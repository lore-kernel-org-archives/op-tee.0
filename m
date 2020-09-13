From: Souptick Joarder <jrdr.linux@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee/tee_shm.c: Fix error handling path
Date: Sun, 13 Sep 2020 10:12:11 +0530
Message-ID: <1599972131-31770-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5487499368135813228=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5487499368135813228==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When shm->num_pages <=3D 0, we should avoid calling
release_registered_pages() in error handling path.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 drivers/tee/tee_shm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 00472f5..e517d9f 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -260,8 +260,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx,=
 unsigned long addr,
 		rc =3D get_kernel_pages(kiov, num_pages, 0, shm->pages);
 		kfree(kiov);
 	}
-	if (rc > 0)
-		shm->num_pages =3D rc;
+	shm->num_pages =3D rc;
 	if (rc !=3D num_pages) {
 		if (rc >=3D 0)
 			rc =3D -ENOMEM;
@@ -309,7 +308,9 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx,=
 unsigned long addr,
 			idr_remove(&teedev->idr, shm->id);
 			mutex_unlock(&teedev->mutex);
 		}
-		release_registered_pages(shm);
+		if (shm->pages && (shm->num_pages > 0))
+			release_registered_pages(shm);
+
 	}
 	kfree(shm);
 	teedev_ctx_put(ctx);
--=20
1.9.1


--===============5487499368135813228==--

