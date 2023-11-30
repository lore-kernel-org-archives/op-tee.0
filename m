From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
Date: Thu, 30 Nov 2023 13:18:32 +0000
Message-ID: <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com>
In-Reply-To: <
 <CAFA6WYN9eJ1vGTKfGXy7M709=aGkg1oF3odK7iGRUBokbKtqzw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6851700828969293244=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6851700828969293244==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 11/30/23 13:00, Sumit Garg wrote:
> On Thu, 30 Nov 2023 at 14:38, Arnaud POULIQUEN
> <arnaud.pouliquen@foss.st.com> wrote:
>>
>>
>>
>> On 11/30/23 08:54, Sumit Garg wrote:
>>> On Wed, 29 Nov 2023 at 22:15, Arnaud Pouliquen
>>> <arnaud.pouliquen@foss.st.com> wrote:
>>>>
>>>> Currently it's not possible to register kernel buffers with TEE
>>>> which are allocated via vmalloc.
>>>>
>>>> Use iov_iter and associated helper functions to manage the page
>>>> registration for all type of memories.
>>>>
>>>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>> ---
>>>> Update from V3 to V4:
>>>> - improve commit message,
>>>> - use import_ubuf() instead of iov_iter_init(),
>>>> - move shm_get_kernel_pages in register_shm_helper,
>>>> - put back untagged_addr in register_shm_helper(),
>>>> - move the comment related to pin pages from shm_get_kernel_pages()
>>>>   to register_shm_helper().
>>>>
>>>> Update from V2 to V3:
>>>> - break lines longer than 80 columns.
>>>>
>>>> Update from V1 to V2:
>>>> - replace ITER_SOURCE by ITER_DEST flag in tee_shm_register_user_buf(),
>>>> - replace IS_ERR_OR NULL(shm) by IS_ERR(shm) in tee_shm_register_user_bu=
f().
>>>>
>>>> V1:
>>>> The support of buffer registration allocated with vmalloc is no more
>>>> available since c83900393aa1 ("tee: Remove vmalloc page support").
>>>>
>>>> This patch is an alternative to a revert and resulted from a discussion
>>>> with Christopher Hellwig [1].
>>>>
>>>> This patch has been tested using xtest tool in optee qemu environment [2]
>>>> and using the series related to the remoteproc tee that should be
>>>> proposed soon [3].
>>>>
>>>> References:
>>>> [1] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee=
47dd39fb2(a)foss.st.com/T/#m8ec683c44fcd9b69c2aee42eaed0793afac9dd18in
>>>> [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#bu=
ild-instructions
>>>> [3] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee=
47dd39fb2(a)foss.st.com/T/#maca0a1fc897aadd54c7deac432e11473fe970d1d
>>>> ---
>>>>  drivers/tee/tee_shm.c | 83 ++++++++++++++++++++++++-------------------
>>>>  1 file changed, 46 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>>>> index 673cf0359494..ac73e8143233 100644
>>>> --- a/drivers/tee/tee_shm.c
>>>> +++ b/drivers/tee/tee_shm.c
>>>> @@ -22,23 +22,12 @@ static void shm_put_kernel_pages(struct page **pages=
, size_t page_count)
>>>>                 put_page(pages[n]);
>>>>  }
>>>>
>>>> -static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>>>> -                               struct page **pages)
>>>> +static void shm_get_kernel_pages(struct page **pages, size_t page_count)
>>>>  {
>>>> -       struct page *page;
>>>>         size_t n;
>>>>
>>>> -       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
>>>> -                        is_kmap_addr((void *)start)))
>>>> -               return -EINVAL;
>>>> -
>>>> -       page =3D virt_to_page((void *)start);
>>>> -       for (n =3D 0; n < page_count; n++) {
>>>> -               pages[n] =3D page + n;
>>>> +       for (n =3D 0; n < page_count; n++)
>>>>                 get_page(pages[n]);
>>>> -       }
>>>> -
>>>> -       return page_count;
>>>>  }
>>>>
>>>>  static void release_registered_pages(struct tee_shm *shm)
>>>> @@ -214,13 +203,14 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_=
context *ctx, size_t size)
>>>>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>>>>
>>>>  static struct tee_shm *
>>>> -register_shm_helper(struct tee_context *ctx, unsigned long addr,
>>>> -                   size_t length, u32 flags, int id)
>>>> +register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32=
 flags,
