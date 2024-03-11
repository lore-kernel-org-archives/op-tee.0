From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: smc: Convert to platform remove callback
 returning void
Date: Mon, 11 Mar 2024 17:01:42 +0530
Message-ID: 
 <CAFA6WYMDvFGopHkLfMUL963MAOBwcCSfu8TwnjqcyTRWWZrN8w@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3Cc15ca2d5ed403d66fe6984b35da61d194dc776ab=2E1709886?=
 =?utf-8?q?922=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1547937865052170755=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1547937865052170755==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Mar 2024 at 14:21, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tee/optee/smc_abi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a37f87087e5c..c82b7b88991d 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1433,7 +1433,7 @@ static optee_invoke_fn *get_invoke_func(struct device=
 *dev)
>   * optee_remove is called by platform subsystem to alert the driver
>   * that it should release the device
>   */
> -static int optee_smc_remove(struct platform_device *pdev)
> +static void optee_smc_remove(struct platform_device *pdev)
>  {
>         struct optee *optee =3D platform_get_drvdata(pdev);
>
> @@ -1453,8 +1453,6 @@ static int optee_smc_remove(struct platform_device *p=
dev)
>                 memunmap(optee->smc.memremaped_shm);
>
>         kfree(optee);
> -
> -       return 0;
>  }
>
>  /* optee_shutdown - Device Removal Routine
> @@ -1806,7 +1804,7 @@ MODULE_DEVICE_TABLE(of, optee_dt_match);
>
>  static struct platform_driver optee_driver =3D {
>         .probe  =3D optee_probe,
> -       .remove =3D optee_smc_remove,
> +       .remove_new =3D optee_smc_remove,
>         .shutdown =3D optee_shutdown,
>         .driver =3D {
>                 .name =3D "optee",
>
> base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
> --
> 2.43.0
>

--===============1547937865052170755==--

