From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 1/3] tee: optee: Move pool_op helper functions
Date: Tue, 13 Feb 2024 15:52:37 +0100
Message-ID: <20240213145239.379875-2-balint.dobszay@arm.com>
In-Reply-To: <20240213145239.379875-1-balint.dobszay@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7681001778643520305=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7681001778643520305==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Move the pool alloc and free helper functions from the OP-TEE driver to
the TEE subsystem, since these could be reused in other TEE drivers.
This patch is not supposed to change behavior, it's only reorganizing
the code.

Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
---
 drivers/tee/optee/core.c          | 64 ------------------------------
 drivers/tee/optee/ffa_abi.c       |  6 +--
 drivers/tee/optee/optee_private.h | 12 ------
 drivers/tee/optee/smc_abi.c       | 10 ++---
 drivers/tee/tee_shm.c             | 65 +++++++++++++++++++++++++++++++
 include/linux/tee_drv.h           | 11 ++++++
 6 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 3aed554bc8d8..9390f21f9902 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -9,7 +9,6 @@
 #include <linux/crash_dump.h>
 #include <linux/errno.h>
 #include <linux/io.h>
-#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -17,69 +16,6 @@
 #include <linux/types.h>
 #include "optee_private.h"
=20
-int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *sh=
m,
-			       size_t size, size_t align,
-			       int (*shm_register)(struct tee_context *ctx,
-						   struct tee_shm *shm,
-						   struct page **pages,
-						   size_t num_pages,
-						   unsigned long start))
-{
-	size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
-	struct page **pages;
-	unsigned int i;
-	int rc =3D 0;
-
-	/*
-	 * Ignore alignment since this is already going to be page aligned
-	 * and there's no need for any larger alignment.
-	 */
-	shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
-				       GFP_KERNEL | __GFP_ZERO);
-	if (!shm->kaddr)
-		return -ENOMEM;
-
-	shm->paddr =3D virt_to_phys(shm->kaddr);
-	shm->size =3D nr_pages * PAGE_SIZE;
-
-	pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
-	if (!pages) {
-		rc =3D -ENOMEM;
-		goto err;
-	}
-
-	for (i =3D 0; i < nr_pages; i++)
-		pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
-
-	shm->pages =3D pages;
-	shm->num_pages =3D nr_pages;
-
-	if (shm_register) {
-		rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
-				  (unsigned long)shm->kaddr);
-		if (rc)
-			goto err;
-	}
-
-	return 0;
-err:
-	free_pages_exact(shm->kaddr, shm->size);
-	shm->kaddr =3D NULL;
-	return rc;
-}
-
-void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *sh=
m,
-			       int (*shm_unregister)(struct tee_context *ctx,
-						     struct tee_shm *shm))
-{
-	if (shm_unregister)
-		shm_unregister(shm->ctx, shm);
-	free_pages_exact(shm->kaddr, shm->size);
-	shm->kaddr =3D NULL;
-	kfree(shm->pages);
-	shm->pages =3D NULL;
-}
-
 static void optee_bus_scan(struct work_struct *work)
 {
 	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index ecb5eb079408..ee11918a2b35 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -374,14 +374,14 @@ static int optee_ffa_shm_unregister_supp(struct tee_con=
text *ctx,
 static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
 			     struct tee_shm *shm, size_t size, size_t align)
 {
-	return optee_pool_op_alloc_helper(pool, shm, size, align,
-					  optee_ffa_shm_register);
+	return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
+					    optee_ffa_shm_register);
 }
=20
 static void pool_ffa_op_free(struct tee_shm_pool *pool,
 			     struct tee_shm *shm)
 {
-	optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
+	tee_shm_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
 }
=20
 static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 7a5243c78b55..a153285a1919 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -283,18 +283,6 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel=
_id, u32 session);
 int optee_enumerate_devices(u32 func);
 void optee_unregister_devices(void);
