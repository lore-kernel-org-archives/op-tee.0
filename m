From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v10 4/7] remoteproc: Introduce release_fw optional operation
Date: Mon, 07 Oct 2024 15:16:17 +0200
Message-ID: <20241007131620.2090104-5-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20241007131620.2090104-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5535710254288632129=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5535710254288632129==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This patch updates the rproc_ops struct to include an optional
release_fw function.

The release_fw ops is responsible for releasing the remote processor
firmware image. The ops is called in the following cases:

 - An error occurs in rproc_start() between the loading of the segments and
      the start of the remote processor.
 - after stopping the remote processor.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Update vs previous revision:
- New commit that preplace previous one to introduce ops->release_fw
---
 drivers/remoteproc/remoteproc_core.c | 5 +++++
 include/linux/remoteproc.h           | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remote=
proc_core.c
index 7694817f25d4..46863e1ca307 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1258,6 +1258,9 @@ static int rproc_alloc_registered_carveouts(struct rpro=
c *rproc)
=20
 static void rproc_release_fw(struct rproc *rproc)
 {
+	if (rproc->ops->release_fw)
+		rproc->ops->release_fw(rproc);
+
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
 	rproc->cached_table =3D NULL;
@@ -1377,6 +1380,8 @@ static int rproc_start(struct rproc *rproc, const struc=
t firmware *fw)
 unprepare_subdevices:
 	rproc_unprepare_subdevices(rproc);
 reset_table_ptr:
+	if (rproc->ops->release_fw)
+		rproc->ops->release_fw(rproc);
 	rproc->table_ptr =3D rproc->cached_table;
=20
 	return ret;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 73f640dd0fc0..bdf4d94a9e63 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -381,6 +381,8 @@ enum rsc_handling_status {
  * @panic:	optional callback to react to system panic, core will delay
  *		panic at least the returned number of milliseconds
  * @coredump:	  collect firmware dump after the subsystem is shutdown
+ * @release_fw:	optional function to release the firmware image from ROM mem=
ories.
+ *              This function is called after stopping the process or in cas=
e of an error
  */
 struct rproc_ops {
 	int (*prepare)(struct rproc *rproc);
@@ -403,6 +405,7 @@ struct rproc_ops {
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
 	unsigned long (*panic)(struct rproc *rproc);
 	void (*coredump)(struct rproc *rproc);
+	void (*release_fw)(struct rproc *rproc);
 };
=20
 /**
--=20
2.25.1


--===============5535710254288632129==--

