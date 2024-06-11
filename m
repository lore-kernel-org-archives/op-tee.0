From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Tue, 11 Jun 2024 16:13:21 +0530
Message-ID: 
 <CAFA6WYPYSfrDtnLPRs7_0h5Hf01oPfOpqmt4c7_Twxv-re87xQ@mail.gmail.com>
In-Reply-To: <Zme-NMa3Bvp2h7aL@nuoska>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1761674594193962278=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1761674594193962278==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jun 2024 at 08:32, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> On Mon, Jun 10, 2024 at 02:52:31PM +0200, Jens Wiklander wrote:
> > Hi Manuel,
> >
> > On Mon, Jun 3, 2024 at 11:10=E2=80=AFAM Manuel Traut <manut@mecka.net> =
wrote:
> > >
> > > On 14:13 Mon 27 May     , Jens Wiklander wrote:
> > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > @@ -7,6 +7,7 @@
> > > >
> > > >  #include <linux/arm_ffa.h>
> > > >  #include <linux/errno.h>
> > > > +#include <linux/rpmb.h>
> > > >  #include <linux/scatterlist.h>
> > > >  #include <linux/sched.h>
> > > >  #include <linux/slab.h>
> > > > @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *ff=
a_dev)
> > > >       optee->ffa.bottom_half_value =3D U32_MAX;
> > > >       optee->rpc_param_count =3D rpc_param_count;
> > > >
> > > > +     if (IS_REACHABLE(CONFIG_RPMB) &&
> > > > +         (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> > > > +             optee->in_kernel_rpmb_routing =3D true;
> > >
> > > The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the mome=
nt.
> > > If I remove this check here, the series works for me.
> >
> > You're right, I missed pushing those flags to optee_os. I've pushed them =
now.
>
> Thanks! Tested with optee 4.1 and your patches from
> https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe_v7/
> in Trusted Substrate uefi firmware
> ( https://gitlab.com/Linaro/trustedsubstrate/meta-ts/ )
> and this series and a bunch of dependencies backported to
> our Trusted Reference Stack
> ( https://trs.readthedocs.io/en/latest/ )
> 6.6.29 kernel on rockpi4b (rk3399 ARM64 SoC) with secure boot and
> the optee side fTPM TA device used to create an encrypted rootfs with
> systemd. Kernel side RPMB routing is in use and works for the TPM use cases.
>

Glad to see that you can get fTPM to work without tee-supplicant after
this patch-set.

> Full boot and test log (with unrelated test failures)
> https://ledge.validation.linaro.org/scheduler/job/88692
>
> root(a)trs-qemuarm64:~# cat /sys/class/tee/tee0/rpmb_routing_model
> ...
> kernel

So coming back to the real question, do we really need this new
rpmb_routing_model ABI? Did systemd still need it with no
tee-supplicant dependency? IMHO, a user-space ABI requires use-case
justification otherwise it's just going to add on maintenance burden.

-Sumit

>
> Tested-by: Mikko Rapeli <mikko.rapeli@linaro.org>
>
> Cheers,
>
> -Mikko

--===============1761674594193962278==--

