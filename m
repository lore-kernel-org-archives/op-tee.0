From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 02/10] optee: pass parent device to tee_device_alloc()
Date: Mon, 10 Mar 2025 14:27:24 +0530
Message-ID: <Z86pdKQY440edHNx@sumit-X1>
In-Reply-To: <20250305130634.1850178-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6117989205686787652=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6117989205686787652==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Mar 05, 2025 at 02:04:08PM +0100, Jens Wiklander wrote:
> During probing of the OP-TEE driver, pass the parent device to
> tee_device_alloc() so the dma_mask of the new devices can be updated
> accordingly.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/ffa_abi.c | 8 ++++----
>  drivers/tee/optee/smc_abi.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Sumit Garg <sumit.garg@kernel.org>

-Sumit

> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index f3af5666bb11..4ca1d5161b82 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -914,16 +914,16 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	    (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
>  		optee->in_kernel_rpmb_routing = true;
>  
> -	teedev = tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
> -				  optee);
> +	teedev = tee_device_alloc(&optee_ffa_clnt_desc, &ffa_dev->dev,
> +				  optee->pool, optee);
>  	if (IS_ERR(teedev)) {
>  		rc = PTR_ERR(teedev);
>  		goto err_free_pool;
>  	}
>  	optee->teedev = teedev;
>  
> -	teedev = tee_device_alloc(&optee_ffa_supp_desc, NULL, optee->pool,
> -				  optee);
> +	teedev = tee_device_alloc(&optee_ffa_supp_desc, &ffa_dev->dev,
> +				  optee->pool, optee);
>  	if (IS_ERR(teedev)) {
>  		rc = PTR_ERR(teedev);
>  		goto err_unreg_teedev;
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index f0c3ac1103bb..165fadd9abc9 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1691,14 +1691,14 @@ static int optee_probe(struct platform_device *pdev)
>  	    (sec_caps & OPTEE_SMC_SEC_CAP_RPMB_PROBE))
>  		optee->in_kernel_rpmb_routing = true;
>  
> -	teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
> +	teedev = tee_device_alloc(&optee_clnt_desc, &pdev->dev, pool, optee);
>  	if (IS_ERR(teedev)) {
>  		rc = PTR_ERR(teedev);
>  		goto err_free_optee;
>  	}
>  	optee->teedev = teedev;
>  
> -	teedev = tee_device_alloc(&optee_supp_desc, NULL, pool, optee);
> +	teedev = tee_device_alloc(&optee_supp_desc, &pdev->dev, pool, optee);
>  	if (IS_ERR(teedev)) {
>  		rc = PTR_ERR(teedev);
>  		goto err_unreg_teedev;
> -- 
> 2.43.0
> 

--===============6117989205686787652==--

