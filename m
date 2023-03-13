From: Jeffrey Kardatzke <jkardatzke@chromium.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6] tee: optee: Add SMC for loading OP-TEE image
Date: Mon, 13 Mar 2023 10:16:46 -0700
Message-ID: 
 <CA+ddPcNgkQZ5afwzNX=7nupBhLd0iK9smfCmGGeMtnCTXUcfqw@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYP9Y0fG-2MeUC8rJcwYJodtLucaqeoDe4--fU0RyA8kFg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1588688021339443247=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1588688021339443247==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2023 at 1:03=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Fri, 10 Mar 2023 at 01:13, Jeffrey Kardatzke <jkardatzke@chromium.org>=
 wrote:
> >
> > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> > instruct it to load it as the BL32 payload. This works in conjunction
> > with a feature added to Trusted Firmware for ARMv8 and above
> > architectures that supports this.
> >
> > The main purpose of this change is to facilitate updating the OP-TEE
> > component on devices via a rootfs change rather than having to do a
> > firmware update. Further details are linked to in the Kconfig file.
> >
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > ---
> >
> > Changes in v6:
> > - Expanded Kconfig documentation
> >
> > Changes in v5:
> > - Renamed config option
> > - Added runtime warning when config is used
> >
> > Changes in v4:
> > - Update commit message
> > - Added more documentation
> > - Renamed config option, added ARM64 dependency
> >
> > Changes in v3:
> > - Removed state tracking for driver reload
> > - Check UID of service to verify it needs image load
> >
> > Changes in v2:
> > - Fixed compile issue when feature is disabled
> > - Addressed minor comments
> > - Added state tracking for driver reload
> >
> >  drivers/tee/optee/Kconfig     | 29 +++++++++++
> >  drivers/tee/optee/optee_msg.h | 12 +++++
> >  drivers/tee/optee/optee_smc.h | 24 +++++++++
> >  drivers/tee/optee/smc_abi.c   | 97 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 162 insertions(+)
> >
> > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > index f121c224e682..8d4836c58486 100644
> > --- a/drivers/tee/optee/Kconfig
> > +++ b/drivers/tee/optee/Kconfig
> > @@ -7,3 +7,32 @@ config OPTEE
> >         help
> >           This implements the OP-TEE Trusted Execution Environment (TEE)
> >           driver.
> > +
> > +config OPTEE_INSECURE_LOAD_IMAGE
> > +       bool "Load OP-TEE image as firmware"
> > +       default n
> > +       depends on OPTEE && ARM64
> > +       help
> > +         This loads the BL32 image for OP-TEE as firmware when the drive=
r is
> > +         probed. This returns -EPROBE_DEFER until the firmware is loadab=
le from
> > +         the filesystem which is determined by checking the system_state=
 until
> > +         it is in SYSTEM_RUNNING. This also requires enabling the corres=
ponding
> > +         option in Trusted Firmware for Arm. The documentation there exp=
lains
> > +         the security threat associated with enabling this as well as
> > +         mitigations at the firmware and platform level.
> > +         https://trustedfirmware-a.readthedocs.io/en/latest/threat_model=
/threat_model.html
> > +
> > +         When utilizing this option, the following mitigations should be
> > +         implemented to prevent attacks at the kernel level.
> > +         1. There must be boot chain security that verifies the kernel a=
nd
> > +            rootfs, otherwise an attacker can modify the loaded OP-TEE b=
inary.
> > +         2. It is recommended to build it as an included driver rather t=
han
> > +            a module to prevent exploits that may cause the module to no=
t be
> > +            loaded.
> > +         3. If there are alternate methods of booting the device, such a=
s a
> > +            recovery mode, it should be ensured that the same mitigation=
s are
> > +            applied in that mode.
> > +         4. The OP-TEE driver must be loaded before any potential attack
> > +            vectors are opened up. This should include mounting of any
> > +            modifiable filesystems, opening of network ports or communic=
ating
> > +            with external devices (such a USB).
>
> This detailed threat model documentation belongs here [1] and it
> should rather be in following format for every bullet point:
>
> Attack vector: <>
> Mitigation: <>
>
> [1] https://docs.kernel.org/staging/tee.html?highlight=3Dtee#op-tee-driver
>

Done in v7 patch set.

> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > index 70e9cc2ee96b..e8840a82b983 100644
> > --- a/drivers/tee/optee/optee_msg.h
> > +++ b/drivers/tee/optee/optee_msg.h
> > @@ -241,11 +241,23 @@ struct optee_msg_arg {
> >   * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
> >   * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_UID_1,
> >   * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
> > + *
> > + * In the case where the OP-TEE image is loaded by the kernel, this will
> > + * initially return an alternate UID to reflect that we are communicatin=
g with
> > + * the TF-A image loading service at that time instead of OP-TEE. That U=
ID is:
> > + * a3fbeab1-1246-315d-c7c4-06b9c03cbea4.
> > + * Represented in 4 32-bit words in OPTEE_MSG_IMAGE_LOAD_UID_0,
> > + * OPTEE_MSG_IMAGE_LOAD_UID_1, OPTEE_MSG_IMAGE_LOAD_UID_2,
> > + * OPTEE_MSG_IMAGE_LOAD_UID_3.
> >   */
> >  #define OPTEE_MSG_UID_0                        0x384fb3e0
> >  #define OPTEE_MSG_UID_1                        0xe7f811e3
> >  #define OPTEE_MSG_UID_2                        0xaf630002
> >  #define OPTEE_MSG_UID_3                        0xa5d5c51b
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_0     0xa3fbeab1
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_1     0x1246315d
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_2     0xc7c406b9
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_3     0xc03cbea4
> >  #define OPTEE_MSG_FUNCID_CALLS_UID     0xFF01
> >
> >  /*
> > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > index 73b5e7760d10..7d9fa426505b 100644
> > --- a/drivers/tee/optee/optee_smc.h
> > +++ b/drivers/tee/optee/optee_smc.h
> > @@ -104,6 +104,30 @@ struct optee_smc_call_get_os_revision_result {
> >         unsigned long reserved1;
> >  };
> >
> > +/*
> > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > + *
> > + * WARNING: Use this cautiously as it could lead to insecure loading of =
the
> > + * Trusted OS.
> > + * This SMC instructs EL3 to load a binary and execute it as the Trusted=
 OS.
> > + *
> > + * Call register usage:
> > + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
> > + * a1 Upper 32bit of a 64bit size for the payload
> > + * a2 Lower 32bit of a 64bit size for the payload
> > + * a3 Upper 32bit of the physical address for the payload
> > + * a4 Lower 32bit of the physical address for the payload
> > + *
> > + * The payload is in the OP-TEE image format.
> > + *
> > + * Returns result in a0, 0 on success and an error code otherwise.
> > + */
> > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE 2
> > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> > +                          ARM_SMCCC_OWNER_TRUSTED_OS_END, \
> > +                          OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > +
> >  /*
> >   * Call with struct optee_msg_arg as argument
> >   *
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a1c1fa1a9c28..00b6b69b6f79 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -8,9 +8,11 @@
> >
> >  #include <linux/arm-smccc.h>
> >  #include <linux/errno.h>
> > +#include <linux/firmware.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -1149,6 +1151,22 @@ static bool optee_msg_api_uid_is_optee_api(optee_i=
nvoke_fn *invoke_fn)
> >         return false;
> >  }
> >
> > +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> > +static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invok=
e_fn)
> > +{
> > +       struct arm_smccc_res res;
> > +
> > +       invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
> > +
> > +       if (res.a0 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_0 &&
> > +          res.a1 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_1 &&
> > +          res.a2 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_2 &&
> > +          res.a3 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_3)
> > +               return true;
> > +       return false;
> > +}
> > +#endif
> > +
> >  static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> >  {
> >         union {
> > @@ -1354,6 +1372,81 @@ static void optee_shutdown(struct platform_device =
*pdev)
> >                 optee_disable_shm_cache(optee);
> >  }
> >
> > +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> > +
> > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > +
> > +static int optee_load_fw(struct platform_device *pdev,
> > +                        optee_invoke_fn *invoke_fn)
> > +{
> > +       const struct firmware *fw =3D NULL;
> > +       struct arm_smccc_res res;
> > +       phys_addr_t data_pa;
> > +       u8 *data_buf =3D NULL;
> > +       u64 data_size;
> > +       u32 data_pa_high, data_pa_low;
> > +       u32 data_size_high, data_size_low;
> > +       int rc;
> > +
> > +       if (!optee_msg_api_uid_is_optee_image_load(invoke_fn))
> > +               return 0;
> > +
> > +       rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> > +       if (rc) {
> > +               /*
> > +                * The firmware in the rootfs will not be accessible unti=
l we
> > +                * are in the SYSTEM_RUNNING state, so return EPROBE_DEFE=
R until
> > +                * that point.
> > +                */
> > +               if (system_state < SYSTEM_RUNNING)
> > +                       return -EPROBE_DEFER;
> > +               goto fw_err;
> > +       }
> > +
> > +       data_size =3D fw->size;
> > +       /*
> > +        * This uses the GFP_DMA flag to ensure we are allocated memory i=
n the
> > +        * 32-bit space since TF-A cannot map memory beyond the 32-bit bo=
undary.
> > +        */
> > +       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > +       if (!data_buf) {
> > +               rc =3D -ENOMEM;
> > +               goto fw_err;
> > +       }
> > +       memcpy(data_buf, fw->data, fw->size);
> > +       data_pa =3D virt_to_phys(data_buf);
> > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> > +       reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> > +       goto fw_load;
> > +
> > +fw_err:
> > +       pr_warn("image loading failed\n");
> > +       data_pa_high =3D data_pa_low =3D data_size_high =3D data_size_low=
 =3D 0;
