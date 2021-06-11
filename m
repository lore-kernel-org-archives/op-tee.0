From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 6/8] tee: Support kernel shm registration without
 dma-buf backing
Date: Fri, 11 Jun 2021 10:46:20 +0530
Message-ID: 
 <CAFA6WYMcGGkAAWxK2vmM8CNsgTKJpegkZZjJZy4pvXhKe9WGvA@mail.gmail.com>
In-Reply-To: <20210610210913.536081-7-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2471185552358452199=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2471185552358452199==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Jun 2021 at 02:39, Tyler Hicks <tyhicks@linux.microsoft.com> wro=
te:
>
> Uncouple the registration of kernel shared memory buffers from the
> TEE_SHM_DMA_BUF flag. Drivers may wish to allocate multi-page contiguous
> shared memory regions but do not need them to be backed by a dma-buf
> when the memory region is only used by the driver.
>
> If the TEE implementation does not require shared memory to be
> registered, clear the flag prior to calling the corresponding pool alloc
> function. Update the OP-TEE driver to respect TEE_SHM_REGISTER, rather
> than TEE_SHM_DMA_BUF, when deciding whether to (un)register on
> alloc/free operations.

> The AMD-TEE driver continues to ignore the
> TEE_SHM_REGISTER flag.
>

That's the main point that no other TEE implementation would honour
TEE_SHM_REGISTER and I think it's just the incorrect usage of
TEE_SHM_REGISTER flag to suffice OP-TEE underlying implementation.

> Allow callers of tee_shm_alloc_kernel_buf() to allocate and register a
> shared memory region without the backing of dma-buf.
>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/shm_pool.c |  5 ++---
>  drivers/tee/tee_shm.c        | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 5 deletions(-)
>

This patch is just mixing two separate approaches to TEE shared
memory. Have a look at alternative suggestions below.

> diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> index da06ce9b9313..6054343a29fb 100644
> --- a/drivers/tee/optee/shm_pool.c
> +++ b/drivers/tee/optee/shm_pool.c
> @@ -27,7 +27,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>         shm->paddr =3D page_to_phys(page);
>         shm->size =3D PAGE_SIZE << order;
>
> -       if (shm->flags & TEE_SHM_DMA_BUF) {
> +       if (shm->flags & TEE_SHM_REGISTER) {

Here you can just do following check instead:

       if (!(shm->flags & TEE_SHM_PRIV)) {

And this flag needs to be passed from the call sites here [1] [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/tee/optee/core.c#n280
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/tee/optee/call.c#n186

>                 unsigned int nr_pages =3D 1 << order, i;
>                 struct page **pages;
>
> @@ -42,7 +42,6 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>                         page++;
>                 }
>
> -               shm->flags |=3D TEE_SHM_REGISTER;

This should remain as it is.

>                 rc =3D optee_shm_register(shm->ctx, shm, pages, nr_pages,
>                                         (unsigned long)shm->kaddr);
>                 kfree(pages);
> @@ -60,7 +59,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
>                          struct tee_shm *shm)
>  {
> -       if (shm->flags & TEE_SHM_DMA_BUF)
> +       if (shm->flags & TEE_SHM_REGISTER)

Same as above.

>                 optee_shm_unregister(shm->ctx, shm);
>
>         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index c65e44707cd6..26a76f817c57 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -117,7 +117,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, =
size_t size, u32 flags)
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
> +       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER)=
)) {

No need for this change.

>                 dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags=
);
>                 return ERR_PTR(-EINVAL);
>         }
> @@ -137,6 +137,15 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx,=
 size_t size, u32 flags)
>                 goto err_dev_put;
>         }
>
> +       if (!teedev->desc->ops->shm_register ||
> +           !teedev->desc->ops->shm_unregister) {
> +               /* registration is not required by the TEE implementation */
> +               flags &=3D ~TEE_SHM_REGISTER;
> +       } else if (flags & TEE_SHM_DMA_BUF) {
> +               /* all dma-buf backed shm allocations are registered */
> +               flags |=3D TEE_SHM_REGISTER;
> +       }
> +

This change isn't required as well as underlying TEE implementation:
OP-TEE in this case knows how to implement shared memory allocation
whether to use reserved shared memory pool or dynamic shared memory
pool. For more details see shared memory pool creation in
optee_probe().

>         shm->flags =3D flags | TEE_SHM_POOL;
>         shm->ctx =3D ctx;
>         if (flags & TEE_SHM_DMA_BUF)
> @@ -207,7 +216,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
>   */
>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t s=
ize)
>  {
> -       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_REGISTER);

Here it could just be:

       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED);

-Sumit

>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
>
> --
> 2.25.1
>

--===============2471185552358452199==--

