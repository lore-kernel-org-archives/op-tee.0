From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RESEND PATCH v5 4/7] remoteproc: core introduce
 rproc_set_rsc_table_on_start function
Date: Tue, 21 May 2024 14:24:55 +0200
Message-ID: <20240521122458.3517054-5-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20240521122458.3517054-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0795317220328795471=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0795317220328795471==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Split rproc_start()to prepare the update of the management of
the cache table on start, for the support of the firmware loading
by the TEE interface.
- create rproc_set_rsc_table_on_start() to address the management of
  the cache table in a specific function, as done in
  rproc_reset_rsc_table_on_stop().
- rename rproc_set_rsc_table in rproc_set_rsc_table_on_attach()
- move rproc_reset_rsc_table_on_stop() to be close to the
  rproc_set_rsc_table_on_start() function

Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 116 ++++++++++++++-------------
 1 file changed, 62 insertions(+), 54 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remote=
proc_core.c
index f276956f2c5c..42bca01f3bde 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1264,18 +1264,9 @@ void rproc_resource_cleanup(struct rproc *rproc)
 }
 EXPORT_SYMBOL(rproc_resource_cleanup);
=20
-static int rproc_start(struct rproc *rproc, const struct firmware *fw)
+static int rproc_set_rsc_table_on_start(struct rproc *rproc, const struct fi=
rmware *fw)
 {
 	struct resource_table *loaded_table;
-	struct device *dev =3D &rproc->dev;
-	int ret;
-
-	/* load the ELF segments to memory */
-	ret =3D rproc_load_segments(rproc, fw);
-	if (ret) {
-		dev_err(dev, "Failed to load program segments: %d\n", ret);
-		return ret;
-	}
=20
 	/*
 	 * The starting device has been given the rproc->cached_table as the
@@ -1291,6 +1282,64 @@ static int rproc_start(struct rproc *rproc, const stru=
ct firmware *fw)
 		rproc->table_ptr =3D loaded_table;
 	}
=20
+	return 0;
+}
+
+static int rproc_reset_rsc_table_on_stop(struct rproc *rproc)
+{
+	/* A resource table was never retrieved, nothing to do here */
+	if (!rproc->table_ptr)
+		return 0;
+
+	/*
+	 * If a cache table exists the remote processor was started by
+	 * the remoteproc core.  That cache table should be used for
+	 * the rest of the shutdown process.
+	 */
+	if (rproc->cached_table)
+		goto out;
+
+	/*
+	 * If we made it here the remote processor was started by another
+	 * entity and a cache table doesn't exist.  As such make a copy of
+	 * the resource table currently used by the remote processor and
+	 * use that for the rest of the shutdown process.  The memory
+	 * allocated here is free'd in rproc_shutdown().
+	 */
+	rproc->cached_table =3D kmemdup(rproc->table_ptr,
+				      rproc->table_sz, GFP_KERNEL);
+	if (!rproc->cached_table)
+		return -ENOMEM;
+
+	/*
+	 * Since the remote processor is being switched off the clean table
+	 * won't be needed.  Allocated in rproc_set_rsc_table_on_start().
+	 */
+	kfree(rproc->clean_table);
+
+out:
+	/*
+	 * Use a copy of the resource table for the remainder of the
+	 * shutdown process.
+	 */
+	rproc->table_ptr =3D rproc->cached_table;
+	return 0;
+}
+
+static int rproc_start(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev =3D &rproc->dev;
+	int ret;
+
+	/* load the ELF segments to memory */
+	ret =3D rproc_load_segments(rproc, fw);
+	if (ret) {
+		dev_err(dev, "Failed to load program segments: %d\n", ret);
+		return ret;
+	}
+
+	rproc_set_rsc_table_on_start(rproc, fw);
+
 	ret =3D rproc_prepare_subdevices(rproc);
 	if (ret) {
 		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
@@ -1450,7 +1499,7 @@ static int rproc_fw_boot(struct rproc *rproc, const str=
uct firmware *fw)
 	return ret;
 }
=20
-static int rproc_set_rsc_table(struct rproc *rproc)
+static int rproc_set_rsc_table_on_attach(struct rproc *rproc)
 {
 	struct resource_table *table_ptr;
 	struct device *dev =3D &rproc->dev;
@@ -1540,54 +1589,13 @@ static int rproc_reset_rsc_table_on_detach(struct rpr=
oc *rproc)
=20
 	/*
 	 * The clean resource table is no longer needed.  Allocated in
-	 * rproc_set_rsc_table().
+	 * rproc_set_rsc_table_on_attach().
 	 */
 	kfree(rproc->clean_table);
=20
 	return 0;
 }
=20
-static int rproc_reset_rsc_table_on_stop(struct rproc *rproc)
-{
-	/* A resource table was never retrieved, nothing to do here */
-	if (!rproc->table_ptr)
-		return 0;
-
-	/*
-	 * If a cache table exists the remote processor was started by
-	 * the remoteproc core.  That cache table should be used for
-	 * the rest of the shutdown process.
-	 */
-	if (rproc->cached_table)
-		goto out;
-
-	/*
-	 * If we made it here the remote processor was started by another
-	 * entity and a cache table doesn't exist.  As such make a copy of
-	 * the resource table currently used by the remote processor and
-	 * use that for the rest of the shutdown process.  The memory
-	 * allocated here is free'd in rproc_shutdown().
-	 */
-	rproc->cached_table =3D kmemdup(rproc->table_ptr,
-				      rproc->table_sz, GFP_KERNEL);
-	if (!rproc->cached_table)
-		return -ENOMEM;
-
-	/*
-	 * Since the remote processor is being switched off the clean table
-	 * won't be needed.  Allocated in rproc_set_rsc_table().
-	 */
-	kfree(rproc->clean_table);
-
-out:
-	/*
-	 * Use a copy of the resource table for the remainder of the
-	 * shutdown process.
-	 */
-	rproc->table_ptr =3D rproc->cached_table;
-	return 0;
-}
-
 /*
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
@@ -1614,7 +1622,7 @@ static int rproc_attach(struct rproc *rproc)
 		goto disable_iommu;
 	}
=20
-	ret =3D rproc_set_rsc_table(rproc);
+	ret =3D rproc_set_rsc_table_on_attach(rproc);
 	if (ret) {
 		dev_err(dev, "can't load resource table: %d\n", ret);
 		goto unprepare_device;
--=20
2.25.1


--===============0795317220328795471==--

