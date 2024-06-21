From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v8 1/5] remoteproc: core: Introduce rproc_pa_to_va helper
Date: Fri, 21 Jun 2024 16:37:55 +0200
Message-ID: <20240621143759.547793-2-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20240621143759.547793-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5073070496285271850=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5073070496285271850==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When a resource table is loaded by an external entity such as U-boot or
OP-TEE, we do not necessarily get the device address(da) but the physical
address(pa).
This helper performs similar translation than the rproc_da_to_va()
but based on a physical address.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
updates vs previous version:
- remove pa_to_va in the rproc_ops structure as not used
- simplify the rproc_pa_to_va() documentation header
- fix typos
---
 drivers/remoteproc/remoteproc_core.c | 46 ++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remote=
proc_core.c
index f276956f2c5c..ace11ea17097 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -230,6 +230,52 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t=
 len, bool *is_iomem)
 }
 EXPORT_SYMBOL(rproc_da_to_va);
=20
+/**
+ * rproc_pa_to_va() - lookup the kernel virtual address for a physical addre=
ss of a remoteproc
+ * memory
+ *
+ * @rproc: handle of a remote processor
+ * @pa: remoteproc physical address
+ * @len: length of the memory region @pa is pointing to
+ * @is_iomem: optional pointer filled in to indicate if @da is iomapped memo=
ry
+ *
+ * This function is a helper function similar to rproc_da_to_va() but it dea=
ls with physical
+ * addresses instead of device addresses.
+ *
+ * Return: a valid kernel address on success or NULL on failure
+ */
+void *rproc_pa_to_va(struct rproc *rproc, phys_addr_t pa, size_t len, bool *=
is_iomem)
+{
+	struct rproc_mem_entry *carveout;
+	void *ptr =3D NULL;
+
+	list_for_each_entry(carveout, &rproc->carveouts, node) {
+		int offset =3D pa - carveout->dma;
+
+		/*  Verify that carveout is allocated */
+		if (!carveout->va)
+			continue;
+
+		/* try next carveout if da is too small */
+		if (offset < 0)
+			continue;
+
+		/* try next carveout if da is too large */
+		if (offset + len > carveout->len)
+			continue;
+
+		ptr =3D carveout->va + offset;
+
+		if (is_iomem)
+			*is_iomem =3D carveout->is_iomem;
+
+		break;
+	}
+
+	return ptr;
+}
+EXPORT_SYMBOL(rproc_pa_to_va);
+
 /**
  * rproc_find_carveout_by_name() - lookup the carveout region by a name
  * @rproc: handle of a remote processor
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index b4795698d8c2..8fd0d7f63c8e 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -690,6 +690,7 @@ int rproc_detach(struct rproc *rproc);
 int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem=
);
+void *rproc_pa_to_va(struct rproc *rproc, phys_addr_t pa, size_t len, bool *=
is_iomem);
=20
 /* from remoteproc_coredump.c */
 void rproc_coredump_cleanup(struct rproc *rproc);
--=20
2.25.1


--===============5073070496285271850==--

