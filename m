From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v5 7/8] tpm_ftpm_tee: Free and unregister TEE shared memory
 during kexec
Date: Mon, 14 Jun 2021 17:33:16 -0500
Message-ID: <20210614223317.999867-8-tyhicks@linux.microsoft.com>
In-Reply-To: <20210614223317.999867-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5522243405050202839=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5522243405050202839==
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

Use tee_shm_alloc_kernel_buf() to avoid dma-buf backed shared memory
allocation so that tee_shm_free() can directly call tee_shm_release().
This will ensure that the shm can be freed and unregistered during a
kexec operation.

Fixes: 09e574831b27 ("tpm/tpm_ftpm_tee: A driver for firmware TPM running ins=
ide TEE")
Fixes: 1760eb689ed6 ("tpm/tpm_ftpm_tee: add shutdown call back")
Cc: stable(a)vger.kernel.org
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2ccdf8ac6994..6e3235565a4d 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -254,11 +254,11 @@ static int ftpm_tee_probe(struct device *dev)
 	pvt_data->session =3D sess_arg.session;
=20
 	/* Allocate dynamic shared memory with fTPM TA */
-	pvt_data->shm =3D tee_shm_alloc(pvt_data->ctx,
-				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
-				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	pvt_data->shm =3D tee_shm_alloc_kernel_buf(pvt_data->ctx,
+						 MAX_COMMAND_SIZE +
+						 MAX_RESPONSE_SIZE);
 	if (IS_ERR(pvt_data->shm)) {
-		dev_err(dev, "%s: tee_shm_alloc failed\n", __func__);
+		dev_err(dev, "%s: tee_shm_alloc_kernel_buf failed\n", __func__);
 		rc =3D -ENOMEM;
 		goto out_shm_alloc;
 	}
--=20
2.25.1


--===============5522243405050202839==--

