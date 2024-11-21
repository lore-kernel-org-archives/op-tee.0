From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH RFC 3/3] tee: introduce orphan tee_shm and default context
Date: Wed, 20 Nov 2024 17:37:17 -0800
Message-ID: 
 <20241120-fix-tee_shm-refcount-upstream-v1-3-5da97f584fcd@quicinc.com>
In-Reply-To: <
 <20241120-fix-tee_shm-refcount-upstream-v1-0-5da97f584fcd@quicinc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5531421419070779266=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5531421419070779266==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The default context has a lifespan similar to the tee_device.
It is used as a context for shared memory if the context to which the
shared memory belongs is released, making the tee_shm an orphan.
This allows the driver implementing shm_unregister to safely make
subsequent calls, such as to a supplicant if needed.

It also enables users to free the shared memory while the driver is
blocked on unregister_tee_device safely.

Preferably, this should be used for all driver internal uses, using
teedev_get_def_context rather than calling teedev_open.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
 drivers/tee/optee/core.c    |  2 +-
 drivers/tee/optee/ffa_abi.c |  2 +-
 drivers/tee/optee/smc_abi.c |  2 +-
 drivers/tee/tee_core.c      | 83 +++++++++++++++++++++++++++++--------------=
--
 drivers/tee/tee_private.h   |  3 --
 drivers/tee/tee_shm.c       | 18 ++--------
 include/linux/tee_core.h    | 15 ++++++++
 include/linux/tee_drv.h     |  7 ----
 8 files changed, 73 insertions(+), 59 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index c75fddc83576..78d43d0c8014 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -173,7 +173,7 @@ void optee_remove_common(struct optee *optee)
=20
 	optee_notif_uninit(optee);
 	optee_shm_arg_cache_uninit(optee);
-	teedev_close_context(optee->ctx);
+
 	/*
 	 * The two devices have to be unregistered before we can free the
 	 * other resources.
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index f3af5666bb11..6ad94f0788ad 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -949,7 +949,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
 	mutex_init(&optee->rpmb_dev_mutex);
 	ffa_dev_set_drvdata(ffa_dev, optee);
-	ctx =3D teedev_open(optee->teedev);
+	ctx =3D teedev_get_def_context(optee->teedev);
 	if (IS_ERR(ctx)) {
 		rc =3D PTR_ERR(ctx);
 		goto err_rhashtable_free;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index e9456e3e74cc..c77a3e631d04 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1722,7 +1722,7 @@ static int optee_probe(struct platform_device *pdev)
 	mutex_init(&optee->rpmb_dev_mutex);
=20
 	platform_set_drvdata(pdev, optee);
-	ctx =3D teedev_open(optee->teedev);
+	ctx =3D teedev_get_def_context(optee->teedev);
 	if (IS_ERR(ctx)) {
 		rc =3D PTR_ERR(ctx);
 		goto err_supp_uninit;
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 93f3b330aec8..805e1336089d 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -57,7 +57,6 @@ struct tee_context *teedev_open(struct tee_device *teedev)
 		goto err;
 	}
=20
-	kref_init(&ctx->refcount);
 	ctx->teedev =3D teedev;
 	INIT_LIST_HEAD(&ctx->list_shm);
 	rc =3D teedev->desc->ops->open(ctx);
@@ -73,36 +72,43 @@ struct tee_context *teedev_open(struct tee_device *teedev)
 }
 EXPORT_SYMBOL_GPL(teedev_open);
=20
-void teedev_ctx_get(struct tee_context *ctx)
+struct tee_context *teedev_get_def_context(struct tee_device *teedev)
 {
-	if (ctx->releasing)
-		return;
+	int rc;
+	struct tee_context *ctx =3D &teedev->def_ctx;
=20
-	kref_get(&ctx->refcount);
-}
+	ctx->teedev =3D teedev;
+	INIT_LIST_HEAD(&ctx->list_shm);
+	rc =3D teedev->desc->ops->open(ctx);
+	if (rc)
+		return ERR_PTR(rc);
=20
-static void teedev_ctx_release(struct kref *ref)
-{
-	struct tee_context *ctx =3D container_of(ref, struct tee_context,
-					       refcount);
-	ctx->releasing =3D true;
-	ctx->teedev->desc->ops->release(ctx);
-	kfree(ctx);
+	return ctx;
 }
+EXPORT_SYMBOL_GPL(teedev_get_def_context);
=20
-void teedev_ctx_put(struct tee_context *ctx)
+void teedev_close_context(struct tee_context *ctx)
 {
-	if (ctx->releasing)
+	struct tee_device *teedev =3D ctx->teedev;
+	struct tee_shm *shm;
+
+	if (ctx =3D=3D &teedev->def_ctx)
 		return;
=20
-	kref_put(&ctx->refcount, teedev_ctx_release);
-}
+	teedev->desc->ops->release(ctx);
=20
-void teedev_close_context(struct tee_context *ctx)
-{
-	struct tee_device *teedev =3D ctx->teedev;
+	mutex_lock(&teedev->mutex);
+	list_for_each_entry(shm, &ctx->list_shm, link) {
+		/* Context released. However, shm still holding a teedev reference.
+		 * Replace shm->ctx with the default context so that tee_shm_get_from_id()
+		 * fails (i.e. it is not accessible from userspace) but shm still
+		 * holds a valid context for further clean up, e.g. shm_unregister().
+		 */
+		shm->ctx =3D &teedev->def_ctx;
+	}
+	mutex_unlock(&teedev->mutex);
=20
-	teedev_ctx_put(ctx);
+	kfree(ctx);
 	tee_device_put(teedev);
 }
 EXPORT_SYMBOL_GPL(teedev_close_context);
