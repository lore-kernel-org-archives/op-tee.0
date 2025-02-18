From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v5 3/7] optee: account for direction while converting parameters
Date: Tue, 18 Feb 2025 15:34:52 +0100
Message-ID: <20250218143527.1236668-4-jens.wiklander@linaro.org>
In-Reply-To: <20250218143527.1236668-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0828164484150076190=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0828164484150076190==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The OP-TEE backend driver has two internal function pointers to convert
between the subsystem type struct tee_param and the OP-TEE type struct
optee_msg_param.

The conversion is done from one of the types to the other, which is then
involved in some operation and finally converted back to the original
type. When converting to prepare the parameters for the operation, all
fields must be taken into account, but then converting back, it's enough
to update only out-values and out-sizes. So, an update_out parameter is
added to the conversion functions to tell if all or only some fields
must be copied.

This is needed in a later patch where it might get confusing when
converting back in from_msg_param() callback since an allocated
restricted SHM can be using the sec_world_id of the used restricted
memory pool and that doesn't translate back well.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          | 10 ++--
 drivers/tee/optee/ffa_abi.c       | 43 +++++++++++++----
 drivers/tee/optee/optee_private.h | 42 +++++++++++------
 drivers/tee/optee/rpc.c           | 31 +++++++++----
 drivers/tee/optee/smc_abi.c       | 76 +++++++++++++++++++++++--------
 5 files changed, 144 insertions(+), 58 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 16eb953e14bb..f1533b894726 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -400,7 +400,8 @@ int optee_open_session(struct tee_context *ctx,
 	export_uuid(msg_arg->params[1].u.octets, &client_uuid);
=20
 	rc =3D optee->ops->to_msg_param(optee, msg_arg->params + 2,
-				      arg->num_params, param);
+				      arg->num_params, param,
+				      false /*!update_out*/);
 	if (rc)
 		goto out;
=20
@@ -427,7 +428,8 @@ int optee_open_session(struct tee_context *ctx,
 	}
=20
 	if (optee->ops->from_msg_param(optee, param, arg->num_params,
-				       msg_arg->params + 2)) {
+				       msg_arg->params + 2,
+				       true /*update_out*/)) {
 		arg->ret =3D TEEC_ERROR_COMMUNICATION;
 		arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 		/* Close session again to avoid leakage */
@@ -541,7 +543,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee=
_ioctl_invoke_arg *arg,
 	msg_arg->cancel_id =3D arg->cancel_id;
=20
 	rc =3D optee->ops->to_msg_param(optee, msg_arg->params, arg->num_params,
-				      param);
+				      param, false /*!update_out*/);
 	if (rc)
 		goto out;
=20
@@ -551,7 +553,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee=
_ioctl_invoke_arg *arg,
 	}
=20
 	if (optee->ops->from_msg_param(optee, param, arg->num_params,
-				       msg_arg->params)) {
+				       msg_arg->params, true /*update_out*/)) {
 		msg_arg->ret =3D TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 	}
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index f3af5666bb11..02e6175ac5f0 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -122,15 +122,21 @@ static int optee_shm_rem_ffa_handle(struct optee *optee=
, u64 global_id)
  */
=20
 static void from_msg_param_ffa_mem(struct optee *optee, struct tee_param *p,
-				   u32 attr, const struct optee_msg_param *mp)
+				   u32 attr, const struct optee_msg_param *mp,
+				   bool update_out)
 {
 	struct tee_shm *shm =3D NULL;
 	u64 offs_high =3D 0;
 	u64 offs_low =3D 0;
=20
+	if (update_out) {
+		if (attr =3D=3D OPTEE_MSG_ATTR_TYPE_FMEM_INPUT)
+			return;
+		goto out;
+	}
+
 	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
 		  attr - OPTEE_MSG_ATTR_TYPE_FMEM_INPUT;
-	p->u.memref.size =3D mp->u.fmem.size;
=20
 	if (mp->u.fmem.global_id !=3D OPTEE_MSG_FMEM_INVALID_GLOBAL_ID)
 		shm =3D optee_shm_from_ffa_handle(optee, mp->u.fmem.global_id);
@@ -141,6 +147,8 @@ static void from_msg_param_ffa_mem(struct optee *optee, s=
truct tee_param *p,
 		offs_high =3D mp->u.fmem.offs_high;
 	}
 	p->u.memref.shm_offs =3D offs_low | offs_high << 32;
+out:
+	p->u.memref.size =3D mp->u.fmem.size;
 }
