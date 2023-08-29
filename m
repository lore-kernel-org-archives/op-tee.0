From: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 2/2] tee: amdtee: add support for CMA buffer allocations
Date: Wed, 30 Aug 2023 01:49:43 +0530
Message-ID: <8c7f0641582d53c20c6657f0ebb4d3a1279e6f9b.1693340098.git.Devaraj.Rangasamy@amd.com>
In-Reply-To: <=?utf-8?q?=3Cfe6fd7781d77ea32064e5b861f33150b28768278=2E1693340?=
 =?utf-8?q?098=2Egit=2EDevaraj=2ERangasamy=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0552101906672513923=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0552101906672513923==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

amdtee driver shall use CMA region for contiguous
buffer allocation, if CMA is available.

since CMA and DMA contiguous APIs are not exported,
this support is enabled only when amdtee is built
as a builtin driver.

Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
v2:
* Switched to generic CMA pool.
* Replaced __get_free_pages() with alloc_pages_exact().
* Compacted patch with simplified changes within single file.

 drivers/tee/amdtee/shm_pool.c | 51 +++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
index 156e8a6f631f..d504d9749114 100644
--- a/drivers/tee/amdtee/shm_pool.c
+++ b/drivers/tee/amdtee/shm_pool.c
@@ -5,10 +5,50 @@
=20
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/dma-map-ops.h>
 #include <linux/tee_drv.h>
 #include <linux/psp.h>
 #include "amdtee_private.h"
=20
+#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_DMA_CMA)
+static void *alloc_from_cma(size_t size)
+{
+
+	int nr_pages =3D size >> PAGE_SHIFT;
+	struct page *page;
+
+	page =3D dma_alloc_from_contiguous(NULL, nr_pages, 0, false);
+	if (page)
+		return page_to_virt(page);
+
+	return NULL;
+}
+
+static bool free_from_cma(struct tee_shm *shm)
+{
+
+	int nr_pages;
+	struct page *page;
+
+	if (!dev_get_cma_area(NULL))
+		return false;
+
+	nr_pages =3D shm->size >> PAGE_SHIFT;
+	page =3D virt_to_page(shm->kaddr);
+	return dma_release_from_contiguous(NULL, page, nr_pages);
+}
+#else
+static void *alloc_from_cma(size_t size)
+{
+	return NULL;
+}
+
+static bool free_from_cma(struct tee_shm *shm)
+{
+	return false;
+}
+#endif
+
 static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 			 size_t size, size_t align)
 {
@@ -17,7 +57,11 @@ static int pool_op_alloc(struct tee_shm_pool *pool, struct=
 tee_shm *shm,
=20
 	size =3D PAGE_ALIGN(size);
=20
-	va =3D alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
+	va =3D alloc_from_cma(size);
+
+	if (!va)
+		va =3D alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
+
 	if (!va)
 		return -ENOMEM;
=20
@@ -40,7 +84,10 @@ static void pool_op_free(struct tee_shm_pool *pool, struct=
 tee_shm *shm)
 {
 	/* Unmap the shared memory from TEE */
 	amdtee_unmap_shmem(shm);
-	free_pages_exact(shm->kaddr, shm->size);
+
+	if (!free_from_cma(shm))
+		free_pages_exact(shm->kaddr, shm->size);
+
 	shm->kaddr =3D NULL;
 }
=20
--=20
2.25.1


--===============0552101906672513923==--

