From: Tian Tao <tiantao6@hisilicon.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2] hwrng: optee: Use device-managed registration API
Date: Wed, 03 Feb 2021 20:26:06 +0800
Message-ID: <1612355166-11824-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8375734085051452394=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8375734085051452394==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Use devm_hwrng_register to get rid of manual unregistration.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
v2:Fix up subject line as s/hwrng: optee -:/hwrng: optee:/
---
 drivers/char/hw_random/optee-rng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/opte=
e-rng.c
index a99d829..135a825 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -243,7 +243,7 @@ static int optee_rng_probe(struct device *dev)
 	if (err)
 		goto out_sess;
=20
-	err =3D hwrng_register(&pvt_data.optee_rng);
+	err =3D devm_hwrng_register(dev, &pvt_data.optee_rng);
 	if (err) {
 		dev_err(dev, "hwrng registration failed (%d)\n", err);
 		goto out_sess;
@@ -263,7 +263,6 @@ static int optee_rng_probe(struct device *dev)
=20
 static int optee_rng_remove(struct device *dev)
 {
-	hwrng_unregister(&pvt_data.optee_rng);
 	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
 	tee_client_close_context(pvt_data.ctx);
=20
--=20
2.7.4


--===============8375734085051452394==--

