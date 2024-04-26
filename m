From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v5 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Fri, 26 Apr 2024 15:08:07 +0200
Message-ID: 
 <CAHUa44EsO9rr2_KsmNcwoUuL_OAO-Oh8gqepUn5Bmo1dfP_LUA@mail.gmail.com>
In-Reply-To: <ZioWLgVJ7Ky4nUxC@mecka.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0998587552494858451=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0998587552494858451==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 10:37=E2=80=AFAM Manuel Traut <manut@mecka.net> wro=
te:
>
> On Mon, Apr 22, 2024 at 11:19:34AM +0200, Jens Wiklander wrote:
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
> >  drivers/misc/rpmb-core.c | 232 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/rpmb.h     | 136 +++++++++++++++++++++++
> >  5 files changed, 386 insertions(+)
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
> > index 000000000000..5479469c26f3
> > --- /dev/null
> > +++ b/drivers/misc/rpmb-core.c
> > @@ -0,0 +1,232 @@
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
> > +     return rdev;
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_get);
> > +
> > +/**
> > + * rpmb_dev_put() - decrease rpmb device ref counter
> > + * @rdev: rpmb device
> > + */
> > +void rpmb_dev_put(struct rpmb_dev *rdev)
> > +{
> > +     if (rdev)
> > +             put_device(rdev->parent_dev);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_dev_put);
> > +
> > +/**
> > + * rpmb_route_frames() - route rpmb frames to rpmb device
> > + * @rdev:    rpmb device
> > + * @req:     rpmb request frames
> > + * @req_len: length of rpmb request frames in bytes
> > + * @rsp:     rpmb response frames
> > + * @rsp_len: length of rpmb response frames in bytes
> > + *
> > + * Returns: < 0 on failure
> > + */
> > +int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
> > +                   unsigned int req_len, u8 *rsp, unsigned int rsp_len)
> > +{
> > +     if (!req || !req_len || !rsp || !rsp_len)
> > +             return -EINVAL;
> > +
> > +     return rdev->descr.route_frames(rdev->parent_dev, req, req_len,
> > +                                     rsp, rsp_len);
> > +}
> > +EXPORT_SYMBOL_GPL(rpmb_route_frames);
> > +
> > +/**
> > + * rpmb_dev_find_device() - return first matching rpmb device
> > + * @data: data for the match function
> > + * @match: the matching function
> > + *
> > + * Iterate over registered RPMB devices, and call @match() for each pass=
ing
> > + * it the RPMB device and @data.
> > + *
> > + * The return value of @match() is checked for each call. If it returns
> > + * anything other 0, break and return the found RPMB device.
> > + *
> > + * It's the callers responsibility to call rpmb_dev_put() on the returned
> > + * device, when it's done with it.
> > + *
> > + * Returns: a matching rpmb device or NULL on failure
> > + */
> > +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> > +                                   const struct rpmb_dev *start,
> > +                                   int (*match)(struct rpmb_dev *rdev,
> > +                                                const void *data))
> > +{
> > +     struct rpmb_dev *rdev;
> > +     struct list_head *pos;
> > +
> > +     mutex_lock(&rpmb_mutex);
> > +     if (start)
> > +             pos =3D start->list_node.next;
> > +     else
> > +             pos =3D rpmb_dev_list.next;
> > +
> > +     while (pos !=3D &rpmb_dev_list) {
> > +             rdev =3D container_of(pos, struct rpmb_dev, list_node);
> > +             if (match(rdev, data)) {
> > +                     rpmb_dev_get(rdev);
> > +                     goto out;
> > +             }
> > +             pos =3D pos->next;
> > +     }
> > +     rdev =3D NULL;
> > +
> > +out:
> > +     mutex_unlock(&rpmb_mutex);
> > +
> > +     return rdev;
> > +}
>
> EXPORT_SYMBOL_GPL missing?

You're right, I'll add it.

Thanks,
Jens

--===============0998587552494858451==--

