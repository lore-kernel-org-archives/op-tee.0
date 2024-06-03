From: Manuel Traut <manut@mecka.net>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Mon, 03 Jun 2024 11:10:05 +0200
Message-ID: <Zl2Ibey9Qck-VLWE@manut.de>
In-Reply-To: <20240527121340.3931987-5-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0968799958261859948=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0968799958261859948==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 14:13 Mon 27 May     , Jens Wiklander wrote:
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/arm_ffa.h>
>  #include <linux/errno.h>
> +#include <linux/rpmb.h>
>  #include <linux/scatterlist.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	optee->ffa.bottom_half_value = U32_MAX;
>  	optee->rpc_param_count = rpc_param_count;
>  
> +	if (IS_REACHABLE(CONFIG_RPMB) &&
> +	    (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> +		optee->in_kernel_rpmb_routing = true;

The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the moment.
If I remove this check here, the series works for me.

Cheers
Manuel

--===============0968799958261859948==--

