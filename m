From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: enable apci support
Date: Wed, 17 Mar 2021 09:04:42 +0100
Message-ID: <20210317080442.GA3018337@jade>
In-Reply-To: <20210312083653.38780-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5213759086201045231=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5213759086201045231==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, Mar 12, 2021 at 04:36:53PM +0800, Ran Wang wrote:
> This patch add ACPI support for optee driver.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/tee/optee/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index cf4718c6d35d..8fb261f4b9db 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -5,6 +5,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> @@ -735,12 +736,21 @@ static const struct of_device_id optee_dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, optee_dt_match);
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id optee_acpi_match[] = {
> +	{ "OPTEE01",},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
> +#endif
> +
>  static struct platform_driver optee_driver = {
>  	.probe  = optee_probe,
>  	.remove = optee_remove,
>  	.driver = {
>  		.name = "optee",
>  		.of_match_table = optee_dt_match,
> +		.acpi_match_table = ACPI_PTR(optee_acpi_match),
>  	},
>  };
>  module_platform_driver(optee_driver);
> -- 
> 2.25.1
> 

This looks simple enough. Ard, is this what you had in mind earlier?

Thanks,
Jens

--===============5213759086201045231==--

