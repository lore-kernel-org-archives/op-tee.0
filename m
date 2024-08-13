From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 13 Aug 2024 13:07:07 +0000
Message-ID: <PH7PR11MB7605877E4EE14DB19CBB26F0E5862@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <
 <CAHUa44GnG1uonKASAYHSt=rNC=73svDFgCfe6XyQT+c+xs+_XA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8101494797883657025=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8101494797883657025==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Jens Wiklander <jens.wiklander@linaro.org>
> Sent: Tuesday, August 13, 2024 3:13 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel(a)vger.kernel.org; linux-mmc(a)vger.kernel.org; op-
> tee(a)lists.trustedfirmware.org; Ulf Hansson <ulf.hansson@linaro.org>;
> Shyam Saini <shyamsaini@linux.microsoft.com>; Linus Walleij
> <linus.walleij@linaro.org>; Jerome Forissier <jerome.forissier@linaro.o=
rg>;
> Sumit Garg <sumit.garg@linaro.org>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Bart Van Assche <bvanassche@acm.org>;
> Randy Dunlap <rdunlap@infradead.org>; Ard Biesheuvel
> <ardb@kernel.org>; Arnd Bergmann <arnd@arndb.de>; Manuel Traut
> <manut@mecka.net>; Mikko Rapeli <mikko.rapeli@linaro.org>; Winkler,
> Tomas <tomas.winkler@intel.com>; Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg>
> Subject: Re: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block
> (RPMB) subsystem
>=20
> On Tue, Aug 13, 2024 at 1:36=E2=80=AFPM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 13, 2024 at 01:26:18PM +0200, Jens Wiklander wrote:
> > > On Tue, Aug 13, 2024 at 11:29=E2=80=AFAM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> > > > > --- /dev/null
> > > > > +++ b/drivers/misc/rpmb-core.c
> > > > > @@ -0,0 +1,233 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > >
> > > > Fine, but:
> > > >
> > > > > --- /dev/null
> > > > > +++ b/include/linux/rpmb.h
> > > > > @@ -0,0 +1,136 @@
> > > > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> > > >
> > > > Really?
> > > >
> > > > Why?  I need lots of documentation and a lawyer sign off for why
> > > > this is a dual license for a file that is obviously only for
> > > > internal Linux kernel stuff.
> > >
> > > I'm sorry that was added via one of the patch sets before mine. I'll
> > > revert to GPL-2.0 only.
> >
> > Please be sure to get proper legal approval to change the license of
> > code not written by you :)
>=20
> The dual license was introduced in
> https://lore.kernel.org/lkml/20220405093759.1126835-2-
> alex.bennee(a)linaro.org/,
> but https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-
> tomas.winkler(a)intel.com/
> uses GPL-2.0 only. So reverting to GPL-2.0 only should be OK, don't you
> agree?


Ack.=20



--===============8101494797883657025==--

