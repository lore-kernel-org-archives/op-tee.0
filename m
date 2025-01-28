From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add support for supplicant timeout
Date: Tue, 28 Jan 2025 09:19:28 +0100
Message-ID: 
 <CAHUa44H4yLvkU6ATvk0KOzVDa2TOgS9EBsU+BKR2piZbX26kLQ@mail.gmail.com>
In-Reply-To: <c3c782f8-fb48-4d3e-95b0-d0707f57acff@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7231773196340268102=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7231773196340268102==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 9:29=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 27, 2025, at 08:33, Jens Wiklander wrote:
> > [+Arnd for a question below]
> >
> > On Wed, Jan 22, 2025 at 1:25=E2=80=AFPM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> >>
> >> On Wed, 22 Jan 2025 at 15:36, Jens Wiklander <jens.wiklander@linaro.or=
g> wrote:
> >> >
> >> > On Wed, Jan 22, 2025 at 10:15=E2=80=AFAM Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> >> > >
> >> > > On Mon, 20 Jan 2025 at 19:01, Jens Wiklander <jens.wiklander@linar=
o.org> wrote:
> >> > > >
> >> > > > On Mon, Jan 20, 2025 at 10:24=E2=80=AFAM Sumit Garg <sumit.garg@=
linaro.org> wrote:
> >> > > > >
> >> > > > > Hi Jens,
> >> > > > >
> >> > > > > On Fri, 13 Dec 2024 at 16:45, Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >> > > > > >
> >> > > > > > OP-TEE supplicant is a user-space daemon and it's possible for=
 it
> >> > > > > > being crashed or killed in the middle of processing an OP-TEE =
RPC call.
> >> > > > > > It becomes more complicated when there is incorrect shutdown o=
rdering
> >> > > > > > of the supplicant process vs the OP-TEE client application whi=
ch can
> >> > > > > > eventually lead to system hang-up waiting for the closure of t=
he client
> >> > > > > > application.
> >> > > > > >
> >> > > > > > In order to gracefully handle this scenario, let's add a long =
enough
> >> > > > > > timeout to wait for supplicant to process requests. In case th=
ere is a
> >> > > > > > timeout then we return a proper error code for the RPC request.
> >> > > > > >
> >> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> > > > > > ---
> >> > > > > >  drivers/tee/optee/supp.c | 58 +++++++++++++++++++++++++------=
---------
> >> > > > > >  1 file changed, 36 insertions(+), 22 deletions(-)
> >> > > > > >
> >> > > > >
> >> > > > > Do you have any further comments here? Or is it fine for you to =
pick it up?
> >> > > >
> >> > > > I don't like the timeout, it's a bit too hacky.
> >> > > >
> >> > >
> >> > > Can you please elaborate here as to why?
> >> >
> >> > Tee-supplicant is supposed to respond in a timely manner. What is
> >> > timely manner depends on the use case, but you now want to say that
> >> > it's 10 seconds regardless of what's going on. This makes it
> >> > impossible to debug tee-supplicant with a debugger unless you're very
> >> > quick. It might also introduce random timouts in a system under a
> >> > heavy IO load.
> >>
> >> Although, initially I thought 10 seconds should be enough for any
> >> user-space process to be considered hung but then I saw
> >> DEFAULT_HUNG_TASK_TIMEOUT which is 120 seconds for a task to be
> >> considered hung. How about rather a Kconfig option like
> >> OPTEE_SUPPLICANT_HUNG_TIMEOUT which defaults to 120 seconds? It can be
> >> configured as 0 to disable timeout entirely for debugging purposes.
> >
> > Adding a timeout when a timeout isn't needed seems wrong, even if the
> > timeout is very long. Arnd, what do you think?
>
> It's hard to put an upper bound on user space latency.
>
> As far as I can tell, even that DEFAULT_HUNG_TASK_TIMEOUT
> limit is only for tasks that are in an unkillable state for more
> than two minutes, but the supplicant not providing results
> to the kernel could also happen when it waits in a killable
> or interruptible state, or when it does multiple I/Os in a
> row that each block for a time under 120 seconds.
>
> A single sector write to an eMMC can easily take multiple
> seconds by itself when nothing is going on and the device is
> in need of garbage collection. If the system is already in
> low memory or there are other tasks writing to the file system,
> you can have many such I/O operations queued up in the device
> when it adds another I/O to the back of the queue.

Adding a timeout means we must somehow handle them to avoid spurious errors.

>
> Looking at the function that Sumit suggested changing, I see
> another problem, both before and after the patch:
>
>         while (wait_for_completion_interruptible(&req->c)) {
>                 mutex_lock(&supp->mutex);
>                 interruptable =3D !supp->ctx;
>                 if (interruptable) {
> ...
>                 }
>                 mutex_unlock(&supp->mutex);
>
>                 if (interruptable) {
>                         req->ret =3D TEEC_ERROR_COMMUNICATION;
>                         break;
>                 }
>         }
>
> The "_interruptible()" wait makes no sense here if the
> "interruptable" variable is unset: The task remains in
> interrupted state, so the while() loop that was waiting
> for the wake_up_interruptible() turns into a busy loop
> if the task actually gets a signal.
>
> If the task at this point is running at a realtime
> priority, it would prevent the thing it is waiting for
> from getting scheduled on the same CPU.

I see the problem, thanks.

>
> >> > > So do you have a better suggestion to fix this in the mainline as we=
ll
> >> > > as backported to stable releases?
> >> >
> >> > Let's start by finding out what problem you're trying to fix.
> >>
> >> Let me know if the Kconfig option as proposed above sounds reasonable to=
 you.
> >
> > No one is going to bother with that config option, recompiling the
> > kernel to be able to debug tee-supplicant is a bit much.
>
> If a timeout is needed, having it runtime configurable seems
> more useful than a build time option.

To address Sumit's issue of hung shutdowns and reboots, the timeout
could be activated only during shutdowns and reboots.

Thanks,
Jens

--===============7231773196340268102==--

