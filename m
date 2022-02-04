From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4 10/10] tee: refactor TEE_SHM_* flags
Date: Fri, 04 Feb 2022 10:33:59 +0100
Message-ID: <20220204093359.359059-11-jens.wiklander@linaro.org>
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1412544758555470219=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1412544758555470219==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Removes the redundant TEE_SHM_DMA_BUF, TEE_SHM_EXT_DMA_BUF,
TEE_SHM_MAPPED and TEE_SHM_KERNEL_MAPPED flags.

TEE_SHM_REGISTER is renamed to TEE_SHM_DYNAMIC in order to better
match its usage.

Assigns new values to the remaining flags to void gaps.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/smc_abi.c |  4 ++--
 drivers/tee/tee_shm.c       | 23 +++++++++++------------
 drivers/tee/tee_shm_pool.c  |  2 +-
 include/linux/tee_drv.h     | 21 +++++++++------------
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 0b68127a8afa..375a40eef36c 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -228,7 +228,7 @@ static int optee_to_msg_param(struct optee *optee,
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
-			if (tee_shm_is_registered(p->u.memref.shm))
+			if (tee_shm_is_dynamic(p->u.memref.shm))
 				rc =3D to_msg_param_reg_mem(mp, p);
 			else
 				rc =3D to_msg_param_tmp_mem(mp, p);
@@ -669,7 +669,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_cont=
ext *ctx,
=20
 	sz =3D tee_shm_get_size(shm);
=20
-	if (tee_shm_is_registered(shm)) {
+	if (tee_shm_is_dynamic(shm)) {
 		struct page **pages;
 		u64 *pages_list;
 		size_t page_num;
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 9db571253802..f31e29e8f1ca 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -58,7 +58,7 @@ static void tee_shm_release(struct tee_device *teedev, stru=
ct tee_shm *shm)
 {
 	if (shm->flags & TEE_SHM_POOL) {
 		teedev->pool->ops->free(teedev->pool, shm);
-	} else if (shm->flags & TEE_SHM_REGISTER) {
+	} else if (shm->flags & TEE_SHM_DYNAMIC) {
 		int rc =3D teedev->desc->ops->shm_unregister(shm->ctx, shm);
=20
 		if (rc)
@@ -139,8 +139,7 @@ static struct tee_shm *shm_alloc_helper(struct tee_contex=
t *ctx, size_t size,
  */
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
 {
-	u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER |
-		    TEE_SHM_POOL;
+	u32 flags =3D TEE_SHM_DYNAMIC | TEE_SHM_POOL;
 	struct tee_device *teedev =3D ctx->teedev;
 	struct tee_shm *shm;
 	void *ret;
@@ -185,7 +184,7 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context=
 *ctx, size_t size)
  */
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t siz=
e)
 {
-	u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_REGISTER | TEE_SHM_POOL;
+	u32 flags =3D TEE_SHM_DYNAMIC | TEE_SHM_POOL;
=20
 	return shm_alloc_helper(ctx, size, PAGE_SIZE, flags, -1);
 }
@@ -209,7 +208,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
  */
 struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
 {
-	u32 flags =3D TEE_SHM_MAPPED | TEE_SHM_PRIV | TEE_SHM_POOL;
+	u32 flags =3D TEE_SHM_PRIV | TEE_SHM_POOL;
=20
 	return shm_alloc_helper(ctx, size, sizeof(long) * 2, flags, -1);
 }
@@ -306,7 +305,7 @@ register_shm_helper(struct tee_context *ctx, unsigned lon=
g addr,
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length)
 {
-	u32 flags =3D TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
+	u32 flags =3D TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
 	struct tee_device *teedev =3D ctx->teedev;
 	struct tee_shm *shm;
 	void *ret;
@@ -350,7 +349,7 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_cont=
ext *ctx,
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length)
 {
-	u32 flags =3D TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
+	u32 flags =3D TEE_SHM_DYNAMIC;
=20
 	return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
 }
@@ -394,7 +393,7 @@ int tee_shm_get_fd(struct tee_shm *shm)
 {
 	int fd;
=20
-	if (!(shm->flags & TEE_SHM_DMA_BUF))
+	if (shm->id < 0)
 		return -EINVAL;
=20
 	/* matched by tee_shm_put() in tee_shm_op_release() */
@@ -424,7 +423,7 @@ EXPORT_SYMBOL_GPL(tee_shm_free);
  */
 int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
 {
-	if (!(shm->flags & TEE_SHM_MAPPED))
+	if (!shm->kaddr)
 		return -EINVAL;
 	/* Check that we're in the range of the shm */
 	if ((char *)va < (char *)shm->kaddr)
@@ -446,7 +445,7 @@ EXPORT_SYMBOL_GPL(tee_shm_va2pa);
  */
 int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
 {
-	if (!(shm->flags & TEE_SHM_MAPPED))
+	if (!shm->kaddr)
 		return -EINVAL;
 	/* Check that we're in the range of the shm */
 	if (pa < shm->paddr)
@@ -474,7 +473,7 @@ EXPORT_SYMBOL_GPL(tee_shm_pa2va);
  */
 void *tee_shm_get_va(struct tee_shm *shm, size_t offs)
 {
-	if (!(shm->flags & TEE_SHM_MAPPED))
+	if (!shm->kaddr)
 		return ERR_PTR(-EINVAL);
 	if (offs >=3D shm->size)
 		return ERR_PTR(-EINVAL);
@@ -549,7 +548,7 @@ void tee_shm_put(struct tee_shm *shm)
 		 * the refcount_inc() in tee_shm_get_from_id() never starts
 		 * from 0.
 		 */
-		if (shm->flags & TEE_SHM_DMA_BUF)
+		if (shm->id >=3D 0)
 			idr_remove(&teedev->idr, shm->id);
 		do_release =3D true;
 	}
diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
index 71e0f8ae69aa..058bfbac657a 100644
--- a/drivers/tee/tee_shm_pool.c
+++ b/drivers/tee/tee_shm_pool.c
@@ -30,7 +30,7 @@ static int pool_op_gen_alloc(struct tee_shm_pool *pool, str=
uct tee_shm *shm,
 	 * This is from a static shared memory pool so no need to register
 	 * each chunk, and no need to unregister later either.
 	 */
-	shm->flags &=3D ~TEE_SHM_REGISTER;
+	shm->flags &=3D ~TEE_SHM_DYNAMIC;
 	return 0;
 }
=20
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index a3b663ef0694..911cad324acc 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -20,14 +20,11 @@
  * specific TEE driver.
  */
=20
-#define TEE_SHM_MAPPED		BIT(0)	/* Memory mapped by the kernel */
-#define TEE_SHM_DMA_BUF		BIT(1)	/* Memory with dma-buf handle */
-#define TEE_SHM_EXT_DMA_BUF	BIT(2)	/* Memory with dma-buf handle */
-#define TEE_SHM_REGISTER	BIT(3)  /* Memory registered in secure world */
-#define TEE_SHM_USER_MAPPED	BIT(4)  /* Memory mapped in user space */
-#define TEE_SHM_POOL		BIT(5)  /* Memory allocated from pool */
-#define TEE_SHM_KERNEL_MAPPED	BIT(6)  /* Memory mapped in kernel space */
-#define TEE_SHM_PRIV		BIT(7)  /* Memory private to TEE driver */
+#define TEE_SHM_DYNAMIC		BIT(0)  /* Dynamic shared memory registered */
+					/* in secure world */
+#define TEE_SHM_USER_MAPPED	BIT(1)  /* Memory mapped in user space */
+#define TEE_SHM_POOL		BIT(2)  /* Memory allocated from pool */
+#define TEE_SHM_PRIV		BIT(3)  /* Memory private to TEE driver */
=20
 struct device;
 struct tee_device;
@@ -280,13 +277,13 @@ struct tee_shm *tee_shm_register_kernel_buf(struct tee_=
context *ctx,
 					    void *addr, size_t length);
=20
 /**
- * tee_shm_is_registered() - Check if shared memory object in registered in =
TEE
+ * tee_shm_is_dynamic() - Check if shared memory object is of the dynamic ki=
nd
  * @shm:	Shared memory handle
- * @returns true if object is registered in TEE
+ * @returns true if object is dynamic shared memory
  */
-static inline bool tee_shm_is_registered(struct tee_shm *shm)
+static inline bool tee_shm_is_dynamic(struct tee_shm *shm)
 {
-	return shm && (shm->flags & TEE_SHM_REGISTER);
+	return shm && (shm->flags & TEE_SHM_DYNAMIC);
 }
=20
 /**
--=20
2.31.1


--===============1412544758555470219==--