=20
-int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *sh=
m,
-			       size_t size, size_t align,
-			       int (*shm_register)(struct tee_context *ctx,
-						   struct tee_shm *shm,
-						   struct page **pages,
-						   size_t num_pages,
-						   unsigned long start));
-void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *sh=
m,
-			       int (*shm_unregister)(struct tee_context *ctx,
-						     struct tee_shm *shm));
-
-
 void optee_remove_common(struct optee *optee);
 int optee_open(struct tee_context *ctx, bool cap_memref_null);
 void optee_release(struct tee_context *ctx);
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a37f87087e5c..78f4c8c43790 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -592,19 +592,19 @@ static int pool_op_alloc(struct tee_shm_pool *pool,
 	 * to be registered with OP-TEE.
 	 */
 	if (shm->flags & TEE_SHM_PRIV)
-		return optee_pool_op_alloc_helper(pool, shm, size, align, NULL);
+		return tee_shm_pool_op_alloc_helper(pool, shm, size, align, NULL);
=20
-	return optee_pool_op_alloc_helper(pool, shm, size, align,
-					  optee_shm_register);
+	return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
+					    optee_shm_register);
 }
=20
 static void pool_op_free(struct tee_shm_pool *pool,
 			 struct tee_shm *shm)
 {
 	if (!(shm->flags & TEE_SHM_PRIV))
-		optee_pool_op_free_helper(pool, shm, optee_shm_unregister);
+		tee_shm_pool_op_free_helper(pool, shm, optee_shm_unregister);
 	else
-		optee_pool_op_free_helper(pool, shm, NULL);
+		tee_shm_pool_op_free_helper(pool, shm, NULL);
 }
=20
 static void pool_op_destroy_pool(struct tee_shm_pool *pool)
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 731d9028b67f..641aad92ffe2 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -202,6 +202,71 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_contex=
t *ctx, size_t size)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
=20
+int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *=
shm,
+				 size_t size, size_t align,
+				 int (*shm_register)(struct tee_context *ctx,
+						     struct tee_shm *shm,
+						     struct page **pages,
+						     size_t num_pages,
+						     unsigned long start))
+{
+	size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
+	struct page **pages;
+	unsigned int i;
+	int rc =3D 0;
+
+	/*
+	 * Ignore alignment since this is already going to be page aligned
+	 * and there's no need for any larger alignment.
+	 */
+	shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
+				       GFP_KERNEL | __GFP_ZERO);
+	if (!shm->kaddr)
+		return -ENOMEM;
+
+	shm->paddr =3D virt_to_phys(shm->kaddr);
+	shm->size =3D nr_pages * PAGE_SIZE;
+
+	pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages) {
+		rc =3D -ENOMEM;
+		goto err;
+	}
+
+	for (i =3D 0; i < nr_pages; i++)
+		pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
+
+	shm->pages =3D pages;
+	shm->num_pages =3D nr_pages;
+
+	if (shm_register) {
+		rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
+				  (unsigned long)shm->kaddr);
+		if (rc)
+			goto err;
+	}
+
+	return 0;
+err:
+	free_pages_exact(shm->kaddr, shm->size);
+	shm->kaddr =3D NULL;
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tee_shm_pool_op_alloc_helper);
+
+void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *=
shm,
+				 int (*shm_unregister)(struct tee_context *ctx,
+						       struct tee_shm *shm))
+{
+	if (shm_unregister)
+		shm_unregister(shm->ctx, shm);
+	free_pages_exact(shm->kaddr, shm->size);
+	shm->kaddr =3D NULL;
+	kfree(shm->pages);
+	shm->pages =3D NULL;
+}
+EXPORT_SYMBOL_GPL(tee_shm_pool_op_free_helper);
+
 static struct tee_shm *
 register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flag=
s,
 		    int id)
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 911ddf92dcee..4cf402424e71 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teedev);
 struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t siz=
e);
=20
+int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *=
shm,
+				 size_t size, size_t align,
+				 int (*shm_register)(struct tee_context *ctx,
+						     struct tee_shm *shm,
+						     struct page **pages,
+						     size_t num_pages,
+						     unsigned long start));
+void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *=
shm,
+				 int (*shm_unregister)(struct tee_context *ctx,
+						       struct tee_shm *shm));
+
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length);
=20
--=20
2.34.1


--===============7681001778643520305==--

