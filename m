From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 4/7] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
Date: Wed, 09 Jun 2021 09:51:53 -0500
Message-ID: <20210609145153.GH4910@sequoia>
In-Reply-To: <20210609102324.2222332-5-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6328689079779658619=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6328689079779658619==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-06-09 12:23:21, Jens Wiklander wrote:
> Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> the old deprecated tee_shm_alloc() function which required specific
> TEE_SHM-flags.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  drivers/char/hw_random/optee-rng.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/op=
tee-rng.c
> index 135a82590923..a948c0727b2b 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -145,10 +145,10 @@ static int optee_rng_init(struct hwrng *rng)
>  	struct optee_rng_private *pvt_data =3D to_optee_rng_private(rng);
>  	struct tee_shm *entropy_shm_pool =3D NULL;
> =20
> -	entropy_shm_pool =3D tee_shm_alloc(pvt_data->ctx, MAX_ENTROPY_REQ_SZ,
> -					 TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +	entropy_shm_pool =3D tee_shm_alloc_kernel_buf(pvt_data->ctx,
> +						    MAX_ENTROPY_REQ_SZ);
>  	if (IS_ERR(entropy_shm_pool)) {
> -		dev_err(pvt_data->dev, "tee_shm_alloc failed\n");
> +		dev_err(pvt_data->dev, "tee_shm_alloc_kernel_buf failed\n");
>  		return PTR_ERR(entropy_shm_pool);
>  	}
> =20
> --=20
> 2.31.1
>=20

--===============6328689079779658619==--

