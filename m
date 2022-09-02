From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 07/10] firmware: arm_ffa: Rename ffa_dev_ops as ffa_ops
Date: Fri, 02 Sep 2022 13:40:29 +0100
Message-ID: <20220902124032.788488-8-sudeep.holla@arm.com>
In-Reply-To: <20220902124032.788488-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6516520485915431973=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6516520485915431973==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Except the message APIs, all other APIs are ffa_device independent and can
be used without any associated ffa_device from a non ffa_driver.

In order to reflect the same, just rename ffa_dev_ops as ffa_ops to
avoid any confusion or to keep it simple.

Suggested-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/bus.c    |  2 +-
 drivers/firmware/arm_ffa/driver.c |  2 +-
 drivers/tee/optee/ffa_abi.c       | 14 +++++++-------
 include/linux/arm_ffa.h           |  8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 69328041fbc3..99d439480612 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -168,7 +168,7 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
 }
=20
 struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
-				       const struct ffa_dev_ops *ops)
+				       const struct ffa_ops *ops)
 {
 	int ret;
 	struct device *dev;
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index e4fd35773071..2532e0f16cc9 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -666,7 +666,7 @@ static int ffa_memory_lend(struct ffa_mem_ops_args *args)
 	return ffa_memory_ops(FFA_MEM_LEND, args);
 }
=20
-static const struct ffa_dev_ops ffa_ops =3D {
+static const struct ffa_ops ffa_ops =3D {
 	.api_version_get =3D ffa_api_version_get,
 	.partition_info_get =3D ffa_partition_info_get,
 	.mode_32bit_set =3D ffa_mode_32bit_set,
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 7257b42d0545..2ce5b87dfb27 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -272,7 +272,7 @@ static int optee_ffa_shm_register(struct tee_context *ctx=
, struct tee_shm *shm,
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
-	const struct ffa_dev_ops *ffa_ops =3D ffa_dev->ops;
+	const struct ffa_ops *ffa_ops =3D ffa_dev->ops;
 	struct ffa_mem_region_attributes mem_attr =3D {
 		.receiver =3D ffa_dev->vm_id,
 		.attrs =3D FFA_MEM_RW,
@@ -315,7 +315,7 @@ static int optee_ffa_shm_unregister(struct tee_context *c=
tx,
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
-	const struct ffa_dev_ops *ffa_ops =3D ffa_dev->ops;
+	const struct ffa_ops *ffa_ops =3D ffa_dev->ops;
 	u64 global_handle =3D shm->sec_world_id;
 	struct ffa_send_direct_data data =3D {
 		.data0 =3D OPTEE_FFA_UNREGISTER_SHM,
@@ -342,7 +342,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_conte=
xt *ctx,
 					 struct tee_shm *shm)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-	const struct ffa_dev_ops *ffa_ops =3D optee->ffa.ffa_dev->ops;
+	const struct ffa_ops *ffa_ops =3D optee->ffa.ffa_dev->ops;
 	u64 global_handle =3D shm->sec_world_id;
 	int rc;
=20
@@ -530,7 +530,7 @@ static int optee_ffa_yielding_call(struct tee_context *ct=
x,
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
-	const struct ffa_dev_ops *ffa_ops =3D ffa_dev->ops;
+	const struct ffa_ops *ffa_ops =3D ffa_dev->ops;
 	struct optee_call_waiter w;
 	u32 cmd =3D data->data0;
 	u32 w4 =3D data->data1;
@@ -652,7 +652,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context =
*ctx,
  */
=20
 static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
-					const struct ffa_dev_ops *ops)
+					const struct ffa_ops *ops)
 {
 	struct ffa_send_direct_data data =3D { OPTEE_FFA_GET_API_VERSION };
 	int rc;
@@ -687,7 +687,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device=
 *ffa_dev,
 }
=20
 static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
-				    const struct ffa_dev_ops *ops,
+				    const struct ffa_ops *ops,
 				    u32 *sec_caps,
 				    unsigned int *rpc_param_count)
 {
@@ -783,7 +783,7 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
=20
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
-	const struct ffa_dev_ops *ffa_ops;
+	const struct ffa_ops *ffa_ops;
 	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
 	struct tee_device *teedev;
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index eafab07c9f58..4c4b06783035 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -17,7 +17,7 @@ struct ffa_device {
 	bool mode_32bit;
 	uuid_t uuid;
 	struct device dev;
-	const struct ffa_dev_ops *ops;
+	const struct ffa_ops *ops;
 };
=20
 #define to_ffa_dev(d) container_of(d, struct ffa_device, dev)
@@ -49,7 +49,7 @@ static inline void *ffa_dev_get_drvdata(struct ffa_device *=
fdev)
=20
 #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
 struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
-				       const struct ffa_dev_ops *ops);
+				       const struct ffa_ops *ops);
 void ffa_device_unregister(struct ffa_device *ffa_dev);
 int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
 			const char *mod_name);
@@ -59,7 +59,7 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev);
 #else
 static inline
 struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
-				       const struct ffa_dev_ops *ops)
+				       const struct ffa_ops *ops)
 {
 	return NULL;
 }
@@ -254,7 +254,7 @@ struct ffa_mem_ops_args {
 	struct ffa_mem_region_attributes *attrs;
 };
=20
-struct ffa_dev_ops {
+struct ffa_ops {
 	u32 (*api_version_get)(void);
 	int (*partition_info_get)(const char *uuid_str,
 				  struct ffa_partition_info *buffer);
--=20
2.37.3


--===============6516520485915431973==--

