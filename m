From: Jakub Kicinski <kuba@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Fri, 20 Nov 2020 11:51:42 -0800
Message-ID: 
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202011201129.B13FDB3C@keescook>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8404832212126802110=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8404832212126802110==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Nov 2020 11:30:40 -0800 Kees Cook wrote:
> On Fri, Nov 20, 2020 at 10:53:44AM -0800, Jakub Kicinski wrote:
> > On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote: =20
> > > This series aims to fix almost all remaining fall-through warnings in
> > > order to enable -Wimplicit-fallthrough for Clang.
> > >=20
> > > In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> > > add multiple break/goto/return/fallthrough statements instead of just
> > > letting the code fall through to the next case.
> > >=20
> > > Notice that in order to enable -Wimplicit-fallthrough for Clang, this
> > > change[1] is meant to be reverted at some point. So, this patch helps
> > > to move in that direction.
> > >=20
> > > Something important to mention is that there is currently a discrepancy
> > > between GCC and Clang when dealing with switch fall-through to empty ca=
se
> > > statements or to cases that only contain a break/continue/return
> > > statement[2][3][4]. =20
> >=20
> > Are we sure we want to make this change? Was it discussed before?
> >=20
> > Are there any bugs Clangs puritanical definition of fallthrough helped
> > find?
> >=20
> > IMVHO compiler warnings are supposed to warn about issues that could
> > be bugs. Falling through to default: break; can hardly be a bug?! =20
>=20
> It's certainly a place where the intent is not always clear. I think
> this makes all the cases unambiguous, and doesn't impact the machine
> code, since the compiler will happily optimize away any behavioral
> redundancy.

If none of the 140 patches here fix a real bug, and there is no change
to machine code then it sounds to me like a W=3D2 kind of a warning.

I think clang is just being annoying here, but if I'm the only one who
feels this way chances are I'm wrong :)

--===============8404832212126802110==--

