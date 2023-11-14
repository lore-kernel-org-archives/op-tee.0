From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 2/2] optee: allocate shared memory with alloc_pages_exact()
Date: Tue, 14 Nov 2023 10:52:17 +0100
Message-ID: <20231114095217.1142360-3-jens.wiklander@linaro.org>
In-Reply-To: <20231114095217.1142360-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6443047495068154647=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6443047495068154647==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Allocate memory to share with the secure using alloc_pages_exact()
instead of alloc_pages() for more efficient memory usage.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 38ea2fecfc2e..4a4b03b4fc7d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -26,10 +26,8 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, =
struct tee_shm *shm,
 						   size_t num_pages,
 						   unsigned long start))
 {
-	unsigned int order =3D get_order(size);
-	unsigned int nr_pages =3D 1 << order;
+	size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
 	struct page **pages;
-	struct page *page;
 	unsigned int i;
 	int rc =3D 0;
=20
@@ -37,13 +35,13 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool,=
 struct tee_shm *shm,
 	 * Ignore alignment since this is already going to be page aligned
 	 * and there's no need for any larger alignment.
 	 */
-	page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!page)
+	shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
+				       GFP_KERNEL | __GFP_ZERO);
+	if (!shm->kaddr)
 		return -ENOMEM;
=20
-	shm->kaddr =3D page_address(page);
-	shm->paddr =3D page_to_phys(page);
-	shm->size =3D PAGE_SIZE << order;
+	shm->paddr =3D virt_to_phys(shm->kaddr);
+	shm->size =3D nr_pages * PAGE_SIZE;
=20
 	pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages) {
@@ -52,7 +50,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, s=
truct tee_shm *shm,
 	}
=20
 	for (i =3D 0; i < nr_pages; i++)
-		pages[i] =3D page + i;
+		pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
=20
 	shm->pages =3D pages;
 	shm->num_pages =3D nr_pages;
@@ -66,7 +64,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, s=
truct tee_shm *shm,
=20
 	return 0;
 err:
-	free_pages((unsigned long)shm->kaddr, order);
+	free_pages_exact(shm->kaddr, shm->size);
 	shm->kaddr =3D NULL;
 	return rc;
 }
@@ -77,7 +75,7 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, s=
truct tee_shm *shm,
 {
 	if (shm_unregister)
 		shm_unregister(shm->ctx, shm);
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	free_pages_exact(shm->kaddr, shm->size);
 	shm->kaddr =3D NULL;
 	kfree(shm->pages);
 	shm->pages =3D NULL;
--=20
2.34.1


--===============6443047495068154647==--