@@ -946,6 +952,8 @@ struct tee_device *tee_device_alloc(const struct tee_desc=
 *teedesc,
=20
 	teedev->desc =3D teedesc;
 	teedev->pool =3D pool;
+	/* Only open default context when teedev_get_def_context() called. */
+	teedev->def_ctx.teedev =3D NULL;
=20
 	return teedev;
 err_devt:
@@ -1027,16 +1035,31 @@ EXPORT_SYMBOL_GPL(tee_device_register);
=20
 void tee_device_put(struct tee_device *teedev)
 {
-	mutex_lock(&teedev->mutex);
-	/* Shouldn't put in this state */
-	if (!WARN_ON(!teedev->desc)) {
-		teedev->num_users--;
-		if (!teedev->num_users) {
-			teedev->desc =3D NULL;
-			complete(&teedev->c_no_users);
-		}
+	const struct tee_desc *desc;
+
+	scoped_guard(mutex, &teedev->mutex) {
+		desc =3D teedev->desc;
+
+		/* Shouldn't put in this state */
+		if (WARN_ON(!desc))
+			return;
+
+		/* If there is still users for teedev */
+		if (--teedev->num_users)
+			return;
+
+		/* tee_device_unregister() has been called and there is no
+		 * user in userspace or kernel, including orphan shm for teedev.
+		 * Set teedev->desc to NULL, so that teedev can not be reused.
+		 */
+		teedev->desc =3D NULL;
 	}
-	mutex_unlock(&teedev->mutex);
+
+	/* Release the default context */
+	desc->ops->release(&teedev->def_ctx);
+	teedev->def_ctx.teedev =3D NULL;
+
+	complete(&teedev->c_no_users);
 }
=20
 bool tee_device_get(struct tee_device *teedev)
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 9bc50605227c..6c7bcc308958 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -17,9 +17,6 @@ int tee_shm_get_fd(struct tee_shm *shm);
 bool tee_device_get(struct tee_device *teedev);
 void tee_device_put(struct tee_device *teedev);
=20
-void teedev_ctx_get(struct tee_context *ctx);
-void teedev_ctx_put(struct tee_context *ctx);
-
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length);
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index c0164c0f4a01..f07274291edf 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -59,8 +59,6 @@ static void tee_shm_release(struct tee_shm *shm)
 		release_registered_pages(shm);
 	}
=20
-	teedev_ctx_put(shm->ctx);
-
 	kfree(shm);
=20
 	tee_device_put(teedev);
