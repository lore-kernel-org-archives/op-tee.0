From: jeshwank <JESHWANTHKUMAR.NK@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 3/3] tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
Date: Wed, 25 Oct 2023 12:27:00 +0530
Message-ID: <20231025065700.1556152-4-JESHWANTHKUMAR.NK@amd.com>
In-Reply-To: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1969882769776332332=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1969882769776332332==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Rijo Thomas <Rijo-john.Thomas@amd.com>

Allocate shared memory using psp_tee_alloc_buffer(), and free shared
memory using psp_tee_free_buffer().

As part of cleanup, memory allocation using get_free_pages() is replaced
with DMA APIs.

Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Signed-off-by: Jeshwanth Kumar <JESHWANTHKUMAR.NK@amd.com>
---
 drivers/tee/amdtee/amdtee_private.h | 18 +++----
 drivers/tee/amdtee/call.c           | 74 +++++++++++++----------------
 drivers/tee/amdtee/core.c           | 72 +++++++++++++++++-----------
 drivers/tee/amdtee/shm_pool.c       | 21 ++------
 4 files changed, 89 insertions(+), 96 deletions(-)

diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_=
private.h
index 6d0f7062bb87..e2bb0a21942c 100644
--- a/drivers/tee/amdtee/amdtee_private.h
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -13,6 +13,7 @@
 #include <linux/kref.h>
 #include <linux/types.h>
 #include "amdtee_if.h"
+#include <linux/psp-tee.h>
=20
 #define DRIVER_NAME	"amdtee"
 #define DRIVER_AUTHOR   "AMD-TEE Linux driver team"
@@ -78,19 +79,14 @@ struct amdtee_driver_data {
 	struct amdtee *amdtee;
 };
=20
-struct shmem_desc {
-	void *kaddr;
-	u64 size;
-};
-
 /**
  * struct amdtee_shm_data - Shared memory data
- * @kaddr:	Kernel virtual address of shared memory
+ * @shm_buf:	Pointer to shared memory buffer
  * @buf_id:	Buffer id of memory mapped by TEE_CMD_ID_MAP_SHARED_MEM
  */
 struct amdtee_shm_data {
 	struct  list_head shm_node;
-	void    *kaddr;
+	struct	psp_tee_buffer *shm_buf;
 	u32     buf_id;
 };
