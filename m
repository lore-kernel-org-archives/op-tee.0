From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 2/3] optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
Date: Tue, 05 Apr 2022 16:51:13 +0200
Message-ID: 
 <CAHUa44Fr+q6AxAPrYfb4wV3+ZdkX4zd+u8SOv6XoAXsWOB0aZg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPe2C6Zu0P9NX3X6dGqBs_HSNLYe_1qrW_QiikuKFRoOA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7900503526923271441=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7900503526923271441==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Tue, Apr 5, 2022 at 2:26 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> Apologies for the delay as I was on leave for the past 2 weeks.

No worries, quite understandable.

>
> On Fri, 18 Mar 2022 at 13:19, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Thu, Mar 17, 2022 at 1:17 PM Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > >
> > > On Wed, 16 Mar 2022 at 14:57, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > On Mon, Mar 14, 2022 at 02:33:26PM +0530, Sumit Garg wrote:
> > > > > On Wed, 2 Mar 2022 at 01:18, Jens Wiklander <jens.wiklander@linar=
o.org> wrote:
> > > > > >
> > > > > > Adds the secure capability OPTEE_FFA_SEC_CAP_ARG_OFFSET to indica=
te that
> > > > > > OP-TEE with FF-A can support an argument struct at a non-zero off=
set into
> > > > > > a passed shared memory object.
> > > > > >
> > > > >
> > > > > It isn't clear to me why FF-A ABI requires this capability.
> > > > > shm->offset should be honoured by default, if it isn't then it's a
> > > > > bug.
> > > >
> > > > Yes, there was a bug in secure world when using a non-zero offset. So
> > > > far the driver has always used a zero offset that's why it hasn't been
> > > > caught earlier.
> > > >
> > > > It's not a serious bug, but it might be quite hard to track down. This
> > > > is of course fixed now, but there is a window where it can be trigger=
ed.
> > >
> > > I am not able to find the fix in this [1] OP-TEE OS commit. Could you
> > > help me to point it out?
> > >
> > > [1] https://github.com/OP-TEE/optee_os/commit/89d991352352b80ae90f82228=
a014bb8cadfb80b
> >
> > I believe it's this one:
> > https://github.com/OP-TEE/optee_os/commit/7267624eef019476f20aee7dba11ff9=
49d005670
> >
>
> Which OP-TEE release is affected by this where FF-A functionality is
> fully supported?

3.10.0 to 3.15.0, I'm note sure where to draw the line for fully
supported. But it would be a pity to break 3.14.0 and 3.15.0.

>
> > >
> > > >
> > > > So in order to spare FF-A developers this problem I'm making a non-ze=
ro
> > > > offset an extension guarded by a capability bit. Even though this is =
an
> > > > ABI change it's in practice not since it has been unused and not work=
ing
> > > > as expected.
> > > >
> > > > The next commit will start using non-zero offsets if supported, so th=
is
> > > > will change to become a problem (if left unchecked) in the window
> > > > mentioned above.
> > > >
> > > > > AFAIK, FF-A is currently still in its early stages so it
> > > > > shouldn't be that hard to fix bugs in the ABI.
> > > >
> > > > Starting from the kernel release (v5.16) where FF-A support in this
> > > > driver was merged the ABI is supposed to be stable.
> > > >
> > >
> > > From Linux kernel perspective, there are dedicated stable branches for
> > > that purpose in case we want to push a fix for OP-TEE FF-A kernel
> > > driver.
> >
> > The problem isn't in the kernel driver. What I'm doing here is to
> > formalize the ABI that the kernel defacto was using. Since we
> > obviously didn't test the driver with a non-zero offset before, we
> > didn't notice that the offset wasn't used in the right way by the
> > secure world.
>
> My understanding of capabilities is to denote new features rather than
> bug fixes.

If you take the pragmatic approach to this it could be seen as a new
feature, this part of the ABI wasn't used before and had obviously not
been tested either. The only place where it did exist before was in a
comment.

> So I am still not able to make any sense regarding why we
> are abusing capabilities to fix bugs in the ABI. If we find more bugs
> in the FF-A ABI in future then we will be stuck adding new
> capabilities which aren't scalable and unnecessarily complicates
> kernel driver.

This is a balance act, in this case I believe it's worth it. It
doesn't leave any strange artefacts in the ABI.

Others are using OP-TEE for FF-A development without knowing too many
details of how this part works. So breakage here could cause a bit of
trouble for those developers and also give the impression that we
don't care if we break things.

>
> IMO, the best way to maintain a stable ABI would be to create a stable
> release for OP-TEE as well where ABI fixes can be backported.

I disagree, breakage is breakage.

> But
> since we don't have that currently, we have to live with cherry
> picking ABI fixes if we observe issues with earlier OP-TEE releases.

We have so far had zero requests to keep stable branches. I don't
think they would have helped in this case anyway.

Cheers,
Jens