>>>> +                   int id)
>>>>  {
>>>>         struct tee_device *teedev =3D ctx->teedev;
>>>>         struct tee_shm *shm;
>>>> -       unsigned long start;
>>>> -       size_t num_pages;
>>>> +       unsigned long start, addr;
>>>> +       size_t num_pages, off;
>>>> +       ssize_t len;
>>>>         void *ret;
>>>>         int rc;
>>>>
>>>> @@ -245,31 +235,38 @@ register_shm_helper(struct tee_context *ctx, unsig=
ned long addr,
>>>>         shm->flags =3D flags;
>>>>         shm->ctx =3D ctx;
>>>>         shm->id =3D id;
>>>> -       addr =3D untagged_addr(addr);
>>>> +       addr =3D untagged_addr((unsigned long)iter_iov_addr(iter));
>>>>         start =3D rounddown(addr, PAGE_SIZE);
>>>> -       shm->offset =3D addr - start;
>>>> -       shm->size =3D length;
>>>> -       num_pages =3D (roundup(addr + length, PAGE_SIZE) - start) / PAGE=
_SIZE;
>>>> +       num_pages =3D iov_iter_npages(iter, INT_MAX);
>>>> +       if (!num_pages) {
>>>> +               ret =3D ERR_PTR(-ENOMEM);
>>>> +               goto err_ctx_put;
>>>> +       }
>>>> +
>>>>         shm->pages =3D kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNE=
L);
>>>>         if (!shm->pages) {
>>>>                 ret =3D ERR_PTR(-ENOMEM);
>>>>                 goto err_free_shm;
>>>>         }
>>>>
>>>> -       if (flags & TEE_SHM_USER_MAPPED)
>>>> -               rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE,
>>>> -                                        shm->pages);
>>>> -       else
>>>> -               rc =3D shm_get_kernel_pages(start, num_pages, shm->pages=
);
>>>> -       if (rc > 0)
>>>> -               shm->num_pages =3D rc;
>>>> -       if (rc !=3D num_pages) {
>>>> -               if (rc >=3D 0)
>>>> -                       rc =3D -ENOMEM;
>>>> -               ret =3D ERR_PTR(rc);
>>>> -               goto err_put_shm_pages;
>>>> +       len =3D iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_=
pages, 0,
>>>> +                                    &off);
>>>> +       if (unlikely(len <=3D 0)) {
>>>> +               ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>>>> +               goto err_free_shm_pages;
>>>>         }
>>>>
>>>> +       /*
>>>> +        * iov_iter_extract_kvec_pages does not get reference on the pag=
es,
>>>> +        * get a pin on them.
>>>
>>> I think you meant: "get a reference on them". But I don't see the
>>> value of this comment since iov_iter_extract_kvec_pages() already has
>>> been commented properly as follows:
>>>
>>> /*
>>>  * Extract a list of virtually contiguous pages from an ITER_KVEC iterato=
r.
>>>  * This does not get references on the pages, nor does it get a pin on th=
em.
>>>  */
>>>
>>
>> I spent some time debugging this part. Since we use the same API for both =
user
>> and kernel buffers, we wouldn't expect to have any specific actions to tak=
e.
>> Therefore, I thought it would be helpful to add a comment explaining the r=
eason
>> for this specific code, rather than go deeper into iov_iter to understand =
it.
>>
>=20
> Fair enough, let's keep it with s/pin/reference/.
>=20
>> But if you don't see the value, I can remove the comment.
>>
>>>> +        */
>>>> +       if (iov_iter_is_kvec(iter))
>>>> +               shm_get_kernel_pages(shm->pages, num_pages);
>>>> +
>>>> +       shm->offset =3D off;
>>>> +       shm->size =3D len;
>>>> +       shm->num_pages =3D num_pages;
>>>> +
>>>>         rc =3D teedev->desc->ops->shm_register(ctx, shm, shm->pages,
>>>>                                              shm->num_pages, start);
>>>>         if (rc) {
>>>> @@ -279,10 +276,11 @@ register_shm_helper(struct tee_context *ctx, unsig=
ned long addr,
>>>>
>>>>         return shm;
>>>>  err_put_shm_pages:
>>>> -       if (flags & TEE_SHM_USER_MAPPED)
>>>> +       if (!iov_iter_is_kvec(iter))
>>>>                 unpin_user_pages(shm->pages, shm->num_pages);
>>>>         else
>>>>                 shm_put_kernel_pages(shm->pages, shm->num_pages);
>>>> +err_free_shm_pages:
>>>>         kfree(shm->pages);
>>>>  err_free_shm:
>>>>         kfree(shm);
>>>> @@ -307,8 +305,9 @@ struct tee_shm *tee_shm_register_user_buf(struct tee=
_context *ctx,
>>>>         u32 flags =3D TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
>>>>         struct tee_device *teedev =3D ctx->teedev;
>>>>         struct tee_shm *shm;
>>>> +       struct iov_iter iter;
>>>>         void *ret;
>>>> -       int id;
>>>> +       int id, err;
>>>>
>>>>         if (!access_ok((void __user *)addr, length))
>>>>                 return ERR_PTR(-EFAULT);
>>>> @@ -319,7 +318,11 @@ struct tee_shm *tee_shm_register_user_buf(struct te=
e_context *ctx,
>>>>         if (id < 0)
>>>>                 return ERR_PTR(id);
>>>>
>>>> -       shm =3D register_shm_helper(ctx, addr, length, flags, id);
>>>> +       err =3D import_ubuf(ITER_DEST, (void __user *)addr, length, &ite=
r);
>>>
>>> As I mentioned in a previous review, import_ubuf() already does the
>>> access_ok() check, so we don't need the extra access_ok() check above.
>>> Also, you should move import_ubuf() to be the first invocation within
>>> this API.
>>
>> My apologies, I re-added import_ubuf() during testing to debug an issue and
>=20
> I suppose you intended to mention access_ok() here, BTW, no worries :).

Re-running xtest after removing the access_ok() I have a crash in
regression_5006.3 Allocate_out_of_memory

[   89.258100] ------------[ cut here ]------------
[   89.258377] WARNING: CPU: 1 PID: 134 at mm/page_alloc.c:4402
__alloc_pages+0x674/0xd14
[   89.258988] Modules linked in:
[   89.259554] CPU: 1 PID: 134 Comm: xtest Not tainted 6.6.0-g1ebcc18a80d7-di=
rty #69
[   89.259763] Hardware name: linux,dummy-virt (DT)
[   89.259977] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D=
--)
[   89.260143] pc : __alloc_pages+0x674/0xd14
[   89.260252] lr : alloc_pages+0xac/0x160
[   89.260364] sp : ffff8000803f3a30
[   89.260437] x29: ffff8000803f3a30 x28: ffff8000803f3d70 x27: 0000000000000=
000
[   89.260705] x26: 000000000000000b x25: 0000000000000000 x24: ffff000000178=
000
[   89.260847] x23: ffff00003f52b720 x22: ffff000001442720 x21: 0000000000000=
000
[   89.261022] x20: 000000000000000b x19: 0000000000000000 x18: ffff8000803f3=
b78
[   89.261162] x17: 0000000000000000 x16: ffffa7a428b67660 x15: 0000ffff63fff=
fff
[   89.261348] x14: 0000000000000008 x13: 1fffe00000a4c421 x12: ffff8000803f3=
b78
[   89.261528] x11: ffff000005262100 x10: ffff000005262108 x9 : ffff000005262=
10c
[   89.261739] x8 : 0000aaab0a97c000 x7 : 0000aaab0a90e000 x6 : ffff000005262=
150
[   89.261920] x5 : 0000000000000000 x4 : ffff000000976740 x3 : 0000000000000=
000
[   89.262098] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffa7a429daf=
000
[   89.262340] Call trace:
[   89.262921]  __alloc_pages+0x674/0xd14
[   89.263262]  alloc_pages+0xac/0x160
[   89.263373]  alloc_pages_exact+0x48/0x94
[   89.263464]  optee_shm_register+0xa8/0x1f4
[   89.263591]  register_shm_helper+0x1bc/0x28c
[   89.263687]  tee_shm_register_user_buf+0xb8/0x128
[   89.263816]  tee_ioctl+0xbc/0xfa0
[   89.263915]  __arm64_sys_ioctl+0xa8/0xec
[   89.264053]  invoke_syscall+0x48/0x114
[   89.264173]  el0_svc_common.constprop.0+0x40/0xe8
[   89.264321]  do_el0_svc+0x20/0x2c
[   89.264488]  el0_svc+0x40/0xf4
[   89.264578]  el0t_64_sync_handler+0x13c/0x158
[   89.264714]  el0t_64_sync+0x190/0x194
[   89.265003] ---[ end trace 0000000000000000 ]---


The issue is that, in import_ubuf(), it updates the length [1], making the

access_ok() succeed and leading to an issue later in the page allocation proc=
ess.

To fix, I propose to add a test in tee_shm_register_user_buf() after calling

import_ubuf()

	if (length !=3D iter_iov_len(&iter))
		return ERR_PTR(-EFAULT);


Would it be ok for you ? I'm afraid of side effects if I update import_ubuf()=
...

[1] https://elixir.bootlin.com/linux/latest/source/lib/iov_iter.c#L1553

Regards,
Arnaud


>=20
> -Sumit
>=20
>> forgot to
>> remove it afterwards.
>>
>> Thanks and regards,
>> Arnaud
>>
>>>
>>> -Sumit
>>>
>>>> +       if (err)
>>>> +               return ERR_PTR(err);
>>>> +
>>>> +       shm =3D register_shm_helper(ctx, &iter, flags, id);
>>>>         if (IS_ERR(shm)) {
>>>>                 mutex_lock(&teedev->mutex);
>>>>                 idr_remove(&teedev->idr, id);
>>>> @@ -352,8 +355,14 @@ struct tee_shm *tee_shm_register_kernel_buf(struct =
tee_context *ctx,
>>>>                                             void *addr, size_t length)
>>>>  {
>>>>         u32 flags =3D TEE_SHM_DYNAMIC;
>>>> +       struct kvec kvec;
>>>> +       struct iov_iter iter;
>>>> +
>>>> +       kvec.iov_base =3D addr;
>>>> +       kvec.iov_len =3D length;
>>>> +       iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, length);
>>>>
>>>> -       return register_shm_helper(ctx, (unsigned long)addr, length, fla=
gs, -1);
>>>> +       return register_shm_helper(ctx, &iter, flags, -1);
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
>>>>
>>>> --
>>>> 2.25.1
>>>>

--===============6851700828969293244==--

