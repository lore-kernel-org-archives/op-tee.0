From: "gavin.liu" <gavin.liu@mediatek.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v2] optee: add timeout value to optee_notif_wait() to support timeout
Date: Thu, 02 May 2024 16:56:36 +0800
Message-ID: <20240502085636.4049-1-gavin.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4104127894817070994=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4104127894817070994==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Gavin Liu <gavin.liu@mediatek.com>

Add timeout value to support self waking when timeout to avoid waiting
indefinitely.

Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
---
Change in v2:
Change commit message.
Add description for value[0].c in optee_rpc_cmd.h.
---
---
 drivers/tee/optee/notif.c         |  9 +++++++--
 drivers/tee/optee/optee_private.h |  2 +-
 drivers/tee/optee/optee_rpc_cmd.h |  1 +
 drivers/tee/optee/rpc.c           | 10 ++++++++--
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
index 05212842b0a5..d5e5c0645609 100644
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
index 7a5243c78b55..da990c4016ec 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -252,7 +252,7 @@ struct optee_call_ctx {
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
index f3f06e0994a7..99342aa66263 100644
--- a/drivers/tee/optee/optee_rpc_cmd.h
+++ b/drivers/tee/optee/optee_rpc_cmd.h
@@ -41,6 +41,7 @@
  * Waiting on notification
  * [in]    value[0].a	    OPTEE_RPC_NOTIFICATION_WAIT
  * [in]    value[0].b	    notification value
+ * [in]    value[0].c	    timeout in millisecond or 0 if no timeout
  *
  * Sending a synchronous notification
  * [in]    value[0].a	    OPTEE_RPC_NOTIFICATION_SEND
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index e69bc6380683..14e6246aaf05 100644
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
+		arg->ret =3D TEEC_ERROR_BUSY;
+	else
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 }
=20
 static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
--=20
2.18.0


--===============4104127894817070994==--

