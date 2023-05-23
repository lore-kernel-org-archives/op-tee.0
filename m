From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 1/4] tee: Re-enable vmalloc page support for shared memory
Date: Tue, 23 May 2023 09:14:36 +0000
Message-ID: <20230523091350.292221-2-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7538694311999387380=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7538694311999387380==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This patch revert commit c83900393aa1 ("tee: Remove vmalloc page support")

The firmware framework uses vmalloc page to store an image of a firmware,
got from the file system.
To be able to give this firmware to OP-TEE without an extra copy,
the vmalloc page support needs to be reintroduce.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/tee/tee_shm.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 673cf0359494..b2d349ac17b4 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -28,14 +28,26 @@ static int shm_get_kernel_pages(unsigned long start, size=
_t page_count,
 	struct page *page;
 	size_t n;
=20
-	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
-			 is_kmap_addr((void *)start)))
+	if (WARN_ON_ONCE(is_kmap_addr((void *)start)))
 		return -EINVAL;
=20
-	page =3D virt_to_page((void *)start);
-	for (n =3D 0; n < page_count; n++) {
-		pages[n] =3D page + n;
-		get_page(pages[n]);
+	if (is_vmalloc_addr((void *)start)) {
+		struct page *page;
+
+		for (n =3D 0; n < page_count; n++) {
+			page =3D vmalloc_to_page((void *)(start + PAGE_SIZE * n));
+			if (!page)
+				return -ENOMEM;
+
+			get_page(page);
+			pages[n] =3D page;
+		}
+	}  else {
+		page =3D virt_to_page((void *)start);
+		for (n =3D 0; n < page_count; n++) {
+			pages[n] =3D page + n;
+			get_page(pages[n]);
+		}
 	}
=20
 	return page_count;
--=20
2.25.1


--===============7538694311999387380==--

