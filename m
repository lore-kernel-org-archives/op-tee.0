From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 3/7] tee: add tee_shm_alloc_kernel_buf()
Date: Wed, 09 Jun 2021 12:23:20 +0200
Message-ID: <20210609102324.2222332-4-jens.wiklander@linaro.org>
In-Reply-To: <20210609102324.2222332-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0675360196393725645=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0675360196393725645==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds a new function tee_shm_alloc_kernel_buf() to allocate shared memory
from a kernel driver. This function can later be made more lightweight
by unnecessary dma-buf export.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c   | 18 ++++++++++++++++++
 include/linux/tee_drv.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index b9dbf4bce149..63fce8d39d8b 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -192,6 +192,24 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, s=
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
index 62b7c7a55743..58b319766f8e 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -282,6 +282,7 @@ void *tee_get_drvdata(struct tee_device *teedev);
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
2.31.1


--===============0675360196393725645==--

