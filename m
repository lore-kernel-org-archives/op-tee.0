From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v6 01/10] tee: tee_device_alloc(): copy dma_mask from parent device
Date: Wed, 05 Mar 2025 14:04:07 +0100
Message-ID: <20250305130634.1850178-2-jens.wiklander@linaro.org>
In-Reply-To: <20250305130634.1850178-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6829333190407223538=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6829333190407223538==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

If a parent device is supplied to tee_device_alloc(), copy the dma_mask
field into the new device. This avoids future warnings when mapping a
DMA-buf for the device.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
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


--===============6829333190407223538==--

