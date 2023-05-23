From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Tue, 23 May 2023 09:14:38 +0000
Message-ID: <20230523091350.292221-5-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6293643226623012894=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6293643226623012894==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add the support of signed firmware using new TEE remoteproc device to
manage a remote firmware in a secure trusted application.

The support of a signed or a non signed firmware is based on compatible:
- with legacy compatible "st,stm32mp1-m4" the Linux kernel loads a
  non-signed (ELF) firmware image,
- with compatible "st,stm32mp1-m4-tee" the Linux kernel load a signed
  firmware image. In this case it calls TEE services to manage the firmware
  loading and the remoteproc life-cycle.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/Kconfig       |   1 +
 drivers/remoteproc/stm32_rproc.c | 234 ++++++++++++++++++++++++++-----
 2 files changed, 198 insertions(+), 37 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 2969f067e3c3..e6f0ca4adf8a 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -316,6 +316,7 @@ config STM32_RPROC
 	depends on ARCH_STM32
 	depends on REMOTEPROC
 	select MAILBOX
+	select TEE_REMOTEPROC
 	help
 	  Say y here to support STM32 MCU processors via the
 	  remote processor framework.
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rpro=
c.c
index 8746cbb1f168..d2c909905cba 100644
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
@@ -49,6 +50,13 @@
 #define M4_STATE_STANDBY	4
 #define M4_STATE_CRASH		5
=20
+/*
+ * Define a default index in future may come a global list of
+ * firmwares which list platforms and associated firmware(s)
+ */
+
+#define STM32_MP1_FW_ID    0
+
 struct stm32_syscon {
 	struct regmap *map;
 	u32 reg;
@@ -89,6 +97,8 @@ struct stm32_rproc {
 	struct stm32_mbox mb[MBOX_NB_MBX];
 	struct workqueue_struct *workqueue;
 	bool secured_soc;
+	bool fw_loaded;
+	struct tee_rproc *trproc;
 	void __iomem *rsc_va;
 };
=20
@@ -208,6 +218,139 @@ static int stm32_rproc_mbox_idx(struct rproc *rproc, co=
nst unsigned char *name)
 	return -EINVAL;
 }
