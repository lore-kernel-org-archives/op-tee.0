From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 1/3] optee: add per cpu asynchronous notification
Date: Thu, 12 Jan 2023 15:54:22 +0100
Message-ID: <20230112145424.3791276-2-etienne.carriere@linaro.org>
In-Reply-To: <20230112145424.3791276-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4098771428992253336=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4098771428992253336==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Implements use of per CPU irq for asynchronous notification next to
existing standard irq support. This change allows for example to use
GIC_PPI on platforms where no GIC_SPI is provisioned for OP-TEE
asynchronous notification.

Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/tee/optee/optee_private.h |  22 ++++++
 drivers/tee/optee/smc_abi.c       | 107 ++++++++++++++++++++++++++++--
 2 files changed, 124 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 04ae58892608..e5bd3548691f 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -94,11 +94,33 @@ struct optee_supp {
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
+ */
 struct optee_smc {
 	optee_invoke_fn *invoke_fn;
 	void *memremaped_shm;
 	u32 sec_caps;
 	unsigned int notif_irq;
+	struct optee_pcpu __percpu *optee_pcpu;
+	struct workqueue_struct *notif_pcpu_wq;
+	struct work_struct notif_pcpu_work;
 };
=20
 /**
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..8c2d58d605ac 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -993,12 +993,20 @@ static u32 get_async_notif_value(optee_invoke_fn *invok=
e_fn, bool *value_valid,
=20
 static irqreturn_t notif_irq_handler(int irq, void *dev_id)
 {
-	struct optee *optee =3D dev_id;
+	struct optee *optee;
 	bool do_bottom_half =3D false;
 	bool value_valid;
 	bool value_pending;
 	u32 value;
=20
+	if (irq_is_percpu_devid(irq)) {
+		struct optee_pcpu *pcpu =3D (struct optee_pcpu *)dev_id;
+
+		optee =3D pcpu->optee;
+	} else {
+		optee =3D dev_id;
+	}
+
 	do {
 		value =3D get_async_notif_value(optee->smc.invoke_fn,
 					      &value_valid, &value_pending);
@@ -1011,8 +1019,13 @@ static irqreturn_t notif_irq_handler(int irq, void *de=
v_id)
 			optee_notif_send(optee, value);
 	} while (value_pending);
=20
-	if (do_bottom_half)
-		return IRQ_WAKE_THREAD;
+	if (do_bottom_half) {
+		if (irq_is_percpu_devid(irq))
+			queue_work(optee->smc.notif_pcpu_wq, &optee->smc.notif_pcpu_work);
+		else
+			return IRQ_WAKE_THREAD;
+	}
+
 	return IRQ_HANDLED;
 }
=20
@@ -1025,7 +1038,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *d=
ev_id)
 	return IRQ_HANDLED;
 }
=20
-static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
+static int init_irq(struct optee *optee, u_int irq)
 {
 	int rc;
=20
@@ -1040,12 +1053,96 @@ static int optee_smc_notif_init_irq(struct optee *opt=
ee, u_int irq)
 	return 0;
 }
=20
+static void notif_pcpu_irq_work_fn(struct work_struct *work)
+{
+	struct optee_smc *optee_smc =3D container_of(work, struct optee_smc, notif_=
pcpu_work);
+	struct optee *optee =3D container_of(optee_smc, struct optee, smc);
+
+	optee_smc_do_bottom_half(optee->ctx);
+}
+
+static int init_pcpu_irq(struct optee *optee, u_int irq)
+{
+	struct optee_pcpu *optee_pcpu;
+	spinlock_t lock;
+	int cpu;
+	int rc;
+
+	optee_pcpu =3D alloc_percpu(struct optee_pcpu);
+	if (!optee_pcpu)
+		return -ENOMEM;
+
+	for_each_present_cpu(cpu) {
+		struct optee_pcpu *p =3D per_cpu_ptr(optee_pcpu, cpu);
+
+		p->optee =3D optee;
+	}
+
+	rc =3D request_percpu_irq(irq, notif_irq_handler,
+				"optee_pcpu_notification", optee_pcpu);
+	if (rc)
+		goto err_free_pcpu;
+
+	spin_lock_init(&lock);
+
+	spin_lock(&lock);
+	enable_percpu_irq(irq, 0);
+	spin_unlock(&lock);
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
+	return 0;
+
+err_free_pcpu_irq:
+	spin_lock(&lock);
+	disable_percpu_irq(irq);
+	spin_unlock(&lock);
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
+	spinlock_t lock;
+
+	spin_lock_init(&lock);
+	spin_lock(&lock);
+	disable_percpu_irq(optee->smc.notif_irq);
+	spin_unlock(&lock);
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


--===============4098771428992253336==--

