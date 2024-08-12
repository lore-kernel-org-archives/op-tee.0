From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Mon, 12 Aug 2024 15:31:24 +0200
Message-ID: <20240812133127.865879-2-jens.wiklander@linaro.org>
In-Reply-To: <20240812133127.865879-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5915011965501475099=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5915011965501475099==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

A number of storage technologies support a specialised hardware
partition designed to be resistant to replay attacks. The underlying
HW protocols differ but the operations are common. The RPMB partition
cannot be accessed via standard block layer, but by a set of specific
RPMB commands. Such a partition provides authenticated and replay
protected access, hence suitable as a secure storage.

The initial aim of this patch is to provide a simple RPMB driver
interface which can be accessed by the optee driver to facilitate early
RPMB access to OP-TEE OS (secure OS) during the boot time.

A TEE device driver can claim the RPMB interface, for example, via
rpmb_interface_register() or rpmb_dev_find_device(). The RPMB driver
provides a callback to route RPMB frames to the RPMB device accessible
via rpmb_route_frames().

The detailed operation of implementing the access is left to the TEE
device driver itself.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Manuel Traut <manut@mecka.net>
---
 MAINTAINERS              |   7 ++
 drivers/misc/Kconfig     |  10 ++
 drivers/misc/Makefile    |   1 +
 drivers/misc/rpmb-core.c | 233 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpmb.h     | 136 +++++++++++++++++++++++
 5 files changed, 387 insertions(+)
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..716011964b18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19838,6 +19838,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-rotate.y=
aml
 F:	drivers/media/platform/sunxi/sun8i-rotate/
=20
+RPMB SUBSYSTEM
+M:	Jens Wiklander <jens.wiklander@linaro.org>
+L:	linux-kernel(a)vger.kernel.org
+S:	Supported
+F:	drivers/misc/rpmb-core.c
+F:	include/linux/rpmb.h
+
 RPMSG TTY DRIVER
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	linux-remoteproc(a)vger.kernel.org
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41c3d2821a78..21403392d809 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -104,6 +104,16 @@ config PHANTOM
 	  If you choose to build module, its name will be phantom. If unsure,
 	  say N here.
=20
+config RPMB
+	tristate "RPMB partition interface"
+	depends on MMC
+	help
+	  Unified RPMB unit interface for RPMB capable devices such as eMMC and
+	  UFS. Provides interface for in-kernel security controllers to access
+	  RPMB unit.
+
+	  If unsure, select N.
+
 config TIFM_CORE
 	tristate "TI Flash Media interface support"
 	depends on PCI
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c2f990862d2b..a9f94525e181 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_LKDTM)		+=3D lkdtm/
 obj-$(CONFIG_TIFM_CORE)       	+=3D tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+=3D tifm_7xx1.o
 obj-$(CONFIG_PHANTOM)		+=3D phantom.o
+obj-$(CONFIG_RPMB)		+=3D rpmb-core.o
 obj-$(CONFIG_QCOM_COINCELL)	+=3D qcom-coincell.o
 obj-$(CONFIG_QCOM_FASTRPC)	+=3D fastrpc.o
 obj-$(CONFIG_SENSORS_BH1770)	+=3D bh1770glc.o
diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
new file mode 100644
index 000000000000..e42a45debc76
--- /dev/null
+++ b/drivers/misc/rpmb-core.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
+ * Copyright(c) 2021 - 2024 Linaro Ltd.
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rpmb.h>
+#include <linux/slab.h>
+
+static struct list_head rpmb_dev_list;
+static DEFINE_MUTEX(rpmb_mutex);
+static struct blocking_notifier_head rpmb_interface =3D
+	BLOCKING_NOTIFIER_INIT(rpmb_interface);
+
+/**
+ * rpmb_dev_get() - increase rpmb device ref counter
+ * @rdev: rpmb device
+ */
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	if (rdev)
+		get_device(rdev->parent_dev);
+	return rdev;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_get);
+
+/**
+ * rpmb_dev_put() - decrease rpmb device ref counter
+ * @rdev: rpmb device
+ */
+void rpmb_dev_put(struct rpmb_dev *rdev)
+{
+	if (rdev)
+		put_device(rdev->parent_dev);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_put);
+
+/**
+ * rpmb_route_frames() - route rpmb frames to rpmb device
+ * @rdev:	rpmb device
+ * @req:	rpmb request frames
+ * @req_len:	length of rpmb request frames in bytes
+ * @rsp:	rpmb response frames
+ * @rsp_len:	length of rpmb response frames in bytes
+ *
+ * Returns: < 0 on failure
+ */
+int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+		      unsigned int req_len, u8 *rsp, unsigned int rsp_len)
+{
+	if (!req || !req_len || !rsp || !rsp_len)
+		return -EINVAL;
+
+	return rdev->descr.route_frames(rdev->parent_dev, req, req_len,
+					rsp, rsp_len);
+}
+EXPORT_SYMBOL_GPL(rpmb_route_frames);
+
+/**
+ * rpmb_dev_find_device() - return first matching rpmb device
+ * @data: data for the match function
+ * @match: the matching function
+ *
+ * Iterate over registered RPMB devices, and call @match() for each passing
+ * it the RPMB device and @data.
+ *
+ * The return value of @match() is checked for each call. If it returns
+ * anything other 0, break and return the found RPMB device.
+ *
+ * It's the callers responsibility to call rpmb_dev_put() on the returned
+ * device, when it's done with it.
+ *
+ * Returns: a matching rpmb device or NULL on failure
+ */
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      const struct rpmb_dev *start,
+				      int (*match)(struct rpmb_dev *rdev,
+						   const void *data))
+{
+	struct rpmb_dev *rdev;
+	struct list_head *pos;
+
+	mutex_lock(&rpmb_mutex);
+	if (start)
+		pos =3D start->list_node.next;
+	else
+		pos =3D rpmb_dev_list.next;
+
+	while (pos !=3D &rpmb_dev_list) {
+		rdev =3D container_of(pos, struct rpmb_dev, list_node);
+		if (match(rdev, data)) {
+			rpmb_dev_get(rdev);
+			goto out;
+		}
+		pos =3D pos->next;
+	}
+	rdev =3D NULL;
+
+out:
+	mutex_unlock(&rpmb_mutex);
+
+	return rdev;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_find_device);
+
+/**
+ * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
+ * @rdev: the rpmb device to unregister
+ *
+ * This function should be called from the release function of the
+ * underlying device used when the RPMB device was registered.
+ *
+ * Returns: < 0 on failure
+ */
+int rpmb_dev_unregister(struct rpmb_dev *rdev)
+{
+	if (!rdev)
+		return -EINVAL;
+
+	mutex_lock(&rpmb_mutex);
+	list_del(&rdev->list_node);
+	mutex_unlock(&rpmb_mutex);
+	kfree(rdev->descr.dev_id);
+	kfree(rdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
+
+/**
+ * rpmb_dev_register - register RPMB partition with the RPMB subsystem
+ * @dev: storage device of the rpmb device
+ * @ops: device specific operations
+ *
+ * While registering the RPMB partition extract needed device information
+ * while needed resources are available.
+ *
+ * Returns: a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
+ */
+struct rpmb_dev *rpmb_dev_register(struct device *dev,
+				   struct rpmb_descr *descr)
+{
+	struct rpmb_dev *rdev;
+
+	if (!dev || !descr || !descr->route_frames || !descr->dev_id ||
+	    !descr->dev_id_len)
+		return ERR_PTR(-EINVAL);
+
+	rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+	rdev->descr =3D *descr;
+	rdev->descr.dev_id =3D kmemdup(descr->dev_id, descr->dev_id_len,
+				     GFP_KERNEL);
+	if (!rdev->descr.dev_id) {
+		kfree(rdev);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	rdev->parent_dev =3D dev;
+
+	dev_dbg(rdev->parent_dev, "registered device\n");
+
+	mutex_lock(&rpmb_mutex);
+	list_add_tail(&rdev->list_node, &rpmb_dev_list);
+	blocking_notifier_call_chain(&rpmb_interface, RPMB_NOTIFY_ADD_DEVICE,
+				     rdev);
+	mutex_unlock(&rpmb_mutex);
+
+	return rdev;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_register);
+
+/**
+ * rpmb_interface_register() - register for new device notifications
+ *
+ * @nb : New entry in notifier chain
+ *
+ * Returns: 0 on success  -EEXIST on error.
+ */
+int rpmb_interface_register(struct notifier_block *nb)
+{
+	struct rpmb_dev *rdev;
+	int ret;
+
+	ret =3D blocking_notifier_chain_register(&rpmb_interface, nb);
+	if (ret)
+		return ret;
+
+	mutex_lock(&rpmb_mutex);
+	list_for_each_entry(rdev, &rpmb_dev_list, list_node)
+		nb->notifier_call(nb, RPMB_NOTIFY_ADD_DEVICE, rdev);
+	mutex_unlock(&rpmb_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_register);
+
+/**
+ * rpmb_interface_unregister() - unregister from new device notifications
+ *
+ * @nb : Entry to remove from notifier chain
+ *
+ * Returns: 0 on success or -ENOENT on failure.
+ */
+int rpmb_interface_unregister(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&rpmb_interface, nb);
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
+
+static int __init rpmb_init(void)
+{
+	INIT_LIST_HEAD(&rpmb_dev_list);
+	return 0;
+}
+
+static void __exit rpmb_exit(void)
+{
+	mutex_destroy(&rpmb_mutex);
+}
+
+subsys_initcall(rpmb_init);
+module_exit(rpmb_exit);
+
+MODULE_AUTHOR("Jens Wiklander <jens.wiklander@linaro.org>");
+MODULE_DESCRIPTION("RPMB class");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
new file mode 100644
index 000000000000..3ced206fdc17
--- /dev/null
+++ b/include/linux/rpmb.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Intel Corp. All rights reserved
+ * Copyright (C) 2021-2022 Linaro Ltd
+ */
+#ifndef __RPMB_H__
+#define __RPMB_H__
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/notifier.h>
+
+/**
+ * enum rpmb_type - type of underlying storage technology
+ *
+ * @RPMB_TYPE_EMMC  : emmc (JESD84-B50.1)
+ * @RPMB_TYPE_UFS   : UFS (JESD220)
+ * @RPMB_TYPE_NVME  : NVM Express
+ */
+enum rpmb_type {
+	RPMB_TYPE_EMMC,
+	RPMB_TYPE_UFS,
+	RPMB_TYPE_NVME,
+};
+
+/**
+ * struct rpmb_descr - RPMB description provided by the underlying block dev=
ice
+ *
+ * @type             : block device type
+ * @route_frames     : routes frames to and from the RPMB device
+ * @dev_id           : unique device identifier read from the hardware
+ * @dev_id_len       : length of unique device identifier
+ * @reliable_wr_count: number of sectors that can be written in one access
+ * @capacity         : capacity of the device in units of 128K
+ *
+ * @dev_id is intended to be used as input when deriving the authenticaion k=
ey.
+ */
+struct rpmb_descr {
+	enum rpmb_type type;
+	int (*route_frames)(struct device *dev, u8 *req, unsigned int req_len,
+			    u8 *resp, unsigned int resp_len);
+	u8 *dev_id;
+	size_t dev_id_len;
+	u16 reliable_wr_count;
+	u16 capacity;
+};
+
+/**
+ * struct rpmb_dev - device which can support RPMB partition
+ *
+ * @parent_dev       : parent device
+ * @list_node        : linked list node
+ * @descr            : RPMB description
+ */
+struct rpmb_dev {
+	struct device *parent_dev;
+	struct list_head list_node;
+	struct rpmb_descr descr;
+};
+
+enum rpmb_interface_action {
+	RPMB_NOTIFY_ADD_DEVICE,
+};
+
+/**
+ * struct rpmb_interface - subscribe to new RPMB devices
+ *
+ * @list_node     : linked list node
+ * @add_rdev      : notifies that a new RPMB device has been found
+ */
+struct rpmb_interface {
+	struct list_head list_node;
+	void (*add_rdev)(struct rpmb_interface *intf, struct rpmb_dev *rdev);
+};
+
+#if IS_ENABLED(CONFIG_RPMB)
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
+void rpmb_dev_put(struct rpmb_dev *rdev);
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      const struct rpmb_dev *start,
+				      int (*match)(struct rpmb_dev *rdev,
+						   const void *data));
+struct rpmb_dev *rpmb_dev_register(struct device *dev,
+				   struct rpmb_descr *descr);
+int rpmb_dev_unregister(struct rpmb_dev *rdev);
+
+int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+		      unsigned int req_len, u8 *resp, unsigned int resp_len);
+
+int rpmb_interface_register(struct notifier_block *nb);
+int rpmb_interface_unregister(struct notifier_block *nb);
+#else
+static inline struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	return NULL;
+}
+
+static inline void rpmb_dev_put(struct rpmb_dev *rdev) { }
+
+static inline struct rpmb_dev *
+rpmb_dev_find_device(const void *data, const struct rpmb_dev *start,
+		     int (*match)(struct rpmb_dev *rdev, const void *data))
+{
+	return NULL;
+}
+
+static inline struct rpmb_dev *
+rpmb_dev_register(struct device *dev, const struct rpmb_ops *ops)
+{
+	return NULL;
+}
+
+static inline int rpmb_dev_unregister(struct rpmb_dev *dev)
+{
+	return 0;
+}
+
+static inline int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+				    unsigned int req_len, u8 *resp,
+				    unsigned int resp_len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmb_interface_register(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmb_interface_unregister(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_RPMB */
+
+#endif /* __RPMB_H__ */
--=20
2.34.1


--===============5915011965501475099==--

