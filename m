From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3] tee: optee: Add SMC for loading OP-TEE image
Date: Tue, 07 Mar 2023 19:33:54 +0530
Message-ID: 
 <CAFA6WYMnpvTOTDFMfR7AnkT7FrWxxhcNf0uhndMjUwi5+WCQfQ@mail.gmail.com>
In-Reply-To: <
 <CA+ddPcNASYd_mD2ZPB-D=oxpAOZOChrQ+6f7+9yvneLKQm3rCA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7091872871719278768=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7091872871719278768==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Mar 2023 at 00:26, Jeffrey Kardatzke <jkardatzke@chromium.org> wr=
ote:
>
>
>
> On Mon, Mar 6, 2023 at 4:34=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>>
>> On Fri, 3 Mar 2023 at 01:37, Jeffrey Kardatzke <jkardatzke@chromium.org>=
 wrote:
>> >
>> > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
>> > instruct it to load it as the BL32 payload. This works in conjunction
>> > with a feature added to Trusted Firmware for ARM that supports this.
>>
>> s/Trusted Firmware for ARM/Trusted Firmware for Armv8 and above architectu=
res/
>>
> Fixed in next patch.
>>
>> This commit description tells me what you have implemented but not
>> why? The motivation for this change should be included here along with
>> security implications.
>>
> Fixed in next patch. I added another sentence on this and then linked to th=
e TF-A documentation that explains the threat model and security implications=
. Enabling the kernel feature itself won't create any security concerns; it's=
 only if TF-A has the feature enabled is there a risk introduced.

Do you have a scenario where this feature would be at all useful in
the kernel without it being enabled in TF-A?

So once you enable this feature in TF-A, isn't the kernel included in
the trust boundary for the secure world to do the right thing? IOW,
mitigations for potential attack vectors have to be implemented in the
kernel such as (from top of my head):

- The OP-TEE kernel module has to be signature checked.
- The OP-TEE firmware has to be loaded from a RO filesystem which has
been signature checked.
- How can we prevent other system entities like DMA capable devices
from mangling RAM where OP-TEE firmware is loaded during SMC call?
- How can we ensure that the OP-TEE firmware is loaded at the earliest
point before exposing it to the user-space attack vectors?

>>
>> >
>> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
>> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
>> > ---
>> >
>> > Changes in v3:
>> > - Removed state tracking for driver reload
>> > - Check UID of service to verify it needs image load
>> >
>> > Changes in v2:
>> > - Fixed compile issue when feature is disabled
>> > - Addressed minor comments
>> > - Added state tracking for driver reload
>> >
>> >  drivers/tee/optee/Kconfig     | 10 ++++
>> >  drivers/tee/optee/optee_msg.h | 12 +++++
>> >  drivers/tee/optee/optee_smc.h | 24 +++++++++
>> >  drivers/tee/optee/smc_abi.c   | 96 +++++++++++++++++++++++++++++++++++
>> >  4 files changed, 142 insertions(+)
>> >
>> > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
>> > index f121c224e682..f0f12b146add 100644
>> > --- a/drivers/tee/optee/Kconfig
>> > +++ b/drivers/tee/optee/Kconfig
>> > @@ -7,3 +7,13 @@ config OPTEE
>> >         help
>> >           This implements the OP-TEE Trusted Execution Environment (TEE)
>> >           driver.
>> > +
>> > +config OPTEE_LOAD_IMAGE
>>
>> Given the warning text attached to this config option, this should be
>> renamed as OPTEE_INSECURE_LOAD_IMAGE. Also, the help text should be
>> updated to reflect the security implication of this.
>
> OK, I renamed this to OPTEE_NONSECURE_LOAD_IMAGE (to reflect that it's load=
ing the secure image from the non-secure world).

No this has to be an insecure OP-TEE module configuration which
currently only works for your platform threat model. I would also be
in favour of a runtime warning if this option is enabled.

> I also added more comments on the security implications and that full docum=
entation is in TF-A.
>>
>>
>> I would also like to see documentation updates regarding how your
>> platform is mitigating potential threats in order to enable this
>> option. It would enable others to make a concious decision if their
>> threat model allows this option.
>
> This is already covered in the TF-A documentation. Let me know if you want =
me to link to that from here or not.

I am looking for documentation regarding risk mitigations in the
kernel (see above), basically how one should configure their kernel.
Maybe I have overlooked it but I can't find that in the TF-A
documentation.

-Sumit

