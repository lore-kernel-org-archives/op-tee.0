From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v5 2/2] optee: multiplex tee interrupt events on optee async notif irq
Date: Sat, 06 May 2023 09:32:35 +0200
Message-ID: <20230506073235.2770292-2-etienne.carriere@linaro.org>
In-Reply-To: <20230506073235.2770292-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2288646591302321032=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2288646591302321032==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Implements an irqchip in optee driver for the interrupt events notified
from OP-TEE world to the Linux kernel. Optee registers up to 1 interrupt
controller and identifies each line with a line number from 0 to
UINT16_MAX. The interrupt line identifiers and their meaning are
specific to the platform and shall be found in the OP-TEE platform
documentation

There already exists an optee asynchronous notification mechanism using
an irq for OP-TEE to signal to Linux kernel optee driver of a pending
asynchronous events. This existing implementation binds each notified
event to the awaking of a thread waiting to call the TEE. The optee
irqchip service added by this change uses that same irq for
optee interrupt notification.

When optee driver initializes, TEE tells whether it supports interrupt
notification services or not upon what optee driver registers or not
its irqchip controller.

OP-TEE SMC ABI defines 4 new SMC function IDs for non-secure world to
manage optee interrupt events.

Fastcall SMC funcID OPTEE_SMC_GET_NOTIF_ITR allows non-secure world to
retrieve pending interrupts by grapes up to 5 lines. For efficiency,
the function also reports whether there are pending async values
targeting suspended threaded sequences execution and whether TEE has
background threaded work to do.

Fastcall SMC funcID OPTEE_SMC_NOTIF_ITR_SET_MASK allows a Linux kernel
optee irq consumer to mask/unmask the irq line.

Yielded SMC funcID OPTEE_SMC_NOTIF_ITR_SET_STATE allows a Linux kernel
optee irq consumer to enable and disable the irq line

Yielded SMC funcID OPTEE_SMC_NOTIF_ITR_SET_WAKEUP allows a Linux kernel
optee irq consumer to enable and disable the wakeup from low power
capability of the interrupt.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v4:
- Resolved rebase conflicts since integration in v6.3-rc3 of
  commit b3b4ced12c1b ("optee: add per cpu asynchronous notification").
- Slightly rephrased commit message.

Changes since v3:
- Removed OP-TEE PTA service for interrup enable/wakeup config and
  replaced with OP-TEE standard SMC funcion IDs
  OPTEE_SMC_NOTIF_ITR_SET_STATE and OPTEE_SMC_NOTIF_ITR_SET_WAKEUP.
  With this update, patch 3/3 of v3 is no more needed.

Changes since v2:
- Renamed it_notif/IT_NOTIF to itr_notif/ITR_NOTIF.
- Updated retrieve_pending_irqs() loop from review comments.
- Changed OP-TEE ABI function CONFIGURE_IT to a only act on interrupt
  mask state. The function is renamed xxx_NOTIF_ITR_SET_MASK.
- Don't set OPTEE_SMC_SEC_CAP_IT_NOTIF among non-secure capabilities, the
  capability is related only to whether secure world supports interrupt
  notification to normal world.
- Fixed inline description from review comments.
- Rephrased commit message and added a sentence about optee irq line
  number values and meaning.

Changes since v1:
- Removed dependency on optee per-cpu irq notification.
- Change SMC function ID API to retrieves up to 5 optee irq events,
  the optee bottom half event and returns if other async notifications
  are pending, in a single invocation.
- Implement only mask/unmask irqchip handlers with a 2nd SMC function
  to mask/unmask a optee irq in OP-TEE world from an interrupt context.
