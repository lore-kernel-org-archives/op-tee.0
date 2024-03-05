From: Linus Walleij <linus.walleij@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 05 Mar 2024 13:24:02 +0100
Message-ID: 
 <CACRpkdZBWBio8kvKuVzj2CknCb4eS=VB2EqUsAK-vf4e328icg@mail.gmail.com>
In-Reply-To: <20240227153132.2611499-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2047573420152506888=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2047573420152506888==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Jens,

thanks for your patch!

On Tue, Feb 27, 2024 at 4:31 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:

> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> partition provides authenticated and replay protected access, hence
> suitable as a secure storage.
>
> The initial aim of this patch is to provide a simple RPMB driver
> interface which can be accessed by the optee driver to facilitate early
> RPMB access to OP-TEE OS (secure OS) during the boot time.
>
> A TEE device driver can claim the RPMB interface, for example, via
> rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> provides a callback to route RPMB frames to the RPMB device accessible
> via rpmb_route_frames().
>
> The detailed operation of implementing the access is left to the TEE
> device driver itself.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

I would mention in the commit that the subsystem is currently
only used with eMMC but is designed to be used also by UFS
and NVME. Nevertheless, no big deal so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +config RPMB
> +       tristate "RPMB partition interface"
> +       depends on MMC

depends on MMC || SCSI_UFSHCD || NVME_CORE
?

Or do we want to hold it off until we implement the backends?

Yours,
Linus Walleij

--===============2047573420152506888==--

