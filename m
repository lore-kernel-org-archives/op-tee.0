From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
Date: Thu, 30 Nov 2023 09:08:36 +0000
Message-ID: <60b67bd5-36c3-4318-9a2b-bcf172681d45@foss.st.com>
In-Reply-To: <
 <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5889293378187725030=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5889293378187725030==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 11/30/23 08:54, Sumit Garg wrote:
> On Wed, 29 Nov 2023 at 22:15, Arnaud Pouliquen
> <arnaud.pouliquen@foss.st.com> wrote:
>>
>> Currently it's not possible to register kernel buffers with TEE
>> which are allocated via vmalloc.
>>
>> Use iov_iter and associated helper functions to manage the page
>> registration for all type of memories.
>>
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> Update from V3 to V4:
>> - improve commit message,
>> - use import_ubuf() instead of iov_iter_init(),
>> - move shm_get_kernel_pages in register_shm_helper,
>> - put back untagged_addr in register_shm_helper(),
>> - move the comment related to pin pages from shm_get_kernel_pages()
>>   to register_shm_helper().
>>
>> Update from V2 to V3:
>> - break lines longer than 80 columns.
>>
>> Update from V1 to V2:
>> - replace ITER_SOURCE by ITER_DEST flag in tee_shm_register_user_buf(),
>> - replace IS_ERR_OR NULL(shm) by IS_ERR(shm) in tee_shm_register_user_buf(=
).
>>
>> V1:
>> The support of buffer registration allocated with vmalloc is no more
>> available since c83900393aa1 ("tee: Remove vmalloc page support").
>>
>> This patch is an alternative to a revert and resulted from a discussion
>> with Christopher Hellwig [1].
>>
>> This patch has been tested using xtest tool in optee qemu environment [2]
>> and using the series related to the remoteproc tee that should be
>> proposed soon [3].
>>
>> References:
>> [1] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47=
dd39fb2(a)foss.st.com/T/#m8ec683c44fcd9b69c2aee42eaed0793afac9dd18in
>> [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#buil=
d-instructions
>> [3] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47=
dd39fb2(a)foss.st.com/T/#maca0a1fc897aadd54c7deac432e11473fe970d1d
>> ---
>>  drivers/tee/tee_shm.c | 83 ++++++++++++++++++++++++-------------------
>>  1 file changed, 46 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index 673cf0359494..ac73e8143233 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -22,23 +22,12 @@ static void shm_put_kernel_pages(struct page **pages, =
size_t page_count)
>>                 put_page(pages[n]);
>>  }
>>
>> -static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>> -                               struct page **pages)
>> +static void shm_get_kernel_pages(struct page **pages, size_t page_count)
>>  {
>> -       struct page *page;
>>         size_t n;
>>
>> -       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
>> -                        is_kmap_addr((void *)start)))
>> -               return -EINVAL;
>> -
>> -       page =3D virt_to_page((void *)start);
>> -       for (n =3D 0; n < page_count; n++) {
>> -               pages[n] =3D page + n;
>> +       for (n =3D 0; n < page_count; n++)
>>                 get_page(pages[n]);
>> -       }
>> -
>> -       return page_count;
>>  }
>>
>>  static void release_registered_pages(struct tee_shm *shm)
>> @@ -214,13 +203,14 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_co=
ntext *ctx, size_t size)
>>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>>
>>  static struct tee_shm *
>> -register_shm_helper(struct tee_context *ctx, unsigned long addr,
>> -                   size_t length, u32 flags, int id)
>> +register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 f=
lags,
>> +                   int id)
>>  {
>>         struct tee_device *teedev =3D ctx->teedev;
>>         struct tee_shm *shm;
>> -       unsigned long start;
>> -       size_t num_pages;
>> +       unsigned long start, addr;
>> +       size_t num_pages, off;
>> +       ssize_t len;
>>         void *ret;
>>         int rc;
>>
>> @@ -245,31 +235,38 @@ register_shm_helper(struct tee_context *ctx, unsigne=
d long addr,
>>         shm->flags =3D flags;
>>         shm->ctx =3D ctx;
>>         shm->id =3D id;
>> -       addr =3D untagged_addr(addr);
>> +       addr =3D untagged_addr((unsigned long)iter_iov_addr(iter));
>>         start =3D rounddown(addr, PAGE_SIZE);
>> -       shm->offset =3D addr - start;
>> -       shm->size =3D length;
>> -       num_pages =3D (roundup(addr + length, PAGE_SIZE) - start) / PAGE_S=
IZE;
>> +       num_pages =3D iov_iter_npages(iter, INT_MAX);
>> +       if (!num_pages) {
>> +               ret =3D ERR_PTR(-ENOMEM);
>> +               goto err_ctx_put;
>> +       }
>> +
>>         shm->pages =3D kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
>>         if (!shm->pages) {
>>                 ret =3D ERR_PTR(-ENOMEM);
>>                 goto err_free_shm;
>>         }
>>
>> -       if (flags & TEE_SHM_USER_MAPPED)
>> -               rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE,
>> -                                        shm->pages);
>> -       else
>> -               rc =3D shm_get_kernel_pages(start, num_pages, shm->pages);
>> -       if (rc > 0)
>> -               shm->num_pages =3D rc;
>> -       if (rc !=3D num_pages) {
>> -               if (rc >=3D 0)
>> -                       rc =3D -ENOMEM;
>> -               ret =3D ERR_PTR(rc);
>> -               goto err_put_shm_pages;
>> +       len =3D iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pa=
ges, 0,
>> +                                    &off);
>> +       if (unlikely(len <=3D 0)) {
>> +               ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>> +               goto err_free_shm_pages;
>>         }
>>
>> +       /*
>> +        * iov_iter_extract_kvec_pages does not get reference on the pages,
>> +        * get a pin on them.
>=20
> I think you meant: "get a reference on them". But I don't see the
> value of this comment since iov_iter_extract_kvec_pages() already has
> been commented properly as follows:
>=20
> /*
>  * Extract a list of virtually contiguous pages from an ITER_KVEC iterator.
>  * This does not get references on the pages, nor does it get a pin on them.
>  */
>=20

I spent some time debugging this part. Since we use the same API for both user
and kernel buffers, we wouldn't expect to have any specific actions to take.
Therefore, I thought it would be helpful to add a comment explaining the reas=
on
for this specific code, rather than go deeper into iov_iter to understand it.

But if you don't see the value, I can remove the comment.

>> +        */
>> +       if (iov_iter_is_kvec(iter))
>> +               shm_get_kernel_pages(shm->pages, num_pages);
>> +
>> +       shm->offset =3D off;
>> +       shm->size =3D len;
>> +       shm->num_pages =3D num_pages;
>> +
>>         rc =3D teedev->desc->ops->shm_register(ctx, shm, shm->pages,
>>                                              shm->num_pages, start);
>>         if (rc) {
>> @@ -279,10 +276,11 @@ register_shm_helper(struct tee_context *ctx, unsigne=
d long addr,
>>
>>         return shm;
>>  err_put_shm_pages:
>> -       if (flags & TEE_SHM_USER_MAPPED)
>> +       if (!iov_iter_is_kvec(iter))
>>                 unpin_user_pages(shm->pages, shm->num_pages);
>>         else
>>                 shm_put_kernel_pages(shm->pages, shm->num_pages);
>> +err_free_shm_pages:
>>         kfree(shm->pages);
>>  err_free_shm:
>>         kfree(shm);
>> @@ -307,8 +305,9 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_c=
ontext *ctx,
>>         u32 flags =3D TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
>>         struct tee_device *teedev =3D ctx->teedev;
>>         struct tee_shm *shm;
>> +       struct iov_iter iter;
>>         void *ret;
>> -       int id;
>> +       int id, err;
>>
>>         if (!access_ok((void __user *)addr, length))
>>                 return ERR_PTR(-EFAULT);
>> @@ -319,7 +318,11 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_=
context *ctx,
>>         if (id < 0)
>>                 return ERR_PTR(id);
>>
>> -       shm =3D register_shm_helper(ctx, addr, length, flags, id);
>> +       err =3D import_ubuf(ITER_DEST, (void __user *)addr, length, &iter);
>=20
> As I mentioned in a previous review, import_ubuf() already does the
> access_ok() check, so we don't need the extra access_ok() check above.
> Also, you should move import_ubuf() to be the first invocation within
> this API.

My apologies, I re-added import_ubuf() during testing to debug an issue and
forgot to
remove it afterwards.

Thanks and regards,
Arnaud

>=20
> -Sumit
>=20
>> +       if (err)
>> +               return ERR_PTR(err);
>> +
>> +       shm =3D register_shm_helper(ctx, &iter, flags, id);
>>         if (IS_ERR(shm)) {
>>                 mutex_lock(&teedev->mutex);
>>                 idr_remove(&teedev->idr, id);
>> @@ -352,8 +355,14 @@ struct tee_shm *tee_shm_register_kernel_buf(struct te=
e_context *ctx,
>>                                             void *addr, size_t length)
>>  {
>>         u32 flags =3D TEE_SHM_DYNAMIC;
>> +       struct kvec kvec;
>> +       struct iov_iter iter;
>> +
>> +       kvec.iov_base =3D addr;
>> +       kvec.iov_len =3D length;
>> +       iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, length);
>>
>> -       return register_shm_helper(ctx, (unsigned long)addr, length, flags=
, -1);
>> +       return register_shm_helper(ctx, &iter, flags, -1);
>>  }
>>  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
>>
>> --
>> 2.25.1
>>

--===============5889293378187725030==--

