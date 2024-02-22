From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Calling OPTEE_SMC_CALL_GET_OS_UUID from driver code
Date: Thu, 22 Feb 2024 11:35:09 +0530
Message-ID: 
 <CAFA6WYPOb03XOY3QSNJY3iiXKGKZ-7irHckXoen+swV-2E8djA@mail.gmail.com>
In-Reply-To: <5a2134d0-433f-4b6f-9fda-22edae74979e@freebox.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8620325811331513995=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8620325811331513995==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 at 22:28, Marc Gonzalez <mgonzalez@freebox.fr> wrote:
>
> On 21/02/2024 08:40, Sumit Garg wrote:
>
> > Hi Marc,
> >
> > On Tue, 20 Feb 2024 at 22:59, Marc Gonzalez wrote:
> >>
> >> Hello,
> >>
> >> The driver code I'm working on hard-codes
> >>
> >> #define TEE_SMC_FAST_CALL_VAL(func_num) \
> >>     ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> >>             ARM_SMCCC_OWNER_TRUSTED_OS, (func_num))
> >>
> >> #define TEE_SMC_FUNCID_CALLS_UID 0xFF01
> >> #define TEE_SMC_CALLS_UID \
> >>     ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> >>                ARM_SMCCC_OWNER_TRUSTED_OS_END, \
> >>                TEE_SMC_FUNCID_CALLS_UID)
> >>
> >>     arm_smccc_smc(TEE_SMC_CALLS_UID,
> >>             0, 0, 0/*is_swap*/, 0, 0, 0, 0, &res);
> >>     dev_err(dev, "TEE UID %x %x %x %x\n", res.a0, res.a1, res.a2, res.a3=
);
> >>
> >>
> >> but it seems I would be required to somehow use
> >> OPTEE_SMC_CALL_GET_OS_UUID
> >>
> >> But it's not exported, and no code seems to use it...?
> >
> > Can you describe your use-case to require direct
> > OPTEE_SMC_CALL_GET_OS_UUID invocation?
>
> Turns out the GET_OS_UUID call was just debug code to make sure
> we were getting the expected reply.
>
> I have removed it from the production code.
> Below is the current code.
>
> diff --git a/drivers/staging/media/meson/vdec/vdec_1.c b/drivers/staging/me=
dia/meson/vdec/vdec_1.c
> index 3fe2de0c9331f..120bb1847aa38 100644
> --- a/drivers/staging/media/meson/vdec/vdec_1.c
> +++ b/drivers/staging/media/meson/vdec/vdec_1.c
> @@ -8,7 +8,10 @@
>   */
>
>  #include <linux/firmware.h>
> +#include <linux/delay.h>
>  #include <linux/clk.h>
> +#include <linux/arm-smccc.h>
> +#include <soc/amlogic/socinfo.h>
>
>  #include "vdec_1.h"
>  #include "vdec_helpers.h"
> @@ -22,6 +25,45 @@
>
>  #define MC_SIZE                        (4096 * 4)
>
> +static int
> +vdec_1_load_firmware_optee(struct amvdec_session *sess)
> +{
> +       struct amvdec_codec_ops *codec_ops =3D sess->fmt_out->codec_ops;
> +       struct amvdec_core *core =3D sess->core;
> +       struct device *dev =3D core->dev_dec;
> +       struct arm_smccc_res res;
> +       u32 pixfmt =3D sess->fmt_out->pixfmt;
> +       int fw_id =3D -1;
> +
> +#define TEE_SMC_FAST_CALL_VAL(func_num) \
> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, ARM_SMCCC=
_OWNER_TRUSTED_OS, (func_num))
> +
> +#define TEE_SMC_FUNCID_LOAD_VIDEO_FW 15
> +#define TEE_SMC_LOAD_VIDEO_FW TEE_SMC_FAST_CALL_VAL(TEE_SMC_FUNCID_LOAD_VI=
DEO_FW)
> +#define OPTEE_VDEC_LEGACY 0
> +#define VIDEO_DEC_MPEG12 0
> +#define VIDEO_DEC_H264 11
> +
> +       // Load wrong firmware, so that TA will reset hw component for us
> +       arm_smccc_smc(TEE_SMC_LOAD_VIDEO_FW, 1, OPTEE_VDEC_LEGACY, 0, 0, 0,=
 0, 0, &res);
