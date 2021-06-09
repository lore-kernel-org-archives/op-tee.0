From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 6/7] firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()
Date: Wed, 09 Jun 2021 12:23:23 +0200
Message-ID: <20210609102324.2222332-7-jens.wiklander@linaro.org>
In-Reply-To: <20210609102324.2222332-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7089191985048549075=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7089191985048549075==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
the old deprecated tee_shm_alloc() function which required specific
TEE_SHM-flags.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broad=
com/tee_bnxt_fw.c
index ed10da5313e8..56d00ddd4357 100644
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
--=20
2.31.1


--===============7089191985048549075==--

