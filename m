From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 1/2] tee: amdtee: fix memory leak due to reset of global shm list
Date: Wed, 04 Nov 2020 11:56:09 +0530
Message-ID: <86891b29257dbf36aae3b9cfdec75dca3b5273f0.1604470183.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <cover.1604470183.git.Rijo-john.Thomas@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5136155430106553438=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5136155430106553438==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The driver maintains a list of shared memory buffers along with their
mapped buffer id's in a global linked list. These buffers need to be
unmapped after use by the user-space client.

The global shared memory list is initialized to zero entries in the
function amdtee_open(). This clearing of list entries can be a source
for memory leak on secure side if the global linked list previously
held some mapped buffer entries allocated from another TEE context.

Fix potential memory leak issue by moving global shared memory list
to AMD-TEE driver context data structure.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/amdtee_private.h |  7 +++----
 drivers/tee/amdtee/core.c           | 18 +++++++++++-------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_=
private.h
index d7f798c3394b..97df16a17285 100644
--- a/drivers/tee/amdtee/amdtee_private.h
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -64,9 +64,12 @@ struct amdtee_session {
 /**
  * struct amdtee_context_data - AMD-TEE driver context data
  * @sess_list:    Keeps track of sessions opened in current TEE context
+ * @shm_list:     Keeps track of buffers allocated and mapped in current TEE
+ *                context
  */
 struct amdtee_context_data {
 	struct list_head sess_list;
+	struct list_head shm_list;
 };
=20
 struct amdtee_driver_data {
@@ -89,10 +92,6 @@ struct amdtee_shm_data {
 	u32     buf_id;
 };
=20
-struct amdtee_shm_context {
-	struct list_head shmdata_list;
-};
-
 #define LOWER_TWO_BYTE_MASK	0x0000FFFF
=20
 /**
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 27b4cd77d0db..ce61c68ec58c 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -20,7 +20,6 @@
=20
 static struct amdtee_driver_data *drv_data;
 static DEFINE_MUTEX(session_list_mutex);
-static struct amdtee_shm_context shmctx;
=20
 static void amdtee_get_version(struct tee_device *teedev,
 			       struct tee_ioctl_version_data *vers)
@@ -42,7 +41,7 @@ static int amdtee_open(struct tee_context *ctx)
 		return -ENOMEM;
=20
 	INIT_LIST_HEAD(&ctxdata->sess_list);
-	INIT_LIST_HEAD(&shmctx.shmdata_list);
+	INIT_LIST_HEAD(&ctxdata->shm_list);
=20
 	ctx->data =3D ctxdata;
 	return 0;
@@ -152,10 +151,11 @@ static struct amdtee_session *find_session(struct amdte=
e_context_data *ctxdata,
=20
 u32 get_buffer_id(struct tee_shm *shm)
 {
-	u32 buf_id =3D 0;
+	struct amdtee_context_data *ctxdata =3D shm->ctx->data;
 	struct amdtee_shm_data *shmdata;
+	u32 buf_id =3D 0;
=20
-	list_for_each_entry(shmdata, &shmctx.shmdata_list, shm_node)
+	list_for_each_entry(shmdata, &ctxdata->shm_list, shm_node)
 		if (shmdata->kaddr =3D=3D shm->kaddr) {
 			buf_id =3D shmdata->buf_id;
 			break;
@@ -333,8 +333,9 @@ int amdtee_close_session(struct tee_context *ctx, u32 ses=
sion)
=20
 int amdtee_map_shmem(struct tee_shm *shm)
 {
-	struct shmem_desc shmem;
+	struct amdtee_context_data *ctxdata;
 	struct amdtee_shm_data *shmnode;
+	struct shmem_desc shmem;
 	int rc, count;
 	u32 buf_id;
=20
@@ -362,7 +363,8 @@ int amdtee_map_shmem(struct tee_shm *shm)
=20
 	shmnode->kaddr =3D shm->kaddr;
 	shmnode->buf_id =3D buf_id;
-	list_add(&shmnode->shm_node, &shmctx.shmdata_list);
+	ctxdata =3D shm->ctx->data;
+	list_add(&shmnode->shm_node, &ctxdata->shm_list);
=20
 	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shmnode->kaddr);
=20
@@ -371,6 +373,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
=20
 void amdtee_unmap_shmem(struct tee_shm *shm)
 {
+	struct amdtee_context_data *ctxdata;
 	struct amdtee_shm_data *shmnode;
 	u32 buf_id;
=20
@@ -381,7 +384,8 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
 	/* Unmap the shared memory from TEE */
 	handle_unmap_shmem(buf_id);
=20
-	list_for_each_entry(shmnode, &shmctx.shmdata_list, shm_node)
+	ctxdata =3D shm->ctx->data;
+	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
 		if (buf_id =3D=3D shmnode->buf_id) {
 			list_del(&shmnode->shm_node);
 			kfree(shmnode);
--=20
2.17.1


--===============5136155430106553438==--

