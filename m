From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7] tee: optee: Add SMC for loading OP-TEE image
Date: Tue, 14 Mar 2023 12:24:45 +0100
Message-ID: 
 <CAHUa44HQkdN3dgtDA=_J-TUm=AY69=em4Ox6R3q8wj-sLhh+Cw@mail.gmail.com>
In-Reply-To: <
 <20230313100414.v7.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1753524915066279995=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1753524915066279995==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2023 at 6:16=E2=80=AFPM Jeffrey Kardatzke
<jkardatzke@chromium.org> wrote:
>
> Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> instruct it to load it as the BL32 payload. This works in conjunction
> with a feature added to Trusted Firmware for ARMv8 and above
> architectures that supports this.
>
> The main purpose of this change is to facilitate updating the OP-TEE
> component on devices via a rootfs change rather than having to do a
> firmware update. Further details are linked to in the Kconfig file.
>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> ---
>
> Changes in v7:
> - Added documentation to Documentation/staging/tee.rst
>
> Changes in v6:
> - Expanded Kconfig documentation
>
> Changes in v5:
> - Renamed config option
> - Added runtime warning when config is used
>
> Changes in v4:
> - Update commit message
> - Added more documentation
> - Renamed config option, added ARM64 dependency
>
> Changes in v3:
> - Removed state tracking for driver reload
> - Check UID of service to verify it needs image load
>
> Changes in v2:
> - Fixed compile issue when feature is disabled
> - Addressed minor comments
> - Added state tracking for driver reload
>
>  Documentation/staging/tee.rst | 41 +++++++++++++++
>  drivers/tee/optee/Kconfig     | 17 ++++++
>  drivers/tee/optee/optee_msg.h | 12 +++++
>  drivers/tee/optee/optee_smc.h | 24 +++++++++
>  drivers/tee/optee/smc_abi.c   | 97 +++++++++++++++++++++++++++++++++++
>  5 files changed, 191 insertions(+)
>
> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> index 498343c7ab08..315aa8e35e6b 100644
> --- a/Documentation/staging/tee.rst
> +++ b/Documentation/staging/tee.rst
> @@ -214,6 +214,47 @@ call is done from the thread assisting the interrupt h=
andler. This is a
>  building block for OP-TEE OS in secure world to implement the top half and
>  bottom half style of device drivers.
>
> +OPTEE_INSECURE_LOAD_IMAGE Kconfig option
> +----------------------------------------
> +
> +The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load t=
he
> +BL32 OP-TEE image from the kernel after the kernel boots, rather than load=
ing
> +it from the firmware before the kernel boots. This also requires enabling =
the
> +corresponding option in Trusted Firmware for Arm. The documentation there
> +explains the security threat associated with enabling this as well as
> +mitigations at the firmware and platform level.
> +https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_mod=
el.html
> +
> +There are additional attack vectors/mitigations for the kernel that should=
 be
> +addressed when using this option.
> +
> +1. Boot chain security.
> +   Attack vector: Replace the OP-TEE OS image in the rootfs to gain contro=
l of
> +                  the system.
> +   Migitation: There must be boot chain security that verifies the kernel =
and
> +               rootfs, otherwise an attacker can modify the loaded OP-TEE
> +               binary by modifying it in the rootfs.
> +3. Alternate boot modes.
> +   Attack vector: Using an alternate boot mode (i.e. recovery mode), the O=
P-TEE
> +                  driver isn't loaded, leaving the SMC hole open.
> +   Mitigation: If there are alternate methods of booting the device, such =
as a
> +               recovery mode, it should be ensured that the same mitigatio=
ns are
> +               applied in that mode.
> +3. Attacks prior to SMC invocation.
> +   Attack vector: Code that is executed prior to issuing the SMC call to l=
oad
> +                  OP-TEE can be exploited to then load an alternate OS ima=
ge.
> +   Mitigation: The OP-TEE driver must be loaded before any potential attack
> +               vectors are opened up. This should include mounting of any
> +               modifiable filesystems, opening of network ports or communi=
cating
> +               with external devices (e.g. USB).
> +4. Blocking SMC call to load OP-TEE.
> +   Attack vector: Prevent the driver from being probed, so the SMC call to=
 load
> +                  OP-TEE isn't executed when desired, leaving it open to b=
eing
> +                  executed later and loading a modified OS.
> +   Mitigation: It is recommended to build the OP-TEE driver as an included
> +               driver rather than a module to prevent exploits that may ca=
use
> +               the module to not be loaded.
> +
>  AMD-TEE driver
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index f121c224e682..70898bbd5809 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -7,3 +7,20 @@ config OPTEE
>         help
>           This implements the OP-TEE Trusted Execution Environment (TEE)
>           driver.
> +
> +config OPTEE_INSECURE_LOAD_IMAGE
> +       bool "Load OP-TEE image as firmware"
> +       default n
> +       depends on OPTEE && ARM64
> +       help
> +         This loads the BL32 image for OP-TEE as firmware when the driver =
is
> +         probed. This returns -EPROBE_DEFER until the firmware is loadable=
 from
