From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 2/5] optee: simplify optee_release()
Date: Thu, 27 May 2021 10:14:01 +0200
Message-ID: <20210527081404.1433177-3-jens.wiklander@linaro.org>
In-Reply-To: <20210527081404.1433177-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3145445251876032237=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3145445251876032237==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Simplifies optee_release() with a new helper function,
optee_close_session_helper() which has been factored out from
optee_close_session().

A separate optee_release_supp() is added for the supplicant device.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          | 31 ++++++++++-------
 drivers/tee/optee/core.c          | 55 +++++++++++--------------------
 drivers/tee/optee/optee_private.h |  1 +
 3 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 6132cc8d014c..20092cf95c31 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -286,12 +286,28 @@ int optee_open_session(struct tee_context *ctx,
 	return rc;
 }
=20
-int optee_close_session(struct tee_context *ctx, u32 session)
+int optee_close_session_helper(struct tee_context *ctx, u32 session)
 {
-	struct optee_context_data *ctxdata =3D ctx->data;
 	struct tee_shm *shm;
 	struct optee_msg_arg *msg_arg;
 	phys_addr_t msg_parg;
+
+	shm =3D get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
+	if (IS_ERR(shm))
+		return PTR_ERR(shm);
+
+	msg_arg->cmd =3D OPTEE_MSG_CMD_CLOSE_SESSION;
+	msg_arg->session =3D session;
+	optee_do_call_with_arg(ctx, msg_parg);
+
+	tee_shm_free(shm);
+
+	return 0;
+}
+
+int optee_close_session(struct tee_context *ctx, u32 session)
+{
+	struct optee_context_data *ctxdata =3D ctx->data;
 	struct optee_session *sess;
=20
 	/* Check that the session is valid and remove it from the list */
@@ -304,16 +320,7 @@ int optee_close_session(struct tee_context *ctx, u32 ses=
sion)
 		return -EINVAL;
 	kfree(sess);
=20
-	shm =3D get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
-
-	msg_arg->cmd =3D OPTEE_MSG_CMD_CLOSE_SESSION;
-	msg_arg->session =3D session;
-	optee_do_call_with_arg(ctx, msg_parg);
-
-	tee_shm_free(shm);
-	return 0;
+	return optee_close_session_helper(ctx, session);
 }
=20
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *=
arg,
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index ddb8f9ecf307..949223b214c3 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -263,59 +263,42 @@ static int optee_open(struct tee_context *ctx)
 	return 0;
 }
=20
-static void optee_release(struct tee_context *ctx)
+static void optee_release_helper(struct tee_context *ctx,
+				 int (*close_session)(struct tee_context *ctx,
+						      u32 session))
 {
 	struct optee_context_data *ctxdata =3D ctx->data;
-	struct tee_device *teedev =3D ctx->teedev;
-	struct optee *optee =3D tee_get_drvdata(teedev);
-	struct tee_shm *shm;
-	struct optee_msg_arg *arg =3D NULL;
-	phys_addr_t parg;
 	struct optee_session *sess;
 	struct optee_session *sess_tmp;
=20
 	if (!ctxdata)
 		return;
=20
-	shm =3D tee_shm_alloc(ctx, sizeof(struct optee_msg_arg), TEE_SHM_MAPPED);
-	if (!IS_ERR(shm)) {
-		arg =3D tee_shm_get_va(shm, 0);
-		/*
-		 * If va2pa fails for some reason, we can't call into
-		 * secure world, only free the memory. Secure OS will leak
-		 * sessions and finally refuse more sessions, but we will
-		 * at least let normal world reclaim its memory.
-		 */
-		if (!IS_ERR(arg))
-			if (tee_shm_va2pa(shm, arg, &parg))
-				arg =3D NULL; /* prevent usage of parg below */
-	}
-
 	list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list,
 				 list_node) {
 		list_del(&sess->list_node);
-		if (!IS_ERR_OR_NULL(arg)) {
-			memset(arg, 0, sizeof(*arg));
-			arg->cmd =3D OPTEE_MSG_CMD_CLOSE_SESSION;
-			arg->session =3D sess->session_id;
-			optee_do_call_with_arg(ctx, parg);
-		}
+		close_session(ctx, sess->session_id);
 		kfree(sess);
 	}
 	kfree(ctxdata);
+	ctx->data =3D NULL;
+}
=20
-	if (!IS_ERR(shm))
-		tee_shm_free(shm);
+static void optee_release(struct tee_context *ctx)
+{
+	optee_release_helper(ctx, optee_close_session_helper);
+}
=20
-	ctx->data =3D NULL;
+static void optee_release_supp(struct tee_context *ctx)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
=20
-	if (teedev =3D=3D optee->supp_teedev) {
-		if (optee->scan_bus_wq) {
-			destroy_workqueue(optee->scan_bus_wq);
-			optee->scan_bus_wq =3D NULL;
-		}
-		optee_supp_release(&optee->supp);
+	optee_release_helper(ctx, optee_close_session_helper);
+	if (optee->scan_bus_wq) {
+		destroy_workqueue(optee->scan_bus_wq);
+		optee->scan_bus_wq =3D NULL;
 	}
+	optee_supp_release(&optee->supp);
 }
=20
 static const struct tee_driver_ops optee_ops =3D {
@@ -339,7 +322,7 @@ static const struct tee_desc optee_desc =3D {
 static const struct tee_driver_ops optee_supp_ops =3D {
 	.get_version =3D optee_get_version,
 	.open =3D optee_open,
-	.release =3D optee_release,
+	.release =3D optee_release_supp,
 	.supp_recv =3D optee_supp_recv,
 	.supp_send =3D optee_supp_send,
 	.shm_register =3D optee_shm_register_supp,
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index e25b216a14ef..2b63b796645e 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -152,6 +152,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_=
addr_t parg);
 int optee_open_session(struct tee_context *ctx,
 		       struct tee_ioctl_open_session_arg *arg,
 		       struct tee_param *param);
+int optee_close_session_helper(struct tee_context *ctx, u32 session);
 int optee_close_session(struct tee_context *ctx, u32 session);
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *=
arg,
 		      struct tee_param *param);
--=20
2.25.1


--===============3145445251876032237==--

