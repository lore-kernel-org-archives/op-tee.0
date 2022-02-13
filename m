From: Phil Chang <phil.chang@mediatek.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: make tee_shm_register_kernel_buf vmalloc supported
Date: Mon, 14 Feb 2022 00:21:10 +0800
Message-ID: <20220213162110.27210-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4025907521834737818=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4025907521834737818==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

In some low-memory devices, it's hard to aquire large-orders pages,
this patch allowed user using scatter pages to register shm.

Signed-off-by: Phil Chang <phil.chang@mediatek.com>
---
 drivers/tee/optee/call.c |  2 +-
 drivers/tee/tee_shm.c    | 40 ++++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index bd49ec934060..2082e632adff 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -362,7 +362,7 @@ int optee_check_mem_type(unsigned long start, size_t num_=
pages)
 	 * Allow kernel address to register with OP-TEE as kernel
 	 * pages are configured as normal memory only.
 	 */
-	if (virt_addr_valid(start))
+	if (virt_addr_valid(start) || is_vmalloc_addr((void *)start))
 		return 0;
=20
 	mmap_read_lock(mm);
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index f31e29e8f1ca..861403588485 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -23,22 +23,38 @@ static void shm_put_kernel_pages(struct page **pages, siz=
e_t page_count)
 static int shm_get_kernel_pages(unsigned long start, size_t page_count,
 				struct page **pages)
 {
-	struct kvec *kiov;
-	size_t n;
 	int rc;
=20
-	kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
-	if (!kiov)
-		return -ENOMEM;
-
-	for (n =3D 0; n < page_count; n++) {
-		kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
-		kiov[n].iov_len =3D PAGE_SIZE;
+	if (is_vmalloc_addr((void *)start)) {
+		struct page *page;
+		int i;
+
+		for (i =3D 0; i < page_count; i++) {
+			page =3D vmalloc_to_page((void *)(start + PAGE_SIZE * i));
+			if (!page)
+				return -ENOMEM;
+
+			get_page(page);
+			pages[i] =3D page;
+		}
+		rc =3D page_count;
+	} else {
+		struct kvec *kiov;
+		size_t n;
+
+		kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
+		if (!kiov)
+			return -ENOMEM;
+
+		for (n =3D 0; n < page_count; n++) {
+			kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
+			kiov[n].iov_len =3D PAGE_SIZE;
+		}
+
+		rc =3D get_kernel_pages(kiov, page_count, 0, pages);
+		kfree(kiov);
 	}
=20
-	rc =3D get_kernel_pages(kiov, page_count, 0, pages);
-	kfree(kiov);
-
 	return rc;
 }
=20
--=20
2.25.1

--===============4025907521834737818==--

