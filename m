From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add SMC for loading OP-TEE image
Date: Thu, 02 Mar 2023 08:23:14 +0100
Message-ID: 
 <CAHUa44GCzi3oTrko0_JS=-HGZisbwOwG2gT+mpHJziqr4LAcOQ@mail.gmail.com>
In-Reply-To: <
 <CA+ddPcPzVEd6TJ=xFF3iGPpMmPbphGyCSdxMd0Ts-5CzYvRG=Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8115775425725160705=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8115775425725160705==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 1, 2023 at 8:27=E2=80=AFPM Jeffrey Kardatzke
<jkardatzke@chromium.org> wrote:
>
> On Wed, Mar 1, 2023 at 12:44=E2=80=AFAM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > On Tue, Feb 28, 2023 at 8:29 PM Jeffrey Kardatzke
> > <jkardatzke@chromium.org> wrote:
> > >
> > > On Tue, Feb 28, 2023 at 10:55=E2=80=AFAM Jens Wiklander
> > > <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Fri, Feb 24, 2023 at 9:17 PM Jeffrey Kardatzke
> > > > <jkardatzke@chromium.org> wrote:
> > > > >
> > > > > On Fri, Feb 24, 2023 at 12:25 AM Jens Wiklander
> > > > > <jens.wiklander@linaro.org> wrote:
> > > > > >
> > > > > > On Thu, Feb 23, 2023 at 8:09 PM Jeffrey Kardatzke
> > > > > > <jkardatzke@chromium.org> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 23, 2023 at 1:28 AM Jens Wiklander
> > > > > > > <jens.wiklander@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Wed, Feb 22, 2023 at 6:24 PM Jeffrey Kardatzke
> > > > > > > > <jkardatzke@chromium.org> wrote:
> > > > > > > > >
> > > > > > > > > Adds an SMC call that will pass an OP-TEE binary image to E=
L3 and
> > > > > > > > > instruct it to load it as the BL32 payload. This works in c=
onjunction
> > > > > > > > > with a feature added to Trusted Firmware for ARM that suppo=
rts this.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > > > > > > > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > >  drivers/tee/optee/Kconfig     | 10 +++++
> > > > > > > > >  drivers/tee/optee/optee_msg.h | 14 +++++++
> > > > > > > > >  drivers/tee/optee/optee_smc.h | 22 ++++++++++
> > > > > > > > >  drivers/tee/optee/smc_abi.c   | 77 +++++++++++++++++++++++=
++++++++++++
> > > > > > > > >  4 files changed, 123 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/=
Kconfig
> > > > > > > > > index f121c224e682..5ffbeb3eaac0 100644
> > > > > > > > > --- a/drivers/tee/optee/Kconfig
> > > > > > > > > +++ b/drivers/tee/optee/Kconfig
> > > > > > > > > @@ -7,3 +7,13 @@ config OPTEE
> > > > > > > > >         help
> > > > > > > > >           This implements the OP-TEE Trusted Execution Envi=
ronment (TEE)
> > > > > > > > >           driver.
> > > > > > > > > +
> > > > > > > > > +config OPTEE_LOAD_IMAGE
> > > > > > > > > +       bool "Load Op-Tee image as firmware"
> > > > > > > >
> > > > > > > > OP-TEE
> > > > > > > Done, fixed in next patch set.
> > > > > > > >
> > > > > > > > > +       default n
> > > > > > > > > +       depends on OPTEE
> > > > > > > > > +       help
> > > > > > > > > +         This loads the BL32 image for OP-TEE as firmware =
when the driver is probed.
> > > > > > > > > +         This returns -EPROBE_DEFER until the firmware is =
loadable from the
> > > > > > > > > +         filesystem which is determined by checking the sy=
stem_state until it is in
> > > > > > > > > +         SYSTEM_RUNNING.
> > > > > > > > > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/op=
tee/optee_msg.h
> > > > > > > > > index 70e9cc2ee96b..84c1b15032a9 100644
> > > > > > > > > --- a/drivers/tee/optee/optee_msg.h
> > > > > > > > > +++ b/drivers/tee/optee/optee_msg.h
> > > > > > > > > @@ -284,6 +284,20 @@ struct optee_msg_arg {
> > > > > > > > >   */
> > > > > > > > >  #define OPTEE_MSG_FUNCID_GET_OS_REVISION       0x0001
> > > > > > > > >
> > > > > > > > > +/*
> > > > > > > > > + * Load Trusted OS from optee/tee.bin in the Linux firmwar=
e.
> > > > > > > > > + *
> > > > > > > > > + * WARNING: Use this cautiously as it could lead to insecu=
re loading of the
> > > > > > > > > + * Trusted OS.
> > > > > > > > > + * This SMC instructs EL3 to load a binary and excute it a=
s the Trusted OS.
> > > > > > > > > + * The first two params are the high and low 32 bits of th=
e size of the payload
> > > > > > > > > + * and the third and fourth params are the high and low 32=
 bits of the physical
> > > > > > > > > + * address of the payload. The payload is in the OP-TEE im=
age format.
> > > > > > > > > + *
> > > > > > > > > + * Returns 0 on success and an error code otherwise.
> > > > > > > > > + */
> > > > > > > > > +#define OPTEE_MSG_FUNCID_LOAD_IMAGE   0x0002
> > > > > > > >
> > > > > > > > There's no need to add anything to this file, you can define
> > > > > > > > OPTEE_SMC_FUNCID_LOAD_IMAGE to 2 directly in optee_smc.h belo=
w.
> > > > > > > >
> > > > > > > Done, fixed in next patch set.
> > > > > > > > > +
> > > > > > > > >  /*
> > > > > > > > >   * Do a secure call with struct optee_msg_arg as argument
> > > > > > > > >   * The OPTEE_MSG_CMD_* below defines what goes in struct o=
ptee_msg_arg::cmd
> > > > > > > > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/op=
tee/optee_smc.h
> > > > > > > > > index 73b5e7760d10..908b1005e9db 100644
> > > > > > > > > --- a/drivers/tee/optee/optee_smc.h
> > > > > > > > > +++ b/drivers/tee/optee/optee_smc.h
> > > > > > > > > @@ -104,6 +104,28 @@ struct optee_smc_call_get_os_revision_=
result {
> > > > > > > > >         unsigned long reserved1;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > +/*
> > > > > > > > > + * Load Trusted OS from optee/tee.bin in the Linux firmwar=
e.
> > > > > > > > > + *
> > > > > > > > > + * WARNING: Use this cautiously as it could lead to insecu=
re loading of the
> > > > > > > > > + * Trusted OS.
> > > > > > > > > + * This SMC instructs EL3 to load a binary and excute it a=
s the Trusted OS.
> > > > > > > >
> > > > > > > > execute
> > > > > > > >
> > > > > > > Done, fixed in next patch set.
> > > > > > > > > + *
> > > > > > > > > + * Call register usage:
> > > > > > > > > + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
> > > > > > > > > + * a1 Upper 32bit of a 64bit size for the payload
> > > > > > > > > + * a2 Lower 32bit of a 64bit size for the payload
> > > > > > > > > + * a3 Upper 32bit of the physical address for the payload
> > > > > > > > > + * a4 Lower 32bit of the physical address for the payload
> > > > > > > > > + *
> > > > > > > > > + * The payload is in the OP-TEE image format.
> > > > > > > > > + *
> > > > > > > > > + * Returns result in a0, 0 on success and an error code ot=
herwise.
> > > > > > > > > + */
> > > > > > > > > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE OPTEE_MSG_FUNCID_LOAD_=
IMAGE
> > > > > > > > > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > > > > > > > > +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > > > > > > > > +
> > > > > > > > >  /*
> > > > > > > > >   * Call with struct optee_msg_arg as argument
> > > > > > > > >   *
> > > > > > > > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/opte=
e/smc_abi.c
> > > > > > > > > index a1c1fa1a9c28..c1abbee86b39 100644
> > > > > > > > > --- a/drivers/tee/optee/smc_abi.c
> > > > > > > > > +++ b/drivers/tee/optee/smc_abi.c
> > > > > > > > > @@ -8,9 +8,11 @@
> > > > > > > > >
> > > > > > > > >  #include <linux/arm-smccc.h>
> > > > > > > > >  #include <linux/errno.h>
> > > > > > > > > +#include <linux/firmware.h>
> > > > > > > > >  #include <linux/interrupt.h>
> > > > > > > > >  #include <linux/io.h>
> > > > > > > > >  #include <linux/irqdomain.h>
> > > > > > > > > +#include <linux/kernel.h>
> > > > > > > > >  #include <linux/mm.h>
> > > > > > > > >  #include <linux/module.h>
> > > > > > > > >  #include <linux/of.h>
> > > > > > > > > @@ -1354,6 +1356,77 @@ static void optee_shutdown(struct pl=
atform_device *pdev)
> > > > > > > > >                 optee_disable_shm_cache(optee);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> > > > > > > > > +
> > > > > > > > > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > > > > > > > > +
> > > > > > > > > +static int optee_load_fw(struct platform_device *pdev,
> > > > > > > > > +                        optee_invoke_fn *invoke_fn)
> > > > > > > > > +{
> > > > > > > > > +       const struct firmware *fw =3D NULL;
> > > > > > > > > +       struct arm_smccc_res res;
> > > > > > > > > +       phys_addr_t data_pa;
> > > > > > > > > +       u8 *data_buf =3D NULL;
> > > > > > > > > +       u64 data_size;
> > > > > > > > > +       u32 data_pa_high, data_pa_low;
> > > > > > > > > +       u32 data_size_high, data_size_low;
> > > > > > > > > +       int rc;
> > > > > > > > > +
> > > > > > > > > +       rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev-=
>dev);
> > > > > > > > > +       if (rc) {
> > > > > > > > > +               /*
> > > > > > > > > +                * The firmware in the rootfs will not be a=
ccessible until we
> > > > > > > > > +                * are in the SYSTEM_RUNNING state, so retu=
rn EPROBE_DEFER until
> > > > > > > > > +                * that point.
> > > > > > > > > +                */
> > > > > > > > > +               if (system_state < SYSTEM_RUNNING)
> > > > > > > > > +                       return -EPROBE_DEFER;
> > > > > > > > > +               goto fw_err;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       data_size =3D fw->size;
> > > > > > > > > +       /*
> > > > > > > > > +        * This uses the GFP_DMA flag to ensure we are allo=
cated memory in the
> > > > > > > > > +        * 32-bit space since TF-A cannot map memory beyond=
 the 32-bit boundary.
> > > > > > > > > +        */
> > > > > > > > > +       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA=
);
> > > > > > > > > +       if (!data_buf) {
> > > > > > > > > +               rc =3D -ENOMEM;
> > > > > > > > > +               goto fw_err;
> > > > > > > > > +       }
> > > > > > > > > +       memcpy(data_buf, fw->data, fw->size);
> > > > > > > > > +       data_pa =3D virt_to_phys(data_buf);
> > > > > > > > > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_=
pa);
> > > > > > > > > +       reg_pair_from_64(&data_size_high, &data_size_low, d=
ata_size);
> > > > > > > > > +       goto fw_load;
> > > > > > > > > +
> > > > > > > > > +fw_err:
> > > > > > > > > +       pr_warn("image loading failed\n");
> > > > > > > > > +       data_pa_high =3D data_pa_low =3D data_size_high =3D=
 data_size_low =3D 0;
