From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 03/12] tee: add tee_shm_alloc_user_buf()
Date: Tue, 25 Jan 2022 17:29:29 +0100
Message-ID: <20220125162938.838382-4-jens.wiklander@linaro.org>
In-Reply-To: <20220125162938.838382-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1205794438489637641=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1205794438489637641==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds a new function tee_shm_alloc_user_buf() or user mode allocations,
replacing passing the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF to
tee_shm_alloc().

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c     |  2 +-
 drivers/tee/tee_private.h  |  2 ++
 drivers/tee/tee_shm.c      | 17 +++++++++++++++++
 drivers/tee/tee_shm_pool.c |  2 +-
 include/linux/tee_drv.h    |  2 +-
 5 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 3fc426dad2df..a15812baaeb1 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -297,7 +297,7 @@ static int tee_ioctl_shm_alloc(struct tee_context *ctx,
 	if (data.flags)
 		return -EINVAL;
=20
-	shm =3D tee_shm_alloc(ctx, data.size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	shm =3D tee_shm_alloc_user_buf(ctx, data.size);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
=20
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index e55204df31ce..e09c8aa5d967 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -68,4 +68,6 @@ void tee_device_put(struct tee_device *teedev);
 void teedev_ctx_get(struct tee_context *ctx);
 void teedev_ctx_put(struct tee_context *ctx);
=20
+struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
+
 #endif /*TEE_PRIVATE_H*/
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 499fccba3d74..7e7e762fc1de 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -127,6 +127,23 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, s=
ize_t size, u32 flags)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc);
=20
+/**
+ * tee_shm_alloc_user_buf() - Allocate shared memory for user space
+ * @ctx:	Context that allocates the shared memory
+ * @size:	Requested size of shared memory
+ *
+ * Memory allocated as user space shared memory is automatically freed when
+ * the TEE file pointer is closed. The primary usage of this function is
+ * when the TEE driver doesn't support registering ordinary user space
+ * memory.
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
+{
+	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+}
+
 /**
  * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
  * @ctx:	Context that allocates the shared memory
diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
index a9f9d50fd181..0e460347138a 100644
--- a/drivers/tee/tee_shm_pool.c
+++ b/drivers/tee/tee_shm_pool.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2015, Linaro Limited
+ * Copyright (c) 2015, 2017, 2022 Linaro Limited
  */
 #include <linux/device.h>
 #include <linux/dma-buf.h>
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 6b0f0d01ebdf..975500b2553e 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2015-2016, Linaro Limited
+ * Copyright (c) 2015-2022 Linaro Limited
  */
=20
 #ifndef __TEE_DRV_H
--=20
2.31.1


--===============1205794438489637641==--

