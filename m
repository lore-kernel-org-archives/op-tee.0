From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Date: Mon, 10 Jun 2024 14:52:31 +0200
Message-ID: 
 <CAHUa44GAiUf9+PxqhXOwGfOuc250YDyJ7uzGe2B1bGmBw2iegg@mail.gmail.com>
In-Reply-To: <Zl2Ibey9Qck-VLWE@manut.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6653029142730919934=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6653029142730919934==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

On Mon, Jun 3, 2024 at 11:10=E2=80=AFAM Manuel Traut <manut@mecka.net> wrot=
e:
>
> On 14:13 Mon 27 May     , Jens Wiklander wrote:
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/arm_ffa.h>
> >  #include <linux/errno.h>
> > +#include <linux/rpmb.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> > @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_de=
v)
> >       optee->ffa.bottom_half_value =3D U32_MAX;
> >       optee->rpc_param_count =3D rpc_param_count;
> >
> > +     if (IS_REACHABLE(CONFIG_RPMB) &&
> > +         (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> > +             optee->in_kernel_rpmb_routing =3D true;
>
> The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the moment.
> If I remove this check here, the series works for me.

You're right, I missed pushing those flags to optee_os. I've pushed them now.

Cheers,
Jens

--===============6653029142730919934==--

