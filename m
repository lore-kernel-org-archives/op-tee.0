From: Marco Felsch <m.felsch@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2] tee: shm: fix slab page refcounting
Date: Tue, 25 Mar 2025 21:07:39 +0100
Message-ID: <20250325200740.3645331-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4428308109708687723=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4428308109708687723==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Skip manipulating the refcount in case of slab pages according commit
b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page").

Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab page")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v2:
- Make use of page variable
v1:
- https://lore.kernel.org/all/20250325195021.3589797-1-m.felsch(a)pengutronix=
.de/

 drivers/tee/tee_shm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..35f0ac359b12 100644
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
+			put_page(page);
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
+			get_page(page);
+	}
 }
=20
 static void release_registered_pages(struct tee_shm *shm)
--=20
2.39.5


--===============4428308109708687723==--

