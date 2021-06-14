From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
Date: Mon, 14 Jun 2021 17:33:17 -0500
Message-ID: <20210614223317.999867-9-tyhicks@linux.microsoft.com>
In-Reply-To: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0059869006838711200=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0059869006838711200==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Allen Pais <apais@linux.microsoft.com>

Implement a .shutdown hook that will be called during a kexec operation
so that the TEE shared memory, session, and context that were set up
during .probe can be properly freed/closed.

Additionally, don't use dma-buf backed shared memory for the
fw_shm_pool. dma-buf backed shared memory cannot be reliably freed and
unregistered during a kexec operation even when tee_shm_free() is called
on the shm from a .shutdown hook. The problem occurs because
dma_buf_put() calls fput() which then uses task_work_add(), with the
TWA_RESUME parameter, to queue tee_shm_release() to be called before the
current task returns to user mode. However, the current task never
returns to user mode before the kexec completes so the memory is never
freed nor unregistered.

Use tee_shm_alloc_kernel_buf() to avoid dma-buf backed shared memory
allocation so that tee_shm_free() can directly call tee_shm_release().
This will ensure that the shm can be freed and unregistered during a
kexec operation.

Fixes: 246880958ac9 ("firmware: broadcom: add OP-TEE based BNXT f/w manager")
Cc: stable(a)vger.kernel.org
Signed-off-by: Allen Pais <apais@linux.microsoft.com>
Co-developed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broad=
com/tee_bnxt_fw.c
index ed10da5313e8..a5bf4c3f6dc7 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -212,10 +212,9 @@ static int tee_bnxt_fw_probe(struct device *dev)
=20
 	pvt_data.dev =3D dev;
=20
-	fw_shm_pool =3D tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
-				    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	fw_shm_pool =3D tee_shm_alloc_kernel_buf(pvt_data.ctx, MAX_SHM_MEM_SZ);
 	if (IS_ERR(fw_shm_pool)) {
-		dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
+		dev_err(pvt_data.dev, "tee_shm_alloc_kernel_buf failed\n");
 		err =3D PTR_ERR(fw_shm_pool);
 		goto out_sess;
 	}
@@ -242,6 +241,14 @@ static int tee_bnxt_fw_remove(struct device *dev)
 	return 0;
 }
=20
+static void tee_bnxt_fw_shutdown(struct device *dev)
+{
+	tee_shm_free(pvt_data.fw_shm_pool);
+	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+	tee_client_close_context(pvt_data.ctx);
+	pvt_data.ctx =3D NULL;
+}
+
 static const struct tee_client_device_id tee_bnxt_fw_id_table[] =3D {
 	{UUID_INIT(0x6272636D, 0x2019, 0x0716,
 		    0x42, 0x43, 0x4D, 0x5F, 0x53, 0x43, 0x48, 0x49)},
@@ -257,6 +264,7 @@ static struct tee_client_driver tee_bnxt_fw_driver =3D {
 		.bus		=3D &tee_bus_type,
 		.probe		=3D tee_bnxt_fw_probe,
 		.remove		=3D tee_bnxt_fw_remove,
+		.shutdown	=3D tee_bnxt_fw_shutdown,
 	},
 };
=20
--=20
2.25.1


--===============0059869006838711200==--

