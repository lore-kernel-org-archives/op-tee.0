From: Andrew Davis <afd@ti.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 1/2] tee: remove tee_shm_va2pa() and tee_shm_pa2va()
Date: Fri, 22 Apr 2022 13:01:38 -0500
Message-ID: <20220422180139.13447-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2997176672262369192=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2997176672262369192==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

We should not need to index into SHMs based on absolute VA/PA.
These functions are not used and this kind of usage should not be
encouraged anyway. Remove these functions.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/tee/tee_shm.c   | 50 -----------------------------------------
 include/linux/tee_drv.h | 18 ---------------
 2 files changed, 68 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index f31e29e8f1cac..b0c6d553d3a70 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -414,56 +414,6 @@ void tee_shm_free(struct tee_shm *shm)
 }
 EXPORT_SYMBOL_GPL(tee_shm_free);
 
-/**
- * tee_shm_va2pa() - Get physical address of a virtual address
- * @shm:	Shared memory handle
- * @va:		Virtual address to tranlsate
- * @pa:		Returned physical address
- * @returns 0 on success and < 0 on failure
- */
-int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
-{
-	if (!shm->kaddr)
-		return -EINVAL;
-	/* Check that we're in the range of the shm */
-	if ((char *)va < (char *)shm->kaddr)
-		return -EINVAL;
-	if ((char *)va >= ((char *)shm->kaddr + shm->size))
-		return -EINVAL;
-
-	return tee_shm_get_pa(
-			shm, (unsigned long)va - (unsigned long)shm->kaddr, pa);
-}
-EXPORT_SYMBOL_GPL(tee_shm_va2pa);
-
-/**
- * tee_shm_pa2va() - Get virtual address of a physical address
- * @shm:	Shared memory handle
- * @pa:		Physical address to tranlsate
- * @va:		Returned virtual address
- * @returns 0 on success and < 0 on failure
- */
-int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
-{
-	if (!shm->kaddr)
-		return -EINVAL;
-	/* Check that we're in the range of the shm */
-	if (pa < shm->paddr)
-		return -EINVAL;
-	if (pa >= (shm->paddr + shm->size))
-		return -EINVAL;
-
-	if (va) {
-		void *v = tee_shm_get_va(shm, pa - shm->paddr);
-
-		if (IS_ERR(v))
-			return PTR_ERR(v);
-		*va = v;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tee_shm_pa2va);
-
 /**
  * tee_shm_get_va() - Get virtual address of a shared memory plus an offset
  * @shm:	Shared memory handle
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 911cad324acc7..17eb1c5205d34 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -298,24 +298,6 @@ void tee_shm_free(struct tee_shm *shm);
  */
 void tee_shm_put(struct tee_shm *shm);
 
-/**
- * tee_shm_va2pa() - Get physical address of a virtual address
- * @shm:	Shared memory handle
- * @va:		Virtual address to tranlsate
- * @pa:		Returned physical address
- * @returns 0 on success and < 0 on failure
- */
-int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa);
-
-/**
- * tee_shm_pa2va() - Get virtual address of a physical address
- * @shm:	Shared memory handle
- * @pa:		Physical address to tranlsate
- * @va:		Returned virtual address
- * @returns 0 on success and < 0 on failure
- */
-int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va);
-
 /**
  * tee_shm_get_va() - Get virtual address of a shared memory plus an offset
  * @shm:	Shared memory handle
-- 
2.17.1


--===============2997176672262369192==--

