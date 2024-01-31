From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 31 Jan 2024 18:43:45 +0100
Message-ID: <20240131174347.510961-2-jens.wiklander@linaro.org>
In-Reply-To: <20240131174347.510961-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3640451266329963582=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3640451266329963582==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

A number of storage technologies support a specialised hardware
partition designed to be resistant to replay attacks. The underlying
HW protocols differ but the operations are common. The RPMB partition
cannot be accessed via standard block layer, but by a set of specific
RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
partition provides authenticated and replay protected access, hence
suitable as a secure storage.

The initial aim of this patch is to provide a simple RPMB Driver which
can be accessed by the optee driver to facilitate early RPMB access to
OP-TEE OS (secure OS) during the boot time.

A TEE device driver can claim the RPMB interface, for example, via
class_interface_register() or rpmb_dev_find_device(). The RPMB driver
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
 drivers/misc/Kconfig     |   9 ++
 drivers/misc/Makefile    |   1 +
 drivers/misc/rpmb-core.c | 247 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpmb.h     | 184 +++++++++++++++++++++++++++++
 5 files changed, 448 insertions(+)
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
index 4fb291f0bf7c..891aa5763666 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -104,6 +104,15 @@ config PHANTOM
 	  If you choose to build module, its name will be phantom. If unsure,
 	  say N here.