> > +
> > +fw_load:
> > +       /*
> > +        * Always invoke the SMC, even if loading the image fails, to ind=
icate
> > +        * to EL3 that we have passed the point where it should allow inv=
oking
> > +        * this SMC.
> > +        */
> > +       pr_warn("OP-TEE image loaded from kernel, this can be insecure");
> > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_lo=
w,
> > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
>
> Apart from the security considerations discussed, I see an issue with
> the implementation here. Here you only initialize OP-TEE on *CPUX*
> that is performing OP-TEE probe. IIRC, it is required for that CPUX to
> be primary CPU0. How do we ensure that here?

I'm not aware of any restrictions that require OP-TEE to be loaded on
CPU0, do you have a point to something that indicates such a
requirement? (it's always worked fine for me no matter what core it
inits on)
>
> Also, I observe from the TF-A patch that you are doing lazy OP-TEE
> initialization for other secondary CPUs. IOW, if there is an OP-TEE
> SMC call invoked for a particular CPU then only you invoke
> opteed_cpu_on_finish_handler(0) once. This can be a bit unsafe as
> OP-TEE hasn't setup its context for those CPU which may involve some
> CPU specific security bits too such as:
> - GIC CPU interface initialization, secure vs non-secure interrupts.
> - Any platform and CPU specific TrustZone configuration.

When opteed_cpu_on_finish_handler(0) is invoked...that invokes
opteed_init_optee_ep_state(...) which then sets up the CPU context for
that CPU. It then invokes opteed_synchronous_sp_entry for the
cpu_on_entry handler which should then do any other type of platform
specific initialization in the OP-TEE code itself. What setup in
OP-TEE are you referring to that isn't going to be invoked when doing
it the lazy way?

>
> I would have rather expected you to utilize cpuhp_setup_state() and
> friends to initialize OP-TEE for secondary CPUs during boot instead
> which is safe as per your platform threat model.
>
That could be another way to do it (I'm not familiar with that kernel
code currently)..but I'd rather stick with what I have unless there is
something technically wrong with it since it's already been approved
in TF-A.

> -Sumit
>
> > +       if (!rc)
> > +               rc =3D res.a0;
> > +       if (fw)
> > +               release_firmware(fw);
> > +       kfree(data_buf);
> > +
> > +       return rc;
> > +}
> > +#else
> > +static inline int optee_load_fw(struct platform_device *__unused1,
> > +               optee_invoke_fn *__unused2) {
> > +       return 0;
> > +}
> > +#endif
> > +
> >  static int optee_probe(struct platform_device *pdev)
> >  {
> >         optee_invoke_fn *invoke_fn;
> > @@ -1372,6 +1465,10 @@ static int optee_probe(struct platform_device *pde=
v)
> >         if (IS_ERR(invoke_fn))
> >                 return PTR_ERR(invoke_fn);
> >
> > +       rc =3D optee_load_fw(pdev, invoke_fn);
> > +       if (rc)
> > +               return rc;
> > +
> >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> >                 pr_warn("api uid mismatch\n");
> >                 return -EINVAL;
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >

--===============1588688021339443247==--

