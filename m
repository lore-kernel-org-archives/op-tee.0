From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 5/7] tpm_ftpm_tee: use tee_shm_alloc_kernel_buf()
Date: Wed, 09 Jun 2021 12:23:22 +0200
Message-ID: <20210609102324.2222332-6-jens.wiklander@linaro.org>
In-Reply-To: <20210609102324.2222332-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3780269068286160008=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3780269068286160008==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
the old deprecated tee_shm_alloc() function which required specific
TEE_SHM-flags.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2ccdf8ac6994..6e3235565a4d 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -254,11 +254,11 @@ static int ftpm_tee_probe(struct device *dev)
 	pvt_data->session = sess_arg.session;
 
 	/* Allocate dynamic shared memory with fTPM TA */
-	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
-				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
-				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	pvt_data->shm = tee_shm_alloc_kernel_buf(pvt_data->ctx,
+						 MAX_COMMAND_SIZE +
+						 MAX_RESPONSE_SIZE);
 	if (IS_ERR(pvt_data->shm)) {
-		dev_err(dev, "%s: tee_shm_alloc failed\n", __func__);
+		dev_err(dev, "%s: tee_shm_alloc_kernel_buf failed\n", __func__);
 		rc = -ENOMEM;
 		goto out_shm_alloc;
 	}
-- 
2.31.1


--===============3780269068286160008==--

