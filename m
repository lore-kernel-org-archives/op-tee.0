From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: optee: Fix missing devices unregister during optee_remove
Date: Wed, 13 Oct 2021 14:26:35 +0200
Message-ID: 
 <CAHUa44FO1WWpDEad=+C-OEQa1yLktChFkXgrTz5==NvYD4uTVA@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYMcKLPj-ZHSBHPeg4TPmzutf-7VTffMyMbv+7ax+uJf1w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6001861723215231169=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6001861723215231169==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2021 at 10:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> On Tue, 12 Oct 2021 at 13:29, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Hi Sumit,
> >
> > On Tue, Oct 12, 2021 at 9:31 AM Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > >
> > > When OP-TEE driver is built as a module, OP-TEE client devices
> > > registered on TEE bus during probe should be unregistered during
> > > optee_remove. So implement optee_unregister_devices() accordingly.
> > >
> > > Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration suppor=
t")
> > > Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  drivers/tee/optee/core.c          |  3 +++
> > >  drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
> > >  drivers/tee/optee/optee_private.h |  1 +
> > >  3 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index ccad3c7c8f6d..3915dc574503 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pde=
v)
> > >  {
> > >         struct optee *optee =3D platform_get_drvdata(pdev);
> > >
> > > +       /* Unregister OP-TEE specific client devices on TEE bus */
> > > +       optee_unregister_devices();
> > > +
> > >         /*
> > >          * Ask OP-TEE to free all cached shared memory objects to decre=
ase
> > >          * reference counters and also avoid wild pointers in secure wo=
rld
> > > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > > index ec1d24693eba..128a2d2a50a1 100644
> > > --- a/drivers/tee/optee/device.c
> > > +++ b/drivers/tee/optee/device.c
> > > @@ -53,6 +53,13 @@ static int get_devices(struct tee_context *ctx, u32 =
session,
> > >         return 0;
> > >  }
> > >
> > > +static void optee_release_device(struct device *dev)
> > > +{
> > > +       struct tee_client_device *optee_device =3D to_tee_client_device=
(dev);
> > > +
> > > +       kfree(optee_device);
> > > +}
> > > +
> > >  static int optee_register_device(const uuid_t *device_uuid)
> > >  {
> > >         struct tee_client_device *optee_device =3D NULL;
> > > @@ -63,6 +70,7 @@ static int optee_register_device(const uuid_t *device=
_uuid)
> > >                 return -ENOMEM;
> > >
> > >         optee_device->dev.bus =3D &tee_bus_type;
> > > +       optee_device->dev.release =3D optee_release_device;
> > >         if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uu=
id)) {
> > >                 kfree(optee_device);
> > >                 return -ENOMEM;
> > > @@ -154,3 +162,17 @@ int optee_enumerate_devices(u32 func)
> > >  {
> > >         return  __optee_enumerate_devices(func);
> > >  }
> > > +
> > > +static int __optee_unregister_device(struct device *dev, void *data)
> > > +{
> > > +       if (!strncmp(dev_name(dev), "optee-ta", strlen("optee-ta")))
>
> The issue you described below should be handled by this check as we
> would register TAs with unique name corresponding to each OP-TEE
> driver.
>
> > > +               device_unregister(dev);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +void optee_unregister_devices(void)
> > > +{
> > > +       bus_for_each_dev(&tee_bus_type, NULL, NULL,
> > > +                        __optee_unregister_device);
> >
> > I had something like this in mind too, but there's one potential
> > problem with this approach. What if there's more than one OP-TEE
> > driver with TAs here? It seems that we'll remove TAs from other
> > drivers too then.
>
> We should be able to easily differentiate among TAs associated with
> any of multiple OP-TEE drivers based on their unique device name.
>
> >
> > This is not likely to be a problem at upstream for the moment so I
> > might be enough just to keep this in mind if/when the OP-TEE driver is
> > extended in a way that there can be multiple OP-TEEs handled.
> >
>
> Given above comments, I think it should be easily handled.

OK, thanks. The patch looks good and it works when testing it on the
upstream kernel and also with the FF-A patch set.
I'm picking up this now.

Cheers,
Jens

--===============6001861723215231169==--