=20
 /**
@@ -150,12 +158,14 @@ static void from_msg_param_ffa_mem(struct optee *optee,=
 struct tee_param *p,
  * @params:	subsystem internal parameter representation
  * @num_params:	number of elements in the parameter arrays
  * @msg_params:	OPTEE_MSG parameters
+ * @update_out: update parameter for output only
  *
  * Returns 0 on success or <0 on failure
  */
 static int optee_ffa_from_msg_param(struct optee *optee,
 				    struct tee_param *params, size_t num_params,
-				    const struct optee_msg_param *msg_params)
+				    const struct optee_msg_param *msg_params,
+				    bool update_out)
 {
 	size_t n;
=20
@@ -166,18 +176,20 @@ static int optee_ffa_from_msg_param(struct optee *optee,
=20
 		switch (attr) {
 		case OPTEE_MSG_ATTR_TYPE_NONE:
+			if (update_out)
+				break;
 			p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
 			memset(&p->u, 0, sizeof(p->u));
 			break;
 		case OPTEE_MSG_ATTR_TYPE_VALUE_INPUT:
 		case OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT:
 		case OPTEE_MSG_ATTR_TYPE_VALUE_INOUT:
-			optee_from_msg_param_value(p, attr, mp);
+			optee_from_msg_param_value(p, attr, mp, update_out);
 			break;
 		case OPTEE_MSG_ATTR_TYPE_FMEM_INPUT:
 		case OPTEE_MSG_ATTR_TYPE_FMEM_OUTPUT:
 		case OPTEE_MSG_ATTR_TYPE_FMEM_INOUT:
-			from_msg_param_ffa_mem(optee, p, attr, mp);
+			from_msg_param_ffa_mem(optee, p, attr, mp, update_out);
 			break;
 		default:
 			return -EINVAL;
@@ -188,10 +200,16 @@ static int optee_ffa_from_msg_param(struct optee *optee,
 }
=20
 static int to_msg_param_ffa_mem(struct optee_msg_param *mp,
-				const struct tee_param *p)
+				const struct tee_param *p, bool update_out)
 {
 	struct tee_shm *shm =3D p->u.memref.shm;
=20
+	if (update_out) {
+		if (p->attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT)
+			return 0;
+		goto out;
+	}
+
 	mp->attr =3D OPTEE_MSG_ATTR_TYPE_FMEM_INPUT + p->attr -
 		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
=20
@@ -211,6 +229,7 @@ static int to_msg_param_ffa_mem(struct optee_msg_param *m=
p,
 		memset(&mp->u, 0, sizeof(mp->u));
 		mp->u.fmem.global_id =3D OPTEE_MSG_FMEM_INVALID_GLOBAL_ID;
 	}
+out:
 	mp->u.fmem.size =3D p->u.memref.size;
=20
 	return 0;
@@ -222,13 +241,15 @@ static int to_msg_param_ffa_mem(struct optee_msg_param =
*mp,
  * @optee:	main service struct
  * @msg_params:	OPTEE_MSG parameters
  * @num_params:	number of elements in the parameter arrays
- * @params:	subsystem itnernal parameter representation
+ * @params:	subsystem internal parameter representation
+ * @update_out: update parameter for output only
  * Returns 0 on success or <0 on failure
  */
 static int optee_ffa_to_msg_param(struct optee *optee,
 				  struct optee_msg_param *msg_params,
 				  size_t num_params,
-				  const struct tee_param *params)
+				  const struct tee_param *params,
+				  bool update_out)
 {
 	size_t n;
=20
@@ -238,18 +259,20 @@ static int optee_ffa_to_msg_param(struct optee *optee,
=20
 		switch (p->attr) {
 		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
+			if (update_out)
+				break;
 			mp->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
 			memset(&mp->u, 0, sizeof(mp->u));
 			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
-			optee_to_msg_param_value(mp, p);
+			optee_to_msg_param_value(mp, p, update_out);
 			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
-			if (to_msg_param_ffa_mem(mp, p))
+			if (to_msg_param_ffa_mem(mp, p, update_out))
 				return -EINVAL;
 			break;
 		default:
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index dc0f355ef72a..20eda508dbac 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -185,10 +185,12 @@ struct optee_ops {
 				bool system_thread);
 	int (*to_msg_param)(struct optee *optee,
 			    struct optee_msg_param *msg_params,
-			    size_t num_params, const struct tee_param *params);
+			    size_t num_params, const struct tee_param *params,
+			    bool update_out);
 	int (*from_msg_param)(struct optee *optee, struct tee_param *params,
 			      size_t num_params,
-			      const struct optee_msg_param *msg_params);
+			      const struct optee_msg_param *msg_params,
+			      bool update_out);
 };
=20
 /**
@@ -316,23 +318,35 @@ void optee_release(struct tee_context *ctx);
 void optee_release_supp(struct tee_context *ctx);
=20
 static inline void optee_from_msg_param_value(struct tee_param *p, u32 attr,
-					      const struct optee_msg_param *mp)
+					      const struct optee_msg_param *mp,
+					      bool update_out)
 {
-	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
-		  attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
-	p->u.value.a =3D mp->u.value.a;
-	p->u.value.b =3D mp->u.value.b;
-	p->u.value.c =3D mp->u.value.c;
+	if (!update_out)
+		p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
+			  attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+
+	if (attr =3D=3D OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT ||
+	    attr =3D=3D OPTEE_MSG_ATTR_TYPE_VALUE_INOUT || !update_out) {
+		p->u.value.a =3D mp->u.value.a;
+		p->u.value.b =3D mp->u.value.b;
+		p->u.value.c =3D mp->u.value.c;
+	}
 }
=20
 static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
-					    const struct tee_param *p)
+					    const struct tee_param *p,
+					    bool update_out)
 {
-	mp->attr =3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
-		   TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
-	mp->u.value.a =3D p->u.value.a;
-	mp->u.value.b =3D p->u.value.b;
-	mp->u.value.c =3D p->u.value.c;
+	if (!update_out)
+		mp->attr =3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
+			   TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+
+	if (p->attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT ||
+	    p->attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT || !update_out) {
+		mp->u.value.a =3D p->u.value.a;
+		mp->u.value.b =3D p->u.value.b;
+		mp->u.value.c =3D p->u.value.c;
+	}
 }
=20
 void optee_cq_init(struct optee_call_queue *cq, int thread_count);
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index ebbbd42b0e3e..580e6b9b0606 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -63,7 +63,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_con=
text *ctx,
 	}
=20
 	if (optee->ops->from_msg_param(optee, params, arg->num_params,
-				       arg->params))
+				       arg->params, false /*!update_out*/))
 		goto bad;
=20
 	for (i =3D 0; i < arg->num_params; i++) {
@@ -107,7 +107,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_c=
ontext *ctx,
 	} else {
 		params[3].u.value.a =3D msg.len;
 		if (optee->ops->to_msg_param(optee, arg->params,
-					     arg->num_params, params))
+					     arg->num_params, params,
+					     true /*update_out*/))
 			arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 		else
 			arg->ret =3D TEEC_SUCCESS;
