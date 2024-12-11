From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 08/10] tee: add Qualcomm TEE driver
Date: Wed, 11 Dec 2024 15:04:59 +0100
Message-ID: <20241211140459.GA471738@rayden>
In-Reply-To: <62f80fb7-ea13-4ae1-a438-8d6b2d5a2f15@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3597065387191757121=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3597065387191757121==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Amirreza,

On Wed, Dec 11, 2024 at 01:30:22PM +1100, Amirreza Zarrabi wrote:
[snip]
> >> +/**
> >> + * struct qcom_tee_context - Clients or supplicants context.
> >> + * @tee_context: TEE context.
> >> + * @qtee_objects_idr: QTEE objects in this context.
> >> + * @reqs_idr: Requests currently being processed.
> >> + * @lock: mutex for @reqs_idr and @qtee_objects_idr.
> >> + * @req_srcu: srcu for exclusive access to requests.
> >> + * @req_c: completion used when supplicant is waiting for requests.
> >> + * @released: state of this context.
> >> + * @ref_cnt: ref count.
> >> + */
> >> +struct qcom_tee_context {
> >=20
> > Other drivers call their conterpart of this struct *_context_data.
> > Using the same pattern here makes it easier to recognize the struct in
> > the rest of the code.
> >=20
>=20
> Ack.
>=20
> >> +       struct tee_context *tee_context;
> >> +
> >> +       struct idr qtee_objects_idr;
> >> +       struct idr reqs_idr;
> >> +       /* Synchronize access to @reqs_idr, @qtee_objects_idr and updati=
ng requests state. */
> >> +       struct mutex lock;
> >> +       struct srcu_struct req_srcu;
> >=20
> > Why do you use this synchronization primitive? I don't know enough
> > about this primitive to tell if you use it for the right purpose so
> > perhaps you can help me understand which properties you need.
> >=20
>=20
> Sure, let me explain it bellow in the qcom_tee_user_object_dispatch,
> where it is acually used.
>=20
> >> +       struct completion req_c;
> >> +
> >> +       int released;
> >> +
> >> +       struct kref ref_cnt;
> >=20
> > Why does this struct need a different lifetime than struct tee_context?
> >=20
>=20
> This is a side effect of how QTEE objects and callback objects are released:
>=20
>   - When a tee_context is closed, we release all QTEE objects in that conte=
xt.
>     QTEE specifies that object releases are asynchronous. So, we queue the
>     releases in a workqueue and immediately return from the release callbac=
k,
>     allowing the TEE subsystem to continue.
>=20
>   - When the workqueue sends a release for a QTEE object, QTEE may respond
>     by requesting the release of a callback object or an operation on a cal=
lback
>     object. This requires a valid struct qcom_tee_context. That's why we ke=
ep this
>     until all callback objects are gone.
>=20
> The alternative is to keep a list of callback objects in this context and
> flag them as orphans. The refcount seems easier :).

It would be even easier if it was already dealt with by the TEE
subsystem. :-)

It looks like we have the same problem as with the tee_shm objects when
the tee_context should go away. Would it work to add another callback,
close_contex(), to tee_driver_ops to be called from
teedev_close_context()? The release() callback would still be called as
usual when the last reference is gone, but the backend TEE driver would
get a notification earlier with core_contex() that it's time to start
releasing resources.

