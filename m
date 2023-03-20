From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v5 1/4] tee: optee: system call property
Date: Mon, 20 Mar 2023 17:27:58 +0100
Message-ID: <20230320162801.2811542-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8766800772465367824=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8766800772465367824==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds an argument to do_call_with_arg() handler to tell whether the call
is a system call or nor. This change always sets this info to false
hence no functional change.

This change prepares management of system invocation proposed in a later
change.

Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v4:
- New change, extracted from PATCH v4 1/2 (tee: system invocation") and
  revised to cover preparatory changes in optee driver for system session
  support with contribution from Jens.
---
 drivers/tee/optee/call.c          | 22 ++++++++++++++++------
 drivers/tee/optee/core.c          |  5 +++--
 drivers/tee/optee/ffa_abi.c       |  3 ++-
 drivers/tee/optee/optee_private.h |  7 +++++--
 drivers/tee/optee/smc_abi.c       |  9 +++++----
 5 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 290b1bb0e9cd..844d2bdc68db 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -328,7 +328,8 @@ int optee_open_session(struct tee_context *ctx,
 		goto out;
 	}
=20
-	if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
+	if (optee->ops->do_call_with_arg(ctx, shm, offs,
+					 sess->use_sys_thread)) {
 		msg_arg->ret =3D TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 	}
@@ -360,7 +361,8 @@ int optee_open_session(struct tee_context *ctx,
 	return rc;
 }
=20
-int optee_close_session_helper(struct tee_context *ctx, u32 session)
+int optee_close_session_helper(struct tee_context *ctx, u32 session,
+			       bool system_thread)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_shm_arg_entry *entry;
@@ -374,7 +376,7 @@ int optee_close_session_helper(struct tee_context *ctx, u=
32 session)
=20
 	msg_arg->cmd =3D OPTEE_MSG_CMD_CLOSE_SESSION;
 	msg_arg->session =3D session;
-	optee->ops->do_call_with_arg(ctx, shm, offs);
+	optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
=20
 	optee_free_msg_arg(ctx, entry, offs);
=20
@@ -385,6 +387,7 @@ int optee_close_session(struct tee_context *ctx, u32 sess=
ion)
 {
 	struct optee_context_data *ctxdata =3D ctx->data;
 	struct optee_session *sess;
+	bool system_thread;
=20
 	/* Check that the session is valid and remove it from the list */
 	mutex_lock(&ctxdata->mutex);
@@ -394,9 +397,10 @@ int optee_close_session(struct tee_context *ctx, u32 ses=
sion)
 	mutex_unlock(&ctxdata->mutex);
 	if (!sess)
 		return -EINVAL;
+	system_thread =3D sess->use_sys_thread;
 	kfree(sess);
=20
-	return optee_close_session_helper(ctx, session);
+	return optee_close_session_helper(ctx, session, system_thread);
 }
=20
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *=
arg,
@@ -408,12 +412,15 @@ int optee_invoke_func(struct tee_context *ctx, struct t=
ee_ioctl_invoke_arg *arg,
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess;
 	struct tee_shm *shm;
+	bool system_thread;
 	u_int offs;
 	int rc;
=20
 	/* Check that the session is valid */
 	mutex_lock(&ctxdata->mutex);
 	sess =3D find_session(ctxdata, arg->session);
+	if (sess)
+		system_thread =3D sess->use_sys_thread;
 	mutex_unlock(&ctxdata->mutex);
 	if (!sess)
 		return -EINVAL;
@@ -432,7 +439,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee=
_ioctl_invoke_arg *arg,
 	if (rc)
 		goto out;
=20
-	if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
+	if (optee->ops->do_call_with_arg(ctx, shm, offs, system_thread)) {
 		msg_arg->ret =3D TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 	}
@@ -457,12 +464,15 @@ int optee_cancel_req(struct tee_context *ctx, u32 cance=
l_id, u32 session)
 	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess;
+	bool system_thread;
 	struct tee_shm *shm;
 	u_int offs;
=20
 	/* Check that the session is valid */
 	mutex_lock(&ctxdata->mutex);
 	sess =3D find_session(ctxdata, session);
+	if (sess)
+		system_thread =3D sess->use_sys_thread;
 	mutex_unlock(&ctxdata->mutex);
 	if (!sess)
 		return -EINVAL;
@@ -474,7 +484,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_=
id, u32 session)
 	msg_arg->cmd =3D OPTEE_MSG_CMD_CANCEL;
 	msg_arg->session =3D session;
 	msg_arg->cancel_id =3D cancel_id;
-	optee->ops->do_call_with_arg(ctx, shm, offs);
+	optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
=20
 	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a258bd3b6b5..d01ca47f7bde 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -129,7 +129,8 @@ int optee_open(struct tee_context *ctx, bool cap_memref_n=
ull)
=20
 static void optee_release_helper(struct tee_context *ctx,
 				 int (*close_session)(struct tee_context *ctx,
-						      u32 session))
+						      u32 session,
+						      bool system_thread))
 {
 	struct optee_context_data *ctxdata =3D ctx->data;
 	struct optee_session *sess;
@@ -141,7 +142,7 @@ static void optee_release_helper(struct tee_context *ctx,
 	list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list,
 				 list_node) {
 		list_del(&sess->list_node);
-		close_session(ctx, sess->session_id);
+		close_session(ctx, sess->session_id, sess->use_sys_thread);
 		kfree(sess);
 	}
 	kfree(ctxdata);
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 0828240f27e6..52cec9d06041 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -612,7 +612,8 @@ static int optee_ffa_yielding_call(struct tee_context *ct=
x,
  */
=20
 static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm, u_int offs)
+				      struct tee_shm *shm, u_int offs,
+				      bool system_thread)
 {
 	struct ffa_send_direct_data data =3D {
 		.data0 =3D OPTEE_FFA_YIELDING_CALL_WITH_ARG,
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 04ae58892608..bdbc0dc293bb 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -130,7 +130,8 @@ struct optee;
  */
 struct optee_ops {
 	int (*do_call_with_arg)(struct tee_context *ctx,
-				struct tee_shm *shm_arg, u_int offs);
+				struct tee_shm *shm_arg, u_int offs,
+				bool system_thread);
 	int (*to_msg_param)(struct optee *optee,
 			    struct optee_msg_param *msg_params,
 			    size_t num_params, const struct tee_param *params);
@@ -180,6 +181,7 @@ struct optee {
 struct optee_session {
 	struct list_head list_node;
 	u32 session_id;
+	bool use_sys_thread;
 };
=20
 struct optee_context_data {
@@ -228,7 +230,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32=
 num_params,
 int optee_open_session(struct tee_context *ctx,
 		       struct tee_ioctl_open_session_arg *arg,
 		       struct tee_param *param);
-int optee_close_session_helper(struct tee_context *ctx, u32 session);
+int optee_close_session_helper(struct tee_context *ctx, u32 session,
+			       bool system_thread);
 int optee_close_session(struct tee_context *ctx, u32 session);
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *=
arg,
 		      struct tee_param *param);
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..df77700804e5 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -487,7 +487,7 @@ static int optee_shm_register(struct tee_context *ctx, st=
ruct tee_shm *shm,
 	msg_arg->params->u.tmem.buf_ptr =3D virt_to_phys(pages_list) |
 	  (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
=20
-	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
 	    msg_arg->ret !=3D TEEC_SUCCESS)
 		rc =3D -EINVAL;
=20
@@ -530,7 +530,7 @@ static int optee_shm_unregister(struct tee_context *ctx, =
struct tee_shm *shm)
 	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
 	msg_arg->params[0].u.rmem.shm_ref =3D (unsigned long)shm;
=20
-	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
 	    msg_arg->ret !=3D TEEC_SUCCESS)
 		rc =3D -EINVAL;
 out:
@@ -865,7 +865,8 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * Returns return code from secure world, 0 is OK
  */
 static int optee_smc_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm, u_int offs)
+				      struct tee_shm *shm, u_int offs,
+				      bool system_thread)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
@@ -957,7 +958,7 @@ static int simple_call_with_arg(struct tee_context *ctx, =
u32 cmd)
 		return PTR_ERR(msg_arg);
=20
 	msg_arg->cmd =3D cmd;
-	optee_smc_do_call_with_arg(ctx, shm, offs);
+	optee_smc_do_call_with_arg(ctx, shm, offs, false);
=20
 	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
--=20
2.25.1


--===============8766800772465367824==--

