From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Tue, 11 Jun 2024 12:02:12 +0900
Message-ID: <Zme-NMa3Bvp2h7aL@nuoska>
In-Reply-To: <
 <CAHUa44GAiUf9+PxqhXOwGfOuc250YDyJ7uzGe2B1bGmBw2iegg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8662812084606141047=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8662812084606141047==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 10, 2024 at 02:52:31PM +0200, Jens Wiklander wrote:
> Hi Manuel,
>=20
> On Mon, Jun 3, 2024 at 11:10=E2=80=AFAM Manuel Traut <manut@mecka.net> wr=
ote:
> >
> > On 14:13 Mon 27 May     , Jens Wiklander wrote:
> > > --- a/drivers/tee/optee/ffa_abi.c
> > > +++ b/drivers/tee/optee/ffa_abi.c
> > > @@ -7,6 +7,7 @@
> > >
> > >  #include <linux/arm_ffa.h>
> > >  #include <linux/errno.h>
> > > +#include <linux/rpmb.h>
> > >  #include <linux/scatterlist.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/slab.h>
> > > @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_=
dev)
> > >       optee->ffa.bottom_half_value =3D U32_MAX;
> > >       optee->rpc_param_count =3D rpc_param_count;
> > >
> > > +     if (IS_REACHABLE(CONFIG_RPMB) &&
> > > +         (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> > > +             optee->in_kernel_rpmb_routing =3D true;
> >
> > The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the moment.
> > If I remove this check here, the series works for me.
>=20
> You're right, I missed pushing those flags to optee_os. I've pushed them no=
w.

Thanks! Tested with optee 4.1 and your patches from
https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe_v7/
in Trusted Substrate uefi firmware
( https://gitlab.com/Linaro/trustedsubstrate/meta-ts/ )
and this series and a bunch of dependencies backported to
our Trusted Reference Stack
( https://trs.readthedocs.io/en/latest/ )
6.6.29 kernel on rockpi4b (rk3399 ARM64 SoC) with secure boot and
the optee side fTPM TA device used to create an encrypted rootfs with
systemd. Kernel side RPMB routing is in use and works for the TPM use cases.

Full boot and test log (with unrelated test failures)
https://ledge.validation.linaro.org/scheduler/job/88692

root(a)trs-qemuarm64:~# cat /sys/class/tee/tee0/rpmb_routing_model
...
kernel

Tested-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Cheers,

-Mikko

--===============8662812084606141047==--

