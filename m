From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 13 Aug 2024 13:26:18 +0200
Message-ID: 
 <CAHUa44HYQVhT0=E9py2JsO2X93wLhZ=YvH0fBqQpzFBujSGgtw@mail.gmail.com>
In-Reply-To: <2024081346-dutiful-stalemate-0e07@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1984361041321203379=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1984361041321203379==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, Aug 13, 2024 at 11:29 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,233 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> Fine, but:
>
> > --- /dev/null
> > +++ b/include/linux/rpmb.h
> > @@ -0,0 +1,136 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
>
> Really?
>
> Why?  I need lots of documentation and a lawyer sign off for why this is
> a dual license for a file that is obviously only for internal Linux
> kernel stuff.

I'm sorry that was added via one of the patch sets before mine. I'll
revert to GPL-2.0 only.

Thanks,
Jens

>
> thanks,
>
> greg k-h

--===============1984361041321203379==--

