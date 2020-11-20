From: Kees Cook <keescook@chromium.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Fri, 20 Nov 2020 12:48:01 -0800
Message-ID: <202011201244.78E002D5@keescook>
In-Reply-To: <
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1233304455394906178=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1233304455394906178==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> On Fri, 20 Nov 2020 11:30:40 -0800 Kees Cook wrote:
> > On Fri, Nov 20, 2020 at 10:53:44AM -0800, Jakub Kicinski wrote:
> > > On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote: =20
> > > > This series aims to fix almost all remaining fall-through warnings in
> > > > order to enable -Wimplicit-fallthrough for Clang.
> > > >=20
> > > > In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> > > > add multiple break/goto/return/fallthrough statements instead of just
> > > > letting the code fall through to the next case.
> > > >=20
> > > > Notice that in order to enable -Wimplicit-fallthrough for Clang, this
> > > > change[1] is meant to be reverted at some point. So, this patch helps
> > > > to move in that direction.
> > > >=20
> > > > Something important to mention is that there is currently a discrepan=
cy
> > > > between GCC and Clang when dealing with switch fall-through to empty =
case
> > > > statements or to cases that only contain a break/continue/return
> > > > statement[2][3][4]. =20
> > >=20
> > > Are we sure we want to make this change? Was it discussed before?
> > >=20
> > > Are there any bugs Clangs puritanical definition of fallthrough helped
> > > find?
> > >=20
> > > IMVHO compiler warnings are supposed to warn about issues that could
> > > be bugs. Falling through to default: break; can hardly be a bug?! =20
> >=20
> > It's certainly a place where the intent is not always clear. I think
> > this makes all the cases unambiguous, and doesn't impact the machine
> > code, since the compiler will happily optimize away any behavioral
> > redundancy.
>=20
> If none of the 140 patches here fix a real bug, and there is no change
> to machine code then it sounds to me like a W=3D2 kind of a warning.

I'd like to avoid splitting common -W options between default and W=3D2
just based on the compiler. Getting -Wimplicit-fallthrough enabled found
plenty of bugs, so making sure it works correctly for both compilers
feels justified to me. (This is just a subset of the same C language
short-coming.)

> I think clang is just being annoying here, but if I'm the only one who
> feels this way chances are I'm wrong :)

It's being pretty pedantic, but I don't think it's unreasonable to
explicitly state how every case ends. GCC's silence for the case of
"fall through to a break" doesn't really seem justified.

--=20
Kees Cook

--===============1233304455394906178==--

