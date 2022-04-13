From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 4/4] optee: cache argument shared memory structs
Date: Wed, 13 Apr 2022 07:44:18 +0200
Message-ID: <20220413054418.71996-5-jens.wiklander@linaro.org>
In-Reply-To: <20220413054418.71996-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3898765074775044272=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3898765074775044272==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Implements a cache to handle shared memory used to pass the argument
struct needed when doing a normal yielding call into secure world.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          | 236 ++++++++++++++++++++++++------
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       |  13 +-
 drivers/tee/optee/optee_private.h |  27 +++-
 drivers/tee/optee/smc_abi.c       |  73 +++++++--
 5 files changed, 285 insertions(+), 65 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 58ac15c02818..608d5f4241de 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -11,6 +11,34 @@
 #include <linux/types.h>
 #include "optee_private.h"
=20
+#define MAX_ARG_PARAM_COUNT	6
+
+/*
+ * How much memory we allocate for each entry. This doesn't have to be a
+ * single page, but it makes sense to keep at least keep it as multiples of
+ * the page size.
+ */
+#define SHM_ENTRY_SIZE		PAGE_SIZE
+
+/*
+ * We need to have a compile time constant to be able to determine the
+ * maximum needed size of the bit field.
+ */
+#define MIN_ARG_SIZE		OPTEE_MSG_GET_ARG_SIZE(MAX_ARG_PARAM_COUNT)
+#define MAX_ARG_COUNT_PER_ENTRY	(SHM_ENTRY_SIZE / MIN_ARG_SIZE)
+
+/*
+ * Shared memory for argument structs are cached here. The number of
+ * arguments structs that can fit is determined at runtime depending on the
+ * needed RPC parameter count reported by secure world
+ * (optee->rpc_param_count).
+ */
+struct optee_shm_arg_entry {
+	struct list_head list_node;
+	struct tee_shm *shm;
+	DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
+};
+
 void optee_cq_wait_init(struct optee_call_queue *cq,
 			struct optee_call_waiter *w)
 {
@@ -104,37 +132,149 @@ static struct optee_session *find_session(struct optee=
_context_data *ctxdata,
 	return NULL;
 }
=20
-struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
-				  struct optee_msg_arg **msg_arg)
+void optee_shm_arg_cache_init(struct optee *optee, u32 flags)
+{
+	INIT_LIST_HEAD(&optee->shm_arg_cache.shm_args);
+	mutex_init(&optee->shm_arg_cache.mutex);
+	optee->shm_arg_cache.flags =3D flags;
+}
+
+void optee_shm_arg_cache_uninit(struct optee *optee)
+{
+	struct list_head *head =3D &optee->shm_arg_cache.shm_args;
+	struct optee_shm_arg_entry *entry;
+
+	mutex_destroy(&optee->shm_arg_cache.mutex);
+	while (!list_empty(head)) {
+		entry =3D list_first_entry(head, struct optee_shm_arg_entry,
+					 list_node);
+		list_del(&entry->list_node);
+		if (find_first_bit(entry->map, MAX_ARG_COUNT_PER_ENTRY) !=3D
+		     MAX_ARG_COUNT_PER_ENTRY) {
+			pr_err("Freeing non-free entry\n");
+		}
+		tee_shm_free(entry->shm);
+		kfree(entry);
+	}
+}
+
+size_t optee_msg_arg_size(size_t rpc_param_count)
+{
+	size_t sz =3D OPTEE_MSG_GET_ARG_SIZE(MAX_ARG_PARAM_COUNT);
+
+	if (rpc_param_count)
+		sz +=3D OPTEE_MSG_GET_ARG_SIZE(rpc_param_count);
+
+	return sz;
+}
+
+/**
+ * optee_get_msg_arg() - Provide shared memory for argument struct
+ * @ctx:	Caller TEE context
+ * @num_params:	Number of parameter to store
+ * @entry_ret:	Entry pointer, needed when freeing the buffer
+ * @shm_ret:	Shared memory buffer
+ * @offs_ret:	Offset of argument strut in shared memory buffer
+ *
+ * @returns a pointer to the argument struct in memory, else an ERR_PTR
+ */
+struct optee_msg_arg *optee_get_msg_arg(struct tee_context *ctx,
+					size_t num_params,
+					struct optee_shm_arg_entry **entry_ret,
+					struct tee_shm **shm_ret,
+					u_int *offs_ret)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-	size_t sz =3D OPTEE_MSG_GET_ARG_SIZE(num_params);
-	struct tee_shm *shm;
+	size_t sz =3D optee_msg_arg_size(optee->rpc_param_count);
+	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *ma;
+	size_t args_per_entry;
+	u_long bit;
+	u_int offs;
+	void *res;
+
+	if (num_params > MAX_ARG_PARAM_COUNT)
+		return ERR_PTR(-EINVAL);
+
+	if (optee->shm_arg_cache.flags & OPTEE_SHM_ARG_SHARED)
+		args_per_entry =3D SHM_ENTRY_SIZE / sz;
+	else
+		args_per_entry =3D 1;
+
+	mutex_lock(&optee->shm_arg_cache.mutex);
+	list_for_each_entry(entry, &optee->shm_arg_cache.shm_args, list_node) {
+		bit =3D find_first_zero_bit(entry->map, MAX_ARG_COUNT_PER_ENTRY);
+		if (bit < args_per_entry)
+			goto have_entry;
+	}
=20
 	/*
-	 * rpc_param_count is set to the number of allocated parameters in
-	 * the RPC argument struct if a second MSG arg struct is expected.
-	 * The second arg struct will then be used for RPC.
+	 * No entry was found, let's allocate a new.
 	 */
