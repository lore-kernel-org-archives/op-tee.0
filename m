From: Ulf Hansson <ulf.hansson@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/2] mmc: block: add RPMB dependency
Date: Tue, 03 Sep 2024 14:37:35 +0200
Message-ID: 
 <CAPDyKFpqDRWFRhKP7pH9p0NwfP=tEE2SJ-njKt5AcXtJoUg1ug@mail.gmail.com>
In-Reply-To: <20240902151231.3705204-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6861894680114456037=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6861894680114456037==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Sept 2024 at 17:12, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Prevent build error when CONFIG_RPMB=3Dm and CONFIG_MMC_BLOCK=3Dy by adding
> a dependency to CONFIG_RPMB for CONFIG_MMC_BLOCK block so the RPMB
> subsystem always is reachable if configured. This means that
> CONFIG_MMC_BLOCK automatically becomes compiled as a module if
> CONFIG_RPMB is compiled as a module. If CONFIG_RPMB isn't configured or
> is configured as built-in, CONFIG_MMC_BLOCK will remain unchanged.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp(a)i=
ntel.com/
> Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB sub=
system")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Replacing "rpmb: use IS_REACHABLE instead of IS_ENABLED"
> https://lore.kernel.org/lkml/20240902080727.2665235-1-jens.wiklander(a)lina=
ro.org/
> ---
>  drivers/mmc/core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index bf4e29ef023c..14d2ecbb04d3 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -37,6 +37,7 @@ config PWRSEQ_SIMPLE
>  config MMC_BLOCK
>         tristate "MMC block device driver"
>         depends on BLOCK
> +       depends on RPMB || !RPMB
>         imply IOSCHED_BFQ
>         default y
>         help
> --
> 2.34.1
>

--===============6861894680114456037==--

