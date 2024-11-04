From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v13 4/7] remoteproc: Introduce release_fw optional operation
Date: Mon, 04 Nov 2024 14:35:12 +0100
Message-ID: <20241104133515.256497-5-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20241104133515.256497-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8430625671162628478=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8430625671162628478==
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
Updates from version V11:
- fix typo in @release_fw comment
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
index 2e0ddcb2d792..08e0187a84d9 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -381,6 +381,8 @@ enum rsc_handling_status {
  * @panic:	optional callback to react to system panic, core will delay
  *		panic at least the returned number of milliseconds
  * @coredump:	  collect firmware dump after the subsystem is shutdown
+ * @release_fw:	optional function to release the firmware image from ROM mem=
ories.
+ *		This function is called after stopping the remote processor or in case o=
f an error
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


--===============8430625671162628478==--

