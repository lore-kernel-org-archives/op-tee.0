From: Ulf Hansson <ulf.hansson@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/2] optee: add RPMB dependency
Date: Tue, 03 Sep 2024 14:37:38 +0200
Message-ID: 
 <CAPDyKFr+nF5Y-fe6FpKcBt0zX=_oEmy7j-rbvG-1tmP_qQXrWw@mail.gmail.com>
In-Reply-To: <20240902151231.3705204-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0440535686630117154=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0440535686630117154==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Sept 2024 at 17:12, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Prevent build error when CONFIG_RPMB=3Dm and CONFIG_OPTEE=3Dy by adding a
> dependency to CONFIG_RPMB for CONFIG_OPTEE so the RPMB subsystem always
> is reachable if configured. This means that CONFIG_OPTEE automatically
> becomes compiled as a module if CONFIG_RPMB is compiled as a module. If
> CONFIG_RPMB isn't configured or is configured as built-in, CONFIG_OPTEE
> will remain unchanged.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp(a)i=
ntel.com/
> Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Replacing "rpmb: use IS_REACHABLE instead of IS_ENABLED"
> https://lore.kernel.org/lkml/20240902080727.2665235-1-jens.wiklander(a)lina=
ro.org/
> ---
>  drivers/tee/optee/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index 976928641aa6..7bb7990d0b07 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -4,6 +4,7 @@ config OPTEE
>         tristate "OP-TEE"
>         depends on HAVE_ARM_SMCCC
>         depends on MMU
> +       depends on RPMB || !RPMB
>         help
>           This implements the OP-TEE Trusted Execution Environment (TEE)
>           driver.
> --
> 2.34.1
>

--===============0440535686630117154==--

