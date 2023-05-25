From: Etienne CARRIERE <etienne.carriere@st.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH v9 3/4] tee: optee: support tracking system threads
Date: Thu, 25 May 2023 11:48:00 +0000
Message-ID: <PAXPR10MB468715EB2B1DFE080F380266FD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <
 <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3153312161982424564=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3153312161982424564==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>
> De : Sumit Garg <sumit.garg@linaro.org>
> Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> > Hello Sumit,
> >
> >
> > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > >
> > > Adds support in the OP-TEE driver to keep track of reserved system
> > > threads. The optee_cq_*() functions are updated to handle this if
> > > enabled. The SMC ABI part of the driver enables this tracking, but the
> > > FF-A ABI part does not.
> > >
> > > The logic allows atleast 1 OP-TEE thread can be reserved to TEE system
> > > sessions. For sake of simplicity, initialization of call queue
> > > management is factorized into new helper function optee_cq_init().
> > >
> > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >
> > > Disclaimer: Compile tested only
> > >
> > > Hi Etienne,
> > >
> > > Overall the idea we agreed upon was okay but the implementation looked
> > > complex to me. So I thought it would be harder to explain that via
> > > review and I decided myself to give a try at simplification. I would
> > > like you to test it if this still addresses the SCMI deadlock problem or
> > > not. Also, feel free to include this in your patchset if all goes fine
> > > wrt testing.
> >
> > With these changes, there is no more a specific waiting list for TEE
> > system threads hence when a waiting queue can complete, we'll pick any
> > TEE thread, not a TEE system thread first..
>
> I had thought about this but I can't see any value in having a
> separate wait queue for system threads. Here we only need to provide
> an extra privileged thread for system sessions (kernel clients) such
> that user-space doesn't contend for that thread. This prevents kernel
> client's starvation or deadlock like in the SCMI case.
>
> > Also, as stated in a below answer, these change unconditionally
> > reserve a TEE thread for TEE system calls even if no TEE client
> > reserved such.
>
> I don't think we should make thread reservations based on the presence
> of TEE clients. You never know how much user-space or kernel TEE
> clients you are dealing with. And reserving a single privileged thread
> unconditionally for system sessions shouldn't be much of a burden for
> memory constrained devices too.
>
> Also, this way we would enable every kernel TEE client to leverage
> system sessions as it's very likely they wouldn't like to compete with
> user-space for thread availability. Two other kernel TEE clients that
> are on top of my head are HWRNG and Trusted Keys which can benefit
> from this feature.

Trusted Keys is an interesting use case. When OP-TEE accesses Trusted Keys, i=
t may need to access the eMMC/RPMB using the Linux OS tee-supplicant whichj m=
ay repuire an eMMC clock or voltage regulator to be enabled. If that clock or=
 regulator is under an SCMI control, then we need 2 reserved TEE thread: one =
for invoking the Trusted Key TA and another for the SCMI request to reach the=
 TEE will the Trusted Key TA invocation still consumes a thread.

BR,
Etienne

