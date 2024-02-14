From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v3 4/7] remoteproc: core: Implement the support of an alternative boot
Date: Wed, 14 Feb 2024 17:22:37 +0000
Message-ID: <20240214172127.1022199-5-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7626535615769436016=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7626535615769436016==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Implement a new method to load a firmware and start the remote processor.
In this method the firmware is loaded first and then the loaded resource
table is obtained.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 86 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  2 +
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remote=
proc_core.c
index 34b0093689da..47956e07365e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -38,6 +38,7 @@
 #include <linux/virtio_ring.h>
 #include <asm/byteorder.h>
 #include <linux/platform_device.h>
+#include <linux/tee_remoteproc.h>
=20
 #include "remoteproc_internal.h"
=20
@@ -1493,6 +1494,86 @@ static int rproc_set_rsc_table(struct rproc *rproc)
 	return 0;
 }
=20
+/*
+ * Alternative method to load a firmware and boot a remote processor with it.
+ * Similar to rproc_fw_boot but the resource table is obtained and parsed on=
ly after loading the
+ * firmware.
+ */
+static int rproc_alt_fw_boot(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev =3D &rproc->dev;
+	const char *name =3D rproc->firmware;
+	int ret;
+
+	dev_info(dev, "Booting a private format image %s, size %zd\n", name, fw->si=
ze);
+
+	/*
+	 * if enabling an IOMMU isn't relevant for this rproc, this is
+	 * just a nop
+	 */
+	ret =3D rproc_enable_iommu(rproc);
+	if (ret) {
+		dev_err(dev, "can't enable iommu: %d\n", ret);
+		return ret;
+	}
+
+	/* Prepare rproc for firmware loading if needed */
+	ret =3D rproc_prepare_device(rproc);
+	if (ret) {
+		dev_err(dev, "can't prepare rproc %s: %d\n", rproc->name, ret);
+		goto disable_iommu;
+	}
+
+	/* load the image to memory */
+	ret =3D rproc_load_segments(rproc, fw);
+	if (ret) {
+		dev_err(dev, "Failed to load firmware: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D rproc_set_rsc_table(rproc);
+	if (ret) {
+		dev_err(dev, "can't load resource table: %d\n", ret);
+		goto unprepare_device;
+	}
+
+	/* reset max_notifyid */
+	rproc->max_notifyid =3D -1;
+
+	/* reset handled vdev */
+	rproc->nb_vdev =3D 0;
+
+	/* handle fw resources which are required to boot rproc */
+	ret =3D rproc_handle_resources(rproc, rproc_loading_handlers);
+	if (ret) {
+		dev_err(dev, "Failed to process resources: %d\n", ret);
+		goto clean_up_resources;
+	}
+
+	/* Allocate carveout resources associated to rproc */
+	ret =3D rproc_alloc_registered_carveouts(rproc);
+	if (ret) {
+		dev_err(dev, "Failed to allocate associated carveouts: %d\n",
+			ret);
+		goto clean_up_resources;
+	}
+
+	ret =3D rproc_start(rproc, fw);
+	if (ret)
+		goto clean_up_resources;
+
+	return 0;
+
+clean_up_resources:
+	rproc_resource_cleanup(rproc);
+unprepare_device:
+	/* release HW resources if needed */
+	rproc_unprepare_device(rproc);
+disable_iommu:
+	rproc_disable_iommu(rproc);
+	return ret;
+}
+
 static int rproc_reset_rsc_table_on_detach(struct rproc *rproc)
 {
 	struct resource_table *table_ptr;
@@ -1957,7 +2038,10 @@ int rproc_boot(struct rproc *rproc)
 			goto downref_rproc;
 		}
=20
-		ret =3D rproc_fw_boot(rproc, firmware_p);
+		if (rproc->alt_boot)
+			ret =3D rproc_alt_fw_boot(rproc, firmware_p);
+		else
+			ret =3D rproc_fw_boot(rproc, firmware_p);
=20
 		release_firmware(firmware_p);
 	}
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index b4795698d8c2..ba219a77e055 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -544,6 +544,7 @@ enum rproc_features {
  * @elf_machine: firmware ELF machine
  * @cdev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown o=
n @char_dev release
+ * @alt_boot flag to indicate if remoteproc should use the alternate boot me=
thod.
  * @features: indicate remoteproc features
  */
 struct rproc {
@@ -585,6 +586,7 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	bool alt_boot;
 	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
 };
=20
--=20
2.25.1


--===============7626535615769436016==--

