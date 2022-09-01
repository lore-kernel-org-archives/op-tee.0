From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 7/9] firmware: arm_ffa: Add v1.1 get_partition_info support
Date: Thu, 01 Sep 2022 11:37:42 +0200
Message-ID: 
 <CAHUa44EswTNmyApBT2jNfkAT2T8Efw0M8NAvimqsT3Vt8oMbNQ@mail.gmail.com>
In-Reply-To: <20220901085756.ymk3rd7zjqvjpaj6@bogus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0192935354063393431=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0192935354063393431==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 1, 2022 at 10:58 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Sep 01, 2022 at 10:43:58AM +0200, Jens Wiklander wrote:
> > On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wr=
ote:
> > >
> > > FF-A v1.1 adds support to discovery the UUIDs of the partitions that was
> > > missing in v1.0 and which the driver workarounds by using UUIDs supplied
> > > by the ffa_drivers.
> > >
> > > Add the v1.1 get_partition_info support and disable the workaround if
> > > the detected FF-A version is greater than v1.0.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/firmware/arm_ffa/driver.c | 39 ++++++++++++++++++++++++-------
> > >  include/linux/arm_ffa.h           |  1 +
> > >  2 files changed, 32 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_f=
fa/driver.c
> > > index 5c8484b05c50..6822241168d6 100644
> > > --- a/drivers/firmware/arm_ffa/driver.c
> > > +++ b/drivers/firmware/arm_ffa/driver.c
> > > @@ -264,18 +264,24 @@ static int ffa_rxtx_unmap(u16 vm_id)
> > >         return 0;
> > >  }
> > >
> > > +#define PARTITION_INFO_GET_RETURN_COUNT_ONLY   BIT(0)
> > > +
> > >  /* buffer must be sizeof(struct ffa_partition_info) * num_partitions */
> > >  static int
> > >  __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
> > >                          struct ffa_partition_info *buffer, int num_par=
titions)
> > >  {
> > > -       int count;
> > > +       int idx, count, flags =3D 0, size;
> > >         ffa_value_t partition_info;
> > >
> > > +       if (!buffer || !num_partitions) /* Just get the count for now */
> > > +               flags =3D PARTITION_INFO_GET_RETURN_COUNT_ONLY;
> > > +
> > >         mutex_lock(&drv_info->rx_lock);
> > >         invoke_ffa_fn((ffa_value_t){
> > >                       .a0 =3D FFA_PARTITION_INFO_GET,
> > >                       .a1 =3D uuid0, .a2 =3D uuid1, .a3 =3D uuid2, .a4 =
=3D uuid3,
> > > +                     .a5 =3D flags,
> > >                       }, &partition_info);
> > >
> > >         if (partition_info.a0 =3D=3D FFA_ERROR) {
> > > @@ -285,8 +291,15 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32=
 uuid2, u32 uuid3,
> > >
> > >         count =3D partition_info.a2;
> > >
> > > +       if (drv_info->version > FFA_VERSION_1_0)
> > > +               size =3D partition_info.a3;
> >
> > What happens if this value is larger than sizeof(struct ffa_partition_inf=
o)?
> >
>
> Right, I had the check for both 0 size and size > struct size. I removed
> both at once instead of just dropping 0 size. I assume 0 size is non
> compliant or do you prefer to keep that check as well.

The purpose with this size field is to be able to read the known part
of each element in the array.
So I believe that memcpy() below should copy MIN(size, sizeof(struct
ffa_partition_info)), assuming that we update struct
ffa_partition_info if we need to when bumping our reported FF-A
version.

I'm not sure if we need more checks for compliance or not.

Cheers,
Jens

>
> Thanks a lot for the reviews.
>
> --
> Regards,
> Sudeep

--===============0192935354063393431==--

