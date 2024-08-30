From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v9 7/7] remoteproc: stm32: Add support of an OP-TEE TA to load
 the firmware
Date: Fri, 30 Aug 2024 11:51:47 +0200
Message-ID: <20240830095147.3538047-8-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20240830095147.3538047-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4547709418631510564=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4547709418631510564==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The new TEE remoteproc driver is used to manage remote firmware in a
secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
introduced to delegate the loading of the firmware to the trusted
execution context. In such cases, the firmware should be signed and
adhere to the image format defined by the TEE.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/stm32_rproc.c | 63 ++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rpro=
c.c
index 79c638936163..400a7a93b1c9 100644
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
@@ -257,6 +258,19 @@ static int stm32_rproc_release(struct rproc *rproc)
 	return 0;
 }
=20
+static int stm32_rproc_tee_stop(struct rproc *rproc)
+{
+	int err;
+
+	stm32_rproc_request_shutdown(rproc);
+
+	err =3D tee_rproc_stop(rproc);
+	if (err)
+		return err;
+
+	return stm32_rproc_release(rproc);
+}
+
 static int stm32_rproc_prepare(struct rproc *rproc)
 {
 	struct device *dev =3D rproc->dev.parent;
@@ -693,8 +707,20 @@ static const struct rproc_ops st_rproc_ops =3D {
 	.get_boot_addr	=3D rproc_elf_get_boot_addr,
 };
=20
+static const struct rproc_ops st_rproc_tee_ops =3D {
+	.prepare	=3D stm32_rproc_prepare,
+	.start		=3D tee_rproc_start,
+	.stop		=3D stm32_rproc_tee_stop,
+	.kick		=3D stm32_rproc_kick,
+	.load		=3D tee_rproc_load_fw,
+	.parse_fw	=3D tee_rproc_parse_fw,
+	.find_loaded_rsc_table =3D tee_rproc_find_loaded_rsc_table,
+
+};
+
 static const struct of_device_id stm32_rproc_match[] =3D {
 	{ .compatible =3D "st,stm32mp1-m4" },
+	{ .compatible =3D "st,stm32mp1-m4-tee" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_rproc_match);
@@ -853,17 +879,42 @@ static int stm32_rproc_probe(struct platform_device *pd=
ev)
 	struct device *dev =3D &pdev->dev;
 	struct stm32_rproc *ddata;
 	struct device_node *np =3D dev->of_node;
+	struct tee_rproc *trproc =3D NULL;
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
+		trproc =3D tee_rproc_register(dev, rproc, proc_id);
+		if (IS_ERR(trproc)) {
+			dev_err_probe(dev, PTR_ERR(trproc),
+				      "signed firmware not supported by TEE\n");
+			return PTR_ERR(trproc);
+		}
+	} else {
+		rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*dda=
ta));
+		if (!rproc)
+			return -ENOMEM;
+	}
=20
 	ddata =3D rproc->priv;
=20
@@ -915,6 +966,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 		dev_pm_clear_wake_irq(dev);
 		device_init_wakeup(dev, false);
 	}
+	if (trproc)
+		tee_rproc_unregister(trproc);
+
 	return ret;
 }
=20
@@ -935,6 +989,9 @@ static void stm32_rproc_remove(struct platform_device *pd=
ev)
 		dev_pm_clear_wake_irq(dev);
 		device_init_wakeup(dev, false);
 	}
+	if (rproc->tee_interface)
+		tee_rproc_unregister(rproc->tee_interface);
+
 }
=20
 static int stm32_rproc_suspend(struct device *dev)
--=20
2.25.1


--===============4547709418631510564==--

