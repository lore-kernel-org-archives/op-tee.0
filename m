From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 1/2] hwrng: optee: handle unlimited data rates
Date: Thu, 23 Jul 2020 10:28:20 +0200
Message-ID: <20200723082821.26237-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0462503940439643189=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0462503940439643189==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Data rates of MAX_UINT32 will schedule an unnecessary one jiffy
timeout on the call to msleep. Avoid this scenario by using 0 as the
unlimited data rate.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 drivers/char/hw_random/optee-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/opte=
e-rng.c
index 49b2e02537dd..5bc4700c4dae 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -128,7 +128,7 @@ static int optee_rng_read(struct hwrng *rng, void *buf, s=
ize_t max, bool wait)
 		data +=3D rng_size;
 		read +=3D rng_size;
=20
-		if (wait) {
+		if (wait && pvt_data->data_rate) {
 			if (timeout-- =3D=3D 0)
 				return read;
 			msleep((1000 * (max - read)) / pvt_data->data_rate);
--=20
2.17.1


--===============0462503940439643189==--

