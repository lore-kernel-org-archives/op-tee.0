From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 07 Feb 2024 09:06:35 +0100
Message-ID: 
 <CAHUa44Ht93U2Q78Xx91J_Xq=dBrhwjy2tERO4BntfNywewxVAg@mail.gmail.com>
In-Reply-To: <
 <CAPDyKFqNhGWKm=+7niNsjXOjEJE3U=o7dRNG=JqpptUSo9G-ug@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1822973661105136007=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1822973661105136007==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 1:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
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

As I wrote in another reply. I'd like to probe the OP-TEE driver
without touching RPMB first, and then as the devices start to appear
we discover the one to use. In this patchset I'm relying on the OP-TEE
client to wait until the RPMB device is available. That's probably
good enough for user space client, but I guess not for kernel clients
(drivers).

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

Yes, the class-device might be more of a leftover from earlier
versions with a user space interface too. Let's try to do this without
a class-device. I was considering using class_interface_register() for
the optee driver to get notified of an eventual RPMB device, but if we
don't have an RPMB class device we'll need some other mechanism for
that. Perhaps a rpmb_interface_register() with similar callbacks as
class_interface_register().

>
> To deal with the lifecycle issue, we could probably just add reference
> counting for the corresponding struct device that we already have at
> hand, which represents the eMMC/UFS/NVME card. That together with a
> simple list that contains the registered rpmb ops. But I may be
> overlooking something, so perhaps it's more complicated than that?

I could try to call mmc_blk_get() in mmc_blk_alloc_rpmb_part() when
storing the md pointer in the newly created struct mmc_rpmb_data. If
that works as I hope, then I can get rid of the two get_resources()
and put_resources() callbacks. We should probably update
mmc_rpmb_chrdev_open() and mmc_rpmb_chrdev_release() to match this.

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

That makes sense, I'll add that.

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

In the OP-TEE driver, we get an arbitrarily sized block of data from
the secure world, but we don't interpret it. I expect that it would be
the same for any other driver. You get data from somewhere and need to
pass it on. With this interface, we can provide the needed sanity
checks here instead of forcing each caller to do it instead.

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

Yes, we need to pass this information to the secure side. I'll update
the OP-TEE driver to extract and use the type field from struct
rpmb_ops.

Thanks,
Jens

>
> [...]
>
> Kind regards
> Uffe

--===============1822973661105136007==--

