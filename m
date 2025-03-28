From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v3 01/11] tee: allow a driver to allocate a tee_device without a pool
Date: Thu, 27 Mar 2025 19:47:23 -0700
Message-ID: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-1-7f457073282d@oss.qualcomm.com>
In-Reply-To: <=?utf-8?q?=3C20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-?=
 =?utf-8?q?0-7f457073282d=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0961462642991951149=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0961462642991951149==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d113679b1e2d..24edce4cdbaa 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -888,7 +888,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc=
 *teedesc,
=20
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
=20
 	teedev =3D kzalloc(sizeof(*teedev), GFP_KERNEL);

--=20
2.34.1


--===============0961462642991951149==--

