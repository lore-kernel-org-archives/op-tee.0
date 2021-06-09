From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 7/7] tee: replace tee_shm_alloc()
Date: Wed, 09 Jun 2021 12:23:24 +0200
Message-ID: <20210609102324.2222332-8-jens.wiklander@linaro.org>
In-Reply-To: <20210609102324.2222332-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2912854728837674231=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2912854728837674231==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

tee_shm_alloc() is replaced by three new functions,

tee_shm_alloc_user_buf() - for user mode allocations, replacing passing
the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF

tee_shm_alloc_kernel_buf() - for kernel mode allocations, slightly
optimized compared to using the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF
since we now can avoid using the dma-buf registration.

tee_shm_alloc_anon_kernel_buf() - for TEE driver internal use only
allowing decoupling a shared memory object from its original
tee_context.

This also makes the interface easier to use as we can get rid of the
somewhat hard to use flags parameter.

The TEE subsystem and the TEE drivers are updated to use the new
functions instead.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c   |  16 ++--
 drivers/tee/optee/core.c   |   4 +-
 drivers/tee/optee/device.c |   5 +-
 drivers/tee/optee/rpc.c    |   8 +-
 drivers/tee/tee_core.c     |   2 +-
 drivers/tee/tee_shm.c      | 186 +++++++++++++++++++++++++++----------
 include/linux/tee_drv.h    |  19 +---
 7 files changed, 156 insertions(+), 84 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 6132cc8d014c..f31257649c0e 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -183,8 +183,8 @@ static struct tee_shm *get_msg_arg(struct tee_context *ct=
x, size_t num_params,
 	struct tee_shm *shm;
 	struct optee_msg_arg *ma;
=20
-	shm =3D tee_shm_alloc(ctx, OPTEE_MSG_GET_ARG_SIZE(num_params),
-			    TEE_SHM_MAPPED);
+	shm =3D tee_shm_alloc_anon_kernel_buf(ctx,
+					    OPTEE_MSG_GET_ARG_SIZE(num_params));
 	if (IS_ERR(shm))
 		return shm;
=20
@@ -281,7 +281,7 @@ int optee_open_session(struct tee_context *ctx,
 		arg->ret_origin =3D msg_arg->ret_origin;
 	}
 out:
-	tee_shm_free(shm);
+	tee_shm_free_anon_kernel_buf(ctx, shm);
=20
 	return rc;
 }
@@ -312,7 +312,7 @@ int optee_close_session(struct tee_context *ctx, u32 sess=
ion)
 	msg_arg->session =3D session;
 	optee_do_call_with_arg(ctx, msg_parg);
=20
-	tee_shm_free(shm);
+	tee_shm_free_anon_kernel_buf(ctx, shm);
 	return 0;
 }
=20
@@ -358,7 +358,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee=
_ioctl_invoke_arg *arg,
 	arg->ret =3D msg_arg->ret;
 	arg->ret_origin =3D msg_arg->ret_origin;
 out:
-	tee_shm_free(shm);
+	tee_shm_free_anon_kernel_buf(ctx, shm);
 	return rc;
 }
=20
@@ -386,7 +386,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_=
id, u32 session)
 	msg_arg->cancel_id =3D cancel_id;
 	optee_do_call_with_arg(ctx, msg_parg);
=20
-	tee_shm_free(shm);
+	tee_shm_free_anon_kernel_buf(ctx, shm);
 	return 0;
 }
=20
@@ -625,7 +625,7 @@ int optee_shm_register(struct tee_context *ctx, struct te=
e_shm *shm,
 	    msg_arg->ret !=3D TEEC_SUCCESS)
 		rc =3D -EINVAL;
=20
-	tee_shm_free(shm_arg);
+	tee_shm_free_anon_kernel_buf(ctx, shm_arg);
 out:
 	optee_free_pages_list(pages_list, num_pages);
 	return rc;
@@ -650,7 +650,7 @@ int optee_shm_unregister(struct tee_context *ctx, struct =
tee_shm *shm)
 	if (optee_do_call_with_arg(ctx, msg_parg) ||
 	    msg_arg->ret !=3D TEEC_SUCCESS)
 		rc =3D -EINVAL;
-	tee_shm_free(shm_arg);
+	tee_shm_free_anon_kernel_buf(ctx, shm_arg);
 	return rc;
 }
=20
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 0c287345f9fe..a15dc3881636 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -277,7 +277,7 @@ static void optee_release(struct tee_context *ctx)
 	if (!ctxdata)
 		return;
