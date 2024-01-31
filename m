From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 3/3] optee: probe RPMB device using RPMB subsystem
Date: Wed, 31 Jan 2024 18:43:47 +0100
Message-ID: <20240131174347.510961-4-jens.wiklander@linaro.org>
In-Reply-To: <20240131174347.510961-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0242772042632593600=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0242772042632593600==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
use an RPMB device via the RPBM subsystem instead of passing the RPMB
frames via tee-supplicant in user space. A fallback mechanism is kept to
route RPMB frames via tee-supplicant if the RPMB subsystem isn't
available.

The OP-TEE RPC ABI is extended to support iterating over all RPMB
devices until one is found with the expected RPMB key already
programmed.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       |   2 +
 drivers/tee/optee/optee_private.h |   6 +
 drivers/tee/optee/optee_rpc_cmd.h |  33 +++++
 drivers/tee/optee/rpc.c           | 221 ++++++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       |   2 +
 6 files changed, 265 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 3aed554bc8d8..21bcccbe2207 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -177,6 +177,7 @@ void optee_remove_common(struct optee *optee)
 	tee_shm_pool_free(optee->pool);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
+	mutex_destroy(&optee->rpmb_dev_mutex);
 }
=20
 static int smc_abi_rc;
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index ecb5eb079408..1d207a9d4f3b 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -934,6 +934,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee_cq_init(&optee->call_queue, 0);
 	optee_supp_init(&optee->supp);
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
+	mutex_init(&optee->rpmb_dev_mutex);
 	ffa_dev_set_drvdata(ffa_dev, optee);
 	ctx =3D teedev_open(optee->teedev);
 	if (IS_ERR(ctx)) {
@@ -968,6 +969,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	teedev_close_context(ctx);
 err_rhashtable_free:
 	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
+	mutex_destroy(&optee->rpmb_dev_mutex);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
 	mutex_destroy(&optee->ffa.mutex);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 7a5243c78b55..3a87ad4ef1e2 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -20,6 +20,7 @@
 /* Some Global Platform error codes used in this driver */
 #define TEEC_SUCCESS			0x00000000
 #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
+#define TEEC_ERROR_ITEM_NOT_FOUND	0xFFFF0008
 #define TEEC_ERROR_NOT_SUPPORTED	0xFFFF000A
 #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
 #define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
@@ -197,6 +198,8 @@ struct optee_ops {
  * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
+ * @mutex:		mutex protecting @rpmb_dev
+ * @rpmb_dev:		current RPMB device or NULL
  * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
  * @scan_bus_work	workq to scan optee bus and register optee drivers
@@ -215,6 +218,9 @@ struct optee {
 	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
+	/* Protects rpmb_dev pointer */
+	struct mutex rpmb_dev_mutex;
+	struct rpmb_dev *rpmb_dev;
 	unsigned int rpc_param_count;
 	bool   scan_bus_done;
 	struct work_struct scan_bus_work;
diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_=
cmd.h
index f3f06e0994a7..672e5dcdf041 100644
--- a/drivers/tee/optee/optee_rpc_cmd.h
+++ b/drivers/tee/optee/optee_rpc_cmd.h
@@ -16,6 +16,14 @@
  * and sends responses.
  */
=20
+/*
+ * Replay Protected Memory Block access
+ *
+ * [in]     memref[0]	    Frames to device
+ * [out]    memref[1]	    Frames from device
+ */
+#define OPTEE_RPC_CMD_RPMB		1
+
 /*
  * Get time
  *
@@ -103,4 +111,29 @@
 /* I2C master control flags */
 #define OPTEE_RPC_I2C_FLAGS_TEN_BIT	BIT(0)
=20
+/*
+ * Reset RPMB probing
+ *
+ * Releases an eventually already used RPMB devices and starts over searching
+ * for RPMB devices. Returns the kind of shared memory to use in subsequent
+ * OPTEE_RPC_CMD_RPMB_PROBE_NEXT and OPTEE_RPC_CMD_RPMB calls.
+ *
+ * [out]    value[0].a	    OPTEE_RPC_SHM_TYPE_*, the parameter for
+ *			    OPTEE_RPC_CMD_SHM_ALLOC
+ */
+#define OPTEE_RPC_CMD_RPMB_PROBE_RESET	22
+
+/*
+ * Probe next RPMB device
+ *
+ * [out]    value[0].a	    Must be OPTEE_RPC_RPMB_EMMC
+ * [out]    value[0].b	    EXT CSD-slice 168 "RPMB Size"
+ * [out]    value[0].c	    EXT CSD-slice 222 "Reliable Write Sector Count"
+ * [out]    memref[1]       Buffer with the raw CID
+ */
+#define OPTEE_RPC_CMD_RPMB_PROBE_NEXT	23
+
+/* Type of RPMB device */
+#define OPTEE_RPC_RPMB_EMMC		0
+
 #endif /*__OPTEE_RPC_CMD_H*/
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index e69bc6380683..6fd6f99dafab 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -7,6 +7,7 @@
=20
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/rpmb.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include "optee_private.h"
@@ -255,6 +256,217 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, =
struct tee_shm *shm)
 	optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
 }
=20
+static void handle_rpc_func_rpmb_probe_reset(struct tee_context *ctx,
+					     struct optee *optee,
+					     struct optee_msg_arg *arg)
+{
+	struct tee_param params[1];
+
+	if (!IS_ENABLED(CONFIG_RPMB)) {
+		handle_rpc_supp_cmd(ctx, optee, arg);
+		return;
+	}
+
+	if (arg->num_params !=3D ARRAY_SIZE(params) ||
+	    optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params) ||
+	    params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT) {
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	params[0].u.value.a =3D OPTEE_RPC_SHM_TYPE_KERNEL;
+	params[0].u.value.b =3D 0;
+	params[0].u.value.c =3D 0;
+	if (optee->ops->to_msg_param(optee, arg->params,
+				     arg->num_params, params)) {
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	mutex_lock(&optee->rpmb_dev_mutex);
+	rpmb_dev_put(optee->rpmb_dev);
+	optee->rpmb_dev =3D NULL;
+	mutex_unlock(&optee->rpmb_dev_mutex);
+
+	arg->ret =3D TEEC_SUCCESS;
+}
+
+static int rpc_rpmb_match(struct device *dev, const void *data)
+{
+	return 1;
+}
+
+static void handle_rpc_func_rpmb_probe_next(struct tee_context *ctx,
+					    struct optee *optee,
+					    struct optee_msg_arg *arg)
+{
+	struct rpmb_dev *start_rdev;
+	struct rpmb_dev *rdev;
+	struct tee_param params[2];
+	void *buf;
+
+	if (!IS_ENABLED(CONFIG_RPMB)) {
+		handle_rpc_supp_cmd(ctx, optee, arg);
+		return;
+	}
+
+	if (arg->num_params !=3D ARRAY_SIZE(params) ||
+	    optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params) ||
+	    params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT ||
+	    params[1].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+	buf =3D tee_shm_get_va(params[1].u.memref.shm,
+			     params[1].u.memref.shm_offs);
+	if (!buf) {
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	mutex_lock(&optee->rpmb_dev_mutex);
+	start_rdev =3D optee->rpmb_dev;
+	rdev =3D rpmb_dev_find_device(NULL, start_rdev, rpc_rpmb_match);
+	rpmb_dev_put(start_rdev);
+	optee->rpmb_dev =3D rdev;
+	mutex_unlock(&optee->rpmb_dev_mutex);
+
+	if (!rdev) {
+		arg->ret =3D TEEC_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	if (params[1].u.memref.size < rdev->dev_id_len) {
+		arg->ret =3D TEEC_ERROR_SHORT_BUFFER;
+		return;
+	}
+	memcpy(buf, rdev->dev_id, rdev->dev_id_len);
+	params[1].u.memref.size =3D rdev->dev_id_len;
+	params[0].u.value.a =3D OPTEE_RPC_RPMB_EMMC;
+	params[0].u.value.b =3D rdev->capacity;
+	params[0].u.value.c =3D rdev->reliable_wr_count;
+	if (optee->ops->to_msg_param(optee, arg->params,
+				     arg->num_params, params)) {
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	arg->ret =3D TEEC_SUCCESS;
+}
+
+/* Request */
+struct rpmb_req {
+	u16 cmd;
+#define RPMB_CMD_DATA_REQ      0x00
+#define RPMB_CMD_GET_DEV_INFO  0x01
+	u16 dev_id;
+	u16 block_count;
+	/* Optional data frames (rpmb_data_frame) follow */
+};
+
+#define RPMB_REQ_DATA(req) ((void *)((struct rpmb_req *)(req) + 1))
+
+#define RPMB_CID_SZ 16
+
+/* Response to device info request */
+struct rpmb_dev_info {
+	u8 cid[RPMB_CID_SZ];
+	u8 rpmb_size_mult;	/* EXT CSD-slice 168: RPMB Size */
+	u8 rel_wr_sec_c;	/* EXT CSD-slice 222: Reliable Write Sector */
+				/*                    Count */
+	u8 ret_code;
+#define RPMB_CMD_GET_DEV_INFO_RET_OK     0x00
+#define RPMB_CMD_GET_DEV_INFO_RET_ERROR  0x01
+};
+
+static int get_dev_info(struct rpmb_dev *rdev, void *rsp, size_t rsp_size)
+{
+	struct rpmb_dev_info *dev_info;
+
+	if (rsp_size !=3D sizeof(*dev_info))
+		return TEEC_ERROR_BAD_PARAMETERS;
+
+	dev_info =3D rsp;
+	memcpy(dev_info->cid, rdev->dev_id, sizeof(dev_info->cid));
+	dev_info->rpmb_size_mult =3D rdev->capacity;
+	dev_info->rel_wr_sec_c =3D rdev->reliable_wr_count;
+	dev_info->ret_code =3D RPMB_CMD_GET_DEV_INFO_RET_OK;
+
+	return TEEC_SUCCESS;
+}
+
+/*
+ * req is one struct rpmb_req followed by one or more struct rpmb_data_frame
+ * rsp is either one struct rpmb_dev_info or one or more struct rpmb_data_fr=
ame
+ */
+static u32 rpmb_process_request(struct optee *optee, struct rpmb_dev *rdev,
+				void *req, size_t req_size,
+				void *rsp, size_t rsp_size)
+{
+	struct rpmb_req *sreq =3D req;
+	int rc;
+
+	if (req_size < sizeof(*sreq))
+		return TEEC_ERROR_BAD_PARAMETERS;
+
+	switch (sreq->cmd) {
+	case RPMB_CMD_DATA_REQ:
+		rc =3D rpmb_route_frames(rdev, RPMB_REQ_DATA(req),
+				       req_size - sizeof(struct rpmb_req),
+				       rsp, rsp_size);
+		if (rc) // TODO translate error code
+			return TEEC_ERROR_BAD_PARAMETERS;
+		return TEEC_SUCCESS;
+	case RPMB_CMD_GET_DEV_INFO:
+		return get_dev_info(rdev, rsp, rsp_size);
+	default:
+		return TEEC_ERROR_BAD_PARAMETERS;
+	}
+}
+
+static void handle_rpc_func_rpmb(struct tee_context *ctx, struct optee *opte=
e,
+				 struct optee_msg_arg *arg)
+{
+	struct tee_param params[2];
+	struct rpmb_dev *rdev;
+	void *p0, *p1;
+
+	mutex_lock(&optee->rpmb_dev_mutex);
+	rdev =3D rpmb_dev_get(optee->rpmb_dev);
+	mutex_unlock(&optee->rpmb_dev_mutex);
+	if (!rdev) {
+		handle_rpc_supp_cmd(ctx, optee, arg);
+		return;
+	}
+
+	if (arg->num_params !=3D ARRAY_SIZE(params) ||
+	    optee->ops->from_msg_param(optee, params, arg->num_params,
+				       arg->params) ||
+	    params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT ||
+	    params[1].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		goto out;
+	}
+
+	p0 =3D tee_shm_get_va(params[0].u.memref.shm,
+			    params[0].u.memref.shm_offs);
+	p1 =3D tee_shm_get_va(params[1].u.memref.shm,
+			    params[1].u.memref.shm_offs);
+	arg->ret =3D rpmb_process_request(optee, rdev, p0,
+					params[0].u.memref.size,
+					p1, params[1].u.memref.size);
+	if (arg->ret)
+		goto out;
+
+	if (optee->ops->to_msg_param(optee, arg->params,
+				     arg->num_params, params))
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+out:
+	rpmb_dev_put(rdev);
+}
+
 void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
 		   struct optee_msg_arg *arg)
 {
@@ -271,6 +483,15 @@ void optee_rpc_cmd(struct tee_context *ctx, struct optee=
 *optee,
 	case OPTEE_RPC_CMD_I2C_TRANSFER:
 		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
 		break;
+	case OPTEE_RPC_CMD_RPMB_PROBE_RESET:
+		handle_rpc_func_rpmb_probe_reset(ctx, optee, arg);
+		break;
+	case OPTEE_RPC_CMD_RPMB_PROBE_NEXT:
+		handle_rpc_func_rpmb_probe_next(ctx, optee, arg);
+		break;
+	case OPTEE_RPC_CMD_RPMB:
+		handle_rpc_func_rpmb(ctx, optee, arg);
+		break;
 	default:
 		handle_rpc_supp_cmd(ctx, optee, arg);
 	}
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a37f87087e5c..8c85c3b8dbb4 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1715,6 +1715,7 @@ static int optee_probe(struct platform_device *pdev)
 	optee->smc.memremaped_shm =3D memremaped_shm;
 	optee->pool =3D pool;
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
+	mutex_init(&optee->rpmb_dev_mutex);
=20
 	platform_set_drvdata(pdev, optee);
 	ctx =3D teedev_open(optee->teedev);
@@ -1782,6 +1783,7 @@ static int optee_probe(struct platform_device *pdev)
 err_close_ctx:
 	teedev_close_context(ctx);
 err_supp_uninit:
+	mutex_destroy(&optee->rpmb_dev_mutex);
 	optee_shm_arg_cache_uninit(optee);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
--=20
2.34.1


--===============0242772042632593600==--

