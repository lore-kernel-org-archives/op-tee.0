From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: smc: remove unnecessary NULL check before
 release_firmware()
Date: Thu, 24 Apr 2025 10:23:55 +0530
Message-ID: <aAnD4_WXl8gE2bGv@sumit-X1>
In-Reply-To: <20250410075635.3558712-1-nichen@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7059506036553221247=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7059506036553221247==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Apr 10, 2025 at 03:56:35PM +0800, Chen Ni wrote:
> release_firmware() checks for NULL pointers internally.
> Remove unneeded NULL check for fmw here.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/tee/optee/smc_abi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index f0c3ac1103bb..26f8f7bbbe56 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1551,8 +1551,7 @@ static int optee_load_fw(struct platform_device *pdev,
>  		  data_pa_high, data_pa_low, 0, 0, 0, &res);
>  	if (!rc)
>  		rc = res.a0;
> -	if (fw)
> -		release_firmware(fw);
> +	release_firmware(fw);
>  	kfree(data_buf);
>  
>  	if (!rc) {
> -- 
> 2.25.1
> 

--===============7059506036553221247==--

