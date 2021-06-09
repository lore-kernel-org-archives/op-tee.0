From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 6/7] firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()
Date: Wed, 09 Jun 2021 09:58:11 -0500
Message-ID: <20210609145811.GJ4910@sequoia>
In-Reply-To: <20210609102324.2222332-7-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2225536551340918181=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2225536551340918181==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-06-09 12:23:23, Jens Wiklander wrote:
> Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> the old deprecated tee_shm_alloc() function which required specific
> TEE_SHM-flags.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Since this series is essentially a rewrite of the shm allocation logic,
it is worth pointing out that the rewrite still uses contiguous
allocations (from alloc_pages()). The tee_bnxt_fw driver is performing
an order-10 allocation which is the max, by default. I've only tested
tee_bnxt_fw when it was built-in to the kernel and tee_bnxt_fw_probe()
was called early in boot but I suspect that it might not succeed when
built as a module and loaded later after memory is segmented. I think
this driver would benefit from being able to request a non-contiguous
allocation.

Is this rewrite a good time to offer drivers a way to perform a
non-contiguous allocation?

Tyler

> ---
>  drivers/firmware/broadcom/tee_bnxt_fw.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/bro=
adcom/tee_bnxt_fw.c
> index ed10da5313e8..56d00ddd4357 100644
> --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> @@ -212,10 +212,9 @@ static int tee_bnxt_fw_probe(struct device *dev)
> =20
>  	pvt_data.dev =3D dev;
> =20
> -	fw_shm_pool =3D tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
> -				    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +	fw_shm_pool =3D tee_shm_alloc_kernel_buf(pvt_data.ctx, MAX_SHM_MEM_SZ);
>  	if (IS_ERR(fw_shm_pool)) {
> -		dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
> +		dev_err(pvt_data.dev, "tee_shm_alloc_kernel_buf failed\n");
>  		err =3D PTR_ERR(fw_shm_pool);
>  		goto out_sess;
>  	}
> --=20
> 2.31.1
>=20

--===============2225536551340918181==--

