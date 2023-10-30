From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 2/2] tee: optee: Remove redundant custom workqueue
Date: Mon, 30 Oct 2023 21:29:01 +0530
Message-ID: <20231030155901.80673-3-sumit.garg@linaro.org>
In-Reply-To: <20231030155901.80673-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7658192125959698350=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7658192125959698350==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Global system workqueue is sufficient to suffice OP-TEE bus scanning work
needs. So drop redundant usage of the custom workqueue.

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/core.c          | 13 ++-----------
 drivers/tee/optee/optee_private.h |  2 --
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a258bd3b6b5..1eaa191b6ff6 100644
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
@@ -110,12 +109,7 @@ int optee_open(struct tee_context *ctx, bool cap_memref_=
null)
=20
 		if (!optee->scan_bus_done) {
 			INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
-			optee->scan_bus_wq =3D create_workqueue("optee_bus_scan");
-			if (!optee->scan_bus_wq) {
-				kfree(ctxdata);
-				return -ECHILD;
-			}
-			queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
+			schedule_work(&optee->scan_bus_work);
 			optee->scan_bus_done =3D true;
 		}
 	}
@@ -158,10 +152,7 @@ void optee_release_supp(struct tee_context *ctx)
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
=20
 	optee_release_helper(ctx, optee_close_session_helper);
-	if (optee->scan_bus_wq) {
-		destroy_workqueue(optee->scan_bus_wq);
-		optee->scan_bus_wq =3D NULL;
-	}
+
 	optee_supp_release(&optee->supp);
 }
=20
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 6bb5cae09688..94c0ee381894 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -178,7 +178,6 @@ struct optee_ops {
  * @pool:		shared memory pool
  * @rpc_param_count:	If > 0 number of RPC parameters to make room for
  * @scan_bus_done	flag if device registation was already done.
- * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
  * @scan_bus_work	workq to scan optee bus and register optee drivers
  */
 struct optee {
@@ -197,7 +196,6 @@ struct optee {
 	struct tee_shm_pool *pool;
 	unsigned int rpc_param_count;
 	bool   scan_bus_done;
-	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
 };
=20
--=20
2.34.1


--===============7658192125959698350==--

