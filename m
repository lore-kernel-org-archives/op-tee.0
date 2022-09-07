From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 02/10] tee: optee: Drop ffa_ops in optee_ffa structure
 using ffa_dev->ops directly
Date: Wed, 07 Sep 2022 15:52:32 +0100
Message-ID: <20220907145240.1683088-3-sudeep.holla@arm.com>
In-Reply-To: <20220907145240.1683088-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5440073942147313614=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5440073942147313614==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Now that the ffa_device structure holds the pointer to ffa_dev_ops,
there is no need to obtain the same through ffa_dev_ops_get().

Just use the ffa_dev->ops directly. Since the ffa_device itself carries
ffa_dev_ops now, there is no need to keep a copy in optee_ffa structure.

Drop ffa_ops in the optee_ffa structure as it is not needed anymore.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tee/optee/ffa_abi.c       | 15 +++++----------
 drivers/tee/optee/optee_private.h |  1 -
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 7ab31740cff8..3d4079575ccd 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -271,8 +271,8 @@ static int optee_ffa_shm_register(struct tee_context *ctx=
, struct tee_shm *shm,
 				  unsigned long start)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops =3D optee->ffa.ffa_ops;
 	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
+	const struct ffa_dev_ops *ffa_ops =3D ffa_dev->ops;
 	struct ffa_mem_region_attributes mem_attr =3D {
 		.receiver =3D ffa_dev->vm_id,
 		.attrs =3D FFA_MEM_RW,
@@ -314,8 +314,8 @@ static int optee_ffa_shm_unregister(struct tee_context *c=
tx,
 				    struct tee_shm *shm)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops =3D optee->ffa.ffa_ops;
 	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
+	const struct ffa_dev_ops *ffa_ops =3D ffa_dev->ops;
 	u64 global_handle =3D shm->sec_world_id;
 	struct ffa_send_direct_data data =3D {
 		.data0 =3D OPTEE_FFA_UNREGISTER_SHM,
@@ -342,7 +342,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_conte=
xt *ctx,
 					 struct tee_shm *shm)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops =3D optee->ffa.ffa_ops;
+	const struct ffa_dev_ops *ffa_ops =3D optee->ffa.ffa_dev->ops;
 	u64 global_handle =3D shm->sec_world_id;
 	int rc;
=20
@@ -529,8 +529,8 @@ static int optee_ffa_yielding_call(struct tee_context *ct=
x,
 				   struct optee_msg_arg *rpc_arg)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops =3D optee->ffa.ffa_ops;
 	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
+	const struct ffa_dev_ops *ffa_ops =3D ffa_dev->ops;
 	struct optee_call_waiter w;
 	u32 cmd =3D data->data0;
 	u32 w4 =3D data->data1;
@@ -793,11 +793,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	u32 sec_caps;
 	int rc;
=20
-	ffa_ops =3D ffa_dev_ops_get(ffa_dev);
-	if (!ffa_ops) {
-		pr_warn("failed \"method\" init: ffa\n");
-		return -ENOENT;
-	}
+	ffa_ops =3D ffa_dev->ops;
=20
 	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
 		return -EINVAL;
@@ -821,7 +817,6 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
=20
 	optee->ops =3D &optee_ffa_ops;
 	optee->ffa.ffa_dev =3D ffa_dev;
-	optee->ffa.ffa_ops =3D ffa_ops;
 	optee->rpc_param_count =3D rpc_param_count;
=20
 	teedev =3D tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index a33d98d17cfd..04ae58892608 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -111,7 +111,6 @@ struct optee_smc {
  */
 struct optee_ffa {
 	struct ffa_device *ffa_dev;
-	const struct ffa_dev_ops *ffa_ops;
 	/* Serializes access to @global_ids */
 	struct mutex mutex;
 	struct rhashtable global_ids;
--=20
2.37.3


--===============5440073942147313614==--

