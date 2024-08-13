From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 13 Aug 2024 11:29:37 +0200
Message-ID: <2024081346-dutiful-stalemate-0e07@gregkh>
In-Reply-To: <20240812133127.865879-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7790589646924716785=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7790589646924716785==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> --- /dev/null
> +++ b/drivers/misc/rpmb-core.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0

Fine, but:

> --- /dev/null
> +++ b/include/linux/rpmb.h
> @@ -0,0 +1,136 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */

Really?

Why?  I need lots of documentation and a lawyer sign off for why this is
a dual license for a file that is obviously only for internal Linux
kernel stuff.

thanks,

greg k-h

--===============7790589646924716785==--

