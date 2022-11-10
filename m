From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
Date: Thu, 10 Nov 2022 16:23:56 +0530
Message-ID: 
 <CAFA6WYPxTET4mUQ4YHosbPN1o0UthP6PU=t8bAp91GZL+5rjRA@mail.gmail.com>
In-Reply-To: <20221109160708.507481-1-ludvig.parsson@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4900835104308846889=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4900835104308846889==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Nov 2022 at 21:37, Ludvig P=C3=A4rsson <ludvig.parsson@axis.com> =
wrote:
>
> Currently there is no dependency between the "linaro,scmi-optee" driver
> and the tee_core. If the scmi-optee driver gets probed before the
> tee_bus_type is initialized, then we will get an unwanted error print.
>

What error print do you observe? I suppose this case is already
handled by scmi optee driver via -EPROBE_DEFER.

-Sumit

> This patch enables putting scmi-optee nodes as children to the optee
> node in devicetree, which indirectly creates the missing dependency.
>
> Signed-off-by: Ludvig P=C3=A4rsson <ludvig.parsson@axis.com>
> ---
>  drivers/tee/optee/smc_abi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..be6f02fd5a7f 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1533,6 +1533,11 @@ static int optee_probe(struct platform_device *pdev)
>         if (rc)
>                 goto err_disable_shm_cache;
>
> +       /* Populate any dependent child node (if any) */
> +       rc =3D devm_of_platform_populate(&pdev->dev);
> +       if (rc)
> +               goto err_disable_shm_cache;
> +
>         pr_info("initialized driver\n");
>         return 0;
>
> --
> 2.30.2
>

--===============4900835104308846889==--

