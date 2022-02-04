From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4 02/10] tee: remove unused tee_shm_pool_alloc_res_mem()
Date: Fri, 04 Feb 2022 10:33:51 +0100
Message-ID: <20220204093359.359059-3-jens.wiklander@linaro.org>
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7006726531816516046=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7006726531816516046==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

None of the drivers in the TEE subsystem uses
tee_shm_pool_alloc_res_mem() so remove the function.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm_pool.c | 56 --------------------------------------
 include/linux/tee_drv.h    | 30 --------------------
 2 files changed, 86 deletions(-)

diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
index fcbb461fc59c..a9f9d50fd181 100644
--- a/drivers/tee/tee_shm_pool.c
+++ b/drivers/tee/tee_shm_pool.c
@@ -47,62 +47,6 @@ static const struct tee_shm_pool_mgr_ops pool_ops_generic =
=3D {
 	.destroy_poolmgr =3D pool_op_gen_destroy_poolmgr,
 };
=20
-/**
- * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
- * memory range
- * @priv_info:	Information for driver private shared memory pool
- * @dmabuf_info: Information for dma-buf shared memory pool
- *
- * Start and end of pools will must be page aligned.
- *
- * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
- * in @dmabuf, others will use the range provided by @priv.
- *
- * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
- */
-struct tee_shm_pool *
-tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
-			   struct tee_shm_pool_mem_info *dmabuf_info)
-{
-	struct tee_shm_pool_mgr *priv_mgr;
-	struct tee_shm_pool_mgr *dmabuf_mgr;
-	void *rc;
-
-	/*
-	 * Create the pool for driver private shared memory
-	 */
-	rc =3D tee_shm_pool_mgr_alloc_res_mem(priv_info->vaddr, priv_info->paddr,
-					    priv_info->size,
-					    3 /* 8 byte aligned */);
-	if (IS_ERR(rc))
-		return rc;
-	priv_mgr =3D rc;
-
-	/*
-	 * Create the pool for dma_buf shared memory
-	 */
-	rc =3D tee_shm_pool_mgr_alloc_res_mem(dmabuf_info->vaddr,
-					    dmabuf_info->paddr,
-					    dmabuf_info->size, PAGE_SHIFT);
-	if (IS_ERR(rc))
-		goto err_free_priv_mgr;
-	dmabuf_mgr =3D rc;
-
-	rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
-	if (IS_ERR(rc))
-		goto err_free_dmabuf_mgr;
-
-	return rc;
-
-err_free_dmabuf_mgr:
-	tee_shm_pool_mgr_destroy(dmabuf_mgr);
-err_free_priv_mgr:
-	tee_shm_pool_mgr_destroy(priv_mgr);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_res_mem);
-
 struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long vaddr,
 							phys_addr_t paddr,
 							size_t size,
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 5e1533ee3785..6b0f0d01ebdf 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -278,36 +278,6 @@ static inline void tee_shm_pool_mgr_destroy(struct tee_s=
hm_pool_mgr *poolm)
 	poolm->ops->destroy_poolmgr(poolm);
 }
=20
-/**
- * struct tee_shm_pool_mem_info - holds information needed to create a shared
- * memory pool
- * @vaddr:	Virtual address of start of pool
- * @paddr:	Physical address of start of pool
- * @size:	Size in bytes of the pool
- */
-struct tee_shm_pool_mem_info {
-	unsigned long vaddr;
-	phys_addr_t paddr;
-	size_t size;
-};
-
-/**
- * tee_shm_pool_alloc_res_mem() - Create a shared memory pool from reserved
- * memory range
- * @priv_info:	 Information for driver private shared memory pool
- * @dmabuf_info: Information for dma-buf shared memory pool
- *
- * Start and end of pools will must be page aligned.
- *
- * Allocation with the flag TEE_SHM_DMA_BUF set will use the range supplied
- * in @dmabuf, others will use the range provided by @priv.
- *
- * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
- */
-struct tee_shm_pool *
-tee_shm_pool_alloc_res_mem(struct tee_shm_pool_mem_info *priv_info,
-			   struct tee_shm_pool_mem_info *dmabuf_info);
-
 /**
  * tee_shm_pool_free() - Free a shared memory pool
  * @pool:	The shared memory pool to free
--=20
2.31.1


--===============7006726531816516046==--

