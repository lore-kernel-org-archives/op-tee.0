From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 27 Feb 2024 16:31:30 +0100
Message-ID: <20240227153132.2611499-2-jens.wiklander@linaro.org>
In-Reply-To: <20240227153132.2611499-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7107808547128469449=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7107808547128469449==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

A number of storage technologies support a specialised hardware
partition designed to be resistant to replay attacks. The underlying
HW protocols differ but the operations are common. The RPMB partition
cannot be accessed via standard block layer, but by a set of specific
RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
partition provides authenticated and replay protected access, hence
suitable as a secure storage.

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
---
 MAINTAINERS              |   7 ++
 drivers/misc/Kconfig     |  10 ++
 drivers/misc/Makefile    |   1 +
 drivers/misc/rpmb-core.c | 258 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpmb.h     | 195 +++++++++++++++++++++++++++++
 5 files changed, 471 insertions(+)
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8999497011a2..e83152c42499 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19012,6 +19012,13 @@ T:	git git://linuxtv.org/media_tree.git
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
index 4fb291f0bf7c..dbff9e8c3a03 100644
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
index ea6ea5bbbc9c..8af058ad1df4 100644
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
index 000000000000..e0003b039e9f
--- /dev/null
+++ b/drivers/misc/rpmb-core.c
@@ -0,0 +1,258 @@
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
+static struct list_head rpmb_intf_list;
+static DEFINE_MUTEX(rpmb_mutex);
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
+	struct rpmb_frame *frm =3D (struct rpmb_frame *)req;
+	u16 req_type;
+	bool write;
+
+	if (!req || req_len < sizeof(*frm) || !rsp || !rsp_len)
+		return -EINVAL;
+
+	req_type =3D be16_to_cpu(frm->req_resp);
+	switch (req_type) {
+	case RPMB_PROGRAM_KEY:
+		if (req_len !=3D sizeof(struct rpmb_frame) ||
+		    rsp_len !=3D sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write =3D true;
+		break;
+	case RPMB_GET_WRITE_COUNTER:
+		if (req_len !=3D sizeof(struct rpmb_frame) ||
+		    rsp_len !=3D sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write =3D false;
+		break;
+	case RPMB_WRITE_DATA:
+		if (req_len % sizeof(struct rpmb_frame) ||
+		    rsp_len !=3D sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write =3D true;
+		break;
+	case RPMB_READ_DATA:
+		if (req_len !=3D sizeof(struct rpmb_frame) ||
+		    rsp_len % sizeof(struct rpmb_frame))
+			return -EINVAL;
+		write =3D false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rdev->ops->route_frames(rdev->parent_dev, write,
+				       req, req_len, rsp, rsp_len);
+}
+EXPORT_SYMBOL_GPL(rpmb_route_frames);
+
+/**
+ * rpmb_dev_find_device() - return first matching rpmb device
+ * @data: data for the match function
+ * @match: the matching function
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
+
+/**
+ * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
+ * @rdev: the rpmb device to unregister
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
+	kfree(rdev->dev_id);
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
+				   const struct rpmb_ops *ops)
+{
+	struct rpmb_dev *rdev;
+	struct rpmb_interface *intf;
+	int ret;
+
+	if (!dev || !ops || !ops->route_frames || !ops->set_dev_info)
+		return ERR_PTR(-EINVAL);
+
+	rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&rpmb_mutex);
+	list_add_tail(&rdev->list_node, &rpmb_dev_list);
+	mutex_unlock(&rpmb_mutex);
+
+	rdev->ops =3D ops;
+
+	rdev->parent_dev =3D dev;
+
+	ret =3D ops->set_dev_info(dev, rdev);
+	if (ret)
+		goto exit;
+
+	dev_dbg(rdev->parent_dev, "registered device\n");
+
+	mutex_lock(&rpmb_mutex);
+	list_for_each_entry(intf, &rpmb_intf_list, list_node)
+		if (intf->add_rdev)
+			intf->add_rdev(intf, rdev);
+	mutex_unlock(&rpmb_mutex);
+
+	return rdev;
+
+exit:
+	mutex_lock(&rpmb_mutex);
+	list_del(&rdev->list_node);
+	mutex_unlock(&rpmb_mutex);
+	kfree(rdev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_register);
+
+/**
+ * rpmb_interface_register() - register for new device notifications
+ *
+ * @intf : pointer to interface struct with a notification callback
+ */
+void rpmb_interface_register(struct rpmb_interface *intf)
+{
+	struct rpmb_dev *rdev;
+
+	mutex_lock(&rpmb_mutex);
+	list_add_tail(&intf->list_node, &rpmb_intf_list);
+	if (intf->add_rdev)
+		list_for_each_entry(rdev, &rpmb_dev_list, list_node)
+			intf->add_rdev(intf, rdev);
+	mutex_unlock(&rpmb_mutex);
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_register);
+
+/**
+ * rpmb_interface_unregister() - unregister from new device notifications
+ *
+ * @intf : pointer to previously registered interface struct
+ */
+void rpmb_interface_unregister(struct rpmb_interface *intf)
+{
+	mutex_lock(&rpmb_mutex);
+	list_del(&intf->list_node);
+	mutex_unlock(&rpmb_mutex);
+}
+EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
+
+static int __init rpmb_init(void)
+{
+	INIT_LIST_HEAD(&rpmb_dev_list);
+	INIT_LIST_HEAD(&rpmb_intf_list);
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
index 000000000000..c4b13dad10c4
--- /dev/null
+++ b/include/linux/rpmb.h
@@ -0,0 +1,195 @@
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
+
+/**
+ * struct rpmb_frame - rpmb frame as defined by specs
+ *
+ * @stuff        : stuff bytes
+ * @key_mac      : The authentication key or the message authentication
+ *                 code (MAC) depending on the request/response type.
+ *                 The MAC will be delivered in the last (or the only)
+ *                 block of data.
+ * @data         : Data to be written or read by signed access.
+ * @nonce        : Random number generated by the host for the requests
+ *                 and copied to the response by the RPMB engine.
+ * @write_counter: Counter value for the total amount of the successful
+ *                 authenticated data write requests made by the host.
+ * @addr         : Address of the data to be programmed to or read
+ *                 from the RPMB. Address is the serial number of
+ *                 the accessed block (half sector 256B).
+ * @block_count  : Number of blocks (half sectors, 256B) requested to be
+ *                 read/programmed.
+ * @result       : Includes information about the status of the write counter
+ *                 (valid, expired) and result of the access made to the RPM=
B.
+ * @req_resp     : Defines the type of request and response to/from the memo=
ry.
+ */
+struct rpmb_frame {
+	u8     stuff[196];
+	u8     key_mac[32];
+	u8     data[256];
+	u8     nonce[16];
+	__be32 write_counter;
+	__be16 addr;
+	__be16 block_count;
+	__be16 result;
+	__be16 req_resp;
+} __packed;
+
+#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key */
+#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
+#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
+#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition */
+#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal) */
+
+#define RPMB_REQ2RESP(_OP) ((_OP) << 8)
+#define RPMB_RESP2REQ(_OP) ((_OP) >> 8)
+
+/**
+ * enum rpmb_op_result - rpmb operation results
+ *
+ * @RPMB_ERR_OK      : operation successful
+ * @RPMB_ERR_GENERAL : general failure
+ * @RPMB_ERR_AUTH    : mac doesn't match or ac calculation failure
+ * @RPMB_ERR_COUNTER : counter doesn't match or counter increment failure
+ * @RPMB_ERR_ADDRESS : address out of range or wrong address alignment
+ * @RPMB_ERR_WRITE   : data, counter, or result write failure
+ * @RPMB_ERR_READ    : data, counter, or result read failure
+ * @RPMB_ERR_NO_KEY  : authentication key not yet programmed
+ *
+ * @RPMB_ERR_COUNTER_EXPIRED:  counter expired
+ */
+enum rpmb_op_result {
+	RPMB_ERR_OK      =3D 0x0000,
+	RPMB_ERR_GENERAL =3D 0x0001,
+	RPMB_ERR_AUTH    =3D 0x0002,
+	RPMB_ERR_COUNTER =3D 0x0003,
+	RPMB_ERR_ADDRESS =3D 0x0004,
+	RPMB_ERR_WRITE   =3D 0x0005,
+	RPMB_ERR_READ    =3D 0x0006,
+	RPMB_ERR_NO_KEY  =3D 0x0007,
+
+	RPMB_ERR_COUNTER_EXPIRED =3D 0x0080
+};
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
+ * struct rpmb_dev - device which can support RPMB partition
+ *
+ * @parent_dev       : parent device
+ * @list_node        : linked list node
+ * @ops              : operation exported by rpmb
+ * @dev_id           : unique device identifier read from the hardware
+ * @dev_id_len       : length of unique device identifier
+ * @reliable_wr_count: number of sectors that can be written in one access
+ * @capacity         : capacity of the device in units of 128K
+ */
+struct rpmb_dev {
+	struct device *parent_dev;
+	struct list_head list_node;
+	const struct rpmb_ops *ops;
+	u8 *dev_id;
+	size_t dev_id_len;
+	u16 reliable_wr_count;
+	u16 capacity;
+};
+
+/**
+ * struct rpmb_ops - RPMB ops to be implemented by underlying block device
+ *
+ * @type          : block device type
+ * @route_frames  : routes frames to and from the RPMB device
+ * @set_dev_info  : extracts device info from the RPMB device
+ */
+struct rpmb_ops {
+	enum rpmb_type type;
+	int (*set_dev_info)(struct device *dev, struct rpmb_dev *rdev);
+	int (*route_frames)(struct device *dev, bool write,
+			    u8 *req, unsigned int req_len,
+			    u8 *resp, unsigned int resp_len);
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
+				   const struct rpmb_ops *ops);
+int rpmb_dev_unregister(struct rpmb_dev *rdev);
+
+int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+		      unsigned int req_len, u8 *resp, unsigned int resp_len);
+
+void rpmb_interface_register(struct rpmb_interface *intf);
+void rpmb_interface_unregister(struct rpmb_interface *intf);
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
+static inline void rpmb_interface_register(struct rpmb_interface *intf) { }
+static inline void rpmb_interface_unregister(struct rpmb_interface *intf) { }
+#endif /* CONFIG_RPMB */
+
+#endif /* __RPMB_H__ */
--=20
2.34.1


--===============7107808547128469449==--

