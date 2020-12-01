From: Dan Carpenter <dan.carpenter@oracle.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Tue, 01 Dec 2020 17:04:49 +0300
Message-ID: <20201201140449.GG2767@kadam>
In-Reply-To: <202011220816.8B6591A@keescook>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0077794472368019658=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0077794472368019658==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2020 at 08:17:03AM -0800, Kees Cook wrote:
> On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> > On Fri, 20 Nov 2020 11:30:40 -0800 Kees Cook wrote:
> > > On Fri, Nov 20, 2020 at 10:53:44AM -0800, Jakub Kicinski wrote:
> > > > On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote: =20
> > > > > This series aims to fix almost all remaining fall-through warnings =
in
> > > > > order to enable -Wimplicit-fallthrough for Clang.
> > > > >=20
> > > > > In preparation to enable -Wimplicit-fallthrough for Clang, explicit=
ly
> > > > > add multiple break/goto/return/fallthrough statements instead of ju=
st
> > > > > letting the code fall through to the next case.
> > > > >=20
> > > > > Notice that in order to enable -Wimplicit-fallthrough for Clang, th=
is
> > > > > change[1] is meant to be reverted at some point. So, this patch hel=
ps
> > > > > to move in that direction.
> > > > >=20
> > > > > Something important to mention is that there is currently a discrep=
ancy
> > > > > between GCC and Clang when dealing with switch fall-through to empt=
y case
> > > > > statements or to cases that only contain a break/continue/return
> > > > > statement[2][3][4]. =20
> > > >=20
> > > > Are we sure we want to make this change? Was it discussed before?
> > > >=20
> > > > Are there any bugs Clangs puritanical definition of fallthrough helped
> > > > find?
> > > >=20
> > > > IMVHO compiler warnings are supposed to warn about issues that could
> > > > be bugs. Falling through to default: break; can hardly be a bug?! =20
> > >=20
> > > It's certainly a place where the intent is not always clear. I think
> > > this makes all the cases unambiguous, and doesn't impact the machine
> > > code, since the compiler will happily optimize away any behavioral
> > > redundancy.
> >=20
> > If none of the 140 patches here fix a real bug, and there is no change
> > to machine code then it sounds to me like a W=3D2 kind of a warning.
>=20
> FWIW, this series has found at least one bug so far:
> https://lore.kernel.org/lkml/CAFCwf11izHF=3Dg1mGry1fE5kvFFFrxzhPSM6qKAO8gxS=
p=3DKr_CQ(a)mail.gmail.com/

This is a fallthrough to a return and not to a break.  That should
trigger a warning.  The fallthrough to a break should not generate a
warning.

The bug we're trying to fix is "missing break statement" but if the
result of the bug is "we hit a break statement" then now we're just
talking about style.  GCC should limit itself to warning about
potentially buggy code.

regards,
dan carpenter

--===============0077794472368019658==--

