From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 10/10] firmware: arm_ffa: Split up ffa_ops into info,
 message and memory operations
Date: Wed, 07 Sep 2022 15:52:40 +0100
Message-ID: <20220907145240.1683088-11-sudeep.holla@arm.com>
In-Reply-To: <20220907145240.1683088-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4939858190142196456=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4939858190142196456==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

In preparation to make memory operations accessible for a non
ffa_driver/device, it is better to split the ffa_ops into different
categories of operations: info, message and memory. The info and memory
are ffa_device independent and can be used without any associated
ffa_device from a non ffa_driver.

However, we don't export these info and memory APIs yet without the user.
The first users of these APIs can export them.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 16 +++++++++++++--
 drivers/tee/optee/ffa_abi.c       | 33 +++++++++++++++++--------------
 include/linux/arm_ffa.h           | 14 ++++++++++++-
 3 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index 34e12a2a98fe..490c8757b281 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -691,16 +691,28 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *arg=
s)
 	return ffa_memory_ops(FFA_MEM_LEND, args);
 }
=20
-static const struct ffa_ops ffa_ops =3D {
+static const struct ffa_info_ops ffa_drv_info_ops =3D {
 	.api_version_get =3D ffa_api_version_get,
 	.partition_info_get =3D ffa_partition_info_get,
+};
+
+static const struct ffa_msg_ops ffa_drv_msg_ops =3D {
 	.mode_32bit_set =3D ffa_mode_32bit_set,
 	.sync_send_receive =3D ffa_sync_send_receive,
+};
+
+static const struct ffa_mem_ops ffa_drv_mem_ops =3D {
 	.memory_reclaim =3D ffa_memory_reclaim,
 	.memory_share =3D ffa_memory_share,
 	.memory_lend =3D ffa_memory_lend,
 };
=20
+static const struct ffa_ops ffa_drv_ops =3D {
+	.info_ops =3D &ffa_drv_info_ops,
+	.msg_ops =3D &ffa_drv_msg_ops,
+	.mem_ops =3D &ffa_drv_mem_ops,
+};
+
 void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
 {
 	int count, idx;
@@ -746,7 +758,7 @@ static void ffa_setup_partitions(void)
 		 * provides UUID here for each partition as part of the
 		 * discovery API and the same is passed.
 		 */
-		ffa_dev =3D ffa_device_register(&uuid, tpbuf->id, &ffa_ops);
+		ffa_dev =3D ffa_device_register(&uuid, tpbuf->id, &ffa_drv_ops);
 		if (!ffa_dev) {
 			pr_err("%s: failed to register partition ID 0x%x\n",
 			       __func__, tpbuf->id);
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 2ce5b87dfb27..0828240f27e6 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -272,7 +272,7 @@ static int optee_ffa_shm_register(struct tee_context *ctx=
, struct tee_shm *shm,
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
-	const struct ffa_ops *ffa_ops =3D ffa_dev->ops;
+	const struct ffa_mem_ops *mem_ops =3D ffa_dev->ops->mem_ops;
 	struct ffa_mem_region_attributes mem_attr =3D {
 		.receiver =3D ffa_dev->vm_id,
 		.attrs =3D FFA_MEM_RW,
@@ -294,14 +294,14 @@ static int optee_ffa_shm_register(struct tee_context *c=
tx, struct tee_shm *shm,
 	if (rc)
 		return rc;
 	args.sg =3D sgt.sgl;
-	rc =3D ffa_ops->memory_share(&args);
+	rc =3D mem_ops->memory_share(&args);
 	sg_free_table(&sgt);
 	if (rc)
 		return rc;
=20
 	rc =3D optee_shm_add_ffa_handle(optee, shm, args.g_handle);
 	if (rc) {
-		ffa_ops->memory_reclaim(args.g_handle, 0);
+		mem_ops->memory_reclaim(args.g_handle, 0);
 		return rc;
 	}
=20
@@ -315,7 +315,8 @@ static int optee_ffa_shm_unregister(struct tee_context *c=
tx,
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
-	const struct ffa_ops *ffa_ops =3D ffa_dev->ops;
+	const struct ffa_msg_ops *msg_ops =3D ffa_dev->ops->msg_ops;
+	const struct ffa_mem_ops *mem_ops =3D ffa_dev->ops->mem_ops;
 	u64 global_handle =3D shm->sec_world_id;
 	struct ffa_send_direct_data data =3D {
 		.data0 =3D OPTEE_FFA_UNREGISTER_SHM,
@@ -327,11 +328,11 @@ static int optee_ffa_shm_unregister(struct tee_context =
*ctx,
 	optee_shm_rem_ffa_handle(optee, global_handle);
 	shm->sec_world_id =3D 0;
=20
-	rc =3D ffa_ops->sync_send_receive(ffa_dev, &data);
+	rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc)
 		pr_err("Unregister SHM id 0x%llx rc %d\n", global_handle, rc);
=20
-	rc =3D ffa_ops->memory_reclaim(global_handle, 0);
+	rc =3D mem_ops->memory_reclaim(global_handle, 0);
 	if (rc)
 		pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
=20
@@ -342,7 +343,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_conte=
xt *ctx,
 					 struct tee_shm *shm)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-	const struct ffa_ops *ffa_ops =3D optee->ffa.ffa_dev->ops;
+	const struct ffa_mem_ops *mem_ops;
 	u64 global_handle =3D shm->sec_world_id;
 	int rc;
=20
@@ -353,7 +354,8 @@ static int optee_ffa_shm_unregister_supp(struct tee_conte=
xt *ctx,
 	 */
=20
 	optee_shm_rem_ffa_handle(optee, global_handle);
-	rc =3D ffa_ops->memory_reclaim(global_handle, 0);
+	mem_ops =3D optee->ffa.ffa_dev->ops->mem_ops;
+	rc =3D mem_ops->memory_reclaim(global_handle, 0);
 	if (rc)
 		pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
=20
@@ -530,7 +532,7 @@ static int optee_ffa_yielding_call(struct tee_context *ct=
x,
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
-	const struct ffa_ops *ffa_ops =3D ffa_dev->ops;
+	const struct ffa_msg_ops *msg_ops =3D ffa_dev->ops->msg_ops;
 	struct optee_call_waiter w;
 	u32 cmd =3D data->data0;
 	u32 w4 =3D data->data1;
@@ -541,7 +543,7 @@ static int optee_ffa_yielding_call(struct tee_context *ct=
x,
 	/* Initialize waiter */
 	optee_cq_wait_init(&optee->call_queue, &w);
 	while (true) {
-		rc =3D ffa_ops->sync_send_receive(ffa_dev, data);
+		rc =3D msg_ops->sync_send_receive(ffa_dev, data);
 		if (rc)
 			goto done;
=20
@@ -576,7 +578,7 @@ static int optee_ffa_yielding_call(struct tee_context *ct=
x,
 		 * OP-TEE has returned with a RPC request.
 		 *
 		 * Note that data->data4 (passed in register w7) is already
-		 * filled in by ffa_ops->sync_send_receive() returning
+		 * filled in by ffa_mem_ops->sync_send_receive() returning
 		 * above.
 		 */
 		cond_resched();
@@ -654,12 +656,13 @@ static int optee_ffa_do_call_with_arg(struct tee_contex=
t *ctx,
 static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 					const struct ffa_ops *ops)
 {
+	const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;
 	struct ffa_send_direct_data data =3D { OPTEE_FFA_GET_API_VERSION };
 	int rc;
=20
-	ops->mode_32bit_set(ffa_dev);
+	msg_ops->mode_32bit_set(ffa_dev);
=20
-	rc =3D ops->sync_send_receive(ffa_dev, &data);
+	rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d\n", rc);
 		return false;
@@ -672,7 +675,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device=
 *ffa_dev,
 	}
=20
 	data =3D (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION };
-	rc =3D ops->sync_send_receive(ffa_dev, &data);
+	rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d\n", rc);
 		return false;
@@ -694,7 +697,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ff=
a_dev,
 	struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABILITIES };
 	int rc;
=20
-	rc =3D ops->sync_send_receive(ffa_dev, &data);
+	rc =3D ops->msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d", rc);
 		return false;
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 5964b6104996..5f02d2e6b9d9 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -257,16 +257,28 @@ struct ffa_mem_ops_args {
 	struct ffa_mem_region_attributes *attrs;
 };
=20
-struct ffa_ops {
+struct ffa_info_ops {
 	u32 (*api_version_get)(void);
 	int (*partition_info_get)(const char *uuid_str,
 				  struct ffa_partition_info *buffer);
+};
+
+struct ffa_msg_ops {
 	void (*mode_32bit_set)(struct ffa_device *dev);
 	int (*sync_send_receive)(struct ffa_device *dev,
 				 struct ffa_send_direct_data *data);
+};
+
+struct ffa_mem_ops {
 	int (*memory_reclaim)(u64 g_handle, u32 flags);
 	int (*memory_share)(struct ffa_mem_ops_args *args);
 	int (*memory_lend)(struct ffa_mem_ops_args *args);
 };
=20
+struct ffa_ops {
+	const struct ffa_info_ops *info_ops;
+	const struct ffa_msg_ops *msg_ops;
+	const struct ffa_mem_ops *mem_ops;
+};
+
 #endif /* _LINUX_ARM_FFA_H */
--=20
2.37.3


--===============4939858190142196456==--

