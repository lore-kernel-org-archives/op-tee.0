From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 6/7] tpm_ftpm_tee: Free and unregister dynamic shared
 memory during kexec
Date: Tue, 08 Jun 2021 19:23:25 -0500
Message-ID: <20210609002326.210024-7-tyhicks@linux.microsoft.com>
In-Reply-To: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6295081958263694505=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6295081958263694505==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

dma-buf backed shared memory cannot be reliably freed and unregistered
during a kexec operation even when tee_shm_free() is called on the shm
from a .shutdown hook. The problem occurs because dma_buf_put() calls
fput() which then uses task_work_add(), with the TWA_RESUME parameter,
to queue tee_shm_release() to be called before the current task returns
to user mode. However, the current task never returns to user mode
before the kexec completes so the memory is never freed nor
unregistered.

Don't use dma-buf backed shared memory for a multi-page dynamic shm
that's private to the driver. Not using a dma-buf backed shm will allow
tee_shm_free() to directly call tee_shm_release() so that the shared
memory can be freed and unregistered during a kexec operation.

Continue to register the multi-page dynamic shm with the TEE so that all
4K chunks can be used.

Fixes: 09e574831b27 ("tpm/tpm_ftpm_tee: A driver for firmware TPM running ins=
ide TEE")
Fixes: 1760eb689ed6 ("tpm/tpm_ftpm_tee: add shutdown call back")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2ccdf8ac6994..8f1155227506 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -256,7 +256,7 @@ static int ftpm_tee_probe(struct device *dev)
 	/* Allocate dynamic shared memory with fTPM TA */
 	pvt_data->shm =3D tee_shm_alloc(pvt_data->ctx,
 				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
-				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+				      TEE_SHM_MAPPED | TEE_SHM_REGISTER);
 	if (IS_ERR(pvt_data->shm)) {
 		dev_err(dev, "%s: tee_shm_alloc failed\n", __func__);
 		rc =3D -ENOMEM;
--=20
2.25.1


--===============6295081958263694505==--

