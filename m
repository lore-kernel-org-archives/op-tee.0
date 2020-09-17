From: Liu Shixin <liushixin2@huawei.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH -next] tee: optee: fix type warning of sizeof in pool_op_alloc()
Date: Thu, 17 Sep 2020 16:13:56 +0800
Message-ID: <20200917081356.2083345-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6293528433300000072=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6293528433300000072==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

sizeof() when applied to a pointer typed expression should gives the
size of the pointed data, even if the data is a pointer.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/tee/optee/shm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index d767eebf30bd..9fdc667b5df0 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -31,7 +31,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		unsigned int nr_pages = 1 << order, i;
 		struct page **pages;
 
-		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
+		pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 		if (!pages)
 			return -ENOMEM;
 
-- 
2.25.1


--===============6293528433300000072==--

