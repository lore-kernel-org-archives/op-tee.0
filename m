From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 05/12] tee: replace tee_shm_alloc()
Date: Tue, 25 Jan 2022 17:29:31 +0100
Message-ID: <20220125162938.838382-6-jens.wiklander@linaro.org>
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0631138508340655795=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0631138508340655795==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

tee_shm_alloc() is replaced by three new functions,

tee_shm_alloc_user_buf() - for user mode allocations, replacing passing
the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF

tee_shm_alloc_kernel_buf() - for kernel mode allocations, slightly
optimized compared to using the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF.

tee_shm_alloc_priv_kernel_buf() - primarily for TEE driver internal use.

This also makes the interface easier to use as we can get rid of the
somewhat hard to use flags parameter.

The TEE subsystem and the TEE drivers are updated to use the new
functions instead.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c    |   2 +-
 drivers/tee/optee/device.c  |   5 +-
 drivers/tee/optee/ffa_abi.c |   3 +-
 drivers/tee/optee/smc_abi.c |   5 +-
 drivers/tee/tee_shm.c       | 108 +++++++++++++++++++++++-------------
 include/linux/tee_drv.h     |  16 +-----
 6 files changed, 75 insertions(+), 64 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index b25cc1fac945..bd49ec934060 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -120,7 +120,7 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx=
, size_t num_params,
 	if (optee->rpc_arg_count)
 		sz +=3D OPTEE_MSG_GET_ARG_SIZE(optee->rpc_arg_count);
=20
-	shm =3D tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED | TEE_SHM_PRIV);
+	shm =3D tee_shm_alloc_priv_buf(ctx, sz);
 	if (IS_ERR(shm))
 		return shm;
=20
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 128a2d2a50a1..f3947be13e2e 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -121,10 +121,9 @@ static int __optee_enumerate_devices(u32 func)
 	if (rc < 0 || !shm_size)
 		goto out_sess;
=20
-	device_shm =3D tee_shm_alloc(ctx, shm_size,
-				   TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	device_shm =3D tee_shm_alloc_kernel_buf(ctx, shm_size);
 	if (IS_ERR(device_shm)) {
-		pr_err("tee_shm_alloc failed\n");
+		pr_err("tee_shm_alloc_kernel_buf failed\n");
 		rc =3D PTR_ERR(device_shm);
 		goto out_sess;
 	}
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index e690d9420966..d71880ede6d6 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -439,8 +439,7 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_=
context *ctx,
 		shm =3D optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm =3D tee_shm_alloc(ctx, arg->params[0].u.value.b,
-				    TEE_SHM_MAPPED | TEE_SHM_PRIV);
+		shm =3D tee_shm_alloc_priv_buf(ctx, arg->params[0].u.value.b);
 		break;
 	default:
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index b679037ea794..66d5d1b56b95 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -650,7 +650,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_cont=
ext *ctx,
 		shm =3D optee_rpc_cmd_alloc_suppl(ctx, sz);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm =3D tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED | TEE_SHM_PRIV);
+		shm =3D tee_shm_alloc_priv_buf(ctx, sz);
 		break;
 	default:
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
@@ -775,8 +775,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
=20
 	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
 	case OPTEE_SMC_RPC_FUNC_ALLOC:
-		shm =3D tee_shm_alloc(ctx, param->a1,
-				    TEE_SHM_MAPPED | TEE_SHM_PRIV);
+		shm =3D tee_shm_alloc_priv_buf(ctx, param->a1);
 		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
 			reg_pair_from_64(&param->a1, &param->a2, pa);
 			reg_pair_from_64(&param->a4, &param->a5,
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index f0a9cccd2f2c..dc02afd7b5c9 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -49,25 +49,14 @@ static void tee_shm_release(struct tee_device *teedev, st=
ruct tee_shm *shm)
 	tee_device_put(teedev);
 }
