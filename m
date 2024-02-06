From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 06 Feb 2024 17:10:46 +0200
Message-ID: 
 <CAC_iWj+k_Vsz4ot=9pv-Gv7r11=vCunH5TSyOMTK4z-NZ2TeTA@mail.gmail.com>
In-Reply-To: <
 <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8768665629236161085=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8768665629236161085==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Tue, 6 Feb 2024 at 14:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > A number of storage technologies support a specialised hardware
> > partition designed to be resistant to replay attacks. The underlying
> > HW protocols differ but the operations are common. The RPMB partition
> > cannot be accessed via standard block layer, but by a set of specific
> > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > partition provides authenticated and replay protected access, hence
> > suitable as a secure storage.
> >
> > The initial aim of this patch is to provide a simple RPMB Driver which
> > can be accessed by the optee driver to facilitate early RPMB access to
> > OP-TEE OS (secure OS) during the boot time.
>
> How early do we expect OP-TEE to need RPMB access?

It depends on the requested services. I am currently aware of 2
services that depend on the RPMB
- FirmwareTPM
- UEFI variables stored there via optee.

For the FirmwareTPM it depends on when you want to use it. This
typically happens when the initramfs is loaded or systemd requests
access to the TPM. I guess this is late enough to not cause problems?

For the latter, we won't need the supplicant until a write is
requested. This will only happen once the userspace is up and running.
The UEFI driver that sits behind OP-TEE has an in-memory cache of the
variables, so all the reads (the kernel invokes get_next_variable
during boot) are working without it.