> +
> +       if (pixfmt =3D=3D V4L2_PIX_FMT_H264)
> +               fw_id =3D 11;
> +
> +       if (pixfmt =3D=3D V4L2_PIX_FMT_MPEG1 || pixfmt =3D=3D V4L2_PIX_FMT_=
MPEG2)
> +               fw_id =3D 0;
> +
> +       arm_smccc_smc(TEE_SMC_LOAD_VIDEO_FW, fw_id, OPTEE_VDEC_LEGACY, 0, 0=
, 0, 0, 0, &res);
> +       dev_info(dev, "Load firmware %d: ret=3D%d\n", fw_id, res.a0);
> +
> +       msleep(100);
> +
> +       if (codec_ops->load_extended_firmware)
> +               codec_ops->load_extended_firmware(sess, 0, 0);
> +
> +       return 0;
> +}
> +
>  static int
>  vdec_1_load_firmware(struct amvdec_session *sess, const char *fwname)
>  {
> @@ -209,7 +251,11 @@ static int vdec_1_start(struct amvdec_session *sess)
>
>         vdec_1_stbuf_power_up(sess);
>
> -       ret =3D vdec_1_load_firmware(sess, sess->fmt_out->firmware_path);
> +       if (meson_get_secure_boot_state() =3D=3D 1)
> +               ret =3D vdec_1_load_firmware_optee(sess);
> +       else
> +               ret =3D vdec_1_load_firmware(sess, sess->fmt_out->firmware_=
path);
> +
>         if (ret)
>                 goto stop;
>
> @@ -232,6 +278,13 @@ static int vdec_1_start(struct amvdec_session *sess)
>         /* Let the firmware settle */
>         usleep_range(10, 20);
>
> +       /*
> +        * When running secure boot, it looks like the codec needs
> +        * more time to settle (perhaps to authenticate the image?)
> +        */
> +       if (meson_get_secure_boot_state() =3D=3D 1)
> +               msleep(100);
> +
>         return 0;
>
>  stop:
>
>
> >> $ git grep OPTEE_SMC_CALL_GET_OS_UUID
> >> Documentation/tee/op-tee.rst:- OPTEE_SMC_CALL_GET_OS_UUID returns the pa=
rticular OP-TEE implementation, used
> >> drivers/tee/optee/optee_smc.h:#define OPTEE_SMC_CALL_GET_OS_UUID \
> >>
> >> How do I make calls to OP-TEE from driver code?
> >
> > The TEE driver API documentation is here [1] and you can refer to the
> > existing OP-TEE RNG driver here for reference.
> >
> > [1] https://docs.kernel.org/driver-api/tee.html
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/char/hw_random/optee-rng.c
>
> Wow, this looks very different from our code.
>
> Are we not supposed to call arm_smccc_smc() from driver code?

Yes, all OP-TEE invocations are abstracted out via the TEE bus driver
framework. You can find other examples with a simple grep like:

$ git grep -nr "tee_bus_type"

> Looks like no one else is calling arm_smccc_smc with an owner
> equal to ARM_SMCCC_OWNER_TRUSTED_OS...
>

BTW, looking at your use-case it sounds somewhat similar (load a
firmware via OP-TEE) to this [1]. So you can take that as a reference
for your driver development.

[1] https://lore.kernel.org/linux-arm-kernel/20240214172127.1022199-3-arnaud.=
pouliquen(a)foss.st.com/T/

-Sumit

--===============8620325811331513995==--

