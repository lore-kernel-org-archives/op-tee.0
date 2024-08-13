From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 13 Aug 2024 14:12:42 +0200
Message-ID: 
 <CAHUa44GnG1uonKASAYHSt=rNC=73svDFgCfe6XyQT+c+xs+_XA@mail.gmail.com>
In-Reply-To: <2024081346-riveting-unwired-d9dc@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0792937614847064934=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0792937614847064934==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 13, 2024 at 01:26:18PM +0200, Jens Wiklander wrote:
> > On Tue, Aug 13, 2024 at 11:29=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> > > > --- /dev/null
> > > > +++ b/drivers/misc/rpmb-core.c
> > > > @@ -0,0 +1,233 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > >
> > > Fine, but:
> > >
> > > > --- /dev/null
> > > > +++ b/include/linux/rpmb.h
> > > > @@ -0,0 +1,136 @@
> > > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> > >
> > > Really?
> > >
> > > Why?  I need lots of documentation and a lawyer sign off for why this is
> > > a dual license for a file that is obviously only for internal Linux
> > > kernel stuff.
> >
> > I'm sorry that was added via one of the patch sets before mine. I'll
> > revert to GPL-2.0 only.
>
> Please be sure to get proper legal approval to change the license of
> code not written by you :)

The dual license was introduced in
https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee(a)linaro.or=
g/,
but https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.=
winkler(a)intel.com/
uses GPL-2.0 only. So reverting to GPL-2.0 only should be OK, don't
you agree?

Thanks,
Jens

--===============0792937614847064934==--