=20
@@ -145,11 +141,11 @@ int amdtee_invoke_func(struct tee_context *ctx,
=20
 int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
=20
-int amdtee_map_shmem(struct tee_shm *shm);
+int amdtee_alloc_shmem(struct tee_shm *shm);
=20
-void amdtee_unmap_shmem(struct tee_shm *shm);
+void amdtee_free_shmem(struct tee_shm *shm);
=20
-int handle_load_ta(void *data, u32 size,
+int handle_load_ta(struct psp_tee_buffer *buf,
 		   struct tee_ioctl_open_session_arg *arg);
=20
 int handle_unload_ta(u32 ta_handle);
@@ -159,7 +155,7 @@ int handle_open_session(struct tee_ioctl_open_session_arg=
 *arg, u32 *info,
=20
 int handle_close_session(u32 ta_handle, u32 info);
=20
-int handle_map_shmem(u32 count, struct shmem_desc *start, u32 *buf_id);
+int handle_map_shmem(struct psp_tee_buffer *shm_buf, u32 *buf_id);
=20
 void handle_unmap_shmem(u32 buf_id);
=20
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index e9b63dcb3194..031d37cc975c 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -283,53 +283,44 @@ int handle_invoke_cmd(struct tee_ioctl_invoke_arg *arg,=
 u32 sinfo,
 	return ret;
 }
=20
-int handle_map_shmem(u32 count, struct shmem_desc *start, u32 *buf_id)
+int handle_map_shmem(struct psp_tee_buffer *shm_buf, u32 *buf_id)
 {
 	struct tee_cmd_map_shared_mem *cmd;
-	phys_addr_t paddr;
-	int ret, i;
 	u32 status;
+	int ret;
=20
-	if (!count || !start || !buf_id)
+	if (!shm_buf || !shm_buf->vaddr || !buf_id)
 		return -EINVAL;
=20
 	cmd =3D kzalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
=20
-	/* Size must be page aligned */
-	for (i =3D 0; i < count ; i++) {
-		if (!start[i].kaddr || (start[i].size & (PAGE_SIZE - 1))) {
-			ret =3D -EINVAL;
-			goto free_cmd;
-		}
-
-		if ((u64)start[i].kaddr & (PAGE_SIZE - 1)) {
-			pr_err("map shared memory: page unaligned. addr 0x%llx",
-			       (u64)start[i].kaddr);
-			ret =3D -EINVAL;
-			goto free_cmd;
-		}
+	/* Size and address must be page aligned */
+	if (shm_buf->size & (PAGE_SIZE - 1)) {
+		ret =3D -EINVAL;
+		goto free_cmd;
 	}
=20
-	cmd->sg_list.count =3D count;
-
-	/* Create buffer list */
-	for (i =3D 0; i < count ; i++) {
-		paddr =3D __psp_pa(start[i].kaddr);
-		cmd->sg_list.buf[i].hi_addr =3D upper_32_bits(paddr);
-		cmd->sg_list.buf[i].low_addr =3D lower_32_bits(paddr);
-		cmd->sg_list.buf[i].size =3D start[i].size;
-		cmd->sg_list.size +=3D cmd->sg_list.buf[i].size;
-
-		pr_debug("buf[%d]:hi addr =3D 0x%x\n", i,
-			 cmd->sg_list.buf[i].hi_addr);
-		pr_debug("buf[%d]:low addr =3D 0x%x\n", i,
-			 cmd->sg_list.buf[i].low_addr);
-		pr_debug("buf[%d]:size =3D 0x%x\n", i, cmd->sg_list.buf[i].size);
-		pr_debug("list size =3D 0x%x\n", cmd->sg_list.size);
+	if ((u64)shm_buf->vaddr & (PAGE_SIZE - 1)) {
+		pr_err("map shared memory: page unaligned. addr 0x%llx",
+		       (u64)shm_buf->vaddr);
+		ret =3D -EINVAL;
+		goto free_cmd;
 	}
=20
+	/* Update sg list */
+	cmd->sg_list.count =3D 1;
+	cmd->sg_list.buf[0].hi_addr =3D upper_32_bits(shm_buf->paddr);
+	cmd->sg_list.buf[0].low_addr =3D lower_32_bits(shm_buf->paddr);
+	cmd->sg_list.buf[0].size =3D shm_buf->size;
+	cmd->sg_list.size =3D cmd->sg_list.buf[0].size;
+
+	pr_debug("buf: hi addr =3D 0x%x\n", cmd->sg_list.buf[0].hi_addr);
+	pr_debug("buf: low addr =3D 0x%x\n", cmd->sg_list.buf[0].low_addr);
+	pr_debug("buf: size =3D 0x%x\n", cmd->sg_list.buf[0].size);
+	pr_debug("list size =3D 0x%x\n", cmd->sg_list.size);
+
 	*buf_id =3D 0;
=20
 	ret =3D psp_tee_process_cmd(TEE_CMD_ID_MAP_SHARED_MEM, (void *)cmd,
@@ -396,25 +387,24 @@ int handle_open_session(struct tee_ioctl_open_session_a=
rg *arg, u32 *info,
 	return ret;
 }
=20
-int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *=
arg)
+int handle_load_ta(struct psp_tee_buffer *buf,
+		   struct tee_ioctl_open_session_arg *arg)
 {
 	struct tee_cmd_unload_ta unload_cmd =3D {};
 	struct tee_cmd_load_ta load_cmd =3D {};
-	phys_addr_t blob;
 	int ret;
=20
-	if (size =3D=3D 0 || !data || !arg)
+	if (buf->size =3D=3D 0 || !buf->paddr || !arg)
 		return -EINVAL;
=20
-	blob =3D __psp_pa(data);
-	if (blob & (PAGE_SIZE - 1)) {
-		pr_err("load TA: page unaligned. blob 0x%llx", blob);
+	if (buf->dma & (PAGE_SIZE - 1)) {
+		pr_err("load TA: page unaligned. addr 0x%llx", buf->dma);
 		return -EINVAL;
 	}
=20
-	load_cmd.hi_addr =3D upper_32_bits(blob);
-	load_cmd.low_addr =3D lower_32_bits(blob);
-	load_cmd.size =3D size;
+	load_cmd.hi_addr =3D upper_32_bits(buf->paddr);
+	load_cmd.low_addr =3D lower_32_bits(buf->paddr);
+	load_cmd.size =3D buf->size;
=20
 	mutex_lock(&ta_refcount_mutex);
=20
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 3c15f6a9e91c..37784360fc10 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -17,6 +17,7 @@
 #include "amdtee_private.h"
 #include "../tee_private.h"
 #include <linux/psp-tee.h>
+#include <linux/psp.h>
=20
 static struct amdtee_driver_data *drv_data;
 static DEFINE_MUTEX(session_list_mutex);
@@ -158,7 +159,8 @@ u32 get_buffer_id(struct tee_shm *shm)
=20
 	mutex_lock(&ctxdata->shm_mutex);
 	list_for_each_entry(shmdata, &ctxdata->shm_list, shm_node)
-		if (shmdata->kaddr =3D=3D shm->kaddr) {
+		if (shmdata->shm_buf &&
+		    shmdata->shm_buf->vaddr =3D=3D shm->kaddr) {
 			buf_id =3D shmdata->buf_id;
 			break;
 		}
@@ -168,11 +170,13 @@ u32 get_buffer_id(struct tee_shm *shm)
 }
=20
 static DEFINE_MUTEX(drv_mutex);
-static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
-			  size_t *ta_size)
+static int copy_ta_binary(struct tee_context *ctx, void *ptr,
+			  struct psp_tee_buffer **bufp)
 {
 	const struct firmware *fw;
 	char fw_name[TA_PATH_MAX];
+	struct psp_tee_buffer *buf;
+	unsigned long size;
 	struct {
 		u32 lo;
 		u16 mid;
@@ -201,15 +205,16 @@ static int copy_ta_binary(struct tee_context *ctx, void=
 *ptr, void **ta,
 		goto unlock;
 	}
=20
-	*ta_size =3D roundup(fw->size, PAGE_SIZE);
-	*ta =3D (void *)__get_free_pages(GFP_KERNEL, get_order(*ta_size));
-	if (!*ta) {
-		pr_err("%s: get_free_pages failed\n", __func__);
+	size =3D roundup(fw->size, PAGE_SIZE);
+	buf =3D psp_tee_alloc_buffer(size, GFP_KERNEL);
+	if (!buf) {
+		pr_err("TA binary memory allocation failed\n");
 		rc =3D -ENOMEM;
 		goto rel_fw;
 	}
+	memcpy(buf->vaddr, fw->data, fw->size);
+	*bufp =3D buf;
=20
-	memcpy(*ta, fw->data, fw->size);
 rel_fw:
 	release_firmware(fw);
 unlock:
@@ -234,24 +239,23 @@ int amdtee_open_session(struct tee_context *ctx,
 {
 	struct amdtee_context_data *ctxdata =3D ctx->data;
 	struct amdtee_session *sess =3D NULL;
+	struct psp_tee_buffer *buf;
 	u32 session_info, ta_handle;
-	size_t ta_size;
 	int rc, i;
-	void *ta;
=20
 	if (arg->clnt_login !=3D TEE_IOCTL_LOGIN_PUBLIC) {
 		pr_err("unsupported client login method\n");
 		return -EINVAL;
 	}
=20
-	rc =3D copy_ta_binary(ctx, &arg->uuid[0], &ta, &ta_size);
+	rc =3D copy_ta_binary(ctx, &arg->uuid[0], &buf);
 	if (rc) {
 		pr_err("failed to copy TA binary\n");
 		return rc;
 	}
=20
 	/* Load the TA binary into TEE environment */
-	handle_load_ta(ta, ta_size, arg);
+	handle_load_ta(buf, arg);
 	if (arg->ret !=3D TEEC_SUCCESS)
 		goto out;
=20
@@ -298,7 +302,7 @@ int amdtee_open_session(struct tee_context *ctx,
 	}
=20
 out:
-	free_pages((u64)ta, get_order(ta_size));
+	psp_tee_free_buffer(buf);
 	return rc;
 }
=20
@@ -338,51 +342,62 @@ int amdtee_close_session(struct tee_context *ctx, u32 s=
ession)
 	return 0;
 }
=20
-int amdtee_map_shmem(struct tee_shm *shm)
+int amdtee_alloc_shmem(struct tee_shm *shm)
 {
 	struct amdtee_context_data *ctxdata;
 	struct amdtee_shm_data *shmnode;
-	struct shmem_desc shmem;
-	int rc, count;
+	struct psp_tee_buffer *shm_buf;
 	u32 buf_id;
+	int rc;
=20
 	if (!shm)
 		return -EINVAL;
=20
-	shmnode =3D kmalloc(sizeof(*shmnode), GFP_KERNEL);
-	if (!shmnode)
+	shm_buf =3D psp_tee_alloc_buffer(shm->size, GFP_KERNEL | __GFP_ZERO);
+	if (!shm_buf)
 		return -ENOMEM;
=20
-	count =3D 1;
-	shmem.kaddr =3D shm->kaddr;
-	shmem.size =3D shm->size;
+	shm->kaddr =3D shm_buf->vaddr;
+	shm->paddr =3D __psp_pa(shm_buf->vaddr);
+
+	shmnode =3D kmalloc(sizeof(*shmnode), GFP_KERNEL);
+	if (!shmnode) {
+		rc =3D -ENOMEM;
+		goto free_dmabuf;
+	}
=20
 	/*
 	 * Send a MAP command to TEE and get the corresponding
 	 * buffer Id
 	 */
-	rc =3D handle_map_shmem(count, &shmem, &buf_id);
+	rc =3D handle_map_shmem(shm_buf, &buf_id);
 	if (rc) {
 		pr_err("map_shmem failed: ret =3D %d\n", rc);
-		kfree(shmnode);
-		return rc;
+		goto free_shmnode;
 	}
=20
-	shmnode->kaddr =3D shm->kaddr;
+	shmnode->shm_buf =3D shm_buf;
 	shmnode->buf_id =3D buf_id;
 	ctxdata =3D shm->ctx->data;
 	mutex_lock(&ctxdata->shm_mutex);
 	list_add(&shmnode->shm_node, &ctxdata->shm_list);
 	mutex_unlock(&ctxdata->shm_mutex);
=20
-	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shmnode->kaddr);
+	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shm->kaddr);
=20
 	return 0;
+
+free_shmnode:
+	kfree(shmnode);
+free_dmabuf:
+	psp_tee_free_buffer(shm_buf);
+	return rc;
 }
=20
-void amdtee_unmap_shmem(struct tee_shm *shm)
+void amdtee_free_shmem(struct tee_shm *shm)
 {
 	struct amdtee_context_data *ctxdata;
+	struct psp_tee_buffer *shm_buf =3D NULL;
 	struct amdtee_shm_data *shmnode;
 	u32 buf_id;
=20
@@ -390,6 +405,7 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
 		return;
=20
 	buf_id =3D get_buffer_id(shm);
+
 	/* Unmap the shared memory from TEE */
 	handle_unmap_shmem(buf_id);
=20
@@ -398,10 +414,12 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
 	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
 		if (buf_id =3D=3D shmnode->buf_id) {
 			list_del(&shmnode->shm_node);
+			shm_buf =3D shmnode->shm_buf;
 			kfree(shmnode);
 			break;
 		}
 	mutex_unlock(&ctxdata->shm_mutex);
+	psp_tee_free_buffer(shm_buf);
 }
=20
 int amdtee_invoke_func(struct tee_context *ctx,
diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
index f0303126f199..443874c82611 100644
--- a/drivers/tee/amdtee/shm_pool.c
+++ b/drivers/tee/amdtee/shm_pool.c
@@ -12,25 +12,13 @@ static int pool_op_alloc(struct tee_shm_pool *pool, struc=
t tee_shm *shm,
 			 size_t size, size_t align)
 {
 	unsigned int order =3D get_order(size);
-	unsigned long va;
 	int rc;
=20
-	/*
-	 * Ignore alignment since this is already going to be page aligned
-	 * and there's no need for any larger alignment.
-	 */
-	va =3D __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!va)
-		return -ENOMEM;
-
-	shm->kaddr =3D (void *)va;
-	shm->paddr =3D __psp_pa((void *)va);
 	shm->size =3D PAGE_SIZE << order;
=20
-	/* Map the allocated memory in to TEE */
-	rc =3D amdtee_map_shmem(shm);
+	/* Allocate and map memory in to TEE */
+	rc =3D amdtee_alloc_shmem(shm);
 	if (rc) {
-		free_pages(va, order);
 		shm->kaddr =3D NULL;
 		return rc;
 	}
@@ -41,8 +29,9 @@ static int pool_op_alloc(struct tee_shm_pool *pool, struct =
tee_shm *shm,
 static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
 {
 	/* Unmap the shared memory from TEE */
-	amdtee_unmap_shmem(shm);
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	amdtee_free_shmem(shm);
+
+	shm->size =3D 0;
 	shm->kaddr =3D NULL;
 }
=20
--=20
2.25.1


--===============1969882769776332332==--

