From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v9 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Sat, 24 Aug 2024 11:13:12 +0800
Message-ID: <2024082403-preseason-preacher-a709@gregkh>
In-Reply-To: <20240814153558.708365-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1952534301811681134=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1952534301811681134==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, Aug 14, 2024 at 05:35:55PM +0200, Jens Wiklander wrote:
> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> RPMB commands. Such a partition provides authenticated and replay
> protected access, hence suitable as a secure storage.
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
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Manuel Traut <manut@mecka.net>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--===============1952534301811681134==--

