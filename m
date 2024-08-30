From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 1/4] dma-buf: heaps: restricted_heap: add no_map attribute
Date: Fri, 30 Aug 2024 09:03:48 +0200
Message-ID: <20240830070351.2855919-2-jens.wiklander@linaro.org>
In-Reply-To: <20240830070351.2855919-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3635296358225256424=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3635296358225256424==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add a no_map attribute to struct restricted_heap_attachment and struct
restricted_heap to skip the call to dma_map_sgtable() if set. This
avoids trying to map a dma-buf that doens't refer to memory accessible
by the kernel.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/dma-buf/heaps/restricted_heap.c | 17 +++++++++++++----
 drivers/dma-buf/heaps/restricted_heap.h |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/heaps/restricted_heap.c b/drivers/dma-buf/heaps/=
restricted_heap.c
index 8bc8a5e3f969..4bf28e3727ca 100644
--- a/drivers/dma-buf/heaps/restricted_heap.c
+++ b/drivers/dma-buf/heaps/restricted_heap.c
@@ -16,6 +16,7 @@
 struct restricted_heap_attachment {
 	struct sg_table			*table;
 	struct device			*dev;
+	bool no_map;
 };
=20
 static int
@@ -54,6 +55,8 @@ restricted_heap_memory_free(struct restricted_heap *rheap, =
struct restricted_buf
 static int restricted_heap_attach(struct dma_buf *dmabuf, struct dma_buf_att=
achment *attachment)
 {
 	struct restricted_buffer *restricted_buf =3D dmabuf->priv;
+	struct dma_heap *heap =3D restricted_buf->heap;
+	struct restricted_heap *rheap =3D dma_heap_get_drvdata(heap);
 	struct restricted_heap_attachment *a;
 	struct sg_table *table;
=20
@@ -70,6 +73,7 @@ static int restricted_heap_attach(struct dma_buf *dmabuf, s=
truct dma_buf_attachm
 	sg_dma_mark_restricted(table->sgl);
 	a->table =3D table;
 	a->dev =3D attachment->dev;
+	a->no_map =3D rheap->no_map;
 	attachment->priv =3D a;
=20
 	return 0;
@@ -92,9 +96,12 @@ restricted_heap_map_dma_buf(struct dma_buf_attachment *att=
achment,
 	struct sg_table *table =3D a->table;
 	int ret;
=20
-	ret =3D dma_map_sgtable(attachment->dev, table, direction, DMA_ATTR_SKIP_CP=
U_SYNC);
-	if (ret)
-		return ERR_PTR(ret);
+	if (!a->no_map) {
+		ret =3D dma_map_sgtable(attachment->dev, table, direction,
+				      DMA_ATTR_SKIP_CPU_SYNC);
+		if (ret)
+			return ERR_PTR(ret);
+	}
 	return table;
 }
=20
@@ -106,7 +113,9 @@ restricted_heap_unmap_dma_buf(struct dma_buf_attachment *=
attachment, struct sg_t
=20
 	WARN_ON(a->table !=3D table);
=20
-	dma_unmap_sgtable(attachment->dev, table, direction, DMA_ATTR_SKIP_CPU_SYNC=
);
+	if (!a->no_map)
+		dma_unmap_sgtable(attachment->dev, table, direction,
+				  DMA_ATTR_SKIP_CPU_SYNC);
 }
=20
 static int
diff --git a/drivers/dma-buf/heaps/restricted_heap.h b/drivers/dma-buf/heaps/=
restricted_heap.h
index 7dec4b8a471b..94cc0842f70d 100644
--- a/drivers/dma-buf/heaps/restricted_heap.h
+++ b/drivers/dma-buf/heaps/restricted_heap.h
@@ -27,6 +27,8 @@ struct restricted_heap {
 	unsigned long		cma_paddr;
 	unsigned long		cma_size;
=20
+	bool			no_map;
+
 	void			*priv_data;
 };
=20
--=20
2.34.1


--===============3635296358225256424==--