=20
+static void stm32_rproc_request_shutdown(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata =3D rproc->priv;
+	int err, dummy_data, idx;
+
+	/* Request shutdown of the remote processor */
+	if (rproc->state !=3D RPROC_OFFLINE && rproc->state !=3D RPROC_CRASHED) {
+		idx =3D stm32_rproc_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
+		if (idx >=3D 0 && ddata->mb[idx].chan) {
+			/* A dummy data is sent to allow to block on transmit. */
+			err =3D mbox_send_message(ddata->mb[idx].chan,
+						&dummy_data);
+			if (err < 0)
+				dev_warn(&rproc->dev, "warning: remote FW shutdown without ack\n");
+		}
+	}
+}
+
+static int stm32_rproc_release(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata =3D rproc->priv;
+	unsigned int err =3D 0;
+
+	/* To allow platform Standby power mode, set remote proc Deep Sleep. */
+	if (ddata->pdds.map) {
+		err =3D regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
+					 ddata->pdds.mask, 1);
+		if (err) {
+			dev_err(&rproc->dev, "failed to set pdds\n");
+			return err;
+		}
+	}
+
+	/* Update coprocessor state to OFF if available. */
+	if (ddata->m4_state.map) {
+		err =3D regmap_update_bits(ddata->m4_state.map,
+					 ddata->m4_state.reg,
+					 ddata->m4_state.mask,
+					 M4_STATE_OFF);
+		if (err) {
+			dev_err(&rproc->dev, "failed to set copro state\n");
+			return err;
+		}
+	}
+
+	return err;
+}
+
+static int stm32_rproc_tee_elf_sanity_check(struct rproc *rproc,
+					    const struct firmware *fw)
+{
+	struct stm32_rproc *ddata =3D rproc->priv;
+	unsigned int ret =3D 0;
+
+	if (rproc->state =3D=3D RPROC_DETACHED)
+		return 0;
+
+	ret =3D tee_rproc_load_fw(ddata->trproc, fw);
+	if (!ret)
+		ddata->fw_loaded =3D true;
+
+	return ret;
+}
+
+static int stm32_rproc_tee_elf_load(struct rproc *rproc,
+				    const struct firmware *fw)
+{
+	struct stm32_rproc *ddata =3D rproc->priv;
+	unsigned int ret;
+
+	/*
+	 * This function can be called by remote proc for recovery
+	 * without the sanity check. In this case we need to load the firmware
+	 * else nothing done here as the firmware has been preloaded for the
+	 * sanity check to be able to parse it for the resource table
+	 */
+	if (ddata->fw_loaded)
+		return 0;
+
+	ret =3D tee_rproc_load_fw(ddata->trproc, fw);
+	if (ret)
+		return ret;
+	ddata->fw_loaded =3D true;
+
+	/* update the resource table parameters */
+	if (rproc_tee_get_rsc_table(ddata->trproc)) {
+		/* no resource table: reset the related fields */
+		rproc->cached_table =3D NULL;
+		rproc->table_ptr =3D NULL;
+		rproc->table_sz =3D 0;
+	}
+
+	return 0;
+}
+
+static struct resource_table *
+stm32_rproc_tee_elf_find_loaded_rsc_table(struct rproc *rproc,
+					  const struct firmware *fw)
+{
+	struct stm32_rproc *ddata =3D rproc->priv;
+
+	return tee_rproc_get_loaded_rsc_table(ddata->trproc);
+}
+
+static int stm32_rproc_tee_start(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata =3D rproc->priv;
+
+	return tee_rproc_start(ddata->trproc);
+}
+
+static int stm32_rproc_tee_attach(struct rproc *rproc)
+{
+	/* Nothing to do, remote proc already started by the secured context */
+	return 0;
+}
+
+static int stm32_rproc_tee_stop(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata =3D rproc->priv;
+	int err;
+
+	stm32_rproc_request_shutdown(rproc);
+
+	err =3D tee_rproc_stop(ddata->trproc);
+	if (err)
+		return err;
+
+	ddata->fw_loaded =3D false;
+
+	return stm32_rproc_release(rproc);
+}
+
 static int stm32_rproc_prepare(struct rproc *rproc)
 {
 	struct device *dev =3D rproc->dev.parent;
@@ -270,7 +413,14 @@ static int stm32_rproc_prepare(struct rproc *rproc)
=20
 static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *=
fw)
 {
-	if (rproc_elf_load_rsc_table(rproc, fw))
+	struct stm32_rproc *ddata =3D rproc->priv;
+	int ret;
+
+	if (ddata->trproc)
+		ret =3D rproc_tee_get_rsc_table(ddata->trproc);
+	else
+		ret =3D rproc_elf_load_rsc_table(rproc, fw);
+	if (ret)
 		dev_warn(&rproc->dev, "no resource table found for this firmware\n");
=20
 	return 0;
@@ -503,17 +653,9 @@ static int stm32_rproc_detach(struct rproc *rproc)
 static int stm32_rproc_stop(struct rproc *rproc)
 {
 	struct stm32_rproc *ddata =3D rproc->priv;
-	int err, idx;
+	int err;
=20
-	/* request shutdown of the remote processor */
-	if (rproc->state !=3D RPROC_OFFLINE && rproc->state !=3D RPROC_CRASHED) {
-		idx =3D stm32_rproc_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
-		if (idx >=3D 0 && ddata->mb[idx].chan) {
-			err =3D mbox_send_message(ddata->mb[idx].chan, "detach");
-			if (err < 0)
-				dev_warn(&rproc->dev, "warning: remote FW shutdown without ack\n");
-		}
-	}
+	stm32_rproc_request_shutdown(rproc);
=20
 	err =3D stm32_rproc_set_hold_boot(rproc, true);
 	if (err)
@@ -525,29 +667,8 @@ static int stm32_rproc_stop(struct rproc *rproc)
 		return err;
 	}
=20
-	/* to allow platform Standby power mode, set remote proc Deep Sleep */
-	if (ddata->pdds.map) {
-		err =3D regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
-					 ddata->pdds.mask, 1);
-		if (err) {
-			dev_err(&rproc->dev, "failed to set pdds\n");
-			return err;
-		}
-	}
-
-	/* update coprocessor state to OFF if available */
-	if (ddata->m4_state.map) {
-		err =3D regmap_update_bits(ddata->m4_state.map,
-					 ddata->m4_state.reg,
-					 ddata->m4_state.mask,
-					 M4_STATE_OFF);
-		if (err) {
-			dev_err(&rproc->dev, "failed to set copro state\n");
-			return err;
-		}
-	}
=20
-	return 0;
+	return stm32_rproc_release(rproc);
 }
