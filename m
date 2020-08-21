From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] driver: tee: Handle NULL pointer indication from client
Date: Fri, 21 Aug 2020 12:09:22 +0200
Message-ID: 
 <CAHUa44GKffKTBdrfchtj=wuM_4EMcFPw35DyXT7pRuqDYQ6VYA@mail.gmail.com>
In-Reply-To: <20200710101808.1316522-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5752915547110982255=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5752915547110982255==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, Jul 10, 2020 at 12:18 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> From: Cedric Neveux <cedric.neveux@nxp.com>
>
> TEE Client introduce a new capability "TEE_GEN_CAP_MEMREF_NULL"
> to handle the support of the shared memory buffer with a NULL pointer.
>
> This capability depends on TEE Capabilities and driver support.
> Driver and TEE exchange capabilities at driver initialization.
>
> Signed-off-by: Michael Whitfield <michael.whitfield@nxp.com>
> Signed-off-by: Cedric Neveux <cedric.neveux@nxp.com>
> Reviewed-by: Joakim Bech <joakim.bech@linaro.org>
> Tested-by: Joakim Bech <joakim.bech@linaro.org> (QEMU)
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c      |  7 +++++
>  drivers/tee/optee/optee_smc.h |  3 +++
>  drivers/tee/tee_core.c        | 49 ++++++++++++++++++++++-------------
>  include/linux/tee_drv.h       |  3 +++
>  include/uapi/linux/tee.h      | 13 ++++++++++
>  5 files changed, 57 insertions(+), 18 deletions(-)

I almost forgot this one. I'm picking this up.

Cheers,
Jens

--===============5752915547110982255==--

