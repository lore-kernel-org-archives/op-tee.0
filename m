From: Allen Pais <allen.lkml@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 1/2] optee: fix tee out of memory failure seen during kexec reboot
Date: Wed, 17 Feb 2021 14:57:13 +0530
Message-ID: <20210217092714.121297-2-allen.lkml@gmail.com>
In-Reply-To: <20210217092714.121297-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0112282669880079063=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0112282669880079063==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Allen Pais <apais@linux.microsoft.com>

The following out of memory errors are seen on kexec reboot
from the optee core.

[    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
[    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22

tee_shm_release() is not invoked on dma shm buffer.

Implement .shutdown() method to handle the release of the buffers
correctly.

More info:
https://github.com/OP-TEE/optee_os/issues/3637

Signed-off-by: Allen Pais <apais@linux.microsoft.com>
---
 drivers/tee/optee/core.c | 69 ++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index cf4718c6d35d..b402e5eace7b 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -582,36 +582,64 @@ static optee_invoke_fn *get_invoke_func(struct device *=
dev)
 	return ERR_PTR(-EINVAL);
 }
=20
-static int optee_remove(struct platform_device *pdev)
+static int __optee_shutoff(struct platform_device *pdev, bool shutdown)
 {
 	struct optee *optee =3D platform_get_drvdata(pdev);
=20
-	/*
-	 * Ask OP-TEE to free all cached shared memory objects to decrease
-	 * reference counters and also avoid wild pointers in secure world
-	 * into the old shared memory range.
-	 */
-	optee_disable_shm_cache(optee);
+	if (shutdown) {
+		optee_disable_shm_cache(optee);
+	} else {
+		/*
+		 * Ask OP-TEE to free all cached shared memory
+		 * objects to decrease reference counters and
+		 * also avoid wild pointers in secure world
+		 * into the old shared memory range.
+		 */
+		optee_disable_shm_cache(optee);
=20
-	/*
-	 * The two devices have to be unregistered before we can free the
-	 * other resources.
-	 */
-	tee_device_unregister(optee->supp_teedev);
-	tee_device_unregister(optee->teedev);
+		/*
+		 * The two devices have to be unregistered before
+		 * we can free the other resources.
+		 */
+		tee_device_unregister(optee->supp_teedev);
+		tee_device_unregister(optee->teedev);
=20
-	tee_shm_pool_free(optee->pool);
-	if (optee->memremaped_shm)
-		memunmap(optee->memremaped_shm);
-	optee_wait_queue_exit(&optee->wait_queue);
-	optee_supp_uninit(&optee->supp);
-	mutex_destroy(&optee->call_queue.mutex);
+		tee_shm_pool_free(optee->pool);
+		if (optee->memremaped_shm)
+			memunmap(optee->memremaped_shm);
+		optee_wait_queue_exit(&optee->wait_queue);
+		optee_supp_uninit(&optee->supp);
+		mutex_destroy(&optee->call_queue.mutex);
=20
-	kfree(optee);
+		kfree(optee);
+	}
=20
 	return 0;
 }
=20
+/* optee_remove - Device Removal Routine
+ * @pdev: platform device information struct
+ *
+ * optee_remove is called by platform subsystem to alter the driver
+ * that it should release the device
+ */
+static int optee_remove(struct platform_device *pdev)
+{
+	return __optee_shutoff(pdev, false);
+}
+
+/* optee_shutdown - Device Removal Routine
+ * @pdev: platform device information struct
+ *
+ * platform_shutdown is called by the platform subsystem to alter
+ * the driver that a shutdown/reboot(or kexec) is happening and
+ * device must be disabled.
+ */
+static void optee_shutdown(struct platform_device *pdev)
+{
+	__optee_shutoff(pdev, true);
+}
+
 static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
@@ -738,6 +766,7 @@ MODULE_DEVICE_TABLE(of, optee_dt_match);
 static struct platform_driver optee_driver =3D {
 	.probe  =3D optee_probe,
 	.remove =3D optee_remove,
+	.shutdown =3D optee_shutdown,
 	.driver =3D {
 		.name =3D "optee",
 		.of_match_table =3D optee_dt_match,
--=20
2.25.1


--===============0112282669880079063==--

