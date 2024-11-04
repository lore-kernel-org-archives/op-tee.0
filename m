From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v13 7/7] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Mon, 04 Nov 2024 14:35:15 +0100
Message-ID: <20241104133515.256497-8-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20241104133515.256497-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5920712034480384655=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5920712034480384655==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The new TEE remoteproc driver is used to manage remote firmware in a
secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
introduced to delegate the loading of the firmware to the trusted
execution context. In such cases, the firmware should be signed and
adhere to the image format defined by the TEE.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Updates from version V11:
- rename structures, variables and function from tee_rproc_xxx to
  rproc_tee_xxx,
- rework code to take into account rproc_tee_register and
  rproc_tee_unregister APIs update,
- optimize code around dev_err_probe() when rproc_tee_register() fails.
---
 drivers/remoteproc/stm32_rproc.c | 57 ++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rpro=
c.c
index 288bd70c7861..7875b26a38a5 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -18,6 +18,7 @@
 #include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
+#include <linux/remoteproc_tee.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
@@ -255,6 +256,19 @@ static int stm32_rproc_release(struct rproc *rproc)
 	return 0;
 }
=20
+static int stm32_rproc_tee_stop(struct rproc *rproc)
+{
+	int err;
+
+	stm32_rproc_request_shutdown(rproc);
+
+	err =3D rproc_tee_stop(rproc);
+	if (err)
+		return err;
+
+	return stm32_rproc_release(rproc);
+}
+
 static int stm32_rproc_prepare(struct rproc *rproc)
 {
 	struct device *dev =3D rproc->dev.parent;
@@ -691,8 +705,20 @@ static const struct rproc_ops st_rproc_ops =3D {
 	.get_boot_addr	=3D rproc_elf_get_boot_addr,
 };
=20
+static const struct rproc_ops st_rproc_tee_ops =3D {
+	.prepare	=3D stm32_rproc_prepare,
+	.start		=3D rproc_tee_start,
+	.stop		=3D stm32_rproc_tee_stop,
+	.kick		=3D stm32_rproc_kick,
+	.load		=3D rproc_tee_load_fw,
+	.parse_fw	=3D rproc_tee_parse_fw,
+	.find_loaded_rsc_table =3D rproc_tee_find_loaded_rsc_table,
+	.release_fw	=3D rproc_tee_release_fw,
+};
+
 static const struct of_device_id stm32_rproc_match[] =3D {
 	{ .compatible =3D "st,stm32mp1-m4" },
+	{ .compatible =3D "st,stm32mp1-m4-tee" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_rproc_match);
@@ -853,15 +879,36 @@ static int stm32_rproc_probe(struct platform_device *pd=
ev)
 	struct device_node *np =3D dev->of_node;
 	struct rproc *rproc;
 	unsigned int state;
+	u32 proc_id;
 	int ret;
=20
 	ret =3D dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
=20
-	rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddat=
a));
-	if (!rproc)
-		return -ENOMEM;
+	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
+		/*
+		 * Delegate the firmware management to the secure context.
+		 * The firmware loaded has to be signed.
+		 */
+		ret =3D of_property_read_u32(np, "st,proc-id", &proc_id);
+		if (ret) {
+			dev_err(dev, "failed to read st,rproc-id property\n");
+			return ret;
+		}
+
+		rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_tee_ops, NULL, sizeof(=
*ddata));
+		if (!rproc)
+			return -ENOMEM;
+
+		ret =3D rproc_tee_register(dev, rproc, proc_id);
+		if (ret)
+			return dev_err_probe(dev, ret,  "signed firmware not supported by TEE\n");
+	} else {
+		rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*dda=
ta));
+		if (!rproc)
+			return -ENOMEM;
+	}
=20
 	ddata =3D rproc->priv;
=20
@@ -913,6 +960,8 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 		dev_pm_clear_wake_irq(dev);
 		device_init_wakeup(dev, false);
 	}
+	rproc_tee_unregister(rproc);
+
 	return ret;
 }
=20
@@ -933,6 +982,8 @@ static void stm32_rproc_remove(struct platform_device *pd=
ev)
 		dev_pm_clear_wake_irq(dev);
 		device_init_wakeup(dev, false);
 	}
+
+	rproc_tee_unregister(rproc);
 }
=20
 static int stm32_rproc_suspend(struct device *dev)
--=20
2.25.1


--===============5920712034480384655==--

