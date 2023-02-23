From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add SMC for loading OP-TEE image
Date: Thu, 23 Feb 2023 10:28:29 +0100
Message-ID: 
 <CAHUa44GUEtN4J_PKaeM4YEfL8dGBpCcSWw1C_pobwh9VFpWKTw@mail.gmail.com>
In-Reply-To: <
 <20230222092409.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4322319826660635707=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4322319826660635707==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 22, 2023 at 6:24 PM Jeffrey Kardatzke
<jkardatzke@chromium.org> wrote:
>
> Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> instruct it to load it as the BL32 payload. This works in conjunction
> with a feature added to Trusted Firmware for ARM that supports this.
>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> ---
>
>  drivers/tee/optee/Kconfig     | 10 +++++
>  drivers/tee/optee/optee_msg.h | 14 +++++++
>  drivers/tee/optee/optee_smc.h | 22 ++++++++++
>  drivers/tee/optee/smc_abi.c   | 77 +++++++++++++++++++++++++++++++++++
>  4 files changed, 123 insertions(+)
>
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index f121c224e682..5ffbeb3eaac0 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -7,3 +7,13 @@ config OPTEE
>         help
>           This implements the OP-TEE Trusted Execution Environment (TEE)
>           driver.
> +
> +config OPTEE_LOAD_IMAGE
> +       bool "Load Op-Tee image as firmware"

OP-TEE

> +       default n
> +       depends on OPTEE
> +       help
> +         This loads the BL32 image for OP-TEE as firmware when the driver =
is probed.
> +         This returns -EPROBE_DEFER until the firmware is loadable from the
> +         filesystem which is determined by checking the system_state until=
 it is in
> +         SYSTEM_RUNNING.
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 70e9cc2ee96b..84c1b15032a9 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -284,6 +284,20 @@ struct optee_msg_arg {
>   */
>  #define OPTEE_MSG_FUNCID_GET_OS_REVISION       0x0001
>
> +/*
> + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> + *
> + * WARNING: Use this cautiously as it could lead to insecure loading of the
> + * Trusted OS.
> + * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.
> + * The first two params are the high and low 32 bits of the size of the pa=
yload
> + * and the third and fourth params are the high and low 32 bits of the phy=
sical
> + * address of the payload. The payload is in the OP-TEE image format.
> + *
> + * Returns 0 on success and an error code otherwise.
> + */
> +#define OPTEE_MSG_FUNCID_LOAD_IMAGE   0x0002

There's no need to add anything to this file, you can define
OPTEE_SMC_FUNCID_LOAD_IMAGE to 2 directly in optee_smc.h below.

> +
>  /*
>   * Do a secure call with struct optee_msg_arg as argument
>   * The OPTEE_MSG_CMD_* below defines what goes in struct optee_msg_arg::cmd
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index 73b5e7760d10..908b1005e9db 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -104,6 +104,28 @@ struct optee_smc_call_get_os_revision_result {
>         unsigned long reserved1;
>  };
>
> +/*
> + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> + *
> + * WARNING: Use this cautiously as it could lead to insecure loading of the
> + * Trusted OS.
> + * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.

execute

> + *
> + * Call register usage:
> + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
> + * a1 Upper 32bit of a 64bit size for the payload
> + * a2 Lower 32bit of a 64bit size for the payload
> + * a3 Upper 32bit of the physical address for the payload
> + * a4 Lower 32bit of the physical address for the payload
> + *
> + * The payload is in the OP-TEE image format.
> + *
> + * Returns result in a0, 0 on success and an error code otherwise.
> + */
> +#define OPTEE_SMC_FUNCID_LOAD_IMAGE OPTEE_MSG_FUNCID_LOAD_IMAGE
> +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_LOAD_IMAGE)
> +
>  /*
>   * Call with struct optee_msg_arg as argument
>   *
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..c1abbee86b39 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -8,9 +8,11 @@
>
>  #include <linux/arm-smccc.h>
>  #include <linux/errno.h>
> +#include <linux/firmware.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irqdomain.h>
> +#include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -1354,6 +1356,77 @@ static void optee_shutdown(struct platform_device *p=
dev)
>                 optee_disable_shm_cache(optee);
>  }
>
> +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> +
> +#define OPTEE_FW_IMAGE "optee/tee.bin"
> +
> +static int optee_load_fw(struct platform_device *pdev,
> +                        optee_invoke_fn *invoke_fn)
> +{
> +       const struct firmware *fw =3D NULL;
> +       struct arm_smccc_res res;
> +       phys_addr_t data_pa;
> +       u8 *data_buf =3D NULL;
> +       u64 data_size;
> +       u32 data_pa_high, data_pa_low;
> +       u32 data_size_high, data_size_low;
> +       int rc;
> +
> +       rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> +       if (rc) {
> +               /*
> +                * The firmware in the rootfs will not be accessible until =
we
> +                * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER =
until
> +                * that point.
> +                */
> +               if (system_state < SYSTEM_RUNNING)
> +                       return -EPROBE_DEFER;
> +               goto fw_err;
> +       }
> +
> +       data_size =3D fw->size;
> +       /*
> +        * This uses the GFP_DMA flag to ensure we are allocated memory in =
the
> +        * 32-bit space since TF-A cannot map memory beyond the 32-bit boun=
dary.
> +        */
> +       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> +       if (!data_buf) {
> +               rc =3D -ENOMEM;
> +               goto fw_err;
> +       }
> +       memcpy(data_buf, fw->data, fw->size);
> +       data_pa =3D virt_to_phys(data_buf);
> +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> +       reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> +       goto fw_load;
> +
> +fw_err:
> +       pr_warn("image loading failed\n");
> +       data_pa_high =3D data_pa_low =3D data_size_high =3D data_size_low =
=3D 0;
> +
> +fw_load:
> +       /*
> +        * Always invoke the SMC, even if loading the image fails, to indic=
ate
> +        * to EL3 that we have passed the point where it should allow invok=
ing
> +        * this SMC.
> +        */
> +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
> +                 data_pa_high, data_pa_low, 0, 0, 0, &res);

Prior to this, you've done nothing to check that the firmware might do
what you're expecting. optee_msg_api_uid_is_optee_api() does this
under normal circumstances as that SMC function is defined in the SMC
Calling Convention. I'm not sure what is the best approach here
though.

> +       if (!rc)
> +               rc =3D res.a0;
> +       if (fw)
> +               release_firmware(fw);
> +       kfree(data_buf);
> +
> +       return rc;
> +}
> +#else
> +static inline int optee_load_fw(struct platform_device *__unused,
> +               optee_invoke_fn *__unused) {
> +       return 0;
> +}
> +#endif
> +
>  static int optee_probe(struct platform_device *pdev)
>  {
>         optee_invoke_fn *invoke_fn;
> @@ -1372,6 +1445,10 @@ static int optee_probe(struct platform_device *pdev)
>         if (IS_ERR(invoke_fn))
>                 return PTR_ERR(invoke_fn);
>
> +       rc =3D optee_load_fw(pdev, invoke_fn);
> +       if (rc)
> +               return rc;

What if OP-TEE already was loaded?
This also causes trouble if unloading and loading the driver again.
I think we need a way of telling if OP-TEE must be loaded first or not.

Thanks,
Jens

> +
>         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
>                 pr_warn("api uid mismatch\n");
>                 return -EINVAL;
> --
> 2.39.2.637.g21b0678d19-goog
>

--===============4322319826660635707==--

