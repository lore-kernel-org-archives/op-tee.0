From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 1/4] optee: rename rpc_arg_count to rpc_param_count
Date: Mon, 21 Mar 2022 14:03:38 +0100
Message-ID: <20220321130341.935535-2-jens.wiklander@linaro.org>
In-Reply-To: <20220321130341.935535-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8749710474504734273=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8749710474504734273==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Renames the field rpc_arg_count in struct optee to rpc_param_count.
Function parameter names and local variables are also renamed to match.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c          |  6 +++---
 drivers/tee/optee/ffa_abi.c       | 10 +++++-----
 drivers/tee/optee/optee_private.h |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index bd49ec934060..a9a237d20c61 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -113,12 +113,12 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *c=
tx, size_t num_params,
 	struct optee_msg_arg *ma;
=20
 	/*
-	 * rpc_arg_count is set to the number of allocated parameters in
+	 * rpc_param_count is set to the number of allocated parameters in
 	 * the RPC argument struct if a second MSG arg struct is expected.
 	 * The second arg struct will then be used for RPC.
 	 */
-	if (optee->rpc_arg_count)
-		sz +=3D OPTEE_MSG_GET_ARG_SIZE(optee->rpc_arg_count);
+	if (optee->rpc_param_count)
+		sz +=3D OPTEE_MSG_GET_ARG_SIZE(optee->rpc_param_count);
=20
 	shm =3D tee_shm_alloc_priv_buf(ctx, sz);
 	if (IS_ERR(shm))
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index a5eb4ef46971..7686f7020616 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -678,7 +678,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device=
 *ffa_dev,
=20
 static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 				    const struct ffa_dev_ops *ops,
-				    unsigned int *rpc_arg_count)
+				    unsigned int *rpc_param_count)
 {
 	struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABILITIES };
 	int rc;
@@ -693,7 +693,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ff=
a_dev,
 		return false;
 	}
=20
-	*rpc_arg_count =3D (u8)data.data1;
+	*rpc_param_count =3D (u8)data.data1;
=20
 	return true;
 }
@@ -772,7 +772,7 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
 	const struct ffa_dev_ops *ffa_ops;
-	unsigned int rpc_arg_count;
+	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
@@ -788,7 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
 		return -EINVAL;
=20
-	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_arg_count))
+	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
 		return -EINVAL;
=20
 	optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
@@ -805,7 +805,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee->ops =3D &optee_ffa_ops;
 	optee->ffa.ffa_dev =3D ffa_dev;
 	optee->ffa.ffa_ops =3D ffa_ops;
-	optee->rpc_arg_count =3D rpc_arg_count;
+	optee->rpc_param_count =3D rpc_param_count;
=20
 	teedev =3D tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
 				  optee);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index e77765c78878..e80c5d9b62ec 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -143,7 +143,7 @@ struct optee_ops {
  * @notif:		notification synchronization struct
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
- * @rpc_arg_count:	If > 0 number of RPC parameters to make room for
+ * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
  * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
  * @scan_bus_work	workq to scan optee bus and register optee drivers
@@ -161,7 +161,7 @@ struct optee {
 	struct optee_notif notif;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
-	unsigned int rpc_arg_count;
+	unsigned int rpc_param_count;
 	bool   scan_bus_done;
 	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
--=20
2.31.1


--===============8749710474504734273==--

