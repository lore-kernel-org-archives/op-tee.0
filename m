From: Avri Altman <Avri.Altman@wdc.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v4 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Sat, 06 Apr 2024 10:27:18 +0000
Message-ID: <DM6PR04MB65757A966792C93334DE4BF1FC022@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <20240405115318.904143-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4451859066415585376=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4451859066415585376==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> A number of storage technologies support a specialised hardware
> partition designed to be resistant to replay attacks. The underlying
> HW protocols differ but the operations are common. The RPMB partition
> cannot be accessed via standard block layer, but by a set of specific
> RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY.
What about the other rpmb operations?
There are 7 operations in eMMC.

............

> +/**
> + * rpmb_dev_find_device() - return first matching rpmb device
> + * @data: data for the match function
> + * @match: the matching function
> + *
> + * Iterate over registered RPMB devices, and call @match() for each passing
> + * it the RPMB device and @data.
> + *
> + * The return value of @match() is checked for each call. If it returns
> + * anything other 0, break and return the found RPMB device.
> + *
> + * It's the callers responsibility to call rpmb_dev_put() on the returned
> + * device, when it's done with it.
> + *
> + * Returns: a matching rpmb device or NULL on failure
> + */
> +struct rpmb_dev *rpmb_dev_find_device(const void *data,
> +                                     const struct rpmb_dev *start,
> +                                     int (*match)(struct rpmb_dev *rdev,
> +                                                  const void *data))
> +{
> +       struct rpmb_dev *rdev;
> +       struct list_head *pos;
> +
> +       mutex_lock(&rpmb_mutex);
> +       if (start)
> +               pos =3D start->list_node.next;
> +       else
> +               pos =3D rpmb_dev_list.next;
> +
> +       while (pos !=3D &rpmb_dev_list) {
Why not just list_for_each_entry instead?

> +               rdev =3D container_of(pos, struct rpmb_dev, list_node);
> +               if (match(rdev, data)) {
> +                       rpmb_dev_get(rdev);
> +                       goto out;
> +               }
> +               pos =3D pos->next;
> +       }
> +       rdev =3D NULL;
> +
> +out:
> +       mutex_unlock(&rpmb_mutex);
> +
> +       return rdev;
> +}

.....................

> +/**
> + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
> + * @dev: storage device of the rpmb device
> + * @ops: device specific operations
> + *
> + * While registering the RPMB partition extract needed device information
> + * while needed resources are available.
> + *
> + * Returns: a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
> + */
> +struct rpmb_dev *rpmb_dev_register(struct device *dev,
> +                                  struct rpmb_descr *descr)
> +{
> +       struct rpmb_dev *rdev;
> +
> +       if (!dev || !descr || !descr->route_frames || !descr->dev_id ||
> +           !descr->dev_id_len)
> +               return ERR_PTR(-EINVAL);
> +
> +       rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> +       if (!rdev)
> +               return ERR_PTR(-ENOMEM);
> +       rdev->descr =3D *descr;
> +       rdev->descr.dev_id =3D kmemdup(descr->dev_id, descr->dev_id_len,
> +                                    GFP_KERNEL);
In addition to the dev_id, wouldn't it make sense to have your own IDA as wel=
l?

> +       if (!rdev->descr.dev_id) {
> +               kfree(rdev);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       rdev->parent_dev =3D dev;
> +
> +       dev_dbg(rdev->parent_dev, "registered device\n");
> +
> +       mutex_lock(&rpmb_mutex);
> +       list_add_tail(&rdev->list_node, &rpmb_dev_list);
> +       blocking_notifier_call_chain(&rpmb_interface,
> RPMB_NOTIFY_ADD_DEVICE,
> +                                    rdev);
> +       mutex_unlock(&rpmb_mutex);
> +
> +       return rdev;
> +}
> +EXPORT_SYMBOL_GPL(rpmb_dev_register);

............

> new file mode 100644
> index 000000000000..251d6b7e6d15
> --- /dev/null
> +++ b/include/linux/rpmb.h
> @@ -0,0 +1,136 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> +/*
> + * Copyright (C) 2015-2019 Intel Corp. All rights reserved
> + * Copyright (C) 2021-2022 Linaro Ltd
> + */
> +#ifndef __RPMB_H__
> +#define __RPMB_H__
> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/notifier.h>
> +
> +/**
> + * enum rpmb_type - type of underlying storage technology
> + *
> + * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
> + * @RPMB_TYPE_UFS   : UFS (JESD220)
> + * @RPMB_TYPE_NVME  : NVM Express
> + */
> +enum rpmb_type {
> +       RPMB_TYPE_EMMC,
> +       RPMB_TYPE_UFS,
> +       RPMB_TYPE_NVME,
> +};
> +
> +/**
> + * struct rpmb_descr - RPMB descriptor provided by the underlying block
> device
The use of the term "rpmb descriptor" may be slightly misleading.
This is because in UFS there are various descriptors that identifies various =
characteristics,
e.g. device descriptor, geometry descriptor, unit descriptor etc.,=20
and recently UFS4.0 introduced a new descriptor - RPMB descriptor....

Thanks,
Avri

--===============4451859066415585376==--

