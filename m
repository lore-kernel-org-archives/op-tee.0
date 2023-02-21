From: Jeffrey Kardatzke <jkardatzke@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add SMC for loading OP-TEE image
Date: Tue, 21 Feb 2023 10:44:57 -0800
Message-ID: 
 <CA+ddPcNZoi6jjfG4CeEt6Se8nO3Oav36zBFB5KfeZ3goqgU=2w@mail.gmail.com>
In-Reply-To: <
 <CA+ddPcPnG1Oc0a4Axxd9Yg8_NyJaTbgi_PB7S-zx6n88mZ551w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1017426557537462509=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1017426557537462509==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Is there more I need to do to get this kernel patch reviewed?

Thanks,
Jeff


On Mon, Feb 6, 2023 at 12:11=E2=80=AFPM Jeffrey Kardatzke <jkardatzke@googl=
e.com> wrote:
>
> v2 update where we check the system_state before returning EPROBE_DEFER so =
the SMC hole won't stay open if the FW isn't present in the rootfs.
>
> From ff8990ca1568139c8c0bab4512aef3cc35a26466 Mon Sep 17 00:00:00 2001
> From: Jeffrey Kardatzke <jkardatzke@google.com>
> Date: Fri, 3 Feb 2023 11:33:17 -0800
> Subject: [PATCH v2] tee: optee: Add SMC for loading OP-TEE image
>
> Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> instruct it to load it as the BL32 payload. This works in conjunction
> with a feature added to Trusted Firmware for ARM that supports this.
>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> ---
>  drivers/tee/optee/Kconfig     |  9 ++++
>  drivers/tee/optee/optee_msg.h | 14 +++++++
>  drivers/tee/optee/optee_smc.h | 22 ++++++++++
>  drivers/tee/optee/smc_abi.c   | 77 +++++++++++++++++++++++++++++++++++
>  4 files changed, 122 insertions(+)
>
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index f121c224e682..b96b5db52b37 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -7,3 +7,12 @@ config OPTEE
>   help
>    This implements the OP-TEE Trusted Execution Environment (TEE)
>    driver.
> +
> +config OPTEE_LOAD_IMAGE
> + bool "Load Op-Tee image as firmware"
> + default n
> + depends on OPTEE
> + help
> +  This loads the BL32 image for OP-TEE as firmware when the driver is prob=
ed.
> +  This returns -EPROBE_DEFER until the firmware is loadable from the
> +  filesystem.
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 70e9cc2ee96b..84c1b15032a9 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -284,6 +284,20 @@ struct optee_msg_arg {
>   */
>  #define OPTEE_MSG_FUNCID_GET_OS_REVISION 0x0001
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
> +
>  /*
>   * Do a secure call with struct optee_msg_arg as argument
>   * The OPTEE_MSG_CMD_* below defines what goes in struct optee_msg_arg::cmd
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index 73b5e7760d10..908b1005e9db 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -104,6 +104,28 @@ struct optee_smc_call_get_os_revision_result {
>   unsigned long reserved1;
>  };
>
> +/*
> + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> + *
> + * WARNING: Use this cautiously as it could lead to insecure loading of the
> + * Trusted OS.
> + * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.
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
> + OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_LOAD_IMAGE)
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
>   optee_disable_shm_cache(optee);
>  }
>
> +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> +
> +#define OPTEE_FW_IMAGE "optee/tee.bin"
> +
> +static int optee_load_fw(struct platform_device *pdev,
> + optee_invoke_fn *invoke_fn)
> +{
> + const struct firmware *fw =3D NULL;
> + struct arm_smccc_res res;
> + phys_addr_t data_pa;
> + u8 *data_buf =3D NULL;
> + u64 data_size;
> + u32 data_pa_high, data_pa_low;
> + u32 data_size_high, data_size_low;
> + int rc;
> +
> + rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> + if (rc) {
> + /*
> + * The firmware in the rootfs will not be accessible until we
> + * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
> + * that point.
> + */
> + if (system_state < SYSTEM_RUNNING)
> + return -EPROBE_DEFER;
> + goto fw_err;
> + }
> +
> + data_size =3D fw->size;
> + /*
> + * This uses the GFP_DMA flag to ensure we are allocated memory in the
> + * 32-bit space since TF-A cannot map memory beyond the 32-bit boundary.
> + */
> + data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> + if (!data_buf) {
> + rc =3D -ENOMEM;
> + goto fw_err;
> + }
> + memcpy(data_buf, fw->data, fw->size);
> + data_pa =3D virt_to_phys(data_buf);
> + reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> + reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> + goto fw_load;
> +
> +fw_err:
> + pr_warn("image loading failed\n");
> + data_pa_high =3D data_pa_low =3D data_size_high =3D data_size_low =3D 0;
> +
> +fw_load:
> + /*
> + * Always invoke the SMC, even if loading the image fails, to indicate
> + * to EL3 that we have passed the point where it should allow invoking
> + * this SMC.
> + */
> + invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
> +  data_pa_high, data_pa_low, 0, 0, 0, &res);
> + if (!rc)
> + rc =3D res.a0;
> + if (fw)
> + release_firmware(fw);
> + kfree(data_buf);
> +
> + return rc;
> +}
> +#else
> +static inline int optee_load_fw(struct platform_device *__unused,
> + optee_invoke_fn *__unused) {
> + return 0;
> +}
> +#endif
> +
>  static int optee_probe(struct platform_device *pdev)
>  {
>   optee_invoke_fn *invoke_fn;
> @@ -1372,6 +1445,10 @@ static int optee_probe(struct platform_device *pdev)
>   if (IS_ERR(invoke_fn))
>   return PTR_ERR(invoke_fn);
>
> + rc =3D optee_load_fw(pdev, invoke_fn);
> + if (rc)
> + return rc;
> +
>   if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
>   pr_warn("api uid mismatch\n");
>   return -EINVAL;
> --
> 2.39.1.519.gcb327c4b5f-goog
>
>
> On Fri, Feb 3, 2023 at 1:43 PM Jeffrey Kardatzke <jkardatzke@google.com> =
wrote:
>>
>> This is the kernel patch corresponding to the change landed in TF-A
>> here: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/18635
>>
>> This appears to be the right place to post this, let me know if not please.
>>
>> From 81d97a06a48d01eb53661b41905768271f07b870 Mon Sep 17 00:00:00 2001
>> From: Jeffrey Kardatzke <jkardatzke@google.com>
>> Date: Fri, 3 Feb 2023 11:33:17 -0800
>> Subject: [PATCH] tee: optee: Add SMC for loading OP-TEE image
>>
>> Adds an SMC call that will pass an OP-TEE binary image to EL3 and
>> instruct it to load it as the BL32 payload. This works in conjunction
>> with a feature added to Trusted Firmware for ARM that supports this.
>>
>> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
>> ---
>>  drivers/tee/optee/Kconfig     |  9 +++++
>>  drivers/tee/optee/optee_msg.h | 14 +++++++
>>  drivers/tee/optee/optee_smc.h | 22 +++++++++++
>>  drivers/tee/optee/smc_abi.c   | 70 +++++++++++++++++++++++++++++++++++
>>  4 files changed, 115 insertions(+)
>>
>> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
>> index f121c224e682..b96b5db52b37 100644
>> --- a/drivers/tee/optee/Kconfig
>> +++ b/drivers/tee/optee/Kconfig
>> @@ -7,3 +7,12 @@ config OPTEE
>>   help
>>     This implements the OP-TEE Trusted Execution Environment (TEE)
>>     driver.
>> +
>> +config OPTEE_LOAD_IMAGE
>> + bool "Load Op-Tee image as firmware"
>> + default n
>> + depends on OPTEE
>> + help
>> +   This loads the BL32 image for OP-TEE as firmware when the driver is pr=
obed.
>> +   This returns -EPROBE_DEFER until the firmware is loadable from the
>> +   filesystem.
>> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
>> index 70e9cc2ee96b..84c1b15032a9 100644
>> --- a/drivers/tee/optee/optee_msg.h
>> +++ b/drivers/tee/optee/optee_msg.h
>> @@ -284,6 +284,20 @@ struct optee_msg_arg {
>>   */
>>  #define OPTEE_MSG_FUNCID_GET_OS_REVISION 0x0001
>>
>> +/*
>> + * Load Trusted OS from optee/tee.bin in the Linux firmware.
>> + *
>> + * WARNING: Use this cautiously as it could lead to insecure loading of t=
he
>> + * Trusted OS.
>> + * This SMC instructs EL3 to load a binary and excute it as the Trusted O=
S.
>> + * The first two params are the high and low 32 bits of the size of the p=
ayload
>> + * and the third and fourth params are the high and low 32 bits of the ph=
ysical
>> + * address of the payload. The payload is in the OP-TEE image format.
>> + *
>> + * Returns 0 on success and an error code otherwise.
>> + */
>> +#define OPTEE_MSG_FUNCID_LOAD_IMAGE   0x0002
>> +
>>  /*
>>   * Do a secure call with struct optee_msg_arg as argument
>>   * The OPTEE_MSG_CMD_* below defines what goes in struct optee_msg_arg::c=
md
>> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
>> index 73b5e7760d10..908b1005e9db 100644
>> --- a/drivers/tee/optee/optee_smc.h
>> +++ b/drivers/tee/optee/optee_smc.h
>> @@ -104,6 +104,28 @@ struct optee_smc_call_get_os_revision_result {
>>   unsigned long reserved1;
>>  };
>>
>> +/*
>> + * Load Trusted OS from optee/tee.bin in the Linux firmware.
>> + *
>> + * WARNING: Use this cautiously as it could lead to insecure loading of t=
he
>> + * Trusted OS.
>> + * This SMC instructs EL3 to load a binary and excute it as the Trusted O=
S.
>> + *
>> + * Call register usage:
>> + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
>> + * a1 Upper 32bit of a 64bit size for the payload
>> + * a2 Lower 32bit of a 64bit size for the payload
>> + * a3 Upper 32bit of the physical address for the payload
>> + * a4 Lower 32bit of the physical address for the payload
>> + *
>> + * The payload is in the OP-TEE image format.
>> + *
>> + * Returns result in a0, 0 on success and an error code otherwise.
>> + */
>> +#define OPTEE_SMC_FUNCID_LOAD_IMAGE OPTEE_MSG_FUNCID_LOAD_IMAGE
>> +#define OPTEE_SMC_CALL_LOAD_IMAGE \
>> + OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_LOAD_IMAGE)
>> +
>>  /*
>>   * Call with struct optee_msg_arg as argument
>>   *
>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
>> index a1c1fa1a9c28..b1e6c4a807db 100644
>> --- a/drivers/tee/optee/smc_abi.c
>> +++ b/drivers/tee/optee/smc_abi.c
>> @@ -8,6 +8,7 @@
>>
>>  #include <linux/arm-smccc.h>
>>  #include <linux/errno.h>
>> +#include <linux/firmware.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>>  #include <linux/irqdomain.h>
>> @@ -1354,6 +1355,69 @@ static void optee_shutdown(struct platform_device *=
pdev)
>>   optee_disable_shm_cache(optee);
>>  }
>>
>> +#ifdef CONFIG_OPTEE_LOAD_IMAGE
>> +
>> +#define OPTEE_FW_IMAGE "optee/tee.bin"
>> +
>> +static int optee_load_fw(struct platform_device *pdev,
>> + optee_invoke_fn *invoke_fn)
>> +{
>> + const struct firmware *fw =3D NULL;
>> + struct arm_smccc_res res;
>> + phys_addr_t data_pa;
>> + u8 *data_buf =3D NULL;
>> + u64 data_size;
>> + u32 data_pa_high, data_pa_low;
>> + u32 data_size_high, data_size_low;
>> + int rc;
>> +
>> + rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
>> + if (rc)
>> + return -EPROBE_DEFER;
>> +
>> + data_size =3D fw->size;
>> + /*
>> + * This uses the GFP_DMA flag to ensure we are allocated memory in the
>> + * 32-bit space since TF-A cannot map memory beyond the 32-bit boundary.
>> + */
>> + data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
>> + if (!data_buf) {
>> + rc =3D -ENOMEM;
>> + goto fw_err;
>> + }
>> + memcpy(data_buf, fw->data, fw->size);
>> + data_pa =3D virt_to_phys(data_buf);
>> + reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
>> + reg_pair_from_64(&data_size_high, &data_size_low, data_size);
>> + goto fw_load;
>> +
>> +fw_err:
>> + pr_warn("image loading failed\n");
>> + data_pa_high =3D data_pa_low =3D data_size_high =3D data_size_low =3D 0;
>> +
>> +fw_load:
>> + /*
>> + * Always invoke the SMC, even if loading the image fails, to indicate
>> + * to EL3 that we have passed the point where it should allow invoking
>> + * this SMC.
>> + */
>> + invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
>> +   data_pa_high, data_pa_low, 0, 0, 0, &res);
>> + if (!rc)
>> + rc =3D res.a0;
>> + if (fw)
>> + release_firmware(fw);
>> + kfree(data_buf);
>> +
>> + return rc;
>> +}
>> +#else
>> +static inline int optee_load_fw(struct platform_device *__unused,
>> + optee_invoke_fn *__unused) {
>> + return 0;
>> +}
>> +#endif
>> +
>>  static int optee_probe(struct platform_device *pdev)
>>  {
>>   optee_invoke_fn *invoke_fn;
>> @@ -1372,6 +1436,12 @@ static int optee_probe(struct platform_device *pdev)
>>   if (IS_ERR(invoke_fn))
>>   return PTR_ERR(invoke_fn);
>>
>> + rc =3D optee_load_fw(pdev, invoke_fn);
>> + if (rc) {
>> + pr_warn("image loading failed\n");
>> + return rc;
>> + }
>> +
>>   if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
>>   pr_warn("api uid mismatch\n");
>>   return -EINVAL;
>> --
>> 2.39.1.519.gcb327c4b5f-goog

--===============1017426557537462509==--

