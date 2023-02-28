From: Jeffrey Kardatzke <jkardatzke@chromium.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add SMC for loading OP-TEE image
Date: Tue, 28 Feb 2023 11:29:04 -0800
Message-ID: 
 <CA+ddPcO4L55d2Uudkj8_NAY_5zSay-LBKWS=ZR0C6opPrzwRwQ@mail.gmail.com>
In-Reply-To: <
 <CAHUa44GhTnpyN6BrK69vOsjnDrQmYFsfm2mTX=sK97D2SWtrGQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9155903686748403127=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9155903686748403127==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 10:55=E2=80=AFAM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> On Fri, Feb 24, 2023 at 9:17 PM Jeffrey Kardatzke
> <jkardatzke@chromium.org> wrote:
> >
> > On Fri, Feb 24, 2023 at 12:25 AM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > On Thu, Feb 23, 2023 at 8:09 PM Jeffrey Kardatzke
> > > <jkardatzke@chromium.org> wrote:
> > > >
> > > > On Thu, Feb 23, 2023 at 1:28 AM Jens Wiklander
> > > > <jens.wiklander@linaro.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Wed, Feb 22, 2023 at 6:24 PM Jeffrey Kardatzke
> > > > > <jkardatzke@chromium.org> wrote:
> > > > > >
> > > > > > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> > > > > > instruct it to load it as the BL32 payload. This works in conjunc=
tion
> > > > > > with a feature added to Trusted Firmware for ARM that supports th=
is.
> > > > > >
> > > > > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > > > > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > > > > > ---
> > > > > >
> > > > > >  drivers/tee/optee/Kconfig     | 10 +++++
> > > > > >  drivers/tee/optee/optee_msg.h | 14 +++++++
> > > > > >  drivers/tee/optee/optee_smc.h | 22 ++++++++++
> > > > > >  drivers/tee/optee/smc_abi.c   | 77 +++++++++++++++++++++++++++++=
++++++
> > > > > >  4 files changed, 123 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > > > > > index f121c224e682..5ffbeb3eaac0 100644
> > > > > > --- a/drivers/tee/optee/Kconfig
> > > > > > +++ b/drivers/tee/optee/Kconfig
> > > > > > @@ -7,3 +7,13 @@ config OPTEE
> > > > > >         help
> > > > > >           This implements the OP-TEE Trusted Execution Environmen=
t (TEE)
> > > > > >           driver.
> > > > > > +
> > > > > > +config OPTEE_LOAD_IMAGE
> > > > > > +       bool "Load Op-Tee image as firmware"
> > > > >
> > > > > OP-TEE
> > > > Done, fixed in next patch set.
> > > > >
> > > > > > +       default n
> > > > > > +       depends on OPTEE
> > > > > > +       help
> > > > > > +         This loads the BL32 image for OP-TEE as firmware when t=
he driver is probed.
> > > > > > +         This returns -EPROBE_DEFER until the firmware is loadab=
le from the
> > > > > > +         filesystem which is determined by checking the system_s=
tate until it is in
> > > > > > +         SYSTEM_RUNNING.
> > > > > > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/op=
tee_msg.h
> > > > > > index 70e9cc2ee96b..84c1b15032a9 100644
> > > > > > --- a/drivers/tee/optee/optee_msg.h
> > > > > > +++ b/drivers/tee/optee/optee_msg.h
> > > > > > @@ -284,6 +284,20 @@ struct optee_msg_arg {
> > > > > >   */
> > > > > >  #define OPTEE_MSG_FUNCID_GET_OS_REVISION       0x0001
> > > > > >
> > > > > > +/*
> > > > > > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > > > > > + *
> > > > > > + * WARNING: Use this cautiously as it could lead to insecure loa=
ding of the
> > > > > > + * Trusted OS.
> > > > > > + * This SMC instructs EL3 to load a binary and excute it as the =
Trusted OS.
> > > > > > + * The first two params are the high and low 32 bits of the size=
 of the payload
> > > > > > + * and the third and fourth params are the high and low 32 bits =
of the physical
> > > > > > + * address of the payload. The payload is in the OP-TEE image fo=
rmat.
> > > > > > + *
> > > > > > + * Returns 0 on success and an error code otherwise.
> > > > > > + */
> > > > > > +#define OPTEE_MSG_FUNCID_LOAD_IMAGE   0x0002
> > > > >
> > > > > There's no need to add anything to this file, you can define
> > > > > OPTEE_SMC_FUNCID_LOAD_IMAGE to 2 directly in optee_smc.h below.
> > > > >
> > > > Done, fixed in next patch set.
> > > > > > +
> > > > > >  /*
> > > > > >   * Do a secure call with struct optee_msg_arg as argument
> > > > > >   * The OPTEE_MSG_CMD_* below defines what goes in struct optee_m=
sg_arg::cmd
> > > > > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/op=
tee_smc.h
> > > > > > index 73b5e7760d10..908b1005e9db 100644
> > > > > > --- a/drivers/tee/optee/optee_smc.h
> > > > > > +++ b/drivers/tee/optee/optee_smc.h
> > > > > > @@ -104,6 +104,28 @@ struct optee_smc_call_get_os_revision_result=
 {
> > > > > >         unsigned long reserved1;
> > > > > >  };
> > > > > >
> > > > > > +/*
> > > > > > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > > > > > + *
> > > > > > + * WARNING: Use this cautiously as it could lead to insecure loa=
ding of the
> > > > > > + * Trusted OS.
> > > > > > + * This SMC instructs EL3 to load a binary and excute it as the =
Trusted OS.
> > > > >
> > > > > execute
> > > > >
> > > > Done, fixed in next patch set.
> > > > > > + *
> > > > > > + * Call register usage:
> > > > > > + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
> > > > > > + * a1 Upper 32bit of a 64bit size for the payload
> > > > > > + * a2 Lower 32bit of a 64bit size for the payload
> > > > > > + * a3 Upper 32bit of the physical address for the payload
> > > > > > + * a4 Lower 32bit of the physical address for the payload
> > > > > > + *
> > > > > > + * The payload is in the OP-TEE image format.
> > > > > > + *
> > > > > > + * Returns result in a0, 0 on success and an error code otherwis=
e.
> > > > > > + */
> > > > > > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE OPTEE_MSG_FUNCID_LOAD_IMAGE
> > > > > > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > > > > > +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > > > > > +
> > > > > >  /*
> > > > > >   * Call with struct optee_msg_arg as argument
> > > > > >   *
> > > > > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_=
abi.c
> > > > > > index a1c1fa1a9c28..c1abbee86b39 100644
> > > > > > --- a/drivers/tee/optee/smc_abi.c
> > > > > > +++ b/drivers/tee/optee/smc_abi.c
> > > > > > @@ -8,9 +8,11 @@
> > > > > >
> > > > > >  #include <linux/arm-smccc.h>
> > > > > >  #include <linux/errno.h>
> > > > > > +#include <linux/firmware.h>
> > > > > >  #include <linux/interrupt.h>
> > > > > >  #include <linux/io.h>
> > > > > >  #include <linux/irqdomain.h>
> > > > > > +#include <linux/kernel.h>
> > > > > >  #include <linux/mm.h>
> > > > > >  #include <linux/module.h>
> > > > > >  #include <linux/of.h>
> > > > > > @@ -1354,6 +1356,77 @@ static void optee_shutdown(struct platform=
_device *pdev)
> > > > > >                 optee_disable_shm_cache(optee);
> > > > > >  }
> > > > > >
> > > > > > +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> > > > > > +
> > > > > > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > > > > > +
> > > > > > +static int optee_load_fw(struct platform_device *pdev,
> > > > > > +                        optee_invoke_fn *invoke_fn)
> > > > > > +{
> > > > > > +       const struct firmware *fw =3D NULL;
> > > > > > +       struct arm_smccc_res res;
> > > > > > +       phys_addr_t data_pa;
> > > > > > +       u8 *data_buf =3D NULL;
> > > > > > +       u64 data_size;
> > > > > > +       u32 data_pa_high, data_pa_low;
> > > > > > +       u32 data_size_high, data_size_low;
> > > > > > +       int rc;
> > > > > > +
> > > > > > +       rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> > > > > > +       if (rc) {
> > > > > > +               /*
> > > > > > +                * The firmware in the rootfs will not be accessi=
ble until we
> > > > > > +                * are in the SYSTEM_RUNNING state, so return EPR=
OBE_DEFER until
> > > > > > +                * that point.
> > > > > > +                */
> > > > > > +               if (system_state < SYSTEM_RUNNING)
> > > > > > +                       return -EPROBE_DEFER;
> > > > > > +               goto fw_err;
> > > > > > +       }
> > > > > > +
> > > > > > +       data_size =3D fw->size;
> > > > > > +       /*
> > > > > > +        * This uses the GFP_DMA flag to ensure we are allocated =
memory in the
> > > > > > +        * 32-bit space since TF-A cannot map memory beyond the 3=
2-bit boundary.
> > > > > > +        */
> > > > > > +       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > > > > > +       if (!data_buf) {
> > > > > > +               rc =3D -ENOMEM;
> > > > > > +               goto fw_err;
> > > > > > +       }
> > > > > > +       memcpy(data_buf, fw->data, fw->size);
> > > > > > +       data_pa =3D virt_to_phys(data_buf);
> > > > > > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> > > > > > +       reg_pair_from_64(&data_size_high, &data_size_low, data_si=
ze);
> > > > > > +       goto fw_load;
> > > > > > +
> > > > > > +fw_err:
> > > > > > +       pr_warn("image loading failed\n");
> > > > > > +       data_pa_high =3D data_pa_low =3D data_size_high =3D data_=
size_low =3D 0;
> > > > > > +
> > > > > > +fw_load:
> > > > > > +       /*
> > > > > > +        * Always invoke the SMC, even if loading the image fails=
, to indicate
> > > > > > +        * to EL3 that we have passed the point where it should a=
llow invoking
> > > > > > +        * this SMC.
> > > > > > +        */
> > > > > > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data=
_size_low,
> > > > > > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> > > > >
> > > > > Prior to this, you've done nothing to check that the firmware might=
 do