> > > > > > > > > +
> > > > > > > > > +fw_load:
> > > > > > > > > +       /*
> > > > > > > > > +        * Always invoke the SMC, even if loading the image=
 fails, to indicate
> > > > > > > > > +        * to EL3 that we have passed the point where it sh=
ould allow invoking
> > > > > > > > > +        * this SMC.
> > > > > > > > > +        */
> > > > > > > > > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high=
, data_size_low,
> > > > > > > > > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> > > > > > > >
> > > > > > > > Prior to this, you've done nothing to check that the firmware=
 might do
> > > > > > > > what you're expecting. optee_msg_api_uid_is_optee_api() does =
this
> > > > > > > > under normal circumstances as that SMC function is defined in=
 the SMC
> > > > > > > > Calling Convention. I'm not sure what is the best approach he=
re
> > > > > > > > though.
> > > > > > > >
> > > > > > > The way I think about it is that we have to issue this SMC call=
 once
> > > > > > > we are in the SYSTEM_RUNNING state no matter what. We need to c=
lose
> > > > > > > the security hole this would leave open otherwise. Any other ch=
ecks we
> > > > > > > would do that would prevent us from making that call could be o=
ther
> > > > > > > attack vectors.
> > > > > >
> > > > > > This is clearly a weakness in the design. If the kernel config do=
esn't
> > > > > > match exactly, we either have an open security hole in the secure
> > > > > > world or fail to initialize the driver.
> > > > > Yes, that's correct where if TF-A was built to enable the SMC call,
> > > > > but then the kernel wasn't built to include the OP-TEE driver, or w=
ith
> > > > > the image loading SMC config or the driver doesn't get loaded; that=
's
> > > > > leaving an open security hole. It's understood as part of this desi=
gn
> > > > > that there's a big open security hole if the system isn't configured
> > > > > properly.
> > > > > > The former can only happen in
> > > > > > systems designed like yours where the kernel up to this point has=
 the
