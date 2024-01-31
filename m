From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 31 Jan 2024 13:13:01 -0800
Message-ID: <2024013108-hamster-audacious-9e3a@gregkh>
In-Reply-To: <20240131174347.510961-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4518084040766155665=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4518084040766155665==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Jan 31, 2024 at 06:43:45PM +0100, Jens Wiklander wrote:
> +struct class rpmb_class = {

This structure should be marked as 'const', right?

> +	.name = "rpmb",
> +	.dev_release = rpmb_dev_release,
> +};
> +EXPORT_SYMBOL(rpmb_class);

EXPORT_SYMBOL_GPL() to match all the other exports in this file please.

thanks,

greg k-h

--===============4518084040766155665==--

