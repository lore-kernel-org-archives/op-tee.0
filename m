From: Linus Walleij <linus.walleij@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: Pass a pointer to virt_to_page()
Date: Fri, 24 Mar 2023 11:15:31 +0100
Message-ID: <20230324101531.711735-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6248703723798844223=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6248703723798844223==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Like the other calls in this function virt_to_page() expects
a pointer, not an integer.

However since many architectures implement virt_to_pfn() as
a macro, this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix this up with an explicit cast.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tee/tee_shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index b1c6231defad..673cf0359494 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -32,7 +32,7 @@ static int shm_get_kernel_pages(unsigned long start, size_t=
 page_count,
 			 is_kmap_addr((void *)start)))
 		return -EINVAL;
=20
-	page =3D virt_to_page(start);
+	page =3D virt_to_page((void *)start);
 	for (n =3D 0; n < page_count; n++) {
 		pages[n] =3D page + n;
 		get_page(pages[n]);
--=20
2.34.1


--===============6248703723798844223==--

