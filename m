From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v5 6/8] tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag
Date: Mon, 14 Jun 2021 17:33:15 -0500
Message-ID: <20210614223317.999867-7-tyhicks@linux.microsoft.com>
In-Reply-To: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8393323098716014975=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8393323098716014975==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Sumit Garg <sumit.garg@linaro.org>

Currently TEE_SHM_DMA_BUF flag has been inappropriately used to not
register shared memory allocated for private usage by underlying TEE
driver: OP-TEE in this case. So rather add a new flag as TEE_SHM_PRIV
that can be utilized by underlying TEE drivers for private allocation
and usage of shared memory.

With this corrected, allow tee_shm_alloc_kernel_buf() to allocate a
shared memory region without the backing of dma-buf.

Cc: stable(a)vger.kernel.org
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/optee/call.c     | 2 +-
 drivers/tee/optee/core.c     | 3 ++-
 drivers/tee/optee/rpc.c      | 5 +++--
 drivers/tee/optee/shm_pool.c | 8 ++++++--
 drivers/tee/tee_shm.c        | 4 ++--
 include/linux/tee_drv.h      | 1 +
 6 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 387e94768182..945f03da0223 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -184,7 +184,7 @@ static struct tee_shm *get_msg_arg(struct tee_context *ct=
x, size_t num_params,
 	struct optee_msg_arg *ma;
=20
 	shm =3D tee_shm_alloc(ctx, OPTEE_MSG_GET_ARG_SIZE(num_params),
-			    TEE_SHM_MAPPED);
+			    TEE_SHM_MAPPED | TEE_SHM_PRIV);
 	if (IS_ERR(shm))
 		return shm;
=20
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 651d49b53d3b..5ce13b099d7d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -278,7 +278,8 @@ static void optee_release(struct tee_context *ctx)
 	if (!ctxdata)
 		return;
=20
-	shm =3D tee_shm_alloc(ctx, sizeof(struct optee_msg_arg), TEE_SHM_MAPPED);
+	shm =3D tee_shm_alloc(ctx, sizeof(struct optee_msg_arg),
+			    TEE_SHM_MAPPED | TEE_SHM_PRIV);
 	if (!IS_ERR(shm)) {
 		arg =3D tee_shm_get_va(shm, 0);
 		/*
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 1849180b0278..efbaff7ad7e5 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -314,7 +314,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_cont=
ext *ctx,
 		shm =3D cmd_alloc_suppl(ctx, sz);
 		break;
 	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm =3D tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED);
+		shm =3D tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED | TEE_SHM_PRIV);
 		break;
 	default:
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
@@ -502,7 +502,8 @@ void optee_handle_rpc(struct tee_context *ctx, struct opt=
ee_rpc_param *param,
=20
 	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
 	case OPTEE_SMC_RPC_FUNC_ALLOC:
-		shm =3D tee_shm_alloc(ctx, param->a1, TEE_SHM_MAPPED);
+		shm =3D tee_shm_alloc(ctx, param->a1,
+				    TEE_SHM_MAPPED | TEE_SHM_PRIV);
 		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
 			reg_pair_from_64(&param->a1, &param->a2, pa);
 			reg_pair_from_64(&param->a4, &param->a5,
diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index da06ce9b9313..c41a9a501a6e 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -27,7 +27,11 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 	shm->paddr =3D page_to_phys(page);
 	shm->size =3D PAGE_SIZE << order;
=20
-	if (shm->flags & TEE_SHM_DMA_BUF) {
+	/*
+	 * Shared memory private to the OP-TEE driver doesn't need
+	 * to be registered with OP-TEE.
+	 */
+	if (!(shm->flags & TEE_SHM_PRIV)) {
 		unsigned int nr_pages =3D 1 << order, i;
 		struct page **pages;
=20
@@ -60,7 +64,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 static void pool_op_free(struct tee_shm_pool_mgr *poolm,
 			 struct tee_shm *shm)
 {
-	if (shm->flags & TEE_SHM_DMA_BUF)
+	if (!(shm->flags & TEE_SHM_PRIV))
 		optee_shm_unregister(shm->ctx, shm);
=20
 	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index c65e44707cd6..8a9384a64f3e 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -117,7 +117,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, si=
ze_t size, u32 flags)
 		return ERR_PTR(-EINVAL);
 	}
=20
-	if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF))) {
+	if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_PRIV))) {
 		dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
 		return ERR_PTR(-EINVAL);
 	}
@@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
  */
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t siz=
e)
 {
-	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED);
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
=20
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 8990f7628387..3ebfea0781f1 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -27,6 +27,7 @@
 #define TEE_SHM_USER_MAPPED	BIT(4)  /* Memory mapped in user space */
 #define TEE_SHM_POOL		BIT(5)  /* Memory allocated from pool */
 #define TEE_SHM_KERNEL_MAPPED	BIT(6)  /* Memory mapped in kernel space */
+#define TEE_SHM_PRIV		BIT(7)  /* Memory private to TEE driver */
=20
 struct device;
 struct tee_device;
--=20
2.25.1


--===============8393323098716014975==--

