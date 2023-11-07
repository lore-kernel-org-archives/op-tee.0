From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v2 1/2] optee: provide optee_do_bottom_half() as a common function
Date: Tue, 07 Nov 2023 17:06:56 +0100
Message-ID: <20231107160657.3798803-2-jens.wiklander@linaro.org>
In-Reply-To: <20231107160657.3798803-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0018709035652683577=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0018709035652683577==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Provides optee_do_bottom_half() and optee_stop_async_notif() as common
functions callable from the FF-A ABI part of the driver too.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/call.c          | 31 +++++++++++++++++++++++++-
 drivers/tee/optee/optee_private.h |  5 ++++-
 drivers/tee/optee/smc_abi.c       | 36 ++++---------------------------
 3 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index df5fb5410b72..5afc759794ce 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015-2021, Linaro Limited
+ * Copyright (c) 2015-2021, 2023 Linaro Limited
  */
 #include <linux/device.h>
 #include <linux/err.h>
@@ -524,3 +524,32 @@ int optee_check_mem_type(unsigned long start, size_t num=
_pages)
=20
 	return rc;
 }
+
+static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+
+	msg_arg =3D optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd =3D cmd;
+	optee->ops->do_call_with_arg(ctx, shm, offs);
+
+	optee_free_msg_arg(ctx, entry, offs);
+	return 0;
+}
+
+int optee_do_bottom_half(struct tee_context *ctx)
+{
+	return simple_call_with_arg(ctx, OPTEE_MSG_CMD_DO_BOTTOM_HALF);
+}
+
+int optee_stop_async_notif(struct tee_context *ctx)
+{
+	return simple_call_with_arg(ctx, OPTEE_MSG_CMD_STOP_ASYNC_NOTIF);
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 72685ee0d53f..2165bd11e6ac 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2015-2021, Linaro Limited
+ * Copyright (c) 2015-2021, 2023 Linaro Limited
  */
=20
 #ifndef OPTEE_PRIVATE_H
@@ -325,6 +325,9 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, st=
ruct tee_shm *shm);
 void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
 		   struct optee_msg_arg *arg);
=20
+int optee_do_bottom_half(struct tee_context *ctx);
+int optee_stop_async_notif(struct tee_context *ctx);
+
 /*
  * Small helpers
  */
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index d5b28fd35d66..94e96803a722 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015-2021, Linaro Limited
+ * Copyright (c) 2015-2021, 2023 Linaro Limited
  * Copyright (c) 2016, EPAM Systems
  */
=20
@@ -965,34 +965,6 @@ static int optee_smc_do_call_with_arg(struct tee_context=
 *ctx,
 	return rc;
 }
=20
-static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
-{
-	struct optee_shm_arg_entry *entry;
-	struct optee_msg_arg *msg_arg;
-	struct tee_shm *shm;
-	u_int offs;
-
-	msg_arg =3D optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
-	if (IS_ERR(msg_arg))
-		return PTR_ERR(msg_arg);
-
-	msg_arg->cmd =3D cmd;
-	optee_smc_do_call_with_arg(ctx, shm, offs);
-
-	optee_free_msg_arg(ctx, entry, offs);
-	return 0;
-}
-
-static int optee_smc_do_bottom_half(struct tee_context *ctx)
-{
-	return simple_call_with_arg(ctx, OPTEE_MSG_CMD_DO_BOTTOM_HALF);
-}
-
-static int optee_smc_stop_async_notif(struct tee_context *ctx)
-{
-	return simple_call_with_arg(ctx, OPTEE_MSG_CMD_STOP_ASYNC_NOTIF);
-}
-
 /*
  * 5. Asynchronous notification
  */
@@ -1048,7 +1020,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *d=
ev_id)
 {
 	struct optee *optee =3D dev_id;
=20
-	optee_smc_do_bottom_half(optee->ctx);
+	optee_do_bottom_half(optee->ctx);
=20
 	return IRQ_HANDLED;
 }
@@ -1086,7 +1058,7 @@ static void notif_pcpu_irq_work_fn(struct work_struct *=
work)
 						   notif_pcpu_work);
 	struct optee *optee =3D container_of(optee_smc, struct optee, smc);
=20
-	optee_smc_do_bottom_half(optee->ctx);
+	optee_do_bottom_half(optee->ctx);
 }
=20
 static int init_pcpu_irq(struct optee *optee, u_int irq)
@@ -1158,7 +1130,7 @@ static void uninit_pcpu_irq(struct optee *optee)
 static void optee_smc_notif_uninit_irq(struct optee *optee)
 {
 	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
-		optee_smc_stop_async_notif(optee->ctx);
+		optee_stop_async_notif(optee->ctx);
 		if (optee->smc.notif_irq) {
 			if (irq_is_percpu_devid(optee->smc.notif_irq))
 				uninit_pcpu_irq(optee);
--=20
2.34.1


--===============0018709035652683577==--

