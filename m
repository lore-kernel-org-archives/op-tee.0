From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v2 1/8] tee: allow a driver to allocate a tee_device without a pool
Date: Sun, 02 Feb 2025 18:43:29 -0800
Message-ID: <20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-1-297eacd0d34f@quicinc.com>
In-Reply-To: <=?utf-8?q?=3C20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-?=
 =?utf-8?q?0-297eacd0d34f=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2085971033865064516=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2085971033865064516==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
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


--===============2085971033865064516==--

