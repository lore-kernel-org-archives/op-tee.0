From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 01/12] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
Date: Tue, 18 Jan 2022 17:42:16 +0530
Message-ID: 
 <CAFA6WYOrzbs-AYoMUGv5s_5k0cq0rqb7MVjr8szkB4mYakyJGg@mail.gmail.com>
In-Reply-To: <20220114150824.3578829-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5859790669207994940=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5859790669207994940==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> the old deprecated tee_shm_alloc() function which required specific
> TEE_SHM-flags.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/char/hw_random/optee-rng.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/op=
tee-rng.c
> index 135a82590923..a948c0727b2b 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -145,10 +145,10 @@ static int optee_rng_init(struct hwrng *rng)
>         struct optee_rng_private *pvt_data =3D to_optee_rng_private(rng);
>         struct tee_shm *entropy_shm_pool =3D NULL;
>
> -       entropy_shm_pool =3D tee_shm_alloc(pvt_data->ctx, MAX_ENTROPY_REQ_S=
Z,
> -                                        TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +       entropy_shm_pool =3D tee_shm_alloc_kernel_buf(pvt_data->ctx,
> +                                                   MAX_ENTROPY_REQ_SZ);
>         if (IS_ERR(entropy_shm_pool)) {
> -               dev_err(pvt_data->dev, "tee_shm_alloc failed\n");
> +               dev_err(pvt_data->dev, "tee_shm_alloc_kernel_buf failed\n");
>                 return PTR_ERR(entropy_shm_pool);
>         }
>
> --
> 2.31.1
>

--===============5859790669207994940==--

