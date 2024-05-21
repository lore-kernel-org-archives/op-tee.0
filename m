From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RESEND PATCH v5 5/7] remoteproc: core: support of the tee interface
Date: Tue, 21 May 2024 14:24:56 +0200
Message-ID: <20240521122458.3517054-6-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20240521122458.3517054-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1834450580051385227=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1834450580051385227==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

1) on start:
- Using the TEE loader, the resource table is loaded by an external entity.
In such case the resource table address is not find from the firmware but
provided by the TEE remoteproc framework.
Use the rproc_get_loaded_rsc_table instead of rproc_find_loaded_rsc_table
- test that rproc->cached_table is not null before performing the memcpy

2)on stop
The use of the cached_table seems mandatory:
- during recovery sequence to have a snapshot of the resource table
  resources used,
- on stop to allow  for the deinitialization of resources after the
  the remote processor has been shutdown.
However if the TEE interface is being used, we first need to unmap the
table_ptr before setting it to rproc->cached_table.
The update of rproc->table_ptr to rproc->cached_table is performed in
tee_remoteproc.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 31 +++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remote=
proc_core.c
index 42bca01f3bde..3a642151c983 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1267,6 +1267,7 @@ EXPORT_SYMBOL(rproc_resource_cleanup);
 static int rproc_set_rsc_table_on_start(struct rproc *rproc, const struct fi=
rmware *fw)
 {
 	struct resource_table *loaded_table;
+	struct device *dev =3D &rproc->dev;
=20
 	/*
 	 * The starting device has been given the rproc->cached_table as the
@@ -1276,12 +1277,21 @@ static int rproc_set_rsc_table_on_start(struct rproc =
*rproc, const struct firmwa
 	 * this information to device memory. We also update the table_ptr so
 	 * that any subsequent changes will be applied to the loaded version.
 	 */
-	loaded_table =3D rproc_find_loaded_rsc_table(rproc, fw);
-	if (loaded_table) {
-		memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
-		rproc->table_ptr =3D loaded_table;
+	if (rproc->tee_interface) {
+		loaded_table =3D rproc_get_loaded_rsc_table(rproc, &rproc->table_sz);
+		if (IS_ERR(loaded_table)) {
+			dev_err(dev, "can't get resource table\n");
+			return PTR_ERR(loaded_table);
+		}
+	} else {
+		loaded_table =3D rproc_find_loaded_rsc_table(rproc, fw);
 	}
=20
+	if (loaded_table && rproc->cached_table)
+		memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
+
+	rproc->table_ptr =3D loaded_table;
+
 	return 0;
 }
=20
@@ -1318,11 +1328,16 @@ static int rproc_reset_rsc_table_on_stop(struct rproc=
 *rproc)
 	kfree(rproc->clean_table);
=20
 out:
-	/*
-	 * Use a copy of the resource table for the remainder of the
-	 * shutdown process.
+	/* If the remoteproc_tee interface is used, then we have first to unmap the=
 resource table
+	 * before updating the proc->table_ptr reference.
 	 */
-	rproc->table_ptr =3D rproc->cached_table;
+	if (!rproc->tee_interface) {
+		/*
+		 * Use a copy of the resource table for the remainder of the
+		 * shutdown process.
+		 */
+		rproc->table_ptr =3D rproc->cached_table;
+	}
 	return 0;
 }
=20
--=20
2.25.1


--===============1834450580051385227==--

