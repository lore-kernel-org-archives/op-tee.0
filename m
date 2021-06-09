From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 5/7] tpm_ftpm_tee: use tee_shm_alloc_kernel_buf()
Date: Wed, 09 Jun 2021 09:53:00 -0500
Message-ID: <20210609145300.GI4910@sequoia>
In-Reply-To: <20210609102324.2222332-6-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3755636382474509510=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3755636382474509510==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-06-09 12:23:22, Jens Wiklander wrote:
> Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> the old deprecated tee_shm_alloc() function which required specific
> TEE_SHM-flags.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_te=
e.c
> index 2ccdf8ac6994..6e3235565a4d 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -254,11 +254,11 @@ static int ftpm_tee_probe(struct device *dev)
>  	pvt_data->session =3D sess_arg.session;
> =20
>  	/* Allocate dynamic shared memory with fTPM TA */
> -	pvt_data->shm =3D tee_shm_alloc(pvt_data->ctx,
> -				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
> -				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +	pvt_data->shm =3D tee_shm_alloc_kernel_buf(pvt_data->ctx,
> +						 MAX_COMMAND_SIZE +
> +						 MAX_RESPONSE_SIZE);
>  	if (IS_ERR(pvt_data->shm)) {
> -		dev_err(dev, "%s: tee_shm_alloc failed\n", __func__);
> +		dev_err(dev, "%s: tee_shm_alloc_kernel_buf failed\n", __func__);
>  		rc =3D -ENOMEM;
>  		goto out_shm_alloc;
>  	}
> --=20
> 2.31.1
>=20

--===============3755636382474509510==--

