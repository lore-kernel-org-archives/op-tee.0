From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v7 11/11] optee: smc abi: dynamic protected memory allocation
Date: Fri, 04 Apr 2025 16:31:34 +0200
Message-ID: <20250404143215.2281034-12-jens.wiklander@linaro.org>
In-Reply-To: <20250404143215.2281034-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5860736400685138987=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5860736400685138987==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add support in the OP-TEE backend driver for dynamic protected memory
allocation using the SMC ABI.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/smc_abi.c | 102 ++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 17 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index c10b38b23586..dd9887826590 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1001,6 +1001,70 @@ static int optee_smc_do_call_with_arg(struct tee_conte=
xt *ctx,
 	return rc;
 }
=20
+static int optee_smc_lend_protmem(struct optee *optee, struct tee_shm *protm=
em,
+				  u16 *end_points, unsigned int ep_count,
+				  u32 use_case)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg =3D optee_get_msg_arg(optee->ctx, 2, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd =3D OPTEE_MSG_CMD_LEND_PROTMEM;
+	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+	msg_arg->params[0].u.value.a =3D use_case;
+	msg_arg->params[1].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
+	msg_arg->params[1].u.tmem.buf_ptr =3D protmem->paddr;
+	msg_arg->params[1].u.tmem.size =3D protmem->size;
+	msg_arg->params[1].u.tmem.shm_ref =3D (u_long)protmem;
+
+	rc =3D optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret !=3D TEEC_SUCCESS) {
+		rc =3D -EINVAL;
+		goto out;
+	}
+	protmem->sec_world_id =3D (u_long)protmem;
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
+static int optee_smc_reclaim_protmem(struct optee *optee,
+				     struct tee_shm *protmem)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg =3D optee_get_msg_arg(optee->ctx, 1, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd =3D OPTEE_MSG_CMD_RECLAIM_PROTMEM;
+	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
+	msg_arg->params[0].u.rmem.shm_ref =3D (u_long)protmem;
+
+	rc =3D optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret !=3D TEEC_SUCCESS)
+		rc =3D -EINVAL;
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
 /*
  * 5. Asynchronous notification
  */
@@ -1252,6 +1316,8 @@ static const struct optee_ops optee_ops =3D {
 	.do_call_with_arg =3D optee_smc_do_call_with_arg,
 	.to_msg_param =3D optee_to_msg_param,
 	.from_msg_param =3D optee_from_msg_param,
+	.lend_protmem =3D optee_smc_lend_protmem,
+	.reclaim_protmem =3D optee_smc_reclaim_protmem,
 };
=20
 static int enable_async_notif(optee_invoke_fn *invoke_fn)
@@ -1620,13 +1686,16 @@ static inline int optee_load_fw(struct platform_devic=
e *pdev,
 }
 #endif
=20
-static int optee_rstmem_pool_init(struct optee *optee)
+static int optee_protmem_pool_init(struct optee *optee)
 {
+	bool protm =3D optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM;
+	bool dyn_protm =3D optee->smc.sec_caps &
+			 OPTEE_SMC_SEC_CAP_DYNAMIC_PROTMEM;
 	enum tee_dma_heap_id heap_id =3D TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
-	struct tee_protmem_pool *pool;
-	int rc;
+	struct tee_protmem_pool *pool =3D ERR_PTR(-EINVAL);
+	int rc =3D -EINVAL;
=20
-	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM) {
+	if (protm) {
 		union {
 			struct arm_smccc_res smccc;
 			struct optee_smc_get_protmem_config_result result;
@@ -1634,25 +1703,24 @@ static int optee_rstmem_pool_init(struct optee *optee)
=20
 		optee->smc.invoke_fn(OPTEE_SMC_GET_PROTMEM_CONFIG, 0, 0, 0, 0,
 				     0, 0, 0, &res.smccc);
-		if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
-			pr_err("Secure Data Path service not available\n");
-			return 0;
-		}
+		if (res.result.status =3D=3D OPTEE_SMC_RETURN_OK)
+			pool =3D tee_protmem_static_pool_alloc(res.result.start,
+							     res.result.size);
+	}
=20
-		pool =3D tee_protmem_static_pool_alloc(res.result.start,
-						     res.result.size);
-		if (IS_ERR(pool))
-			return PTR_ERR(pool);
+	if (dyn_protm && IS_ERR(pool))
+		pool =3D optee_protmem_alloc_cma_pool(optee, heap_id);
=20
+	if (!IS_ERR(pool)) {
 		rc =3D tee_device_register_dma_heap(optee->teedev, heap_id, pool);
 		if (rc)
-			goto err;
+			pool->ops->destroy_pool(pool);
 	}
=20
+	if (rc && (protm || dyn_protm))
+		pr_info("Protected memory service not available\n");
+
 	return 0;
-err:
-	pool->ops->destroy_pool(pool);
-	return rc;
 }
=20
 static int optee_probe(struct platform_device *pdev)
@@ -1823,7 +1891,7 @@ static int optee_probe(struct platform_device *pdev)
 		pr_info("Asynchronous notifications enabled\n");
 	}
=20
-	rc =3D optee_rstmem_pool_init(optee);
+	rc =3D optee_protmem_pool_init(optee);
 	if (rc)
 		goto err_notif_uninit;
=20
--=20
2.43.0


--===============5860736400685138987==--

