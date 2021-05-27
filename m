From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 3/5] optee: refactor driver with internal callbacks
Date: Thu, 27 May 2021 10:14:02 +0200
Message-ID: <20210527081404.1433177-4-jens.wiklander@linaro.org>
In-Reply-To: <20210527081404.1433177-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1789937495886557617=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1789937495886557617==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The OP-TEE driver is refactored with three internal callbacks replacing
direct calls to optee_from_msg_param(), optee_to_msg_param() and
optee_do_call_with_arg().

These functions a central to communicating with OP-TEE in secure world
by using the SMC Calling Convention directly.

This refactoring makes room for using other primitives to communicate
with OP-TEE in secure world while being able to reuse as much as
possible from the present driver.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          |  86 +++++++++--------
 drivers/tee/optee/core.c          | 148 ++++++++++++++++++++----------
 drivers/tee/optee/optee_private.h |  35 +++++--
 drivers/tee/optee/rpc.c           |  19 ++--
 4 files changed, 182 insertions(+), 106 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 20092cf95c31..f5d77ef780b9 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015, Linaro Limited
+ * Copyright (c) 2015-2021, Linaro Limited
  */
 #include <linux/arm-smccc.h>
 #include <linux/device.h>
@@ -118,20 +118,25 @@ static struct optee_session *find_session(struct optee_=
context_data *ctxdata,
 /**
  * optee_do_call_with_arg() - Do an SMC to OP-TEE in secure world
  * @ctx:	calling context
- * @parg:	physical address of message to pass to secure world
+ * @arg:	shared memory holding the message to pass to secure world
  *
  * Does and SMC to OP-TEE in secure world and handles eventual resulting
  * Remote Procedure Calls (RPC) from OP-TEE.
  *
  * Returns return code from secure world, 0 is OK
  */
-u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
+int optee_do_call_with_arg(struct tee_context *ctx, struct tee_shm *arg)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
 	struct optee_rpc_param param =3D { };
 	struct optee_call_ctx call_ctx =3D { };
-	u32 ret;
+	phys_addr_t parg;
+	int rc;
+
+	rc =3D tee_shm_get_pa(arg, 0, &parg);
+	if (rc)
+		return rc;
=20
 	param.a0 =3D OPTEE_SMC_CALL_WITH_ARG;
 	reg_pair_from_64(&param.a1, &param.a2, parg);
@@ -160,7 +165,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_=
addr_t parg)
 			param.a3 =3D res.a3;
 			optee_handle_rpc(ctx, &param, &call_ctx);
 		} else {
-			ret =3D res.a0;
+			rc =3D res.a0;
 			break;
 		}
 	}
@@ -172,14 +177,12 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phy=
s_addr_t parg)
 	 */
 	optee_cq_wait_final(&optee->call_queue, &w);
=20
-	return ret;
+	return rc;
 }
