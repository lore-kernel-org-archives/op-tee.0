From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v5 2/5] optee: simplify optee_release()
Date: Tue, 31 Aug 2021 09:24:09 +0200
Message-ID: <20210831072412.887565-3-jens.wiklander@linaro.org>
In-Reply-To: <20210831072412.887565-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2262518708374114611=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2262518708374114611==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Simplifies optee_release() with a new helper function,
optee_close_session_helper() which has been factored out from
optee_close_session().

A separate optee_release_supp() is added for the supplicant device.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          | 31 ++++++++++-------
 drivers/tee/optee/core.c          | 56 +++++++++++--------------------
 drivers/tee/optee/optee_private.h |  1 +
 3 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 945f03da0223..103976df2062 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -288,12 +288,28 @@ int optee_open_session(struct tee_context *ctx,
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
@@ -306,16 +322,7 @@ int optee_close_session(struct tee_context *ctx, u32 ses=
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
index 5ce13b099d7d..86a1ae8d296d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -264,60 +264,42 @@ static int optee_open(struct tee_context *ctx)
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
-	shm =3D tee_shm_alloc(ctx, sizeof(struct optee_msg_arg),
-			    TEE_SHM_MAPPED | TEE_SHM_PRIV);
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
@@ -341,7 +323,7 @@ static const struct tee_desc optee_desc =3D {
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
index dbdd367be156..d9f5f3f7ba58 100644
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
2.31.1


--===============2262518708374114611==--

