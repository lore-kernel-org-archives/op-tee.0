From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v4 08/10] KEYS: trusted: tee: use tee_shm_register_kernel_buf()
Date: Fri, 04 Feb 2022 10:33:57 +0100
Message-ID: <20220204093359.359059-9-jens.wiklander@linaro.org>
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8398633287729765905=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8398633287729765905==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Uses the new simplified tee_shm_register_kernel_buf() function instead
of the old tee_shm_alloc() function which required specific
TEE_SHM-flags

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 security/keys/trusted-keys/trusted_tee.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted=
-keys/trusted_tee.c
index 2ce66c199e1d..c8626686ee1b 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -70,17 +70,15 @@ static int trusted_tee_seal(struct trusted_key_payload *p=
, char *datablob)
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
=20
-	reg_shm_in =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
-				      p->key_len, TEE_SHM_DMA_BUF |
-				      TEE_SHM_KERNEL_MAPPED);
+	reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
+						 p->key_len);
 	if (IS_ERR(reg_shm_in)) {
 		dev_err(pvt_data.dev, "key shm register failed\n");
 		return PTR_ERR(reg_shm_in);
 	}
=20
-	reg_shm_out =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
-				       sizeof(p->blob), TEE_SHM_DMA_BUF |
-				       TEE_SHM_KERNEL_MAPPED);
+	reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
+						  sizeof(p->blob));
 	if (IS_ERR(reg_shm_out)) {
 		dev_err(pvt_data.dev, "blob shm register failed\n");
 		ret =3D PTR_ERR(reg_shm_out);
@@ -131,17 +129,15 @@ static int trusted_tee_unseal(struct trusted_key_payloa=
d *p, char *datablob)
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
=20
-	reg_shm_in =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
-				      p->blob_len, TEE_SHM_DMA_BUF |
-				      TEE_SHM_KERNEL_MAPPED);
+	reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
+						 p->blob_len);
 	if (IS_ERR(reg_shm_in)) {
 		dev_err(pvt_data.dev, "blob shm register failed\n");
 		return PTR_ERR(reg_shm_in);
 	}
=20
-	reg_shm_out =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
-				       sizeof(p->key), TEE_SHM_DMA_BUF |
-				       TEE_SHM_KERNEL_MAPPED);
+	reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
+						  sizeof(p->key));
 	if (IS_ERR(reg_shm_out)) {
 		dev_err(pvt_data.dev, "key shm register failed\n");
 		ret =3D PTR_ERR(reg_shm_out);
@@ -192,8 +188,7 @@ static int trusted_tee_get_random(unsigned char *key, siz=
e_t key_len)
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
=20
-	reg_shm =3D tee_shm_register(pvt_data.ctx, (unsigned long)key, key_len,
-				   TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
+	reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, key, key_len);
 	if (IS_ERR(reg_shm)) {
 		dev_err(pvt_data.dev, "key shm register failed\n");
 		return PTR_ERR(reg_shm);
--=20
2.31.1


--===============8398633287729765905==--