- Added Cc: tags.
---
 drivers/tee/optee/optee_private.h |   2 +
 drivers/tee/optee/optee_smc.h     | 133 ++++++++++++++++++++-
 drivers/tee/optee/smc_abi.c       | 186 +++++++++++++++++++++++++++++-
 3 files changed, 315 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 72685ee0d53f..3406c6c8ea30 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -113,6 +113,7 @@ struct optee_pcpu {
  * @notif_pcpu_wq	workqueue for per cpu asynchronous notification or NULL
  * @notif_pcpu_work	work for per cpu asynchronous notification
  * @notif_cpuhp_state   CPU hotplug state assigned for pcpu interrupt manage=
ment
+ * @domain		interrupt domain registered by OP-TEE driver
  */
 struct optee_smc {
 	optee_invoke_fn *invoke_fn;
@@ -123,6 +124,7 @@ struct optee_smc {
 	struct workqueue_struct *notif_pcpu_wq;
 	struct work_struct notif_pcpu_work;
 	unsigned int notif_cpuhp_state;
+	struct irq_domain *domain;
 };
=20
 /**
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 7d9fa426505b..73160379c738 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -250,7 +250,8 @@ struct optee_smc_get_shm_config_result {
  * a3	Bit[7:0]: Number of parameters needed for RPC to be supplied
  *		  as the second MSG arg struct for
  *		  OPTEE_SMC_CALL_WITH_ARG
- *	Bit[31:8]: Reserved (MBZ)
+ *	Bit[23:8]: The maximum interrupt event notification number
+ *	Bit[31:24]: Reserved (MBZ)
  * a4-7	Preserved
  *
  * Error return register usage:
@@ -278,6 +279,11 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
 /* Secure world supports pre-allocating RPC arg struct */
 #define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
+/* Secure world supports interrupt events notification to normal world */
+#define OPTEE_SMC_SEC_CAP_ITR_NOTIF		BIT(7)
+
+#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_ITR_MASK	GENMASK(23, 8)
+#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_ITR_SHIFT	8
=20
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
@@ -450,6 +456,131 @@ struct optee_smc_disable_shm_cache_result {
 /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
 #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
=20
+/*
+ * Retrieve up to 5 pending interrupt events notified by OP-TEE world,
+ * whether bottom half is to be scheduled and if there are pending
+ * async event for waiting threads, all this since the last call of
+ * this function.
+ *
+ * Interrupts notified by OP-TEE are identified by a number from 0 to
+ * the interrupt number max value for that platform. Values for each
+ * interrupt number are platform specific and shall be found in the
+ * OP-TEE platform documentation.
+ *
+ * OP-TEE keeps a record of all posted interrupt notification events.
+ * When the async notif interrupt is received by normal world,
+ * this function should be called until all pended interrupt events
+ * have been retrieved. When an interrupt event is retrieved, it is
+ * cleared from the record in OP-TEE world. When do bottom half event
+ * is retrieved (async value 0), it is also cleared from its related
+ * record in OP-TEE world.
+ *
+ * It is expected that this function is called from an interrupt handler
+ * in normal world.
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_GET_NOTIF_ITR
+ * a1-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1	Bit[7:0]: Number of pending interrupt carried in a1..a5
+ *	Bit[8]: OPTEE_SMC_NOTIF_ITR_PENDING if other interrupt(s) are pending
+ *	Bit[9]: OPTEE_SMC_NOTIF_ASYNC_PENDING if a threaded event is pending
+ *		excluding bottom half notification that is retrieved in Bit[10].
+ *	Bit[10]: OPTEE_SMC_NOTIF_DO_BOTTOM_HALF if retrieved bottom half notif
+ *	Bit[15:11]: Reserved for future use, MBZ
+ *	Bit[31:16]: Pending interrupt line value if a1 & 0xFF >=3D 1
+ * a2	Bit[15:0]:  Pending interrupt line value if a1 & 0xFF >=3D 2
+ *	Bit[31:16]: Pending interrupt line value if a1 & 0xFF >=3D 3
+ * a3	Bit[15:0]:  Pending interrupt line value if a1 & 0xFF >=3D 4
+ *	Bit[31:16]: Pending interrupt line value if a1 & 0xFF =3D=3D 5
+ * a4-7 Preserved
+ *
+ * Not supported return register usage:
+ * a0	OPTEE_SMC_RETURN_ENOTAVAIL
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_NOTIF_ITR_COUNT_MASK		GENMASK(7, 0)
+#define OPTEE_SMC_NOTIF_ITR_PENDING		BIT(8)
+#define OPTEE_SMC_NOTIF_VALUE_PENDING		BIT(9)
+#define OPTEE_SMC_NOTIF_DO_BOTTOM_HALF		BIT(10)
+
+#define OPTEE_SMC_FUNCID_GET_NOTIF_ITR		20
+#define OPTEE_SMC_GET_NOTIF_ITR \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_NOTIF_ITR)
+
+/*
+ * Mask/unmask an interrupt notification
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_NOTIF_ITR_SET_MASK
+ * a1	Interrupt number identifier value
+ * a2	1 to mask, 0 to unmask the interrupt notification.
+ * a3-6	Reserved for future use, MBZ
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1-7	Preserved
+ *
+ * Invalid command with provided arguments return usage:
+ * a0	OPTEE_SMC_RETURN_EBADCMD
+ * a1-7	Preserved
+ *
+ * Not supported return register usage:
+ * a0	OPTEE_SMC_RETURN_ENOTAVAIL
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_FUNCID_NOTIF_ITR_SET_MASK	21
+#define OPTEE_SMC_NOTIF_ITR_SET_MASK \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_NOTIF_ITR_SET_MASK)
+
+/*
+ * Enable/disable an interrupt notification
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_NOTIF_ITR_SET_STATE
+ * a1	Interrupt number identifier value
+ * a2	1 to enable, 0 to disable the interrupt notification
+ * a3-6	Reserved for future use, MBZ
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1-7	Preserved
+ *
+ * Invalid command with provided arguments return usage:
+ * a0	OPTEE_SMC_RETURN_EBADCMD
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_FUNCID_NOTIF_ITR_SET_STATE	22
+#define OPTEE_SMC_NOTIF_ITR_SET_STATE \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_NOTIF_ITR_SET_STATE)
+
+/*
+ * Enable/disable the wake up from low power feature of an interrupt event
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_NOTIF_ITR_SET_WAKEUP
+ * a1	Interrupt number identifier value
+ * a2	1 to enable, 0 to disable the interrupt wake up capability
+ * a3-6	Reserved for future use, MBZ
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1-7	Preserved
+ *
+ * Invalid command with provided arguments return usage:
+ * a0	OPTEE_SMC_RETURN_EBADCMD
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_FUNCID_NOTIF_ITR_SET_WAKEUP	23
+#define OPTEE_SMC_NOTIF_ITR_SET_WAKEUP \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_NOTIF_ITR_SET_WAKEUP)
+
 /*
  * Resume from RPC (for example after processing a foreign interrupt)
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 49702cb08f4f..e383811a5f6d 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -997,6 +997,99 @@ static int optee_smc_stop_async_notif(struct tee_context=
 *ctx)
  * 5. Asynchronous notification
  */
=20
+static void optee_itr_notif_mask(struct irq_data *d)
+{
+	struct optee *optee =3D d->domain->host_data;
+	struct arm_smccc_res res =3D { };
+
+	optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_MASK, d->hwirq, 1,
+			     0, 0, 0, 0, 0, &res);
+}
+
+static void optee_itr_notif_unmask(struct irq_data *d)
+{
+	struct optee *optee =3D d->domain->host_data;
+	struct arm_smccc_res res =3D { };
+
+	optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_MASK, d->hwirq, 0,
+			     0, 0, 0, 0, 0, &res);
+}
+
+static void optee_itr_notif_enable(struct irq_data *d)
+{
+	struct optee *optee =3D d->domain->host_data;
+	struct arm_smccc_res res;
+
+	optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_STATE, d->hwirq, 1,
+			     0, 0, 0, 0, 0, &res);
+}
+
+static void optee_itr_notif_disable(struct irq_data *d)
+{
+	struct optee *optee =3D d->domain->host_data;
+	struct arm_smccc_res res;
+
+	optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_STATE, d->hwirq, 0,
+			     0, 0, 0, 0, 0, &res);
+}
+
+static int optee_itr_notif_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct optee *optee =3D d->domain->host_data;
+	struct arm_smccc_res res;
+
+	optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_WAKEUP, d->hwirq, !!on,
+			     0, 0, 0, 0, 0, &res);
+
+	if (res.a0)
+		return -EINVAL;
+	return 0;
+}
+
+static struct irq_chip optee_irq_chip =3D {
+	.name =3D "optee-itr-notif",
+	.irq_mask =3D optee_itr_notif_mask,
+	.irq_unmask =3D optee_itr_notif_unmask,
+	.irq_disable =3D optee_itr_notif_disable,
+	.irq_enable =3D optee_itr_notif_enable,
+	.irq_set_wake =3D optee_itr_notif_set_wake,
+};
+
+static int optee_itr_alloc(struct irq_domain *d, unsigned int virq,
+			  unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec =3D data;
+	irq_hw_number_t hwirq;
+
+	hwirq =3D fwspec->param[0];
+
+	irq_domain_set_hwirq_and_chip(d, virq, hwirq, &optee_irq_chip,
+				      d->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops optee_irq_domain_ops =3D {
+	.alloc =3D optee_itr_alloc,
+	.free =3D irq_domain_free_irqs_common,
+};
+
+static int optee_irq_domain_init(struct platform_device *pdev,
+				 struct optee *optee, u_int max_it)
+{
+	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
+
+	optee->smc.domain =3D irq_domain_add_linear(np, max_it,
+						  &optee_irq_domain_ops, optee);
+	if (!optee->smc.domain) {
+		dev_err(dev, "Unable to add irq domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_val=
id,
 				 bool *value_pending)
 {
@@ -1011,6 +1104,61 @@ static u32 get_async_notif_value(optee_invoke_fn *invo=
ke_fn, bool *value_valid,
 	return res.a1;
 }
=20
+static void forward_irq(struct optee *optee, unsigned int itr_num)
+{
+	if (generic_handle_domain_irq(optee->smc.domain, itr_num)) {
+		struct arm_smccc_res res =3D { };
+
+		pr_err("No consumer for optee irq %u, masked\n", itr_num);
+		optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_MASK, itr_num, 1,
+				     0, 0, 0, 0, 0, &res);
+	}
+}
+
+static void retrieve_pending_irqs(struct optee *optee, bool *async_pending,
+				  bool *do_bottom_half)
+
+{
+	struct arm_smccc_res res;
+	bool irq_pending;
+	ssize_t cnt;
+	const unsigned int lsb_mask =3D GENMASK(15, 0);
+	const unsigned int msb_shift =3D 16;
+
+	*do_bottom_half =3D false;
+
+	do {
+		optee->smc.invoke_fn(OPTEE_SMC_GET_NOTIF_ITR, 0, 0, 0, 0, 0, 0,
+				     0, &res);
+
+		if (res.a0)
+			return;
+
+		if (res.a1 & OPTEE_SMC_NOTIF_DO_BOTTOM_HALF)
+			*do_bottom_half =3D true;
+
+		irq_pending =3D res.a1 & OPTEE_SMC_NOTIF_ITR_PENDING;
+		cnt =3D res.a1 & OPTEE_SMC_NOTIF_ITR_COUNT_MASK;
+		if (cnt > 5 || (!cnt && irq_pending)) {
+			WARN_ONCE(0, "Unexpected irq notif count %zi\n", cnt);
+			break;
+		}
+
+		if (cnt > 0)
+			forward_irq(optee, res.a1 >> msb_shift);
+		if (cnt > 1)
+			forward_irq(optee, res.a2 & lsb_mask);
+		if (cnt > 2)
+			forward_irq(optee, res.a2 >> msb_shift);
+		if (cnt > 3)
+			forward_irq(optee, res.a3 & lsb_mask);
+		if (cnt =3D=3D 5)
+			forward_irq(optee, res.a3 >> msb_shift);
+	} while (irq_pending);
+
+	*async_pending =3D res.a1 & OPTEE_SMC_NOTIF_VALUE_PENDING;
+}
+
 static irqreturn_t irq_handler(struct optee *optee)
 {
 	bool do_bottom_half =3D false;
@@ -1018,9 +1166,15 @@ static irqreturn_t irq_handler(struct optee *optee)
 	bool value_pending;
 	u32 value;
=20
-	do {
-		value =3D get_async_notif_value(optee->smc.invoke_fn,
-					      &value_valid, &value_pending);
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ITR_NOTIF)
+		retrieve_pending_irqs(optee, &value_pending, &do_bottom_half);
+	else
+		value_pending =3D true;
+
+	while (value_pending) {
+		value =3D get_async_notif_value(optee->smc.invoke_fn, &value_valid,
+					      &value_pending);
+
 		if (!value_valid)
 			break;
=20
@@ -1028,7 +1182,7 @@ static irqreturn_t irq_handler(struct optee *optee)
 			do_bottom_half =3D true;
 		else
 			optee_notif_send(optee, value);
-	} while (value_pending);
+	}
=20
 	if (do_bottom_half)
 		return IRQ_WAKE_THREAD;
@@ -1165,6 +1319,9 @@ static void optee_smc_notif_uninit_irq(struct optee *op=
tee)
=20
 			irq_dispose_mapping(optee->smc.notif_irq);
 		}
+
+		if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ITR_NOTIF)
+			irq_domain_remove(optee->smc.domain);
 	}
 }
