From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add support for supplicant timeout
Date: Wed, 22 Jan 2025 14:45:35 +0530
Message-ID: 
 <CAFA6WYNRD-CGTHufafFLX4SjvpH6fBKwqCac8JE2oLepqqsNOw@mail.gmail.com>
In-Reply-To: <
 <CAHUa44EE6XL5zgf0VNeqPkUukFGz5BgiHz=0yAVdd=tEzLEq6Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8385629504323743808=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8385629504323743808==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jan 2025 at 19:01, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Mon, Jan 20, 2025 at 10:24=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > Hi Jens,
> >
> > On Fri, 13 Dec 2024 at 16:45, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > OP-TEE supplicant is a user-space daemon and it's possible for it
> > > being crashed or killed in the middle of processing an OP-TEE RPC call.
> > > It becomes more complicated when there is incorrect shutdown ordering
> > > of the supplicant process vs the OP-TEE client application which can
> > > eventually lead to system hang-up waiting for the closure of the client
> > > application.
> > >
> > > In order to gracefully handle this scenario, let's add a long enough
> > > timeout to wait for supplicant to process requests. In case there is a
> > > timeout then we return a proper error code for the RPC request.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  drivers/tee/optee/supp.c | 58 +++++++++++++++++++++++++---------------
> > >  1 file changed, 36 insertions(+), 22 deletions(-)
> > >
> >
> > Do you have any further comments here? Or is it fine for you to pick it u=
p?
>
> I don't like the timeout, it's a bit too hacky.
>

Can you please elaborate here as to why? Currently the kernel is
relying too heavily on tee-supplicant daemon to respond properly in an
unbounded loop. I think this is really a bug for devices in production
in scenarios where the tee-supplicant gets stuck for some reason or
crashes in the middle or gets killed. These can simply lead to system
hung up issues during shutdown requiring a hard power off or reset
which isn't expected from a sane system. So I rather consider the
unbounded wait loop for tee-supplicant a bug we have currently
requiring a fix to be backported.

So do you have a better suggestion to fix this in the mainline as well
as backported to stable releases?

-Sumit

--===============8385629504323743808==--

