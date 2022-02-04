From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4 01/10] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
Date: Fri, 04 Feb 2022 10:33:50 +0100
Message-ID: <20220204093359.359059-2-jens.wiklander@linaro.org>
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0414207877239602875=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0414207877239602875==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
the old deprecated tee_shm_alloc() function which required specific
TEE_SHM-flags.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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


--===============0414207877239602875==--

