From: Randy Dunlap <rdunlap@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
Date: Mon, 31 Jul 2023 08:05:18 -0700
Message-ID: <a6d9857c-fcbd-74d0-bc97-fc86a8c1b820@infradead.org>
In-Reply-To: <20230731065041.1447-4-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3609527124258964332=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3609527124258964332==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



On 7/30/23 23:50, Masahisa Kojima wrote:
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 043ca31c114e..aa38089d1e4a 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -287,3 +287,18 @@ config UEFI_CPER_X86
>  	bool
>  	depends on UEFI_CPER && X86
>  	default y
> +
> +config TEE_STMM_EFI
> +	tristate "TEE based EFI runtime variable service driver"

	          TEE-based

> +	depends on EFI && OPTEE && !EFI_VARS_PSTORE
> +	help
> +	  Select this config option if TEE is compiled to include StandAloneMM
> +	  as a separate secure partition it has the ability to check and store

	                       partition. It has the ability

> +	  EFI variables on an RPMB or any other non-volatile medium used by
> +	  StandAloneMM.
> +
> +	  Enabling this will change the EFI runtime services from the firmware
> +	  provided functions to TEE calls.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called tee_stmm_efi.

-- 
~Randy

--===============3609527124258964332==--

