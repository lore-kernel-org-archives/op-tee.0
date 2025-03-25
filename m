From: Marco Felsch <m.felsch@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: shm: fix slab page refcounting
Date: Tue, 25 Mar 2025 20:50:20 +0100
Message-ID: <20250325195021.3589797-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2513806938881530663=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2513806938881530663==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Skip manipulating the refcount in case of slab pages according commit
b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").

Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/tee/tee_shm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..3d6a3077b6f2 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -19,16 +19,24 @@ static void shm_put_kernel_pages(struct page **pages, siz=
e_t page_count)
 {
 	size_t n;
=20
-	for (n =3D 0; n < page_count; n++)
-		put_page(pages[n]);
+	for (n =3D 0; n < page_count; n++) {
+		struct page *page =3D pages[n];
+
+		if (!PageSlab(page))
+			put_page(pages[n]);
+	}
 }
=20
 static void shm_get_kernel_pages(struct page **pages, size_t page_count)
 {
 	size_t n;
=20
-	for (n =3D 0; n < page_count; n++)
-		get_page(pages[n]);
+	for (n =3D 0; n < page_count; n++) {
+		struct page *page =3D pages[n];
+
+		if (!PageSlab(page))
+			get_page(pages[n]);
+	}
 }
=20
 static void release_registered_pages(struct tee_shm *shm)
--=20
2.39.5


--===============2513806938881530663==--