=20
 static void stm32_rproc_kick(struct rproc *rproc, int vqid)
@@ -659,8 +780,22 @@ static const struct rproc_ops st_rproc_ops =3D {
 	.get_boot_addr	=3D rproc_elf_get_boot_addr,
 };
=20
+static const struct rproc_ops st_rproc_tee_ops =3D {
+	.prepare	=3D stm32_rproc_prepare,
+	.start		=3D stm32_rproc_tee_start,
+	.stop		=3D stm32_rproc_tee_stop,
+	.attach		=3D stm32_rproc_tee_attach,
+	.kick		=3D stm32_rproc_kick,
+	.parse_fw	=3D stm32_rproc_parse_fw,
+	.find_loaded_rsc_table =3D stm32_rproc_tee_elf_find_loaded_rsc_table,
+	.get_loaded_rsc_table =3D stm32_rproc_get_loaded_rsc_table,
+	.sanity_check	=3D stm32_rproc_tee_elf_sanity_check,
+	.load		=3D stm32_rproc_tee_elf_load,
+};
+
 static const struct of_device_id stm32_rproc_match[] =3D {
-	{ .compatible =3D "st,stm32mp1-m4" },
+	{.compatible =3D "st,stm32mp1-m4",},
+	{.compatible =3D "st,stm32mp1-m4-tee",},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_rproc_match);
@@ -801,6 +936,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct stm32_rproc *ddata;
 	struct device_node *np =3D dev->of_node;
+	struct tee_rproc *trproc;
 	struct rproc *rproc;
 	unsigned int state;
 	int ret;
@@ -809,11 +945,29 @@ static int stm32_rproc_probe(struct platform_device *pd=
ev)
 	if (ret)
 		return ret;
=20
-	rproc =3D rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
-	if (!rproc)
-		return -ENOMEM;
+	if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
+		trproc =3D tee_rproc_register(dev, STM32_MP1_FW_ID);
+		if (IS_ERR_OR_NULL(trproc)) {
+			return PTR_ERR(trproc);
+		/*
+		 * Delegate the firmware management to the secure context.
+		 * The firmware loaded has to be signed.
+		 */
+		dev_info(dev, "Support of signed firmware only\n");
+		}
+	}
+	rproc =3D rproc_alloc(dev, np->name,
+			    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
+			    NULL, sizeof(*ddata));
+	if (!rproc) {
+		ret =3D -ENOMEM;
+		goto free_tee;
+	}
=20
 	ddata =3D rproc->priv;
+	ddata->trproc =3D trproc;
+	if (trproc)
+		ddata->trproc->rproc =3D rproc;
=20
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
=20
@@ -864,6 +1018,10 @@ static int stm32_rproc_probe(struct platform_device *pd=
ev)
 		device_init_wakeup(dev, false);
 	}
 	rproc_free(rproc);
+free_tee:
+	if (trproc)
+		tee_rproc_unregister(trproc);
+
 	return ret;
 }
=20
@@ -885,6 +1043,8 @@ static int stm32_rproc_remove(struct platform_device *pd=
ev)
 		device_init_wakeup(dev, false);
 	}
 	rproc_free(rproc);
+	if (ddata->trproc)
+		tee_rproc_unregister(ddata->trproc);
=20
 	return 0;
 }
--=20
2.25.1


--===============6293643226623012894==--