>>
>>
>> > +       bool "Load OP-TEE image as firmware"
>> > +       default n
>> > +       depends on OPTEE
>>
>> IIRC, from earlier review threads you mentioned that this option is
>> enabled when OP-TEE driver is built-in rather than loadable. Shouldn't
>> we make that dependency explicit?
>
> That was an issue with a prior patch set, but has since been fixed. This ca=
n work as a built in driver or loadable module now.
>>
>>
>> Also, this option only makes sense for ARM64 as in case of ARM the
>> secure monitor is bundled into OP-TEE image and hence can't be loaded
>> dynamically. We should make that dependency explicit too.
>
> Fixed.
>>
>>
>> > +       help
>> > +         This loads the BL32 image for OP-TEE as firmware when the driv=
er is probed.
>> > +         This returns -EPROBE_DEFER until the firmware is loadable from=
 the
>> > +         filesystem which is determined by checking the system_state un=
til it is in
>> > +         SYSTEM_RUNNING.
>> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg=
.h
>> > index 70e9cc2ee96b..237d6fa9a6e8 100644
>> > --- a/drivers/tee/optee/optee_msg.h
>> > +++ b/drivers/tee/optee/optee_msg.h
>> > @@ -241,11 +241,23 @@ struct optee_msg_arg {
>> >   * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
>> >   * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_UID_1,
>> >   * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
>> > + *
>> > + * In the case where the OP-TEE image is loaded by the kernel, this will
>> > + * initially return an alternate UID to reflect that we are communicati=
ng with
>> > + * the TF-A image loading service at that time instead of OP-TEE. That =
UID is:
>> > + * a3fbeab1-1246-315d-c7c4-06b9c03cbea4.
>> > + * Represetned in 4 32-bit words in OPTEE_MSG_IMAGE_LOAD_UID_0,
>>
>> s/Represetned/Represented/
>>
> Fixed.
>>
>> > + * OPTEE_MSG_IMAGE_LOAD_UID_1, OPTEE_MSG_IMAGE_LOAD_UID_2,
>> > + * OPTEE_MSG_IMAGE_LOAD_UID_3.
>> >   */
>> >  #define OPTEE_MSG_UID_0                        0x384fb3e0
>> >  #define OPTEE_MSG_UID_1                        0xe7f811e3
>> >  #define OPTEE_MSG_UID_2                        0xaf630002
>> >  #define OPTEE_MSG_UID_3                        0xa5d5c51b
>> > +#define OPTEE_MSG_IMAGE_LOAD_UID_0     0xa3fbeab1
>> > +#define OPTEE_MSG_IMAGE_LOAD_UID_1     0x1246315d
>> > +#define OPTEE_MSG_IMAGE_LOAD_UID_2     0xc7c406b9
>> > +#define OPTEE_MSG_IMAGE_LOAD_UID_3     0xc03cbea4
>> >  #define OPTEE_MSG_FUNCID_CALLS_UID     0xFF01
>> >
>> >  /*
>> > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc=
.h
>> > index 73b5e7760d10..7d9fa426505b 100644
>> > --- a/drivers/tee/optee/optee_smc.h
>> > +++ b/drivers/tee/optee/optee_smc.h
>> > @@ -104,6 +104,30 @@ struct optee_smc_call_get_os_revision_result {
>> >         unsigned long reserved1;
>> >  };
>> >
>> > +/*
>> > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
>> > + *
>> > + * WARNING: Use this cautiously as it could lead to insecure loading of=
 the
>> > + * Trusted OS.
>> > + * This SMC instructs EL3 to load a binary and execute it as the Truste=
d OS.
>> > + *
>> > + * Call register usage:
>> > + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
>> > + * a1 Upper 32bit of a 64bit size for the payload
>> > + * a2 Lower 32bit of a 64bit size for the payload
>> > + * a3 Upper 32bit of the physical address for the payload
>> > + * a4 Lower 32bit of the physical address for the payload
>> > + *
>> > + * The payload is in the OP-TEE image format.
>> > + *
>> > + * Returns result in a0, 0 on success and an error code otherwise.
>> > + */
>> > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE 2
>> > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
>> > +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
>> > +                          ARM_SMCCC_OWNER_TRUSTED_OS_END, \
>> > +                          OPTEE_SMC_FUNCID_LOAD_IMAGE)
>> > +
>> >  /*
>> >   * Call with struct optee_msg_arg as argument
>> >   *
>> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
>> > index a1c1fa1a9c28..14612edef8f2 100644
>> > --- a/drivers/tee/optee/smc_abi.c
>> > +++ b/drivers/tee/optee/smc_abi.c
>> > @@ -8,9 +8,11 @@
>> >
>> >  #include <linux/arm-smccc.h>
>> >  #include <linux/errno.h>
>> > +#include <linux/firmware.h>
>> >  #include <linux/interrupt.h>
>> >  #include <linux/io.h>
>> >  #include <linux/irqdomain.h>
>> > +#include <linux/kernel.h>
>> >  #include <linux/mm.h>
>> >  #include <linux/module.h>
>> >  #include <linux/of.h>
>> > @@ -1149,6 +1151,22 @@ static bool optee_msg_api_uid_is_optee_api(optee_=
invoke_fn *invoke_fn)
>> >         return false;
>> >  }
>> >
>> > +#ifdef CONFIG_OPTEE_LOAD_IMAGE
>> > +static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invo=
ke_fn)
>> > +{
>> > +       struct arm_smccc_res res;
>> > +
>> > +       invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
>> > +
>> > +       if (res.a0 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_0 &&
>> > +          res.a1 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_1 &&
>> > +          res.a2 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_2 &&
>> > +          res.a3 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_3)
>> > +               return true;
>> > +       return false;
>> > +}
>> > +#endif
>> > +
>> >  static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
>> >  {
>> >         union {
>> > @@ -1354,6 +1372,80 @@ static void optee_shutdown(struct platform_device=
 *pdev)
>> >                 optee_disable_shm_cache(optee);
>> >  }
>> >
>> > +#ifdef CONFIG_OPTEE_LOAD_IMAGE
>> > +
>> > +#define OPTEE_FW_IMAGE "optee/tee.bin"
>> > +
>> > +static int optee_load_fw(struct platform_device *pdev,
>> > +                        optee_invoke_fn *invoke_fn)
>> > +{
>> > +       const struct firmware *fw =3D NULL;
>> > +       struct arm_smccc_res res;
>> > +       phys_addr_t data_pa;
>> > +       u8 *data_buf =3D NULL;
>> > +       u64 data_size;
>> > +       u32 data_pa_high, data_pa_low;
>> > +       u32 data_size_high, data_size_low;
>> > +       int rc;
>> > +
>> > +       if (!optee_msg_api_uid_is_optee_image_load(invoke_fn))
>> > +               return 0;
>> > +
>> > +       rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
>> > +       if (rc) {
>> > +               /*
>> > +                * The firmware in the rootfs will not be accessible unt=
il we
>> > +                * are in the SYSTEM_RUNNING state, so return EPROBE_DEF=
ER until
>> > +                * that point.
>> > +                */
>> > +               if (system_state < SYSTEM_RUNNING)
>> > +                       return -EPROBE_DEFER;
>> > +               goto fw_err;
>> > +       }
>> > +
>> > +       data_size =3D fw->size;
>> > +       /*
>> > +        * This uses the GFP_DMA flag to ensure we are allocated memory =
in the
>> > +        * 32-bit space since TF-A cannot map memory beyond the 32-bit b=
oundary.
>> > +        */
>> > +       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
>> > +       if (!data_buf) {
>> > +               rc =3D -ENOMEM;
>> > +               goto fw_err;
>> > +       }
>> > +       memcpy(data_buf, fw->data, fw->size);
>> > +       data_pa =3D virt_to_phys(data_buf);
>> > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
>> > +       reg_pair_from_64(&data_size_high, &data_size_low, data_size);
>> > +       goto fw_load;
>> > +
>> > +fw_err:
>> > +       pr_warn("image loading failed\n");
>> > +       data_pa_high =3D data_pa_low =3D data_size_high =3D data_size_lo=
w =3D 0;
>> > +
>> > +fw_load:
>> > +       /*
>> > +        * Always invoke the SMC, even if loading the image fails, to in=
dicate
>> > +        * to EL3 that we have passed the point where it should allow in=
voking
>> > +        * this SMC.
>> > +        */
>> > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_l=
ow,
>> > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
>> > +       if (!rc)
>> > +               rc =3D res.a0;
>> > +       if (fw)
>> > +               release_firmware(fw);
>> > +       kfree(data_buf);
>> > +
>> > +       return rc;
>> > +}
>> > +#else
>> > +static inline int optee_load_fw(struct platform_device *__unused1,
>> > +               optee_invoke_fn *__unused2) {
>> > +       return 0;
>> > +}
>> > +#endif
>> > +
>> >  static int optee_probe(struct platform_device *pdev)
>> >  {
>> >         optee_invoke_fn *invoke_fn;
>> > @@ -1372,6 +1464,10 @@ static int optee_probe(struct platform_device *pd=
ev)
>> >         if (IS_ERR(invoke_fn))
>> >                 return PTR_ERR(invoke_fn);
>> >
>> > +       rc =3D optee_load_fw(pdev, invoke_fn);
>> > +       if (rc)
>> > +               return rc;
>> > +
>> >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
>> >                 pr_warn("api uid mismatch\n");
>> >                 return -EINVAL;
>> > --
>> > 2.40.0.rc0.216.gc4246ad0f0-goog
>> >

--===============7091872871719278768==--

