From: Randy Dunlap <rdunlap@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Date: Fri, 18 Aug 2023 16:04:08 -0700
Message-ID: <0f16dd5a-bce7-0e36-3827-f713e90fb843@infradead.org>
In-Reply-To: <=?utf-8?q?=3C7531423fcb3b18ff78737ae5eabc84b0e3cb2909=2E1692369?=
 =?utf-8?q?704=2Egit=2EDevaraj=2ERangasamy=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2123032960994983975=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2123032960994983975==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi--

On 8/18/23 07:42, Devaraj Rangasamy wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
> index 722b6eca2e93..5e38423f3d53 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -363,6 +363,13 @@
>  			  selects a performance level in this range and appropriate
>  			  to the current workload.
> =20
> +	amdtee_cma=3Dnn	[HW,TEE]
> +			Sets the memory size reserved for contiguous memory
> +			allocations, to be used by amdtee device driver.
> +			Value is in MB and can range from 4 to 128 (MBs)

			                                       128 (MBs).

> +			CMA will be active only when CMA is enabled, and amdtee is

	That could use some improvement. How about:

			AMD-TEE CMA will be active only when CONFIG_CMA is enabled,
			and amdtee is

> +			built as inbuilt driver, and not loaded as module.
> +
>  	amijoy.map=3D	[HW,JOY] Amiga joystick support
>  			Map of devices attached to JOY0DAT and JOY1DAT
>  			Format: <a>,<b>

> diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
> index 191f9715fa9a..5843c739a7b8 100644
> --- a/drivers/tee/amdtee/Kconfig
> +++ b/drivers/tee/amdtee/Kconfig
> @@ -6,3 +6,12 @@ config AMDTEE
>  	depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
>  	help
>  	  This implements AMD's Trusted Execution Environment (TEE) driver.
> +
> +config AMDTEE_CMA_SIZE
> +	int "Size of Memory in MiB reserved in CMA for AMD-TEE"
> +	default "0"

Why won't this default value cause an allocation error message?
Maybe I'm just not following the call paths correctly.

It looks to me like this causes a call to
cma_declare_contiguous_nid() with @size =3D 0, and that function says:

	if (!size)
		return -EINVAL;

> +	depends on CMA && (AMDTEE=3Dy)
> +	help
> +	  Specify the default amount of memory in MiB reserved in CMA for AMD-TEE=
 driver

	                                                                          dr=
iver.

> +	  Any amdtee shm buffer allocation larger than 64k will allocate memory f=
rom the CMA

	                                                                            =
     CMA.

> +	  The default can be overridden with the kernel commandline parameter "am=
dtee_cma".
> \ No newline at end of file

Please fix that ^^^ warning.

Thanks.
--=20
~Randy

--===============2123032960994983975==--

