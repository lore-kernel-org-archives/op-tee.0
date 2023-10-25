From: jeshwank <JESHWANTHKUMAR.NK@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 2/3] crypto: ccp - Use psp_tee_alloc_buffer() and
 psp_tee_free_buffer()
Date: Wed, 25 Oct 2023 12:26:59 +0530
Message-ID: <20231025065700.1556152-3-JESHWANTHKUMAR.NK@amd.com>
In-Reply-To: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6770770613003617442=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6770770613003617442==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Rijo Thomas <Rijo-john.Thomas@amd.com>

Allocate TEE ring buffer and command buffer using
psp_tee_alloc_buffer(), and free TEE ring buffer and command buffer
using psp_tee_free_buffer().

As part of cleanup, memory allocation using get_free_pages() is replaced
with DMA APIs.

Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Co-developed-by: Jeshwanth Kumar <JESHWANTHKUMAR.NK@amd.com>
Signed-off-by: Jeshwanth Kumar <JESHWANTHKUMAR.NK@amd.com>
---
 drivers/crypto/ccp/tee-dev.c | 68 ++++++++++++++----------------------
 drivers/crypto/ccp/tee-dev.h | 11 +++---
 2 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
index fa6f89572613..f0a94191662d 100644
--- a/drivers/crypto/ccp/tee-dev.c
+++ b/drivers/crypto/ccp/tee-dev.c
@@ -76,22 +76,16 @@ EXPORT_SYMBOL(psp_tee_free_buffer);
 static int tee_alloc_ring(struct psp_tee_device *tee, int ring_size)
 {
 	struct ring_buf_manager *rb_mgr =3D &tee->rb_mgr;
-	void *start_addr;
=20
 	if (!ring_size)
 		return -EINVAL;
=20
-	/* We need actual physical address instead of DMA address, since
-	 * Trusted OS running on AMD Secure Processor will map this region
-	 */
-	start_addr =3D (void *)__get_free_pages(GFP_KERNEL, get_order(ring_size));
-	if (!start_addr)
+	rb_mgr->ring_buf =3D psp_tee_alloc_buffer(ring_size,
+						GFP_KERNEL | __GFP_ZERO);
+	if (!rb_mgr->ring_buf) {
+		dev_err(tee->dev, "ring allocation failed\n");
 		return -ENOMEM;
-
-	memset(start_addr, 0x0, ring_size);
-	rb_mgr->ring_start =3D start_addr;
-	rb_mgr->ring_size =3D ring_size;
-	rb_mgr->ring_pa =3D __psp_pa(start_addr);
+	}
 	mutex_init(&rb_mgr->mutex);
=20
 	return 0;
@@ -101,15 +95,8 @@ static void tee_free_ring(struct psp_tee_device *tee)
 {
 	struct ring_buf_manager *rb_mgr =3D &tee->rb_mgr;
=20
-	if (!rb_mgr->ring_start)
-		return;
+	psp_tee_free_buffer(rb_mgr->ring_buf);
=20
-	free_pages((unsigned long)rb_mgr->ring_start,
-		   get_order(rb_mgr->ring_size));
-
-	rb_mgr->ring_start =3D NULL;
-	rb_mgr->ring_size =3D 0;
-	rb_mgr->ring_pa =3D 0;
 	mutex_destroy(&rb_mgr->mutex);
 }
=20
@@ -133,35 +120,36 @@ static int tee_wait_cmd_poll(struct psp_tee_device *tee=
, unsigned int timeout,
 	return -ETIMEDOUT;
 }
=20
-static
-struct tee_init_ring_cmd *tee_alloc_cmd_buffer(struct psp_tee_device *tee)
+struct psp_tee_buffer *tee_alloc_cmd_buffer(struct psp_tee_device *tee)
 {
 	struct tee_init_ring_cmd *cmd;
+	struct psp_tee_buffer *cmd_buffer;
=20
-	cmd =3D kzalloc(sizeof(*cmd), GFP_KERNEL);
-	if (!cmd)
+	cmd_buffer =3D psp_tee_alloc_buffer(sizeof(*cmd),
+					  GFP_KERNEL | __GFP_ZERO);
+	if (!cmd_buffer)
 		return NULL;
=20
-	cmd->hi_addr =3D upper_32_bits(tee->rb_mgr.ring_pa);
-	cmd->low_addr =3D lower_32_bits(tee->rb_mgr.ring_pa);
-	cmd->size =3D tee->rb_mgr.ring_size;
+	cmd =3D (struct tee_init_ring_cmd *)cmd_buffer->vaddr;
+	cmd->hi_addr =3D upper_32_bits(tee->rb_mgr.ring_buf->paddr);
+	cmd->low_addr =3D lower_32_bits(tee->rb_mgr.ring_buf->paddr);
+	cmd->size =3D tee->rb_mgr.ring_buf->size;
=20
 	dev_dbg(tee->dev, "tee: ring address: high =3D 0x%x low =3D 0x%x size =3D %=
u\n",
 		cmd->hi_addr, cmd->low_addr, cmd->size);
=20
-	return cmd;
+	return cmd_buffer;
 }
=20
-static inline void tee_free_cmd_buffer(struct tee_init_ring_cmd *cmd)
+static inline void tee_free_cmd_buffer(struct psp_tee_buffer *cmd_buffer)
 {
-	kfree(cmd);
+	psp_tee_free_buffer(cmd_buffer);
 }
=20
 static int tee_init_ring(struct psp_tee_device *tee)
 {
 	int ring_size =3D MAX_RING_BUFFER_ENTRIES * sizeof(struct tee_ring_cmd);
-	struct tee_init_ring_cmd *cmd;
-	phys_addr_t cmd_buffer;
+	struct psp_tee_buffer *cmd_buffer;
 	unsigned int reg;
 	int ret;
=20
@@ -175,21 +163,19 @@ static int tee_init_ring(struct psp_tee_device *tee)
=20
 	tee->rb_mgr.wptr =3D 0;
=20
-	cmd =3D tee_alloc_cmd_buffer(tee);
-	if (!cmd) {
+	cmd_buffer =3D tee_alloc_cmd_buffer(tee);
+	if (!cmd_buffer) {
 		tee_free_ring(tee);
 		return -ENOMEM;
 	}
=20
-	cmd_buffer =3D __psp_pa((void *)cmd);
-
 	/* Send command buffer details to Trusted OS by writing to
 	 * CPU-PSP message registers
 	 */
=20
-	iowrite32(lower_32_bits(cmd_buffer),
+	iowrite32(lower_32_bits(cmd_buffer->paddr),
 		  tee->io_regs + tee->vdata->cmdbuff_addr_lo_reg);
-	iowrite32(upper_32_bits(cmd_buffer),
+	iowrite32(upper_32_bits(cmd_buffer->paddr),
 		  tee->io_regs + tee->vdata->cmdbuff_addr_hi_reg);
 	iowrite32(TEE_RING_INIT_CMD,
 		  tee->io_regs + tee->vdata->cmdresp_reg);
@@ -209,7 +195,7 @@ static int tee_init_ring(struct psp_tee_device *tee)
 	}
=20
 free_buf:
-	tee_free_cmd_buffer(cmd);
+	tee_free_cmd_buffer(cmd_buffer);
=20
 	return ret;
 }
@@ -219,7 +205,7 @@ static void tee_destroy_ring(struct psp_tee_device *tee)
 	unsigned int reg;
 	int ret;
=20
-	if (!tee->rb_mgr.ring_start)
+	if (!tee->rb_mgr.ring_buf->vaddr)
 		return;
=20
 	if (psp_dead)
@@ -308,7 +294,7 @@ static int tee_submit_cmd(struct psp_tee_device *tee, enu=
m tee_cmd_id cmd_id,
 	do {
 		/* Get pointer to ring buffer command entry */
 		cmd =3D (struct tee_ring_cmd *)
-			(tee->rb_mgr.ring_start + tee->rb_mgr.wptr);
+			(tee->rb_mgr.ring_buf->vaddr + tee->rb_mgr.wptr);
=20
 		rptr =3D ioread32(tee->io_regs + tee->vdata->ring_rptr_reg);
=20
@@ -357,7 +343,7 @@ static int tee_submit_cmd(struct psp_tee_device *tee, enu=
m tee_cmd_id cmd_id,
=20
 	/* Update local copy of write pointer */
 	tee->rb_mgr.wptr +=3D sizeof(struct tee_ring_cmd);
-	if (tee->rb_mgr.wptr >=3D tee->rb_mgr.ring_size)
+	if (tee->rb_mgr.wptr >=3D tee->rb_mgr.ring_buf->size)
 		tee->rb_mgr.wptr =3D 0;
=20
 	/* Trigger interrupt to Trusted OS */
diff --git a/drivers/crypto/ccp/tee-dev.h b/drivers/crypto/ccp/tee-dev.h
index 49d26158b71e..0e4398d15f93 100644
--- a/drivers/crypto/ccp/tee-dev.h
+++ b/drivers/crypto/ccp/tee-dev.h
@@ -16,6 +16,7 @@
=20
 #include <linux/device.h>
 #include <linux/mutex.h>
+#include <linux/psp-tee.h>
=20
 #define TEE_DEFAULT_TIMEOUT		10
 #define MAX_BUFFER_SIZE			988
@@ -48,17 +49,13 @@ struct tee_init_ring_cmd {
=20
 /**
  * struct ring_buf_manager - Helper structure to manage ring buffer.
- * @ring_start:  starting address of ring buffer
- * @ring_size:   size of ring buffer in bytes
- * @ring_pa:     physical address of ring buffer
  * @wptr:        index to the last written entry in ring buffer
+ * @ring_buf:    ring buffer allocated using DMA api
  */
 struct ring_buf_manager {
-	struct mutex mutex;	/* synchronizes access to ring buffer */
-	void *ring_start;
-	u32 ring_size;
-	phys_addr_t ring_pa;
+	struct mutex mutex;    /* synchronizes access to ring buffer */
 	u32 wptr;
+	struct psp_tee_buffer *ring_buf;
 };
=20
 struct psp_tee_device {
--=20
2.25.1


--===============6770770613003617442==--