Thanks
/Ilias
>
> The way things work for mmc today, is that the eMMC card gets
> discovered/probed via a workqueue. The work is punted by the mmc host
> driver (typically a module-platform-driver), when it has probed
> successfully.
>
> The point is, it looks like we need some kind of probe deferral
> mechanism too. Whether we want the OP-TEE driver to manage this itself
> or whether we should let rpmb_dev_find_device() deal with it, I don't
> know.
>
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > class_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > provides a callback to route RPMB frames to the RPMB device accessible
> > via rpmb_route_frames().
>
> By looking at the design of the interface, I do like it. It's simple
> and straightforward.
>
> However, I wonder if you considered avoiding using a class-device
> altogether? Even if it helps with lifecycle problems and the
> ops-lookup, we really don't need another struct device with a sysfs
> node, etc.
>
> To deal with the lifecycle issue, we could probably just add reference
> counting for the corresponding struct device that we already have at
> hand, which represents the eMMC/UFS/NVME card. That together with a
> simple list that contains the registered rpmb ops. But I may be
> overlooking something, so perhaps it's more complicated than that?
>
> >
> > The detailed operation of implementing the access is left to the TEE
> > device driver itself.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  MAINTAINERS              |   7 ++
> >  drivers/misc/Kconfig     |   9 ++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/rpmb-core.c | 247 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/rpmb.h     | 184 +++++++++++++++++++++++++++++
> >  5 files changed, 448 insertions(+)
> >  create mode 100644 drivers/misc/rpmb-core.c
> >  create mode 100644 include/linux/rpmb.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8999497011a2..e83152c42499 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19012,6 +19012,13 @@ T:     git git://linuxtv.org/media_tree.git
> >  F:     Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-=
rotate.yaml
> >  F:     drivers/media/platform/sunxi/sun8i-rotate/
> >
> > +RPMB SUBSYSTEM
> > +M:     Jens Wiklander <jens.wiklander@linaro.org>
> > +L:     linux-kernel(a)vger.kernel.org
> > +S:     Supported
> > +F:     drivers/misc/rpmb-core.c
> > +F:     include/linux/rpmb.h
> > +
> >  RPMSG TTY DRIVER
> >  M:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >  L:     linux-remoteproc(a)vger.kernel.org
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 4fb291f0bf7c..891aa5763666 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -104,6 +104,15 @@ config PHANTOM
> >           If you choose to build module, its name will be phantom. If uns=
ure,
> >           say N here.
> >
> > +config RPMB
> > +       tristate "RPMB partition interface"
>
> Should we add a "depends on MMC"? (We can add the other NVME and UFS
> later on too).
>
> > +       help
> > +         Unified RPMB unit interface for RPMB capable devices such as eM=
MC and
> > +         UFS. Provides interface for in kernel security controllers to a=
ccess
> > +         RPMB unit.
> > +
> > +         If unsure, select N.
> > +
> >  config TIFM_CORE
> >         tristate "TI Flash Media interface support"
> >         depends on PCI
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index ea6ea5bbbc9c..8af058ad1df4 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)           +=3D lkdtm/
> >  obj-$(CONFIG_TIFM_CORE)        +=3D tifm_core.o
> >  obj-$(CONFIG_TIFM_7XX1)        +=3D tifm_7xx1.o
> >  obj-$(CONFIG_PHANTOM)          +=3D phantom.o
> > +obj-$(CONFIG_RPMB)             +=3D rpmb-core.o
> >  obj-$(CONFIG_QCOM_COINCELL)    +=3D qcom-coincell.o
> >  obj-$(CONFIG_QCOM_FASTRPC)     +=3D fastrpc.o
> >  obj-$(CONFIG_SENSORS_BH1770)   +=3D bh1770glc.o
> > diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> > new file mode 100644
> > index 000000000000..a3c289051687
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,247 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
> > + * Copyright(c) 2021 - 2024 Linaro Ltd.
> > + */
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/rpmb.h>
> > +#include <linux/slab.h>
> > +
> > +static DEFINE_IDA(rpmb_ida);
> > +static DEFINE_MUTEX(rpmb_mutex);
> > +
> > +/**
> > + * rpmb_dev_get() - increase rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > +{
> > +       if (rdev)
> > +               get_device(&rdev->dev);
> > +       return rdev;
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_get);
> > +
> > +/**
> > + * rpmb_dev_put() - decrease rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +void rpmb_dev_put(struct rpmb_dev *rdev)
> > +{
> > +       if (rdev)
> > +               put_device(&rdev->dev);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_put);
> > +
> > +/**
> > + * rpmb_route_frames() - route rpmb frames to rpmb device
> > + * @rdev:      rpmb device
> > + * @req:       rpmb request frames
> > + * @req_len:   length of rpmb request frames in bytes
> > + * @rsp:       rpmb response frames
> > + * @rsp_len:   length of rpmb response frames in bytes
> > + *
> > + * @return < 0 on failure
> > + */
> > +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> > +                     unsigned int req_len, u8 *rsp, unsigned int rsp_len)
> > +{
> > +       struct rpmb_frame *frm =3D (struct rpmb_frame *)req;
>
> Is there a reason why we are passing an u8 *req, in favor of a
> "rpmb_frame *frame" directly as the in-parameter?
>
> > +       u16 req_type;
> > +       bool write;
> > +
> > +       if (!req || req_len < sizeof(*frm) || !rsp || !rsp_len)
> > +               return -EINVAL;
> > +
> > +       req_type =3D be16_to_cpu(frm->req_resp);
> > +       switch (req_type) {
> > +       case RPMB_PROGRAM_KEY:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   rsp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D true;
> > +               break;
> > +       case RPMB_GET_WRITE_COUNTER:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   rsp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D false;
> > +               break;
> > +       case RPMB_WRITE_DATA:
> > +               if (req_len % sizeof(struct rpmb_frame) ||
> > +                   rsp_len !=3D sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D true;
> > +               break;
> > +       case RPMB_READ_DATA:
> > +               if (req_len !=3D sizeof(struct rpmb_frame) ||
> > +                   rsp_len % sizeof(struct rpmb_frame))
> > +                       return -EINVAL;
> > +               write =3D false;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return rdev->ops->route_frames(rdev->dev.parent, write,
> > +                                      req, req_len, rsp, rsp_len);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_route_frames);
>
> [...]
>
>
> > +
> > +/**
> > + * enum rpmb_type - type of underlaying storage technology
> > + *
> > + * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
> > + * @RPMB_TYPE_UFS   : UFS (JESD220)
> > + * @RPMB_TYPE_NVME  : NVM Express
> > + */
> > +enum rpmb_type {
> > +       RPMB_TYPE_EMMC,
> > +       RPMB_TYPE_UFS,
> > +       RPMB_TYPE_NVME,
> > +};
>
> In what way do we expect these to be useful?
>
> Perhaps we should add some information about this, because currently
> in the series they seem not to be used. Maybe the OP-TEE driver needs
> it when extending support to NVME and UFS?
>
> [...]
>
> Kind regards
> Uffe

--===============8768665629236161085==--

