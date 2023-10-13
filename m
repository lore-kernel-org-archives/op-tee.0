From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v10 3/4] tee: optee: support tracking system threads
Date: Fri, 13 Oct 2023 09:23:17 +0000
Message-ID: <adb7df76eb8f4a7399b89f681383df84@foss.st.com>
In-Reply-To: <
 <CAFA6WYPRgAnq_WZGbqvrn4de9Gk9fzTDs+NmcWyFn-QAC2+c8w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8386473668620752122=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8386473668620752122==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> From: Sumit Garg <sumit.garg@linaro.org>
> Sent: Friday, October 13, 2023 11:13 AM
>=20
> On Fri, 13 Oct 2023 at 14:09, Etienne CARRIERE - foss
> <etienne.carriere@foss.st.com> wrote:
> >
> > > From: Sumit Garg <sumit.garg@linaro.org>
> > > Sent: Friday, October 13, 2023 9:21 AM
> > >
> > > On Wed, 11 Oct 2023 at 12:41, Etienne CARRIERE - foss
> > > <etienne.carriere@foss.st.com> wrote:
> > > >
> > > > > From: Sumit Garg <sumit.garg@linaro.org>
> > > > > Sent: Friday, October 6, 2023 11:33 AM
> > > > >
> > > > > On Tue, 3 Oct 2023 at 19:36, Etienne Carriere
> > > > > <etienne.carriere@foss.st.com> wrote:
> > > > > >
> > > > > > Adds support in the OP-TEE driver to keep track of reserved system
> > > > > > threads. The logic allows one OP-TEE thread to be reserved to TEE=
 system
> > > > > > sessions.
> > > > > >
> > > > > > The optee_cq_*() functions are updated to handle this if enabled,
> > > > > > that is when TEE describes how many thread context it supports
> > > > > > and when at least 1 session has registered as a system session
> > > > > > (using tee_client_system_session()).
> > > > > >
> > > > > > For sake of simplicity, initialization of call queue management
> > > > > > is factorized into new helper function optee_cq_init().
> > > > > >
> > > > > > The SMC ABI part of the driver enables this tracking, but the
> > > > > > FF-A ABI part does not.
> > > > > >
> > > > > >
> > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > > > > ---
> > > > > > Changes since v9:
> > > > > > - Add a reference counter for TEE system thread provisioning. We =
reserve
> > > > > >   a TEE thread context for system session only when there is at l=
east
> > > > > >   1 opened system session.
> > > > > > - Use 2 wait queue lists, normal_waiters and sys_waiter, as propo=
sed in
> > > > > >   patch v8. Using a single list can prevent a waiting system thre=
ad from
> > > > > >   being resumed if the executing system thread wakes a normal wai=
ter in
> > > > > >   the list.
> > > > >
> > > > > How would that be possible? The system thread wakeup
> > > > > (free_thread_threshold =3D 0) is given priority over normal thread
> > > > > wakeup (free_thread_threshold =3D 1). I think a single queue list w=
ould
> > > > > be sufficient as demonstrated in v9.
> > > > >
> > > >
> > > > Hello Sumit,
> > > >
> > > > I think a system session can be trapped waiting when using a single q=
ueue list.
> > > > To have a chance to reach the TEE, a waiting thread must wait that a =
TEE thread comes out of the TEE and calls complete() on the waitqueue to wake=
 next waiter.
> > > >
> > > > To illustrate, consider a 10 TEE threads configuration on TEE side (:=
:total_thread_count=3D10 at init),
> > > > and several TEE clients in Linux OS, including 2 system sessions, fro=
m 2 consumer drivers (::sys_thread_req_count=3D2).
> > > >
> > > > Imagine the 9 normal threads and the 1 system thread are in use. (::f=
ree_thread_count=3D0),
> > > > Now comes the other system session: it goes to the waitqueue list.
> > > > Now comes a normal session invocation: it goes to the waitqueue list,=
 1st position.
> > > >
> > > > Now, TEE system thread returns to Linux:
> > > > It increments the counter, ::free_thread_count=3D1, and calls complet=
e() for the waitequeue.
> > > > The 1st element in the waitqueue list is the last entered normal sess=
ion invocation.
> > > > However, that waiter won't switch local boolean 'need_wait'  to false=
 because ::free_thread_count=3D1 and ::sys_thread_req_count!=3D0.
> > > > So no attempt to reach TEE and wake another waiter on return.
> > > > At that point there is a system session in the waitqueue list that co=
uld enter TEE (::free_thread_count=3D1) but is waiting someone returns from t=
he TEE.
> > >
> > > I suppose the following loop tries to wake-up every waiter to give
> > > them a chance to enter OP-TEE. So with that system session would
> > > always be prefered over normal session, right?
> >
> > No, the below loop will wake only the 1st waiter it finds in the list tha=
t is
> > current waiting (completion_done() returns false). So if it finds a normal
> > session, it will only wake this one which, in turn, will not try to reach=
 the
> > TEE from the while(need_wiat) loop in optee_cq_wait_init(), because there=
 is
> > not enough free threads. Because it does not reach the TEE, it will not
> > it wake another waiter.
> >
>=20
> Okay I see your point, so how about the following change on top of v9.
> I still think having 2 queues is an overkill here.
>=20
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index df5fb5410b72..47f57054d9b7 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -60,6 +60,7 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
>          */
>         init_completion(&w->c);
>         list_add_tail(&w->list_node, &cq->waiters);
> +       w->sys_thread =3D sys_thread;
>=20
> ...
>=20
> @@ -83,6 +84,14 @@ static void optee_cq_complete_one(struct
> optee_call_queue *cq)
>  {
>         struct optee_call_waiter *w;
>=20
> +       /* Try to wakeup system session capable threads first */
> +       list_for_each_entry(w, &cq->waiters, list_node) {
> +               if (!completion_done(&w->c) && w->sys_thread) {
> +                       complete(&w->c);
> +                       return;
> +               }
> +       }
> +

Indeed, looking for system sessions first in the list would address the issue.
I would test sys_thread firs: if (w->sys_thread && !completion_done(&w->c))

That said, is it better to have 2 lists or to have 1 list possibly scanned tw=
ice?
I'm fine with both ways.

etienne


>         list_for_each_entry(w, &cq->waiters, list_node) {
>                 if (!completion_done(&w->c)) {
>                         complete(&w->c);
> diff --git a/drivers/tee/optee/optee_private.h
> b/drivers/tee/optee/optee_private.h
> index 6bb5cae09688..a7817ce9f90f 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -43,6 +43,7 @@ typedef void (optee_invoke_fn)(unsigned long,
> unsigned long, unsigned long,
>  struct optee_call_waiter {
>         struct list_head list_node;
>         struct completion c;
> +       bool sys_thread;
>  };
>=20
>  struct optee_call_queue {
>=20
> -Sumit
>=20
> > >
> > > static void optee_cq_complete_one(struct optee_call_queue *cq)
> > > {
> > >         struct optee_call_waiter *w;
> > >
> > >         list_for_each_entry(w, &cq->waiters, list_node) {
> > >                 if (!completion_done(&w->c)) {
> > >                         complete(&w->c);
> > >                         break;
> > >                 }
> > >         }
> > > }
> > >
> > > -Sumit
> > >
> >
> > Note I've found a error in this patch v10, see below.
> >
> > BR,
> > Etienne
> >
> >
> > > >
> > > > With 2 lists, we first treat system sessions to overcome that.
> > > > Am I missing something?
> > > >
> > > > Best regards,
> > > > Etienne
> > > >
> > > > > -Sumit
> > > > >
(snip)

--===============8386473668620752122==--

