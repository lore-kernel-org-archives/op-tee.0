From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4 4/4] remoteproc: stm32: Add support of an OP-TEE TA to load
 the firmware
Date: Fri, 08 Mar 2024 14:48:31 +0000
Message-ID: <20240308144708.62362-5-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20240308144708.62362-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4501812772709857978=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4501812772709857978==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The new TEE remoteproc device is used to manage remote firmware in a
secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
introduced to delegate the loading of the firmware to the trusted
execution context. In such cases, the firmware should be signed and
adhere to the image format defined by the TEE.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Updates from V3:
- remove support of the attach use case. Will be addressed in a separate
  thread,
- add st_rproc_tee_ops::parse_fw ops,
- inverse call of devm_rproc_alloc()and tee_rproc_register() to manage cross
  reference between the rproc struct and the tee_rproc struct in tee_rproc.c.
---
 drivers/remoteproc/stm32_rproc.c | 60 +++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rpro=
c.c
index 8cd838df4e92..13df33c78aa2 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -20,6 +20,7 @@
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/tee_remoteproc.h>
 #include <linux/workqueue.h>
=20
 #include "remoteproc_internal.h"
@@ -49,6 +50,9 @@
 #define M4_STATE_STANDBY	4
 #define M4_STATE_CRASH		5
=20
+/* Remote processor unique identifier aligned with the Trusted Execution Env=
ironment definitions */
+#define STM32_MP1_M4_PROC_ID    0
+
 struct stm32_syscon {
 	struct regmap *map;
 	u32 reg;
@@ -257,6 +261,19 @@ static int stm32_rproc_release(struct rproc *rproc)
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
@@ -693,8 +710,19 @@ static const struct rproc_ops st_rproc_ops =3D {
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
+};
+
 static const struct of_device_id stm32_rproc_match[] =3D {
-	{ .compatible =3D "st,stm32mp1-m4" },
+	{.compatible =3D "st,stm32mp1-m4",},
+	{.compatible =3D "st,stm32mp1-m4-tee",},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_rproc_match);
@@ -853,6 +881,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct stm32_rproc *ddata;
 	struct device_node *np =3D dev->of_node;
+	struct tee_rproc *trproc =3D NULL;
 	struct rproc *rproc;
 	unsigned int state;
 	int ret;
@@ -861,9 +890,26 @@ static int stm32_rproc_probe(struct platform_device *pde=
v)
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
+		rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_tee_ops, NULL, sizeof(=
*ddata));
+		if (!rproc)
+			return -ENOMEM;
+
+		trproc =3D tee_rproc_register(dev, rproc, STM32_MP1_M4_PROC_ID);
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
@@ -915,6 +961,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 		dev_pm_clear_wake_irq(dev);
 		device_init_wakeup(dev, false);
 	}
+	if (trproc)
+		tee_rproc_unregister(trproc);
+
 	return ret;
 }
=20
@@ -935,6 +984,9 @@ static void stm32_rproc_remove(struct platform_device *pd=
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


--===============4501812772709857978==--

