From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Wed, 12 Jun 2024 08:56:07 +0200
Message-ID: 
 <CAHUa44FP_eN+S4QBWJWmZ6PLptYg1+9iackz9P4Q1_Yc5EK3tQ@mail.gmail.com>
In-Reply-To: <Zmj2Wg_YqdebN3xO@nuoska>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8322872003964352093=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8322872003964352093==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:14=E2=80=AFAM Mikko Rapeli <mikko.rapeli@linaro.o=
rg> wrote:
>
> Hi,
>
> Adding TPM maintainers and linux-integrity since discussion relates to firm=
ware TPM
> driver tpm_ftpm_tee
>
> On Tue, Jun 11, 2024 at 04:13:21PM +0530, Sumit Garg wrote:
> > On Tue, 11 Jun 2024 at 08:32, Mikko Rapeli <mikko.rapeli@linaro.org> wr=
ote:
> > >
> > > Hi,
> > >
> > > On Mon, Jun 10, 2024 at 02:52:31PM +0200, Jens Wiklander wrote:
> > > > Hi Manuel,
> > > >
> > > > On Mon, Jun 3, 2024 at 11:10=E2=80=AFAM Manuel Traut <manut@mecka.n=
et> wrote:
> > > > >
> > > > > On 14:13 Mon 27 May     , Jens Wiklander wrote:
> > > > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > > > @@ -7,6 +7,7 @@
> > > > > >
> > > > > >  #include <linux/arm_ffa.h>
> > > > > >  #include <linux/errno.h>
> > > > > > +#include <linux/rpmb.h>
> > > > > >  #include <linux/scatterlist.h>
> > > > > >  #include <linux/sched.h>
> > > > > >  #include <linux/slab.h>
> > > > > > @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device=
 *ffa_dev)
> > > > > >       optee->ffa.bottom_half_value =3D U32_MAX;
> > > > > >       optee->rpc_param_count =3D rpc_param_count;
> > > > > >
> > > > > > +     if (IS_REACHABLE(CONFIG_RPMB) &&
> > > > > > +         (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> > > > > > +             optee->in_kernel_rpmb_routing =3D true;
> > > > >
> > > > > The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the =
moment.
> > > > > If I remove this check here, the series works for me.
> > > >
> > > > You're right, I missed pushing those flags to optee_os. I've pushed t=
hem now.
> > >
> > > Thanks! Tested with optee 4.1 and your patches from
> > > https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe_v7/
> > > in Trusted Substrate uefi firmware
> > > ( https://gitlab.com/Linaro/trustedsubstrate/meta-ts/ )
> > > and this series and a bunch of dependencies backported to
> > > our Trusted Reference Stack
> > > ( https://trs.readthedocs.io/en/latest/ )
> > > 6.6.29 kernel on rockpi4b (rk3399 ARM64 SoC) with secure boot and
> > > the optee side fTPM TA device used to create an encrypted rootfs with
> > > systemd. Kernel side RPMB routing is in use and works for the TPM use c=
ases.
> > >
> >
> > Glad to see that you can get fTPM to work without tee-supplicant after
> > this patch-set.
>
> Sorry but the fTPM TA only works with tee-supplicant in userspace. It's nee=
ded
> for RPC setup. For RPMB it is not needed or used with these patches applied.

I've never been able to find out what fTPM is trying to do with
tee-supplicant at this stage. I guess the RPC is a shared memory
allocation preparing for another request.

>
> > > Full boot and test log (with unrelated test failures)
> > > https://ledge.validation.linaro.org/scheduler/job/88692
> > >
> > > root(a)trs-qemuarm64:~# cat /sys/class/tee/tee0/rpmb_routing_model
> > > ...
> > > kernel
> >
> > So coming back to the real question, do we really need this new
> > rpmb_routing_model ABI? Did systemd still need it with no
> > tee-supplicant dependency? IMHO, a user-space ABI requires use-case
> > justification otherwise it's just going to add on maintenance burden.
>
> Currently it is not needed, because tee-supplicant is still required to
> setup RPC with fTPM. If the RPC setup were also done in kernel directly and
> tee-supplicant need is removed, then this kind of ABI is important so that
> userspace init knows if it needs to queue startup of tee-supplicant or not.
>
> On a related note, the kernel tpm_ftpm_tee driver for fTPM TA really has
> a hard dependency to tee-supplicant in userspace. If tee-supplicant is stop=
ped,
> restarted etc without unloading the kernel module (or otherwise disabling t=
he TPM device),
> then all TPM device actions done without tee-supplicant running will fail a=
ne keep
> failing until next reboot. The kernel driver is not crashing but all functi=
onality
> breaks.
>
> The availability of tpm_ftpm_tee should be tied much harder to the tee-supp=
licant
> running in userspace, e.g. optee should be in charge to start and bring tpm=
_ftpm_tee down
> based on tee-supplicant userspace daemon availability. Or the needed tee-su=
pplicant code
> should be moved to kernel side. Currently systemd side init scripts have is=
sues switching
> from initrd to main rootfs since they need to disable tpm_ftpm_tee driver, =
built in or a module,
> before shutting down tee-supplicant. A suspend or other inactive state in t=
he ftpm driver
> needs to be triggered, which AFAIK is not currently possible, at least from=
 userspace
> (I'd happy be proven wrong here).
>
> An alternative for tpm_fptm_tee driver is to use optee APIs so that the cal=
ls
> wait for tee-supplicant in userspace if needed:
>
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -237,6 +237,9 @@ static int ftpm_tee_probe(struct device *dev)
>                 return PTR_ERR(pvt_data->ctx);
>         }
>
> +       /* wait for tee-supplicant in userspace, fTPM TA really depends on =
it */
> +       pvt_data->ctx->supp_nowait =3D false;
> +
>         /* Open a session with fTPM TA */
>         memset(&sess_arg, 0, sizeof(sess_arg));
>         export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
>
> This works pretty well for the tee-supplicant initrd to main rootfs switch =
but currently
> breaks for example reboot (just hangs), and Jens doesn't approve of this as=
 a
> real solution.

Yes, the hang part is my main concern.

>
> So as an alternative, userspace needs to be very careful in initrd and root=
fs
> to start tee-supplicant earlier than loading tpm_ftpm_tee driver which can
> only be supported as module and removed before shutting down tee-supplicant.

Unbind/bind via sysfs might be an option. But that's still only a
workaround since getting rid of the tee-supplicant dependency in
initrd should avoid the problem entirely.

Cheers,
Jens

> In other use cases, TPM drivers are only supported if driver is built into
> the kernel (or ACPI table entry for a TPM device exists) which I'm trying
> to change with
>
> [PATCH] efi: expose TPM event log to userspace via sysfs
>
> https://lore.kernel.org/lkml/20240422112711.362779-1-mikko.rapeli(a)linaro.=
org/
>
> where userspace init can check if it should wait longer for the tpm device =
to appear,
> e.g. let udev load optee etc drivers which eventually start also tee-suppli=
cant and
> thus load tpm_ftpm_tee driver (fTPM TA enumration is tied to tee-supplicant=
 in userspace
> https://git.yoctoproject.org/meta-arm/tree/meta-arm/recipes-security/optee-=
ftpm/optee-ftpm/0001-add-enum-to-ta-flags.patch )
>
> Cheers,
>
> -Mikko

--===============8322872003964352093==--