[snip]
> >> +/**
> >> + * qcom_tee_supp_pop_entry() - Pop the next request in a context.
> >=20
> > When you pop something you'd expect it to be removed also.
> >
>=20
> I'll rename it to more apporpriate name.
>=20
> >> + * @ctx: context from which to pop a request.
> >> + * @ubuf_size: size of available buffer for MEMBUF parameters.
> >> + * @num_params: number of entries for TEE parameter array.
> >> + *
> >> + * It does not remove the request from &qcom_tee_context.reqs_idr.
> >> + * It checks if @num_params is large enough to fit the next request arg=
uments.
> >> + * It checks if @ubuf_size is large enough to fit IB buffer arguments f=
rom QTEE.
> >> + * It updates request state to %QCOM_TEE_REQ_PROCESSING state.
> >> + *
> >> + * Return: On success return a request or NULL and ERR_PTR on failure.
> >> + */
> >> +static struct qcom_tee_user_req *qcom_tee_supp_pop_entry(struct qcom_te=
e_context *ctx,
> >> +                                                        size_t ubuf_siz=
e, int num_params)
> >> +{
> >> +       struct qcom_tee_user_req *ureq;
> >> +       struct qcom_tee_arg *u;
> >> +       int i, id;
> >> +
> >> +       guard(mutex)(&ctx->lock);
> >> +
> >> +       /* Find the a QUEUED request. */
> >=20
> > Is it _a_ or _the_?
> >=20
> >> +       idr_for_each_entry(&ctx->reqs_idr, ureq, id)
> >> +               if (ureq->state =3D=3D QCOM_TEE_REQ_QUEUED)
> >> +                       break;
> >=20
> > Will this always result in a FIFO processing?
> >=20
>=20
> It not a FIFO. I understand your concerns.
> I'll replace it with a list.
>=20
> >> +
> >> +       if (!ureq)
> >> +               return NULL;
> >> +
> >> +       u =3D ureq->args;
> >> +       /* (1) Is there enough TEE parameters? */
> >> +       if (num_params < qcom_tee_args_len(u))
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       /* (2) Is there enough space to pass input buffers? */
> >> +       qcom_tee_arg_for_each_input_buffer(i, u) {
> >> +               ubuf_size =3D size_sub(ubuf_size, u[i].b.size);
> >> +               if (ubuf_size =3D=3D SIZE_MAX)
> >> +                       return ERR_PTR(-EINVAL);
> >> +
> >> +               ubuf_size =3D round_down(ubuf_size, 8);
> >> +       }
> >> +
> >> +       /* Ready to process request 'QUEUED -> PROCESSING'. */
> >> +       ureq->state =3D QCOM_TEE_REQ_PROCESSING;
> >> +
> >> +       return ureq;
> >> +}
> >> +
> >> +/* User object dispatcher. */
> >> +static int qcom_tee_user_object_dispatch(struct qcom_tee_object_invoke_=
ctx *oic,
> >> +                                        struct qcom_tee_object *object,=
 u32 op,
> >> +                                        struct qcom_tee_arg *args)
> >> +{
> >> +       struct qcom_tee_user_object *uo =3D to_qcom_tee_user_object(obje=
ct);
> >> +       struct qcom_tee_user_req *ureq __free(kfree);
> >> +       struct qcom_tee_context *ctx =3D uo->ctx;
> >> +       int errno;
> >> +
> >> +       ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
> >> +       if (!ureq)
> >> +               return -ENOMEM;
> >> +
> >> +       init_completion(&ureq->c);
> >> +       ureq->object_id =3D uo->object_id;
> >> +       ureq->op =3D op;
> >> +       ureq->args =3D args;
> >> +
> >> +       /* Queue the request. */
> >> +       if (qcom_tee_request_enqueue(ureq, ctx))
> >> +               return -ENODEV;
> >> +
> >> +       /* Wakeup supplicant to process it. */
> >> +       complete(&ctx->req_c);
> >> +
> >> +       /* Wait for supplicant to process the request. */
> >> +       /* Supplicant is expected to process request in a timely manner.=
 We wait as KILLABLE,
> >=20
> > requests
> >=20
> >> +        * in case supplicant and invoke thread both running from a same=
 user process, otherwise
> >=20
> > the same
> >=20
> >> +        * the process stuck on fatal signal.
> >=20
> > might get stuck on a fatal signal?
> >=20
> >> +        */
> >=20
> > Please combine into one comment.
> >=20
>=20
> Ack.
>=20
> >> +       if (!wait_for_completion_state(&ureq->c, TASK_KILLABLE | TASK_FR=
EEZABLE)) {
> >> +               errno =3D ureq->errno;
> >> +               /* On SUCCESS, end_cb_notify frees the request. */
> >> +               if (!errno)
> >> +                       oic->data =3D no_free_ptr(ureq);
> >> +       } else {
> >> +               enum qcom_tee_req_state prev_state;
> >> +
> >> +               errno =3D -ENODEV;
> >> +
> >> +               scoped_guard(mutex, &ctx->lock) {
> >> +                       prev_state =3D ureq->state;
> >> +                       /* Replace ureq with '__empty_ureq' to keep req_=
id reserved. */
> >> +                       if (prev_state =3D=3D QCOM_TEE_REQ_PROCESSING)
> >> +                               idr_replace(&ctx->reqs_idr, &__empty_ure=
q, ureq->req_id);
> >> +                       /* Remove ureq as supplicant has never seen this=
 request. */
> >> +                       else if (prev_state =3D=3D QCOM_TEE_REQ_QUEUED)
> >> +                               idr_remove(&ctx->reqs_idr, ureq->req_id);
> >> +               }
> >> +
> >> +               /* Wait for exclusive access to ureq. */
> >> +               synchronize_srcu(&ctx->req_srcu);
> >=20
> > I'm sorry, I don't follow.
> >
>=20
> I'll try to compare it to the optee.
>=20
> In optee, clients and the supplicant run in two different contexts. If the
> supplicant is available, the client will wait for it to finish processing
> the queued request. The supplicant is guaranteed to be timely and responsiv=
e.

Yeah, or at least trusted to be timely and responsive.

>=20
> In QCOMTEE:
>=20
>   1. There are multiple supplicants. Any process that implements a callback
>      object is considered a supplicant. The general assumption of timeliness
>      or responsiveness may not apply. We allow the client to at least recei=
ve fatal
>      signals (this design can be extended later if a timeout is required).
>=20
>   2. A client can implement a callback object and act as both a client and
>      a supplicant simultaneously. To terminate such a process, we need to be
>      able to accept fatal signals.

We accept tee-supplicant to be killed so this is similar.

>=20
> srcu is specifically used to protect the args array. After returning from
> qcom_tee_user_object_dispatch, the args array might not be valid. We need to
> ensure no one is accessing the args array before the retun, hence synchroni=
ze_srcu.
> Whenever we read the contents of args, we do it within an srcu read lock.
>=20
> For example, qcomtee_user_object_pop, which picks a request for the supplic=
ant
> to process, will hold the srcu read lock when marshaling the args array
> to the TEE subsystem's params array.
>=20
> An alternative to the srcu would be to use "context lock" ctx->lock and
> hold it throughout the qcomtee_user_object_pop function, even when marshali=
ng
> the args array to the TEE subsystem's params array.
>=20
> Using ctx->lock is easier to follow, but since it's shared by everyone in
> a context and marshaling can be heavy depending on the type of objects,
> I thought srcu would be more performant.
>=20
> In other words, srcu just moves the marshaling of objects outside of ctx->l=
ock.
> What do you think about keeping srcu or replacing it with ctx->lock?

Let's continue the comparison with OP-TEE where struct optee_supp_req
plays the role of struct qcom_tee_user_req in QCOMTEE. You can say that
access rights to the optee_supp_req follows with the owner. The
supp->mutex is in principle only held while changing owner. Couldn't the
ctx->lock be used in a similar way, avoiding it while marshalling
objects?

I'm open to be persuaded if you think that srcu is a better choice.

Cheers,
Jens

--===============3597065387191757121==--

