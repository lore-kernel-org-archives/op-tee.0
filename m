From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 5/6] optee: separate notification functions
Date: Wed, 13 Oct 2021 15:42:53 +0200
Message-ID: 
 <CAHUa44E9jLYsMd1LPVJTDXyCkT==EW7s-nHn3rYRx30gyBU8=g@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNdebJKoWZdQRPc=OdmaA=_jiguz12gfyHsdozbdx45vQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4780159665545645758=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4780159665545645758==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 9:15 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 6 Oct 2021 at 12:46, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > Renames struct optee_wait_queue to struct optee_notif and all related
> > functions to optee_notif_*().
> >
> > The implementation is changed to allow sending a notification from an
> > atomic state, that is from the top half of an interrupt handler.
> >
> > Waiting for keys is currently only used when secure world is waiting for
> > a mutex or condition variable. The old implementation could handle any
> > 32-bit key while this new implementation is restricted to only 8 bits or
> > the maximum value 255. A upper value is needed since a bitmap is
> > allocated to allow an interrupt handler to only set a bit in case the
> > waiter hasn't had the time yet to allocate and register a completion.
> >
> > The keys are currently only representing secure world threads which
> > number usually are never even close to 255 so it should be safe for now.
> > In future ABI updates the maximum value of the key will be communicated
> > while the driver is initializing.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/Makefile        |   1 +
> >  drivers/tee/optee/core.c          |  12 ++-
> >  drivers/tee/optee/notif.c         | 125 ++++++++++++++++++++++++++++++
> >  drivers/tee/optee/optee_private.h |  19 +++--
> >  drivers/tee/optee/optee_rpc_cmd.h |  31 ++++----
> >  drivers/tee/optee/rpc.c           |  73 ++---------------
> >  6 files changed, 170 insertions(+), 91 deletions(-)
> >  create mode 100644 drivers/tee/optee/notif.c
> >
>
> Apart from minor nit below:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>
> > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > index 3aa33ea9e6a6..df55e4ad5370 100644
> > --- a/drivers/tee/optee/Makefile
> > +++ b/drivers/tee/optee/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_OPTEE) +=3D optee.o
> >  optee-objs +=3D core.o
> >  optee-objs +=3D call.o
> > +optee-objs +=3D notif.o
> >  optee-objs +=3D rpc.o
> >  optee-objs +=3D supp.o
> >  optee-objs +=3D shm_pool.o
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 5ce13b099d7d..8531184f98f4 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -592,6 +592,7 @@ static int optee_remove(struct platform_device *pdev)
> >          */
> >         optee_disable_shm_cache(optee);
> >
> > +       optee_notif_uninit(optee);
> >         /*
> >          * The two devices have to be unregistered before we can free the
> >          * other resources.
> > @@ -602,7 +603,6 @@ static int optee_remove(struct platform_device *pdev)
> >         tee_shm_pool_free(optee->pool);
> >         if (optee->memremaped_shm)
> >                 memunmap(optee->memremaped_shm);
> > -       optee_wait_queue_exit(&optee->wait_queue);
> >         optee_supp_uninit(&optee->supp);
> >         mutex_destroy(&optee->call_queue.mutex);
> >
> > @@ -712,11 +712,17 @@ static int optee_probe(struct platform_device *pdev)
> >
> >         mutex_init(&optee->call_queue.mutex);
> >         INIT_LIST_HEAD(&optee->call_queue.waiters);
> > -       optee_wait_queue_init(&optee->wait_queue);
> >         optee_supp_init(&optee->supp);
> >         optee->memremaped_shm =3D memremaped_shm;
> >         optee->pool =3D pool;
> >
> > +       platform_set_drvdata(pdev, optee);
> > +       rc =3D optee_notif_init(optee, 255);
>
> nit: Can you use a macro here instead of a constant with a proper
> comment similar to the one in commit description?

OK, I'll fix.

Thanks,
Jens

--===============4780159665545645758==--