-	if (optee->rpc_param_count)
-		sz +=3D OPTEE_MSG_GET_ARG_SIZE(optee->rpc_param_count);
+	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		res =3D ERR_PTR(-ENOMEM);
+		goto out;
+	}
=20
-	shm =3D tee_shm_alloc_priv_buf(ctx, sz);
-	if (IS_ERR(shm))
-		return shm;
+	if (optee->shm_arg_cache.flags & OPTEE_SHM_ARG_ALLOC_PRIV)
+		res =3D tee_shm_alloc_priv_buf(ctx, SHM_ENTRY_SIZE);
+	else
+		res =3D tee_shm_alloc_kernel_buf(ctx, SHM_ENTRY_SIZE);
=20
-	ma =3D tee_shm_get_va(shm, 0);
-	if (IS_ERR(ma)) {
-		tee_shm_free(shm);
-		return (void *)ma;
+	if (IS_ERR(res)) {
+		kfree(entry);
+		goto out;
 	}
-
+	entry->shm =3D res;
+	list_add(&entry->list_node, &optee->shm_arg_cache.shm_args);
+	bit =3D 0;
+
+have_entry:
+	offs =3D bit * sz;
+	res =3D tee_shm_get_va(entry->shm, offs);
+	if (IS_ERR(res))
+		goto out;
+	ma =3D res;
+	set_bit(bit, entry->map);
 	memset(ma, 0, sz);
 	ma->num_params =3D num_params;
-	*msg_arg =3D ma;
+	*entry_ret =3D entry;
+	*shm_ret =3D entry->shm;
+	*offs_ret =3D offs;
+out:
+	mutex_unlock(&optee->shm_arg_cache.mutex);
+	return res;
+}
+
+/**
+ * optee_free_msg_arg() - Free previsouly obtained shared memory
+ * @ctx:	Caller TEE context
+ * @entry:	Pointer returned when the shared memory was obtained
+ * @offs:	Offset of shared memory buffer to free
+ *
+ * This function frees the shared memory obtained with optee_get_msg_arg().
+ */
+void optee_free_msg_arg(struct tee_context *ctx,
+			struct optee_shm_arg_entry *entry, u_int offs)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	size_t sz =3D optee_msg_arg_size(optee->rpc_param_count);
+	u_long bit;
=20
-	return shm;
+	if (offs > SHM_ENTRY_SIZE || offs % sz) {
+		pr_err("Invalid offs %u\n", offs);
+		return;
+	}
+	bit =3D offs / sz;
+
+	mutex_lock(&optee->shm_arg_cache.mutex);
+
+	if (!test_bit(bit, entry->map))
+		pr_err("Bit pos %lu is already free\n", bit);
+	clear_bit(bit, entry->map);
+
+	mutex_unlock(&optee->shm_arg_cache.mutex);
 }