=20
-	shm =3D tee_shm_alloc(ctx, sizeof(struct optee_msg_arg), TEE_SHM_MAPPED);
+	shm =3D tee_shm_alloc_anon_kernel_buf(ctx, sizeof(struct optee_msg_arg));
 	if (!IS_ERR(shm)) {
 		arg =3D tee_shm_get_va(shm, 0);
 		/*
@@ -305,7 +305,7 @@ static void optee_release(struct tee_context *ctx)
 	kfree(ctxdata);
=20
 	if (!IS_ERR(shm))
-		tee_shm_free(shm);
+		tee_shm_free_anon_kernel_buf(ctx, shm);
=20
 	ctx->data =3D NULL;
=20
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index ec1d24693eba..5a5bf86b1b95 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -113,10 +113,9 @@ static int __optee_enumerate_devices(u32 func)
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
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 1849180b0278..9108aedb3eee 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -314,7 +314,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_cont=
ext *ctx,
 		shm =3D cmd_alloc_suppl(ctx, sz);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm =3D tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED);
+		shm =3D tee_shm_alloc_anon_kernel_buf(ctx, sz);
 		break;
 	default:
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
@@ -424,7 +424,7 @@ static void handle_rpc_func_cmd_shm_free(struct tee_conte=
xt *ctx,
 		cmd_free_suppl(ctx, shm);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		tee_shm_free(shm);
+		tee_shm_free_anon_kernel_buf(ctx, shm);
 		break;
 	default:
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
@@ -502,7 +502,7 @@ void optee_handle_rpc(struct tee_context *ctx, struct opt=
ee_rpc_param *param,
=20
 	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
 	case OPTEE_SMC_RPC_FUNC_ALLOC:
-		shm =3D tee_shm_alloc(ctx, param->a1, TEE_SHM_MAPPED);
+		shm =3D tee_shm_alloc_anon_kernel_buf(ctx, param->a1);
 		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
 			reg_pair_from_64(&param->a1, &param->a2, pa);
 			reg_pair_from_64(&param->a4, &param->a5,
@@ -516,7 +516,7 @@ void optee_handle_rpc(struct tee_context *ctx, struct opt=
ee_rpc_param *param,
 		break;
 	case OPTEE_SMC_RPC_FUNC_FREE:
 		shm =3D reg_pair_to_ptr(param->a1, param->a2);
-		tee_shm_free(shm);
+		tee_shm_free_anon_kernel_buf(ctx, shm);
 		break;
 	case OPTEE_SMC_RPC_FUNC_FOREIGN_INTR:
 		/*
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 480d294a23ab..4f5c7c17a434 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -293,7 +293,7 @@ static int tee_ioctl_shm_alloc(struct tee_context *ctx,
 	if (data.flags)
 		return -EINVAL;
=20
-	shm =3D tee_shm_alloc(ctx, data.size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	shm =3D tee_shm_alloc_user_buf(ctx, data.size);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
=20
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 63fce8d39d8b..d134e2778a3a 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -96,25 +96,14 @@ static const struct dma_buf_ops tee_shm_dma_buf_ops =3D {
 	.mmap =3D tee_shm_op_mmap,
 };
=20
-struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flag=
s)
+static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
+					size_t align, u32 flags)
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
-	if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
-		dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (!tee_device_get(teedev))
 		return ERR_PTR(-EINVAL);
=20
@@ -131,17 +120,14 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, =
size_t size, u32 flags)
 	}
=20
 	shm->flags =3D flags | TEE_SHM_POOL;
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
@@ -149,48 +135,71 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, =
size_t size, u32 flags)
 		goto err_kfree;
 	}
=20
+	return shm;
+err_kfree:
+	kfree(shm);
+err_dev_put:
+	tee_device_put(teedev);
+	return ret;
+}
=20
-	if (flags & TEE_SHM_DMA_BUF) {
-		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+/**
+ * tee_shm_alloc_user_buf() - Allocate shared memory for user space
+ * @ctx:	Context that allocates the shared memory
+ * @size:	Requested size of shared memory
+ *
+ * Memory allocated as user space shared memory is automatically freed when
+ * the TEE file pointer is closed. The primary usage of this function is
+ * when the TEE driver doesn't support registering ordinary user space
+ * memory.
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
+{
+	u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER;
+	struct tee_device *teedev =3D ctx->teedev;
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct tee_shm *shm;
+	void *ret;
=20
-		mutex_lock(&teedev->mutex);
-		shm->id =3D idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
-		mutex_unlock(&teedev->mutex);
-		if (shm->id < 0) {
-			ret =3D ERR_PTR(shm->id);
-			goto err_pool_free;
-		}
+	shm =3D shm_alloc_helper(ctx, size, PAGE_SIZE, flags);
+	if (IS_ERR(shm))
+		return shm;
=20
-		exp_info.ops =3D &tee_shm_dma_buf_ops;
-		exp_info.size =3D shm->size;
-		exp_info.flags =3D O_RDWR;
-		exp_info.priv =3D shm;
+	mutex_lock(&teedev->mutex);
+	shm->id =3D idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
+	mutex_unlock(&teedev->mutex);
+	if (shm->id < 0) {
+		ret =3D ERR_PTR(shm->id);
+		goto err_pool_free;
+	}
=20
-		shm->dmabuf =3D dma_buf_export(&exp_info);
-		if (IS_ERR(shm->dmabuf)) {
-			ret =3D ERR_CAST(shm->dmabuf);
-			goto err_rem;
-		}
+	exp_info.ops =3D &tee_shm_dma_buf_ops;
+	exp_info.size =3D shm->size;
+	exp_info.flags =3D O_RDWR;
+	exp_info.priv =3D shm;
+
+	shm->dmabuf =3D dma_buf_export(&exp_info);
+	if (IS_ERR(shm->dmabuf)) {
+		ret =3D ERR_CAST(shm->dmabuf);
+		goto err_rem;
 	}
=20
 	teedev_ctx_get(ctx);
-
 	return shm;
 err_rem:
-	if (flags & TEE_SHM_DMA_BUF) {
-		mutex_lock(&teedev->mutex);
-		idr_remove(&teedev->idr, shm->id);
-		mutex_unlock(&teedev->mutex);
-	}
+	mutex_lock(&teedev->mutex);
+	idr_remove(&teedev->idr, shm->id);
+	mutex_unlock(&teedev->mutex);
 err_pool_free:
 	teedev->pool->ops->free(teedev->pool, shm);
-err_kfree:
 	kfree(shm);
-err_dev_put:
 	tee_device_put(teedev);
 	return ret;
+
 }
-EXPORT_SYMBOL_GPL(tee_shm_alloc);
+EXPORT_SYMBOL_GPL(tee_shm_alloc_user_buf);
=20
 /**
  * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
@@ -206,10 +215,85 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
  */
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t siz=
e)
 {
-	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_REGISTER;
+	struct tee_shm *shm;
+
+	shm =3D shm_alloc_helper(ctx, size, PAGE_SIZE, flags);
+	if (IS_ERR(shm))
+		return shm;
+
+	teedev_ctx_get(ctx);
+	return shm;
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
=20
+/**
+ * tee_shm_alloc_anon_kernel_buf() - Allocate shared memory for anonymous
+ *				     kernel buffer
+ * @ctx:	Context that allocates the shared memory
+ * @size:	Requested size of shared memory
+ *
+ * This function returns similar shared memory as tee_shm_alloc_kernel_buf(),
+ * but with two differences:
+ * 1. The memory might not be registered in secure world
+ *    in case the driver supports passing memory not registered in advance.
+ * 2. The memory is not directly associated with the passed tee_context,
+ *    rather the tee_device used by the context.
+ *
+ * This function should normally only be used internally in the TEE
+ * drivers. The memory must later only be freed using
+ * tee_shm_free_anon_kernel_buf() with a tee_contex with the same internal
+ * tee_device as when the memory was allocated.
+ *
+ * This allows allocating the shared memory using one context which is
+ * destroyed while the memory continues to live and finally freed using
+ * another context.
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc_anon_kernel_buf(struct tee_context *ctx,
+					      size_t size)
+{
+	struct tee_shm *shm;
+
+	shm =3D shm_alloc_helper(ctx, size, sizeof(long) * 2, TEE_SHM_MAPPED);
+	if (IS_ERR(shm))
+		return shm;
+
+	shm->ctx =3D NULL;
+	return shm;
+}
+EXPORT_SYMBOL_GPL(tee_shm_alloc_anon_kernel_buf);
+
+/**
+ * tee_shm_free_anon_kernel_buf() - Free anonymous shared kernel memory
+ * @ctx:	Borrowed context when freeing the shared memory
+ * @shm:	Handle to shared memory to free
+ *
+ * This function must only be used to free a tee_shm allocated with
+ * tee_shm_alloc_anon_kernel_buf(). The passed @ctx has to have the same
+ * internal tee_device as was used by the tee_context passed when the
+ * memory was allocated.
+ */
+void tee_shm_free_anon_kernel_buf(struct tee_context *ctx, struct tee_shm *s=
hm)
+{
+	struct tee_device *teedev =3D ctx->teedev;
+
+	/*
+	 * The anonymous kernel buffer isn't attached to any tee_context
+	 * we're instead assigning the current tee_context temporarily.
+	 * This is needed because an eventual call to unregister the shared
+	 * memory might need a context. As long as this context uses the
+	 * same tee_device as in the ctx in the call in
+	 * tee_shm_alloc_anon_kernel_buf() above we are OK.
+	 */
+	shm->ctx =3D ctx;
+	teedev->pool->ops->free(teedev->pool, shm);
+	kfree(shm);
+	tee_device_put(teedev);
+}
+EXPORT_SYMBOL_GPL(tee_shm_free_anon_kernel_buf);
+
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 58b319766f8e..11a4e556bdf9 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -267,22 +267,11 @@ static inline void tee_shm_pool_free(struct tee_shm_poo=
l *pool)
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
+struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t siz=
e);
+struct tee_shm *tee_shm_alloc_anon_kernel_buf(struct tee_context *ctx,
+					      size_t size);
+void tee_shm_free_anon_kernel_buf(struct tee_context *ctx, struct tee_shm *s=
hm);
=20
 /**
  * tee_shm_register() - Register shared memory buffer
--=20
2.31.1


--===============2912854728837674231==--

