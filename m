From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 2/2] hwrng: optee: fix wait use case
Date: Thu, 23 Jul 2020 10:28:21 +0200
Message-ID: <20200723082821.26237-2-jorge@foundries.io>
In-Reply-To: <20200723082821.26237-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3696187668975165849=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3696187668975165849==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The current code waits for data to be available before attempting a
second read. However the second read would not be executed as the
while loop exits.

This fix does not wait if all data has been read and reads a second
time if only partial data was retrieved on the first read.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 drivers/char/hw_random/optee-rng.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/opte=
e-rng.c
index 5bc4700c4dae..967d58bb9fda 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -122,13 +122,15 @@ static int optee_rng_read(struct hwrng *rng, void *buf,=
 size_t max, bool wait)
 	if (max > MAX_ENTROPY_REQ_SZ)
 		max =3D MAX_ENTROPY_REQ_SZ;
=20
-	while (read =3D=3D 0) {
+	for (;;) {
 		rng_size =3D get_optee_rng_data(pvt_data, data, (max - read));
=20
 		data +=3D rng_size;
 		read +=3D rng_size;
=20
 		if (wait && pvt_data->data_rate) {
+			if (read =3D=3D max)
+				return read;
 			if (timeout-- =3D=3D 0)
 				return read;
 			msleep((1000 * (max - read)) / pvt_data->data_rate);
--=20
2.17.1


--===============3696187668975165849==--

