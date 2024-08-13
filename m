From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 13 Aug 2024 14:41:06 +0200
Message-ID: <2024081315-cofounder-stem-8b3d@gregkh>
In-Reply-To: <=?utf-8?q?=3CPH7PR11MB7605F50AC47D18361D933CE1E5862=40PH7PR11MB?=
 =?utf-8?q?7605=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6028993316367313606=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6028993316367313606==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, Aug 13, 2024 at 12:04:03PM +0000, Winkler, Tomas wrote:
> > 
> > On Tue, Aug 13, 2024 at 01:26:18PM +0200, Jens Wiklander wrote:
> > > On Tue, Aug 13, 2024 at 11:29 AM Greg Kroah-Hartman
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
> 
> This was legal approved.

This internal Linux kernel header file for an internal-only Linux kernel
api?  Wonderful, please get the Intel lawyer who agreed with that to
sign off on the commit next time around explaining why it needs to be
this way.

thanks,

greg k-h

--===============6028993316367313606==--

