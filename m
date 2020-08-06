From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCHv3 2/2] hwrng: optee: fix wait use case
Date: Thu, 06 Aug 2020 11:58:45 +0200
Message-ID: <20200806095845.20288-2-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8390382611754562789=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8390382611754562789==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The current code waits for data to be available before attempting a
second read. However the second read would not be executed as the
while loop will exit.

This fix does not wait if all data has been read (skips the call to
msleep(0)) and reads a second time if partial data was retrieved on
the first read.

Worth noticing that since msleep(0) schedules a one jiffy timeout is
better to skip such a call.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/char/hw_random/optee-rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/opte=
e-rng.c
index 5bc4700c4dae..a99d82949981 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng *rng, void *buf,=
 size_t max, bool wait)
 	if (max > MAX_ENTROPY_REQ_SZ)
 		max =3D MAX_ENTROPY_REQ_SZ;
=20
-	while (read =3D=3D 0) {
+	while (read < max) {
 		rng_size =3D get_optee_rng_data(pvt_data, data, (max - read));
=20
 		data +=3D rng_size;
 		read +=3D rng_size;
=20
 		if (wait && pvt_data->data_rate) {
-			if (timeout-- =3D=3D 0)
+			if ((timeout-- =3D=3D 0) || (read =3D=3D max))
 				return read;
 			msleep((1000 * (max - read)) / pvt_data->data_rate);
 		} else {
--=20
2.17.1


--===============8390382611754562789==--