@@ -188,6 +189,7 @@ static void handle_rpc_func_cmd_wait(struct optee_msg_arg=
 *arg)
 static void handle_rpc_supp_cmd(struct tee_context *ctx, struct optee *optee,
 				struct optee_msg_arg *arg)
 {
+	bool update_out =3D false;
 	struct tee_param *params;
=20
 	arg->ret_origin =3D TEEC_ORIGIN_COMMS;
@@ -200,15 +202,21 @@ static void handle_rpc_supp_cmd(struct tee_context *ctx=
, struct optee *optee,
 	}
=20
 	if (optee->ops->from_msg_param(optee, params, arg->num_params,
-				       arg->params)) {
+				       arg->params, update_out)) {
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 		goto out;
 	}
=20
 	arg->ret =3D optee_supp_thrd_req(ctx, arg->cmd, arg->num_params, params);
=20
+	/*
+	 * Special treatment for OPTEE_RPC_CMD_SHM_ALLOC since input is a
+	 * value type, but the output is a memref type.
+	 */
+	if (arg->cmd !=3D OPTEE_RPC_CMD_SHM_ALLOC)
+		update_out =3D true;
 	if (optee->ops->to_msg_param(optee, arg->params, arg->num_params,
-				     params))
+				     params, update_out))
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 out:
 	kfree(params);
