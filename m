From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 08/10] firmware: arm_ffa: Add v1.1 get_partition_info support
Date: Wed, 07 Sep 2022 12:04:33 +0100
Message-ID: <20220907110433.rnuhlrtjm32w63qz@bogus>
In-Reply-To: <
 <CAHUa44FR7PN99CK6Qq4tSoKWm7uEgctJOLEW5F3jhZhSV19QXg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6434863046557369291=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6434863046557369291==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 10:38:05AM +0200, Jens Wiklander wrote:
> On Fri, Sep 2, 2022 at 2:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > FF-A v1.1 adds support to discovery the UUIDs of the partitions that was
> > missing in v1.0 and which the driver workarounds by using UUIDs supplied
> > by the ffa_drivers.
> >
> > Add the v1.1 get_partition_info support and disable the workaround if
> > the detected FF-A version is greater than v1.0.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 42 +++++++++++++++++++++++++------
> >  include/linux/arm_ffa.h           |  1 +
> >  2 files changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa=
/driver.c
> > index 2532e0f16cc9..dd6ab2f81580 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -264,18 +264,24 @@ static int ffa_rxtx_unmap(u16 vm_id)
> >         return 0;
> >  }
> >
> > +#define PARTITION_INFO_GET_RETURN_COUNT_ONLY   BIT(0)
> > +
> >  /* buffer must be sizeof(struct ffa_partition_info) * num_partitions */
> >  static int
> >  __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
> >                          struct ffa_partition_info *buffer, int num_parti=
tions)
> >  {
> > -       int count;
> > +       int idx, count, flags =3D 0, size;
> >         ffa_value_t partition_info;
> >
> > +       if (!buffer || !num_partitions) /* Just get the count for now */
> > +               flags =3D PARTITION_INFO_GET_RETURN_COUNT_ONLY;
> > +
> >         mutex_lock(&drv_info->rx_lock);
> >         invoke_ffa_fn((ffa_value_t){
> >                       .a0 =3D FFA_PARTITION_INFO_GET,
> >                       .a1 =3D uuid0, .a2 =3D uuid1, .a3 =3D uuid2, .a4 =
=3D uuid3,
> > +                     .a5 =3D flags,
> >                       }, &partition_info);
> >
> >         if (partition_info.a0 =3D=3D FFA_ERROR) {
> > @@ -285,8 +291,18 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 u=
uid2, u32 uuid3,
> >
> >         count =3D partition_info.a2;
> >
> > +       if (drv_info->version > FFA_VERSION_1_0) {
> > +               size =3D partition_info.a3;
> > +               if (size > sizeof(*buffer))
> > +                       size =3D sizeof(*buffer);
>=20
> Below when calculating the address in the source buffer with
> "drv_info->rx_buffer + idx * size" you should use the size from
> partition_info.a3 even if it's larger than sizeof(*buffer). The amount
> of bytes to copy looks correct though. Does that make sense?
>

Good spot, I missed to see that. It makes complete sense. I will fix it.

--=20
Regards,
Sudeep

--===============6434863046557369291==--