=20
 int optee_open_session(struct tee_context *ctx,
@@ -143,16 +283,19 @@ int optee_open_session(struct tee_context *ctx,
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_context_data *ctxdata =3D ctx->data;
-	int rc;
+	struct optee_shm_arg_entry *entry;
 	struct tee_shm *shm;
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess =3D NULL;
 	uuid_t client_uuid;
+	u_int offs;
+	int rc;
=20
 	/* +2 for the meta parameters added below */
-	shm =3D optee_get_msg_arg(ctx, arg->num_params + 2, &msg_arg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
+	msg_arg =3D optee_get_msg_arg(ctx, arg->num_params + 2,
+				    &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
=20
 	msg_arg->cmd =3D OPTEE_MSG_CMD_OPEN_SESSION;
 	msg_arg->cancel_id =3D arg->cancel_id;
@@ -185,7 +328,7 @@ int optee_open_session(struct tee_context *ctx,
 		goto out;
 	}
=20
-	if (optee->ops->do_call_with_arg(ctx, shm)) {
+	if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
 		msg_arg->ret =3D TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 	}
@@ -212,26 +355,28 @@ int optee_open_session(struct tee_context *ctx,
 		arg->ret_origin =3D msg_arg->ret_origin;
 	}
 out:
-	tee_shm_free(shm);
+	optee_free_msg_arg(ctx, entry, offs);
=20
 	return rc;
 }
=20
 int optee_close_session_helper(struct tee_context *ctx, u32 session)
 {
-	struct tee_shm *shm;
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
=20
-	shm =3D optee_get_msg_arg(ctx, 0, &msg_arg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
+	msg_arg =3D optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
=20
 	msg_arg->cmd =3D OPTEE_MSG_CMD_CLOSE_SESSION;
 	msg_arg->session =3D session;
-	optee->ops->do_call_with_arg(ctx, shm);
+	optee->ops->do_call_with_arg(ctx, shm, offs);
=20
-	tee_shm_free(shm);
+	optee_free_msg_arg(ctx, entry, offs);
=20
 	return 0;
 }
@@ -259,9 +404,11 @@ int optee_invoke_func(struct tee_context *ctx, struct te=
e_ioctl_invoke_arg *arg,
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_context_data *ctxdata =3D ctx->data;
-	struct tee_shm *shm;
+	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess;
+	struct tee_shm *shm;
+	u_int offs;
 	int rc;
=20
 	/* Check that the session is valid */
@@ -271,9 +418,10 @@ int optee_invoke_func(struct tee_context *ctx, struct te=
e_ioctl_invoke_arg *arg,
 	if (!sess)
 		return -EINVAL;
=20
-	shm =3D optee_get_msg_arg(ctx, arg->num_params, &msg_arg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
+	msg_arg =3D optee_get_msg_arg(ctx, arg->num_params,
+				    &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
 	msg_arg->cmd =3D OPTEE_MSG_CMD_INVOKE_COMMAND;
 	msg_arg->func =3D arg->func;
 	msg_arg->session =3D arg->session;
@@ -284,7 +432,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee=
_ioctl_invoke_arg *arg,
 	if (rc)
 		goto out;
=20
-	if (optee->ops->do_call_with_arg(ctx, shm)) {
+	if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
 		msg_arg->ret =3D TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 	}
@@ -298,7 +446,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee=
_ioctl_invoke_arg *arg,
 	arg->ret =3D msg_arg->ret;
 	arg->ret_origin =3D msg_arg->ret_origin;
 out:
-	tee_shm_free(shm);
+	optee_free_msg_arg(ctx, entry, offs);
 	return rc;
 }
=20
@@ -306,9 +454,11 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel=
_id, u32 session)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_context_data *ctxdata =3D ctx->data;
-	struct tee_shm *shm;
+	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess;
+	struct tee_shm *shm;
+	u_int offs;
=20
 	/* Check that the session is valid */
 	mutex_lock(&ctxdata->mutex);
@@ -317,16 +467,16 @@ int optee_cancel_req(struct tee_context *ctx, u32 cance=
l_id, u32 session)
 	if (!sess)
 		return -EINVAL;
=20
-	shm =3D optee_get_msg_arg(ctx, 0, &msg_arg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
+	msg_arg =3D optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
=20
 	msg_arg->cmd =3D OPTEE_MSG_CMD_CANCEL;
 	msg_arg->session =3D session;
 	msg_arg->cancel_id =3D cancel_id;
-	optee->ops->do_call_with_arg(ctx, shm);
+	optee->ops->do_call_with_arg(ctx, shm, offs);
=20
-	tee_shm_free(shm);
+	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
 }
=20
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index daf947e98d14..daf07737c4fd 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -171,6 +171,7 @@ void optee_remove_common(struct optee *optee)
 	optee_unregister_devices();
=20
 	optee_notif_uninit(optee);
+	optee_shm_arg_cache_uninit(optee);
 	teedev_close_context(optee->ctx);
 	/*
 	 * The two devices have to be unregistered before we can free the
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index cc863aaefcd9..1552cd3f9d4e 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -601,6 +601,7 @@ static int optee_ffa_yielding_call(struct tee_context *ct=
x,
  * optee_ffa_do_call_with_arg() - Do a FF-A call to enter OP-TEE in secure w=
orld
  * @ctx:	calling context
  * @shm:	shared memory holding the message to pass to secure world
+ * @offs:	offset of the message in @shm
  *
  * Does a FF-A call to OP-TEE in secure world and handles eventual resulting
  * Remote Procedure Calls (RPC) from OP-TEE.
@@ -609,13 +610,13 @@ static int optee_ffa_yielding_call(struct tee_context *=
ctx,
  */
=20
 static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm)
+				      struct tee_shm *shm, u_int offs)
 {
 	struct ffa_send_direct_data data =3D {
 		.data0 =3D OPTEE_FFA_YIELDING_CALL_WITH_ARG,
 		.data1 =3D (u32)shm->sec_world_id,
 		.data2 =3D (u32)(shm->sec_world_id >> 32),
-		.data3 =3D 0,
+		.data3 =3D offs,
 	};
 	struct optee_msg_arg *arg;
 	unsigned int rpc_arg_offs;
@@ -630,12 +631,12 @@ static int optee_ffa_do_call_with_arg(struct tee_contex=
t *ctx,
 	if (shm->offset)
 		return -EINVAL;
=20
-	arg =3D tee_shm_get_va(shm, 0);
+	arg =3D tee_shm_get_va(shm, offs);
 	if (IS_ERR(arg))
 		return PTR_ERR(arg);
=20
 	rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
-	rpc_arg =3D tee_shm_get_va(shm, rpc_arg_offs);
+	rpc_arg =3D tee_shm_get_va(shm, offs + rpc_arg_offs);
 	if (IS_ERR(rpc_arg))
 		return PTR_ERR(rpc_arg);
=20
@@ -787,6 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	struct tee_shm_pool *pool;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
+	u32 arg_cache_flags =3D 0;
 	struct optee *optee;
 	u32 sec_caps;
 	int rc;
@@ -803,6 +805,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
 				     &rpc_param_count))
 		return -EINVAL;
+	if (sec_caps & OPTEE_FFA_SEC_CAP_ARG_OFFSET)
+		arg_cache_flags |=3D OPTEE_SHM_ARG_SHARED;
=20
 	optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee)
@@ -851,6 +855,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	mutex_init(&optee->call_queue.mutex);
 	INIT_LIST_HEAD(&optee->call_queue.waiters);
 	optee_supp_init(&optee->supp);
+	optee_shm_arg_cache_init(optee, arg_cache_flags);
 	ffa_dev_set_drvdata(ffa_dev, optee);
 	ctx =3D teedev_open(optee->teedev);
 	if (IS_ERR(ctx)) {
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index e80c5d9b62ec..a33d98d17cfd 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -59,6 +59,16 @@ struct optee_notif {
 	u_long *bitmap;
 };
=20
+#define OPTEE_SHM_ARG_ALLOC_PRIV	BIT(0)
+#define OPTEE_SHM_ARG_SHARED		BIT(1)
+struct optee_shm_arg_entry;
+struct optee_shm_arg_cache {
+	u32 flags;
+	/* Serializes access to this struct */
+	struct mutex mutex;
+	struct list_head shm_args;
+};
+
 /**
  * struct optee_supp - supplicant synchronization struct
  * @ctx			the context of current connected supplicant.
@@ -121,7 +131,7 @@ struct optee;
  */
 struct optee_ops {
 	int (*do_call_with_arg)(struct tee_context *ctx,
-				struct tee_shm *shm_arg);
+				struct tee_shm *shm_arg, u_int offs);
 	int (*to_msg_param)(struct optee *optee,
 			    struct optee_msg_param *msg_params,
 			    size_t num_params, const struct tee_param *params);
@@ -157,6 +167,7 @@ struct optee {
 		struct optee_smc smc;
 		struct optee_ffa ffa;
 	};
+	struct optee_shm_arg_cache shm_arg_cache;
 	struct optee_call_queue call_queue;
 	struct optee_notif notif;
 	struct optee_supp supp;
@@ -273,8 +284,18 @@ void optee_cq_wait_for_completion(struct optee_call_queu=
e *cq,
 void optee_cq_wait_final(struct optee_call_queue *cq,
 			 struct optee_call_waiter *w);
 int optee_check_mem_type(unsigned long start, size_t num_pages);
-struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
-				  struct optee_msg_arg **msg_arg);
+
+void optee_shm_arg_cache_init(struct optee *optee, u32 flags);
+void optee_shm_arg_cache_uninit(struct optee *optee);
+struct optee_msg_arg *optee_get_msg_arg(struct tee_context *ctx,
+					size_t num_params,
+					struct optee_shm_arg_entry **entry,
+					struct tee_shm **shm_ret,
+					u_int *offs);
+void optee_free_msg_arg(struct tee_context *ctx,
+			struct optee_shm_arg_entry *entry, u_int offs);
+size_t optee_msg_arg_size(size_t rpc_param_count);
+
=20
 struct tee_shm *optee_rpc_cmd_alloc_suppl(struct tee_context *ctx, size_t sz=
);
 void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm);
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index b258d7306042..fc6fb802b9bf 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -437,6 +437,7 @@ static int optee_shm_register(struct tee_context *ctx, st=
ruct tee_shm *shm,
 	struct optee_msg_arg *msg_arg;
 	struct tee_shm *shm_arg;
 	u64 *pages_list;
+	size_t sz;
 	int rc;
=20
 	if (!num_pages)
@@ -450,15 +451,30 @@ static int optee_shm_register(struct tee_context *ctx, =
struct tee_shm *shm,
 	if (!pages_list)
 		return -ENOMEM;
=20
-	shm_arg =3D optee_get_msg_arg(ctx, 1, &msg_arg);
+	/*
+	 * We're about to register shared memory we can't register shared
+	 * memory for this request or there's a catch-22.
+	 *
+	 * So in this we'll have to do the good old temporary private
+	 * allocation instead of using optee_get_msg_arg().
+	 */
+	sz =3D optee_msg_arg_size(optee->rpc_param_count);
+	shm_arg =3D tee_shm_alloc_priv_buf(ctx, sz);
 	if (IS_ERR(shm_arg)) {
 		rc =3D PTR_ERR(shm_arg);
 		goto out;
 	}
+	msg_arg =3D tee_shm_get_va(shm_arg, 0);
+	if (IS_ERR(msg_arg)) {
+		rc =3D PTR_ERR(msg_arg);
+		goto out;
+	}
=20
 	optee_fill_pages_list(pages_list, pages, num_pages,
 			      tee_shm_get_page_offset(shm));
=20
+	memset(msg_arg, 0, OPTEE_MSG_GET_ARG_SIZE(1));
+	msg_arg->num_params =3D 1;
 	msg_arg->cmd =3D OPTEE_MSG_CMD_REGISTER_SHM;
 	msg_arg->params->attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
 				OPTEE_MSG_ATTR_NONCONTIG;
@@ -471,7 +487,7 @@ static int optee_shm_register(struct tee_context *ctx, st=
ruct tee_shm *shm,
 	msg_arg->params->u.tmem.buf_ptr =3D virt_to_phys(pages_list) |
 	  (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
=20
-	if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
 	    msg_arg->ret !=3D TEEC_SUCCESS)
 		rc =3D -EINVAL;
=20
@@ -487,19 +503,37 @@ static int optee_shm_unregister(struct tee_context *ctx=
, struct tee_shm *shm)
 	struct optee_msg_arg *msg_arg;
 	struct tee_shm *shm_arg;
 	int rc =3D 0;
+	size_t sz;
=20
-	shm_arg =3D optee_get_msg_arg(ctx, 1, &msg_arg);
+	/*
+	 * We're about to unregister shared memory and we may not be able
+	 * register shared memory for this request in case we're called
+	 * from optee_shm_arg_cache_uninit().
+	 *
+	 * So in order to keep things simple in this function just as in
+	 * optee_shm_register() we'll use temporary private allocation
+	 * instead of using optee_get_msg_arg().
+	 */
+	sz =3D optee_msg_arg_size(optee->rpc_param_count);
+	shm_arg =3D tee_shm_alloc_priv_buf(ctx, sz);
 	if (IS_ERR(shm_arg))
 		return PTR_ERR(shm_arg);
+	msg_arg =3D tee_shm_get_va(shm_arg, 0);
+	if (IS_ERR(msg_arg)) {
+		rc =3D PTR_ERR(msg_arg);
+		goto out;
+	}
=20
+	memset(msg_arg, 0, sz);
+	msg_arg->num_params =3D 1;
 	msg_arg->cmd =3D OPTEE_MSG_CMD_UNREGISTER_SHM;
-
 	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
 	msg_arg->params[0].u.rmem.shm_ref =3D (unsigned long)shm;
=20
-	if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
 	    msg_arg->ret !=3D TEEC_SUCCESS)
 		rc =3D -EINVAL;
+out:
 	tee_shm_free(shm_arg);
 	return rc;
 }
@@ -823,6 +857,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * optee_smc_do_call_with_arg() - Do an SMC to OP-TEE in secure world
  * @ctx:	calling context
  * @shm:	shared memory holding the message to pass to secure world
+ * @offs:	offset of the message in @shm
  *
  * Does and SMC to OP-TEE in secure world and handles eventual resulting
  * Remote Procedure Calls (RPC) from OP-TEE.
@@ -830,7 +865,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * Returns return code from secure world, 0 is OK
  */
 static int optee_smc_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm)
+				      struct tee_shm *shm, u_int offs)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
@@ -843,12 +878,12 @@ static int optee_smc_do_call_with_arg(struct tee_contex=
t *ctx,
 		struct optee_msg_arg *arg;
 		unsigned int rpc_arg_offs;
=20
-		arg =3D tee_shm_get_va(shm, 0);
+		arg =3D tee_shm_get_va(shm, offs);
 		if (IS_ERR(arg))
 			return PTR_ERR(arg);
=20
 		rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
-		rpc_arg =3D tee_shm_get_va(shm, rpc_arg_offs);
+		rpc_arg =3D tee_shm_get_va(shm, offs + rpc_arg_offs);
 		if (IS_ERR(arg))
 			return PTR_ERR(arg);
 	}
@@ -856,11 +891,11 @@ static int optee_smc_do_call_with_arg(struct tee_contex=
t *ctx,
 	if  (rpc_arg && tee_shm_is_dynamic(shm)) {
 		param.a0 =3D OPTEE_SMC_CALL_WITH_REGD_ARG;
 		reg_pair_from_64(&param.a1, &param.a2, (u_long)shm);
-		param.a3 =3D 0;
+		param.a3 =3D offs;
 	} else {
 		phys_addr_t parg;
=20
-		rc =3D tee_shm_get_pa(shm, 0, &parg);
+		rc =3D tee_shm_get_pa(shm, offs, &parg);
 		if (rc)
 			return rc;
=20
@@ -912,17 +947,19 @@ static int optee_smc_do_call_with_arg(struct tee_contex=
t *ctx,
=20
 static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
 {
+	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
 	struct tee_shm *shm;
+	u_int offs;
=20
-	shm =3D optee_get_msg_arg(ctx, 0, &msg_arg);
-	if (IS_ERR(shm))
-		return PTR_ERR(shm);
+	msg_arg =3D optee_get_msg_arg(ctx, 0, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
=20
 	msg_arg->cmd =3D cmd;
-	optee_smc_do_call_with_arg(ctx, shm);
+	optee_smc_do_call_with_arg(ctx, shm, offs);
=20
-	tee_shm_free(shm);
+	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
 }
=20
@@ -1321,6 +1358,7 @@ static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
 	struct tee_shm_pool *pool =3D ERR_PTR(-EINVAL);
+	u32 arg_cache_flags =3D OPTEE_SHM_ARG_SHARED;
 	struct optee *optee =3D NULL;
 	void *memremaped_shm =3D NULL;
 	unsigned int rpc_param_count;
@@ -1353,6 +1391,9 @@ static int optee_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
=20
+	if (!rpc_param_count)
+		arg_cache_flags |=3D OPTEE_SHM_ARG_ALLOC_PRIV;
+
 	/*
 	 * Try to use dynamic shared memory if possible
 	 */
@@ -1406,6 +1447,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee_supp_init(&optee->supp);
 	optee->smc.memremaped_shm =3D memremaped_shm;
 	optee->pool =3D pool;
+	optee_shm_arg_cache_init(optee, arg_cache_flags);
=20
 	platform_set_drvdata(pdev, optee);
 	ctx =3D teedev_open(optee->teedev);
@@ -1473,6 +1515,7 @@ static int optee_probe(struct platform_device *pdev)
 err_close_ctx:
 	teedev_close_context(ctx);
 err_supp_uninit:
+	optee_shm_arg_cache_uninit(optee);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
 err_unreg_supp_teedev:
--=20
2.31.1


--===============3898765074775044272==--

