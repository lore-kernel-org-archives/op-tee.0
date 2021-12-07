From: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 1/2] crypto: caam - convert to use capabilities
Date: Wed, 08 Dec 2021 00:02:05 +0100
Message-ID: <20211207230206.14637-2-andrey.zhizhikin@leica-geosystems.com>
In-Reply-To: <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0704978533309837032=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0704978533309837032==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

CAAM driver contains several variables, which are used for indication
that certain capabilities are detected during initial probing of the
device. They are defined as u8, but mainly used as boolean variables to
identify capabillities. CAAM JR driver code also contains the static
variable in the probe method, which is used to derive the JR index value
and does not respect how JRs are implemented in the HW.

Clean-up all assorted variables, collect them into one bitfield value
which encodes capabilities as bit, and use them in the execution flow
instead.

Replace static indexing in JR driver with index derived from "reg"
binding, as it reflects the actual JR number in the HW.

Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
---
Changes in V3:
- Address review comments from V2 series, replace inline if statements
  with explicit ones
- Add more helper macros
- Merge change done in separate patch for JR indexing into here
- Change caam_ctrl_check_jr_perm() from register readout to status
  binding check
- Do not export caam_ctrl_check_jr_perm() anymore, drop the declaration
  from header
- Remove more local variables in probe() and replace them with
  capabilities readout

 drivers/crypto/caam/caamalg_qi.c |   2 +-
 drivers/crypto/caam/ctrl.c       | 115 ++++++++++++++++++++-----------
 drivers/crypto/caam/intern.h     |  20 +++---
 drivers/crypto/caam/jr.c         |  19 ++++-
 drivers/crypto/caam/regs.h       |   2 -
 5 files changed, 106 insertions(+), 52 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_q=
i.c
index 189a7438b29c..1b7cdae28290 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -2610,7 +2610,7 @@ int caam_qi_algapi_init(struct device *ctrldev)
 	bool registered =3D false;
=20
 	/* Make sure this runs only on (DPAA 1.x) QI */
-	if (!priv->qi_present || caam_dpaa2)
+	if (!(priv->caam_caps & CAAM_CAPS_QI_PRESENT) || caam_dpaa2)
 		return 0;
=20
 	/*
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index ca0361b2dbb0..37c0c6af1137 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -79,6 +79,36 @@ static void build_deinstantiation_desc(u32 *desc, int hand=
le)
 	append_jump(desc, JUMP_CLASS_CLASS1 | JUMP_TYPE_HALT);
 }
=20
+/*
+ * caam_ctrl_check_jr_perm - check if the job ring can be accessed
+ *				from Non-Secure World.
+ * @np - pointer to JR device node
+ *
+ * Return: - 0 if Job Ring is reserved in the Secure World
+ *	    - 1 if Job Ring is available in NS World
+ */
+static inline int caam_ctrl_check_jr_perm(const struct device_node *np)
+{
+	struct property *p;
+
+	/* read "status" property first */
+	p =3D of_find_property(np, "status", NULL);
+	if (p && (!strncmp(p->value, "disabled", p->length))) {
+		/*
+		 * "status" is set to "disabled", which would imply that the JR
+		 * is not available for NS World. All other possible combination
+		 * of "status" and "secure-status" would rather indicate that JR
+		 * is either available in NS-only, or in both S and NS Worlds.
+		 * In a later case, we indicate that this JR can be used by the
+		 * Kernel since the resource is shared.
+		 * For details, see:
+		 * Documentation/devicetree/bindings/arm/secure.txt
+		 */
+		return 0;
+	}
+	return 1;
+}
+
 /*
  * run_descriptor_deco0 - runs a descriptor on DECO0, under direct control of
  *			  the software (no JR/QI used).
@@ -100,7 +130,7 @@ static inline int run_descriptor_deco0(struct device *ctr=
ldev, u32 *desc,
 	int i;
=20
=20
-	if (ctrlpriv->virt_en =3D=3D 1 ||
+	if ((ctrlpriv->caam_caps & CAAM_CAPS_VIRT_ENABLED) ||
 	    /*
 	     * Apparently on i.MX8M{Q,M,N,P} it doesn't matter if virt_en =3D=3D 1
 	     * and the following steps should be performed regardless
@@ -169,7 +199,7 @@ static inline int run_descriptor_deco0(struct device *ctr=
ldev, u32 *desc,
 	*status =3D rd_reg32(&deco->op_status_hi) &
 		  DECO_OP_STATUS_HI_ERR_MASK;
=20
-	if (ctrlpriv->virt_en =3D=3D 1)
+	if (ctrlpriv->caam_caps & CAAM_CAPS_VIRT_ENABLED)
 		clrsetbits_32(&ctrl->deco_rsr, DECORSR_JR0, 0);
=20
 	/* Mark the DECO as free */
