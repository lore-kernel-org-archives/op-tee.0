From: Yoochan Lee <yoochan1026@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: smc_abi: Fix use-after-free in optee_smc_open
Date: Sat, 31 Dec 2022 05:20:01 +0000
Message-ID: <20221231051954.2038772-1-yoochan1026@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0991830118912514666=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0991830118912514666==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

A race condition may occur if the user physically removes the
smc_abi device while calling open().

This is a race condition between optee_smc_open() function and
the optee_smc_remove() function, which may lead to Use-After-Free.

Therefore, add a refcount check to optee_smc_remove() function
to free the "optee" structure after the device is close()d.

---------------CPU 0--------------------CPU 1-----------------
         optee_smc_open()     |     optee_smc_remove()
--------------------------------------------------------------
struct optee *optee =3D tee_get_|
drvdata(ctx->teedev); =E2=80=94 (1)   |
                              | struct optee *optee =3D platform_
                              | get_drvdata(pdev);
                              | ...
                              | kfree(optee); =E2=80=94 (2)
u32 sec_caps =3D optee->smc.sec_|
caps; =E2=80=94 (3)

Signed-off-by: Yoochan Lee <yoochan1026@gmail.com>
---
 drivers/tee/optee/optee_private.h |  1 +
 drivers/tee/optee/smc_abi.c       | 66 ++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 04ae58892608..f52b1cf20eab 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -175,6 +175,7 @@ struct optee {
 	bool   scan_bus_done;
 	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
+	struct kref refcnt;
 };
=20
 struct optee_session {
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..4fbec2acc255 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1077,18 +1077,61 @@ static void optee_get_version(struct tee_device *teed=
ev,
 	*vers =3D v;
 }
=20
+static void optee_smc_delete(struct kref *kref)
+{
+	struct optee *optee =3D container_of(kref, struct optee, refcnt);
+
+	/*
+	 * Ask OP-TEE to free all cached shared memory objects to decrease
+	 * reference counters and also avoid wild pointers in secure world
+	 * into the old shared memory range.
+	 */
+	if (!optee->rpc_param_count)
+		optee_disable_shm_cache(optee);
+
+	optee_smc_notif_uninit_irq(optee);
+
+	optee_remove_common(optee);
+
+	if (optee->smc.memremaped_shm)
+		memunmap(optee->smc.memremaped_shm);
+
+	kfree(optee);
+}
+
+static void optee_smc_release_supp(struct tee_context *ctx)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+
+	optee_release_helper(ctx, optee_close_session_helper);
+	if (optee->scan_bus_wq) {
+		destroy_workqueue(optee->scan_bus_wq);
+		optee->scan_bus_wq =3D NULL;
+	}
+	optee_supp_release(&optee->supp);
+	kref_put(&optee->refcnt, optee_smc_delete);
+}
+
+static void optee_smc_release(struct tee_context *ctx)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+
+	optee_release_helper(ctx, optee_close_session_helper);
+	kref_put(&optee->refcnt, optee_smc_delete);
+}
+
 static int optee_smc_open(struct tee_context *ctx)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	u32 sec_caps =3D optee->smc.sec_caps;
-
+	kref_get(&optee->refcnt);
 	return optee_open(ctx, sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL);
 }
=20
 static const struct tee_driver_ops optee_clnt_ops =3D {
 	.get_version =3D optee_get_version,
 	.open =3D optee_smc_open,
-	.release =3D optee_release,
+	.release =3D optee_smc_release,
 	.open_session =3D optee_open_session,
 	.close_session =3D optee_close_session,
 	.invoke_func =3D optee_invoke_func,
@@ -1106,7 +1149,7 @@ static const struct tee_desc optee_clnt_desc =3D {
 static const struct tee_driver_ops optee_supp_ops =3D {
 	.get_version =3D optee_get_version,
 	.open =3D optee_smc_open,
-	.release =3D optee_release_supp,
+	.release =3D optee_smc_release_supp,
 	.supp_recv =3D optee_supp_recv,
 	.supp_send =3D optee_supp_send,
 	.shm_register =3D optee_shm_register_supp,
@@ -1319,22 +1362,7 @@ static int optee_smc_remove(struct platform_device *pd=
ev)
 {
 	struct optee *optee =3D platform_get_drvdata(pdev);
=20
-	/*
-	 * Ask OP-TEE to free all cached shared memory objects to decrease
-	 * reference counters and also avoid wild pointers in secure world
-	 * into the old shared memory range.
-	 */
-	if (!optee->rpc_param_count)
-		optee_disable_shm_cache(optee);
-
-	optee_smc_notif_uninit_irq(optee);
-
-	optee_remove_common(optee);
-
-	if (optee->smc.memremaped_shm)
-		memunmap(optee->smc.memremaped_shm);
-
-	kfree(optee);
+	kref_put(&optee->refcnt, optee_smc_delete);
=20
 	return 0;
 }
--=20
2.39.0


--===============0991830118912514666==--

