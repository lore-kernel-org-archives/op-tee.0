From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 09/12] tee: add tee_shm_register_{user,kernel}_buf()
Date: Fri, 14 Jan 2022 16:08:21 +0100
Message-ID: <20220114150824.3578829-10-jens.wiklander@linaro.org>
In-Reply-To: <20220114150824.3578829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8282221745384585461=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8282221745384585461==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds the two new functions tee_shm_register_user_buf() and
tee_shm_register_kernel_buf() which should be used instead of the old
tee_shm_register().

This avoids having the caller supplying the flags parameter which
exposes a bit more than desired of the internals of the TEE subsystem.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c  |  3 +--
 drivers/tee/tee_shm.c   | 34 ++++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h |  4 ++++
 3 files changed, 39 insertions(+), 2 deletions(-)

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
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index d51bf97ce7e5..6a1dbce75616 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -301,6 +301,40 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx=
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
+EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
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
index e71cb0411e9c..029c9a0590cc 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -289,6 +289,10 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_cont=
ext *ctx, size_t size);
  */
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags);
+struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
+					  unsigned long addr, size_t length);
+struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
+					    void *addr, size_t length);
=20
 /**
  * tee_shm_is_registered() - Check if shared memory object in registered in =
TEE
--=20
2.31.1


--===============8282221745384585461==--

