From: jeshwank <JESHWANTHKUMAR.NK@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 1/3] crypto: ccp - Add function to allocate and free memory
 using DMA APIs
Date: Wed, 25 Oct 2023 12:26:58 +0530
Message-ID: <20231025065700.1556152-2-JESHWANTHKUMAR.NK@amd.com>
In-Reply-To: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1151869172711035251=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1151869172711035251==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Rijo Thomas <Rijo-john.Thomas@amd.com>

As part of cleanup, memory allocation using get_free_pages() is replaced
with DMA APIs.

psp_tee_alloc_buffer() and psp_tee_free_buffer() has been introduced, so
that DMA address can be shared with PSP Trusted OS for buffer mapping.
In the presence of IOMMU, the address will be an IOVA. So, it must be
converted into a physical address before sharing it with PSP Trusted OS.

Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Signed-off-by: Jeshwanth Kumar <JESHWANTHKUMAR.NK@amd.com>
---
 drivers/crypto/ccp/psp-dev.c |  3 +++
 drivers/crypto/ccp/tee-dev.c | 51 ++++++++++++++++++++++++++++++++++++
 include/linux/psp-tee.h      | 47 +++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index d42d7bc62352..049954d9984b 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -163,6 +163,9 @@ int psp_dev_init(struct sp_device *sp)
 		goto e_err;
 	}
=20
+	if (sp->set_psp_master_device)
+		sp->set_psp_master_device(sp);
+
 	psp->io_regs =3D sp->io_map;
=20
 	ret =3D psp_get_capability(psp);
diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
index 5560bf8329a1..fa6f89572613 100644
--- a/drivers/crypto/ccp/tee-dev.c
+++ b/drivers/crypto/ccp/tee-dev.c
@@ -13,6 +13,8 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/dma-direct.h>
+#include <linux/iommu.h>
 #include <linux/gfp.h>
 #include <linux/psp.h>
 #include <linux/psp-tee.h>
@@ -22,6 +24,55 @@
=20
 static bool psp_dead;
=20
+struct psp_tee_buffer *psp_tee_alloc_buffer(unsigned long size, gfp_t gfp)
+{
+	struct psp_device *psp =3D psp_get_master_device();
+	struct psp_tee_buffer *tee_buf;
+	struct iommu_domain *dom;
+
+	if (!psp || !size)
+		return NULL;
+
+	tee_buf =3D kzalloc(sizeof(*tee_buf), GFP_KERNEL);
+	if (!tee_buf)
+		return NULL;
+
+	tee_buf->vaddr =3D dma_alloc_coherent(psp->dev, size, &tee_buf->dma, gfp);
+	if (!tee_buf->vaddr || !tee_buf->dma) {
+		kfree(tee_buf);
+		return NULL;
+	}
+
+	tee_buf->size =3D size;
+
+	/* Check whether IOMMU is present. If present, translate IOVA
+	 * to physical address, else the dma handle is the physical
+	 * address.
+	 */
+	dom =3D iommu_get_domain_for_dev(psp->dev);
+	if (dom)
+		tee_buf->paddr =3D iommu_iova_to_phys(dom, tee_buf->dma);
+	else
+		tee_buf->paddr =3D tee_buf->dma;
+
+	return tee_buf;
+}
+EXPORT_SYMBOL(psp_tee_alloc_buffer);
+
+void psp_tee_free_buffer(struct psp_tee_buffer *tee_buf)
+{
+	struct psp_device *psp =3D psp_get_master_device();
+
+	if (!psp || !tee_buf)
+		return;
+
+	dma_free_coherent(psp->dev, tee_buf->size,
+			  tee_buf->vaddr, tee_buf->dma);
+
+	kfree(tee_buf);
+}
+EXPORT_SYMBOL(psp_tee_free_buffer);
+
 static int tee_alloc_ring(struct psp_tee_device *tee, int ring_size)
 {
 	struct ring_buf_manager *rb_mgr =3D &tee->rb_mgr;
diff --git a/include/linux/psp-tee.h b/include/linux/psp-tee.h
index cb0c95d6d76b..c3db3f33d069 100644
--- a/include/linux/psp-tee.h
+++ b/include/linux/psp-tee.h
@@ -40,6 +40,20 @@ enum tee_cmd_id {
 	TEE_CMD_ID_UNMAP_SHARED_MEM,
 };
=20
+/**
+ * struct psp_tee_buffer - Structure of a TEE buffer shared with PSP.
+ * @dma:    DMA buffer address
+ * @paddr:  Physical address of DMA buffer
+ * @vaddr:  CPU virtual address of DMA buffer
+ * @size:   Size of DMA buffer in bytes
+ */
+struct psp_tee_buffer {
+	dma_addr_t dma;
+	phys_addr_t paddr;
+	void *vaddr;
+	unsigned long size;
+};
+
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 /**
  * psp_tee_process_cmd() - Process command in Trusted Execution Environment
@@ -75,6 +89,28 @@ int psp_tee_process_cmd(enum tee_cmd_id cmd_id, void *buf,=
 size_t len,
  */
 int psp_check_tee_status(void);
=20
+/**
+ * psp_tee_alloc_buffer() - Allocates memory of requested size and flags usi=
ng
+ * dma_alloc_coherent() API.
+ *
+ * This function can be used to allocate a shared memory region between the
+ * host and PSP TEE.
+ *
+ * Returns:
+ * non-NULL   a valid pointer to struct psp_tee_buffer
+ * NULL       on failure
+ */
+struct psp_tee_buffer *psp_tee_alloc_buffer(unsigned long size, gfp_t gfp);
+
+/**
+ * psp_tee_free_buffer() - Deallocates memory using dma_free_coherent() API.
+ *
+ * This function can be used to release shared memory region between host
+ * and PSP TEE.
+ *
+ */
+void psp_tee_free_buffer(struct psp_tee_buffer *tee_buffer);
+
 #else /* !CONFIG_CRYPTO_DEV_SP_PSP */
=20
 static inline int psp_tee_process_cmd(enum tee_cmd_id cmd_id, void *buf,
@@ -87,5 +123,16 @@ static inline int psp_check_tee_status(void)
 {
 	return -ENODEV;
 }
+
+static inline
+struct psp_tee_buffer *psp_tee_alloc_buffer(unsigned long size, gfp_t gfp)
+{
+	return NULL;
+}
+
+static inline void psp_tee_free_buffer(struct psp_tee_buffer *tee_buffer)
+{
+}
+
 #endif /* CONFIG_CRYPTO_DEV_SP_PSP */
 #endif /* __PSP_TEE_H_ */
--=20
2.25.1


--===============1151869172711035251==--

