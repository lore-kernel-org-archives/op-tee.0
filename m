From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v6 05/10] tee: implement restricted DMA-heap
Date: Wed, 05 Mar 2025 14:04:11 +0100
Message-ID: <20250305130634.1850178-6-jens.wiklander@linaro.org>
In-Reply-To: <20250305130634.1850178-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4669462078641169546=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4669462078641169546==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Implement DMA heap for restricted DMA-buf allocation in the TEE
subsystem.

Restricted memory refers to memory buffers behind a hardware enforced
firewall. It is not accessible to the kernel during normal circumstances
but rather only accessible to certain hardware IPs or CPUs executing in
higher or differently privileged mode than the kernel itself. This
interface allows to allocate and manage such restricted memory buffers
via interaction with a TEE implementation.

The restricted memory is allocated for a specific use-case, like Secure
Video Playback, Trusted UI, or Secure Video Recording where certain
hardware devices can access the memory.

The DMA-heaps are enabled explicitly by the TEE backend driver. The TEE
backend drivers needs to implement restricted memory pool to manage the
restricted memory.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/Makefile      |   1 +
 drivers/tee/tee_heap.c    | 470 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/tee_private.h |   6 +
 include/linux/tee_core.h  |  62 +++++
 4 files changed, 539 insertions(+)
 create mode 100644 drivers/tee/tee_heap.c

diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
index 5488cba30bd2..949a6a79fb06 100644
--- a/drivers/tee/Makefile
+++ b/drivers/tee/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEE) +=3D tee.o
 tee-objs +=3D tee_core.o
+tee-objs +=3D tee_heap.o
 tee-objs +=3D tee_shm.o
 tee-objs +=3D tee_shm_pool.o
 obj-$(CONFIG_OPTEE) +=3D optee/