@@ -270,7 +278,7 @@ static void handle_rpc_func_rpmb_probe_reset(struct tee_c=
ontext *ctx,
=20
 	if (arg->num_params !=3D ARRAY_SIZE(params) ||
 	    optee->ops->from_msg_param(optee, params, arg->num_params,
-				       arg->params) ||
+				       arg->params, false /*!update_out*/) ||
 	    params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT) {
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 		return;
@@ -280,7 +288,8 @@ static void handle_rpc_func_rpmb_probe_reset(struct tee_c=
ontext *ctx,
 	params[0].u.value.b =3D 0;
 	params[0].u.value.c =3D 0;
 	if (optee->ops->to_msg_param(optee, arg->params,
-				     arg->num_params, params)) {
+				     arg->num_params, params,
+				     true /*update_out*/)) {
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 		return;
 	}
@@ -324,7 +333,7 @@ static void handle_rpc_func_rpmb_probe_next(struct tee_co=
ntext *ctx,
=20
 	if (arg->num_params !=3D ARRAY_SIZE(params) ||
 	    optee->ops->from_msg_param(optee, params, arg->num_params,
-				       arg->params) ||
+				       arg->params, false /*!update_out*/) ||
 	    params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT ||
 	    params[1].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
@@ -358,7 +367,8 @@ static void handle_rpc_func_rpmb_probe_next(struct tee_co=
ntext *ctx,
 	params[0].u.value.b =3D rdev->descr.capacity;
 	params[0].u.value.c =3D rdev->descr.reliable_wr_count;
 	if (optee->ops->to_msg_param(optee, arg->params,
-				     arg->num_params, params)) {
+				     arg->num_params, params,
+				     true /*update_out*/)) {
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 		return;
 	}
@@ -384,7 +394,7 @@ static void handle_rpc_func_rpmb_frames(struct tee_contex=
t *ctx,
=20
 	if (arg->num_params !=3D ARRAY_SIZE(params) ||
 	    optee->ops->from_msg_param(optee, params, arg->num_params,
-				       arg->params) ||
+				       arg->params, false /*!update_out*/) ||
 	    params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT ||
 	    params[1].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
@@ -401,7 +411,8 @@ static void handle_rpc_func_rpmb_frames(struct tee_contex=
t *ctx,
 		goto out;
 	}
 	if (optee->ops->to_msg_param(optee, arg->params,
-				     arg->num_params, params)) {
+				     arg->num_params, params,
+				     true /*update_out*/)) {
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 		goto out;
 	}
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index f0c3ac1103bb..e5b190d64a49 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -81,20 +81,26 @@ static int optee_cpuhp_disable_pcpu_irq(unsigned int cpu)
  */
=20
 static int from_msg_param_tmp_mem(struct tee_param *p, u32 attr,
-				  const struct optee_msg_param *mp)
+				  const struct optee_msg_param *mp,
+				  bool update_out)
 {
 	struct tee_shm *shm;
 	phys_addr_t pa;
 	int rc;
=20
+	if (update_out) {
+		if (attr =3D=3D OPTEE_MSG_ATTR_TYPE_TMEM_INPUT)
+			return 0;
+		goto out;
+	}
+
 	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
 		  attr - OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
-	p->u.memref.size =3D mp->u.tmem.size;
 	shm =3D (struct tee_shm *)(unsigned long)mp->u.tmem.shm_ref;
 	if (!shm) {
 		p->u.memref.shm_offs =3D 0;
 		p->u.memref.shm =3D NULL;
-		return 0;
+		goto out;
 	}
=20
 	rc =3D tee_shm_get_pa(shm, 0, &pa);
@@ -103,18 +109,25 @@ static int from_msg_param_tmp_mem(struct tee_param *p, =
u32 attr,
=20
 	p->u.memref.shm_offs =3D mp->u.tmem.buf_ptr - pa;
 	p->u.memref.shm =3D shm;
-
+out:
+	p->u.memref.size =3D mp->u.tmem.size;
 	return 0;
 }
=20
 static void from_msg_param_reg_mem(struct tee_param *p, u32 attr,
-				   const struct optee_msg_param *mp)
+				   const struct optee_msg_param *mp,
+				   bool update_out)
 {
 	struct tee_shm *shm;
=20
+	if (update_out) {
+		if (attr =3D=3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT)
+			return;
+		goto out;
+	}
+
 	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
 		  attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
-	p->u.memref.size =3D mp->u.rmem.size;
 	shm =3D (struct tee_shm *)(unsigned long)mp->u.rmem.shm_ref;
=20
 	if (shm) {
@@ -124,6 +137,8 @@ static void from_msg_param_reg_mem(struct tee_param *p, u=
32 attr,
 		p->u.memref.shm_offs =3D 0;
 		p->u.memref.shm =3D NULL;
 	}
+out:
+	p->u.memref.size =3D mp->u.rmem.size;
 }
=20
 /**
@@ -133,11 +148,13 @@ static void from_msg_param_reg_mem(struct tee_param *p,=
 u32 attr,
  * @params:	subsystem internal parameter representation
  * @num_params:	number of elements in the parameter arrays
  * @msg_params:	OPTEE_MSG parameters
+ * @update_out:	update parameter for output only
  * Returns 0 on success or <0 on failure
  */
 static int optee_from_msg_param(struct optee *optee, struct tee_param *param=
s,
 				size_t num_params,
-				const struct optee_msg_param *msg_params)
+				const struct optee_msg_param *msg_params,
+				bool update_out)
 {
 	int rc;
 	size_t n;
@@ -149,25 +166,27 @@ static int optee_from_msg_param(struct optee *optee, st=
ruct tee_param *params,
=20
 		switch (attr) {
 		case OPTEE_MSG_ATTR_TYPE_NONE:
+			if (update_out)
+				break;
 			p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
 			memset(&p->u, 0, sizeof(p->u));
 			break;
 		case OPTEE_MSG_ATTR_TYPE_VALUE_INPUT:
 		case OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT:
 		case OPTEE_MSG_ATTR_TYPE_VALUE_INOUT:
-			optee_from_msg_param_value(p, attr, mp);
+			optee_from_msg_param_value(p, attr, mp, update_out);
 			break;
 		case OPTEE_MSG_ATTR_TYPE_TMEM_INPUT:
 		case OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT:
 		case OPTEE_MSG_ATTR_TYPE_TMEM_INOUT:
-			rc =3D from_msg_param_tmp_mem(p, attr, mp);
+			rc =3D from_msg_param_tmp_mem(p, attr, mp, update_out);
 			if (rc)
 				return rc;
 			break;
 		case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
 		case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
 		case OPTEE_MSG_ATTR_TYPE_RMEM_INOUT:
-			from_msg_param_reg_mem(p, attr, mp);
+			from_msg_param_reg_mem(p, attr, mp, update_out);
 			break;
=20
 		default:
@@ -178,20 +197,25 @@ static int optee_from_msg_param(struct optee *optee, st=
ruct tee_param *params,
 }
=20
 static int to_msg_param_tmp_mem(struct optee_msg_param *mp,
-				const struct tee_param *p)
+				const struct tee_param *p, bool update_out)
 {
 	int rc;
 	phys_addr_t pa;
=20
+	if (update_out) {
+		if (p->attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT)
+			return 0;
+		goto out;
+	}
+
 	mp->attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_INPUT + p->attr -
 		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
=20
 	mp->u.tmem.shm_ref =3D (unsigned long)p->u.memref.shm;
-	mp->u.tmem.size =3D p->u.memref.size;
=20
 	if (!p->u.memref.shm) {
 		mp->u.tmem.buf_ptr =3D 0;
-		return 0;
+		goto out;
 	}
=20
 	rc =3D tee_shm_get_pa(p->u.memref.shm, p->u.memref.shm_offs, &pa);
@@ -201,19 +225,27 @@ static int to_msg_param_tmp_mem(struct optee_msg_param =
*mp,
 	mp->u.tmem.buf_ptr =3D pa;
 	mp->attr |=3D OPTEE_MSG_ATTR_CACHE_PREDEFINED <<
 		    OPTEE_MSG_ATTR_CACHE_SHIFT;
-
+out:
+	mp->u.tmem.size =3D p->u.memref.size;
 	return 0;
 }
=20
 static int to_msg_param_reg_mem(struct optee_msg_param *mp,
-				const struct tee_param *p)
+				const struct tee_param *p, bool update_out)
 {
+	if (update_out) {
+		if (p->attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT)
+			return 0;
+		goto out;
+	}
+
 	mp->attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT + p->attr -
 		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
=20
 	mp->u.rmem.shm_ref =3D (unsigned long)p->u.memref.shm;
-	mp->u.rmem.size =3D p->u.memref.size;
 	mp->u.rmem.offs =3D p->u.memref.shm_offs;
+out:
+	mp->u.rmem.size =3D p->u.memref.size;
 	return 0;
 }
=20
@@ -223,11 +255,13 @@ static int to_msg_param_reg_mem(struct optee_msg_param =
*mp,
  * @msg_params:	OPTEE_MSG parameters
  * @num_params:	number of elements in the parameter arrays
  * @params:	subsystem itnernal parameter representation
+ * @update_out:	update parameter for output only
  * Returns 0 on success or <0 on failure
  */
 static int optee_to_msg_param(struct optee *optee,
 			      struct optee_msg_param *msg_params,
-			      size_t num_params, const struct tee_param *params)
+			      size_t num_params, const struct tee_param *params,
+			      bool update_out)
 {
 	int rc;
 	size_t n;
@@ -238,21 +272,23 @@ static int optee_to_msg_param(struct optee *optee,
=20
 		switch (p->attr) {
 		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
+			if (update_out)
+				break;
 			mp->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
 			memset(&mp->u, 0, sizeof(mp->u));
 			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
-			optee_to_msg_param_value(mp, p);
+			optee_to_msg_param_value(mp, p, update_out);
 			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			if (tee_shm_is_dynamic(p->u.memref.shm))
-				rc =3D to_msg_param_reg_mem(mp, p);
+				rc =3D to_msg_param_reg_mem(mp, p, update_out);
 			else
-				rc =3D to_msg_param_tmp_mem(mp, p);
+				rc =3D to_msg_param_tmp_mem(mp, p, update_out);
 			if (rc)
 				return rc;
 			break;
--=20
2.43.0


--===============0828164484150076190==--

