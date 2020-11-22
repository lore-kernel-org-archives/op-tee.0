From: Sam Ravnborg <sam@ravnborg.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Sun, 22 Nov 2020 23:10:40 +0100
Message-ID: <20201122221040.GD566387@ravnborg.org>
In-Reply-To: <
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7741873723261443605=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7741873723261443605==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi James.

> > > If none of the 140 patches here fix a real bug, and there is no
> > > change to machine code then it sounds to me like a W=3D2 kind of a
> > > warning.
> >=20
> > FWIW, this series has found at least one bug so far:
> > https://lore.kernel.org/lkml/CAFCwf11izHF=3Dg1mGry1fE5kvFFFrxzhPSM6qKAO8g=
xSp=3DKr_CQ(a)mail.gmail.com/
>=20
>=20
> Well, it's a problem in an error leg, sure, but it's not a really
> compelling reason for a 141 patch series, is it?  All that fixing this
> error will do is get the driver to print "oh dear there's a problem"
> under four more conditions than it previously did.

You are asking the wrong question here.

Yuo should ask  how many hours could have been saved by all the bugs
people have been fighting with and then fixed *before* the code
hit the kernel at all.

My personal experience is that I, more than once, have had errors
related to a missing break in my code. So this warnings is IMO a win.

And if we are only ~100 patches to have it globally enabled then it is a
no-brainer in my book.

	Sam

--===============7741873723261443605==--

