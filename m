From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: Do not publish partially initialized shm objects
Date: Thu, 09 Dec 2021 17:30:16 +0530
Message-ID: 
 <CAFA6WYNzyr1m_MHcqHP+GPTetLcsNDMsTPsUsah0DUVJREOYbw@mail.gmail.com>
In-Reply-To: <20211207095758.1077636-1-larper@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7645559932848843196=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7645559932848843196==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Dec 2021 at 15:28, Lars Persson <larper@axis.com> wrote:
>
> Adding a partially initialized struct tee_shm to teedev->idr makes
> that object reachable from userspace through TEE_IOC_OPEN_SESSION and
> TEE_IOC_INVOKE.

Can you elaborate here how this partially initialized shared memory is
reachable from user-space? AFAICT, TEE_IOC_OPEN_SESSION and
TEE_IOC_INVOKE relies on shm->id to access underlying shared memory
(via tee_shm_get_from_id()) and that is only known to user-space after
TEE_IOC_SHM_ALLOC or TEE_IOC_SHM_REGISTER return successfully.

-Sumit

> We should delay the registration of the pointer in the
> idr until the object is fully initialized.
>
> Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
> Reported-by: Patrik Lantz <patrik.lantz@axis.com>
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  drivers/tee/tee_shm.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 8a9384a64f3e..93814ff7fde8 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -155,7 +155,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, =
size_t size, u32 flags)
>                 DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>
>                 mutex_lock(&teedev->mutex);
> -               shm->id =3D idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> +               shm->id =3D idr_alloc(&teedev->idr, NULL, 1, 0, GFP_KERNEL);
>                 mutex_unlock(&teedev->mutex);
>                 if (shm->id < 0) {
>                         ret =3D ERR_PTR(shm->id);
> @@ -172,6 +172,12 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx,=
 size_t size, u32 flags)
>                         ret =3D ERR_CAST(shm->dmabuf);
>                         goto err_rem;
>                 }
> +
> +               ret =3D idr_replace(&teedev->idr, shm, shm->id);
> +               if (IS_ERR(ret)) {
> +                       dma_buf_put(shm->dmabuf);
> +                       return ret;
> +               }
>         }
>
>         teedev_ctx_get(ctx);
> @@ -288,7 +294,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ct=
x, unsigned long addr,
>         }
>
>         mutex_lock(&teedev->mutex);
> -       shm->id =3D idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> +       shm->id =3D idr_alloc(&teedev->idr, NULL, 1, 0, GFP_KERNEL);
>         mutex_unlock(&teedev->mutex);
>
>         if (shm->id < 0) {
> @@ -319,6 +325,12 @@ struct tee_shm *tee_shm_register(struct tee_context *c=
tx, unsigned long addr,
>                 }
>         }
>
> +       ret =3D idr_replace(&teedev->idr, shm, shm->id);
> +       if (IS_ERR(ret)) {
> +               tee_shm_free(shm);
> +               return ret;
> +       }
> +
>         return shm;
>  err:
>         if (shm) {
> --
> 2.30.2
>

--===============7645559932848843196==--

