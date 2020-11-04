From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 2/2] tee: amdtee: synchronize access to shm list
Date: Wed, 04 Nov 2020 11:56:10 +0530
Message-ID: <ae6cf5eaf0552746bd2733d0caf06c6a0425010b.1604470183.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <cover.1604470183.git.Rijo-john.Thomas@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5601015977858984312=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5601015977858984312==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Synchronize access to shm or shared memory buffer list to prevent
race conditions due to concurrent updates to shared shm list by
multiple threads.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/amdtee_private.h | 1 +
 drivers/tee/amdtee/core.c           | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_=
private.h
index 97df16a17285..337c8d82f74e 100644
--- a/drivers/tee/amdtee/amdtee_private.h
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -70,6 +70,7 @@ struct amdtee_session {
 struct amdtee_context_data {
 	struct list_head sess_list;
 	struct list_head shm_list;
+	struct mutex shm_mutex;   /* synchronizes access to @shm_list */
 };
=20
 struct amdtee_driver_data {
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index ce61c68ec58c..8a6a8f30bb42 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -42,6 +42,7 @@ static int amdtee_open(struct tee_context *ctx)
=20
 	INIT_LIST_HEAD(&ctxdata->sess_list);
 	INIT_LIST_HEAD(&ctxdata->shm_list);
+	mutex_init(&ctxdata->shm_mutex);
=20
 	ctx->data =3D ctxdata;
 	return 0;
@@ -85,6 +86,7 @@ static void amdtee_release(struct tee_context *ctx)
 		list_del(&sess->list_node);
 		release_session(sess);
 	}
+	mutex_destroy(&ctxdata->shm_mutex);
 	kfree(ctxdata);
=20
 	ctx->data =3D NULL;
@@ -155,11 +157,13 @@ u32 get_buffer_id(struct tee_shm *shm)
 	struct amdtee_shm_data *shmdata;
 	u32 buf_id =3D 0;
=20
+	mutex_lock(&ctxdata->shm_mutex);
 	list_for_each_entry(shmdata, &ctxdata->shm_list, shm_node)
 		if (shmdata->kaddr =3D=3D shm->kaddr) {
 			buf_id =3D shmdata->buf_id;
 			break;
 		}
+	mutex_unlock(&ctxdata->shm_mutex);
=20
 	return buf_id;
 }
@@ -364,7 +368,9 @@ int amdtee_map_shmem(struct tee_shm *shm)
 	shmnode->kaddr =3D shm->kaddr;
 	shmnode->buf_id =3D buf_id;
 	ctxdata =3D shm->ctx->data;
+	mutex_lock(&ctxdata->shm_mutex);
 	list_add(&shmnode->shm_node, &ctxdata->shm_list);
+	mutex_unlock(&ctxdata->shm_mutex);
=20
 	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shmnode->kaddr);
=20
@@ -385,12 +391,14 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
 	handle_unmap_shmem(buf_id);
=20
 	ctxdata =3D shm->ctx->data;
+	mutex_lock(&ctxdata->shm_mutex);
 	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
 		if (buf_id =3D=3D shmnode->buf_id) {
 			list_del(&shmnode->shm_node);
 			kfree(shmnode);
 			break;
 		}
+	mutex_unlock(&ctxdata->shm_mutex);
 }
=20
 int amdtee_invoke_func(struct tee_context *ctx,
--=20
2.17.1


--===============5601015977858984312==--

