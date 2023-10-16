From: Etienne Carriere <etienne.carriere@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v11 1/4] tee: optee: system call property
Date: Mon, 16 Oct 2023 11:04:25 +0200
Message-ID: <20231016090428.1369071-2-etienne.carriere@foss.st.com>
In-Reply-To: <20231016090428.1369071-1-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8721954252031323813=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8721954252031323813==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds an argument to do_call_with_arg() handler to tell whether the call
is a system call or nor. This change always sets this info to false
hence no functional change.

This change prepares management of system invocation proposed in a later
change.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
No change since v10

Changes since v9:
- Applied Sumit R-b tag:
  https://lore.kernel.org/lkml/CAFA6WYMwWFRUo719wHHsjaAUOSdo4cMa8gdHBMWidP4vC=
4z31g(a)mail.gmail.com/
- Updated my e-mail address.

No change since v8
No change since v7

Changes since v6:
- Squashed a part of patch v6 3/4 changes into this patch v7 1/4
  related to adding boolean system thread attribute into optee
  driver call queue and SMC/FF-A ABIs API functions.
- Removed local variable sys_thread set to constant false value
  and use false straight as function argument instead.
- Comment on struct optee_session::use_sys_thread being read with
  optee mutex locked is not addressed as still under discussion.

No changes since v5

Changes since v4:
- New change, extracted from PATCH v4 1/2 (tee: system invocation") and
  revised to cover preparatory changes in optee driver for system session
  support with contribution from Jens.
---
 drivers/tee/optee/call.c          | 24 +++++++++++++++++-------
 drivers/tee/optee/core.c          |  5 +++--
 drivers/tee/optee/ffa_abi.c       | 10 ++++++----
 drivers/tee/optee/optee_private.h |  9 ++++++---
 drivers/tee/optee/smc_abi.c       | 15 ++++++++-------
 5 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index df5fb5410b72..152ae9bb1785 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -40,7 +40,7 @@ struct optee_shm_arg_entry {
 };
=20
 void optee_cq_wait_init(struct optee_call_queue *cq,
-			struct optee_call_waiter *w)
+			struct optee_call_waiter *w, bool sys_thread)
 {
 	/*
 	 * We're preparing to make a call to secure world. In case we can't
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
index 0828240f27e6..5fde9d4100e3 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -528,7 +528,8 @@ static void optee_handle_ffa_rpc(struct tee_context *ctx,=
 struct optee *optee,
=20
 static int optee_ffa_yielding_call(struct tee_context *ctx,
 				   struct ffa_send_direct_data *data,
-				   struct optee_msg_arg *rpc_arg)
+				   struct optee_msg_arg *rpc_arg,
+				   bool system_thread)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
@@ -541,7 +542,7 @@ static int optee_ffa_yielding_call(struct tee_context *ct=
x,
 	int rc;
=20
 	/* Initialize waiter */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, system_thread);
 	while (true) {
 		rc =3D msg_ops->sync_send_receive(ffa_dev, data);
 		if (rc)
@@ -612,7 +613,8 @@ static int optee_ffa_yielding_call(struct tee_context *ct=
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
@@ -642,7 +644,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context =
*ctx,
 	if (IS_ERR(rpc_arg))
 		return PTR_ERR(rpc_arg);
=20
-	return optee_ffa_yielding_call(ctx, &data, rpc_arg);
+	return optee_ffa_yielding_call(ctx, &data, rpc_arg, system_thread);
 }
=20
 /*
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 6bb5cae09688..b659a6f521df 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -154,7 +154,8 @@ struct optee;
  */
 struct optee_ops {
 	int (*do_call_with_arg)(struct tee_context *ctx,
-				struct tee_shm *shm_arg, u_int offs);
+				struct tee_shm *shm_arg, u_int offs,
+				bool system_thread);
 	int (*to_msg_param)(struct optee *optee,
 			    struct optee_msg_param *msg_params,
 			    size_t num_params, const struct tee_param *params);
@@ -204,6 +205,7 @@ struct optee {
 struct optee_session {
 	struct list_head list_node;
 	u32 session_id;
+	bool use_sys_thread;
 };
=20
 struct optee_context_data {
@@ -250,7 +252,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32=
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
@@ -299,7 +302,7 @@ static inline void optee_to_msg_param_value(struct optee_=
msg_param *mp,
 }
=20
 void optee_cq_wait_init(struct optee_call_queue *cq,
-			struct optee_call_waiter *w);
+			struct optee_call_waiter *w, bool sys_thread);
 void optee_cq_wait_for_completion(struct optee_call_queue *cq,
 				  struct optee_call_waiter *w);
 void optee_cq_wait_final(struct optee_call_queue *cq,
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index d5b28fd35d66..1033d7da03ea 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -283,7 +283,7 @@ static void optee_enable_shm_cache(struct optee *optee)
 	struct optee_call_waiter w;
=20
 	/* We need to retry until secure world isn't busy. */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, false);
 	while (true) {
 		struct arm_smccc_res res;
=20
@@ -308,7 +308,7 @@ static void __optee_disable_shm_cache(struct optee *optee=
, bool is_mapped)
 	struct optee_call_waiter w;
=20
 	/* We need to retry until secure world isn't busy. */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, false);
 	while (true) {
 		union {
 			struct arm_smccc_res smccc;
@@ -507,7 +507,7 @@ static int optee_shm_register(struct tee_context *ctx, st=
ruct tee_shm *shm,
 	msg_arg->params->u.tmem.buf_ptr =3D virt_to_phys(pages_list) |
 	  (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
=20
-	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
 	    msg_arg->ret !=3D TEEC_SUCCESS)
 		rc =3D -EINVAL;
=20
@@ -550,7 +550,7 @@ static int optee_shm_unregister(struct tee_context *ctx, =
struct tee_shm *shm)
 	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
 	msg_arg->params[0].u.rmem.shm_ref =3D (unsigned long)shm;
=20
-	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
 	    msg_arg->ret !=3D TEEC_SUCCESS)
 		rc =3D -EINVAL;
 out:
@@ -885,7 +885,8 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * Returns return code from secure world, 0 is OK
  */
 static int optee_smc_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm, u_int offs)
+				      struct tee_shm *shm, u_int offs,
+				      bool system_thread)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
@@ -926,7 +927,7 @@ static int optee_smc_do_call_with_arg(struct tee_context =
*ctx,
 		reg_pair_from_64(&param.a1, &param.a2, parg);
 	}
 	/* Initialize waiter */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, system_thread);
 	while (true) {
 		struct arm_smccc_res res;
=20
@@ -977,7 +978,7 @@ static int simple_call_with_arg(struct tee_context *ctx, =
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


--===============8721954252031323813==--

