From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v16 3/6] remoteproc: Introduce release_fw optional operation
Date: Tue, 25 Mar 2025 10:58:30 +0100
Message-ID: <20250325095833.3059895-4-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20250325095833.3059895-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2589333325940662492=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2589333325940662492==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The release_fw operation is the inverse operation of the load, responsible
for releasing the remote processor resources configured from the loading
of the remoteproc firmware (e.g., memories).

The operation is called in the following cases:
 - An error occurs on boot of the remote processor.
 - An error occurs on recovery start of the remote processor.
 - After stopping the remote processor.

This operation is needed for the remoteproc_tee implementation after stop
and on error.
Indeed, as the remoteproc image is loaded when we parse the resource
table, there are many situations where something can go wrong before
the start of the remote processor(resource handling, carveout allocation,
...).

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Updates vs previous version:
- remove the rproc:load_fw() ops introduced in previous version
- remove duplicate call of rproc_release_fw in rproc_fw_boot and rproc_boot
---
 drivers/remoteproc/remoteproc_core.c     | 6 ++++++
 drivers/remoteproc/remoteproc_internal.h | 6 ++++++
 include/linux/remoteproc.h               | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remote=
proc_core.c
index f05122b699b7..79317d148651 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1857,6 +1857,8 @@ static int rproc_boot_recovery(struct rproc *rproc)
=20
 	/* boot the remote processor up again */
 	ret =3D rproc_start(rproc, firmware_p);
+	if (ret)
+		rproc_release_fw(rproc);
=20
 	release_firmware(firmware_p);
=20
@@ -1998,6 +2000,8 @@ int rproc_boot(struct rproc *rproc)
 		}
=20
 		ret =3D rproc_fw_boot(rproc, firmware_p);
+		if (ret)
+			rproc_release_fw(rproc);
=20
 		release_firmware(firmware_p);
 	}
@@ -2067,6 +2071,8 @@ int rproc_shutdown(struct rproc *rproc)
=20
 	rproc_disable_iommu(rproc);
=20
+	rproc_release_fw(rproc);
+
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
 	rproc->cached_table =3D NULL;
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/re=
moteproc_internal.h
index 0cd09e67ac14..c7fb908f8652 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -221,4 +221,10 @@ bool rproc_u64_fit_in_size_t(u64 val)
 	return (val <=3D (size_t) -1);
 }
=20
+static inline void rproc_release_fw(struct rproc *rproc)
+{
+	if (rproc->ops->release_fw)
+		rproc->ops->release_fw(rproc);
+}
+
 #endif /* REMOTEPROC_INTERNAL_H */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 8fd0d7f63c8e..80128461972b 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -381,6 +381,8 @@ enum rsc_handling_status {
  * @panic:	optional callback to react to system panic, core will delay
  *		panic at least the returned number of milliseconds
  * @coredump:	  collect firmware dump after the subsystem is shutdown
+ * @release_fw:	optional function to release the loaded firmware, called aft=
er
+ *              stopping the remote processor or in case of error
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


--===============2589333325940662492==--