> +         the filesystem which is determined by checking the system_state u=
ntil
> +         it is in SYSTEM_RUNNING. This also requires enabling the correspo=
nding
> +         option in Trusted Firmware for Arm. The documentation there expla=
ins
> +         the security threat associated with enabling this as well as
> +         mitigations at the firmware and platform level.
> +         https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/t=
hreat_model.html
> +
> +         Additional documentation on kernel security risks are at
> +         Documentation/staging/tee.rst.
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 70e9cc2ee96b..e8840a82b983 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -241,11 +241,23 @@ struct optee_msg_arg {
>   * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
>   * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_UID_1,
>   * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
> + *
> + * In the case where the OP-TEE image is loaded by the kernel, this will
> + * initially return an alternate UID to reflect that we are communicating =
with
> + * the TF-A image loading service at that time instead of OP-TEE. That UID=
 is:
> + * a3fbeab1-1246-315d-c7c4-06b9c03cbea4.
> + * Represented in 4 32-bit words in OPTEE_MSG_IMAGE_LOAD_UID_0,
> + * OPTEE_MSG_IMAGE_LOAD_UID_1, OPTEE_MSG_IMAGE_LOAD_UID_2,
> + * OPTEE_MSG_IMAGE_LOAD_UID_3.
>   */
>  #define OPTEE_MSG_UID_0                        0x384fb3e0
>  #define OPTEE_MSG_UID_1                        0xe7f811e3
>  #define OPTEE_MSG_UID_2                        0xaf630002
>  #define OPTEE_MSG_UID_3                        0xa5d5c51b
> +#define OPTEE_MSG_IMAGE_LOAD_UID_0     0xa3fbeab1
> +#define OPTEE_MSG_IMAGE_LOAD_UID_1     0x1246315d
> +#define OPTEE_MSG_IMAGE_LOAD_UID_2     0xc7c406b9
> +#define OPTEE_MSG_IMAGE_LOAD_UID_3     0xc03cbea4
>  #define OPTEE_MSG_FUNCID_CALLS_UID     0xFF01
>
>  /*
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index 73b5e7760d10..7d9fa426505b 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -104,6 +104,30 @@ struct optee_smc_call_get_os_revision_result {
>         unsigned long reserved1;
>  };
>
> +/*
> + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> + *
> + * WARNING: Use this cautiously as it could lead to insecure loading of the
> + * Trusted OS.
> + * This SMC instructs EL3 to load a binary and execute it as the Trusted O=
S.
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
> +#define OPTEE_SMC_FUNCID_LOAD_IMAGE 2
> +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> +                          ARM_SMCCC_OWNER_TRUSTED_OS_END, \
> +                          OPTEE_SMC_FUNCID_LOAD_IMAGE)
> +
>  /*
>   * Call with struct optee_msg_arg as argument
>   *
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..00b6b69b6f79 100644
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
> @@ -1149,6 +1151,22 @@ static bool optee_msg_api_uid_is_optee_api(optee_inv=
oke_fn *invoke_fn)
>         return false;
>  }
>
> +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> +static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invoke_=
fn)
> +{
> +       struct arm_smccc_res res;
> +
> +       invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
> +
> +       if (res.a0 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_0 &&
> +          res.a1 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_1 &&
> +          res.a2 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_2 &&
> +          res.a3 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_3)
> +               return true;
> +       return false;
> +}
> +#endif
> +
>  static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
>  {
>         union {
> @@ -1354,6 +1372,81 @@ static void optee_shutdown(struct platform_device *p=
dev)
>                 optee_disable_shm_cache(optee);
>  }
>
> +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> +
> +#define OPTEE_FW_IMAGE "optee/tee.bin"
> +
> +static int optee_load_fw(struct platform_device *pdev,
> +                        optee_invoke_fn *invoke_fn)

Please align with the '(' on the line above.

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
> +       if (!optee_msg_api_uid_is_optee_image_load(invoke_fn))
> +               return 0;
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
> +       pr_warn("OP-TEE image loaded from kernel, this can be insecure");
> +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
> +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> +       if (!rc)
> +               rc =3D res.a0;
> +       if (fw)
> +               release_firmware(fw);
> +       kfree(data_buf);
> +
> +       return rc;
> +}
> +#else
> +static inline int optee_load_fw(struct platform_device *__unused1,
> +               optee_invoke_fn *__unused2) {

Please align with the '(' on the line above. The `{` should be at the
start of the next line.
I'd prefer the normal names of the parameters instead even if they are unused.

Cheers,
Jens

> +       return 0;
> +}
> +#endif
> +
>  static int optee_probe(struct platform_device *pdev)
>  {
>         optee_invoke_fn *invoke_fn;
> @@ -1372,6 +1465,10 @@ static int optee_probe(struct platform_device *pdev)
>         if (IS_ERR(invoke_fn))
>                 return PTR_ERR(invoke_fn);
>
> +       rc =3D optee_load_fw(pdev, invoke_fn);
> +       if (rc)
> +               return rc;
> +
>         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
>                 pr_warn("api uid mismatch\n");
>                 return -EINVAL;
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>

--===============1753524915066279995==--

