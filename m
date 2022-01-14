From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 07/12] optee: use driver internal tee_contex for some rpc
Date: Fri, 14 Jan 2022 16:08:19 +0100
Message-ID: <20220114150824.3578829-8-jens.wiklander@linaro.org>
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0573937707167763716=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0573937707167763716==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Uses the new driver internal tee_context when allocating driver private
shared memory. This decouples the shared memory object from its original
tee_context. This is needed when the life time of such a memory
allocation outlives the client tee_context.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/ffa_abi.c | 16 ++++++++--------
 drivers/tee/optee/smc_abi.c |  7 ++++---
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 88a028d4fb7b..5ec484b42432 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -424,6 +424,7 @@ static struct tee_shm_pool *optee_ffa_shm_pool_alloc_page=
s(void)
  */
=20
 static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
+					      struct optee *optee,
 					      struct optee_msg_arg *arg)
 {
 	struct tee_shm *shm;
@@ -439,7 +440,7 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_=
context *ctx,
 		shm =3D optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm =3D tee_shm_alloc_priv_kernel_buf(ctx,
+		shm =3D tee_shm_alloc_priv_kernel_buf(optee->ctx,
 						    arg->params[0].u.value.b);
 		break;
 	default:
@@ -493,14 +494,13 @@ static void handle_ffa_rpc_func_cmd_shm_free(struct tee=
_context *ctx,
 }
=20
 static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
+				    struct optee *optee,
 				    struct optee_msg_arg *arg)
 {
-	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-
 	arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 	switch (arg->cmd) {
 	case OPTEE_RPC_CMD_SHM_ALLOC:
-		handle_ffa_rpc_func_cmd_shm_alloc(ctx, arg);
+		handle_ffa_rpc_func_cmd_shm_alloc(ctx, optee, arg);
 		break;
 	case OPTEE_RPC_CMD_SHM_FREE:
 		handle_ffa_rpc_func_cmd_shm_free(ctx, optee, arg);
@@ -510,12 +510,12 @@ static void handle_ffa_rpc_func_cmd(struct tee_context =
*ctx,
 	}
 }
=20
-static void optee_handle_ffa_rpc(struct tee_context *ctx, u32 cmd,
-				 struct optee_msg_arg *arg)
+static void optee_handle_ffa_rpc(struct tee_context *ctx, struct optee *opte=
e,
+				 u32 cmd, struct optee_msg_arg *arg)
 {
 	switch (cmd) {
 	case OPTEE_FFA_YIELDING_CALL_RETURN_RPC_CMD:
-		handle_ffa_rpc_func_cmd(ctx, arg);
+		handle_ffa_rpc_func_cmd(ctx, optee, arg);
 		break;
 	case OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT:
 		/* Interrupt delivered by now */
@@ -582,7 +582,7 @@ static int optee_ffa_yielding_call(struct tee_context *ct=
x,
 		 * above.
 		 */
 		cond_resched();
-		optee_handle_ffa_rpc(ctx, data->data1, rpc_arg);
+		optee_handle_ffa_rpc(ctx, optee, data->data1, rpc_arg);
 		cmd =3D OPTEE_FFA_YIELDING_CALL_RESUME;
 		data->data0 =3D cmd;
 		data->data1 =3D 0;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 1dbb13b08381..f2ef76451443 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -621,6 +621,7 @@ static void handle_rpc_func_cmd_shm_free(struct tee_conte=
xt *ctx,
 }
=20
 static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
+					  struct optee *optee,
 					  struct optee_msg_arg *arg,
 					  struct optee_call_ctx *call_ctx)
 {
@@ -650,7 +651,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_cont=
ext *ctx,
 		shm =3D optee_rpc_cmd_alloc_suppl(ctx, sz);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm =3D tee_shm_alloc_priv_kernel_buf(ctx, sz);
+		shm =3D tee_shm_alloc_priv_kernel_buf(optee->ctx, sz);
 		break;
 	default:
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
@@ -746,7 +747,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, =
struct optee *optee,
 	switch (arg->cmd) {
 	case OPTEE_RPC_CMD_SHM_ALLOC:
 		free_pages_list(call_ctx);
-		handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
+		handle_rpc_func_cmd_shm_alloc(ctx, optee, arg, call_ctx);
 		break;
 	case OPTEE_RPC_CMD_SHM_FREE:
 		handle_rpc_func_cmd_shm_free(ctx, arg);
@@ -775,7 +776,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
=20
 	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
 	case OPTEE_SMC_RPC_FUNC_ALLOC:
-		shm =3D tee_shm_alloc_priv_kernel_buf(ctx, param->a1);
+		shm =3D tee_shm_alloc_priv_kernel_buf(optee->ctx, param->a1);
 		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
 			reg_pair_from_64(&param->a1, &param->a2, pa);
 			reg_pair_from_64(&param->a4, &param->a5,
--=20
2.31.1


--===============0573937707167763716==--

