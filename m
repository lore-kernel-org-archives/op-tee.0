From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add support for supplicant timeout
Date: Wed, 18 Dec 2024 16:37:12 +0530
Message-ID: 
 <CAFA6WYNtssUu-43anMG_HsZe8TZtQK_2SpRd0X1tx_zUsar45A@mail.gmail.com>
In-Reply-To: <
 <CAHUa44FtwstZzLOA4k_-nuXrs298_d+piA+_rkAVXswp6dxHxg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8508936045032417095=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8508936045032417095==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Dec 2024 at 16:02, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Wed, Dec 18, 2024 at 8:30=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > + Erik
> >
> > Hi Jens,
> >
> > On Wed, 18 Dec 2024 at 12:27, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Fri, Dec 13, 2024 at 12:15=E2=80=AFPM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> > > >
> > > > OP-TEE supplicant is a user-space daemon and it's possible for it
> > > > being crashed or killed in the middle of processing an OP-TEE RPC cal=
l.
> > > > It becomes more complicated when there is incorrect shutdown ordering
> > > > of the supplicant process vs the OP-TEE client application which can
> > > > eventually lead to system hang-up waiting for the closure of the clie=
nt
> > > > application.
> > > >
> > > > In order to gracefully handle this scenario, let's add a long enough
> > > > timeout to wait for supplicant to process requests. In case there is a
> > > > timeout then we return a proper error code for the RPC request.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  drivers/tee/optee/supp.c | 58 +++++++++++++++++++++++++-------------=
--
> > > >  1 file changed, 36 insertions(+), 22 deletions(-)
> > > >
> > > > diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> > > > index 322a543b8c27..92e86ac4cdd4 100644
> > > > --- a/drivers/tee/optee/supp.c
> > > > +++ b/drivers/tee/optee/supp.c
> > > > @@ -7,6 +7,15 @@
> > > >  #include <linux/uaccess.h>
> > > >  #include "optee_private.h"
> > > >
> > > > +/*
> > > > + * OP-TEE supplicant timeout, the user-space supplicant may get
> > > > + * crashed or killed while servicing an RPC call. This will just lead
> > > > + * to OP-TEE client hung indefinitely just waiting for supplicant to
> > > > + * serve requests which isn't expected. It is rather expected to fail
> > > > + * gracefully with a timeout which is long enough.
> > > > + */
> > > > +#define SUPP_TIMEOUT   (msecs_to_jiffies(10000))
> > > > +
> > > >  struct optee_supp_req {
> > > >         struct list_head link;
> > > >
> > > > @@ -52,8 +61,10 @@ void optee_supp_release(struct optee_supp *supp)
> > > >
> > > >         /* Abort all queued requests */
> > > >         list_for_each_entry_safe(req, req_tmp, &supp->reqs, link) {
> > > > -               list_del(&req->link);
> > > > -               req->in_queue =3D false;
> > > > +               if (req->in_queue) {
> > > > +                       list_del(&req->link);
> > > > +                       req->in_queue =3D false;
> > > > +               }
> > > >                 req->ret =3D TEEC_ERROR_COMMUNICATION;
> > > >                 complete(&req->c);
> > > >         }
> > > > @@ -82,6 +93,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u3=
2 func, size_t num_params,
> > > >         struct optee_supp_req *req;
> > > >         bool interruptable;
> > > >         u32 ret;
> > > > +       int res =3D 1;
> > > >
> > > >         /*
> > > >          * Return in case there is no supplicant available and
> > > > @@ -108,28 +120,28 @@ u32 optee_supp_thrd_req(struct tee_context *ctx=
, u32 func, size_t num_params,
> > > >         /* Tell an eventual waiter there's a new request */
> > > >         complete(&supp->reqs_c);
> > > >
> > > > -       /*
> > > > -        * Wait for supplicant to process and return result, once we'=
ve
> > > > -        * returned from wait_for_completion(&req->c) successfully we=
 have
> > > > -        * exclusive access again.
> > > > -        */
> > > > -       while (wait_for_completion_interruptible(&req->c)) {
> > > > +       /* Wait for supplicant to process and return result */
> > > > +       while (res) {
> > > > +               res =3D wait_for_completion_interruptible_timeout(&re=
q->c,
> > > > +                                                               SUPP_=
TIMEOUT);
> > > > +               /* Check if supplicant served the request */
> > > > +               if (res > 0)
> > > > +                       break;
> > > > +
> > > >                 mutex_lock(&supp->mutex);
> > > > +               /*
> > > > +                * There's no supplicant available and since the supp=
->mutex
> > > > +                * currently is held none can become available until =
the mutex
> > > > +                * released again.
> > > > +                *
> > > > +                * Interrupting an RPC to supplicant is only allowed =
as a way
> > > > +                * of slightly improving the user experience in case =
the
> > > > +                * supplicant hasn't been started yet. During normal =
operation
> > > > +                * the supplicant will serve all requests in a timely=
 manner and
> > > > +                * interrupting then wouldn't make sense.
> > > > +                */
> > > >                 interruptable =3D !supp->ctx;
> > > > -               if (interruptable) {
> > > > -                       /*
> > > > -                        * There's no supplicant available and since =
the
> > > > -                        * supp->mutex currently is held none can
> > > > -                        * become available until the mutex released
> > > > -                        * again.
> > > > -                        *
> > > > -                        * Interrupting an RPC to supplicant is only
> > > > -                        * allowed as a way of slightly improving the=
 user
> > > > -                        * experience in case the supplicant hasn't b=
een
> > > > -                        * started yet. During normal operation the s=
upplicant
> > > > -                        * will serve all requests in a timely manner=
 and
> > > > -                        * interrupting then wouldn't make sense.
> > > > -                        */
> > > > +               if (interruptable || (res =3D=3D 0)) {
> > >
> > > Are you fixing an observed problem or a theoretical one?
> >
> > It is an observed problem, I was able to reproduce it using following
> > sequence with OP-TEE buildroot setup:
> >
> > $ xtest 600 &  // Run some secure storage tests using supplicant in
> > the background
> > $ kill -9 `pidof tee-supplicant` // Kill supplicant when the tests are
> > in progress.
> >
> > This will cause the xtest to hang up.
> >
> > > If the
> > > supplicant has died then "interruptable" is expected to be true so the
> > > timeout shouldn't matter.
> >
> > When the supplicant dies, it doesn't lead to releasing the supplicant
> > context in the above test scenario. The reason is probably the
> > supplicant shared memory reference is held by OP-TEE which is in turn
> > is holding a reference to supplicant context.
>
> This sounds like the problem Amirreza is trying to solve for the
> QCOMTEE driver. If we could get the supplicant context removed soon
> after the supplicant has died we wouldn't need this, except that we
> may need some trick to avoid ignoring an eventual signal received
> while tee-supplicant is dying.

That would be an improvement but it may still get unnoticed in future
once something else starts ref counting the supplicant context.

>
> Wait, would it work to break the loop on SIGKILL? It's an uncatchable
> signal so there's no reason for the calling process to wait anyway.

I agree this can be one way to solve the issue when the supplicant
gets killed but what if the supplicant gets crashed then it will be
another signal to handle. This approach sounds error prone to me as we
might miss a corner case.

So the question here is why do we need an infinite wait loop for the
supplicant which breaks only if we receive events from the user-space?
Isn't it rather robust for the kernel to have a bounded supplicant
wait loop? Do you have any particular use-case where this bounded wait
loop won't suffice?

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >
> > > Cheers,
> > > Jens
> > >
> > > >                         if (req->in_queue) {
> > > >                                 list_del(&req->link);
> > > >                                 req->in_queue =3D false;
> > > > @@ -141,6 +153,8 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, =
u32 func, size_t num_params,
> > > >                         req->ret =3D TEEC_ERROR_COMMUNICATION;
> > > >                         break;
> > > >                 }
> > > > +               if (res =3D=3D 0)
> > > > +                       req->ret =3D TEE_ERROR_TIMEOUT;
> > > >         }
> > > >
> > > >         ret =3D req->ret;
> > > > --
> > > > 2.43.0
> > > >

--===============8508936045032417095==--