>
> -Sumit
>
> >
> > Cheers,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > > Thanks,
> > > > Jens
> > > >
> > > > >
> > > > > -Sumit
> > > > >
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > ---
> > > > > >  drivers/tee/optee/ffa_abi.c   | 17 +++++++++++++++--
> > > > > >  drivers/tee/optee/optee_ffa.h | 12 +++++++++++-
> > > > > >  2 files changed, 26 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_=
abi.c
> > > > > > index 7686f7020616..cc863aaefcd9 100644
> > > > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > > > @@ -615,12 +615,21 @@ static int optee_ffa_do_call_with_arg(struc=
t tee_context *ctx,
> > > > > >                 .data0 =3D OPTEE_FFA_YIELDING_CALL_WITH_ARG,
> > > > > >                 .data1 =3D (u32)shm->sec_world_id,
> > > > > >                 .data2 =3D (u32)(shm->sec_world_id >> 32),
> > > > > > -               .data3 =3D shm->offset,
> > > > > > +               .data3 =3D 0,
> > > > > >         };
> > > > > >         struct optee_msg_arg *arg;
> > > > > >         unsigned int rpc_arg_offs;
> > > > > >         struct optee_msg_arg *rpc_arg;
> > > > > >
> > > > > > +       /*
> > > > > > +        * The shared memory object has to start on a page when p=
assed as
> > > > > > +        * an argument struct. This is also what the shm pool all=
ocator
> > > > > > +        * returns, but check this before calling secure world to=
 catch
> > > > > > +        * eventual errors early in case something changes.
> > > > > > +        */
> > > > > > +       if (shm->offset)
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > >         arg =3D tee_shm_get_va(shm, 0);
> > > > > >         if (IS_ERR(arg))
> > > > > >                 return PTR_ERR(arg);
> > > > > > @@ -678,6 +687,7 @@ static bool optee_ffa_api_is_compatbile(struc=
t ffa_device *ffa_dev,
> > > > > >
> > > > > >  static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> > > > > >                                     const struct ffa_dev_ops *ops,
> > > > > > +                                   u32 *sec_caps,
> > > > > >                                     unsigned int *rpc_param_count)
> > > > > >  {
> > > > > >         struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE=
_CAPABILITIES };
> > > > > > @@ -694,6 +704,7 @@ static bool optee_ffa_exchange_caps(struct ff=
a_device *ffa_dev,
> > > > > >         }
> > > > > >
> > > > > >         *rpc_param_count =3D (u8)data.data1;
> > > > > > +       *sec_caps =3D data.data2;
> > > > > >
> > > > > >         return true;
> > > > > >  }
> > > > > > @@ -777,6 +788,7 @@ static int optee_ffa_probe(struct ffa_device =
*ffa_dev)
> > > > > >         struct tee_device *teedev;
> > > > > >         struct tee_context *ctx;
> > > > > >         struct optee *optee;
> > > > > > +       u32 sec_caps;
> > > > > >         int rc;
> > > > > >
> > > > > >         ffa_ops =3D ffa_dev_ops_get(ffa_dev);
> > > > > > @@ -788,7 +800,8 @@ static int optee_ffa_probe(struct ffa_device =
*ffa_dev)
> > > > > >         if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > > -       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param=
_count))
> > > > > > +       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> > > > > > +                                    &rpc_param_count))
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > >         optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
> > > > > > diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/op=
tee_ffa.h
> > > > > > index ee3a03fc392c..97266243deaa 100644
> > > > > > --- a/drivers/tee/optee/optee_ffa.h
> > > > > > +++ b/drivers/tee/optee/optee_ffa.h
> > > > > > @@ -81,8 +81,16 @@
> > > > > >   *                   as the second MSG arg struct for
> > > > > >   *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
> > > > > >   *        Bit[31:8]: Reserved (MBZ)
> > > > > > - * w5-w7: Note used (MBZ)
> > > > > > + * w5:   Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP=
_* below,
> > > > > > + *       unused bits MBZ.
> > > > > > + * w6-w7: Not used (MBZ)
> > > > > > + */
> > > > > > +/*
> > > > > > + * Secure world supports giving an offset into the argument shar=
ed memory
> > > > > > + * object, see also OPTEE_FFA_YIELDING_CALL_WITH_ARG
> > > > > >   */
> > > > > > +#define OPTEE_FFA_SEC_CAP_ARG_OFFSET   BIT(0)
> > > > > > +
> > > > > >  #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(=
2)
> > > > > >
> > > > > >  /*
> > > > > > @@ -112,6 +120,8 @@
> > > > > >   *       OPTEE_MSG_GET_ARG_SIZE(num_params) follows a struct opt=
ee_msg_arg
> > > > > >   *       for RPC, this struct has reserved space for the number =
of RPC
> > > > > >   *       parameters as returned by OPTEE_FFA_EXCHANGE_CAPABILITI=
ES.
> > > > > > + *       MBZ unless the bit OPTEE_FFA_SEC_CAP_ARG_OFFSET is rece=
ived with
> > > > > > + *       OPTEE_FFA_EXCHANGE_CAPABILITIES.
> > > > > >   * w7:    Not used (MBZ)
> > > > > >   * Resume from RPC. Register usage:
> > > > > >   * w3:    Service ID, OPTEE_FFA_YIELDING_CALL_RESUME
> > > > > > --
> > > > > > 2.31.1
> > > > > >

--===============7900503526923271441==--

