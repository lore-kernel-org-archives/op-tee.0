From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v13 3/7] remoteproc: core: Refactor resource table cleanup
 into rproc_release_fw
Date: Mon, 04 Nov 2024 14:35:11 +0100
Message-ID: <20241104133515.256497-4-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20241104133515.256497-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7293720959115732737=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7293720959115732737==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This patch centralizing the cleanup of the resource table into a new
helper function rproc_release_fw().

More than just factorizing the code into a common function, it is the
first step to integrate the release of the firmware image loaded by the
OP-TEE remoteproc framework.

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remote=
proc_core.c
index ace11ea17097..7694817f25d4 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1256,6 +1256,13 @@ static int rproc_alloc_registered_carveouts(struct rpr=
oc *rproc)
 	return 0;
 }
=20
+static void rproc_release_fw(struct rproc *rproc)
+{
+	/* Free the copy of the resource table */
+	kfree(rproc->cached_table);
+	rproc->cached_table =3D NULL;
+	rproc->table_ptr =3D NULL;
+}
=20
 /**
  * rproc_resource_cleanup() - clean up and free all acquired resources
@@ -1485,9 +1492,7 @@ static int rproc_fw_boot(struct rproc *rproc, const str=
uct firmware *fw)
=20
 clean_up_resources:
 	rproc_resource_cleanup(rproc);
-	kfree(rproc->cached_table);
-	rproc->cached_table =3D NULL;
-	rproc->table_ptr =3D NULL;
+	rproc_release_fw(rproc);
 unprepare_rproc:
 	/* release HW resources if needed */
 	rproc_unprepare_device(rproc);
@@ -2067,10 +2072,7 @@ int rproc_shutdown(struct rproc *rproc)
=20
 	rproc_disable_iommu(rproc);
=20
-	/* Free the copy of the resource table */
-	kfree(rproc->cached_table);
-	rproc->cached_table =3D NULL;
-	rproc->table_ptr =3D NULL;
+	rproc_release_fw(rproc);
 out:
 	mutex_unlock(&rproc->lock);
 	return ret;
@@ -2133,10 +2135,7 @@ int rproc_detach(struct rproc *rproc)
=20
 	rproc_disable_iommu(rproc);
=20
-	/* Free the copy of the resource table */
-	kfree(rproc->cached_table);
-	rproc->cached_table =3D NULL;
-	rproc->table_ptr =3D NULL;
+	rproc_release_fw(rproc);
 out:
 	mutex_unlock(&rproc->lock);
 	return ret;
--=20
2.25.1


--===============7293720959115732737==--