> > > > > > same level of security as the secure world. There's no need for m=
e to
> > > > > > repeat my concerns over that, but this is now going to have an im=
pact
> > > > > > on platforms that don't use your security model too. So far we've
> > > > > > managed to avoid configuration options in the OP-TEE driver that
> > > > > > breaks everything for a class of devices.
> > > > > I could change TF-A and the kernel driver so that if it somebody do=
es
> > > > > enable the kernel option but not the TF-A option, that TF-A returns=
 a
> > > > > specific error code (rather than passing the non-secure originating
> > > > > call to OP-TEE) and the kernel driver can recognize that and then
> > > > > continue as if OP-TEE was loaded. Then enabling this option won't
> > > > > break anything if the TF-A config doesn't match.
> > > >
> > > > Yes, that should help a bit. We may want to check some UUID of the
> > > > service too, just to avoid sending SMCs into the dark and not knowing
> > > > what it may hit. I believe we can sort out those details when
> > > > reviewing the TF-A patch.
> > > >
> > > After looking at the code again...I realize I could do this in TF-A or
> > > OP-TEE. In the current TF-A code (except when this option is enabled),
> > > all SMCs are passed to OP-TEE. So I could add this into the SMC
> > > handling code in OP-TEE to just return success in this case and that's
> > > always enabled (since OP-TEE knows it is already loaded that seems
> > > correct). I'd also want to change the TF-A code so that if it tries to
> > > load OP-TEE more than once, that it returns success to satisfy your
> > > concern about driver reloading if somebody is using this option
> > > (currently it returns -EPERM).  Does that sound fine to you?
> >
> > You're overlooking the problem with sending SMCs to an unknown entity.
> > It might not be entirely unknown at this stage due to the entry in
> > DTB, but I would rather not depend on that.
> >
> > Regarding the error code, that can actually be ignored as the driver
> > further down will discover if OP-TEE isn't there, see the call to
> > optee_msg_api_uid_is_optee_api(). The value defined for
> > OPTEE_SMC_CALLS_UID is also defined in the SMC Calling Convention,
> > https://developer.arm.com/documentation/den0028/latest, for this
> > purpose.
> >
>
> OK, now I see what you're getting at regarding the unknown entity. How
> about I first invoke the UID call, and then in TF-A if it is in the
> state where it needs the image loaded still, it then returns an
> alternate UID.  In the kernel, if it has the alternate UID, then load
> the OP-TEE image. If it has the usual OP-TEE UID, then just proceed as
> normal.  We could even get rid of the kernel config option at that
> point too and always enable this. Would that be fine?

Yes, that's what I had in mind, except that I think it should still be
under a config option, but I don't suppose that's a big deal.

Cheers,
Jens

--===============8115775425725160705==--