>
> > >
> > > Changes since v8:
> > > - Simplified system threads tracking implementation.
> > >
> > >  drivers/tee/optee/call.c          | 72 +++++++++++++++++++++++++++++--
> > >  drivers/tee/optee/ffa_abi.c       |  3 +-
> > >  drivers/tee/optee/optee_private.h | 16 +++++++
> > >  drivers/tee/optee/smc_abi.c       | 16 ++++++-
> > >  4 files changed, 99 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > > index 42e478ac6ce1..09e824e4dcaf 100644
> > > --- a/drivers/tee/optee/call.c
> > > +++ b/drivers/tee/optee/call.c
> > > @@ -39,9 +39,27 @@ struct optee_shm_arg_entry {
> > >         DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
> > >  };
> > >
> > > +void optee_cq_init(struct optee_call_queue *cq, int thread_count)
> > > +{
> > > +       mutex_init(&cq->mutex);
> > > +       INIT_LIST_HEAD(&cq->waiters);
> > > +       /*
> > > +        * If cq->total_thread_count is 0 then we're not trying to keep
> > > +        * track of how many free threads we have, instead we're relyin=
g on
> > > +        * the secure world to tell us when we're out of thread and hav=
e to
> > > +        * wait for another thread to become available.
> > > +        */
> > > +       cq->total_thread_count =3D thread_count;
> > > +       cq->free_thread_count =3D thread_count;
> > > +}
> > > +
> > >  void optee_cq_wait_init(struct optee_call_queue *cq,
> > >                         struct optee_call_waiter *w, bool sys_thread)
> > >  {
> > > +       bool need_wait =3D false;
> > > +
> > > +       memset(w, 0, sizeof(*w));
> > > +
> > >         /*
> > >          * We're preparing to make a call to secure world. In case we c=
an't
> > >          * allocate a thread in secure world we'll end up waiting in
> > > @@ -53,15 +71,43 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
> > >         mutex_lock(&cq->mutex);
> > >
> > >         /*
> > > -        * We add ourselves to the queue, but we don't wait. This
> > > -        * guarantees that we don't lose a completion if secure world
> > > -        * returns busy and another thread just exited and try to compl=
ete
> > > -        * someone.
> > > +        * We add ourselves to a queue, but we don't wait. This guarant=
ees
> > > +        * that we don't lose a completion if secure world returns busy=
 and
> > > +        * another thread just exited and try to complete someone.
> > >          */
> > >         init_completion(&w->c);
> > >         list_add_tail(&w->list_node, &cq->waiters);
> > >
> > > +       if (cq->total_thread_count && sys_thread) {
> > > +               if (cq->free_thread_count > 0)
> > > +                       cq->free_thread_count--;
> > > +               else
> > > +                       need_wait =3D true;
> > > +       } else if (cq->total_thread_count) {
> > > +               if (cq->free_thread_count > 1)
> >
> > This unconditionally reserves a TEE thread for TEE system calls, even
> > if no client has claimed such system thread reservation.
>
> See my response above.
>
> >
> >
> > > +                       cq->free_thread_count--;
> > > +               else
> > > +                       need_wait =3D true;
> > > +       }
> > > +
> > >         mutex_unlock(&cq->mutex);
> > > +
> > > +       while (need_wait) {
> > > +               optee_cq_wait_for_completion(cq, w);
> > > +               mutex_lock(&cq->mutex);
> > > +               if (sys_thread) {
> > > +                       if (cq->free_thread_count > 0) {
> > > +                               cq->free_thread_count--;
> > > +                               need_wait =3D false;
> > > +                       }
> > > +               } else {
> > > +                       if (cq->free_thread_count > 1) {
> > > +                               cq->free_thread_count--;
> > > +                               need_wait =3D false;
> > > +                       }
> > > +               }
> > > +               mutex_unlock(&cq->mutex);
> > > +       }
> > >  }
> > >
> > >  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> > > @@ -104,6 +150,8 @@ void optee_cq_wait_final(struct optee_call_queue *c=
q,
> > >         /* Get out of the list */
> > >         list_del(&w->list_node);
> > >
> > > +       cq->free_thread_count++;
> > > +
> > >         /* Wake up one eventual waiting task */
> > >         optee_cq_complete_one(cq);
> > >
> > > @@ -361,6 +409,22 @@ int optee_open_session(struct tee_context *ctx,
> > >         return rc;
> > >  }
> > >
> > > +int optee_system_session(struct tee_context *ctx, u32 session)
> > > +{
> > > +       struct optee_context_data *ctxdata =3D ctx->data;
> > > +       struct optee_session *sess;
> > > +
> > > +       mutex_lock(&ctxdata->mutex);
> > > +
> > > +       sess =3D find_session(ctxdata, session);
> > > +       if (sess && !sess->use_sys_thread)
> > > +               sess->use_sys_thread =3D true;
> > > +
> > > +       mutex_unlock(&ctxdata->mutex);
> > > +
> > > +       return 0;
> >
> > Nitpicking: should rather return 0 only upon session is valid
> > (sess!=3DNULL here)  and system thread reservation is supported
> > (total_thread_count > 0).
> > But that's not a big deal I guess, can be addressed.
>
> Thanks for pointing it out. If this approach works for you then it can
> be addressed while integrating in your patch-set.
>
> -Sumit
>
> > (snip)

ST Restricted

--===============3153312161982424564==--

