From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
Date: Fri, 11 Nov 2022 16:13:36 +0000
Message-ID: <20221111161336.msozo7l632jvbwcn@bogus>
In-Reply-To: <20221109160708.507481-1-ludvig.parsson@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0313909105549810564=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0313909105549810564==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, Nov 09, 2022 at 05:07:08PM +0100, Ludvig Pärsson wrote:
> Currently there is no dependency between the "linaro,scmi-optee" driver
> and the tee_core. If the scmi-optee driver gets probed before the
> tee_bus_type is initialized, then we will get an unwanted error print.
> 
> This patch enables putting scmi-optee nodes as children to the optee
> node in devicetree, which indirectly creates the missing dependency.
> 
> Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
> ---
>  drivers/tee/optee/smc_abi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..be6f02fd5a7f 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1533,6 +1533,11 @@ static int optee_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto err_disable_shm_cache;
>  
> +	/* Populate any dependent child node (if any) */
> +	rc = devm_of_platform_populate(&pdev->dev);
> +	if (rc)
> +		goto err_disable_shm_cache;
> +

While I agree with idea of populating dependent child nodes from here,
I am not sure if it is OK to give error if that fails or to just continue
as there may be other users(like the user-space) for the OPTEE in general.

-- 
Regards,
Sudeep

--===============0313909105549810564==--

