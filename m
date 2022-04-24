From: Colin Ian King <colin.i.king@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] hwrng: optee-rng: remove redundant initialization to variable
 rng_size
Date: Sun, 24 Apr 2022 19:11:56 +0100
Message-ID: <20220424181156.1364446-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8334398205920334840=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8334398205920334840==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Variable rng_size is being initialized with a value that is never read,
the variable is being re-assigned later on. The initialization is
redundant and can be removed.

Cleans up cppcheck warning:
Variable 'rng_size' is assigned a value that is never used.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/hw_random/optee-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/opte=
e-rng.c
index a948c0727b2b..96b5d546d136 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -115,7 +115,7 @@ static size_t get_optee_rng_data(struct optee_rng_private=
 *pvt_data,
 static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wai=
t)
 {
 	struct optee_rng_private *pvt_data =3D to_optee_rng_private(rng);
-	size_t read =3D 0, rng_size =3D 0;
+	size_t read =3D 0, rng_size;
 	int timeout =3D 1;
 	u8 *data =3D buf;
=20
--=20
2.35.1


--===============8334398205920334840==--