diff --git a/drivers/tee/tee_heap.c b/drivers/tee/tee_heap.c
new file mode 100644
index 000000000000..476ab2e27260
--- /dev/null
+++ b/drivers/tee/tee_heap.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Linaro Limited
+ */
+
+#include <linux/scatterlist.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+#include <linux/genalloc.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/tee_core.h>
+#include <linux/xarray.h>
+
+#include "tee_private.h"
+
+struct tee_dma_heap {
+	struct dma_heap *heap;
+	enum tee_dma_heap_id id;
+	struct tee_rstmem_pool *pool;
+	struct tee_device *teedev;
+	/* Protects pool and teedev above */
+	struct mutex mu;
+};
+
+struct tee_heap_buffer {
+	struct tee_rstmem_pool *pool;
+	struct tee_device *teedev;
+	size_t size;
+	size_t offs;
+	struct sg_table table;
+};
+
+struct tee_heap_attachment {
+	struct sg_table table;
+	struct device *dev;
+};
+
+struct tee_rstmem_static_pool {
+	struct tee_rstmem_pool pool;
+	struct gen_pool *gen_pool;
+	phys_addr_t pa_base;
+};
+
+#if !IS_MODULE(CONFIG_TEE) && IS_ENABLED(CONFIG_DMABUF_HEAPS)
+static DEFINE_XARRAY_ALLOC(tee_dma_heap);
+
+static int copy_sg_table(struct sg_table *dst, struct sg_table *src)
+{
+	struct scatterlist *dst_sg;
+	struct scatterlist *src_sg;
+	int ret;
+	int i;
+
+	ret =3D sg_alloc_table(dst, src->orig_nents, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	dst_sg =3D dst->sgl;
+	for_each_sgtable_sg(src, src_sg, i) {
+		sg_set_page(dst_sg, sg_page(src_sg), src_sg->length,
+			    src_sg->offset);
+		dst_sg =3D sg_next(dst_sg);
+	}
+
+	return 0;
+}
+
+static int tee_heap_attach(struct dma_buf *dmabuf,
+			   struct dma_buf_attachment *attachment)
+{
+	struct tee_heap_buffer *buf =3D dmabuf->priv;
+	struct tee_heap_attachment *a;
+	int ret;
+
+	a =3D kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	ret =3D copy_sg_table(&a->table, &buf->table);
+	if (ret) {
+		kfree(a);
+		return ret;
+	}
+
+	a->dev =3D attachment->dev;
+	attachment->priv =3D a;
+
+	return 0;
+}
+
+static void tee_heap_detach(struct dma_buf *dmabuf,
+			    struct dma_buf_attachment *attachment)
+{
+	struct tee_heap_attachment *a =3D attachment->priv;
+
+	sg_free_table(&a->table);
+	kfree(a);
+}
+
+static struct sg_table *
+tee_heap_map_dma_buf(struct dma_buf_attachment *attachment,
+		     enum dma_data_direction direction)
+{
+	struct tee_heap_attachment *a =3D attachment->priv;
+	int ret;
+
+	ret =3D dma_map_sgtable(attachment->dev, &a->table, direction,
+			      DMA_ATTR_SKIP_CPU_SYNC);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &a->table;
+}
+
+static void tee_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				   struct sg_table *table,
+				   enum dma_data_direction direction)
+{
+	struct tee_heap_attachment *a =3D attachment->priv;
+
+	WARN_ON(&a->table !=3D table);
+
+	dma_unmap_sgtable(attachment->dev, table, direction,
+			  DMA_ATTR_SKIP_CPU_SYNC);
+}
+
+static void tee_heap_buf_free(struct dma_buf *dmabuf)
+{
+	struct tee_heap_buffer *buf =3D dmabuf->priv;
+	struct tee_device *teedev =3D buf->teedev;
+
+	buf->pool->ops->free(buf->pool, &buf->table);
+	tee_device_put(teedev);
+}
+
+static const struct dma_buf_ops tee_heap_buf_ops =3D {
+	.attach =3D tee_heap_attach,
+	.detach =3D tee_heap_detach,
+	.map_dma_buf =3D tee_heap_map_dma_buf,
+	.unmap_dma_buf =3D tee_heap_unmap_dma_buf,
+	.release =3D tee_heap_buf_free,
+};
+
+static struct dma_buf *tee_dma_heap_alloc(struct dma_heap *heap,
+					  unsigned long len, u32 fd_flags,
+					  u64 heap_flags)
+{
+	struct tee_dma_heap *h =3D dma_heap_get_drvdata(heap);
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct tee_device *teedev =3D NULL;
+	struct tee_heap_buffer *buf;
+	struct tee_rstmem_pool *pool;
+	struct dma_buf *dmabuf;
+	int rc;
+
+	mutex_lock(&h->mu);
+	if (tee_device_get(h->teedev)) {
+		teedev =3D h->teedev;
+		pool =3D h->pool;
+	}
+	mutex_unlock(&h->mu);
+
+	if (!teedev)
+		return ERR_PTR(-EINVAL);
+
+	buf =3D kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf) {
+		dmabuf =3D ERR_PTR(-ENOMEM);
+		goto err;
+	}
+	buf->size =3D len;
+	buf->pool =3D pool;
+	buf->teedev =3D teedev;
+
+	rc =3D pool->ops->alloc(pool, &buf->table, len, &buf->offs);
+	if (rc) {
+		dmabuf =3D ERR_PTR(rc);
+		goto err_kfree;
+	}
+
+	exp_info.ops =3D &tee_heap_buf_ops;
+	exp_info.size =3D len;
+	exp_info.priv =3D buf;
+	exp_info.flags =3D fd_flags;
+	dmabuf =3D dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf))
+		goto err_rstmem_free;
+
+	return dmabuf;
+
+err_rstmem_free:
+	pool->ops->free(pool, &buf->table);
+err_kfree:
+	kfree(buf);
+err:
+	tee_device_put(h->teedev);
+	return dmabuf;
+}
+
+static const struct dma_heap_ops tee_dma_heap_ops =3D {
+	.allocate =3D tee_dma_heap_alloc,
+};
+
+static const char *heap_id_2_name(enum tee_dma_heap_id id)
+{
+	switch (id) {
+	case TEE_DMA_HEAP_SECURE_VIDEO_PLAY:
+		return "restricted,secure-video";
+	case TEE_DMA_HEAP_TRUSTED_UI:
+		return "restricted,trusted-ui";
+	case TEE_DMA_HEAP_SECURE_VIDEO_RECORD:
+		return "restricted,secure-video-record";
+	default:
+		return NULL;
+	}
+}
+
+static int alloc_dma_heap(struct tee_device *teedev, enum tee_dma_heap_id id,
+			  struct tee_rstmem_pool *pool)
+{
+	struct dma_heap_export_info exp_info =3D {
+		.ops =3D &tee_dma_heap_ops,
+		.name =3D heap_id_2_name(id),
+	};
+	struct tee_dma_heap *h;
+	int rc;
+
+	if (!exp_info.name)
+		return -EINVAL;
+
+	if (xa_reserve(&tee_dma_heap, id, GFP_KERNEL)) {
+		if (!xa_load(&tee_dma_heap, id))
+			return -EEXIST;
+		return -ENOMEM;
+	}
+
+	h =3D kzalloc(sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+	h->id =3D id;
+	h->teedev =3D teedev;
+	h->pool =3D pool;
+	mutex_init(&h->mu);
+
+	exp_info.priv =3D h;
+	h->heap =3D dma_heap_add(&exp_info);
+	if (IS_ERR(h->heap)) {
+		rc =3D PTR_ERR(h->heap);
+		kfree(h);
+
+		return rc;
+	}
+
+	/* "can't fail" due to the call to xa_reserve() above */
+	return WARN(xa_store(&tee_dma_heap, id, h, GFP_KERNEL),
+		    "xa_store() failed");
+}
+
+int tee_device_register_dma_heap(struct tee_device *teedev,
+				 enum tee_dma_heap_id id,
+				 struct tee_rstmem_pool *pool)
+{
+	struct tee_dma_heap *h;
+	int rc;
+
+	h =3D xa_load(&tee_dma_heap, id);
+	if (h) {
+		mutex_lock(&h->mu);
+		if (h->teedev) {
+			rc =3D -EBUSY;
+		} else {
+			h->teedev =3D teedev;
+			h->pool =3D pool;
+			rc =3D 0;
+		}
+		mutex_unlock(&h->mu);
+	} else {
+		rc =3D alloc_dma_heap(teedev, id, pool);
+	}
+
+	if (rc)
+		dev_err(&teedev->dev, "can't register DMA heap id %d (%s)\n",
+			id, heap_id_2_name(id));
+
+	return rc;
+}
+
+void tee_device_unregister_all_dma_heaps(struct tee_device *teedev)
+{
+	struct tee_rstmem_pool *pool;
+	struct tee_dma_heap *h;
+	u_long i;
+
+	xa_for_each(&tee_dma_heap, i, h) {
+		if (h) {
+			pool =3D NULL;
+			mutex_lock(&h->mu);
+			if (h->teedev =3D=3D teedev) {
+				pool =3D h->pool;
+				h->teedev =3D NULL;
+				h->pool =3D NULL;
+			}
+			mutex_unlock(&h->mu);
+			if (pool)
+				pool->ops->destroy_pool(pool);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
+
+int tee_heap_update_from_dma_buf(struct tee_device *teedev,
+				 struct dma_buf *dmabuf, size_t *offset,
+				 struct tee_shm *shm,
+				 struct tee_shm **parent_shm)
+{
+	struct tee_heap_buffer *buf;
+	int rc;
+
+	/* The DMA-buf must be from our heap */
+	if (dmabuf->ops !=3D &tee_heap_buf_ops)
+		return -EINVAL;
+
+	buf =3D dmabuf->priv;
+	/* The buffer must be from the same teedev */
+	if (buf->teedev !=3D teedev)
+		return -EINVAL;
+
+	shm->size =3D buf->size;
+
+	rc =3D buf->pool->ops->update_shm(buf->pool, &buf->table, buf->offs, shm,
+					parent_shm);
+	if (!rc && *parent_shm)
+		*offset =3D buf->offs;
+
+	return rc;
+}
+#else
+int tee_device_register_dma_heap(struct tee_device *teedev __always_unused,
+				 enum tee_dma_heap_id id __always_unused,
+				 struct tee_rstmem_pool *pool __always_unused)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(tee_device_register_dma_heap);
+
+void
+tee_device_unregister_all_dma_heaps(struct tee_device *teedev __always_unuse=
d)
+{
+}
+EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
+
+int tee_heap_update_from_dma_buf(struct tee_device *teedev __always_unused,
+				 struct dma_buf *dmabuf __always_unused,
+				 size_t *offset __always_unused,
+				 struct tee_shm *shm __always_unused,
+				 struct tee_shm **parent_shm __always_unused)
+{
+	return -EINVAL;
+}
+#endif
+
+static struct tee_rstmem_static_pool *
+to_rstmem_static_pool(struct tee_rstmem_pool *pool)
+{
+	return container_of(pool, struct tee_rstmem_static_pool, pool);
+}
+
+static int rstmem_pool_op_static_alloc(struct tee_rstmem_pool *pool,
+				       struct sg_table *sgt, size_t size,
+				       size_t *offs)
+{
+	struct tee_rstmem_static_pool *stp =3D to_rstmem_static_pool(pool);
+	phys_addr_t pa;
+	int ret;
+
+	pa =3D gen_pool_alloc(stp->gen_pool, size);
+	if (!pa)
+		return -ENOMEM;
+
+	ret =3D sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (ret) {
+		gen_pool_free(stp->gen_pool, pa, size);
+		return ret;
+	}
+
+	sg_set_page(sgt->sgl, phys_to_page(pa), size, 0);
+	*offs =3D pa - stp->pa_base;
+
+	return 0;
+}
+
+static void rstmem_pool_op_static_free(struct tee_rstmem_pool *pool,
+				       struct sg_table *sgt)
+{
+	struct tee_rstmem_static_pool *stp =3D to_rstmem_static_pool(pool);
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sgtable_sg(sgt, sg, i)
+		gen_pool_free(stp->gen_pool, sg_phys(sg), sg->length);
+	sg_free_table(sgt);
+}
+
+static int rstmem_pool_op_static_update_shm(struct tee_rstmem_pool *pool,
+					    struct sg_table *sgt, size_t offs,
+					    struct tee_shm *shm,
+					    struct tee_shm **parent_shm)
+{
+	struct tee_rstmem_static_pool *stp =3D to_rstmem_static_pool(pool);
+
+	shm->paddr =3D stp->pa_base + offs;
+	*parent_shm =3D NULL;
+
+	return 0;
+}
+
+static void rstmem_pool_op_static_destroy_pool(struct tee_rstmem_pool *pool)
+{
+	struct tee_rstmem_static_pool *stp =3D to_rstmem_static_pool(pool);
+
+	gen_pool_destroy(stp->gen_pool);
+	kfree(stp);
+}
+
+static struct tee_rstmem_pool_ops rstmem_pool_ops_static =3D {
+	.alloc =3D rstmem_pool_op_static_alloc,
+	.free =3D rstmem_pool_op_static_free,
+	.update_shm =3D rstmem_pool_op_static_update_shm,
+	.destroy_pool =3D rstmem_pool_op_static_destroy_pool,
+};
+
+struct tee_rstmem_pool *tee_rstmem_static_pool_alloc(phys_addr_t paddr,
+						     size_t size)
+{
+	const size_t page_mask =3D PAGE_SIZE - 1;
+	struct tee_rstmem_static_pool *stp;
+	int rc;
+
+	/* Check it's page aligned */
+	if ((paddr | size) & page_mask)
+		return ERR_PTR(-EINVAL);
+
+	stp =3D kzalloc(sizeof(*stp), GFP_KERNEL);
+	if (!stp)
+		return ERR_PTR(-ENOMEM);
+
+	stp->gen_pool =3D gen_pool_create(PAGE_SHIFT, -1);
+	if (!stp->gen_pool) {
+		rc =3D -ENOMEM;
+		goto err_free;
+	}
+
+	rc =3D gen_pool_add(stp->gen_pool, paddr, size, -1);
+	if (rc)
+		goto err_free_pool;
+
+	stp->pool.ops =3D &rstmem_pool_ops_static;
+	stp->pa_base =3D paddr;
+	return &stp->pool;
+
+err_free_pool:
+	gen_pool_destroy(stp->gen_pool);
+err_free:
+	kfree(stp);
+
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_GPL(tee_rstmem_static_pool_alloc);
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 9bc50605227c..6c6ff5d5eed2 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -8,6 +8,7 @@
 #include <linux/cdev.h>
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/dma-buf.h>
 #include <linux/kref.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
@@ -24,4 +25,9 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *=
ctx, size_t size);
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length);
=20
+int tee_heap_update_from_dma_buf(struct tee_device *teedev,
+				 struct dma_buf *dmabuf, size_t *offset,
+				 struct tee_shm *shm,
+				 struct tee_shm **parent_shm);
+
 #endif /*TEE_PRIVATE_H*/
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index a38494d6b5f4..16ef078247ae 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -8,9 +8,11 @@
=20
 #include <linux/cdev.h>
 #include <linux/device.h>
+#include <linux/dma-buf.h>
 #include <linux/idr.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/scatterlist.h>
 #include <linux/tee.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
@@ -30,6 +32,12 @@
 #define TEE_DEVICE_FLAG_REGISTERED	0x1
 #define TEE_MAX_DEV_NAME_LEN		32
=20
+enum tee_dma_heap_id {
+	TEE_DMA_HEAP_SECURE_VIDEO_PLAY =3D 1,
+	TEE_DMA_HEAP_TRUSTED_UI,
+	TEE_DMA_HEAP_SECURE_VIDEO_RECORD,
+};
+
 /**
  * struct tee_device - TEE Device representation
  * @name:	name of device
@@ -116,6 +124,33 @@ struct tee_desc {
 	u32 flags;
 };
=20
+/**
+ * struct tee_rstmem_pool - restricted memory pool
+ * @ops:		operations
+ *
+ * This is an abstract interface where this struct is expected to be
+ * embedded in another struct specific to the implementation.
+ */
+struct tee_rstmem_pool {
+	const struct tee_rstmem_pool_ops *ops;
+};
+
+/**
+ * struct tee_rstmem_pool_ops - restricted memory pool operations
+ * @alloc:		called when allocating restricted memory
+ * @free:		called when freeing restricted memory
+ * @destroy_pool:	called when destroying the pool
+ */
+struct tee_rstmem_pool_ops {
+	int (*alloc)(struct tee_rstmem_pool *pool, struct sg_table *sgt,
+		     size_t size, size_t *offs);
+	void (*free)(struct tee_rstmem_pool *pool, struct sg_table *sgt);
+	int (*update_shm)(struct tee_rstmem_pool *pool, struct sg_table *sgt,
+			  size_t offs, struct tee_shm *shm,
+			  struct tee_shm **parent_shm);
+	void (*destroy_pool)(struct tee_rstmem_pool *pool);
+};
+
 /**
  * tee_device_alloc() - Allocate a new struct tee_device instance
  * @teedesc:	Descriptor for this driver
@@ -154,6 +189,11 @@ int tee_device_register(struct tee_device *teedev);
  */
 void tee_device_unregister(struct tee_device *teedev);
=20
+int tee_device_register_dma_heap(struct tee_device *teedev,
+				 enum tee_dma_heap_id id,
+				 struct tee_rstmem_pool *pool);
+void tee_device_unregister_all_dma_heaps(struct tee_device *teedev);
+
 /**
  * tee_device_set_dev_groups() - Set device attribute groups
  * @teedev:	Device to register
@@ -229,6 +269,28 @@ static inline void tee_shm_pool_free(struct tee_shm_pool=
 *pool)
 	pool->ops->destroy_pool(pool);
 }
=20
+/**
+ * tee_rstmem_static_pool_alloc() - Create a restricted memory manager
+ * @paddr:	Physical address of start of pool
+ * @size:	Size in bytes of the pool
+ *
+ * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
+ */
+struct tee_rstmem_pool *tee_rstmem_static_pool_alloc(phys_addr_t paddr,
+						     size_t size);
+
+/**
+ * tee_rstmem_pool_free() - Free a restricted memory pool
+ * @pool:	The restricted memory pool to free
+ *
+ * There must be no remaining restricted memory allocated from this pool
+ * when this function is called.
+ */
+static inline void tee_rstmem_pool_free(struct tee_rstmem_pool *pool)
+{
+	pool->ops->destroy_pool(pool);
+}
+
 /**
  * tee_get_drvdata() - Return driver_data pointer
  * @returns the driver_data pointer supplied to tee_register().
--=20
2.43.0


--===============4669462078641169546==--

