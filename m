From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v6 1/5] remoteproc: core: Introduce rproc_pa_to_va helper
Date: Fri, 07 Jun 2024 11:33:22 +0200
Message-ID: <20240607093326.369090-2-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20240607093326.369090-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7308906392737065027=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7308906392737065027==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When a resource table is loaded by an external entity such as U-boot or
OP-TEE, We not necessary get the device address(da) but the physical
address(pa).
This helper performs similar translation than the rproc_da_to_va()
but based on a physical address.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 74 +++++++++++++++++++++++++++-
 include/linux/remoteproc.h           |  3 ++
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remote=
proc_core.c
index f276956f2c5c..3fdec0336fd6 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -230,6 +230,77 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t=
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
+ * Some remote processors will ask us to allocate them physically contiguous
+ * memory regions (which we call "carveouts"), and map them to specific
+ * device addresses (which are hardcoded in the firmware). They may also have
+ * dedicated memory regions internal to the processors, and use them either
+ * exclusively or alongside carveouts.
+ *
+ * They may then ask us to copy objects into specific addresses (e.g.
+ * code/data sections) or expose us certain symbols in other device address
+ * (e.g. their trace buffer).
+ *
+ * This function is a helper function with which we can go over the allocated
+ * carveouts and translate specific physical addresses to kernel virtual add=
resses
+ * so we can access the referenced memory. This function also allows to perf=
orm
+ * translations on the internal remoteproc memory regions through a platform
+ * implementation specific pa_to_va ops, if present.
+ *
+ * Note: phys_to_virt(iommu_iova_to_phys(rproc->domain, da)) will work too,
+ * but only on kernel direct mapped RAM memory. Instead, we're just using
+ * here the output of the DMA API for the carveouts, which should be more
+ * correct.
+ *
+ * Return: a valid kernel address on success or NULL on failure
+ */
+void *rproc_pa_to_va(struct rproc *rproc, phys_addr_t pa, size_t len, bool *=
is_iomem)
+{
+	struct rproc_mem_entry *carveout;
+	void *ptr =3D NULL;
+
+	if (rproc->ops->da_to_va) {
+		ptr =3D rproc->ops->pa_to_va(rproc, pa, len);
+		if (ptr)
+			goto out;
+	}
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
+out:
+	return ptr;
+}
+EXPORT_SYMBOL(rproc_pa_to_va);
+
 /**
  * rproc_find_carveout_by_name() - lookup the carveout region by a name
  * @rproc: handle of a remote processor
@@ -724,8 +795,7 @@ static int rproc_alloc_carveout(struct rproc *rproc,
 	 * firmware was compiled with.
 	 *
 	 * In this case, we must use the IOMMU API directly and map
-	 * the memory to the device address as expected by the remote
-	 * processor.
+	 * the memory to the device address as etable
 	 *
 	 * Obviously such remote processor devices should not be configured
 	 * to use the iommu-based DMA API: we expect 'dma' to contain the
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index b4795698d8c2..28aa62a3b505 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -367,6 +367,7 @@ enum rsc_handling_status {
  * @detach:	detach from a device, leaving it powered up
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
  * @da_to_va:	optional platform hook to perform address translations
+ * @pa_to_va:	optional platform hook to perform address translations
  * @parse_fw:	parse firmware to extract information (e.g. resource table)
  * @handle_rsc:	optional platform hook to handle vendor resources. Should re=
turn
  *		RSC_HANDLED if resource was handled, RSC_IGNORED if not handled
@@ -391,6 +392,7 @@ struct rproc_ops {
 	int (*detach)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
 	void * (*da_to_va)(struct rproc *rproc, u64 da, size_t len, bool *is_iomem);
+	void * (*pa_to_va)(struct rproc *rproc, phys_addr_t da, size_t len);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
 	int (*handle_rsc)(struct rproc *rproc, u32 rsc_type, void *rsc,
 			  int offset, int avail);
@@ -690,6 +692,7 @@ int rproc_detach(struct rproc *rproc);
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


--===============7308906392737065027==--

