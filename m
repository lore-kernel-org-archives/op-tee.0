From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v6 2/2] optee: add per cpu asynchronous notification
Date: Wed, 22 Mar 2023 14:22:12 +0100
Message-ID: <20230322132212.3646972-2-etienne.carriere@linaro.org>
In-Reply-To: <20230322132212.3646972-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6245688769121432702=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6245688769121432702==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Implements use of per-cpu irq for optee asynchronous notification.

Existing optee async notif implementation allows OP-TEE world to
raise an interrupt on which Linux optee driver will query some pending
events. This change allows the signaling interrupt to be a per-cpu
interrupt as with Arm GIC PPIs. Using a PPI instead of an SPI is useful
when no GIC lines are provisioned in the chip design and there are spare
PPI lines.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>

Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v5:
- Removed spurious __percpu attributes reported by kernel test robot
  (https://lore.kernel.org/lkml/202303190039.RsU7kCIu-lkp(a)intel.com/).

Changes since v4:
- Used cpuhp_setup_state()/cpuhp_remove_state() to enable/disable the
  per-cpu interrupt and let CPU hotplug also manage it.
- Added a call to destroy_workqueue() that was missing in uninit_pcpu_irq().
- Rephrased commit message.

Changes since v3:
- Fixed typo in commit message.
- Added few words in commit message about why we do this change.
- Appended a 2nd commit to the series for request DT bindings update.

Changes since v2:
- Irq and per-cpu irq no more share the primary same handler function
  but have a common irq_handler() helper function.
- Removed useless spinlocks.
- Wrapped lines > 80 char.

Changes since v1:
- Fixed missing __percpu attribute reported by kernel test robot.
- Rephrased commit message and added Cc tags.
---
 drivers/tee/optee/optee_private.h |  24 ++++++
 drivers/tee/optee/smc_abi.c       | 122 +++++++++++++++++++++++++++++-
 2 files changed, 142 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 04ae58892608..6129d43dd354 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -94,11 +94,35 @@ struct optee_supp {
 	struct completion reqs_c;
 };
=20
+/*
+ * struct optee_pcpu - per cpu notif private struct passed to work functions
+ * @optee		optee device reference
+ */
+struct optee_pcpu {
+	struct optee *optee;
+};
+
+/*
+ * struct optee_smc - optee smc communication struct
+ * @invoke_fn		handler function to invoke secure monitor
+ * @memremaped_shm	virtual address of memory in shared memory pool
+ * @sec_caps:		secure world capabilities defined by
+ *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
+ * @notif_irq		interrupt used as async notification by OP-TEE or 0
+ * @optee_pcpu		per_cpu optee instance for per cpu work or NULL
+ * @notif_pcpu_wq	workqueue for per cpu aynchronous notification or NULL
+ * @notif_pcpu_work	work for per cpu asynchronous notification
+ * @notif_cpuhp_state   CPU hotplug state assigned for pcpu interrupt manage=
ment
+ */
 struct optee_smc {
 	optee_invoke_fn *invoke_fn;
 	void *memremaped_shm;
 	u32 sec_caps;
 	unsigned int notif_irq;
+	struct optee_pcpu __percpu *optee_pcpu;
+	struct workqueue_struct *notif_pcpu_wq;
+	struct work_struct notif_pcpu_work;
+	unsigned int notif_cpuhp_state;
 };
=20
 /**
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..de7ac9a46354 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -52,6 +52,23 @@
  */
 #define OPTEE_MIN_STATIC_POOL_ALIGN    9 /* 512 bytes aligned */
=20
+/* SMC ABI considers at most a single TEE firmware */
+static unsigned int pcpu_irq_num;
+
+static int optee_cpuhp_enable_pcpu_irq(unsigned int cpu)
+{
+	enable_percpu_irq(pcpu_irq_num, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int optee_cpuhp_disable_pcpu_irq(unsigned int cpu)
+{
+	disable_percpu_irq(pcpu_irq_num);
+
+	return 0;
+}
+
 /*
  * 1. Convert between struct tee_param and struct optee_msg_param
  *
@@ -991,9 +1008,8 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke=
_fn, bool *value_valid,
 	return res.a1;
 }
=20
-static irqreturn_t notif_irq_handler(int irq, void *dev_id)
+static irqreturn_t irq_handler(struct optee *optee)
 {
-	struct optee *optee =3D dev_id;
 	bool do_bottom_half =3D false;
 	bool value_valid;
 	bool value_pending;
@@ -1016,6 +1032,13 @@ static irqreturn_t notif_irq_handler(int irq, void *de=
v_id)
 	return IRQ_HANDLED;
 }
=20
+static irqreturn_t notif_irq_handler(int irq, void *dev_id)
+{
+	struct optee *optee =3D dev_id;
+
+	return irq_handler(optee);
+}
+
 static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
 {
 	struct optee *optee =3D dev_id;
@@ -1025,7 +1048,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *d=
ev_id)
 	return IRQ_HANDLED;
 }
=20
-static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
+static int init_irq(struct optee *optee, u_int irq)
 {
 	int rc;
=20
@@ -1040,12 +1063,103 @@ static int optee_smc_notif_init_irq(struct optee *op=
tee, u_int irq)
 	return 0;
 }
=20
+static irqreturn_t notif_pcpu_irq_handler(int irq, void *dev_id)
+{
+	struct optee_pcpu *pcpu =3D dev_id;
+	struct optee *optee =3D pcpu->optee;
+
+	if (irq_handler(optee) =3D=3D IRQ_WAKE_THREAD)
+		queue_work(optee->smc.notif_pcpu_wq,
+			   &optee->smc.notif_pcpu_work);
+
+	return IRQ_HANDLED;
+}
+
+static void notif_pcpu_irq_work_fn(struct work_struct *work)
+{
+	struct optee_smc *optee_smc =3D container_of(work, struct optee_smc,
+						   notif_pcpu_work);
+	struct optee *optee =3D container_of(optee_smc, struct optee, smc);
+
+	optee_smc_do_bottom_half(optee->ctx);
+}
+
+static int init_pcpu_irq(struct optee *optee, u_int irq)
+{
+	struct optee_pcpu __percpu *optee_pcpu;
+	int cpu, rc;
+
+	optee_pcpu =3D alloc_percpu(struct optee_pcpu);
+	if (!optee_pcpu)
+		return -ENOMEM;
+
+	for_each_present_cpu(cpu)
+		per_cpu_ptr(optee_pcpu, cpu)->optee =3D optee;
+
+	rc =3D request_percpu_irq(irq, notif_pcpu_irq_handler,
+				"optee_pcpu_notification", optee_pcpu);
+	if (rc)
+		goto err_free_pcpu;
+
+	INIT_WORK(&optee->smc.notif_pcpu_work, notif_pcpu_irq_work_fn);
+	optee->smc.notif_pcpu_wq =3D create_workqueue("optee_pcpu_notification");
+	if (!optee->smc.notif_pcpu_wq) {
+		rc =3D -EINVAL;
+		goto err_free_pcpu_irq;
+	}
+
+	optee->smc.optee_pcpu =3D optee_pcpu;
+	optee->smc.notif_irq =3D irq;
+
+	pcpu_irq_num =3D irq;
+	rc =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "optee/pcpu-notif:starting",
+			       optee_cpuhp_enable_pcpu_irq,
+			       optee_cpuhp_disable_pcpu_irq);
+	if (!rc)
+		rc =3D -EINVAL;
+	if (rc < 0)
+		goto err_free_pcpu_irq;
+
+	optee->smc.notif_cpuhp_state =3D rc;
+
+	return 0;
+
+err_free_pcpu_irq:
+	free_percpu_irq(irq, optee_pcpu);
+err_free_pcpu:
+	free_percpu(optee_pcpu);
+
+	return rc;
+}
+
+static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
+{
+	if (irq_is_percpu_devid(irq))
+		return init_pcpu_irq(optee, irq);
+	else
+		return init_irq(optee, irq);
+}
+
+static void uninit_pcpu_irq(struct optee *optee)
+{
+	cpuhp_remove_state(optee->smc.notif_cpuhp_state);
+
+	destroy_workqueue(optee->smc.notif_pcpu_wq);
+
+	free_percpu_irq(optee->smc.notif_irq, optee->smc.optee_pcpu);
+	free_percpu(optee->smc.optee_pcpu);
+}
+
 static void optee_smc_notif_uninit_irq(struct optee *optee)
 {
 	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
 		optee_smc_stop_async_notif(optee->ctx);
 		if (optee->smc.notif_irq) {
-			free_irq(optee->smc.notif_irq, optee);
+			if (irq_is_percpu_devid(optee->smc.notif_irq))
+				uninit_pcpu_irq(optee);
+			else
+				free_irq(optee->smc.notif_irq, optee);
+
 			irq_dispose_mapping(optee->smc.notif_irq);
 		}
 	}
--=20
2.25.1


--===============6245688769121432702==--

