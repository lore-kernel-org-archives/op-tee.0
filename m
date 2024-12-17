From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4 4/6] optee: support restricted memory allocation
Date: Tue, 17 Dec 2024 11:07:40 +0100
Message-ID: <20241217100809.3962439-5-jens.wiklander@linaro.org>
In-Reply-To: <20241217100809.3962439-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5068354982435454408=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5068354982435454408==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add support in the OP-TEE backend driver for restricted memory
allocation. The support is limited to only the SMC ABI and for secure
video buffers.

OP-TEE is probed for the range of restricted physical memory and a
memory pool allocator is initialized if OP-TEE have support for such
memory.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/Makefile        |  1 +
 drivers/tee/optee/core.c          |  1 +
 drivers/tee/optee/optee_private.h | 23 ++++++++++
 drivers/tee/optee/rstmem.c        | 76 +++++++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 69 ++++++++++++++++++++++++++--
 5 files changed, 167 insertions(+), 3 deletions(-)
 create mode 100644 drivers/tee/optee/rstmem.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index a6eff388d300..498969fb8e40 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -4,6 +4,7 @@ optee-objs +=3D core.o
 optee-objs +=3D call.o
 optee-objs +=3D notif.o
 optee-objs +=3D rpc.o
+optee-objs +=3D rstmem.o
 optee-objs +=3D supp.o
 optee-objs +=3D device.o
 optee-objs +=3D smc_abi.o
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index c75fddc83576..f4fa494789a4 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -182,6 +182,7 @@ void optee_remove_common(struct optee *optee)
 	tee_device_unregister(optee->teedev);
=20
 	tee_shm_pool_free(optee->pool);
+	optee_rstmem_pools_uninit(optee);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
 	rpmb_dev_put(optee->rpmb_dev);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 20eda508dbac..0491889e5b0e 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -193,6 +193,20 @@ struct optee_ops {
 			      bool update_out);
 };
=20
+/**
+ * struct optee_rstmem_pools - restricted memory pools
+ * @mutex:	serializes write access to @xa when adding a new pool.
+ * @xa:		XArray of struct tee_shm_pool where the index is the
+ *		use case ID TEE_IOC_UC_* supplied for TEE_IOC_RSTMEM_ALLOC.
+ */
+struct optee_rstmem_pools {
+	/*
+	 * Serializes write access to @xa when adding a new pool.
+	 */
+	struct mutex mutex;
+	struct xarray xa;
+};
+
 /**
  * struct optee - main service struct
  * @supp_teedev:	supplicant device
@@ -206,6 +220,7 @@ struct optee_ops {
  * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
+ * @rstmem_pool:	restricted memory pool for secure data path
  * @mutex:		mutex protecting @rpmb_dev
  * @rpmb_dev:		current RPMB device or NULL
  * @rpmb_scan_bus_done	flag if device registation of RPMB dependent devices
@@ -230,6 +245,7 @@ struct optee {
 	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
+	struct optee_rstmem_pools *rstmem_pools;
 	/* Protects rpmb_dev pointer */
 	struct mutex rpmb_dev_mutex;
 	struct rpmb_dev *rpmb_dev;
@@ -286,6 +302,9 @@ void optee_supp_init(struct optee_supp *supp);
 void optee_supp_uninit(struct optee_supp *supp);
 void optee_supp_release(struct optee_supp *supp);
=20
+int optee_rstmem_pools_init(struct optee *optee);
+void optee_rstmem_pools_uninit(struct optee *optee);
+
 int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		    struct tee_param *param);
 int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
@@ -378,6 +397,10 @@ void optee_rpc_cmd(struct tee_context *ctx, struct optee=
 *optee,
 int optee_do_bottom_half(struct tee_context *ctx);
 int optee_stop_async_notif(struct tee_context *ctx);
=20
+int optee_rstmem_alloc(struct tee_context *ctx, struct tee_shm *shm,
+		       u32 flags, u32 use_case, size_t size);
+void optee_rstmem_free(struct tee_context *ctx, struct tee_shm *shm);
+
 /*
  * Small helpers
  */
diff --git a/drivers/tee/optee/rstmem.c b/drivers/tee/optee/rstmem.c
new file mode 100644
index 000000000000..01456bc3e2f6
--- /dev/null
+++ b/drivers/tee/optee/rstmem.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Linaro Limited
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/dma-map-ops.h>
+#include <linux/errno.h>
+#include <linux/genalloc.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tee_core.h>
+#include <linux/types.h>
+#include "optee_private.h"
+
+int optee_rstmem_alloc(struct tee_context *ctx, struct tee_shm *shm,
+		       u32 flags, u32 use_case, size_t size)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	struct tee_shm_pool *pool;
+
+	if (!optee->rstmem_pools)
+		return -EINVAL;
+	if (flags)
+		return -EINVAL;
+
+	pool =3D xa_load(&optee->rstmem_pools->xa, use_case);
+	if (!pool)
+		return -EINVAL;
+
+	return pool->ops->alloc(pool, shm, size, 0);
+}
+
+void optee_rstmem_free(struct tee_context *ctx, struct tee_shm *shm)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	struct tee_shm_pool *pool;
+
+	pool =3D xa_load(&optee->rstmem_pools->xa, shm->use_case);
+	if (pool)
+		pool->ops->free(pool, shm);
+	else
+		pr_err("Can't find pool for use_case %u\n", shm->use_case);
+}
+
+int optee_rstmem_pools_init(struct optee *optee)
+{
+	struct optee_rstmem_pools *pools;
+
+	pools =3D kmalloc(sizeof(*pools), GFP_KERNEL);
+	if (!pools)
+		return -ENOMEM;
+
+	mutex_init(&pools->mutex);
+	xa_init(&pools->xa);
+	optee->rstmem_pools =3D pools;
+	return 0;
+}
+
+void optee_rstmem_pools_uninit(struct optee *optee)
+{
+	if (optee->rstmem_pools) {
+		struct tee_shm_pool *pool;
+		u_long idx;
+
+		xa_for_each(&optee->rstmem_pools->xa, idx, pool) {
+			xa_erase(&optee->rstmem_pools->xa, idx);
+			pool->ops->destroy_pool(pool);
+		}
+
+		xa_destroy(&optee->rstmem_pools->xa);
+		mutex_destroy(&optee->rstmem_pools->mutex);
+		kfree(optee->rstmem_pools);
+		optee->rstmem_pools =3D NULL;
+	}
+}
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 788919a473d6..f5fd5f1d9a6b 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1201,6 +1201,8 @@ static void optee_get_version(struct tee_device *teedev,
 		v.gen_caps |=3D TEE_GEN_CAP_REG_MEM;
 	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
 		v.gen_caps |=3D TEE_GEN_CAP_MEMREF_NULL;
+	if (optee->rstmem_pools)
+		v.gen_caps |=3D TEE_GEN_CAP_RSTMEM;
 	*vers =3D v;
 }
