From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Sun, 22 Nov 2020 10:21:59 -0800
Message-ID: 
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
In-Reply-To: <202011220816.8B6591A@keescook>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2960369511634464130=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2960369511634464130==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-11-22 at 08:17 -0800, Kees Cook wrote:
> On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> > On Fri, 20 Nov 2020 11:30:40 -0800 Kees Cook wrote:
> > > On Fri, Nov 20, 2020 at 10:53:44AM -0800, Jakub Kicinski wrote:
> > > > On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote: =20
> > > > > This series aims to fix almost all remaining fall-through
> > > > > warnings in order to enable -Wimplicit-fallthrough for Clang.
> > > > >=20
> > > > > In preparation to enable -Wimplicit-fallthrough for Clang,
> > > > > explicitly add multiple break/goto/return/fallthrough
> > > > > statements instead of just letting the code fall through to
> > > > > the next case.
> > > > >=20
> > > > > Notice that in order to enable -Wimplicit-fallthrough for
> > > > > Clang, this change[1] is meant to be reverted at some point.
> > > > > So, this patch helps to move in that direction.
> > > > >=20
> > > > > Something important to mention is that there is currently a
> > > > > discrepancy between GCC and Clang when dealing with switch
> > > > > fall-through to empty case statements or to cases that only
> > > > > contain a break/continue/return statement[2][3][4]. =20
> > > >=20
> > > > Are we sure we want to make this change? Was it discussed
> > > > before?
> > > >=20
> > > > Are there any bugs Clangs puritanical definition of fallthrough
> > > > helped find?
> > > >=20
> > > > IMVHO compiler warnings are supposed to warn about issues that
> > > > could be bugs. Falling through to default: break; can hardly be
> > > > a bug?! =20
> > >=20
> > > It's certainly a place where the intent is not always clear. I
> > > think this makes all the cases unambiguous, and doesn't impact
> > > the machine code, since the compiler will happily optimize away
> > > any behavioral redundancy.
> >=20
> > If none of the 140 patches here fix a real bug, and there is no
> > change to machine code then it sounds to me like a W=3D2 kind of a
> > warning.
>=20
> FWIW, this series has found at least one bug so far:
> https://lore.kernel.org/lkml/CAFCwf11izHF=3Dg1mGry1fE5kvFFFrxzhPSM6qKAO8gxS=
p=3DKr_CQ(a)mail.gmail.com/


Well, it's a problem in an error leg, sure, but it's not a really
compelling reason for a 141 patch series, is it?  All that fixing this
error will do is get the driver to print "oh dear there's a problem"
under four more conditions than it previously did.

We've been at this for three years now with nearly a thousand patches,
firstly marking all the fall throughs with /* fall through */ and later
changing it to fallthrough.  At some point we do have to ask if the
effort is commensurate with the protection afforded.  Please tell me
our reward for all this effort isn't a single missing error print.

James



--===============2960369511634464130==--

