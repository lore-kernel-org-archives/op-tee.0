From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH RFC 3/3] tee: introduce orphan tee_shm and default context
Date: Mon, 25 Nov 2024 13:21:26 +0530
Message-ID: 
 <CAFA6WYNbvxs-KRBkBxdD7M0Z=qLkT0ODDo-4_H5ZbZxqK4va7g@mail.gmail.com>
In-Reply-To: <
 <CAHUa44HZbODOx7N4+WiNjQwrjwo7T=bQfZ5N-EjoMmXnfC4-Lg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4536278613552102938=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4536278613552102938==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2024 at 12:53, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Mon, Nov 25, 2024 at 7:14=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Mon, 25 Nov 2024 at 03:00, Amirreza Zarrabi
> > <quic_azarrabi@quicinc.com> wrote:
> > >
> > >
> > > Hi Sumit,
> > >
> > > Thank you so much for the comemnts :).
> > >
> > > On 11/23/2024 9:32 PM, Sumit Garg wrote:
> > > > Hi Amirreza,
> > > >
> > > > Thanks for proposing this.
> > > >
> > > > On Fri, 22 Nov 2024 at 06:38, Amirreza Zarrabi
> > > > <quic_azarrabi@quicinc.com> wrote:
> > > >>
> > > >>
> > > >> On 11/21/2024 11:08 PM, Jens Wiklander wrote:
> > > >>
> > > >> Hi Jens,
> > > >>
> > > >>> Hi Amirreza,
> > > >>>
> > > >>> On Thu, Nov 21, 2024 at 2:37=E2=80=AFAM Amirreza Zarrabi
> > > >>> <quic_azarrabi@quicinc.com> wrote:
> > > >>>>
> > > >>>> The default context has a lifespan similar to the tee_device.
> > > >
> > > > Since it's associated with tee_device context, let's call it obvious
> > > > via renaming it as device context instead (s/def_ctx/dev_ctx/ in this
> > > > patch).
> > > >
> > >
> > > Make sense, I'll rename it.
> > >
> > > >>>> It is used as a context for shared memory if the context to which =
the
> > > >>>> shared memory belongs is released, making the tee_shm an orphan.
> > > >>>> This allows the driver implementing shm_unregister to safely make
> > > >>>> subsequent calls, such as to a supplicant if needed.
> > > >>>>
> > > >>>> It also enables users to free the shared memory while the driver is
> > > >>>> blocked on unregister_tee_device safely.
> > > >>>>
> > > >>>> Preferably, this should be used for all driver internal uses, using
> > > >>>> teedev_get_def_context rather than calling teedev_open.
> > > >
> > > > Makes sense to me.
> > > >
> > > >>>>
> > > >>>> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
> > > >>>> ---
> > > >>>>  drivers/tee/optee/core.c    |  2 +-
> > > >>>>  drivers/tee/optee/ffa_abi.c |  2 +-
> > > >>>>  drivers/tee/optee/smc_abi.c |  2 +-
> > > >>>>  drivers/tee/tee_core.c      | 83 +++++++++++++++++++++++++++++---=
-------------
> > > >>>>  drivers/tee/tee_private.h   |  3 --
> > > >>>>  drivers/tee/tee_shm.c       | 18 ++--------
> > > >>>>  include/linux/tee_core.h    | 15 ++++++++
> > > >>>>  include/linux/tee_drv.h     |  7 ----
> > > >>>>  8 files changed, 73 insertions(+), 59 deletions(-)
> > > >>>>
> > > >>>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > >>>> index c75fddc83576..78d43d0c8014 100644
> > > >>>> --- a/drivers/tee/optee/core.c
> > > >>>> +++ b/drivers/tee/optee/core.c
> > > >>>> @@ -173,7 +173,7 @@ void optee_remove_common(struct optee *optee)
> > > >>>>
> > > >>>>         optee_notif_uninit(optee);
> > > >>>>         optee_shm_arg_cache_uninit(optee);
> > > >>>> -       teedev_close_context(optee->ctx);
> > > >>>> +
> > > >>>>         /*
> > > >>>>          * The two devices have to be unregistered before we can f=
ree the
> > > >>>>          * other resources.
> > > >>>> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_a=
bi.c
> > > >>>> index f3af5666bb11..6ad94f0788ad 100644
> > > >>>> --- a/drivers/tee/optee/ffa_abi.c
> > > >>>> +++ b/drivers/tee/optee/ffa_abi.c
> > > >>>> @@ -949,7 +949,7 @@ static int optee_ffa_probe(struct ffa_device *=
ffa_dev)
> > > >>>>         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > > >>>>         mutex_init(&optee->rpmb_dev_mutex);
> > > >>>>         ffa_dev_set_drvdata(ffa_dev, optee);
> > > >>>> -       ctx =3D teedev_open(optee->teedev);
> > > >>>> +       ctx =3D teedev_get_def_context(optee->teedev);
> > > >>>>         if (IS_ERR(ctx)) {
> > > >>>>                 rc =3D PTR_ERR(ctx);
> > > >>>>                 goto err_rhashtable_free;
> > > >>>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_a=
bi.c
> > > >>>> index e9456e3e74cc..c77a3e631d04 100644
> > > >>>> --- a/drivers/tee/optee/smc_abi.c
> > > >>>> +++ b/drivers/tee/optee/smc_abi.c
> > > >>>> @@ -1722,7 +1722,7 @@ static int optee_probe(struct platform_devic=
e *pdev)
> > > >>>>         mutex_init(&optee->rpmb_dev_mutex);
> > > >>>>
> > > >>>>         platform_set_drvdata(pdev, optee);
> > > >>>> -       ctx =3D teedev_open(optee->teedev);
> > > >>>> +       ctx =3D teedev_get_def_context(optee->teedev);
> > > >>>>         if (IS_ERR(ctx)) {
> > > >>>>                 rc =3D PTR_ERR(ctx);
> > > >>>>                 goto err_supp_uninit;
> > > >>>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > > >>>> index 93f3b330aec8..805e1336089d 100644
> > > >>>> --- a/drivers/tee/tee_core.c
> > > >>>> +++ b/drivers/tee/tee_core.c
> > > >>>> @@ -57,7 +57,6 @@ struct tee_context *teedev_open(struct tee_devic=
e *teedev)
> > > >>>>                 goto err;
> > > >>>>         }
> > > >>>>
> > > >>>> -       kref_init(&ctx->refcount);
> > > >>>>         ctx->teedev =3D teedev;
> > > >>>>         INIT_LIST_HEAD(&ctx->list_shm);
> > > >>>>         rc =3D teedev->desc->ops->open(ctx);
> > > >>>> @@ -73,36 +72,43 @@ struct tee_context *teedev_open(struct tee_dev=
ice *teedev)
> > > >>>>  }
> > > >>>>  EXPORT_SYMBOL_GPL(teedev_open);
> > > >>>>
> > > >>>> -void teedev_ctx_get(struct tee_context *ctx)
> > > >>>> +struct tee_context *teedev_get_def_context(struct tee_device *tee=
dev)
> > > >>>>  {
> > > >>>> -       if (ctx->releasing)
> > > >>>> -               return;
> > > >>>> +       int rc;
> > > >>>> +       struct tee_context *ctx =3D &teedev->def_ctx;
> > > >>>>
> > > >>>> -       kref_get(&ctx->refcount);
> > > >>>> -}
> > > >>>> +       ctx->teedev =3D teedev;
> > > >>>> +       INIT_LIST_HEAD(&ctx->list_shm);
> > > >>>> +       rc =3D teedev->desc->ops->open(ctx);
> > > >>>> +       if (rc)
> > > >>>> +               return ERR_PTR(rc);
> > > >>>
> > > >>> I think ctx->teedev and ctx->list_shm must always be initialized or
> > > >>> &teedev->def_ctx can't be used in teedev_close_context().
> > > >>
> > > >> True, but &teedev->def_ctx is never used in teedev_close_context().
> > > >> The closing of the &teedev->def_ctx simply ignored. So once opened,
> > > >> &teedev->def_ctx will always remain open until the tee_device is ali=
ve.
> > > >>
> > > >>> We could initialize teedev->def_ctx on the first call to teedev_ope=
n()
> > > >>> on that tee_device. We need a way to tell the
> > > >>> teedev->desc->ops->open() to the backed driver that it's initializi=
ng
> > > >>> the default context though, or optee_open() can't handle the
> > > >>> tee-supplicant case properly.
> > > >>>
> > > >>
> > > >> That's a good point. This way, it is guaranteed that there is one de=
f_ctx
> > > >> per teedev. There should be a way to tell the open() callback that i=
t is
> > > >> a def_ctx, so it is not registered as a supplicant context.
> > > >>
> > > >>
> > > >>> Should we allow this function to be called more than once for each =
teedev?
> > > >>
> > > >> Yes, moving to teedev_open() will fix the issue.
> > > >>
> > > >>> Do we need serialization in this function if it's called after the
> > > >>> driver is probed?
> > > >>>
> > > >>
> > > >> True. I'll make sure there is no race.
> > > >>
> > > >>>>
> > > >>>> -static void teedev_ctx_release(struct kref *ref)
> > > >>>> -{
> > > >>>> -       struct tee_context *ctx =3D container_of(ref, struct tee_c=
ontext,
> > > >>>> -                                              refcount);
> > > >>>> -       ctx->releasing =3D true;
> > > >>>> -       ctx->teedev->desc->ops->release(ctx);
> > > >>>> -       kfree(ctx);
> > > >>>> +       return ctx;
> > > >>>>  }
> > > >>>> +EXPORT_SYMBOL_GPL(teedev_get_def_context);
> > > >>>>
> > > >>>> -void teedev_ctx_put(struct tee_context *ctx)
> > > >>>> +void teedev_close_context(struct tee_context *ctx)
> > > >>>>  {
> > > >>>> -       if (ctx->releasing)
> > > >>>> +       struct tee_device *teedev =3D ctx->teedev;
> > > >>>> +       struct tee_shm *shm;
> > > >>>> +
> > > >>>> +       if (ctx =3D=3D &teedev->def_ctx)
> > > >>>>                 return;
> > > >>>>
> > > >>>> -       kref_put(&ctx->refcount, teedev_ctx_release);
> > > >>>> -}
> > > >>>> +       teedev->desc->ops->release(ctx);
> > > >>>>
> > > >>>> -void teedev_close_context(struct tee_context *ctx)
> > > >>>> -{
> > > >>>> -       struct tee_device *teedev =3D ctx->teedev;
> > > >>>> +       mutex_lock(&teedev->mutex);
> > > >>>> +       list_for_each_entry(shm, &ctx->list_shm, link) {
> > > >>>> +               /* Context released. However, shm still holding a =
teedev reference.
> > > >>>> +                * Replace shm->ctx with the default context so th=
at tee_shm_get_from_id()
> > > >>>> +                * fails (i.e. it is not accessible from userspace=
) but shm still
> > > >>>> +                * holds a valid context for further clean up, e.g=
. shm_unregister().
> > > >>>> +                */
> > > >>>
> > > >>> /*
> > > >>>  * Please format
> > > >>>  * multiline comments
> > > >>>  * like this. Please
> > > >>>  * keep the lines at
> > > >>>  * max 80 columns
> > > >>>  * here and at other
> > > >>>  * places in the patch-
> > > >>>  * set.
> > > >>>  */
> > > >>>
> > > >>
> > > >> Ack.
> > > >>
> > > >>>> +               shm->ctx =3D &teedev->def_ctx;
> > > >>>
> > > >>> shm->ctx will always point to a valid context, even if it is the
> > > >>> default context. It seems that we can always get hold of the correct
> > > >>> teedev via shm->ctx->teedev. Do we need "tee: revert removal of
> > > >>> redundant teedev in struct tee_shm"?
> > > >>>
> > > >>
> > > >> It was there in case we wanted to use NULL, but with def_ctx, it is =
not
> > > >> necessary. I am withdrawing that commit. :).
> > > >>
> > > >>> Shouldn't the shm be removed from the ctx->list_shm and be moved to
> > > >>> teedev->def_ctx.list_shm?
> > > >
> > > > +1
> > > >
> > >
> > > Ack.
> > >
> > > >>>
> > > >>
> > > >> Not really. If we put shm in the teedev->def_ctx.list_shm, by the ti=
me
> > > >> we are closing the def_ctx, the list is guaranteed to be empty.
> > > >>
> > > >> However, I understand it is cleaner and more consistent to do that r=
ather
> > > >> than making changes to tee_shm_put().
> > > >>
> > > >> I'll do it.
> > > >>
> > > >>>> +       }
> > > >>>> +       mutex_unlock(&teedev->mutex);
> > > >>>>
> > > >>>> -       teedev_ctx_put(ctx);
> > > >>>> +       kfree(ctx);
> > > >>>>         tee_device_put(teedev);
> > > >>>>  }
> > > >>>>  EXPORT_SYMBOL_GPL(teedev_close_context);
> > > >>>> @@ -946,6 +952,8 @@ struct tee_device *tee_device_alloc(const stru=
ct tee_desc *teedesc,
> > > >>>>
> > > >>>>         teedev->desc =3D teedesc;
> > > >>>>         teedev->pool =3D pool;
> > > >>>> +       /* Only open default context when teedev_get_def_context()=
 called. */
> > > >>>> +       teedev->def_ctx.teedev =3D NULL;
> > > >
> > > > Why don't you open the device context here only? This will associate
> > > > it automatically with teedev lifespan and then
> > > > teedev_get_def_context() will just return a reference to that.
> > > >
> > > > -Sumit
> > > >
> > >
> > > So my assumption is that the tee_devic_alloc() is called as part of
> > > the driver initialization; there is no guarantee that at this time the
> > > driver is actually ready to accept any open() callback.
> > >
> >
> > The drivers should be able to handle open() callback since we already
> > check for !teedesc->ops->open in the beginning of tee_devic_alloc().
> > Also, we need to open a device context for !TEE_DESC_PRIVILEGED such
> > that we don't open a supplicant device context there.
>
> It would be nice to have the device context fully initialized when the
> probe function returns. How about adding a "bool is_dev_ctx" to struct
> tee_context so the open() callback can tell that this is a special
> tee_contex?

Sure, that will be useful to distinguish the device context from
normal client context.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit

--===============4536278613552102938==--