@@ -612,7 +642,7 @@ static bool check_version(struct fsl_mc_version *mc_versi=
on, u32 major,
 /* Probe routine for CAAM top (controller) level */
 static int caam_probe(struct platform_device *pdev)
 {
-	int ret, ring, gen_sk, ent_delay =3D RTSDCTL_ENT_DLY_MIN;
+	int ret, gen_sk, ent_delay =3D RTSDCTL_ENT_DLY_MIN;
 	u64 caam_id;
 	const struct soc_device_attribute *imx_soc_match;
 	struct device *dev;
@@ -622,8 +652,6 @@ static int caam_probe(struct platform_device *pdev)
 	struct dentry *dfs_root;
 	u32 scfgr, comp_params;
 	u8 rng_vid;
-	int pg_size;
-	int BLOCK_OFFSET =3D 0;
 	bool pr_support =3D false;
=20
 	ctrlpriv =3D devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
@@ -666,11 +694,12 @@ static int caam_probe(struct platform_device *pdev)
 	else
 		caam_ptr_sz =3D sizeof(u32);
 	caam_dpaa2 =3D !!(comp_params & CTPR_MS_DPAA2);
-	ctrlpriv->qi_present =3D !!(comp_params & CTPR_MS_QI_MASK);
+	if (comp_params & CTPR_MS_QI_MASK)
+		ctrlpriv->caam_caps |=3D CAAM_CAPS_QI_PRESENT;
=20
 #ifdef CONFIG_CAAM_QI
 	/* If (DPAA 1.x) QI present, check whether dependencies are available */
-	if (ctrlpriv->qi_present && !caam_dpaa2) {
+	if ((ctrlpriv->caam_caps & CAAM_CAPS_QI_PRESENT) && !caam_dpaa2) {
 		ret =3D qman_is_probed();
 		if (!ret) {
 			return -EPROBE_DEFER;
@@ -689,33 +718,29 @@ static int caam_probe(struct platform_device *pdev)
 	}
 #endif
=20
-	/* Allocating the BLOCK_OFFSET based on the supported page size on
-	 * the platform
-	 */
-	pg_size =3D (comp_params & CTPR_MS_PG_SZ_MASK) >> CTPR_MS_PG_SZ_SHIFT;
-	if (pg_size =3D=3D 0)
-		BLOCK_OFFSET =3D PG_SIZE_4K;
-	else
-		BLOCK_OFFSET =3D PG_SIZE_64K;
+	/* Allocate control blocks based on the CAAM supported page size */
+	if (comp_params & CTPR_MS_PG_SZ_MASK)
+		ctrlpriv->caam_caps |=3D CAAM_CAPS_64K_PAGESIZE;
=20
 	ctrlpriv->ctrl =3D (struct caam_ctrl __iomem __force *)ctrl;
 	ctrlpriv->assure =3D (struct caam_assurance __iomem __force *)
 			   ((__force uint8_t *)ctrl +
-			    BLOCK_OFFSET * ASSURE_BLOCK_NUMBER
+			    CAAM_CAPS_PG_SZ(ctrlpriv->caam_caps) * ASSURE_BLOCK_NUMBER
 			   );
 	ctrlpriv->deco =3D (struct caam_deco __iomem __force *)
 			 ((__force uint8_t *)ctrl +
-			 BLOCK_OFFSET * DECO_BLOCK_NUMBER
+			 CAAM_CAPS_PG_SZ(ctrlpriv->caam_caps) * DECO_BLOCK_NUMBER
 			 );
=20
 	/* Get the IRQ of the controller (for security violations only) */
 	ctrlpriv->secvio_irq =3D irq_of_parse_and_map(nprop, 0);
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,qoriq-mc");
-	ctrlpriv->mc_en =3D !!np;
+	if (np)
+		ctrlpriv->caam_caps |=3D CAAM_CAPS_MC_ENABLED;
 	of_node_put(np);
=20
 #ifdef CONFIG_FSL_MC_BUS
-	if (ctrlpriv->mc_en) {
+	if (ctrlpriv->caam_caps & CAAM_CAPS_MC_ENABLED) {
 		struct fsl_mc_version *mc_version;
=20
 		mc_version =3D fsl_mc_get_version();
@@ -732,7 +757,7 @@ static int caam_probe(struct platform_device *pdev)
 	 * In case of SoCs with Management Complex, MC f/w performs
 	 * the configuration.
 	 */
-	if (!ctrlpriv->mc_en)
+	if (!(ctrlpriv->caam_caps & CAAM_CAPS_MC_ENABLED))
 		clrsetbits_32(&ctrl->mcr, MCFGR_AWCACHE_MASK,
 			      MCFGR_AWCACHE_CACH | MCFGR_AWCACHE_BUFF |
 			      MCFGR_WDENABLE | MCFGR_LARGE_BURST);
@@ -745,7 +770,6 @@ static int caam_probe(struct platform_device *pdev)
 	 */
 	scfgr =3D rd_reg32(&ctrl->scfgr);
=20
-	ctrlpriv->virt_en =3D 0;
 	if (comp_params & CTPR_MS_VIRT_EN_INCL) {
 		/* VIRT_EN_INCL =3D 1 & VIRT_EN_POR =3D 1 or
 		 * VIRT_EN_INCL =3D 1 & VIRT_EN_POR =3D 0 & SCFGR_VIRT_EN =3D 1
@@ -753,14 +777,14 @@ static int caam_probe(struct platform_device *pdev)
 		if ((comp_params & CTPR_MS_VIRT_EN_POR) ||
 		    (!(comp_params & CTPR_MS_VIRT_EN_POR) &&
 		       (scfgr & SCFGR_VIRT_EN)))
-				ctrlpriv->virt_en =3D 1;
+			ctrlpriv->caam_caps |=3D CAAM_CAPS_VIRT_ENABLED;
 	} else {
 		/* VIRT_EN_INCL =3D 0 && VIRT_EN_POR_VALUE =3D 1 */
 		if (comp_params & CTPR_MS_VIRT_EN_POR)
-				ctrlpriv->virt_en =3D 1;
+			ctrlpriv->caam_caps |=3D CAAM_CAPS_VIRT_ENABLED;
 	}
=20
-	if (ctrlpriv->virt_en =3D=3D 1)
+	if (ctrlpriv->caam_caps & CAAM_CAPS_VIRT_ENABLED)
 		clrsetbits_32(&ctrl->jrstart, 0, JRSTART_JR0_START |
 			      JRSTART_JR1_START | JRSTART_JR2_START |
 			      JRSTART_JR3_START);
@@ -785,10 +809,10 @@ static int caam_probe(struct platform_device *pdev)
 	caam_debugfs_init(ctrlpriv, dfs_root);
=20
 	/* Check to see if (DPAA 1.x) QI present. If so, enable */
-	if (ctrlpriv->qi_present && !caam_dpaa2) {
+	if ((ctrlpriv->caam_caps & CAAM_CAPS_QI_PRESENT) && !caam_dpaa2) {
 		ctrlpriv->qi =3D (struct caam_queue_if __iomem __force *)
 			       ((__force uint8_t *)ctrl +
-				 BLOCK_OFFSET * QI_BLOCK_NUMBER
+				 CAAM_CAPS_PG_SZ(ctrlpriv->caam_caps) * QI_BLOCK_NUMBER
 			       );
 		/* This is all that's required to physically enable QI */
 		wr_reg32(&ctrlpriv->qi->qi_control_lo, QICTL_DQEN);
@@ -801,21 +825,32 @@ static int caam_probe(struct platform_device *pdev)
 #endif
 	}
=20
-	ring =3D 0;
 	for_each_available_child_of_node(nprop, np)
 		if (of_device_is_compatible(np, "fsl,sec-v4.0-job-ring") ||
 		    of_device_is_compatible(np, "fsl,sec4.0-job-ring")) {
-			ctrlpriv->jr[ring] =3D (struct caam_job_ring __iomem __force *)
-					     ((__force uint8_t *)ctrl +
-					     (ring + JR_BLOCK_NUMBER) *
-					      BLOCK_OFFSET
-					     );
-			ctrlpriv->total_jobrs++;
-			ring++;
+			u32 ring_id;
+			/*
+			 * Get register page to see the start address of CB
+			 * This is used to index into the bitmap of available
+			 * job rings and indicate if it is available in NS world.
+			 */
+			ret =3D of_property_read_u32(np, "reg", &ring_id);
+			if (ret) {
+				dev_err(dev, "failed to get register address for jobr\n");
+				continue;
+			}
+			ring_id =3D ring_id >> CAAM_CAPS_PG_SHIFT(ctrlpriv->caam_caps);
+
+			if (caam_ctrl_check_jr_perm(np))
+				ctrlpriv->caam_caps |=3D CAAM_CAPS_JR_PRESENT(ring_id);
 		}
=20
-	/* If no QI and no rings specified, quit and go home */
-	if ((!ctrlpriv->qi_present) && (!ctrlpriv->total_jobrs)) {
+	/*
+	 * If no QI, no rings specified or no rings available for NS -
+	 * quit and go home
+	 */
+	if (!(ctrlpriv->caam_caps & CAAM_CAPS_QI_PRESENT) &&
+	    (hweight_long(ctrlpriv->caam_caps & CAAM_CAPS_JOBRS_MASK) =3D=3D 0)) {
 		dev_err(dev, "no queues configured, terminating\n");
 		return -ENOMEM;
 	}
@@ -832,7 +867,8 @@ static int caam_probe(struct platform_device *pdev)
 	 * already instantiated, do RNG instantiation
 	 * In case of SoCs with Management Complex, RNG is managed by MC f/w.
 	 */
-	if (!(ctrlpriv->mc_en && pr_support) && rng_vid >=3D 4) {
+	if (!((ctrlpriv->caam_caps & CAAM_CAPS_MC_ENABLED) && pr_support) &&
+	    rng_vid >=3D 4) {
 		ctrlpriv->rng4_sh_init =3D
 			rd_reg32(&ctrl->r4tst[0].rdsta);
 		/*
@@ -900,8 +936,9 @@ static int caam_probe(struct platform_device *pdev)
 	/* Report "alive" for developer to see */
 	dev_info(dev, "device ID =3D 0x%016llx (Era %d)\n", caam_id,
 		 ctrlpriv->era);
-	dev_info(dev, "job rings =3D %d, qi =3D %d\n",
-		 ctrlpriv->total_jobrs, ctrlpriv->qi_present);
+	dev_info(dev, "job rings =3D %ld, qi =3D %s\n",
+		 hweight_long(ctrlpriv->caam_caps & CAAM_CAPS_JOBRS_MASK),
+		 (ctrlpriv->caam_caps & CAAM_CAPS_QI_PRESENT) ? "yes" : "no");
=20
 	ret =3D devm_of_platform_populate(dev);
 	if (ret)
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 7d45b21bd55a..37fa9db461c7 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -86,15 +86,19 @@ struct caam_drv_private {
=20
 	struct iommu_domain *domain;
=20
-	/*
-	 * Detected geometry block. Filled in from device tree if powerpc,
-	 * or from register-based version detection code
-	 */
-	u8 total_jobrs;		/* Total Job Rings in device */
-	u8 qi_present;		/* Nonzero if QI present in device */
-	u8 mc_en;		/* Nonzero if MC f/w is active */
+	unsigned long caam_caps; /* CAAM Module capabilities */
+
+#define CAAM_CAPS_QI_PRESENT	BIT(0)	/* Queue Manager interface (QI) implemen=
ted */
+#define CAAM_CAPS_JOBRS_MASK	GENMASK(15, 1)	/* Job Ring is available in NS W=
orld */
+#define CAAM_CAPS_MC_ENABLED	BIT(16)	/* Management Complex is enabled (F/W i=
s active) */
+#define CAAM_CAPS_VIRT_ENABLED	BIT(17)	/* Virtualization enabled */
+#define CAAM_CAPS_64K_PAGESIZE	BIT(18)	/* CAAM register page size (64KB if s=
et, 4KB if unset) */
+
+#define CAAM_CAPS_JR_PRESENT(id)	(BIT(id) & CAAM_CAPS_JOBRS_MASK)
+#define CAAM_CAPS_PG_SHIFT(caps)	(((caps) & CAAM_CAPS_64K_PAGESIZE) ? 16 : 1=
2)
+#define CAAM_CAPS_PG_SZ(caps)		(1 << CAAM_CAPS_PG_SHIFT(caps))
+
 	int secvio_irq;		/* Security violation interrupt number */
-	int virt_en;		/* Virtualization enabled in CAAM */
 	int era;		/* CAAM Era (internal HW revision) */
=20
 #define	RNG4_MAX_HANDLES 2
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 7f2b1101f567..e218d4ae604c 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -511,10 +511,25 @@ static int caam_jr_probe(struct platform_device *pdev)
 	struct device_node *nprop;
 	struct caam_job_ring __iomem *ctrl;
 	struct caam_drv_private_jr *jrpriv;
-	static int total_jobrs;
+	struct caam_drv_private *caamctrlpriv;
+	u32 ring_idx;
 	struct resource *r;
 	int error;
=20
+	/*
+	 * Get register page to see the start address of CB.
+	 * Job Rings have their respective input base addresses
+	 * defined in the register IRBAR_JRx. This address is
+	 * present in the DT node and is aligned to the page
+	 * size defined@CAAM compile time.
+	 */
+	if (of_property_read_u32(pdev->dev.of_node, "reg", &ring_idx)) {
+		dev_err(&pdev->dev, "failed to get register address for jobr\n");
+		return -ENOMEM;
+	}
+	caamctrlpriv =3D dev_get_drvdata(pdev->dev.parent);
+	ring_idx =3D ring_idx >> CAAM_CAPS_PG_SHIFT(caamctrlpriv->caam_caps);
+
 	jrdev =3D &pdev->dev;
 	jrpriv =3D devm_kzalloc(jrdev, sizeof(*jrpriv), GFP_KERNEL);
 	if (!jrpriv)
@@ -523,7 +538,7 @@ static int caam_jr_probe(struct platform_device *pdev)
 	dev_set_drvdata(jrdev, jrpriv);
=20
 	/* save ring identity relative to detection */
-	jrpriv->ridx =3D total_jobrs++;
+	jrpriv->ridx =3D ring_idx;
=20
 	nprop =3D pdev->dev.of_node;
 	/* Get configuration properties from device tree */
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 3738625c0250..186e76e6a3e7 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -1023,6 +1023,4 @@ struct caam_deco {
 #define ASSURE_BLOCK_NUMBER	6
 #define QI_BLOCK_NUMBER		7
 #define DECO_BLOCK_NUMBER	8
-#define PG_SIZE_4K		0x1000
-#define PG_SIZE_64K		0x10000
 #endif /* REGS_H */
--=20
2.25.1


--===============0704978533309837032==--

