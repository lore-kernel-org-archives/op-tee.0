From: Clément Léger <clement.leger@bootlin.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4] rtc: optee: add RTC driver for OP-TEE RTC PTA
Date: Tue, 08 Mar 2022 14:35:05 +0100
Message-ID: <20220308133505.471601-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6238327764601068960=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6238327764601068960==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This drivers allows to communicate with a RTC PTA handled by OP-TEE [1].
This PTA allows to query RTC information, set/get time and set/get
offset depending on the supported features.

[1] https://github.com/OP-TEE/optee_os/pull/5179

Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
---

Changes in v4:
 - Remove error prints except the ones in probe

Changes in v3 (was resent as a second v2 due to a mistake);
 - Fix error messages to include ret value and fix wrong IOCTL names
 - Use 100 columns char limit

Changes in v2:
 - Rebased over tee-shm-for-v5.18
 - Switch to tee_shm_alloc_kernel_buf()
 - Use export_uuid() to copy uuid
 - Fix warnings reported by checkpatch
 - Free SHM in error exit path

 MAINTAINERS             |   6 +
 drivers/rtc/Kconfig     |  10 ++
 drivers/rtc/Makefile    |   1 +
 drivers/rtc/rtc-optee.c | 362 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 drivers/rtc/rtc-optee.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..b21375ad73d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14361,6 +14361,12 @@ L:	op-tee(a)lists.trustedfirmware.org
 S:	Maintained
 F:	drivers/char/hw_random/optee-rng.c
=20
+OP-TEE RTC DRIVER
+M:	Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
+L:	linux-rtc(a)vger.kernel.org
+S:	Maintained
+F:	drivers/rtc/rtc-optee.c
+
 OPA-VNIC DRIVER
 M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
 M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index d85a3c31347c..cba5427f79b3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1293,6 +1293,16 @@ config RTC_DRV_OPAL
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-opal.
=20
+config RTC_DRV_OPTEE
+	tristate "OP-TEE based RTC driver"
+	depends on OPTEE
+	help
+	  Select this to get support for OP-TEE based RTC control on SoCs where
+	  RTC are not accessible to the normal world (Linux).
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-optee.
+
 config RTC_DRV_ZYNQMP
 	tristate "Xilinx Zynq Ultrascale+ MPSoC RTC"
 	depends on OF && HAS_IOMEM
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index e92f3e943245..2d827d8261d5 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -115,6 +115,7 @@ obj-$(CONFIG_RTC_DRV_GAMECUBE)	+=3D rtc-gamecube.o
 obj-$(CONFIG_RTC_DRV_NTXEC)	+=3D rtc-ntxec.o
 obj-$(CONFIG_RTC_DRV_OMAP)	+=3D rtc-omap.o
 obj-$(CONFIG_RTC_DRV_OPAL)	+=3D rtc-opal.o
+obj-$(CONFIG_RTC_DRV_OPTEE)	+=3D rtc-optee.o
 obj-$(CONFIG_RTC_DRV_PALMAS)	+=3D rtc-palmas.o
 obj-$(CONFIG_RTC_DRV_PCAP)	+=3D rtc-pcap.o
 obj-$(CONFIG_RTC_DRV_PCF2123)	+=3D rtc-pcf2123.o
