From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Thu, 17 Jun 2021 08:10:01 +0200
Message-ID: 
 <CAHUa44EeAENHv+CxtXeLuqX_NGWW6w-6P8D-BLsb69+XmGaqEQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYMrxNfR09doWQgYKCQSYKyUMVKqSTPuRYn=-nueY9pSvQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1541902870465316032=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1541902870465316032==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Thu, Jun 17, 2021 at 6:33 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> On Wed, 16 Jun 2021 at 16:07, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Hi all,
> >
> > This adds support for asynchronous notifications from OP-TEE in secure
> > world to the OP-TEE driver. This allows a design with a top half and bott=
om
> > half type of driver where the top half runs in secure interrupt context a=
nd
> > a notifications tells normal world to schedule a yielding call to do the
> > bottom half processing.
> >
> > An interrupt is used to notify the driver that there are asynchronous
> > notifications pending.
> >
>
> It looks like a nice feature. I would like to get hands on with this.
> Can I test this feature on Qemu?

Absolutely, you can get this into the normal OP-TEE development repo setup wi=
th:
repo init -u https://github.com/OP-TEE/manifest.git -m default.xml
repo sync
Update optee_os with
https://github.com/jenswi-linaro/optee_os/tree/async_notif_v2
Update linux with https://github.com/jenswi-linaro/linux-1/tree/async_notif_v2
cd build
make all -j...
make run-only

If you type anything at the secure console you'll notice how it
changes behaviour once the Linux kernel has booted.

Cheers,
Jens

>
> -Sumit
>
> > v2:
> > * Added documentation
> > * Converted optee bindings to json-schema and added interrupt property
> > * Configure notification interrupt from DT instead of getting it
> >   from secure world, suggested by Ard Biesheuvel <ardb@kernel.org>.
> >
> > Thanks,
> > Jens
> >
> > Jens Wiklander (7):
> >   docs: staging/tee.rst: add a section on OP-TEE notifications
> >   dt-bindings: arm: Convert optee binding to json-schema
> >   dt-bindings: arm: optee: add interrupt property
> >   tee: fix put order in teedev_close_context()
> >   tee: add tee_dev_open_helper() primitive
> >   optee: separate notification functions
> >   optee: add asynchronous notifications
> >
> >  .../bindings/arm/firmware/linaro,optee-tz.txt |  31 ---
> >  .../arm/firmware/linaro,optee-tz.yaml         |  57 +++++
> >  Documentation/staging/tee.rst                 |  27 +++
> >  drivers/tee/optee/Makefile                    |   1 +
> >  drivers/tee/optee/call.c                      |  27 +++
> >  drivers/tee/optee/core.c                      |  87 +++++--
> >  drivers/tee/optee/notif.c                     | 226 ++++++++++++++++++
> >  drivers/tee/optee/optee_msg.h                 |   9 +
> >  drivers/tee/optee/optee_private.h             |  23 +-
> >  drivers/tee/optee/optee_rpc_cmd.h             |  31 +--
> >  drivers/tee/optee/optee_smc.h                 |  75 +++++-
> >  drivers/tee/optee/rpc.c                       |  73 +-----
> >  drivers/tee/tee_core.c                        |  37 ++-
> >  include/linux/tee_drv.h                       |  27 +++
> >  14 files changed, 576 insertions(+), 155 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro=
,optee-tz.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro=
,optee-tz.yaml
> >  create mode 100644 drivers/tee/optee/notif.c
> >
> > --
> > 2.31.1
> >

--===============1541902870465316032==--

