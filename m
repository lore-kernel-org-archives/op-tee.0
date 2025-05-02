From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v8 01/14] tee: tee_device_alloc(): copy dma_mask from parent device
Date: Fri, 02 May 2025 11:59:15 +0200
Message-ID: <20250502100049.1746335-2-jens.wiklander@linaro.org>
In-Reply-To: <20250502100049.1746335-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0914334519645241667=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0914334519645241667==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

If a parent device is supplied to tee_device_alloc(), copy the dma_mask
field into the new device. This avoids future warnings when mapping a
DMA-buf for the device.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@kernel.org>
---
 drivers/tee/tee_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d113679b1e2d..685afcaa3ea1 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -922,6 +922,8 @@ struct tee_device *tee_device_alloc(const struct tee_desc=
 *teedesc,
 	teedev->dev.class =3D &tee_class;
 	teedev->dev.release =3D tee_release_device;
 	teedev->dev.parent =3D dev;
+	if (dev)
+		teedev->dev.dma_mask =3D dev->dma_mask;
=20
 	teedev->dev.devt =3D MKDEV(MAJOR(tee_devt), teedev->id);
=20
--=20
2.43.0


--===============0914334519645241667==--

