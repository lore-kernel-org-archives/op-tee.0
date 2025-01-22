From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add support for supplicant timeout
Date: Wed, 22 Jan 2025 11:06:05 +0100
Message-ID: 
 <CAHUa44F76AqB4ijQHBfoNXveiyxeBLOLh6ULT+pc+va3y0qBdg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNRD-CGTHufafFLX4SjvpH6fBKwqCac8JE2oLepqqsNOw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1217297807419091863=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1217297807419091863==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 10:15=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Mon, 20 Jan 2025 at 19:01, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Mon, Jan 20, 2025 at 10:24=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > Hi Jens,
> > >
> > > On Fri, 13 Dec 2024 at 16:45, Sumit Garg <sumit.garg@linaro.org> wrot=
e:
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
> > >
> > > Do you have any further comments here? Or is it fine for you to pick it=
 up?
> >
> > I don't like the timeout, it's a bit too hacky.
> >
>
> Can you please elaborate here as to why?

Tee-supplicant is supposed to respond in a timely manner. What is
timely manner depends on the use case, but you now want to say that
it's 10 seconds regardless of what's going on. This makes it
impossible to debug tee-supplicant with a debugger unless you're very
quick. It might also introduce random timouts in a system under a
heavy IO load.

> Currently the kernel is
> relying too heavily on tee-supplicant daemon to respond properly in an
> unbounded loop. I think this is really a bug for devices in production
> in scenarios where the tee-supplicant gets stuck for some reason or
> crashes in the middle or gets killed.

Tee-supplicant is a system daemon, the system depends heavily on it.
It should not be killable by unprivileged processes.
 What happens if init crashes or is killed?

> These can simply lead to system
> hung up issues during shutdown requiring a hard power off or reset
> which isn't expected from a sane system.

This is new information. Is the use case to avoid blocking for too
long during shutdown or reset? We may need to do something to ensure
that the tee-supplicant isn't killed before OP-TEE is done with it.
Enforcing this timeout during shutdown makes sense, but not during
normal operation.

> So I rather consider the
> unbounded wait loop for tee-supplicant a bug we have currently
> requiring a fix to be backported.

Yeah, but only during certain circumstances.

>
> So do you have a better suggestion to fix this in the mainline as well
> as backported to stable releases?

Let's start by finding out what problem you're trying to fix.

Cheers,
Jens

>
> -Sumit

--===============1217297807419091863==--

