From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 11/12] tee: replace tee_shm_register()
Date: Tue, 25 Jan 2022 17:29:37 +0100
Message-ID: <20220125162938.838382-12-jens.wiklander@linaro.org>
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2244213344033573341=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2244213344033573341==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

tee_shm_register() is replaced by the previously introduced functions
tee_shm_register_user_buf() and tee_shm_register_kernel_buf().

Since there are not external callers left we can remove tee_shm_register()
and refactor the remains.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c   | 156 +++++++++++++++++++++++-----------------
 include/linux/tee_drv.h |  11 ---
 2 files changed, 90 insertions(+), 77 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 0b6f7aabbf88..c3a29022ec72 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -12,17 +12,43 @@
 #include <linux/uio.h>
 #include "tee_private.h"
=20
+static void shm_put_kernel_pages(struct page **pages, size_t page_count)
+{
+	size_t n;
+
+	for (n =3D 0; n < page_count; n++)
+		put_page(pages[n]);
+}
+
+static int shm_get_kernel_pages(unsigned long start, size_t page_count,
+				struct page **pages)
+{
+	struct kvec *kiov;
+	size_t n;
+	int rc;
+
+	kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
+	if (!kiov)
+		return -ENOMEM;
+
+	for (n =3D 0; n < page_count; n++) {
+		kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
+		kiov[n].iov_len =3D PAGE_SIZE;
+	}
+
+	rc =3D get_kernel_pages(kiov, page_count, 0, pages);
+	kfree(kiov);
+
+	return rc;
+}
+
 static void release_registered_pages(struct tee_shm *shm)
 {
 	if (shm->pages) {
-		if (shm->flags & TEE_SHM_USER_MAPPED) {
+		if (shm->flags & TEE_SHM_USER_MAPPED)
 			unpin_user_pages(shm->pages, shm->num_pages);
-		} else {
-			size_t n;
-
-			for (n =3D 0; n < shm->num_pages; n++)
-				put_page(shm->pages[n]);
-		}
+		else
+			shm_put_kernel_pages(shm->pages, shm->num_pages);
=20
 		kfree(shm->pages);
 	}
@@ -189,28 +215,24 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_conte=
xt *ctx, size_t size)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
=20
-struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
-				 size_t length, u32 flags)
+static struct tee_shm *
+register_shm_helper(struct tee_context *ctx, unsigned long addr,
+		    size_t length, u32 flags, int id)
 {
 	struct tee_device *teedev =3D ctx->teedev;
-	const u32 req_user_flags =3D TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
-	const u32 req_kernel_flags =3D TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;
 	struct tee_shm *shm;
+	unsigned long start;
+	int num_pages;
 	void *ret;
 	int rc;
-	int num_pages;
-	unsigned long start;
-
-	if (flags !=3D req_user_flags && flags !=3D req_kernel_flags)
-		return ERR_PTR(-ENOTSUPP);
=20
 	if (!tee_device_get(teedev))
 		return ERR_PTR(-EINVAL);
=20
 	if (!teedev->desc->ops->shm_register ||
 	    !teedev->desc->ops->shm_unregister) {
-		tee_device_put(teedev);
-		return ERR_PTR(-ENOTSUPP);
+		ret =3D ERR_PTR(-ENOTSUPP);
+		goto err_dev_put;
 	}
=20
 	teedev_ctx_get(ctx);
@@ -218,13 +240,13 @@ struct tee_shm *tee_shm_register(struct tee_context *ct=
x, unsigned long addr,
 	shm =3D kzalloc(sizeof(*shm), GFP_KERNEL);
 	if (!shm) {
 		ret =3D ERR_PTR(-ENOMEM);
-		goto err;
+		goto err_ctx_put;
 	}
=20
 	refcount_set(&shm->refcount, 1);
-	shm->flags =3D flags | TEE_SHM_REGISTER;
+	shm->flags =3D flags;
 	shm->ctx =3D ctx;
-	shm->id =3D -1;
+	shm->id =3D id;
 	addr =3D untagged_addr(addr);
 	start =3D rounddown(addr, PAGE_SIZE);
 	shm->offset =3D addr - start;
@@ -233,71 +255,45 @@ struct tee_shm *tee_shm_register(struct tee_context *ct=
x, unsigned long addr,
 	shm->pages =3D kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
 	if (!shm->pages) {
 		ret =3D ERR_PTR(-ENOMEM);
-		goto err;
+		goto err_free_shm;
 	}
=20
-	if (flags & TEE_SHM_USER_MAPPED) {
+	if (flags & TEE_SHM_USER_MAPPED)
 		rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE,
 					 shm->pages);
-	} else {
-		struct kvec *kiov;
-		int i;
-
-		kiov =3D kcalloc(num_pages, sizeof(*kiov), GFP_KERNEL);
-		if (!kiov) {
-			ret =3D ERR_PTR(-ENOMEM);
-			goto err;
-		}
-
-		for (i =3D 0; i < num_pages; i++) {
-			kiov[i].iov_base =3D (void *)(start + i * PAGE_SIZE);
-			kiov[i].iov_len =3D PAGE_SIZE;
-		}
-
-		rc =3D get_kernel_pages(kiov, num_pages, 0, shm->pages);
-		kfree(kiov);
-	}
+	else
+		rc =3D shm_get_kernel_pages(start, num_pages, shm->pages);
 	if (rc > 0)
 		shm->num_pages =3D rc;
 	if (rc !=3D num_pages) {
 		if (rc >=3D 0)
 			rc =3D -ENOMEM;
 		ret =3D ERR_PTR(rc);
-		goto err;
-	}
-
-	mutex_lock(&teedev->mutex);
-	shm->id =3D idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
-	mutex_unlock(&teedev->mutex);
-
-	if (shm->id < 0) {
-		ret =3D ERR_PTR(shm->id);
-		goto err;
+		goto err_put_shm_pages;
 	}
=20
 	rc =3D teedev->desc->ops->shm_register(ctx, shm, shm->pages,
 					     shm->num_pages, start);
 	if (rc) {
 		ret =3D ERR_PTR(rc);
-		goto err;
+		goto err_put_shm_pages;
 	}
=20
 	return shm;
-err:
-	if (shm) {
-		if (shm->id >=3D 0) {
-			mutex_lock(&teedev->mutex);
-			idr_remove(&teedev->idr, shm->id);
-			mutex_unlock(&teedev->mutex);
-		}
-		release_registered_pages(shm);
-	}
+err_put_shm_pages:
+	if (flags & TEE_SHM_USER_MAPPED)
+		unpin_user_pages(shm->pages, shm->num_pages);
+	else
+		shm_put_kernel_pages(shm->pages, shm->num_pages);
+	kfree(shm->pages);
+err_free_shm:
 	kfree(shm);
+err_ctx_put:
 	teedev_ctx_put(ctx);
+err_dev_put:
 	tee_device_put(teedev);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(tee_shm_register);
=20
 /**
  * tee_shm_register_user_buf() - Register a userspace shared memory buffer
@@ -310,8 +306,35 @@ EXPORT_SYMBOL_GPL(tee_shm_register);
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length)
 {
-	return tee_shm_register(ctx, addr, length,
-				TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
+	u32 flags =3D TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
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
+	shm =3D register_shm_helper(ctx, addr, length, flags, id);
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
@@ -327,8 +350,9 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_cont=
ext *ctx,
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length)
 {
-	return tee_shm_register(ctx, (unsigned long)addr, length,
-				TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
+	u32 flags =3D TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
+
+	return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
 }
 EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
=20
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index c9d2cc32a5ed..a3b663ef0694 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -276,17 +276,6 @@ void *tee_get_drvdata(struct tee_device *teedev);
 struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t siz=
e);
=20
-/**
- * tee_shm_register() - Register shared memory buffer
- * @ctx:	Context that registers the shared memory
- * @addr:	Address is userspace of the shared buffer
- * @length:	Length of the shared buffer
- * @flags:	Flags setting properties for the requested shared memory.
- *
- * @returns a pointer to 'struct tee_shm'
- */
-struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
-				 size_t length, u32 flags);
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length);
=20
--=20
2.31.1


--===============2244213344033573341==--

