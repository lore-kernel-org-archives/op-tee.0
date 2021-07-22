From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 1/5] tee: add sec_world_id to struct tee_shm
Date: Thu, 22 Jul 2021 14:17:53 +0200
Message-ID: <20210722121757.1944658-2-jens.wiklander@linaro.org>
In-Reply-To: <20210722121757.1944658-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5984520445785700890=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5984520445785700890==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds sec_world_id to struct tee_shm which describes a shared memory
object. sec_world_id can be used by a driver to store an id assigned by
secure world.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 include/linux/tee_drv.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 54269e47ac9a..1a29f0e66e13 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -196,7 +196,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 conne=
ction_method,
  * @num_pages:	number of locked pages
  * @dmabuf:	dmabuf used to for exporting to user space
  * @flags:	defined by TEE_SHM_* in tee_drv.h
- * @id:		unique id of a shared memory object on this device
+ * @id:		unique id of a shared memory object on this device, shared
+ *		with user space
+ * @sec_world_id:
+ *		secure world assigned id of this shared memory object, not
+ *		used by all drivers
  *
  * This pool is only supposed to be accessed directly from the TEE
  * subsystem and from drivers that implements their own shm pool manager.
@@ -212,6 +216,7 @@ struct tee_shm {
 	struct dma_buf *dmabuf;
 	u32 flags;
 	int id;
+	u64 sec_world_id;
 };
=20
 /**
--=20
2.31.1


--===============5984520445785700890==--