> > > > > what you're expecting. optee_msg_api_uid_is_optee_api() does this
> > > > > under normal circumstances as that SMC function is defined in the S=
MC
> > > > > Calling Convention. I'm not sure what is the best approach here
> > > > > though.
> > > > >
> > > > The way I think about it is that we have to issue this SMC call once
> > > > we are in the SYSTEM_RUNNING state no matter what. We need to close
> > > > the security hole this would leave open otherwise. Any other checks we
> > > > would do that would prevent us from making that call could be other
> > > > attack vectors.
> > >
> > > This is clearly a weakness in the design. If the kernel config doesn't
> > > match exactly, we either have an open security hole in the secure
> > > world or fail to initialize the driver.
> > Yes, that's correct where if TF-A was built to enable the SMC call,
> > but then the kernel wasn't built to include the OP-TEE driver, or with
> > the image loading SMC config or the driver doesn't get loaded; that's
> > leaving an open security hole. It's understood as part of this design
> > that there's a big open security hole if the system isn't configured
> > properly.
> > > The former can only happen in
> > > systems designed like yours where the kernel up to this point has the
> > > same level of security as the secure world. There's no need for me to
> > > repeat my concerns over that, but this is now going to have an impact
> > > on platforms that don't use your security model too. So far we've
> > > managed to avoid configuration options in the OP-TEE driver that
> > > breaks everything for a class of devices.
> > I could change TF-A and the kernel driver so that if it somebody does
> > enable the kernel option but not the TF-A option, that TF-A returns a
> > specific error code (rather than passing the non-secure originating
> > call to OP-TEE) and the kernel driver can recognize that and then
> > continue as if OP-TEE was loaded. Then enabling this option won't
> > break anything if the TF-A config doesn't match.
>
> Yes, that should help a bit. We may want to check some UUID of the
> service too, just to avoid sending SMCs into the dark and not knowing
> what it may hit. I believe we can sort out those details when
> reviewing the TF-A patch.
>
After looking at the code again...I realize I could do this in TF-A or
OP-TEE. In the current TF-A code (except when this option is enabled),
all SMCs are passed to OP-TEE. So I could add this into the SMC
handling code in OP-TEE to just return success in this case and that's
always enabled (since OP-TEE knows it is already loaded that seems
correct). I'd also want to change the TF-A code so that if it tries to
load OP-TEE more than once, that it returns success to satisfy your
concern about driver reloading if somebody is using this option
(currently it returns -EPERM).  Does that sound fine to you?
> > >
> > > Given how important this call is for your platform and at the same
> > > time harmful for all others perhaps this call should be done in a
> > > separate driver.
> > I'm not a kernel driver expert...but if I moved this into its own
> > driver, then I think I'd need to have the OP-TEE driver defer loading
> > until the image loading driver succeeds if it's enabled. So somebody
> > enabling that other driver would hit the same issues as somebody
> > enabling this config option for OP-TEE. (I have no problem moving this
> > into a new driver if that's what you really want, but I want to be
> > sure the same concerns don't come up if I do that).
>
> I was considering a way of trying to minimize the window where this
> hole is open while taking care of that other problem. Let's say that
> if something goes wrong and the OP-TEE driver isn't probed, then
> you're in trouble if it doesn't crash badly. If you don't like it I
> don't mind if you skip it.
>
For our config, I'm planning on including the driver directly rather
than as a module (that's why I have the EDEFER logic in there...so
both cases work...then I don't need to worry about probing). But yeah,
if somebody builds it as a module and is using the image
loading...they better be sure that the driver gets probed. And I would
prefer to keep everything in the OP-TEE driver, so that the image
loading is more straightforward.
> >
> > If your main concern is somebody enabling this option and breaking
> > their use of OP-TEE...then what I mentioned above should resolve that.
> > If not, let me know more specifically what issue you're trying to
> > avoid here.
>
> Yes, that's my main concern.
Great, thanks for confirming.
>
> Cheers,
> Jens
>
> >
> > Thanks,
> > Jeff
> > >
> > > Thanks,
> > > Jens
> > >
> > > > > > +       if (!rc)
> > > > > > +               rc =3D res.a0;
> > > > > > +       if (fw)
> > > > > > +               release_firmware(fw);
> > > > > > +       kfree(data_buf);
> > > > > > +
> > > > > > +       return rc;
> > > > > > +}
> > > > > > +#else
> > > > > > +static inline int optee_load_fw(struct platform_device *__unused,
> > > > > > +               optee_invoke_fn *__unused) {
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +#endif
> > > > > > +
> > > > > >  static int optee_probe(struct platform_device *pdev)
> > > > > >  {
> > > > > >         optee_invoke_fn *invoke_fn;
> > > > > > @@ -1372,6 +1445,10 @@ static int optee_probe(struct platform_dev=
ice *pdev)
> > > > > >         if (IS_ERR(invoke_fn))
> > > > > >                 return PTR_ERR(invoke_fn);
> > > > > >
> > > > > > +       rc =3D optee_load_fw(pdev, invoke_fn);
> > > > > > +       if (rc)
> > > > > > +               return rc;
> > > > >
> > > > > What if OP-TEE already was loaded?
> > > > > This also causes trouble if unloading and loading the driver again.
> > > > > I think we need a way of telling if OP-TEE must be loaded first or =
not.
> > > > >
> > > > OK, I added some state tracking in the driver code to return the prior
> > > > loading result if it was already loaded.
> > > > > Thanks,
> > > > > Jens
> > > > >
> > > > > > +
> > > > > >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> > > > > >                 pr_warn("api uid mismatch\n");
> > > > > >                 return -EINVAL;
> > > > > > --
> > > > > > 2.39.2.637.g21b0678d19-goog
> > > > > >

--===============9155903686748403127==--

