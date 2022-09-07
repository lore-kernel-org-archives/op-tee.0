From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 09/10] firmware: arm_ffa: Set up 32bit execution mode
 flag using partiion property
Date: Wed, 07 Sep 2022 12:01:42 +0100
Message-ID: <20220907110142.go33wifjqz7byji6@bogus>
In-Reply-To: <
 <CAHUa44Gq+7_XT2+ccAMxC=ZFh4vV=YuUGLGx0MMYrZ1wne83bw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3458365321074325920=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3458365321074325920==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 11:01:27AM +0200, Jens Wiklander wrote:
> On Fri, Sep 2, 2022 at 2:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > FF-A v1.1 adds a flag in the partition properties to indicate if the
> > partition runs in the AArch32 or AArch64 execution state. Use the same
> > to set-up the 32-bit execution flag mode in the ffa_dev automatically
> > and ignore any requests to do the same from the ffa_driver.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 13 ++++++++++++-
> >  include/linux/arm_ffa.h           |  2 ++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa=
/driver.c
> > index dd6ab2f81580..dbbe15592173 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -647,11 +647,19 @@ static int ffa_partition_info_get(const char *uuid_=
str,
> >         return 0;
> >  }
> >
> > -static void ffa_mode_32bit_set(struct ffa_device *dev)
> > +static void _ffa_mode_32bit_set(struct ffa_device *dev)
> >  {
> >         dev->mode_32bit =3D true;
> >  }
> >
> > +static void ffa_mode_32bit_set(struct ffa_device *dev)
> > +{
> > +       if (drv_info->version > FFA_VERSION_1_0)
> > +               return;
> > +
> > +       _ffa_mode_32bit_set(dev);
> > +}
> > +
> >  static int ffa_sync_send_receive(struct ffa_device *dev,
> >                                  struct ffa_send_direct_data *data)
> >  {
> > @@ -743,6 +751,9 @@ static void ffa_setup_partitions(void)
> >                                __func__, tpbuf->id);
> >                         continue;
> >                 }
> > +
> > +               if (tpbuf->properties & FFA_PARTITION_AARCH64_EXEC)
>=20
> Shouldn't this be !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC)?
>=20
> Before this, we used 64-bit calling convention by default for FF-A
> v1.0. I suppose we would like to keep that behaviour.
>=20

Correct, it is stupid mistake on my part. I did notice this but somehow
messed up not to add the change I made to test with OPTEE. Thanks for
noticing this.

--=20
Regards,
Sudeep

--===============3458365321074325920==--

