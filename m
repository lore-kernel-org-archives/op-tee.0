From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] plat-rzn1: increase DDR size to 1GB
Date: Mon, 15 May 2023 11:03:40 +0530
Message-ID: 
 <CAFA6WYOQD0v2DqqJ9WHck0j9PrWdJ0paqd45DnHkX+o3ieocmQ@mail.gmail.com>
In-Reply-To: <20230512170555.2252017-1-ralph.siemsen@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3939208273173509681=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3939208273173509681==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Ralph,

On Fri, 12 May 2023 at 22:36, Ralph Siemsen <ralph.siemsen@linaro.org> wrot=
e:
>
> There are now some RZ/N1 devices with 1GB rather than 256MB. The
> first-stage bootloader does not support passing a DT to OP-TEE, so
> static values are set at compile time. Increase the DDR size so as to
> avoid OP-TEE calls failing with TEEC_ERROR_OUT_OF_MEMORY.
>
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>  core/arch/arm/plat-rzn1/platform_config.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks for your patch. OP-TEE OS development happens over Github, so
please create a corresponding Github PR here [1].

[1] https://github.com/OP-TEE/optee_os/pulls

-Sumit

> diff --git a/core/arch/arm/plat-rzn1/platform_config.h b/core/arch/arm/plat=
-rzn1/platform_config.h
> index a6340bb33..eb709c62f 100644
> --- a/core/arch/arm/plat-rzn1/platform_config.h
> +++ b/core/arch/arm/plat-rzn1/platform_config.h
> @@ -11,7 +11,7 @@
>
>  /* DRAM */
>  #define DRAM_BASE                      0x80000000
> -#define DRAM_SIZE                      0x10000000
> +#define DRAM_SIZE                      0x40000000
>
>  /* GIC */
>  #define GIC_BASE                       0x44100000
> --
> 2.25.1
>

--===============3939208273173509681==--