=20
-struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flag=
s)
+static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
+					size_t align, u32 flags, int id)
 {
 	struct tee_device *teedev =3D ctx->teedev;
 	struct tee_shm *shm;
-	size_t align;
 	void *ret;
 	int rc;
=20
-	if (!(flags & TEE_SHM_MAPPED)) {
-		dev_err(teedev->dev.parent,
-			"only mapped allocations supported\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_PRIV))) {
-		dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (!tee_device_get(teedev))
 		return ERR_PTR(-EINVAL);
=20
@@ -84,18 +73,16 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, si=
ze_t size, u32 flags)
 	}
=20
 	refcount_set(&shm->refcount, 1);
-	shm->flags =3D flags | TEE_SHM_POOL;
+	shm->flags =3D flags;
+	shm->id =3D id;
+
+	/*
+	 * We're assigning this as it is needed if the shm is to be
+	 * registered. If this function returns OK then the caller expected
+	 * to call teedev_ctx_get() or clear shm->ctx in case it's not
+	 * needed any longer.
+	 */
 	shm->ctx =3D ctx;
-	if (flags & TEE_SHM_DMA_BUF) {
-		align =3D PAGE_SIZE;
-		/*
-		 * Request to register the shm in the pool allocator below
-		 * if supported.
-		 */
-		shm->flags |=3D TEE_SHM_REGISTER;
-	} else {
-		align =3D 2 * sizeof(long);
-	}
=20
 	rc =3D teedev->pool->ops->alloc(teedev->pool, shm, size, align);
 	if (rc) {
@@ -103,28 +90,14 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, s=
ize_t size, u32 flags)
 		goto err_kfree;
 	}
=20
-	if (flags & TEE_SHM_DMA_BUF) {
-		mutex_lock(&teedev->mutex);
-		shm->id =3D idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
-		mutex_unlock(&teedev->mutex);
-		if (shm->id < 0) {
-			ret =3D ERR_PTR(shm->id);
-			goto err_pool_free;
-		}
-	}
-
 	teedev_ctx_get(ctx);
-
 	return shm;
-err_pool_free:
-	teedev->pool->ops->free(teedev->pool, shm);
 err_kfree:
 	kfree(shm);
 err_dev_put:
 	tee_device_put(teedev);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(tee_shm_alloc);
=20
 /**
  * tee_shm_alloc_user_buf() - Allocate shared memory for user space
@@ -140,7 +113,36 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
  */
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
 {
-	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER |
+		    TEE_SHM_POOL;
+	struct tee_device *teedev =3D ctx->teedev;
+	struct tee_shm *shm;
+	void *ret;
+	int id;
+
+	mutex_lock(&teedev->mutex);
+	id =3D idr_alloc(&teedev->idr, NULL, 1, 0, GFP_KERNEL);
+	mutex_unlock(&teedev->mutex);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	shm =3D shm_alloc_helper(ctx, size, PAGE_SIZE, flags, id);
+	if (IS_ERR(shm)) {
+		mutex_lock(&teedev->mutex);
+		idr_remove(&teedev->idr, id);
+		mutex_unlock(&teedev->mutex);
+		return shm;
+	}
+
+	mutex_lock(&teedev->mutex);
+	ret =3D idr_replace(&teedev->idr, shm, id);
+	mutex_unlock(&teedev->mutex);
+	if (IS_ERR(ret)) {
+		tee_shm_free(shm);
+		return ret;
+	}
+
+	return shm;
 }
=20
 /**
@@ -157,10 +159,36 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_conte=
xt *ctx, size_t size)
  */
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t siz=
e)
 {
-	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED);
+	u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_REGISTER | TEE_SHM_POOL;
+
+	return shm_alloc_helper(ctx, size, PAGE_SIZE, flags, -1);
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
=20
+/**
+ * tee_shm_alloc_priv_buf() - Allocate shared memory for a privatly shared
+ *			      kernel buffer
+ * @ctx:	Context that allocates the shared memory
+ * @size:	Requested size of shared memory
+ *
+ * This function returns similar shared memory as
+ * tee_shm_alloc_kernel_buf(), but with the difference that the memory
+ * might not be registered in secure world in case the driver supports
+ * passing memory not registered in advance.
+ *
+ * This function should normally only be used internally in the TEE
+ * drivers.
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
+{
+	u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_PRIV | TEE_SHM_POOL;
+
+	return shm_alloc_helper(ctx, size, sizeof(long) * 2, flags, -1);
+}
+EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
+
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index ed641dc314bd..7f038f8787c7 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -273,21 +273,7 @@ static inline void tee_shm_pool_free(struct tee_shm_pool=
 *pool)
  */
 void *tee_get_drvdata(struct tee_device *teedev);
=20
-/**
- * tee_shm_alloc() - Allocate shared memory
- * @ctx:	Context that allocates the shared memory
- * @size:	Requested size of shared memory
- * @flags:	Flags setting properties for the requested shared memory.
- *
- * Memory allocated as global shared memory is automatically freed when the
- * TEE file pointer is closed. The @flags field uses the bits defined by
- * TEE_SHM_* above. TEE_SHM_MAPPED must currently always be set. If
- * TEE_SHM_DMA_BUF global shared memory will be allocated and associated
- * with a dma-buf handle, else driver private memory.
- *
- * @returns a pointer to 'struct tee_shm'
- */
-struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flag=
s);
+struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t siz=
e);
=20
 /**
--=20
2.31.1


--===============0631138508340655795==--