@@ -93,13 +91,6 @@ static struct tee_shm *shm_alloc_helper(struct tee_context=
 *ctx, size_t size,
 	shm->flags =3D flags;
 	shm->teedev =3D teedev;
 	shm->id =3D id;
-
-	/*
-	 * We're assigning this as it is needed if the shm is to be
-	 * registered. If this function returns OK then the caller expected
-	 * to call teedev_ctx_get() or clear shm->ctx in case it's not
-	 * needed any longer.
-	 */
 	shm->ctx =3D ctx;
=20
 	rc =3D teedev->pool->ops->alloc(teedev->pool, shm, size, align);
@@ -112,7 +103,6 @@ static struct tee_shm *shm_alloc_helper(struct tee_contex=
t *ctx, size_t size,
 	list_add_tail(&shm->link, &ctx->list_shm);
 	mutex_unlock(&teedev->mutex);
=20
-	teedev_ctx_get(ctx);
 	return shm;
 err_kfree:
 	kfree(shm);
@@ -295,12 +285,10 @@ register_shm_helper(struct tee_context *ctx, struct iov=
_iter *iter, u32 flags,
 		goto err_dev_put;
 	}
=20
-	teedev_ctx_get(ctx);
-
 	shm =3D kzalloc(sizeof(*shm), GFP_KERNEL);
 	if (!shm) {
 		ret =3D ERR_PTR(-ENOMEM);
-		goto err_ctx_put;
+		goto err_dev_put;
 	}
=20
 	refcount_set(&shm->refcount, 1);
@@ -313,7 +301,7 @@ register_shm_helper(struct tee_context *ctx, struct iov_i=
ter *iter, u32 flags,
 	num_pages =3D iov_iter_npages(iter, INT_MAX);
 	if (!num_pages) {
 		ret =3D ERR_PTR(-ENOMEM);
-		goto err_ctx_put;
+		goto err_dev_put;
 	}
=20
 	shm->pages =3D kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
@@ -361,8 +349,6 @@ register_shm_helper(struct tee_context *ctx, struct iov_i=
ter *iter, u32 flags,
 	kfree(shm->pages);
 err_free_shm:
 	kfree(shm);
-err_ctx_put:
-	teedev_ctx_put(ctx);
 err_dev_put:
 	tee_device_put(teedev);
 	return ret;
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index a38494d6b5f4..13393ddac530 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -44,6 +44,7 @@
  * @idr:	register of user space shared memory objects allocated or
  *		registered on this device
  * @pool:	shared memory pool
+ * @def_ctx:	default context used if there is no context available, e.g. int=
ernal driver calls.
  */
 struct tee_device {
 	char name[TEE_MAX_DEV_NAME_LEN];
@@ -60,6 +61,7 @@ struct tee_device {
=20
 	struct idr idr;
 	struct tee_shm_pool *pool;
+	struct tee_context def_ctx;
 };
=20
 /**
@@ -309,6 +311,19 @@ static inline bool tee_param_is_memref(struct tee_param =
*param)
  */
 struct tee_context *teedev_open(struct tee_device *teedev);
=20
+/**
+ * teedev_get_def_context() - Get default context for a struct tee_device
+ * @teedev:	Device to open
+ *
+ * Unlike a context that returned from teedev_open(), the default context is=
 static
+ * and available as long as @teedev has a user ''other then this context''. =
This context
+ * can be used for driver internal operation and clean up where a context sh=
ould be
+ * available, while tee_device_unregister() is waiting for other users to go=
 away.
+ *
+ * @return a pointer to struct tee_context on success or an ERR_PTR on failu=
re.
+ */
+struct tee_context *teedev_get_def_context(struct tee_device *teedev);
+
 /**
  * teedev_close_context() - closes a struct tee_context
  * @ctx:	The struct tee_context to close
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 1b57cddfecc8..9633e14ba484 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -7,7 +7,6 @@
 #define __TEE_DRV_H
=20
 #include <linux/device.h>
-#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mod_devicetable.h>
 #include <linux/tee.h>
@@ -25,10 +24,6 @@ struct tee_device;
  * @teedev:	pointer to this drivers struct tee_device
  * @list_shm:	List of shared memory object owned by this context
  * @data:	driver specific context data, managed by the driver
- * @refcount:	reference counter for this structure
- * @releasing:  flag that indicates if context is being released right now.
- *		It is needed to break circular dependency on context during
- *              shared memory release.
  * @supp_nowait: flag that indicates that requests in this context should not
  *              wait for tee-supplicant daemon to be started if not present
  *              and just return with an error code. It is needed for requests
@@ -41,8 +36,6 @@ struct tee_context {
 	struct tee_device *teedev;
 	struct list_head list_shm;
 	void *data;
-	struct kref refcount;
-	bool releasing;
 	bool supp_nowait;
 	bool cap_memref_null;
 };

--=20
2.34.1


--===============5531421419070779266==--

