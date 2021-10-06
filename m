From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v6 1/5] tee: add sec_world_id to struct tee_shm
Date: Wed, 06 Oct 2021 09:08:58 +0200
Message-ID: <20211006070902.2531311-2-jens.wiklander@linaro.org>
In-Reply-To: <20211006070902.2531311-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5299282925884785322=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5299282925884785322==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds sec_world_id to struct tee_shm which describes a shared memory
object. sec_world_id can be used by a driver to store an id assigned by
secure world.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 include/linux/tee_drv.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 3ebfea0781f1..a1f03461369b 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -197,7 +197,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 conne=
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
@@ -213,6 +217,7 @@ struct tee_shm {
 	struct dma_buf *dmabuf;
 	u32 flags;
 	int id;
+	u64 sec_world_id;
 };
=20
 /**
--=20
2.31.1


--===============5299282925884785322==--

