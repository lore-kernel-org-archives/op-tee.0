From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v6 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 15 May 2024 09:51:32 +0200
Message-ID: 
 <CAHUa44FepEVKYPhmH1zvSHOiCMPBwagLSgMmqMyDxewsTxT_-w@mail.gmail.com>
In-Reply-To: <2024051424-shack-blinking-547a@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6416486322954404744=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6416486322954404744==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 5:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 07, 2024 at 11:16:17AM +0200, Jens Wiklander wrote:
> > A number of storage technologies support a specialised hardware
> > partition designed to be resistant to replay attacks. The underlying
> > HW protocols differ but the operations are common. The RPMB partition
> > cannot be accessed via standard block layer, but by a set of specific
> > RPMB commands. Such a partition provides authenticated and replay
> > protected access, hence suitable as a secure storage.
> >
> > The initial aim of this patch is to provide a simple RPMB driver
> > interface which can be accessed by the optee driver to facilitate early
> > RPMB access to OP-TEE OS (secure OS) during the boot time.
> >
> > A TEE device driver can claim the RPMB interface, for example, via
> > rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > provides a callback to route RPMB frames to the RPMB device accessible
> > via rpmb_route_frames().
> >
> > The detailed operation of implementing the access is left to the TEE
> > device driver itself.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  MAINTAINERS              |   7 ++
> >  drivers/misc/Kconfig     |  10 ++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/rpmb-core.c | 233 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/rpmb.h     | 136 +++++++++++++++++++++++
> >  5 files changed, 387 insertions(+)
> >  create mode 100644 drivers/misc/rpmb-core.c
> >  create mode 100644 include/linux/rpmb.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8999497011a2..e83152c42499 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19012,6 +19012,13 @@ T:   git git://linuxtv.org/media_tree.git
> >  F:   Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-ro=
tate.yaml
> >  F:   drivers/media/platform/sunxi/sun8i-rotate/
> >
> > +RPMB SUBSYSTEM
> > +M:   Jens Wiklander <jens.wiklander@linaro.org>
> > +L:   linux-kernel(a)vger.kernel.org
> > +S:   Supported
> > +F:   drivers/misc/rpmb-core.c
> > +F:   include/linux/rpmb.h
> > +
> >  RPMSG TTY DRIVER
> >  M:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >  L:   linux-remoteproc(a)vger.kernel.org
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 4fb291f0bf7c..dbff9e8c3a03 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -104,6 +104,16 @@ config PHANTOM
> >         If you choose to build module, its name will be phantom. If unsur=
e,
> >         say N here.
> >
> > +config RPMB
> > +     tristate "RPMB partition interface"
> > +     depends on MMC
> > +     help
> > +       Unified RPMB unit interface for RPMB capable devices such as eMMC=
 and
> > +       UFS. Provides interface for in-kernel security controllers to acc=
ess
> > +       RPMB unit.
> > +
> > +       If unsure, select N.
> > +
> >  config TIFM_CORE
> >       tristate "TI Flash Media interface support"
> >       depends on PCI
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index ea6ea5bbbc9c..8af058ad1df4 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)         +=3D lkdtm/
> >  obj-$(CONFIG_TIFM_CORE)              +=3D tifm_core.o
> >  obj-$(CONFIG_TIFM_7XX1)              +=3D tifm_7xx1.o
> >  obj-$(CONFIG_PHANTOM)                +=3D phantom.o
> > +obj-$(CONFIG_RPMB)           +=3D rpmb-core.o
> >  obj-$(CONFIG_QCOM_COINCELL)  +=3D qcom-coincell.o
> >  obj-$(CONFIG_QCOM_FASTRPC)   +=3D fastrpc.o
> >  obj-$(CONFIG_SENSORS_BH1770) +=3D bh1770glc.o
> > diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> > new file mode 100644
> > index 000000000000..e42a45debc76
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,233 @@
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
> > +static struct list_head rpmb_dev_list;
> > +static DEFINE_MUTEX(rpmb_mutex);
> > +static struct blocking_notifier_head rpmb_interface =3D
> > +     BLOCKING_NOTIFIER_INIT(rpmb_interface);
> > +
> > +/**
> > + * rpmb_dev_get() - increase rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
> > +{
> > +     if (rdev)
> > +             get_device(rdev->parent_dev);
>
> Odd, why are you thinking the parent reference has anything to do with
> this device's reference?
>
> Why isn't this a "real" device and part of the driver model properly?
> This way of "hanging onto" a device and attempting to influence it's
> reference count is odd, please make this real and not "fake".

I did this in response to
https://lore.kernel.org/lkml/CAPDyKFqNhGWKm=3D+7niNsjXOjEJE3U=3Do7dRNG=3DJqpp=
tUSo9G-ug(a)mail.gmail.com/

Perhaps "parent_dev" isn't the best name. The struct rpmb_dev can be
seen as another representation of the underlying device. The life
cycle of struct rpmb_dev is tied to the underlying device with
rpmb_dev_register() and rpmb_dev_unregister(). Just as
rpmb_route_frames() forwards the frames to the device, rpmb_dev_{get,
put}() does the corresponding thing.

>
> Bonus, you get that notifier callback "for free" if you do that.  But
> really, notifier callbacks are a pain, are you sure you want that?

Yes, they are needed because the device may show up late and the
OP-TEE driver doesn't know if any device will show up. As Ulf pointed
out in the link above, at this point, there's no need to tell user
space about this kernel internal abstraction.

Thanks,
Jens

>
> thanks,
>
> greg k-h

--===============6416486322954404744==--

