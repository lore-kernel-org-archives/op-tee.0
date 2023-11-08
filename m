From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 2/2] optee: allocate shared memory with alloc_pages_exact()
Date: Wed, 08 Nov 2023 11:27:55 +0100
Message-ID: <20231108102755.93079-3-jens.wiklander@linaro.org>
In-Reply-To: <20231108102755.93079-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5445842287104251574=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5445842287104251574==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Allocate memory to share with the secure using alloc_pages_exact()
instead of alloc_pages() for more efficient memory usage.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a425eca0173d..6303085a1b49 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -26,21 +26,19 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool,=
 struct tee_shm *shm,
 						   size_t num_pages,
 						   unsigned long start))
 {
-	unsigned int order =3D get_order(size);
-	unsigned int nr_pages =3D 1 << order;
-	struct page *page;
+	size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
 	int rc =3D 0;
=20
 	/*
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
-	shm->size =3D PAGE_SIZE << order;
+	shm->size =3D nr_pages * PAGE_SIZE;
=20
 	/*
 	 * If memory is registered immediately use a temporary page list
@@ -66,7 +64,8 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, s=
truct tee_shm *shm,
 		}
=20
 		for (i =3D 0; i < nr_pages; i++)
-			pages[i] =3D page + i;
+			pages[i] =3D virt_to_page((u8 *)shm->kaddr +
+						i * PAGE_SIZE);
=20
 		if (shm_register) {
 			rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
@@ -79,12 +78,12 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool,=
 struct tee_shm *shm,
 			shm->num_pages =3D nr_pages;
 		}
 	} else {
-		shm->paddr =3D page_to_phys(page);
+		shm->paddr =3D virt_to_phys(shm->kaddr);
 	}
=20
 	return 0;
 err:
-	free_pages((unsigned long)shm->kaddr, order);
+	free_pages_exact(shm->kaddr, shm->size);
 	shm->kaddr =3D NULL;
 	return rc;
 }
@@ -95,7 +94,7 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, s=
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


--===============5445842287104251574==--

