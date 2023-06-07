From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: Fix supplicant based device enumeration
Date: Wed, 07 Jun 2023 20:44:35 +0530
Message-ID: <20230607151435.92654-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7687376933643431306=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7687376933643431306==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Currently supplicant dependent optee device enumeration only registers
devices whenever tee-supplicant is invoked for the first time. But it
forgets to remove devices when tee-supplicant daemon stops running and
closes its context gracefully. This leads to following splats for fTPM
driver during reboot/shutdown:

[   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0=
xffff3024
[   73.474497] ------------[ cut here ]------------
[   73.479119] WARNING: CPU: 1 PID: 1 at drivers/char/tpm/tpm_ftpm_tee.c:135 =
ftpm_tee_tpm_op_send+0x200/0x25c
<snip>
[   73.539952] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=3D--)
[   73.545946] pc : ftpm_tee_tpm_op_send+0x200/0x25c
[   73.550640] lr : ftpm_tee_tpm_op_send+0x200/0x25c
[   73.555331] sp : ffff80001129baa0
[   73.558635] x29: ffff80001129baa0 x28: ffff00000646f000
[   73.563938] x27: ffff8000110f7000 x26: 0000000000000016
[   73.569241] x25: 0000000000000145 x24: ffff000005395000
[   73.574544] x23: ffff0000065a7280 x22: ffff00000646f000
[   73.579847] x21: ffff000006422080 x20: 000000000000000c
[   73.585149] x19: 0000000000000000 x18: 0000000000000000
[   73.590450] x17: 0000000000000000 x16: 0000000000000000
[   73.595753] x15: 0000000000000030 x14: ffffffffffffffff
[   73.601055] x13: ffff80001110e838 x12: 00000000000006d2
[   73.606357] x11: 0000000000000246 x10: ffff800011166838
[   73.611659] x9 : 00000000fffff000 x8 : ffff80001110e838
[   73.616962] x7 : ffff800011166838 x6 : 0000000000000000
[   73.622263] x5 : 0000000000000000 x4 : 0000000000000000
[   73.627565] x3 : 0000000000000000 x2 : 0000000000000000
[   73.632867] x1 : 0000000000000000 x0 : ffff0000000e8000
[   73.638170] Call trace:
[   73.640610]  ftpm_tee_tpm_op_send+0x200/0x25c
[   73.644960]  tpm_transmit+0xc8/0x33c
[   73.648528]  tpm_transmit_cmd+0x30/0xc0
[   73.652353]  tpm2_shutdown+0xa4/0x100
[   73.656007]  tpm_class_shutdown+0x60/0x90
[   73.660009]  device_shutdown+0x138/0x330
[   73.663926]  __do_sys_reboot+0x218/0x2a0
[   73.667839]  __arm64_sys_reboot+0x24/0x30
[   73.671842]  el0_svc_common.constprop.0+0x78/0x1c4
[   73.676622]  do_el0_svc+0x24/0x8c
[   73.679932]  el0_svc+0x14/0x20
[   73.682978]  el0_sync_handler+0xb0/0xb4
[   73.686806]  el0_sync+0x180/0x1c0

Fix this properly by removing supplicant dependent devices when the
supplicant closes gracefully. While at it use the global system
workqueue for OP-TEE bus scanning work rather than our own custom one.

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Link: https://github.com/OP-TEE/optee_os/issues/6094
Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/core.c          | 26 +++++++++++---------------
 drivers/tee/optee/device.c        | 27 ++++++++++++++++++++++++---
 drivers/tee/optee/optee_private.h |  7 ++-----
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index d01ca47f7bde..e0f2c9cb0073 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -15,7 +15,6 @@
 #include <linux/string.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
 #include "optee_private.h"
=20
 int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *sh=
m,
@@ -84,6 +83,11 @@ static void optee_bus_scan(struct work_struct *work)
 	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
 }
=20
+static void optee_bus_remove(struct work_struct *work)
+{
+	optee_unregister_supp_devices();
+}
+
 int optee_open(struct tee_context *ctx, bool cap_memref_null)
 {
 	struct optee_context_data *ctxdata;
@@ -108,16 +112,8 @@ int optee_open(struct tee_context *ctx, bool cap_memref_=
null)
 			return -EBUSY;
 		}
