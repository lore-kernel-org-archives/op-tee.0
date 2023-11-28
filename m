From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] tee: Use iov_iter to better support shared buffer registration
Date: Tue, 28 Nov 2023 08:44:43 +0100
Message-ID: 
 <CAHUa44G+CeWQVO3K4gJMhUNDp30RcPzo8u1crO3yyLZhLmzzFQ@mail.gmail.com>
In-Reply-To: <20231127171207.285554-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7467230479257462184=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7467230479257462184==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 6:12=E2=80=AFPM Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> It is not possible to register buffers allocated with vmalloc.
> Use iov_iter and associated helper functions to manage the page
> registration for all type of memories.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>
> update from V1 to V2:
> - replace ITER_SOURCE by ITER_DEST flag in tee_shm_register_user_buf(),
> - replace IS_ERR_OR NULL(shm) by IS_ERR(shm) in tee_shm_register_user_buf().
>
> V1:
> The support of buffer registration allocated with vmalloc is no more
> available since c83900393aa1 ("tee: Remove vmalloc page support").
>
> This patch is an alternative to a revert and resulted from a discussion
> with Christopher Hellwig [1].
>
> This patch has been tested using xtest tool in optee qemu environment [2]
> and using the series related to the remoteproc tee that should be
> proposed soon [3].
>
> References:
> [1] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47d=
d39fb2(a)foss.st.com/T/#m8ec683c44fcd9b69c2aee42eaed0793afac9dd18in
> [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#build=
-instructions
> [3] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47d=
d39fb2(a)foss.st.com/T/#maca0a1fc897aadd54c7deac432e11473fe970d1d
> ---
>  drivers/tee/tee_shm.c | 72 +++++++++++++++++++++++--------------------
>  1 file changed, 38 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 673cf0359494..4a24b9942938 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -22,23 +22,13 @@ static void shm_put_kernel_pages(struct page **pages, s=
ize_t page_count)
>                 put_page(pages[n]);
>  }
>
> -static int shm_get_kernel_pages(unsigned long start, size_t page_count,
> -                               struct page **pages)
> +static void shm_get_kernel_pages(struct page **pages, size_t page_count)
>  {
> -       struct page *page;
>         size_t n;
>
> -       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
> -                        is_kmap_addr((void *)start)))
> -               return -EINVAL;
> -
> -       page =3D virt_to_page((void *)start);
> -       for (n =3D 0; n < page_count; n++) {
> -               pages[n] =3D page + n;
> +       /* iov_iter_extract_kvec_pages does not get reference on the pages,=
 get a pin on them. */
This line is longer than 80 columns, please break it.

> +       for (n =3D 0; n < page_count; n++)
>                 get_page(pages[n]);
> -       }
> -
> -       return page_count;
>  }
>
>  static void release_registered_pages(struct tee_shm *shm)
> @@ -214,13 +204,12 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_con=
text *ctx, size_t size)
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>
>  static struct tee_shm *
> -register_shm_helper(struct tee_context *ctx, unsigned long addr,
> -                   size_t length, u32 flags, int id)
> +register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 fl=
ags, int id)
This line is longer than 80 columns, please break it.

Thanks,
Jens

>  {
>         struct tee_device *teedev =3D ctx->teedev;
>         struct tee_shm *shm;
> -       unsigned long start;
> -       size_t num_pages;
> +       unsigned long start, addr;
> +       size_t num_pages, length, len, off;
>         void *ret;
>         int rc;
>
> @@ -245,31 +234,31 @@ register_shm_helper(struct tee_context *ctx, unsigned=
 long addr,
>         shm->flags =3D flags;
>         shm->ctx =3D ctx;
>         shm->id =3D id;
> -       addr =3D untagged_addr(addr);
> +       addr =3D (unsigned long)iter_iov_addr(iter);
> +       length =3D iter_iov_len(iter);
>         start =3D rounddown(addr, PAGE_SIZE);
> -       shm->offset =3D addr - start;
> -       shm->size =3D length;
> -       num_pages =3D (roundup(addr + length, PAGE_SIZE) - start) / PAGE_SI=
ZE;
> +       num_pages =3D iov_iter_npages(iter, INT_MAX);
> +       if (!num_pages) {
> +               ret =3D ERR_PTR(-ENOMEM);
> +               goto err_ctx_put;
> +       }
> +
>         shm->pages =3D kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
>         if (!shm->pages) {
>                 ret =3D ERR_PTR(-ENOMEM);
>                 goto err_free_shm;
>         }
>
> -       if (flags & TEE_SHM_USER_MAPPED)
> -               rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE,
> -                                        shm->pages);
> -       else
> -               rc =3D shm_get_kernel_pages(start, num_pages, shm->pages);
> -       if (rc > 0)
> -               shm->num_pages =3D rc;
> -       if (rc !=3D num_pages) {
> -               if (rc >=3D 0)
> -                       rc =3D -ENOMEM;
> -               ret =3D ERR_PTR(rc);
> +       len =3D iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pag=
es, 0, &off);
> +       if (len !=3D length) {
> +               ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>                 goto err_put_shm_pages;
>         }
>
> +       shm->offset =3D off;
> +       shm->size =3D len;
> +       shm->num_pages =3D num_pages;
> +
>         rc =3D teedev->desc->ops->shm_register(ctx, shm, shm->pages,
>                                              shm->num_pages, start);
>         if (rc) {
> @@ -307,6 +296,8 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_co=
ntext *ctx,
>         u32 flags =3D TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
>         struct tee_device *teedev =3D ctx->teedev;
>         struct tee_shm *shm;
> +       struct iovec iov;
> +       struct iov_iter iter;
>         void *ret;
>         int id;
>
> @@ -319,7 +310,10 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_c=
ontext *ctx,
>         if (id < 0)
>                 return ERR_PTR(id);
>
> -       shm =3D register_shm_helper(ctx, addr, length, flags, id);
> +       iov.iov_base =3D (void __user *)addr;
> +       iov.iov_len =3D length;
> +       iov_iter_init(&iter, ITER_DEST, &iov, 1, length);
> +       shm =3D register_shm_helper(ctx, &iter, flags, id);
>         if (IS_ERR(shm)) {
>                 mutex_lock(&teedev->mutex);
>                 idr_remove(&teedev->idr, id);
> @@ -351,9 +345,19 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_c=
ontext *ctx,
>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>                                             void *addr, size_t length)
>  {
> +       struct tee_shm *shm;
>         u32 flags =3D TEE_SHM_DYNAMIC;
> +       struct kvec kvec;
> +       struct iov_iter iter;
>
> -       return register_shm_helper(ctx, (unsigned long)addr, length, flags,=
 -1);
> +       kvec.iov_base =3D addr;
> +       kvec.iov_len =3D length;
> +       iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, length);
> +       shm =3D register_shm_helper(ctx, &iter, flags, -1);
> +       if (!IS_ERR(shm))
> +               shm_get_kernel_pages(shm->pages, shm->num_pages);
> +
> +       return shm;
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
>
> --
> 2.25.1
>

--===============7467230479257462184==--

