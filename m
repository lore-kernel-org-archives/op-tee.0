From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4 1/2] tee: system invocation
Date: Wed, 15 Feb 2023 18:02:37 +0100
Message-ID: <20230215170238.1864311-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6111492647822989231=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6111492647822989231==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds TEE system invocation context provisioning for a Linux driver
to provision execution contexts for invocation of system service
hosted in TEE. OP-TEE SMC ABI implements such invocation context
provisioning.

This feature is needed when a TEE invocation cannot afford to wait for
a free TEE thread when all TEE threads context are used and suspended
as these may be suspended waiting for a system service, as an SCMI clock
or voltage regulator, to be enabled. An example is when OP-TEE invokes
a Linux OS remote service (RPC) to access an eMMC RPMB partition and
the eMMC device is supplied by an OP-TEE SCMI regulator.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v3:
- Fixed new SMC funcIDs to reserved/unreserve OP-TEE thread contexts:
  minor renaming + define as fastcall funcIDs.
- Moved system_ctx_count from generic struct tee_context to optee's
  private struct optee_context_data. This changes optee smc_abi.c
  to release reserved thread contexts when the optee device is released.
- Fixed inline description comments.

No change since v2

Change since v1
- Addressed comment on Linux client to claim reservation on TEE context.
  This brings 2 new operations from client to TEE to request and release
  system thread contexts: 2 new tee_drv.h API functions, 2 new ops
  functions in struct tee_driver_ops. The OP-TEE implement shall implement
  2 new fastcall SMC funcIDs.
- Fixed typos in commit message.
---
 drivers/tee/optee/optee_private.h |  9 ++++-
 drivers/tee/optee/optee_smc.h     | 60 +++++++++++++++++++++++++++--
 drivers/tee/optee/smc_abi.c       | 64 ++++++++++++++++++++++++++++++-
 drivers/tee/tee_core.c            | 18 +++++++++
 include/linux/tee_drv.h           | 18 +++++++++
 5 files changed, 163 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 04ae58892608..b409ed2acfa6 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -182,10 +182,17 @@ struct optee_session {
 	u32 session_id;
 };
=20
+/*
+ * struct optee_context_data - TEE context private data
+ * @mutex       Serializes access to this struct
+ * @sess_list   List of TEE sessions opened for this context
+ * @system_ctx_count Number of system invocation contexts provisioned in TEE
+ *                   for this context
+ */
 struct optee_context_data {
-	/* Serializes access to this struct */
 	struct mutex mutex;
 	struct list_head sess_list;
+	size_t system_ctx_count;
 };
