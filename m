From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] driver: tee: Handle NULL pointer indication from client
Date: Fri, 10 Jul 2020 12:18:08 +0200
Message-ID: <20200710101808.1316522-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0012625235207278817=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0012625235207278817==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Cedric Neveux <cedric.neveux@nxp.com>

TEE Client introduce a new capability "TEE_GEN_CAP_MEMREF_NULL"
to handle the support of the shared memory buffer with a NULL pointer.

This capability depends on TEE Capabilities and driver support.
Driver and TEE exchange capabilities at driver initialization.

Signed-off-by: Michael Whitfield <michael.whitfield@nxp.com>
Signed-off-by: Cedric Neveux <cedric.neveux@nxp.com>
Reviewed-by: Joakim Bech <joakim.bech@linaro.org>
Tested-by: Joakim Bech <joakim.bech@linaro.org> (QEMU)
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c      |  7 +++++
 drivers/tee/optee/optee_smc.h |  3 +++
 drivers/tee/tee_core.c        | 49 ++++++++++++++++++++++-------------
 include/linux/tee_drv.h       |  3 +++
 include/uapi/linux/tee.h      | 13 ++++++++++
 5 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 99698b8a3a74..8ef66e75b65e 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -215,6 +215,8 @@ static void optee_get_version(struct tee_device *teedev,
=20
 	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
 		v.gen_caps |=3D TEE_GEN_CAP_REG_MEM;
+	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
+		v.gen_caps |=3D TEE_GEN_CAP_MEMREF_NULL;
 	*vers =3D v;
 }
=20
@@ -246,6 +248,11 @@ static int optee_open(struct tee_context *ctx)
 	mutex_init(&ctxdata->mutex);
 	INIT_LIST_HEAD(&ctxdata->sess_list);
=20
+	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
+		ctx->cap_memref_null  =3D true;
+	else
+		ctx->cap_memref_null =3D false;
+
 	ctx->data =3D ctxdata;
 	return 0;
 }
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index c72122d9c997..777ad54d4c2c 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -215,6 +215,9 @@ struct optee_smc_get_shm_config_result {
  */
 #define OPTEE_SMC_SEC_CAP_DYNAMIC_SHM		BIT(2)
=20
+/* Secure world supports Shared Memory with a NULL buffer reference */
+#define OPTEE_SMC_SEC_CAP_MEMREF_NULL		BIT(4)
+
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
 	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES)
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 64637e09a095..ce0f0309b6ac 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -383,25 +383,38 @@ static int params_from_user(struct tee_context *ctx, st=
ruct tee_param *params,
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			/*
-			 * If we fail to get a pointer to a shared memory
-			 * object (and increase the ref count) from an
-			 * identifier we return an error. All pointers that
-			 * has been added in params have an increased ref
-			 * count. It's the callers responibility to do
-			 * tee_shm_put() on all resolved pointers.
+			 * If a NULL pointer is passed to a TA in the TEE,
+			 * the ip.c IOCTL parameters is set to TEE_MEMREF_NULL
+			 * indicating a NULL memory reference.
 			 */
-			shm =3D tee_shm_get_from_id(ctx, ip.c);
-			if (IS_ERR(shm))
-				return PTR_ERR(shm);
-
-			/*
-			 * Ensure offset + size does not overflow offset
-			 * and does not overflow the size of the referred
-			 * shared memory object.
-			 */
-			if ((ip.a + ip.b) < ip.a ||
-			    (ip.a + ip.b) > shm->size) {
-				tee_shm_put(shm);
+			if (ip.c !=3D TEE_MEMREF_NULL) {
+				/*
+				 * If we fail to get a pointer to a shared
+				 * memory object (and increase the ref count)
+				 * from an identifier we return an error. All
+				 * pointers that has been added in params have
+				 * an increased ref count. It's the callers
+				 * responibility to do tee_shm_put() on all
+				 * resolved pointers.
+				 */
+				shm =3D tee_shm_get_from_id(ctx, ip.c);
+				if (IS_ERR(shm))
+					return PTR_ERR(shm);
+
+				/*
+				 * Ensure offset + size does not overflow
+				 * offset and does not overflow the size of
+				 * the referred shared memory object.
+				 */
+				if ((ip.a + ip.b) < ip.a ||
+				    (ip.a + ip.b) > shm->size) {
+					tee_shm_put(shm);
+					return -EINVAL;
+				}
+			} else if (ctx->cap_memref_null) {
+				/* Pass NULL pointer to OP-TEE */
+				shm =3D NULL;
+			} else {
 				return -EINVAL;
 			}
=20
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index d074302989dd..cdd049a724b1 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -47,6 +47,8 @@ struct tee_shm_pool;
  *              and just return with an error code. It is needed for requests
  *              that arises from TEE based kernel drivers that should be
  *              non-blocking in nature.
+ * @cap_memref_null: flag indicating if the TEE Client support shared
+ *                   memory buffer with a NULL pointer.
  */
 struct tee_context {
 	struct tee_device *teedev;
@@ -54,6 +56,7 @@ struct tee_context {
 	struct kref refcount;
 	bool releasing;
 	bool supp_nowait;
+	bool cap_memref_null;
 };
=20
 struct tee_param_memref {
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index b619f37ee03e..d67cadf221fc 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -51,6 +51,9 @@
 #define TEE_GEN_CAP_GP		(1 << 0)/* GlobalPlatform compliant TEE */
 #define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplicant)=
 */
 #define TEE_GEN_CAP_REG_MEM	(1 << 2)/* Supports registering shared memory */
+#define TEE_GEN_CAP_MEMREF_NULL	(1 << 3)/* NULL MemRef support */
+
+#define TEE_MEMREF_NULL		(__u64)(-1) /* NULL MemRef Buffer */
=20
 /*
  * TEE Implementation ID
@@ -200,6 +203,16 @@ struct tee_ioctl_buf_data {
  * a part of a shared memory by specifying an offset (@a) and size (@b) of
  * the object. To supply the entire shared memory object set the offset
  * (@a) to 0 and size (@b) to the previously returned size of the object.
+ *
+ * A client may need to present a NULL pointer in the argument
+ * passed to a trusted application in the TEE.
+ * This is also a requirement in GlobalPlatform Client API v1.0c
+ * (section 3.2.5 memory references), which can be found at
+ * http://www.globalplatform.org/specificationsdevice.asp
+ *
+ * If a NULL pointer is passed to a TA in the TEE, the (@c)
+ * IOCTL parameters value must be set to TEE_MEMREF_NULL indicating a NULL
+ * memory reference.
  */
 struct tee_ioctl_param {
 	__u64 attr;
--=20
2.25.1


--===============0012625235207278817==--