=20
@@ -1223,6 +1225,8 @@ static const struct tee_driver_ops optee_clnt_ops =3D {
 	.cancel_req =3D optee_cancel_req,
 	.shm_register =3D optee_shm_register,
 	.shm_unregister =3D optee_shm_unregister,
+	.rstmem_alloc =3D optee_rstmem_alloc,
+	.rstmem_free =3D optee_rstmem_free,
 };
=20
 static const struct tee_desc optee_clnt_desc =3D {
@@ -1239,6 +1243,8 @@ static const struct tee_driver_ops optee_supp_ops =3D {
 	.supp_send =3D optee_supp_send,
 	.shm_register =3D optee_shm_register_supp,
 	.shm_unregister =3D optee_shm_unregister_supp,
+	.rstmem_alloc =3D optee_rstmem_alloc,
+	.rstmem_free =3D optee_rstmem_free,
 };
=20
 static const struct tee_desc optee_supp_desc =3D {
@@ -1619,6 +1625,57 @@ static inline int optee_load_fw(struct platform_device=
 *pdev,
 }
 #endif
=20
+static int optee_sdp_pool_init(struct optee *optee)
+{
+	bool sdp =3D optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP;
+	struct tee_shm_pool *pool;
+	int rc;
+
+	/*
+	 * optee_sdp_pools_init() must be called if secure world has any
+	 * SDP capability. If the static carvout is available initialize
+	 * and add a pool for that.
+	 */
+	if (!sdp)
+		return 0;
+
+	rc =3D optee_rstmem_pools_init(optee);
+	if (rc)
+		return rc;
+
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP) {
+		union {
+			struct arm_smccc_res smccc;
+			struct optee_smc_get_sdp_config_result result;
+		} res;
+
+		optee->smc.invoke_fn(OPTEE_SMC_GET_SDP_CONFIG, 0, 0, 0, 0, 0, 0,
+				     0, &res.smccc);
+		if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
+			pr_err("Secure Data Path service not available\n");
+			goto err;
+		}
+
+		pool =3D tee_rstmem_gen_pool_alloc(res.result.start,
+						 res.result.size);
+		if (IS_ERR(pool)) {
+			rc =3D PTR_ERR(pool);
+			goto err;
+		}
+		rc =3D xa_insert(&optee->rstmem_pools->xa,
+			       TEE_IOC_UC_SECURE_VIDEO_PLAY, pool, GFP_KERNEL);
+		if (rc) {
+			pool->ops->destroy_pool(pool);
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	optee_rstmem_pools_uninit(optee);
+	return rc;
+}
+
 static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
@@ -1714,7 +1771,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee) {
 		rc =3D -ENOMEM;
-		goto err_free_pool;
+		goto err_free_shm_pool;
 	}
=20
 	optee->ops =3D &optee_ops;
@@ -1726,10 +1783,14 @@ static int optee_probe(struct platform_device *pdev)
 	    (sec_caps & OPTEE_SMC_SEC_CAP_RPMB_PROBE))
 		optee->in_kernel_rpmb_routing =3D true;
=20
+	rc =3D optee_sdp_pool_init(optee);
+	if (rc)
+		goto err_free_optee;
+
 	teedev =3D tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc =3D PTR_ERR(teedev);
-		goto err_free_optee;
+		goto err_rstmem_pools_uninit;
 	}
 	optee->teedev =3D teedev;
=20
@@ -1836,9 +1897,11 @@ static int optee_probe(struct platform_device *pdev)
 	tee_device_unregister(optee->supp_teedev);
 err_unreg_teedev:
 	tee_device_unregister(optee->teedev);
+err_rstmem_pools_uninit:
+	optee_rstmem_pools_uninit(optee);
 err_free_optee:
 	kfree(optee);
-err_free_pool:
+err_free_shm_pool:
 	tee_shm_pool_free(pool);
 	if (memremaped_shm)
 		memunmap(memremaped_shm);
--=20
2.43.0


--===============5068354982435454408==--

