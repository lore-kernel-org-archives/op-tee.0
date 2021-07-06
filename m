From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Tue, 06 Jul 2021 12:55:26 +0530
Message-ID: 
 <CAFA6WYMSAM2MDOXnhjuZFov3BtF8-nihZRUpR8ciUWsL4_nCWA@mail.gmail.com>
In-Reply-To: <
 <CAHUa44EeAENHv+CxtXeLuqX_NGWW6w-6P8D-BLsb69+XmGaqEQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5883333080126142860=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5883333080126142860==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jun 2021 at 11:40, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi Sumit,
>
> On Thu, Jun 17, 2021 at 6:33 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Jens,
> >
> > On Wed, 16 Jun 2021 at 16:07, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Hi all,
> > >
> > > This adds support for asynchronous notifications from OP-TEE in secure
> > > world to the OP-TEE driver. This allows a design with a top half and bo=
ttom
> > > half type of driver where the top half runs in secure interrupt context=
 and
> > > a notifications tells normal world to schedule a yielding call to do the
> > > bottom half processing.
> > >
> > > An interrupt is used to notify the driver that there are asynchronous
> > > notifications pending.
> > >
> >
> > It looks like a nice feature. I would like to get hands on with this.
> > Can I test this feature on Qemu?
>
> Absolutely, you can get this into the normal OP-TEE development repo setup =
with:
> repo init -u https://github.com/OP-TEE/manifest.git -m default.xml
> repo sync
> Update optee_os with
> https://github.com/jenswi-linaro/optee_os/tree/async_notif_v2
> Update linux with https://github.com/jenswi-linaro/linux-1/tree/async_notif=
_v2
> cd build
> make all -j...
> make run-only
>
> If you type anything at the secure console you'll notice how it
> changes behaviour once the Linux kernel has booted.
>

Thanks for sharing instructions as I now got some time to test and
deep dive into this feature. It looks like a pretty useful feature to
realize interrupt support in the secure world in its true sense. This
feature works for me as per your instructions.

I could recognise it's requirement from the time while I was playing
with secure timer interrupt support for OP-TEE RNG driver on
Developerbox. In that case I had to strip down the secure interrupt
handler to a minimum that would just collect entropy and dump into the
secure buffer. But with asynchronous notifications support, I could
add more functionality like entropy health tests in the bottom half
instead of doing those health tests while retrieving entropy from the
secure world.

Given that, have you explored the possibility to leverage SGI rather
than a platform specific SPI for notifying the normal world? If it's
possible to leverage Architecture specific SGI for this purpose then I
think this feature will come automatically enabled for every platform
without the need to reserve a platform specific SPI.

-Sumit

> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > v2:
> > > * Added documentation
> > > * Converted optee bindings to json-schema and added interrupt property
> > > * Configure notification interrupt from DT instead of getting it
> > >   from secure world, suggested by Ard Biesheuvel <ardb@kernel.org>.
> > >
> > > Thanks,
> > > Jens
> > >
> > > Jens Wiklander (7):
> > >   docs: staging/tee.rst: add a section on OP-TEE notifications
> > >   dt-bindings: arm: Convert optee binding to json-schema
> > >   dt-bindings: arm: optee: add interrupt property
> > >   tee: fix put order in teedev_close_context()
> > >   tee: add tee_dev_open_helper() primitive
> > >   optee: separate notification functions
> > >   optee: add asynchronous notifications
> > >
> > >  .../bindings/arm/firmware/linaro,optee-tz.txt |  31 ---
> > >  .../arm/firmware/linaro,optee-tz.yaml         |  57 +++++
> > >  Documentation/staging/tee.rst                 |  27 +++
> > >  drivers/tee/optee/Makefile                    |   1 +
> > >  drivers/tee/optee/call.c                      |  27 +++
> > >  drivers/tee/optee/core.c                      |  87 +++++--
> > >  drivers/tee/optee/notif.c                     | 226 ++++++++++++++++++
> > >  drivers/tee/optee/optee_msg.h                 |   9 +
> > >  drivers/tee/optee/optee_private.h             |  23 +-
> > >  drivers/tee/optee/optee_rpc_cmd.h             |  31 +--
> > >  drivers/tee/optee/optee_smc.h                 |  75 +++++-
> > >  drivers/tee/optee/rpc.c                       |  73 +-----
> > >  drivers/tee/tee_core.c                        |  37 ++-
> > >  include/linux/tee_drv.h                       |  27 +++
> > >  14 files changed, 576 insertions(+), 155 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/lina=
ro,optee-tz.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/firmware/lina=
ro,optee-tz.yaml
> > >  create mode 100644 drivers/tee/optee/notif.c
> > >
> > > --
> > > 2.31.1
> > >

--===============5883333080126142860==--

