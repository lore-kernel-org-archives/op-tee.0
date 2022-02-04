From: Phil Chang <phil.chang@mediatek.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] optee: make tee_shm_register vmalloc supported
Date: Fri, 04 Feb 2022 17:32:54 +0800
Message-ID: <20220204093254.2467-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1732999012649793196=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1732999012649793196==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This patch allowed the tee shm use vmalloc area buffer.

Signed-off-by: Phil Chang <phil.chang@mediatek.com>
---

Hi,

 In some low-memory devices, it's hard to aquire large-orders pages,
 this pathes is allowed user use scatter pages to register shm.

 Thanks.

 drivers/tee/optee/call.c |  2 +-
 drivers/tee/tee_shm.c    | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index b25cc1fac945..937bcc7df8e4 100644
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

 	mmap_read_lock(mm);
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 499fccba3d74..31d0c10485ff 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -195,6 +195,20 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx=
, unsigned long addr,
 	if (flags & TEE_SHM_USER_MAPPED) {
 		rc =3D pin_user_pages_fast(start, num_pages, FOLL_WRITE,
 					 shm->pages);
+	} else if (is_vmalloc_addr((void *)start)) {
+		struct page *page;
+		int i;
+
+		for (i =3D 0; i < num_pages; i++) {
+			page =3D vmalloc_to_page((void *)(start + PAGE_SIZE * i));
+			if (!page) {
+				ret =3D ERR_PTR(-ENOMEM);
+				goto err;
+			}
+			get_page(page);
+			shm->pages[i] =3D page;
+		}
+		rc =3D num_pages;
 	} else {
 		struct kvec *kiov;
 		int i;
--
2.25.1

--===============1732999012649793196==--

