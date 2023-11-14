From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 1/2] optee: add page list to kernel private shared memory
Date: Tue, 14 Nov 2023 10:52:16 +0100
Message-ID: <20231114095217.1142360-2-jens.wiklander@linaro.org>
In-Reply-To: <20231114095217.1142360-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6678564652165388079=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6678564652165388079==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Until now has kernel private shared memory allocated as dynamic shared
memory (not from the static shared memory pool) been returned without a
list of physical pages on allocations via RPC. To support allocations
larger than one page add a list of physical pages.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c    | 28 +++++++++++++----------
 drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a258bd3b6b5..38ea2fecfc2e 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -27,7 +27,10 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, =
struct tee_shm *shm,
 						   unsigned long start))
 {
 	unsigned int order =3D get_order(size);
+	unsigned int nr_pages =3D 1 << order;
+	struct page **pages;
 	struct page *page;
+	unsigned int i;
 	int rc =3D 0;
=20
 	/*
@@ -42,30 +45,29 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool,=
 struct tee_shm *shm,
 	shm->paddr =3D page_to_phys(page);
 	shm->size =3D PAGE_SIZE << order;
=20
-	if (shm_register) {
-		unsigned int nr_pages =3D 1 << order, i;
-		struct page **pages;
+	pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages) {
+		rc =3D -ENOMEM;
+		goto err;
+	}
=20
-		pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
-		if (!pages) {
-			rc =3D -ENOMEM;
-			goto err;
-		}
+	for (i =3D 0; i < nr_pages; i++)
+		pages[i] =3D page + i;
=20
-		for (i =3D 0; i < nr_pages; i++)
-			pages[i] =3D page + i;
+	shm->pages =3D pages;
+	shm->num_pages =3D nr_pages;
=20
+	if (shm_register) {
 		rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
 				  (unsigned long)shm->kaddr);
-		kfree(pages);
 		if (rc)
 			goto err;
 	}
=20
 	return 0;
-
 err:
 	free_pages((unsigned long)shm->kaddr, order);
+	shm->kaddr =3D NULL;
 	return rc;
 }
=20
@@ -77,6 +79,8 @@ void optee_pool_op_free_helper(struct tee_shm_pool *pool, s=
truct tee_shm *shm,
 		shm_unregister(shm->ctx, shm);
 	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
 	shm->kaddr =3D NULL;
+	kfree(shm->pages);
+	shm->pages =3D NULL;
 }
=20
 static void optee_bus_scan(struct work_struct *work)
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index d5b28fd35d66..b69410c7cc0a 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -678,10 +678,11 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_co=
ntext *ctx,
 					  struct optee_msg_arg *arg,
 					  struct optee_call_ctx *call_ctx)
 {
-	phys_addr_t pa;
 	struct tee_shm *shm;
 	size_t sz;
 	size_t n;
+	struct page **pages;
+	size_t page_count;
=20
 	arg->ret_origin =3D TEEC_ORIGIN_COMMS;
=20
@@ -716,32 +717,23 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_co=
ntext *ctx,
 		return;
 	}
=20
-	if (tee_shm_get_pa(shm, 0, &pa)) {
-		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
-		goto bad;
-	}
-
-	sz =3D tee_shm_get_size(shm);
-
-	if (tee_shm_is_dynamic(shm)) {
-		struct page **pages;
+	/*
+	 * If there are pages it's dynamically allocated shared memory (not
+	 * from the reserved shared memory pool) and needs to be
+	 * registered.
+	 */
+	pages =3D tee_shm_get_pages(shm, &page_count);
+	if (pages) {
 		u64 *pages_list;
-		size_t page_num;
-
-		pages =3D tee_shm_get_pages(shm, &page_num);
-		if (!pages || !page_num) {
-			arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
-			goto bad;
-		}
=20
-		pages_list =3D optee_allocate_pages_list(page_num);
+		pages_list =3D optee_allocate_pages_list(page_count);
 		if (!pages_list) {
 			arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
 			goto bad;
 		}
=20
 		call_ctx->pages_list =3D pages_list;
-		call_ctx->num_entries =3D page_num;
+		call_ctx->num_entries =3D page_count;
=20
 		arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
 				      OPTEE_MSG_ATTR_NONCONTIG;
@@ -752,17 +744,22 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_co=
ntext *ctx,
 		arg->params[0].u.tmem.buf_ptr =3D virt_to_phys(pages_list) |
 			(tee_shm_get_page_offset(shm) &
 			 (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
-		arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
-		arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
=20
-		optee_fill_pages_list(pages_list, pages, page_num,
+		optee_fill_pages_list(pages_list, pages, page_count,
 				      tee_shm_get_page_offset(shm));
 	} else {
+		phys_addr_t pa;
+
+		if (tee_shm_get_pa(shm, 0, &pa)) {
+			arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+			goto bad;
+		}
+
 		arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
 		arg->params[0].u.tmem.buf_ptr =3D pa;
-		arg->params[0].u.tmem.size =3D sz;
-		arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
 	}
+	arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
+	arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
=20
 	arg->ret =3D TEEC_SUCCESS;
 	return;
--=20
2.34.1


--===============6678564652165388079==--

