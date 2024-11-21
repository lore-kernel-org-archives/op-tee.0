From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH RFC 1/3] tee: revert removal of redundant teedev in struct tee_shm
Date: Wed, 20 Nov 2024 17:37:15 -0800
Message-ID: 
 <20241120-fix-tee_shm-refcount-upstream-v1-1-5da97f584fcd@quicinc.com>
In-Reply-To: <
 <20241120-fix-tee_shm-refcount-upstream-v1-0-5da97f584fcd@quicinc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6017045454385710501=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6017045454385710501==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

In commit 5271b2011e44 ("tee: remove redundant teedev in struct tee_shm"),
the reference to teedev was removed following the change in
commit 217e0250cccb ("tee: use reference counting for tee_context").
This change ensured that the ctx in tee_shm remains valid as long as the
shared buffer is valid, and teedev is accessible from ctx. It made teedev
in tee_shm redundant.

Reintroduce teedev to tee_shm to facilitate the introduction of orphan
shared memory, which may not be linked to the context it was originally
associated with.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
 drivers/tee/tee_shm.c   | 10 +++++++---
 include/linux/tee_drv.h |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..31e032446cf5 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -43,8 +43,10 @@ static void release_registered_pages(struct tee_shm *shm)
 	}
 }
=20
-static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
+static void tee_shm_release(struct tee_shm *shm)
 {
+	struct tee_device *teedev =3D shm->teedev;
+
 	if (shm->flags & TEE_SHM_POOL) {
 		teedev->pool->ops->free(teedev->pool, shm);
 	} else if (shm->flags & TEE_SHM_DYNAMIC) {
@@ -89,6 +91,7 @@ static struct tee_shm *shm_alloc_helper(struct tee_context =
*ctx, size_t size,
=20
 	refcount_set(&shm->refcount, 1);
 	shm->flags =3D flags;
+	shm->teedev =3D teedev;
 	shm->id =3D id;
=20
 	/*
@@ -298,6 +301,7 @@ register_shm_helper(struct tee_context *ctx, struct iov_i=
ter *iter, u32 flags,
=20
 	refcount_set(&shm->refcount, 1);
 	shm->flags =3D flags;
+	shm->teedev =3D teedev;
 	shm->ctx =3D ctx;
 	shm->id =3D id;
 	addr =3D untagged_addr((unsigned long)iter_iov_addr(iter));
@@ -560,7 +564,7 @@ EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
  */
 void tee_shm_put(struct tee_shm *shm)
 {
-	struct tee_device *teedev =3D shm->ctx->teedev;
+	struct tee_device *teedev =3D shm->teedev;
 	bool do_release =3D false;
=20
 	mutex_lock(&teedev->mutex);
@@ -578,6 +582,6 @@ void tee_shm_put(struct tee_shm *shm)
 	mutex_unlock(&teedev->mutex);
=20
 	if (do_release)
-		tee_shm_release(teedev, shm);
+		tee_shm_release(shm);
 }
 EXPORT_SYMBOL_GPL(tee_shm_put);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index a54c203000ed..56560441b2cb 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -47,6 +47,7 @@ struct tee_context {
=20
 /**
  * struct tee_shm - shared memory object
+ * @teedev:	device used to allocate the object
  * @ctx:	context using the object
  * @paddr:	physical address of the shared memory
  * @kaddr:	virtual address of the shared memory
@@ -63,6 +64,7 @@ struct tee_context {
  *		used by all drivers
  */
 struct tee_shm {
+	struct tee_device *teedev;
 	struct tee_context *ctx;
 	phys_addr_t paddr;
 	void *kaddr;

--=20
2.34.1


--===============6017045454385710501==--