=20
 struct optee_rpc_param {
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 73b5e7760d10..7d08ccaf47d4 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -108,7 +108,8 @@ struct optee_smc_call_get_os_revision_result {
  * Call with struct optee_msg_arg as argument
  *
  * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
- * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
+ * OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
+ * in a0 there is one RPC struct optee_msg_arg
  * following after the first struct optee_msg_arg. The RPC struct
  * optee_msg_arg has reserved space for the number of RPC parameters as
  * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
@@ -130,8 +131,8 @@ struct optee_smc_call_get_os_revision_result {
  * a4-6	Not used
  * a7	Hypervisor Client ID register
  *
- * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
- * a0	SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
+ * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG and OPTEE_SMC_FUNCID_CA=
LL_SYSTEM_WITH_REGD_ARG:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL=
_SYSTEM_WITH_REGD_ARG
  * a1	Upper 32 bits of a 64-bit shared memory cookie
  * a2	Lower 32 bits of a 64-bit shared memory cookie
  * a3	Offset of the struct optee_msg_arg in the shared memory with the
@@ -175,6 +176,8 @@ struct optee_smc_call_get_os_revision_result {
 	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
 #define OPTEE_SMC_CALL_WITH_REGD_ARG \
 	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
+#define OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG)
=20
 /*
  * Get Shared Memory Config
@@ -254,6 +257,8 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
 /* Secure world supports pre-allocating RPC arg struct */
 #define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
+/* Secure world provisions thread for system service invocation */
+#define OPTEE_SMC_SEC_CAP_SYSTEM_THREAD		BIT(7)
=20
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
@@ -426,6 +431,55 @@ struct optee_smc_disable_shm_cache_result {
 /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
 #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
=20
+/* See OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG above */
+#define OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG	20
+
+/*
+ * Request reservation of a system invocation thread context in OP-TEE
+ *
+ * Call register usage:
+ * a0	SMC Function ID: OPTEE_SMC_RESERVE_SYS_THREAD
+ * a1-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	Return value, OPTEE_SMC_RETURN_*
+ * a1-3	Not used
+ * a4-7	Preserved
+ *
+ * Possible return values:
+ * OPTEE_SMC_RETURN_UNKNOWN_FUNCTION	Trusted OS does not recognize this
+ *                                      function.
+ * OPTEE_SMC_RETURN_OK			Call successfully completed.
+ * OPTEE_SMC_RETURN_ETHREAD_LIMIT	Number of Trusted OS threads exceeded
+ *                                      for the request.
+ */
+#define OPTEE_SMC_FUNCID_RESERVE_SYS_THREAD	21
+#define OPTEE_SMC_RESERVE_SYS_THREAD \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_RESERVE_SYS_THREAD)
+
+/*
+ * Unregister reservation of a system invocation thread context in OP-TEE
+ *
+ * Call register usage:
+ * a0	SMC Function ID: OPTEE_SMC_UNRESERVE_SYS_THREAD
+ * a1-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	Return value, OPTEE_SMC_RETURN_*
+ * a1-3	Not used
+ * a4-7	Preserved
+ *
+ * Possible return values:
+ * OPTEE_SMC_RETURN_UNKNOWN_FUNCTION	Trusted OS does not recognize this
+ *                                      function.
+ * OPTEE_SMC_RETURN_OK			Call successfully completed.
+ */
+#define OPTEE_SMC_FUNCID_UNRESERVE_SYS_THREAD	22
+#define OPTEE_SMC_UNRESERVE_SYS_THREAD \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_UNRESERVE_SYS_THREAD)
+
 /*
  * Resume from RPC (for example after processing a foreign interrupt)
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..8668ab5f1c8b 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -867,6 +867,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
 static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 				      struct tee_shm *shm, u_int offs)
 {
+	struct optee_context_data *ctxdata =3D ctx->data;
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
 	struct optee_rpc_param param =3D { };
@@ -889,7 +890,10 @@ static int optee_smc_do_call_with_arg(struct tee_context=
 *ctx,
 	}
=20
 	if  (rpc_arg && tee_shm_is_dynamic(shm)) {
-		param.a0 =3D OPTEE_SMC_CALL_WITH_REGD_ARG;
+		if (ctxdata->system_ctx_count)
+			param.a0 =3D OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
+		else
+			param.a0 =3D OPTEE_SMC_CALL_WITH_REGD_ARG;
 		reg_pair_from_64(&param.a1, &param.a2, (u_long)shm);
 		param.a3 =3D offs;
 	} else {
@@ -1077,6 +1081,50 @@ static void optee_get_version(struct tee_device *teede=
v,
 	*vers =3D v;
 }
=20
+static int optee_request_sys_ctx(struct tee_context *ctx)
+{
+	struct optee_context_data *ctxdata =3D ctx->data;
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	struct arm_smccc_res res;
+
+	if (!(optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
+		return -EINVAL;
+
+	optee->smc.invoke_fn(OPTEE_SMC_RESERVE_SYS_THREAD,
+			     0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0 !=3D OPTEE_SMC_RETURN_OK)
+		return -EINVAL;
+
+	mutex_lock(&ctxdata->mutex);
+	ctxdata->system_ctx_count++;
+	mutex_unlock(&ctxdata->mutex);
+
+	return 0;
+}
+
+static void optee_release_sys_ctx(struct tee_context *ctx)
+{
+	struct optee_context_data *ctxdata =3D ctx->data;
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	struct arm_smccc_res res;
+
+	if (!ctxdata->system_ctx_count)
+		return;
+
+	optee->smc.invoke_fn(OPTEE_SMC_UNRESERVE_SYS_THREAD,
+			     0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0 !=3D OPTEE_SMC_RETURN_OK) {
+		WARN_ONCE(1, "OP-TEE: Couldn't release reserved context\n");
+		return;
+	}
+
+	mutex_lock(&ctxdata->mutex);
+	ctxdata->system_ctx_count--;
+	mutex_unlock(&ctxdata->mutex);
+}
+
 static int optee_smc_open(struct tee_context *ctx)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
@@ -1085,16 +1133,28 @@ static int optee_smc_open(struct tee_context *ctx)
 	return optee_open(ctx, sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL);
 }
=20
+static void optee_smc_release(struct tee_context *ctx)
+{
+	struct optee_context_data *ctxdata =3D ctx->data;
+
+	while (ctxdata->system_ctx_count)
+		optee_release_sys_ctx(ctx);
+
+	optee_release(ctx);
+}
+
 static const struct tee_driver_ops optee_clnt_ops =3D {
 	.get_version =3D optee_get_version,
 	.open =3D optee_smc_open,
-	.release =3D optee_release,
+	.release =3D optee_smc_release,
 	.open_session =3D optee_open_session,
 	.close_session =3D optee_close_session,
 	.invoke_func =3D optee_invoke_func,
 	.cancel_req =3D optee_cancel_req,
 	.shm_register =3D optee_shm_register,
 	.shm_unregister =3D optee_shm_unregister,
+	.system_ctx_request =3D optee_request_sys_ctx,
+	.system_ctx_release =3D optee_release_sys_ctx,
 };
=20
 static const struct tee_desc optee_clnt_desc =3D {
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 98da206cd761..d6593c57f32d 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -5,6 +5,7 @@
=20
 #define pr_fmt(fmt) "%s: " fmt, __func__
=20
+#include <linux/bug.h>
 #include <linux/cdev.h>
 #include <linux/cred.h>
 #include <linux/fs.h>
@@ -1145,6 +1146,23 @@ void tee_client_close_context(struct tee_context *ctx)
 }
 EXPORT_SYMBOL_GPL(tee_client_close_context);
=20
+int tee_client_request_system_context(struct tee_context *ctx)
+{
+	if (!ctx->teedev->desc->ops->system_ctx_request ||
+	    !ctx->teedev->desc->ops->system_ctx_release)
+		return -EINVAL;
+
+	return ctx->teedev->desc->ops->system_ctx_request(ctx);
+}
+EXPORT_SYMBOL_GPL(tee_client_request_system_context);
+
+void tee_client_release_system_context(struct tee_context *ctx)
+{
+	if (ctx->teedev->desc->ops->system_ctx_release)
+		ctx->teedev->desc->ops->system_ctx_release(ctx);
+}
+EXPORT_SYMBOL_GPL(tee_client_release_system_context);
+
 void tee_client_get_version(struct tee_context *ctx,
 			    struct tee_ioctl_version_data *vers)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 17eb1c5205d3..99d016eb7353 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -90,6 +90,8 @@ struct tee_param {
  * @supp_send:		called for supplicant to send a response
  * @shm_register:	register shared memory buffer in TEE
  * @shm_unregister:	unregister shared memory buffer in TEE
+ * @system_ctx_request:	Request provisioning of a new system context in TEE
+ * @system_ctx_release:	Release a provisioned system context in TEE
  */
 struct tee_driver_ops {
 	void (*get_version)(struct tee_device *teedev,
@@ -112,6 +114,8 @@ struct tee_driver_ops {
 			    struct page **pages, size_t num_pages,
 			    unsigned long start);
 	int (*shm_unregister)(struct tee_context *ctx, struct tee_shm *shm);
+	int (*system_ctx_request)(struct tee_context *ctx);
+	void (*system_ctx_release)(struct tee_context *ctx);
 };
=20
 /**
@@ -397,6 +401,20 @@ tee_client_open_context(struct tee_context *start,
  */
 void tee_client_close_context(struct tee_context *ctx);
=20
+/**
+ * tee_client_request_system_context() - Request reservation of a system con=
text
+ * @ctx:	TEE context reference
+ *
+ * @return 0 on success else an error code
+ */
+int tee_client_request_system_context(struct tee_context *ctx);
+
+/**
+ * tee_client_release_system_context() - Release a reserved system context
+ * @ctx:	TEE context reference
+ */
+void tee_client_release_system_context(struct tee_context *ctx);
+
 /**
  * tee_client_get_version() - Query version of TEE
  * @ctx:	TEE context to TEE to query
--=20
2.25.1


--===============6111492647822989231==--

