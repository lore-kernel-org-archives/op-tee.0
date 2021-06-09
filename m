From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 4/7] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
Date: Wed, 09 Jun 2021 12:23:21 +0200
Message-ID: <20210609102324.2222332-5-jens.wiklander@linaro.org>
In-Reply-To: <20210609102324.2222332-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8927659423996775370=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8927659423996775370==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
the old deprecated tee_shm_alloc() function which required specific
TEE_SHM-flags.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/char/hw_random/optee-rng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/opte=
e-rng.c
index 135a82590923..a948c0727b2b 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -145,10 +145,10 @@ static int optee_rng_init(struct hwrng *rng)
 	struct optee_rng_private *pvt_data =3D to_optee_rng_private(rng);
 	struct tee_shm *entropy_shm_pool =3D NULL;
=20
-	entropy_shm_pool =3D tee_shm_alloc(pvt_data->ctx, MAX_ENTROPY_REQ_SZ,
-					 TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	entropy_shm_pool =3D tee_shm_alloc_kernel_buf(pvt_data->ctx,
+						    MAX_ENTROPY_REQ_SZ);
 	if (IS_ERR(entropy_shm_pool)) {
-		dev_err(pvt_data->dev, "tee_shm_alloc failed\n");
+		dev_err(pvt_data->dev, "tee_shm_alloc_kernel_buf failed\n");
 		return PTR_ERR(entropy_shm_pool);
 	}
=20
--=20
2.31.1


--===============8927659423996775370==--

