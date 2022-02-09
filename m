From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 01/10] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
Date: Wed, 09 Feb 2022 15:12:05 +0100
Message-ID: 
 <CAHUa44F8JVw1vab_BBPx7iXMevYRAtMtpYQpa+PDQosV9_y7zA@mail.gmail.com>
In-Reply-To: <20220204093359.359059-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0669737365934151067=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0669737365934151067==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Fri, Feb 4, 2022 at 10:34 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> the old deprecated tee_shm_alloc() function which required specific
> TEE_SHM-flags.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/char/hw_random/optee-rng.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Since this patch depends on other patches in this patch set and vice
versa is it OK if I take this patch via my tree? I'm aiming for v5.18
with this.

Thanks,
Jens

>
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

--===============0669737365934151067==--

