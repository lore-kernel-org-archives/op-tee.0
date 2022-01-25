From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 09/12] tee: add tee_shm_register_{user,kernel}_buf()
Date: Tue, 25 Jan 2022 17:29:35 +0100
Message-ID: <20220125162938.838382-10-jens.wiklander@linaro.org>
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1840454674820839419=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1840454674820839419==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds the two new functions tee_shm_register_user_buf() and
tee_shm_register_kernel_buf() which should be used instead of the old
tee_shm_register().

This avoids having the caller supplying the flags parameter which
exposes a bit more than desired of the internals of the TEE subsystem.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c    |  3 +--
 drivers/tee/tee_private.h |  2 ++
 drivers/tee/tee_shm.c     | 33 +++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h   |  2 ++
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index a15812baaeb1..8aa1a4836b92 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -334,8 +334,7 @@ tee_ioctl_shm_register(struct tee_context *ctx,
 	if (data.flags)
 		return -EINVAL;
=20
-	shm =3D tee_shm_register(ctx, data.addr, data.length,
-			       TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
+	shm =3D tee_shm_register_user_buf(ctx, data.addr, data.length);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
=20
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 7265f47c6d8e..409cadcc1cff 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -58,5 +58,7 @@ void teedev_ctx_get(struct tee_context *ctx);
 void teedev_ctx_put(struct tee_context *ctx);
=20
 struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
+struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
+					  unsigned long addr, size_t length);
=20
 #endif /*TEE_PRIVATE_H*/
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index dc02afd7b5c9..0b6f7aabbf88 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -299,6 +299,39 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx=
, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(tee_shm_register);
=20
+/**
+ * tee_shm_register_user_buf() - Register a userspace shared memory buffer
+ * @ctx:	Context that registers the shared memory
+ * @addr:	The userspace address of the shared buffer
+ * @length:	Length of the shared buffer
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
+					  unsigned long addr, size_t length)
+{
+	return tee_shm_register(ctx, addr, length,
+				TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
+}
+
+/**
+ * tee_shm_register_kernel_buf() - Register kernel memory to be shared with
+ *				   secure world
+ * @ctx:	Context that registers the shared memory
+ * @addr:	The buffer
+ * @length:	Length of the buffer
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+
+struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
+					    void *addr, size_t length)
+{
+	return tee_shm_register(ctx, (unsigned long)addr, length,
+				TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
+}
+EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
+
 static int tee_shm_fop_release(struct inode *inode, struct file *filp)
 {
 	tee_shm_put(filp->private_data);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 7f038f8787c7..c9d2cc32a5ed 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -287,6 +287,8 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_conte=
xt *ctx, size_t size);
  */
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags);
+struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
+					    void *addr, size_t length);
=20
 /**
  * tee_shm_is_registered() - Check if shared memory object in registered in =
TEE
--=20
2.31.1


--===============1840454674820839419==--

