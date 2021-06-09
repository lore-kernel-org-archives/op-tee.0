From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 7/7] firmware: tee_bnxt: Release shm, session, and context
 during kexec
Date: Tue, 08 Jun 2021 19:23:26 -0500
Message-ID: <20210609002326.210024-8-tyhicks@linux.microsoft.com>
In-Reply-To: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5266312960695349913=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5266312960695349913==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Allen Pais <apais@linux.microsoft.com>

Implement a .shutdown hook that will be called during a kexec operation
so that the TEE shared memory, session, and context that were set up
during .probe can be properly freed/closed.

Additionally, don't use dma-buf backed shared memory for the multi-page
dynamic shm that's private to the driver. dma-buf backed shared memory
cannot be reliably freed and unregistered during a kexec operation even
when tee_shm_free() is called on the shm from a .shutdown hook. The
problem occurs because dma_buf_put() calls fput() which then uses
task_work_add(), with the TWA_RESUME parameter, to queue
tee_shm_release() to be called before the current task returns to user
mode. However, the current task never returns to user mode before the
kexec completes so the memory is never freed nor unregistered.

Continue to register the multi-page dynamic shm with the TEE so that all
4K chunks can be used.

Fixes: 246880958ac9 ("firmware: broadcom: add OP-TEE based BNXT f/w manager")
Signed-off-by: Allen Pais <apais@linux.microsoft.com>
Co-developed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broad=
com/tee_bnxt_fw.c
index ed10da5313e8..c496723e9e8d 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -213,7 +213,7 @@ static int tee_bnxt_fw_probe(struct device *dev)
 	pvt_data.dev =3D dev;
=20
 	fw_shm_pool =3D tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
-				    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+				    TEE_SHM_MAPPED | TEE_SHM_REGISTER);
 	if (IS_ERR(fw_shm_pool)) {
 		dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
 		err =3D PTR_ERR(fw_shm_pool);
@@ -242,6 +242,14 @@ static int tee_bnxt_fw_remove(struct device *dev)
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
@@ -257,6 +265,7 @@ static struct tee_client_driver tee_bnxt_fw_driver =3D {
 		.bus		=3D &tee_bus_type,
 		.probe		=3D tee_bnxt_fw_probe,
 		.remove		=3D tee_bnxt_fw_remove,
+		.shutdown	=3D tee_bnxt_fw_shutdown,
 	},
 };
=20
--=20
2.25.1


--===============5266312960695349913==--