=20
-		if (!optee->scan_bus_done) {
-			INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
-			optee->scan_bus_wq =3D create_workqueue("optee_bus_scan");
-			if (!optee->scan_bus_wq) {
-				kfree(ctxdata);
-				return -ECHILD;
-			}
-			queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
-			optee->scan_bus_done =3D true;
-		}
+		INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
+		schedule_work(&optee->scan_bus_work);
 	}
 	mutex_init(&ctxdata->mutex);
 	INIT_LIST_HEAD(&ctxdata->sess_list);
@@ -159,10 +155,10 @@ void optee_release_supp(struct tee_context *ctx)
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
=20
 	optee_release_helper(ctx, optee_close_session_helper);
-	if (optee->scan_bus_wq) {
-		destroy_workqueue(optee->scan_bus_wq);
-		optee->scan_bus_wq =3D NULL;
-	}
+
+	INIT_WORK(&optee->scan_bus_work, optee_bus_remove);
+	schedule_work(&optee->scan_bus_work);
+
 	optee_supp_release(&optee->supp);
 }
=20
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 64f0e047c23d..88e1c3feb15d 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
 	kfree(optee_device);
 }
=20
-static int optee_register_device(const uuid_t *device_uuid)
+static int optee_register_device(const uuid_t *device_uuid, u32 func)
 {
 	struct tee_client_device *optee_device =3D NULL;
+	const char *dev_name_fmt =3D NULL;
 	int rc;
=20
 	optee_device =3D kzalloc(sizeof(*optee_device), GFP_KERNEL);
@@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
=20
 	optee_device->dev.bus =3D &tee_bus_type;
 	optee_device->dev.release =3D optee_release_device;
-	if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
+
+	if (func =3D=3D PTA_CMD_GET_DEVICES_SUPP)
+		dev_name_fmt =3D "optee-ta-supp-%pUb";
+	else
+		dev_name_fmt =3D "optee-ta-%pUb";
+
+	if (dev_set_name(&optee_device->dev, dev_name_fmt, device_uuid)) {
 		kfree(optee_device);
 		return -ENOMEM;
 	}
@@ -142,7 +149,7 @@ static int __optee_enumerate_devices(u32 func)
 	num_devices =3D shm_size / sizeof(uuid_t);
=20
 	for (idx =3D 0; idx < num_devices; idx++) {
-		rc =3D optee_register_device(&device_uuid[idx]);
+		rc =3D optee_register_device(&device_uuid[idx], func);
 		if (rc)
 			goto out_shm;
 	}
@@ -175,3 +182,17 @@ void optee_unregister_devices(void)
 	bus_for_each_dev(&tee_bus_type, NULL, NULL,
 			 __optee_unregister_device);
 }
+
+static int __optee_unregister_supp_device(struct device *dev, void *data)
+{
+	if (!strncmp(dev_name(dev), "optee-ta-supp", strlen("optee-ta-supp")))
+		device_unregister(dev);
+
+	return 0;
+}
+
+void optee_unregister_supp_devices(void)
+{
+	bus_for_each_dev(&tee_bus_type, NULL, NULL,
+			 __optee_unregister_supp_device);
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 6dcecb83c893..cb5eae6f797d 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -192,9 +192,7 @@ struct optee_ops {
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
  * @rpc_param_count:	If > 0 number of RPC parameters to make room for
- * @scan_bus_done	flag if device registation was already done.
- * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
- * @scan_bus_work	workq to scan optee bus and register optee drivers
+ * @scan_bus_work	work to scan optee bus and register optee drivers
  */
 struct optee {
 	struct tee_device *supp_teedev;
@@ -211,8 +209,6 @@ struct optee {
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
 	unsigned int rpc_param_count;
-	bool   scan_bus_done;
-	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
 };
=20
@@ -280,6 +276,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_=
id, u32 session);
 #define PTA_CMD_GET_DEVICES_SUPP	0x1
 int optee_enumerate_devices(u32 func);
 void optee_unregister_devices(void);
+void optee_unregister_supp_devices(void);
=20
 int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *sh=
m,
 			       size_t size, size_t align,
--=20
2.34.1


--===============7687376933643431306==--