=20
+config RPMB
+	tristate "RPMB partition interface"
+	help
+	  Unified RPMB unit interface for RPMB capable devices such as eMMC and
+	  UFS. Provides interface for in kernel security controllers to access
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
index 000000000000..a3c289051687
--- /dev/null
+++ b/drivers/misc/rpmb-core.c
@@ -0,0 +1,247 @@
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
+static DEFINE_IDA(rpmb_ida);
+static DEFINE_MUTEX(rpmb_mutex);
+
+/**
+ * rpmb_dev_get() - increase rpmb device ref counter
+ * @rdev: rpmb device
+ */
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	if (rdev)
+		get_device(&rdev->dev);
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
+		put_device(&rdev->dev);
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
+ * @return < 0 on failure
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
+	return rdev->ops->route_frames(rdev->dev.parent, write,
+				       req, req_len, rsp, rsp_len);
+}
+EXPORT_SYMBOL_GPL(rpmb_route_frames);
+
+static void rpmb_dev_release(struct device *dev)
+{
+	struct rpmb_dev *rdev =3D to_rpmb_dev(dev);
+
+	rdev->ops->put_resources(rdev->dev.parent);
+	mutex_lock(&rpmb_mutex);
+	ida_simple_remove(&rpmb_ida, rdev->id);
+	mutex_unlock(&rpmb_mutex);
+	kfree(rdev->dev_id);
+	kfree(rdev);
+}
+
+struct class rpmb_class =3D {
+	.name =3D "rpmb",
+	.dev_release =3D rpmb_dev_release,
+};
+EXPORT_SYMBOL(rpmb_class);
+
+/**
+ * rpmb_dev_find_device() - return first matching rpmb device
+ * @data: data for the match function
+ * @match: the matching function
+ *
+ * @returns a matching rpmb device or NULL on failure
+ */
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      const struct rpmb_dev *start,
+				      int (*match)(struct device *dev,
+						   const void *data))
+{
+	struct device *dev;
+	const struct device *start_dev =3D NULL;
+
+	if (start)
+		start_dev =3D &start->dev;
+	dev =3D class_find_device(&rpmb_class, start_dev, data, match);
+
+	return dev ? to_rpmb_dev(dev) : NULL;
+}
+
+/**
+ * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
+ * @rdev: the rpmb device to unregister
+ *
+ * @returns < 0 on failure
+ */
+int rpmb_dev_unregister(struct rpmb_dev *rdev)
+{
+	if (!rdev)
+		return -EINVAL;
+
+	device_del(&rdev->dev);
+
+	rpmb_dev_put(rdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
+
+/**
+ * rpmb_dev_register - register RPMB partition with the RPMB subsystem
+ * @dev: storage device of the rpmb device
+ * @target: RPMB target/region within the physical device
+ * @ops: device specific operations
+ *
+ * While registering the RPMB partition get references to needed resources
+ * with the @ops->get_resources() callback and extracts needed devices
+ * information while needed resources are available.
+ *
+ * @returns a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
+ */
+struct rpmb_dev *rpmb_dev_register(struct device *dev,
+				   const struct rpmb_ops *ops)
+{
+	struct rpmb_dev *rdev;
+	int id;
+	int ret;
+
+	if (!dev || !ops || !ops->get_resources ||
+	    !ops->put_resources || !ops->route_frames ||
+	    !ops->set_dev_info)
+		return ERR_PTR(-EINVAL);
+
+	rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&rpmb_mutex);
+	id =3D ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
+	mutex_unlock(&rpmb_mutex);
+	if (id < 0) {
+		ret =3D id;
+		goto exit;
+	}
+
+	rdev->ops =3D ops;
+	rdev->id =3D id;
+
+	dev_set_name(&rdev->dev, "rpmb%d", id);
+	rdev->dev.class =3D &rpmb_class;
+	rdev->dev.parent =3D dev;
+
+	ret =3D ops->set_dev_info(dev, rdev);
+	if (ret)
+		goto exit;
+
+	ret =3D device_register(&rdev->dev);
+	if (ret)
+		goto exit;
+
+	ops->get_resources(rdev->dev.parent);
+
+	dev_dbg(&rdev->dev, "registered device\n");
+
+	return rdev;
+
+exit:
+	if (id >=3D 0) {
+		mutex_lock(&rpmb_mutex);
+		ida_simple_remove(&rpmb_ida, id);
+		mutex_unlock(&rpmb_mutex);
+	}
+	kfree(rdev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_register);
+
+static int __init rpmb_init(void)
+{
+	int rc;
+
+	rc =3D class_register(&rpmb_class);
+	if (rc) {
+		pr_err("couldn't create class\n");
+		return rc;
+	}
+	ida_init(&rpmb_ida);
+	return 0;
+}
+
+static void __exit rpmb_exit(void)
+{
+	ida_destroy(&rpmb_ida);
+	class_unregister(&rpmb_class);
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
index 000000000000..45073513264a
--- /dev/null
+++ b/include/linux/rpmb.h
@@ -0,0 +1,184 @@
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
+ * enum rpmb_type - type of underlaying storage technology
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
+ * @dev              : device
+ * @id               : device id;
+ * @ops              : operation exported by rpmb
+ * @dev_id           : unique device identifier read from the hardware
+ * @dev_id_len       : length of unique device identifier
+ * @reliable_wr_count: number of sectors that can be written in one access
+ * @capacity         : capacity of the device in units of 128K
+ */
+struct rpmb_dev {
+	struct device dev;
+	int id;
+	const struct rpmb_ops *ops;
+	u8 *dev_id;
+	size_t dev_id_len;
+	u16 reliable_wr_count;
+	u16 capacity;
+};
+
+#define to_rpmb_dev(x) container_of((x), struct rpmb_dev, dev)
+
+/**
+ * struct rpmb_ops - RPMB ops to be implemented by underlying block device
+ *
+ * @type          : block device type
+ * @get_resources : gets references to needed resources in rpmb_dev_register=
()
+ * @put_resources : puts references from resources in rpmb_dev_release()
+ * @route_frames  : routes frames to and from the RPMB device
+ * @get_dev_info  : extracts device info from the RPMB device
+ */
+struct rpmb_ops {
+	enum rpmb_type type;
+	void (*get_resources)(struct device *dev);
+	void (*put_resources)(struct device *dev);
+	int (*set_dev_info)(struct device *dev, struct rpmb_dev *rdev);
+	int (*route_frames)(struct device *dev, bool write,
+			    u8 *req, unsigned int req_len,
+			    u8 *resp, unsigned int resp_len);
+};
+
+#if IS_ENABLED(CONFIG_RPMB)
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
+void rpmb_dev_put(struct rpmb_dev *rdev);
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      const struct rpmb_dev *start,
+				      int (*match)(struct device *dev,
+						   const void *data));
+struct rpmb_dev *rpmb_dev_register(struct device *dev,
+				   const struct rpmb_ops *ops);
+int rpmb_dev_unregister(struct rpmb_dev *rdev);
+
+int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
+		      unsigned int req_len, u8 *resp, unsigned int resp_len);
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
+		     int (*match)(struct device *dev, const void *data))
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
+#endif /* CONFIG_RPMB */
+
+#endif /* __RPMB_H__ */
--=20
2.34.1


--===============3640451266329963582==--

