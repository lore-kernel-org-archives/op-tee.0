From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 3/4] tee: optee: support tracking system threads
Date: Thu, 11 May 2023 10:19:45 +0200
Message-ID: 
 <CAN5uoS8HF5ymsjkLthFnoQxBHQ3TOVonycTH3g5K76qKzUniuA@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPUWjK97H5DL-eOT2bjsa79Zrvk4wet2AW0Qb0NOVqt7Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5884286226393098717=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5884286226393098717==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 May 2023 at 09:27, Sumit Garg <sumit.garg@linaro.org> wrote:
> (snip)
> > > > >
> > > > > +bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq)
> > > > > +{
> > > > > +       bool rc =3D false;
> > > > > +
> > > > > +       mutex_lock(&cq->mutex);
> > > > > +
> > > > > +       /* Leave at least 1 normal (non-system) thread */
> > > >
> > > > IMO, this might be counter productive. As most kernel drivers open a
> > > > session during driver probe which are only released in the driver
> > > > release method.
> > >
> > > It is always the case?
> >
> > This answer of mine is irrelevant. Sorry,
> > Please read only the below comments of mine, especially:
> > | Note that an OP-TEE thread is not bound to a TEE session but rather
> > | bound to a yielded call to OP-TEE.
> >
> > >
> > > > If the kernel driver is built-in then the session is
> > > > never released. Now with system threads we would reserve an OP-TEE
> > > > thread for that kernel driver as well which will never be available to
> > > > regular user-space clients.
> > >
> > > That is not true. No driver currently requests their TEE thread to be
> > > a system thread.
> > > Only SCMI does because it needs to by construction.
> > >
>
> Yes that's true but what prevents future/current kernel TEE drivers
> from requesting a system thread once we have this patch-set landed.

Only clients really needing this system_thread attribute should request it.
If they really need, the OP-TEE firmware in secure world should
provision sufficient thread context.

>
> > >
> > > > So I would rather suggest we only allow a
> > > > single system thread to be reserved as a starting point which is
> > > > relevant to this critical SCMI service. We can also make this upper
> > > > bound for system threads configurable with default value as 1 if
> > > > needed.
> >
> > Note that SCMI server can expose several SCMI channels (at most 1 per
> > SCMI protocol used) and each of them will need to request a
> > system_thread to TEE driver.
> >
> > Etienne
> >
> > >
> > > Reserving one or more system threads depends on the number of thread
> > > context provisioned by the TEE.
> > > Note that the implementation proposed here prevents Linux kernel from
> > > exhausting TEE threads so user space always has at least a TEE thread
> > > context left available.
>
> Yeah but on the other hand user-space clients which are comparatively
> larger in number than kernel clients. So they will be starved for
> OP-TEE thread availability. Consider a user-space client which needs
> to serve a lot of TLS connections just waiting for OP-TEE thread
> availability.

Note that OP-TEE default configuration provisions (number of CPUs + 1)
thread context, so the situation is already present before these
changes on systems that embedded an OP-TEE without a properly tuned
configuration. As I said above, Linux kernel cannot be responsible for
the total number of thread contexts provisioned in OP-TEE. If the
overall system requires a lot of TEE thread contexts, one should embed
a suitable OP-TEE firmware.

>
> > >
> > > Note that an OP-TEE thread is not bound to a TEE session but rather
> > > bound to a yielded call to OP-TEE.
>
> tee_client_open_session()
>   -> optee_open_session()
>
> tee_client_system_session()
>   -> optee_system_session()
>     -> optee_cq_inc_sys_thread_count()       <- At this point you
> reserve a system thread corresponding to a particular kernel client
> session
>
> All tee_client_invoke_func() invocations with a system thread capable
> session will use that reserved thread.
>
> tee_client_close_session()
>   -> optee_close_session()
>     -> optee_close_session_helper()
>       -> optee_cq_dec_sys_thread_count()    <- At this point the
> reserved system thread is released
>
> Haven't this tied the system thread to a particular TEE session? Or am
> I missing something?

These changes do not define an overall single system thread.
If several sessions requests reservation of TEE system thread, has
many will be reserved.
Only the very sessions with its sys_thread attribute set will use a
reserved thread. If such a kernel client issues several concurrent
calls to OP-TEE over that session, it will indeed consume more
reserved system threads than what is actually reserved. Here I think
it is the responsibility of such client to open as many sessions as
requests. This is what scmi/optee driver does (see patch v6 4/4). An
alternative would be to have a ref count of sys_thread in session
contexts rather than a boolean value. I don't think it's worth it.

> > > > > (snip)
> > > > > @@ -281,9 +281,10 @@ static int optee_to_msg_param(struct optee *op=
tee,
> > > > >  static void optee_enable_shm_cache(struct optee *optee)
> > > > >  {
> > > > >         struct optee_call_waiter w;
> > > > > +       bool system_thread =3D false;
> > > >
> > > > This variable is redundant.
> > >
> > > Using a variable here makes it more clear which argument is passed to
> > > optee_cq_wait_init().
> > > Calling optee_cq_wait_init(&optee->call_queue, &w, false); is less read=
able.
> > >
>
> The function declaration is always there to read about the arguments.
> IMO, variables with a constant value which are only used once don't
> add any value.

Ok, i'll address that. Actually I see that optee_shm_register() and
optee_shm_unregister() (patch v6 1/4) do use false straight as an
argument.

etienne

>
> -Sumit
>
> > > >
> > > > >
> > > > >         /* We need to retry until secure world isn't busy. */
> > > > > -       optee_cq_wait_init(&optee->call_queue, &w);
> > > > > +       optee_cq_wait_init(&optee->call_queue, &w, system_thread);
> > > > >         while (true) {
> > > > >                 struct arm_smccc_res res;
> > > > >
> > > > > (snip)

--===============5884286226393098717==--

