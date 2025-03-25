From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v6 10/10] optee: smc abi: dynamic restricted memory allocation
Date: Tue, 25 Mar 2025 13:15:35 +0530
Message-ID: <Z-JfH7VAm0DTTbVg@sumit-X1>
In-Reply-To: <20250305130634.1850178-11-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0927467442681304553=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0927467442681304553==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 02:04:16PM +0100, Jens Wiklander wrote:
> Add support in the OP-TEE backend driver for dynamic restricted memory
> allocation using the SMC ABI.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/smc_abi.c | 96 +++++++++++++++++++++++++++++++------
>  1 file changed, 81 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a14ff0b7d3b3..aa574ee6e277 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1001,6 +1001,69 @@ static int optee_smc_do_call_with_arg(struct tee_con=
text *ctx,
>  	return rc;
>  }
> =20
> +static int optee_smc_lend_rstmem(struct optee *optee, struct tee_shm *rstm=
em,
> +				 u16 *end_points, unsigned int ep_count,
> +				 u32 use_case)
> +{
> +	struct optee_shm_arg_entry *entry;
> +	struct optee_msg_arg *msg_arg;
> +	struct tee_shm *shm;
> +	u_int offs;
> +	int rc;
> +
> +	msg_arg =3D optee_get_msg_arg(optee->ctx, 2, &entry, &shm, &offs);
> +	if (IS_ERR(msg_arg))
> +		return PTR_ERR(msg_arg);
> +
> +	msg_arg->cmd =3D OPTEE_MSG_CMD_LEND_RSTMEM;
> +	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
> +	msg_arg->params[0].u.value.a =3D use_case;
> +	msg_arg->params[1].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
> +	msg_arg->params[1].u.tmem.buf_ptr =3D rstmem->paddr;
> +	msg_arg->params[1].u.tmem.size =3D rstmem->size;
> +	msg_arg->params[1].u.tmem.shm_ref =3D (u_long)rstmem;
> +
> +	rc =3D optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
> +	if (rc)
> +		goto out;
> +	if (msg_arg->ret !=3D TEEC_SUCCESS) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}
> +	rstmem->sec_world_id =3D (u_long)rstmem;
> +
> +out:
> +	optee_free_msg_arg(optee->ctx, entry, offs);
> +	return rc;
> +}
> +
> +static int optee_smc_reclaim_rstmem(struct optee *optee, struct tee_shm *r=
stmem)
> +{
> +	struct optee_shm_arg_entry *entry;
> +	struct optee_msg_arg *msg_arg;
> +	struct tee_shm *shm;
> +	u_int offs;
> +	int rc;
> +
> +	msg_arg =3D optee_get_msg_arg(optee->ctx, 1, &entry, &shm, &offs);
> +	if (IS_ERR(msg_arg))
> +		return PTR_ERR(msg_arg);
> +
> +	msg_arg->cmd =3D OPTEE_MSG_CMD_RECLAIM_RSTMEM;
> +	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> +	msg_arg->params[0].u.rmem.shm_ref =3D (u_long)rstmem;
> +
> +	rc =3D optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
> +	if (rc)
> +		goto out;
> +	if (msg_arg->ret !=3D TEEC_SUCCESS)
> +		rc =3D -EINVAL;
> +
> +out:
> +	optee_free_msg_arg(optee->ctx, entry, offs);
> +	return rc;
> +}
> +
>  /*
>   * 5. Asynchronous notification
>   */
> @@ -1252,6 +1315,8 @@ static const struct optee_ops optee_ops =3D {
>  	.do_call_with_arg =3D optee_smc_do_call_with_arg,
>  	.to_msg_param =3D optee_to_msg_param,
>  	.from_msg_param =3D optee_from_msg_param,
> +	.lend_rstmem =3D optee_smc_lend_rstmem,
> +	.reclaim_rstmem =3D optee_smc_reclaim_rstmem,
>  };
> =20
>  static int enable_async_notif(optee_invoke_fn *invoke_fn)
> @@ -1622,11 +1687,13 @@ static inline int optee_load_fw(struct platform_dev=
ice *pdev,
> =20
>  static int optee_sdp_pool_init(struct optee *optee)
>  {
> +	bool sdp =3D optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP;
> +	bool dyn_sdp =3D optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_RSTMEM;
>  	enum tee_dma_heap_id heap_id =3D TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
> -	struct tee_rstmem_pool *pool;
> -	int rc;
> +	struct tee_rstmem_pool *pool =3D ERR_PTR(-EINVAL);
> +	int rc =3D -EINVAL;
> =20
> -	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP) {
> +	if (sdp) {
>  		union {
>  			struct arm_smccc_res smccc;
>  			struct optee_smc_get_sdp_config_result result;
> @@ -1634,25 +1701,24 @@ static int optee_sdp_pool_init(struct optee *optee)
> =20
>  		optee->smc.invoke_fn(OPTEE_SMC_GET_SDP_CONFIG, 0, 0, 0, 0, 0, 0,
>  				     0, &res.smccc);
> -		if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
> -			pr_err("Secure Data Path service not available\n");
> -			return 0;
> -		}
> +		if (res.result.status =3D=3D OPTEE_SMC_RETURN_OK)
> +			pool =3D tee_rstmem_static_pool_alloc(res.result.start,
> +							    res.result.size);
> +	}
> =20
> -		pool =3D tee_rstmem_static_pool_alloc(res.result.start,
> -						    res.result.size);
> -		if (IS_ERR(pool))
> -			return PTR_ERR(pool);
> +	if (dyn_sdp && IS_ERR(pool))
> +		pool =3D optee_rstmem_alloc_cma_pool(optee, heap_id);
> =20
> +	if (!IS_ERR(pool)) {
>  		rc =3D tee_device_register_dma_heap(optee->teedev, heap_id, pool);
>  		if (rc)
> -			goto err;
> +			pool->ops->destroy_pool(pool);
>  	}
> =20
> +	if (rc && (sdp || dyn_sdp))
> +		pr_err("Secure Data Path service not available\n");

Rather than an error message we should just use pr_info().

-Sumit

> +
>  	return 0;
> -err:
> -	pool->ops->destroy_pool(pool);
> -	return rc;
>  }
> =20
>  static int optee_probe(struct platform_device *pdev)
> --=20
> 2.43.0
>=20

--===============0927467442681304553==--

