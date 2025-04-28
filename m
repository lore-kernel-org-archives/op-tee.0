From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/2] tee: Use pr_fmt for messages
Date: Mon, 28 Apr 2025 13:15:25 +0530
Message-ID: <aA8yFRKBjEV2mgBL@sumit-X1>
In-Reply-To: <20250421152238.764659-2-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6459891363290251112=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6459891363290251112==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Apr 21, 2025 at 10:22:22AM -0500, Mario Limonciello via OP-TEE wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> amd-tee inconsistently uses the word amd-tee in error messages.
> 
> Add a `pr_fmt()` define and remove the hardcoded use of amd-tee.
> Also, remove the unnecessary driver init successful message because
> there will be a message if failed and a user can assume it was successful
> otherwise.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/tee/amdtee/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index e487231d25dc0..a44625d076401 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -3,6 +3,8 @@
>   * Copyright 2019 Advanced Micro Devices, Inc.
>   */
>  
> + #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/errno.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -458,7 +460,7 @@ static int __init amdtee_driver_init(void)
>  
>  	rc = psp_check_tee_status();
>  	if (rc) {
> -		pr_err("amd-tee driver: tee not present\n");
> +		pr_err("tee not present\n");
>  		return rc;
>  	}
>  
> @@ -494,7 +496,6 @@ static int __init amdtee_driver_init(void)
>  
>  	drv_data->amdtee = amdtee;
>  
> -	pr_info("amd-tee driver initialization successful\n");
>  	return 0;
>  
>  err_device_unregister:
> @@ -510,7 +511,7 @@ static int __init amdtee_driver_init(void)
>  	kfree(drv_data);
>  	drv_data = NULL;
>  
> -	pr_err("amd-tee driver initialization failed\n");
> +	pr_err("initialization failed\n");
>  	return rc;
>  }
>  module_init(amdtee_driver_init);
> -- 
> 2.43.0
> 

--===============6459891363290251112==--

