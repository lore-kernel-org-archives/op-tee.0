From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v4 1/8] optee: Fix memory leak when failing to register shm pages
Date: Thu, 10 Jun 2021 16:09:06 -0500
Message-ID: <20210610210913.536081-2-tyhicks@linux.microsoft.com>
In-Reply-To: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1334973933806751792=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1334973933806751792==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Free the previously allocated pages when we encounter an error condition
while attempting to register the pages with the secure world.

Fixes: a249dd200d03 ("tee: optee: Fix dynamic shm pool allocations")
Fixes: 5a769f6ff439 ("optee: Fix multi page dynamic shm pool alloc")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/optee/shm_pool.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index d767eebf30bd..da06ce9b9313 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -32,8 +32,10 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		struct page **pages;
 
 		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
-		if (!pages)
-			return -ENOMEM;
+		if (!pages) {
+			rc = -ENOMEM;
+			goto err;
+		}
 
 		for (i = 0; i < nr_pages; i++) {
 			pages[i] = page;
@@ -44,8 +46,14 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
 					(unsigned long)shm->kaddr);
 		kfree(pages);
+		if (rc)
+			goto err;
 	}
 
+	return 0;
+
+err:
+	__free_pages(page, order);
 	return rc;
 }
 
-- 
2.25.1


--===============1334973933806751792==--

