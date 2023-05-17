From: Xiaoming Ding <xiaoming.ding@mediatek.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Date: Wed, 17 May 2023 11:18:56 +0800
Message-ID: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7416267822603927199=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7416267822603927199==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

FOLL_LONGTERM will avoid share memory alloc from CMA region,
which may be used in secure playback case.
if part of CMA region taken by share memory for long term usage,
CMA will failed to get whole buffer back.

Signed-off-by: Xiaoming Ding <xiaoming.ding@mediatek.com>
---
 drivers/tee/tee_shm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 673cf0359494..ddd3947e2229 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -223,6 +223,7 @@ register_shm_helper(struct tee_context *ctx, unsigned lon=
g addr,
 	size_t num_pages;
 	void *ret;
 	int rc;
+	u32 page_flag =3D FOLL_WRITE;
=20
 	if (!tee_device_get(teedev))
 		return ERR_PTR(-EINVAL);
@@ -255,9 +256,11 @@ register_shm_helper(struct tee_context *ctx, unsigned lo=
ng addr,
 		ret =3D ERR_PTR(-ENOMEM);
 		goto err_free_shm;
 	}
-
+#if IS_ENABLED(CONFIG_CMA)
+	page_flag |=3D FOLL_LONGTERM;
+#endif
 	if (flags & TEE_SHM_USER_MAPPED)
-		rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE,
+		rc =3D pin_user_pages_fast(start, num_pages, page_flag,
 					 shm->pages);
 	else
 		rc =3D shm_get_kernel_pages(start, num_pages, shm->pages);
--=20
2.18.0


--===============7416267822603927199==--

