From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH RFC 2/3] tee: revert removal of linked list of struct tee_shm
Date: Wed, 20 Nov 2024 17:37:16 -0800
Message-ID: 
 <20241120-fix-tee_shm-refcount-upstream-v1-2-5da97f584fcd@quicinc.com>
In-Reply-To: <
 <20241120-fix-tee_shm-refcount-upstream-v1-0-5da97f584fcd@quicinc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9060303873897114716=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9060303873897114716==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Partially revert commit 59a135f6fb66 ("tee: remove linked list of
struct tee_shm"). Reintroduce the linked list to track all tee_shm
instances associated with a context.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
 drivers/tee/tee_core.c  |  1 +
 drivers/tee/tee_shm.c   | 13 +++++++++++++
 include/linux/tee_drv.h |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d113679b1e2d..93f3b330aec8 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -59,6 +59,7 @@ struct tee_context *teedev_open(struct tee_device *teedev)
=20
 	kref_init(&ctx->refcount);
 	ctx->teedev =3D teedev;
+	INIT_LIST_HEAD(&ctx->list_shm);
 	rc =3D teedev->desc->ops->open(ctx);
 	if (rc)
 		goto err;
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 31e032446cf5..c0164c0f4a01 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -108,6 +108,10 @@ static struct tee_shm *shm_alloc_helper(struct tee_conte=
xt *ctx, size_t size,
 		goto err_kfree;
 	}
=20
+	mutex_lock(&teedev->mutex);
+	list_add_tail(&shm->link, &ctx->list_shm);
+	mutex_unlock(&teedev->mutex);
+
 	teedev_ctx_get(ctx);
 	return shm;
 err_kfree:
@@ -343,6 +347,10 @@ register_shm_helper(struct tee_context *ctx, struct iov_=
iter *iter, u32 flags,
 		goto err_put_shm_pages;
 	}
=20
+	mutex_lock(&teedev->mutex);
+	list_add_tail(&shm->link, &ctx->list_shm);
+	mutex_unlock(&teedev->mutex);
+
 	return shm;
 err_put_shm_pages:
 	if (!iov_iter_is_kvec(iter))
@@ -577,6 +585,11 @@ void tee_shm_put(struct tee_shm *shm)
 		 */
 		if (shm->id >=3D 0)
 			idr_remove(&teedev->idr, shm->id);
+
+		/* The context owns shm may be gone already. */
+		if (shm->ctx)
+			list_del(&shm->link);
+
 		do_release =3D true;
 	}
 	mutex_unlock(&teedev->mutex);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 56560441b2cb..1b57cddfecc8 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -23,6 +23,7 @@ struct tee_device;
 /**
  * struct tee_context - driver specific context on file pointer data
  * @teedev:	pointer to this drivers struct tee_device
+ * @list_shm:	List of shared memory object owned by this context
  * @data:	driver specific context data, managed by the driver
  * @refcount:	reference counter for this structure
  * @releasing:  flag that indicates if context is being released right now.
@@ -38,6 +39,7 @@ struct tee_device;
  */
 struct tee_context {
 	struct tee_device *teedev;
+	struct list_head list_shm;
 	void *data;
 	struct kref refcount;
 	bool releasing;
@@ -49,6 +51,7 @@ struct tee_context {
  * struct tee_shm - shared memory object
  * @teedev:	device used to allocate the object
  * @ctx:	context using the object
+ * @link	link element
  * @paddr:	physical address of the shared memory
  * @kaddr:	virtual address of the shared memory
  * @size:	size of shared memory
@@ -66,6 +69,7 @@ struct tee_context {
 struct tee_shm {
 	struct tee_device *teedev;
 	struct tee_context *ctx;
+	struct list_head link;
 	phys_addr_t paddr;
 	void *kaddr;
 	size_t size;

--=20
2.34.1


--===============9060303873897114716==--

