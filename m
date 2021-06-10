From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4 5/8] tee: add tee_shm_alloc_kernel_buf()
Date: Thu, 10 Jun 2021 16:09:10 -0500
Message-ID: <20210610210913.536081-6-tyhicks@linux.microsoft.com>
In-Reply-To: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2806471792551184473=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2806471792551184473==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Jens Wiklander <jens.wiklander@linaro.org>

Adds a new function tee_shm_alloc_kernel_buf() to allocate shared memory
from a kernel driver. This function can later be made more lightweight
by unnecessary dma-buf export.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/tee_shm.c   | 18 ++++++++++++++++++
 include/linux/tee_drv.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 00472f5ce22e..c65e44707cd6 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -193,6 +193,24 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, s=
ize_t size, u32 flags)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc);
=20
+/**
+ * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
+ * @ctx:	Context that allocates the shared memory
+ * @size:	Requested size of shared memory
+ *
+ * The returned memory registered in secure world and is suitable to be
+ * passed as a memory buffer in parameter argument to
+ * tee_client_invoke_func(). The memory allocated is later freed with a
+ * call to tee_shm_free().
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t siz=
e)
+{
+	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+}
+EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
+
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 54269e47ac9a..8990f7628387 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -332,6 +332,7 @@ void *tee_get_drvdata(struct tee_device *teedev);
  * @returns a pointer to 'struct tee_shm'
  */
 struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flag=
s);
+struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t siz=
e);
=20
 /**
  * tee_shm_register() - Register shared memory buffer
--=20
2.25.1


--===============2806471792551184473==--

