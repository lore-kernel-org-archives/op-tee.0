From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 13 Aug 2024 13:06:48 +0000
Message-ID: <PH7PR11MB7605DCD728BA31F475816C8EE5862@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <2024081315-cofounder-stem-8b3d@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0272946293360918441=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0272946293360918441==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



>=20
> On Tue, Aug 13, 2024 at 12:04:03PM +0000, Winkler, Tomas wrote:
> > >
> > > On Tue, Aug 13, 2024 at 01:26:18PM +0200, Jens Wiklander wrote:
> > > > On Tue, Aug 13, 2024 at 11:29=E2=80=AFAM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/misc/rpmb-core.c
> > > > > > @@ -0,0 +1,233 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > >
> > > > > Fine, but:
> > > > >
> > > > > > --- /dev/null
> > > > > > +++ b/include/linux/rpmb.h
> > > > > > @@ -0,0 +1,136 @@
> > > > > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> > > > >
> > > > > Really?
> > > > >
> > > > > Why?  I need lots of documentation and a lawyer sign off for why
> > > > > this is a dual license for a file that is obviously only for
> > > > > internal Linux kernel stuff.
> >
> > This was legal approved.
>=20
> This internal Linux kernel header file for an internal-only Linux kernel ap=
i?
> Wonderful, please get the Intel lawyer who agreed with that to sign off on
> the commit next time around explaining why it needs to be this way.
>=20
This was few years ago, and there was few versions of this patchest,=20
 but it looks like Jens is right, as he wrote in another email my final submi=
ssion was with GPL-2.0 only.=20

Thanks
Tomas



--===============0272946293360918441==--

