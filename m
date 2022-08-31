From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 6/9] firmware: arm_ffa: Make memory apis ffa_device independent
Date: Wed, 31 Aug 2022 13:26:56 +0100
Message-ID: <20220831122656.255o7a7yio5uuik2@bogus>
In-Reply-To: <
 <CAFA6WYOcHGRwkt6PKFEm9did=hO-e1eukK_1M-NWT=79jMS9WQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3701582761774019791=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3701582761774019791==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 31, 2022 at 04:16:09PM +0530, Sumit Garg wrote:
> Hi Sudeep,
>=20
> On Tue, 30 Aug 2022 at 15:39, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > There is a requirement to make memory APIs independent of the ffa_device.
> > One of the use-case is to have a common memory driver that manages the
> > memory for all the ffa_devices. That commom memory driver won't be a
>=20
> s/commom/common/
>=20
> > ffa_driver or won't have any ffa_device associated with it. So having
> > these memory APIs accessible without a ffa_device is needed and should
> > be possible as most of these are handled by the partition manager(SPM
> > or hypervisor).
> >
> > Drop the ffa_device argument to the memory APIs and make them ffa_device
> > independent.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 6 ++----
> >  drivers/tee/optee/ffa_abi.c       | 2 +-
> >  include/linux/arm_ffa.h           | 6 ++----
> >  3 files changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa=
/driver.c
> > index 5f02b670e964..5c8484b05c50 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -640,8 +640,7 @@ static int ffa_sync_send_receive(struct ffa_device *d=
ev,
> >                                        dev->mode_32bit, data);
> >  }
> >
> > -static int
> > -ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
> > +static int ffa_memory_share(struct ffa_mem_ops_args *args)
> >  {
> >         if (drv_info->mem_ops_native)
> >                 return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
> > @@ -649,8 +648,7 @@ ffa_memory_share(struct ffa_device *dev, struct ffa_m=
em_ops_args *args)
> >         return ffa_memory_ops(FFA_MEM_SHARE, args);
> >  }
> >
> > -static int
> > -ffa_memory_lend(struct ffa_device *dev, struct ffa_mem_ops_args *args)
> > +static int ffa_memory_lend(struct ffa_mem_ops_args *args)
> >  {
> >         /* Note that upon a successful MEM_LEND request the caller
> >          * must ensure that the memory region specified is not accessed
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 4c3b5d0008dd..7ec0a2f9a63b 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -294,7 +294,7 @@ static int optee_ffa_shm_register(struct tee_context =
*ctx, struct tee_shm *shm,
> >         if (rc)
> >                 return rc;
> >         args.sg =3D sgt.sgl;
> > -       rc =3D ffa_ops->memory_share(ffa_dev, &args);
> > +       rc =3D ffa_ops->memory_share(&args);
> >         sg_free_table(&sgt);
> >         if (rc)
> >                 return rc;
> > diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> > index 556f50f27fb1..eafab07c9f58 100644
> > --- a/include/linux/arm_ffa.h
> > +++ b/include/linux/arm_ffa.h
> > @@ -262,10 +262,8 @@ struct ffa_dev_ops {
> >         int (*sync_send_receive)(struct ffa_device *dev,
> >                                  struct ffa_send_direct_data *data);
> >         int (*memory_reclaim)(u64 g_handle, u32 flags);
> > -       int (*memory_share)(struct ffa_device *dev,
> > -                           struct ffa_mem_ops_args *args);
> > -       int (*memory_lend)(struct ffa_device *dev,
> > -                          struct ffa_mem_ops_args *args);
> > +       int (*memory_share)(struct ffa_mem_ops_args *args);
> > +       int (*memory_lend)(struct ffa_mem_ops_args *args);
> >  };
> >
>=20
> Since these are included under "struct ffa_dev_ops", wouldn't it be
> better to rename the struct (ffa_ops?) as well?
>

Makes sense, I just avoided churn. But now I think there is some churn
anyways, so I am happy to rename.

--=20
Regards,
Sudeep

--===============3701582761774019791==--