=20
@@ -1320,6 +1477,7 @@ static bool optee_msg_api_revision_is_compatible(optee_=
invoke_fn *invoke_fn)
=20
 static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 					    u32 *sec_caps, u32 *max_notif_value,
+					    u32 *max_notif_it,
 					    unsigned int *rpc_param_count)
 {
 	union {
@@ -1352,6 +1510,13 @@ static bool optee_msg_exchange_capabilities(optee_invo=
ke_fn *invoke_fn,
 	else
 		*rpc_param_count =3D 0;
=20
+	if (*sec_caps & OPTEE_SMC_SEC_CAP_ITR_NOTIF)
+		*max_notif_it =3D (res.result.data &
+				 OPTEE_SMC_SEC_CAP_MAX_NOTIF_ITR_MASK) >>
+				OPTEE_SMC_SEC_CAP_MAX_NOTIF_ITR_SHIFT;
+	else
+		*max_notif_it =3D 0;
+
 	return true;
 }
=20
@@ -1611,6 +1776,7 @@ static int optee_probe(struct platform_device *pdev)
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	u32 max_notif_value;
+	u32 max_notif_it;
 	u32 arg_cache_flags;
 	u32 sec_caps;
 	int rc;
@@ -1636,7 +1802,7 @@ static int optee_probe(struct platform_device *pdev)
 	}
=20
 	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
-					     &max_notif_value,
+					     &max_notif_value, &max_notif_it,
 					     &rpc_param_count)) {
 		pr_warn("capabilities mismatch\n");
 		return -EINVAL;
@@ -1757,6 +1923,16 @@ static int optee_probe(struct platform_device *pdev)
 			irq_dispose_mapping(irq);
 			goto err_notif_uninit;
 		}
+
+		if (sec_caps & OPTEE_SMC_SEC_CAP_ITR_NOTIF) {
+			rc =3D optee_irq_domain_init(pdev, optee, max_notif_it);
+			if (rc) {
+				free_irq(optee->smc.notif_irq, optee);
+				irq_dispose_mapping(irq);
+				goto err_notif_uninit;
+			}
+		}
+
 		enable_async_notif(optee->smc.invoke_fn);
 		pr_info("Asynchronous notifications enabled\n");
 	}
--=20
2.25.1


--===============2288646591302321032==--

