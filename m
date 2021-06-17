From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Thu, 17 Jun 2021 10:03:14 +0530
Message-ID: 
 <CAFA6WYMrxNfR09doWQgYKCQSYKyUMVKqSTPuRYn=-nueY9pSvQ@mail.gmail.com>
In-Reply-To: <20210616103649.2662395-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0278232821089078529=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0278232821089078529==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, 16 Jun 2021 at 16:07, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi all,
>
> This adds support for asynchronous notifications from OP-TEE in secure
> world to the OP-TEE driver. This allows a design with a top half and bottom
> half type of driver where the top half runs in secure interrupt context and
> a notifications tells normal world to schedule a yielding call to do the
> bottom half processing.
>
> An interrupt is used to notify the driver that there are asynchronous
> notifications pending.
>

It looks like a nice feature. I would like to get hands on with this.
Can I test this feature on Qemu?

-Sumit

> v2:
> * Added documentation
> * Converted optee bindings to json-schema and added interrupt property
> * Configure notification interrupt from DT instead of getting it
>   from secure world, suggested by Ard Biesheuvel <ardb@kernel.org>.
>
> Thanks,
> Jens
>
> Jens Wiklander (7):
>   docs: staging/tee.rst: add a section on OP-TEE notifications
>   dt-bindings: arm: Convert optee binding to json-schema
>   dt-bindings: arm: optee: add interrupt property
>   tee: fix put order in teedev_close_context()
>   tee: add tee_dev_open_helper() primitive
>   optee: separate notification functions
>   optee: add asynchronous notifications
>
>  .../bindings/arm/firmware/linaro,optee-tz.txt |  31 ---
>  .../arm/firmware/linaro,optee-tz.yaml         |  57 +++++
>  Documentation/staging/tee.rst                 |  27 +++
>  drivers/tee/optee/Makefile                    |   1 +
>  drivers/tee/optee/call.c                      |  27 +++
>  drivers/tee/optee/core.c                      |  87 +++++--
>  drivers/tee/optee/notif.c                     | 226 ++++++++++++++++++
>  drivers/tee/optee/optee_msg.h                 |   9 +
>  drivers/tee/optee/optee_private.h             |  23 +-
>  drivers/tee/optee/optee_rpc_cmd.h             |  31 +--
>  drivers/tee/optee/optee_smc.h                 |  75 +++++-
>  drivers/tee/optee/rpc.c                       |  73 +-----
>  drivers/tee/tee_core.c                        |  37 ++-
>  include/linux/tee_drv.h                       |  27 +++
>  14 files changed, 576 insertions(+), 155 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,o=
ptee-tz.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,o=
ptee-tz.yaml
>  create mode 100644 drivers/tee/optee/notif.c
>
> --
> 2.31.1
>

--===============0278232821089078529==--