diff --git a/drivers/rtc/rtc-optee.c b/drivers/rtc/rtc-optee.c
new file mode 100644
index 000000000000..9f8b5d4a8f6b
--- /dev/null
+++ b/drivers/rtc/rtc-optee.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Microchip.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/tee_drv.h>
+
+#define RTC_INFO_VERSION	0x1
+
+#define TA_CMD_RTC_GET_INFO		0x0
+#define TA_CMD_RTC_GET_TIME		0x1
+#define TA_CMD_RTC_SET_TIME		0x2
+#define TA_CMD_RTC_GET_OFFSET		0x3
+#define TA_CMD_RTC_SET_OFFSET		0x4
+
+#define TA_RTC_FEATURE_CORRECTION	BIT(0)
+
+struct optee_rtc_time {
+	u32 tm_sec;
+	u32 tm_min;
+	u32 tm_hour;
+	u32 tm_mday;
+	u32 tm_mon;
+	u32 tm_year;
+	u32 tm_wday;
+};
+
+struct optee_rtc_info {
+	u64 version;
+	u64 features;
+	struct optee_rtc_time range_min;
+	struct optee_rtc_time range_max;
+};
+
+/**
+ * struct optee_rtc - OP-TEE RTC private data
+ * @dev:		OP-TEE based RTC device.
+ * @ctx:		OP-TEE context handler.
+ * @session_id:		RTC TA session identifier.
+ * @shm:		Memory pool shared with RTC device.
+ * @features:		Bitfield of RTC features
+ */
+struct optee_rtc {
+	struct device *dev;
+	struct tee_context *ctx;
+	u32 session_id;
+	struct tee_shm *shm;
+	u64 features;
+};
+
+static int optee_rtc_readtime(struct device *dev, struct rtc_time *tm)
+{
+	struct optee_rtc *priv =3D dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg =3D {0};
+	struct optee_rtc_time *optee_tm;
+	struct tee_param param[4] =3D {0};
+	int ret;
+
+	inv_arg.func =3D TA_CMD_RTC_GET_TIME;
+	inv_arg.session =3D priv->session_id;
+	inv_arg.num_params =3D 4;
+
+	/* Fill invoke cmd params */
+	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[0].u.memref.shm =3D priv->shm;
+	param[0].u.memref.size =3D sizeof(struct optee_rtc_time);
+
+	ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret !=3D 0)
+		return ret ? ret : -EPROTO;
+
+	optee_tm =3D tee_shm_get_va(priv->shm, 0);
+	if (IS_ERR(optee_tm))
+		return PTR_ERR(optee_tm);
+
+	if (param[0].u.memref.size !=3D sizeof(*optee_tm))
+		return -EPROTO;
+
+	tm->tm_sec =3D optee_tm->tm_sec;
+	tm->tm_min =3D optee_tm->tm_min;
+	tm->tm_hour =3D optee_tm->tm_hour;
+	tm->tm_mday =3D optee_tm->tm_mday;
+	tm->tm_mon =3D optee_tm->tm_mon;
+	tm->tm_year =3D optee_tm->tm_year - 1900;
+	tm->tm_wday =3D optee_tm->tm_wday;
+	tm->tm_yday =3D rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
+
+	return 0;
+}
+
+static int optee_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	struct optee_rtc *priv =3D dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg =3D {0};
+	struct tee_param param[4] =3D {0};
+	struct optee_rtc_time optee_tm;
+	void *rtc_data;
+	int ret;
+
+	optee_tm.tm_sec =3D tm->tm_sec;
+	optee_tm.tm_min =3D tm->tm_min;
+	optee_tm.tm_hour =3D tm->tm_hour;
+	optee_tm.tm_mday =3D tm->tm_mday;
+	optee_tm.tm_mon =3D tm->tm_mon;
+	optee_tm.tm_year =3D tm->tm_year + 1900;
+	optee_tm.tm_wday =3D tm->tm_wday;
+
+	inv_arg.func =3D TA_CMD_RTC_SET_TIME;
+	inv_arg.session =3D priv->session_id;
+	inv_arg.num_params =3D 4;
+
+	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[0].u.memref.shm =3D priv->shm;
+	param[0].u.memref.size =3D sizeof(struct optee_rtc_time);
+
+	rtc_data =3D tee_shm_get_va(priv->shm, 0);
+	if (IS_ERR(rtc_data))
+		return PTR_ERR(rtc_data);
+
+	memcpy(rtc_data, &optee_tm, sizeof(struct optee_rtc_time));
+
+	ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret !=3D 0)
+		return ret ? ret : -EPROTO;
+
+	return 0;
+}
+
+static int optee_rtc_readoffset(struct device *dev, long *offset)
+{
+	struct optee_rtc *priv =3D dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg =3D {0};
+	struct tee_param param[4] =3D {0};
+	int ret;
+
+	if (!(priv->features & TA_RTC_FEATURE_CORRECTION))
+		return -EOPNOTSUPP;
+
+	inv_arg.func =3D TA_CMD_RTC_GET_OFFSET;
+	inv_arg.session =3D priv->session_id;
+	inv_arg.num_params =3D 4;
+
+	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+
+	ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret !=3D 0)
+		return ret ? ret : -EPROTO;
+
+	*offset =3D param[0].u.value.a;
+
+	return 0;
+}
+
+static int optee_rtc_setoffset(struct device *dev, long offset)
+{
+	struct optee_rtc *priv =3D dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg =3D {0};
+	struct tee_param param[4] =3D {0};
+	int ret;
+
+	if (!(priv->features & TA_RTC_FEATURE_CORRECTION))
+		return -EOPNOTSUPP;
+
+	inv_arg.func =3D TA_CMD_RTC_SET_OFFSET;
+	inv_arg.session =3D priv->session_id;
+	inv_arg.num_params =3D 4;
+
+	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	param[0].u.value.a =3D offset;
+
+	ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret !=3D 0)
+		return ret ? ret : -EPROTO;
+
+	return 0;
+}
+
+static const struct rtc_class_ops optee_rtc_ops =3D {
+	.read_time	=3D optee_rtc_readtime,
+	.set_time	=3D optee_rtc_settime,
+	.set_offset	=3D optee_rtc_setoffset,
+	.read_offset	=3D optee_rtc_readoffset,
+};
+
+static int optee_rtc_read_info(struct device *dev, struct rtc_device *rtc,
+			       u64 *features)
+{
+	struct optee_rtc *priv =3D dev_get_drvdata(dev);
+	struct tee_ioctl_invoke_arg inv_arg =3D {0};
+	struct tee_param param[4] =3D {0};
+	struct optee_rtc_info *info;
+	struct optee_rtc_time *tm;
+	int ret;
+
+	inv_arg.func =3D TA_CMD_RTC_GET_INFO;
+	inv_arg.session =3D priv->session_id;
+	inv_arg.num_params =3D 4;
+
+	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[0].u.memref.shm =3D priv->shm;
+	param[0].u.memref.size =3D sizeof(*info);
+
+	ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
+	if (ret < 0 || inv_arg.ret !=3D 0)
+		return ret ? ret : -EPROTO;
+
+	info =3D tee_shm_get_va(priv->shm, 0);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	if (param[0].u.memref.size !=3D sizeof(*info))
+		return -EPROTO;
+
+	if (info->version !=3D RTC_INFO_VERSION)
+		return -EPROTO;
+
+	*features =3D info->features;
+
+	tm =3D &info->range_min;
+	rtc->range_min =3D mktime64(tm->tm_year, tm->tm_mon, tm->tm_mday, tm->tm_ho=
ur, tm->tm_min,
+				  tm->tm_sec);
+	tm =3D &info->range_max;
+	rtc->range_max =3D mktime64(tm->tm_year, tm->tm_mon, tm->tm_mday, tm->tm_ho=
ur, tm->tm_min,
+				  tm->tm_sec);
+
+	return 0;
+}
+
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *d=
ata)
+{
+	if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE)
+		return 1;
+	else
+		return 0;
+}
+
+static int optee_rtc_probe(struct device *dev)
+{
+	struct tee_client_device *rtc_device =3D to_tee_client_device(dev);
+	struct tee_ioctl_open_session_arg sess_arg;
+	struct optee_rtc *priv;
+	struct rtc_device *rtc;
+	struct tee_shm *shm;
+	int ret, err;
+
+	memset(&sess_arg, 0, sizeof(sess_arg));
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	rtc =3D devm_rtc_allocate_device(dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	/* Open context with TEE driver */
+	priv->ctx =3D tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
+	if (IS_ERR(priv->ctx))
+		return -ENODEV;
+
+	/* Open session with rtc Trusted App */
+	export_uuid(sess_arg.uuid, &rtc_device->id.uuid);
+	sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
+
+	ret =3D tee_client_open_session(priv->ctx, &sess_arg, NULL);
+	if (ret < 0 || sess_arg.ret !=3D 0) {
+		dev_err(dev, "tee_client_open_session failed, err: %x\n", sess_arg.ret);
+		err =3D -EINVAL;
+		goto out_ctx;
+	}
+	priv->session_id =3D sess_arg.session;
+
+	shm =3D tee_shm_alloc_kernel_buf(priv->ctx, sizeof(struct optee_rtc_info));
+	if (IS_ERR(shm)) {
+		dev_err(priv->dev, "tee_shm_alloc_kernel_buf failed\n");
+		err =3D PTR_ERR(shm);
+		goto out_sess;
+	}
+
+	priv->shm =3D shm;
+	priv->dev =3D dev;
+	dev_set_drvdata(dev, priv);
+
+	rtc->ops =3D &optee_rtc_ops;
+
+	err =3D optee_rtc_read_info(dev, rtc, &priv->features);
+	if (err) {
+		dev_err(dev, "Failed to get RTC features from OP-TEE\n");
+		goto out_shm;
+	}
+
+	err =3D devm_rtc_register_device(rtc);
+	if (err)
+		goto out_shm;
+
+	/*
+	 * We must clear this bit after registering because rtc_register_device
+	 * will set it if it sees that .set_offset is provided.
+	 */
+	if (!(priv->features & TA_RTC_FEATURE_CORRECTION))
+		clear_bit(RTC_FEATURE_CORRECTION, rtc->features);
+
+	return 0;
+
+out_shm:
+	tee_shm_free(priv->shm);
+out_sess:
+	tee_client_close_session(priv->ctx, priv->session_id);
+out_ctx:
+	tee_client_close_context(priv->ctx);
+
+	return err;
+}
+
+static int optee_rtc_remove(struct device *dev)
+{
+	struct optee_rtc *priv =3D dev_get_drvdata(dev);
+
+	tee_client_close_session(priv->ctx, priv->session_id);
+	tee_client_close_context(priv->ctx);
+
+	return 0;
+}
+
+static const struct tee_client_device_id optee_rtc_id_table[] =3D {
+	{UUID_INIT(0xf389f8c8, 0x845f, 0x496c,
+		   0x8b, 0xbe, 0xd6, 0x4b, 0xd2, 0x4c, 0x92, 0xfd)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(tee, optee_rtc_id_table);
+
+static struct tee_client_driver optee_rtc_driver =3D {
+	.id_table	=3D optee_rtc_id_table,
+	.driver		=3D {
+		.name		=3D "optee_rtc",
+		.bus		=3D &tee_bus_type,
+		.probe		=3D optee_rtc_probe,
+		.remove		=3D optee_rtc_remove,
+	},
+};
+
+static int __init optee_rtc_mod_init(void)
+{
+	return driver_register(&optee_rtc_driver.driver);
+}
+
+static void __exit optee_rtc_mod_exit(void)
+{
+	driver_unregister(&optee_rtc_driver.driver);
+}
+
+module_init(optee_rtc_mod_init);
+module_exit(optee_rtc_mod_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>");
+MODULE_DESCRIPTION("OP-TEE based RTC driver");
--=20
2.34.1


--===============6238327764601068960==--

