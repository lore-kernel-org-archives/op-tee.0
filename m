From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf backing
Date: Wed, 09 Jun 2021 09:59:04 +0530
Message-ID: 
 <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
In-Reply-To: <20210609002326.210024-6-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5511056279800086269=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5511056279800086269==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Tyler,

On Wed, 9 Jun 2021 at 05:55, Tyler Hicks <tyhicks@linux.microsoft.com> wrot=
e:
>
> Uncouple the registration of dynamic shared memory buffers from the
> TEE_SHM_DMA_BUF flag. Drivers may wish to allocate dynamic shared memory
> regions but do not need them to be backed by a dma-buf when the memory
> region is private to the driver.

In this case drivers should use tee_shm_register() instead where the
memory allocated is actually private to the driver. However, you need
to remove TEE_SHM_DMA_BUF as a mandatory flag for tee_shm_register().
Have a look at an example here [1]. So modifying tee_shm_alloc() for
this purpose doesn't look appropriate to me.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/s=
ecurity/keys/trusted-keys/trusted_tee.c#n73

-Sumit

>
> Allow callers of tee_shm_alloc() to specify the TEE_SHM_REGISTER flag to
> request registration. If the TEE implementation does not require dynamic
> shared memory to be registered, clear the flag prior to calling the
> corresponding pool alloc function. Update the OP-TEE driver to respect
> TEE_SHM_REGISTER, rather than TEE_SHM_DMA_BUF, when deciding whether to
> (un)register on alloc/free operations. The AMD-TEE driver continues to
> ignore the TEE_SHM_REGISTER flag.
>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/shm_pool.c |  5 ++---
>  drivers/tee/tee_shm.c        | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
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
>                 unsigned int nr_pages =3D 1 << order, i;
>                 struct page **pages;
>
> @@ -42,7 +42,6 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>                         page++;
>                 }
>
> -               shm->flags |=3D TEE_SHM_REGISTER;
>                 rc =3D optee_shm_register(shm->ctx, shm, pages, nr_pages,
>                                         (unsigned long)shm->kaddr);
>                 kfree(pages);
> @@ -60,7 +59,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
>                          struct tee_shm *shm)
>  {
> -       if (shm->flags & TEE_SHM_DMA_BUF)
> +       if (shm->flags & TEE_SHM_REGISTER)
>                 optee_shm_unregister(shm->ctx, shm);
>
>         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 00472f5ce22e..1c0176550b9c 100644
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
>         shm->flags =3D flags | TEE_SHM_POOL;
>         shm->ctx =3D ctx;
>         if (flags & TEE_SHM_DMA_BUF)
> --
> 2.25.1
>

--===============5511056279800086269==--

