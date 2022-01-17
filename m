From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] docs: staging/tee.rst: fix two typos found while reading
Date: Mon, 17 Jan 2022 12:03:04 +0530
Message-ID: 
 <CAFA6WYM=ie84YO7bBzeXU579LRpxfJ4VMBSkVJy2Fdxd4RpnwQ@mail.gmail.com>
In-Reply-To: <a6b32e17-9aba-4a03-12db-0d707e0f8d26@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2193128098901077053=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2193128098901077053==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 15 Jan 2022 at 21:00, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 1/15/22 04:52, Wang Cheng wrote:
> > Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks.
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> > ---
> >  Documentation/staging/tee.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> > index 3c63d8dcd61e..498343c7ab08 100644
> > --- a/Documentation/staging/tee.rst
> > +++ b/Documentation/staging/tee.rst
> > @@ -255,7 +255,7 @@ The following picture shows a high level overview of =
AMD-TEE::
> >   +--------------------------+      +---------+--------------------+
> >
> >  At the lowest level (in x86), the AMD Secure Processor (ASP) driver uses=
 the
> > -CPU to PSP mailbox regsister to submit commands to the PSP. The format o=
f the
> > +CPU to PSP mailbox register to submit commands to the PSP. The format of=
 the
> >  command buffer is opaque to the ASP driver. It's role is to submit comma=
nds to
> >  the secure processor and return results to AMD-TEE driver. The interface
> >  between AMD-TEE driver and AMD Secure Processor driver can be found in [=
6].
> > @@ -290,7 +290,7 @@ cancel_req driver callback is not supported by AMD-TE=
E.
> >
> >  The GlobalPlatform TEE Client API [5] can be used by the user space (cli=
ent) to
> >  talk to AMD's TEE. AMD's TEE provides a secure environment for loading, =
opening
> > -a session, invoking commands and clossing session with TA.
> > +a session, invoking commands and closing session with TA.
> >
> >  References
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> ~Randy

--===============2193128098901077053==--

