From: "gavin.liu" <gavin.liu@mediatek.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v3] optee: add timeout value to optee_notif_wait() to support timeout
Date: Tue, 07 May 2024 10:00:37 +0800
Message-ID: <20240507020037.14009-1-gavin.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3987890090478060588=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3987890090478060588==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Gavin Liu <gavin.liu@mediatek.com>

Add timeout value to support self waking when timeout to avoid waiting
indefinitely.

Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
---
change in v3:
1. change the comment in optee_rpc_cmd.h
2. add macro for "TEE_ERROR_TIMEOUT"
3. change from "TEEC_ERROR_BUSY" to "TEE_ERROR_TIMEOUT"
---
 drivers/tee/optee/notif.c         |  9 +++++++--
 drivers/tee/optee/optee_private.h |  5 ++++-
 drivers/tee/optee/optee_rpc_cmd.h |  1 +
 drivers/tee/optee/rpc.c           | 10 ++++++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
index 0d7878e770cd..1970880c796f 100644
--- a/drivers/tee/optee/notif.c
+++ b/drivers/tee/optee/notif.c
@@ -29,7 +29,7 @@ static bool have_key(struct optee *optee, u_int key)
 	return false;
 }
=20
-int optee_notif_wait(struct optee *optee, u_int key)
+int optee_notif_wait(struct optee *optee, u_int key, u32 timeout)
 {
 	unsigned long flags;
 	struct notif_entry *entry;
@@ -70,7 +70,12 @@ int optee_notif_wait(struct optee *optee, u_int key)
 	 * Unlock temporarily and wait for completion.
 	 */
 	spin_unlock_irqrestore(&optee->notif.lock, flags);
-	wait_for_completion(&entry->c);
+	if (timeout !=3D 0) {
+		if (!wait_for_completion_timeout(&entry->c, timeout))
+			rc =3D -ETIMEDOUT;
+	} else {
+		wait_for_completion(&entry->c);
+	}
 	spin_lock_irqsave(&optee->notif.lock, flags);
=20
 	list_del(&entry->link);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 429cc20be5cc..424898cdc4e9 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -26,6 +26,9 @@
 #define TEEC_ERROR_BUSY			0xFFFF000D
 #define TEEC_ERROR_SHORT_BUFFER		0xFFFF0010
=20
+/* API Return Codes are from the GP TEE Internal Core API Specification */
+#define TEE_ERROR_TIMEOUT		0xFFFF3001
+
 #define TEEC_ORIGIN_COMMS		0x00000002
=20
 /*
@@ -252,7 +255,7 @@ struct optee_call_ctx {
=20
 int optee_notif_init(struct optee *optee, u_int max_key);
 void optee_notif_uninit(struct optee *optee);
-int optee_notif_wait(struct optee *optee, u_int key);
+int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
 int optee_notif_send(struct optee *optee, u_int key);
=20
 u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_=
cmd.h
index f3f06e0994a7..4576751b490c 100644
--- a/drivers/tee/optee/optee_rpc_cmd.h
+++ b/drivers/tee/optee/optee_rpc_cmd.h
@@ -41,6 +41,7 @@
  * Waiting on notification
  * [in]    value[0].a	    OPTEE_RPC_NOTIFICATION_WAIT
  * [in]    value[0].b	    notification value
+ * [in]    value[0].c	    timeout in milliseconds or 0 if no timeout
  *
  * Sending a synchronous notification
  * [in]    value[0].a	    OPTEE_RPC_NOTIFICATION_SEND
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index f086812f1179..5de4504665be 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -130,6 +130,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_c=
ontext *ctx,
 static void handle_rpc_func_cmd_wq(struct optee *optee,
 				   struct optee_msg_arg *arg)
 {
+	int rc =3D 0;
+
 	if (arg->num_params !=3D 1)
 		goto bad;
=20
@@ -139,7 +141,8 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
=20
 	switch (arg->params[0].u.value.a) {
 	case OPTEE_RPC_NOTIFICATION_WAIT:
-		if (optee_notif_wait(optee, arg->params[0].u.value.b))
+		rc =3D optee_notif_wait(optee, arg->params[0].u.value.b, arg->params[0].u.=
value.c);
+		if (rc)
 			goto bad;
 		break;
 	case OPTEE_RPC_NOTIFICATION_SEND:
@@ -153,7 +156,10 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
 	arg->ret =3D TEEC_SUCCESS;
 	return;
 bad:
-	arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+	if (rc =3D=3D -ETIMEDOUT)
+		arg->ret =3D TEE_ERROR_TIMEOUT;
+	else
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 }
=20
 static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
--=20
2.18.0


--===============3987890090478060588==--