=20
 static struct tee_shm *get_msg_arg(struct tee_context *ctx, size_t num_param=
s,
-				   struct optee_msg_arg **msg_arg,
-				   phys_addr_t *msg_parg)
+				   struct optee_msg_arg **msg_arg)
 {
-	int rc;
 	struct tee_shm *shm;
 	struct optee_msg_arg *ma;
=20
@@ -190,22 +193,13 @@ static struct tee_shm *get_msg_arg(struct tee_context *=
ctx, size_t num_params,
=20
 	ma =3D tee_shm_get_va(shm, 0);
 	if (IS_ERR(ma)) {
-		rc =3D PTR_ERR(ma);
-		goto out;
+		tee_shm_free(shm);
+		return (void *)ma;
 	}
=20
-	rc =3D tee_shm_get_pa(shm, 0, msg_parg);
-	if (rc)
-		goto out;
-
 	memset(ma, 0, OPTEE_MSG_GET_ARG_SIZE(num_params));
 	ma->num_params =3D num_params;
 	*msg_arg =3D ma;
-out:
-	if (rc) {
-		tee_shm_free(shm);
-		return ERR_PTR(rc);
-	}
=20
 	return shm;
 }
@@ -214,15 +208,15 @@ int optee_open_session(struct tee_context *ctx,
 		       struct tee_ioctl_open_session_arg *arg,
 		       struct tee_param *param)
 {
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_context_data *ctxdata =3D ctx->data;
 	int rc;
 	struct tee_shm *shm;
 	struct optee_msg_arg *msg_arg;
-	phys_addr_t msg_parg;
 	struct optee_session *sess =3D NULL;
=20
 	/* +2 for the meta parameters added below */
-	shm =3D get_msg_arg(ctx, arg->num_params + 2, &msg_arg, &msg_parg);
+	shm =3D get_msg_arg(ctx, arg->num_params + 2, &msg_arg);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
=20
@@ -245,7 +239,8 @@ int optee_open_session(struct tee_context *ctx,
 	if (rc)
 		goto out;
=20
-	rc =3D optee_to_msg_param(msg_arg->params + 2, arg->num_params, param);
+	rc =3D optee->ops->to_msg_param(optee, msg_arg->params + 2,
+				      arg->num_params, param);
 	if (rc)
 		goto out;
=20
@@ -255,7 +250,7 @@ int optee_open_session(struct tee_context *ctx,
 		goto out;
 	}
=20
-	if (optee_do_call_with_arg(ctx, msg_parg)) {
+	if (optee->ops->do_call_with_arg(ctx, shm)) {
 		msg_arg->ret =3D TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 	}
@@ -270,7 +265,8 @@ int optee_open_session(struct tee_context *ctx,
 		kfree(sess);
 	}
=20
-	if (optee_from_msg_param(param, arg->num_params, msg_arg->params + 2)) {
+	if (optee->ops->from_msg_param(optee, param, arg->num_params,
+				       msg_arg->params + 2)) {
 		arg->ret =3D TEEC_ERROR_COMMUNICATION;
 		arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 		/* Close session again to avoid leakage */
@@ -289,16 +285,16 @@ int optee_open_session(struct tee_context *ctx,
 int optee_close_session_helper(struct tee_context *ctx, u32 session)
 {
 	struct tee_shm *shm;
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_msg_arg *msg_arg;
-	phys_addr_t msg_parg;
=20
-	shm =3D get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
+	shm =3D get_msg_arg(ctx, 0, &msg_arg);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
=20
 	msg_arg->cmd =3D OPTEE_MSG_CMD_CLOSE_SESSION;
 	msg_arg->session =3D session;
-	optee_do_call_with_arg(ctx, msg_parg);
+	optee->ops->do_call_with_arg(ctx, shm);
=20
 	tee_shm_free(shm);
=20
@@ -326,10 +322,10 @@ int optee_close_session(struct tee_context *ctx, u32 se=
ssion)
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *=
arg,
 		      struct tee_param *param)
 {
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_context_data *ctxdata =3D ctx->data;
 	struct tee_shm *shm;
 	struct optee_msg_arg *msg_arg;
-	phys_addr_t msg_parg;
 	struct optee_session *sess;
 	int rc;
=20
@@ -340,7 +336,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee=
_ioctl_invoke_arg *arg,
 	if (!sess)
 		return -EINVAL;
=20
-	shm =3D get_msg_arg(ctx, arg->num_params, &msg_arg, &msg_parg);
+	shm =3D get_msg_arg(ctx, arg->num_params, &msg_arg);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
 	msg_arg->cmd =3D OPTEE_MSG_CMD_INVOKE_COMMAND;
@@ -348,16 +344,18 @@ int optee_invoke_func(struct tee_context *ctx, struct t=
ee_ioctl_invoke_arg *arg,
 	msg_arg->session =3D arg->session;
 	msg_arg->cancel_id =3D arg->cancel_id;
=20
-	rc =3D optee_to_msg_param(msg_arg->params, arg->num_params, param);
+	rc =3D optee->ops->to_msg_param(optee, msg_arg->params, arg->num_params,
+				      param);
 	if (rc)
 		goto out;
=20
-	if (optee_do_call_with_arg(ctx, msg_parg)) {
+	if (optee->ops->do_call_with_arg(ctx, shm)) {
 		msg_arg->ret =3D TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 	}
=20
-	if (optee_from_msg_param(param, arg->num_params, msg_arg->params)) {
+	if (optee->ops->from_msg_param(optee, param, arg->num_params,
+				       msg_arg->params)) {
 		msg_arg->ret =3D TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 	}
@@ -371,10 +369,10 @@ int optee_invoke_func(struct tee_context *ctx, struct t=
ee_ioctl_invoke_arg *arg,
=20
 int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
 {
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_context_data *ctxdata =3D ctx->data;
 	struct tee_shm *shm;
 	struct optee_msg_arg *msg_arg;
-	phys_addr_t msg_parg;
 	struct optee_session *sess;
=20
 	/* Check that the session is valid */
@@ -384,14 +382,14 @@ int optee_cancel_req(struct tee_context *ctx, u32 cance=
l_id, u32 session)
 	if (!sess)
 		return -EINVAL;
=20
-	shm =3D get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
+	shm =3D get_msg_arg(ctx, 0, &msg_arg);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
=20
 	msg_arg->cmd =3D OPTEE_MSG_CMD_CANCEL;
 	msg_arg->session =3D session;
 	msg_arg->cancel_id =3D cancel_id;
-	optee_do_call_with_arg(ctx, msg_parg);
+	optee->ops->do_call_with_arg(ctx, shm);
=20
 	tee_shm_free(shm);
 	return 0;
@@ -590,10 +588,10 @@ int optee_shm_register(struct tee_context *ctx, struct =
tee_shm *shm,
 		       struct page **pages, size_t num_pages,
 		       unsigned long start)
 {
-	struct tee_shm *shm_arg =3D NULL;
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm_arg;
 	u64 *pages_list;
-	phys_addr_t msg_parg;
 	int rc;
=20
 	if (!num_pages)
@@ -607,7 +605,7 @@ int optee_shm_register(struct tee_context *ctx, struct te=
e_shm *shm,
 	if (!pages_list)
 		return -ENOMEM;
=20
-	shm_arg =3D get_msg_arg(ctx, 1, &msg_arg, &msg_parg);
+	shm_arg =3D get_msg_arg(ctx, 1, &msg_arg);
 	if (IS_ERR(shm_arg)) {
 		rc =3D PTR_ERR(shm_arg);
 		goto out;
@@ -628,7 +626,7 @@ int optee_shm_register(struct tee_context *ctx, struct te=
e_shm *shm,
 	msg_arg->params->u.tmem.buf_ptr =3D virt_to_phys(pages_list) |
 	  (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
=20
-	if (optee_do_call_with_arg(ctx, msg_parg) ||
+	if (optee->ops->do_call_with_arg(ctx, shm) ||
 	    msg_arg->ret !=3D TEEC_SUCCESS)
 		rc =3D -EINVAL;
=20
@@ -640,12 +638,12 @@ int optee_shm_register(struct tee_context *ctx, struct =
tee_shm *shm,
=20
 int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
 {
-	struct tee_shm *shm_arg;
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_msg_arg *msg_arg;
-	phys_addr_t msg_parg;
+	struct tee_shm *shm_arg;
 	int rc =3D 0;
=20
-	shm_arg =3D get_msg_arg(ctx, 1, &msg_arg, &msg_parg);
+	shm_arg =3D get_msg_arg(ctx, 1, &msg_arg);
 	if (IS_ERR(shm_arg))
 		return PTR_ERR(shm_arg);
=20
@@ -654,7 +652,7 @@ int optee_shm_unregister(struct tee_context *ctx, struct =
tee_shm *shm)
 	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
 	msg_arg->params[0].u.rmem.shm_ref =3D (unsigned long)shm;
=20
-	if (optee_do_call_with_arg(ctx, msg_parg) ||
+	if (optee->ops->do_call_with_arg(ctx, shm) ||
 	    msg_arg->ret !=3D TEEC_SUCCESS)
 		rc =3D -EINVAL;
 	tee_shm_free(shm_arg);
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 949223b214c3..f689f171a794 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015, Linaro Limited
+ * Copyright (c) 2015-2021, Linaro Limited
  */
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -26,21 +26,87 @@
=20
 #define OPTEE_SHM_NUM_PRIV_PAGES	CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
=20
+static void from_msg_param_value(struct tee_param *p, u32 attr,
+				 const struct optee_msg_param *mp)
+{
+	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
+		  attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+	p->u.value.a =3D mp->u.value.a;
+	p->u.value.b =3D mp->u.value.b;
+	p->u.value.c =3D mp->u.value.c;
+}
+
+static int from_msg_param_tmp_mem(struct tee_param *p, u32 attr,
+				  const struct optee_msg_param *mp)
+{
+	struct tee_shm *shm;
+	phys_addr_t pa;
+	int rc;
+
+	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
+		  attr - OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
+	p->u.memref.size =3D mp->u.tmem.size;
+	shm =3D (struct tee_shm *)(unsigned long)mp->u.tmem.shm_ref;
+	if (!shm) {
+		p->u.memref.shm_offs =3D 0;
+		p->u.memref.shm =3D NULL;
+		return 0;
+	}
+
+	rc =3D tee_shm_get_pa(shm, 0, &pa);
+	if (rc)
+		return rc;
+
+	p->u.memref.shm_offs =3D mp->u.tmem.buf_ptr - pa;
+	p->u.memref.shm =3D shm;
+
+	/* Check that the memref is covered by the shm object */
+	if (p->u.memref.size) {
+		size_t o =3D p->u.memref.shm_offs +
+			   p->u.memref.size - 1;
+
+		rc =3D tee_shm_get_pa(shm, o, NULL);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static void from_msg_param_reg_mem(struct tee_param *p, u32 attr,
+				   const struct optee_msg_param *mp)
+{
+	struct tee_shm *shm;
+
+	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
+		  attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
+	p->u.memref.size =3D mp->u.rmem.size;
+	shm =3D (struct tee_shm *)(unsigned long)mp->u.rmem.shm_ref;
+
+	if (shm) {
+		p->u.memref.shm_offs =3D mp->u.rmem.offs;
+		p->u.memref.shm =3D shm;
+	} else {
+		p->u.memref.shm_offs =3D 0;
+		p->u.memref.shm =3D NULL;
+	}
+}
+
 /**
  * optee_from_msg_param() - convert from OPTEE_MSG parameters to
  *			    struct tee_param
+ * @optee:	main service struct
  * @params:	subsystem internal parameter representation
  * @num_params:	number of elements in the parameter arrays
  * @msg_params:	OPTEE_MSG parameters
  * Returns 0 on success or <0 on failure
  */
-int optee_from_msg_param(struct tee_param *params, size_t num_params,
-			 const struct optee_msg_param *msg_params)
+static int optee_from_msg_param(struct optee *optee, struct tee_param *param=
s,
+				size_t num_params,
+				const struct optee_msg_param *msg_params)
 {
 	int rc;
 	size_t n;
-	struct tee_shm *shm;
-	phys_addr_t pa;
=20
 	for (n =3D 0; n < num_params; n++) {
 		struct tee_param *p =3D params + n;
@@ -55,48 +121,19 @@ int optee_from_msg_param(struct tee_param *params, size_=
t num_params,
 		case OPTEE_MSG_ATTR_TYPE_VALUE_INPUT:
 		case OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT:
 		case OPTEE_MSG_ATTR_TYPE_VALUE_INOUT:
-			p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
-				  attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
-			p->u.value.a =3D mp->u.value.a;
-			p->u.value.b =3D mp->u.value.b;
-			p->u.value.c =3D mp->u.value.c;
+			from_msg_param_value(p, attr, mp);
 			break;
 		case OPTEE_MSG_ATTR_TYPE_TMEM_INPUT:
 		case OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT:
 		case OPTEE_MSG_ATTR_TYPE_TMEM_INOUT:
-			p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
-				  attr - OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
-			p->u.memref.size =3D mp->u.tmem.size;
-			shm =3D (struct tee_shm *)(unsigned long)
-				mp->u.tmem.shm_ref;
-			if (!shm) {
-				p->u.memref.shm_offs =3D 0;
-				p->u.memref.shm =3D NULL;
-				break;
-			}
-			rc =3D tee_shm_get_pa(shm, 0, &pa);
+			rc =3D from_msg_param_tmp_mem(p, attr, mp);
 			if (rc)
 				return rc;
-			p->u.memref.shm_offs =3D mp->u.tmem.buf_ptr - pa;
-			p->u.memref.shm =3D shm;
 			break;
 		case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
 		case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
 		case OPTEE_MSG_ATTR_TYPE_RMEM_INOUT:
-			p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
-				  attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
-			p->u.memref.size =3D mp->u.rmem.size;
-			shm =3D (struct tee_shm *)(unsigned long)
-				mp->u.rmem.shm_ref;
-
-			if (!shm) {
-				p->u.memref.shm_offs =3D 0;
-				p->u.memref.shm =3D NULL;
-				break;
-			}
-			p->u.memref.shm_offs =3D mp->u.rmem.offs;
-			p->u.memref.shm =3D shm;
-
+			from_msg_param_reg_mem(p, attr, mp);
 			break;
=20
 		default:
@@ -106,6 +143,16 @@ int optee_from_msg_param(struct tee_param *params, size_=
t num_params,
 	return 0;
 }
=20
+static void to_msg_param_value(struct optee_msg_param *mp,
+			       const struct tee_param *p)
+{
+	mp->attr =3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
+		   TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	mp->u.value.a =3D p->u.value.a;
+	mp->u.value.b =3D p->u.value.b;
+	mp->u.value.c =3D p->u.value.c;
+}
+
 static int to_msg_param_tmp_mem(struct optee_msg_param *mp,
 				const struct tee_param *p)
 {
@@ -148,13 +195,15 @@ static int to_msg_param_reg_mem(struct optee_msg_param =
*mp,
=20
 /**
  * optee_to_msg_param() - convert from struct tee_params to OPTEE_MSG parame=
ters
+ * @optee:	main service struct
  * @msg_params:	OPTEE_MSG parameters
  * @num_params:	number of elements in the parameter arrays
  * @params:	subsystem itnernal parameter representation
  * Returns 0 on success or <0 on failure
  */
-int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
-		       const struct tee_param *params)
+static int optee_to_msg_param(struct optee *optee,
+			      struct optee_msg_param *msg_params,
+			      size_t num_params, const struct tee_param *params)
 {
 	int rc;
 	size_t n;
@@ -171,11 +220,7 @@ int optee_to_msg_param(struct optee_msg_param *msg_param=
s, size_t num_params,
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
-			mp->attr =3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
-				   TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
-			mp->u.value.a =3D p->u.value.a;
-			mp->u.value.b =3D p->u.value.b;
-			mp->u.value.c =3D p->u.value.c;
+			to_msg_param_value(mp, p);
 			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
@@ -301,7 +346,7 @@ static void optee_release_supp(struct tee_context *ctx)
 	optee_supp_release(&optee->supp);
 }
=20
-static const struct tee_driver_ops optee_ops =3D {
+static const struct tee_driver_ops optee_clnt_ops =3D {
 	.get_version =3D optee_get_version,
 	.open =3D optee_open,
 	.release =3D optee_release,
@@ -313,9 +358,9 @@ static const struct tee_driver_ops optee_ops =3D {
 	.shm_unregister =3D optee_shm_unregister,
 };
=20
-static const struct tee_desc optee_desc =3D {
+static const struct tee_desc optee_clnt_desc =3D {
 	.name =3D DRIVER_NAME "-clnt",
-	.ops =3D &optee_ops,
+	.ops =3D &optee_clnt_ops,
 	.owner =3D THIS_MODULE,
 };
=20
@@ -336,6 +381,12 @@ static const struct tee_desc optee_supp_desc =3D {
 	.flags =3D TEE_DESC_PRIVILEGED,
 };
=20
+static const struct optee_ops optee_ops =3D {
+	.do_call_with_arg =3D optee_do_call_with_arg,
+	.to_msg_param =3D optee_to_msg_param,
+	.from_msg_param =3D optee_from_msg_param,
+};
+
 static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
 {
 	struct arm_smccc_res res;
@@ -637,10 +688,11 @@ static int optee_probe(struct platform_device *pdev)
 		goto err;
 	}
=20
+	optee->ops =3D &optee_ops;
 	optee->invoke_fn =3D invoke_fn;
 	optee->sec_caps =3D sec_caps;
=20
-	teedev =3D tee_device_alloc(&optee_desc, NULL, pool, optee);
+	teedev =3D tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc =3D PTR_ERR(teedev);
 		goto err;
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 2b63b796645e..c5741e96e967 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2015, Linaro Limited
+ * Copyright (c) 2015-2021, Linaro Limited
  */
=20
 #ifndef OPTEE_PRIVATE_H
@@ -66,9 +66,34 @@ struct optee_supp {
 	struct completion reqs_c;
 };
=20
+struct optee;
+
+/**
+ * struct optee_ops - OP-TEE driver internal operations
+ * @do_call_with_arg:	enters OP-TEE in secure world
+ * @to_msg_param:	converts from struct tee_param to OPTEE_MSG parameters
+ * @from_msg_param:	converts from OPTEE_MSG parameters to struct tee_param
+ *
+ * These OPs are only supposed to be used internally in the OP-TEE driver
+ * as a way of abstracting the different methogs of entering OP-TEE in
+ * secure world.
+ */
+struct optee_ops {
+	int (*do_call_with_arg)(struct tee_context *ctx,
+				struct tee_shm *shm_arg);
+	int (*to_msg_param)(struct optee *optee,
+			    struct optee_msg_param *msg_params,
+			    size_t num_params, const struct tee_param *params);
+	int (*from_msg_param)(struct optee *optee, struct tee_param *params,
+			      size_t num_params,
+			      const struct optee_msg_param *msg_params);
+};
+
 /**
  * struct optee - main service struct
  * @supp_teedev:	supplicant device
+ * @ops:		internal callbacks for different ways to reach secure
+ *			world
  * @teedev:		client device
  * @invoke_fn:		function to issue smc or hvc
  * @call_queue:		queue of threads waiting to call @invoke_fn
@@ -86,6 +111,7 @@ struct optee_supp {
 struct optee {
 	struct tee_device *supp_teedev;
 	struct tee_device *teedev;
+	const struct optee_ops *ops;
 	optee_invoke_fn *invoke_fn;
 	struct optee_call_queue call_queue;
 	struct optee_wait_queue wait_queue;
@@ -148,7 +174,7 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u=
32 *num_params,
 int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 		    struct tee_param *param);
=20
-u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg);
+int optee_do_call_with_arg(struct tee_context *ctx, struct tee_shm *arg);
 int optee_open_session(struct tee_context *ctx,
 		       struct tee_ioctl_open_session_arg *arg,
 		       struct tee_param *param);
@@ -171,11 +197,6 @@ int optee_shm_register_supp(struct tee_context *ctx, str=
uct tee_shm *shm,
 			    unsigned long start);
 int optee_shm_unregister_supp(struct tee_context *ctx, struct tee_shm *shm);
=20
-int optee_from_msg_param(struct tee_param *params, size_t num_params,
-			 const struct optee_msg_param *msg_params);
-int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
-		       const struct tee_param *params);
-
 u64 *optee_allocate_pages_list(size_t num_entries);
 void optee_free_pages_list(void *array, size_t num_entries);
 void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 1849180b0278..39562fb6841e 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015-2016, Linaro Limited
+ * Copyright (c) 2015-2021, Linaro Limited
  */
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -55,6 +55,7 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_a=
rg *arg)
 static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 					     struct optee_msg_arg *arg)
 {
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct tee_param *params;
 	struct i2c_adapter *adapter;
 	struct i2c_msg msg =3D { };
@@ -79,7 +80,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_con=
text *ctx,
 		return;
 	}
=20
-	if (optee_from_msg_param(params, arg->num_params, arg->params))
+	if (optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params))
 		goto bad;
=20
 	for (i =3D 0; i < arg->num_params; i++) {
@@ -122,7 +124,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_c=
ontext *ctx,
 		arg->ret =3D TEEC_ERROR_COMMUNICATION;
 	} else {
 		params[3].u.value.a =3D msg.len;
-		if (optee_to_msg_param(arg->params, arg->num_params, params))
+		if (optee->ops->to_msg_param(optee, arg->params,
+					     arg->num_params, params))
 			arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 		else
 			arg->ret =3D TEEC_SUCCESS;
@@ -234,7 +237,7 @@ static void handle_rpc_func_cmd_wait(struct optee_msg_arg=
 *arg)
 	arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 }
=20
-static void handle_rpc_supp_cmd(struct tee_context *ctx,
+static void handle_rpc_supp_cmd(struct tee_context *ctx, struct optee *optee,
 				struct optee_msg_arg *arg)
 {
 	struct tee_param *params;
@@ -248,14 +251,16 @@ static void handle_rpc_supp_cmd(struct tee_context *ctx,
 		return;
 	}
=20
-	if (optee_from_msg_param(params, arg->num_params, arg->params)) {
+	if (optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params)) {
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 		goto out;
 	}
=20
 	arg->ret =3D optee_supp_thrd_req(ctx, arg->cmd, arg->num_params, params);
=20
-	if (optee_to_msg_param(arg->params, arg->num_params, params))
+	if (optee->ops->to_msg_param(optee, arg->params, arg->num_params,
+				     params))
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 out:
 	kfree(params);
@@ -480,7 +485,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, =
struct optee *optee,
 		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
 		break;
 	default:
-		handle_rpc_supp_cmd(ctx, arg);
+		handle_rpc_supp_cmd(ctx, optee, arg);
 	}
 }
=20
--=20
2.25.1


--===============1789937495886557617==--

