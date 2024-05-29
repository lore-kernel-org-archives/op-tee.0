From: Linus Walleij <linus.walleij@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 2/4] mmc: block: register RPMB partition with the RPMB
 subsystem
Date: Wed, 29 May 2024 09:39:27 +0200
Message-ID: 
 <CACRpkdbA-HF135xbY2RovOyvtSRyiJ8fQ9JG09Bf0vwna+tQ9Q@mail.gmail.com>
In-Reply-To: <20240527121340.3931987-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7073236599017397866=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7073236599017397866==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, May 27, 2024 at 2:14 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:

> Register eMMC RPMB partition with the RPMB subsystem and provide
> an implementation for the RPMB access operations abstracting
> the actual multi step process.
>
> Add a callback to extract the needed device information at registration
> to avoid accessing the struct mmc_card at a later stage as we're not
> holding a reference counter for this struct.
>
> Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
> instead of in mmc_rpmb_chrdev_open(). This is needed by the
> route_frames() function pointer in struct rpmb_ops.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Tested-by: Manuel Traut <manut@mecka.net>

Very nice code!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

--===============7073236599017397866==--

