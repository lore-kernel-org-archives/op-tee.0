From: Yoochan Lee <yoochan1026@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: ffa_abi: Fix use-after-free in optee_ffa_open
Date: Sat, 31 Dec 2022 05:34:26 +0000
Message-ID: <20221231053421.2039591-1-yoochan1026@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0464608635388126607=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0464608635388126607==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

A race condition may occur if the user physically removes the
ffa_abi device while calling open().

This is a race condition between optee_open() function and
the optee_ffa_remove() function, which may lead to Use-After-Free.

Therefore, add a refcount check to optee_ffa_remove() function
to free the "optee" structure after the device is close()d.

---------------CPU 0--------------------CPU 1-----------------
            optee_open()      |     optee_ffa_remove()
--------------------------------------------------------------
struct optee *optee =3D tee_get_|
drvdata(teedev); =E2=80=94 (1)        |
                              | struct optee *optee =3D ffa_dev_
                              | get_drvdata(ffa_dev);
                              | ...
                              | kfree(optee); =E2=80=94 (2)
if (teedev =3D=3D optee->supp_    |
teedev) { =E2=80=94 (3)               |

Signed-off-by: Yoochan Lee <yoochan1026@gmail.com>
---
 drivers/tee/optee/ffa_abi.c       | 49 +++++++++++++++++++++++++------
 drivers/tee/optee/optee_private.h |  1 +
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 0828240f27e6..ea76d7532419 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -726,15 +726,52 @@ static void optee_ffa_get_version(struct tee_device *te=
edev,
 	*vers =3D v;
 }
=20
+static void optee_ffa_delete(struct kref *kref)
+{
+	struct optee *optee =3D container_of(kref, struct optee, refcnt);
+
+	optee_remove_common(optee);
+
+	mutex_destroy(&optee->ffa.mutex);
+	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
+
+	kfree(optee);
+
+}
+
+static void optee_ffa_release(struct tee_context *ctx)
+{
+	struct optee *optee =3D tee_get_drvdata(teedev);
+
+	optee_release_helper(ctx, optee_close_session_helper);
+	kref_put(&optee->refcnt, optee_ffa_delete);
+}
+
+void optee_ffa_release_supp(struct tee_context *ctx)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+
+	optee_release_helper(ctx, optee_close_session_helper);
+	if (optee->scan_bus_wq) {
+		destroy_workqueue(optee->scan_bus_wq);
+		optee->scan_bus_wq =3D NULL;
+	}
+	optee_supp_release(&optee->supp);
+	kref_put(&optee->refcnt, optee_ffa_delete);
+}
+
 static int optee_ffa_open(struct tee_context *ctx)
 {
+	struct optee *optee =3D tee_get_drvdata(teedev);
+	kref_get(&optee->refcnt);
+
 	return optee_open(ctx, true);
 }
=20
 static const struct tee_driver_ops optee_ffa_clnt_ops =3D {
 	.get_version =3D optee_ffa_get_version,
 	.open =3D optee_ffa_open,
-	.release =3D optee_release,
+	.release =3D optee_ffa_release,
 	.open_session =3D optee_open_session,
 	.close_session =3D optee_close_session,
 	.invoke_func =3D optee_invoke_func,
@@ -752,7 +789,7 @@ static const struct tee_desc optee_ffa_clnt_desc =3D {
 static const struct tee_driver_ops optee_ffa_supp_ops =3D {
 	.get_version =3D optee_ffa_get_version,
 	.open =3D optee_ffa_open,
-	.release =3D optee_release_supp,
+	.release =3D optee_ffa_release_supp,
 	.supp_recv =3D optee_supp_recv,
 	.supp_send =3D optee_supp_send,
 	.shm_register =3D optee_ffa_shm_register, /* same as for clnt ops */
@@ -775,13 +812,7 @@ static const struct optee_ops optee_ffa_ops =3D {
 static void optee_ffa_remove(struct ffa_device *ffa_dev)
 {
 	struct optee *optee =3D ffa_dev_get_drvdata(ffa_dev);
-
-	optee_remove_common(optee);
-
-	mutex_destroy(&optee->ffa.mutex);
-	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
-
-	kfree(optee);
+	kref_put(&optee->refcnt, optee_ffa_delete);
 }
=20
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
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
--=20
2.39.0


--===============0464608635388126607==--

