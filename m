From: ira.weiny@intel.com
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 3/4] tee: Remove call to get_kernel_pages()
Date: Sat, 01 Oct 2022 17:23:25 -0700
Message-ID: <20221002002326.946620-4-ira.weiny@intel.com>
In-Reply-To: <20221002002326.946620-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5060184526434545028=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5060184526434545028==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Ira Weiny <ira.weiny@intel.com>

The kernel pages used by shm_get_kernel_pages() are allocated using
GFP_KERNEL through the following call stack:

trusted_instantiate()
	trusted_payload_alloc() -> GFP_KERNEL
	<trusted key op>
		tee_shm_register_kernel_buf()
			register_shm_helper()
				shm_get_kernel_pages()

Where <trusted key op> is one of:

	trusted_key_unseal()
	trusted_key_get_random()
	trusted_key_seal()

Because the pages can't be from highmem get_kernel_pages() boils down to
a get_page() call.

Remove the get_kernel_pages() call and open code the get_page().

In case a kmap page does slip through warn on once for a kmap address.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/tee/tee_shm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 527a6eabc03e..45e6ff1a452e 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -11,6 +11,7 @@
 #include <linux/tee_drv.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/highmem.h>
 #include "tee_private.h"
=20
 static void shm_put_kernel_pages(struct page **pages, size_t page_count)
@@ -26,9 +27,9 @@ static int shm_get_kernel_pages(unsigned long start, size_t=
 page_count,
 {
 	struct kvec *kiov;
 	size_t n;
-	int rc;
=20
-	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
+	if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
+			 is_kmap_addr((void *)start)))
 		return -EINVAL;
=20
 	kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
@@ -38,12 +39,12 @@ static int shm_get_kernel_pages(unsigned long start, size=
_t page_count,
 	for (n =3D 0; n < page_count; n++) {
 		kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
 		kiov[n].iov_len =3D PAGE_SIZE;
+		pages[n] =3D virt_to_page(kiov[n].iov_base);
+		get_page(pages[n]);
 	}
-
-	rc =3D get_kernel_pages(kiov, page_count, 0, pages);
 	kfree(kiov);
=20
-	return rc;
+	return page_count;
 }
=20
 static void release_registered_pages(struct tee_shm *shm)
--=20
2.37.2


--===============5060184526434545028==--

