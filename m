From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v8 13/14] optee: FF-A: dynamic protected memory allocation
Date: Fri, 02 May 2025 11:59:27 +0200
Message-ID: <20250502100049.1746335-14-jens.wiklander@linaro.org>
In-Reply-To: <20250502100049.1746335-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0695478348431637274=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0695478348431637274==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add support in the OP-TEE backend driver dynamic protected memory
allocation with FF-A.

The protected memory pools for dynamically allocated protected memory
are instantiated when requested by user-space. This instantiation can
fail if OP-TEE doesn't support the requested use-case of protected
memory.

Restricted memory pools based on a static carveout or dynamic allocation
can coexist for different use-cases. We use only dynamic allocation with
FF-A.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/ffa_abi.c       | 147 ++++++++++++-
 drivers/tee/optee/optee_private.h |  13 +-
 drivers/tee/optee/protmem.c       | 330 ++++++++++++++++++++++++++++++
 4 files changed, 488 insertions(+), 3 deletions(-)
 create mode 100644 drivers/tee/optee/protmem.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index a6eff388d300..ad7049c1c107 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -4,6 +4,7 @@ optee-objs +=3D core.o
 optee-objs +=3D call.o
 optee-objs +=3D notif.o
 optee-objs +=3D rpc.o
+optee-objs +=3D protmem.o
 optee-objs +=3D supp.o
 optee-objs +=3D device.o
 optee-objs +=3D smc_abi.o
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index e4b08cd195f3..e1f02fc42c2f 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -672,6 +672,124 @@ static int optee_ffa_do_call_with_arg(struct tee_contex=
t *ctx,
 	return optee_ffa_yielding_call(ctx, &data, rpc_arg, system_thread);
 }
=20
+static int do_call_lend_protmem(struct optee *optee, u64 cookie, u32 use_cas=
e)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg =3D optee_get_msg_arg(optee->ctx, 1, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd =3D OPTEE_MSG_CMD_ASSIGN_PROTMEM;
+	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+	msg_arg->params[0].u.value.a =3D cookie;
+	msg_arg->params[0].u.value.b =3D use_case;
+
+	rc =3D optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret !=3D TEEC_SUCCESS) {
+		rc =3D -EINVAL;
+		goto out;
+	}
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
+static int optee_ffa_lend_protmem(struct optee *optee, struct tee_shm *protm=
em,
+				  u16 *end_points, unsigned int ep_count,
+				  u32 use_case)
+{
+	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
+	const struct ffa_mem_ops *mem_ops =3D ffa_dev->ops->mem_ops;
+	const struct ffa_msg_ops *msg_ops =3D ffa_dev->ops->msg_ops;
+	struct ffa_send_direct_data data;
+	struct ffa_mem_region_attributes *mem_attr;
+	struct ffa_mem_ops_args args =3D {
+		.use_txbuf =3D true,
+		.tag =3D use_case,
+	};
+	struct page *page;
+	struct scatterlist sgl;
+	unsigned int n;
+	int rc;
+
+	mem_attr =3D kcalloc(ep_count, sizeof(*mem_attr), GFP_KERNEL);
+	for (n =3D 0; n < ep_count; n++) {
+		mem_attr[n].receiver =3D end_points[n];
+		mem_attr[n].attrs =3D FFA_MEM_RW;
+	}
+	args.attrs =3D mem_attr;
+	args.nattrs =3D ep_count;
+
+	page =3D phys_to_page(protmem->paddr);
+	sg_init_table(&sgl, 1);
+	sg_set_page(&sgl, page, protmem->size, 0);
+
+	args.sg =3D &sgl;
+	rc =3D mem_ops->memory_lend(&args);
+	kfree(mem_attr);
+	if (rc)
+		return rc;
+
+	rc =3D do_call_lend_protmem(optee, args.g_handle, use_case);
+	if (rc)
+		goto err_reclaim;
+
+	rc =3D optee_shm_add_ffa_handle(optee, protmem, args.g_handle);
+	if (rc)
+		goto err_unreg;
+
+	protmem->sec_world_id =3D args.g_handle;
+
+	return 0;
+
+err_unreg:
+	data =3D (struct ffa_send_direct_data){
+		.data0 =3D OPTEE_FFA_RELEASE_PROTMEM,
+		.data1 =3D (u32)args.g_handle,
+		.data2 =3D (u32)(args.g_handle >> 32),
+	};
+	msg_ops->sync_send_receive(ffa_dev, &data);
+err_reclaim:
+	mem_ops->memory_reclaim(args.g_handle, 0);
+	return rc;
+}
+
+static int optee_ffa_reclaim_protmem(struct optee *optee,
+				     struct tee_shm *protmem)
+{
+	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
+	const struct ffa_msg_ops *msg_ops =3D ffa_dev->ops->msg_ops;
+	const struct ffa_mem_ops *mem_ops =3D ffa_dev->ops->mem_ops;
+	u64 global_handle =3D protmem->sec_world_id;
+	struct ffa_send_direct_data data =3D {
+		.data0 =3D OPTEE_FFA_RELEASE_PROTMEM,
+		.data1 =3D (u32)global_handle,
+		.data2 =3D (u32)(global_handle >> 32)
+	};
+	int rc;
+
+	optee_shm_rem_ffa_handle(optee, global_handle);
+	protmem->sec_world_id =3D 0;
+
+	rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
+	if (rc)
+		pr_err("Release SHM id 0x%llx rc %d\n", global_handle, rc);
+
+	rc =3D mem_ops->memory_reclaim(global_handle, 0);
+	if (rc)
+		pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
+
+	return rc;
+}
+
 /*
  * 6. Driver initialization
  *
@@ -833,6 +951,8 @@ static const struct optee_ops optee_ffa_ops =3D {
 	.do_call_with_arg =3D optee_ffa_do_call_with_arg,
 	.to_msg_param =3D optee_ffa_to_msg_param,
 	.from_msg_param =3D optee_ffa_from_msg_param,
+	.lend_protmem =3D optee_ffa_lend_protmem,
+	.reclaim_protmem =3D optee_ffa_reclaim_protmem,
 };
=20
 static void optee_ffa_remove(struct ffa_device *ffa_dev)
@@ -891,6 +1011,25 @@ static int optee_ffa_async_notif_init(struct ffa_device=
 *ffa_dev,
 	return rc;
 }
=20
+static int optee_ffa_protmem_pool_init(struct optee *optee, u32 sec_caps)
+{
+	enum tee_dma_heap_id id =3D TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
+	struct tee_protmem_pool *pool;
+	int rc =3D 0;
+
+	if (sec_caps & OPTEE_FFA_SEC_CAP_PROTMEM) {
+		pool =3D optee_protmem_alloc_cma_pool(optee, id);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+
+		rc =3D tee_device_register_dma_heap(optee->teedev, id, pool);
+		if (rc)
+			pool->ops->destroy_pool(pool);
+	}
+
+	return rc;
+}
+
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
 	const struct ffa_notifier_ops *notif_ops;
@@ -941,7 +1080,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 				  optee->pool, optee);
 	if (IS_ERR(teedev)) {
 		rc =3D PTR_ERR(teedev);
-		goto err_free_pool;
+		goto err_free_shm_pool;
 	}
 	optee->teedev =3D teedev;
=20
@@ -988,6 +1127,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 			       rc);
 	}
=20
+	if (optee_ffa_protmem_pool_init(optee, sec_caps))
+		pr_info("Protected memory service not available\n");
+
 	rc =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc)
 		goto err_unregister_devices;
@@ -1001,6 +1143,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
=20
 err_unregister_devices:
 	optee_unregister_devices();
+	tee_device_unregister_all_dma_heaps(optee->teedev);
 	if (optee->ffa.bottom_half_value !=3D U32_MAX)
 		notif_ops->notify_relinquish(ffa_dev,
 					     optee->ffa.bottom_half_value);
@@ -1018,7 +1161,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	tee_device_unregister(optee->supp_teedev);
 err_unreg_teedev:
 	tee_device_unregister(optee->teedev);
-err_free_pool:
+err_free_shm_pool:
 	tee_shm_pool_free(pool);
 err_free_optee:
 	kfree(optee);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 20eda508dbac..7c53433f6562 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -174,9 +174,14 @@ struct optee;
  * @do_call_with_arg:	enters OP-TEE in secure world
  * @to_msg_param:	converts from struct tee_param to OPTEE_MSG parameters
  * @from_msg_param:	converts from OPTEE_MSG parameters to struct tee_param
+ * @lend_protmem:	lends physically contiguous memory as restricted
+ *			memory, inaccessible by the kernel
+ * @reclaim_protmem:	reclaims restricted memory previously lent with
+ *			@lend_protmem() and makes it accessible by the
+ *			kernel again
  *
  * These OPs are only supposed to be used internally in the OP-TEE driver
- * as a way of abstracting the different methogs of entering OP-TEE in
+ * as a way of abstracting the different methods of entering OP-TEE in
  * secure world.
  */
 struct optee_ops {
@@ -191,6 +196,10 @@ struct optee_ops {
 			      size_t num_params,
 			      const struct optee_msg_param *msg_params,
 			      bool update_out);
+	int (*lend_protmem)(struct optee *optee, struct tee_shm *protmem,
+			    u16 *end_points, unsigned int ep_count,
+			    u32 use_case);
+	int (*reclaim_protmem)(struct optee *optee, struct tee_shm *protmem);
 };
=20
 /**
@@ -285,6 +294,8 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func=
, size_t num_params,
 void optee_supp_init(struct optee_supp *supp);
 void optee_supp_uninit(struct optee_supp *supp);
 void optee_supp_release(struct optee_supp *supp);
+struct tee_protmem_pool *optee_protmem_alloc_cma_pool(struct optee *optee,
+						      enum tee_dma_heap_id id);
=20
 int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		    struct tee_param *param);
diff --git a/drivers/tee/optee/protmem.c b/drivers/tee/optee/protmem.c
new file mode 100644
index 000000000000..e8d6b750a881
--- /dev/null
+++ b/drivers/tee/optee/protmem.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Linaro Limited
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/errno.h>
+#include <linux/genalloc.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tee_core.h>
+#include <linux/types.h>
+#include "optee_private.h"
+
+struct optee_protmem_cma_pool {
+	struct tee_protmem_pool pool;
+	struct gen_pool *gen_pool;
+	struct optee *optee;
+	size_t page_count;
+	u16 *end_points;
+	u_int end_point_count;
+	u_int align;
+	refcount_t refcount;
+	u32 use_case;
+	struct tee_shm *protmem;
+	/* Protects when initializing and tearing down this struct */
+	struct mutex mutex;
+};
+
+static struct optee_protmem_cma_pool *
+to_protmem_cma_pool(struct tee_protmem_pool *pool)
+{
+	return container_of(pool, struct optee_protmem_cma_pool, pool);
+}
+
+static int init_cma_protmem(struct optee_protmem_cma_pool *rp)
+{
+	int rc;
+
+	rp->protmem =3D tee_shm_alloc_cma_phys_mem(rp->optee->ctx, rp->page_count,
+						 rp->align);
+	if (IS_ERR(rp->protmem)) {
+		rc =3D PTR_ERR(rp->protmem);
+		goto err_null_protmem;
+	}
+
+	/*
+	 * TODO unmap the memory range since the physical memory will
+	 * become inaccesible after the lend_protmem() call.
+	 */
+	rc =3D rp->optee->ops->lend_protmem(rp->optee, rp->protmem,
+					  rp->end_points,
+					  rp->end_point_count, rp->use_case);
+	if (rc)
+		goto err_put_shm;
+	rp->protmem->flags |=3D TEE_SHM_DYNAMIC;
+
+	rp->gen_pool =3D gen_pool_create(PAGE_SHIFT, -1);
+	if (!rp->gen_pool) {
+		rc =3D -ENOMEM;
+		goto err_reclaim;
+	}
+
+	rc =3D gen_pool_add(rp->gen_pool, rp->protmem->paddr,
+			  rp->protmem->size, -1);
+	if (rc)
+		goto err_free_pool;
+
+	refcount_set(&rp->refcount, 1);
+	return 0;
+
+err_free_pool:
+	gen_pool_destroy(rp->gen_pool);
+	rp->gen_pool =3D NULL;
+err_reclaim:
+	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
+err_put_shm:
+	tee_shm_put(rp->protmem);
+err_null_protmem:
+	rp->protmem =3D NULL;
+	return rc;
+}
+
+static int get_cma_protmem(struct optee_protmem_cma_pool *rp)
+{
+	int rc =3D 0;
+
+	if (!refcount_inc_not_zero(&rp->refcount)) {
+		mutex_lock(&rp->mutex);
+		if (rp->gen_pool) {
+			/*
+			 * Another thread has already initialized the pool
+			 * before us, or the pool was just about to be torn
+			 * down. Either way we only need to increase the
+			 * refcount and we're done.
+			 */
+			refcount_inc(&rp->refcount);
+		} else {
+			rc =3D init_cma_protmem(rp);
+		}
+		mutex_unlock(&rp->mutex);
+	}
+
+	return rc;
+}
+
+static void release_cma_protmem(struct optee_protmem_cma_pool *rp)
+{
+	gen_pool_destroy(rp->gen_pool);
+	rp->gen_pool =3D NULL;
+
+	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
+	rp->protmem->flags &=3D ~TEE_SHM_DYNAMIC;
+
+	WARN(refcount_read(&rp->protmem->refcount) !=3D 1, "Unexpected refcount");
+	tee_shm_put(rp->protmem);
+	rp->protmem =3D NULL;
+}
+
+static void put_cma_protmem(struct optee_protmem_cma_pool *rp)
+{
+	if (refcount_dec_and_test(&rp->refcount)) {
+		mutex_lock(&rp->mutex);
+		if (rp->gen_pool)
+			release_cma_protmem(rp);
+		mutex_unlock(&rp->mutex);
+	}
+}
+
+static int protmem_pool_op_cma_alloc(struct tee_protmem_pool *pool,
+				     struct sg_table *sgt, size_t size,
+				     size_t *offs)
+{
+	struct optee_protmem_cma_pool *rp =3D to_protmem_cma_pool(pool);
+	size_t sz =3D ALIGN(size, PAGE_SIZE);
+	phys_addr_t pa;
+	int rc;
+
+	rc =3D get_cma_protmem(rp);
+	if (rc)
+		return rc;
+
+	pa =3D gen_pool_alloc(rp->gen_pool, sz);
+	if (!pa) {
+		rc =3D -ENOMEM;
+		goto err_put;
+	}
+
+	rc =3D sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (rc)
+		goto err_free;
+
+	sg_set_page(sgt->sgl, phys_to_page(pa), size, 0);
+	*offs =3D pa - rp->protmem->paddr;
+
+	return 0;
+err_free:
+	gen_pool_free(rp->gen_pool, pa, size);
+err_put:
+	put_cma_protmem(rp);
+
+	return rc;
+}
+
+static void protmem_pool_op_cma_free(struct tee_protmem_pool *pool,
+				     struct sg_table *sgt)
+{
+	struct optee_protmem_cma_pool *rp =3D to_protmem_cma_pool(pool);
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sgtable_sg(sgt, sg, i)
+		gen_pool_free(rp->gen_pool, sg_phys(sg), sg->length);
+	sg_free_table(sgt);
+	put_cma_protmem(rp);
+}
+
+static int protmem_pool_op_cma_update_shm(struct tee_protmem_pool *pool,
+					  struct sg_table *sgt, size_t offs,
+					  struct tee_shm *shm,
+					  struct tee_shm **parent_shm)
+{
+	struct optee_protmem_cma_pool *rp =3D to_protmem_cma_pool(pool);
+
+	*parent_shm =3D rp->protmem;
+
+	return 0;
+}
+
+static void pool_op_cma_destroy_pool(struct tee_protmem_pool *pool)
+{
+	struct optee_protmem_cma_pool *rp =3D to_protmem_cma_pool(pool);
+
+	mutex_destroy(&rp->mutex);
+	kfree(rp);
+}
+
+static struct tee_protmem_pool_ops protmem_pool_ops_cma =3D {
+	.alloc =3D protmem_pool_op_cma_alloc,
+	.free =3D protmem_pool_op_cma_free,
+	.update_shm =3D protmem_pool_op_cma_update_shm,
+	.destroy_pool =3D pool_op_cma_destroy_pool,
+};
+
+static int get_protmem_config(struct optee *optee, u32 use_case,
+			      size_t *min_size, u_int *min_align,
+			      u16 *end_points, u_int *ep_count)
+{
+	struct tee_param params[2] =3D {
+		[0] =3D {
+			.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT,
+			.u.value.a =3D use_case,
+		},
+		[1] =3D {
+			.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT,
+		},
+	};
+	struct optee_shm_arg_entry *entry;
+	struct tee_shm *shm_param =3D NULL;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	if (end_points && *ep_count) {
+		params[1].u.memref.size =3D *ep_count * sizeof(*end_points);
+		shm_param =3D tee_shm_alloc_priv_buf(optee->ctx,
+						   params[1].u.memref.size);
+		if (IS_ERR(shm_param))
+			return PTR_ERR(shm_param);
+		params[1].u.memref.shm =3D shm_param;
+	}
+
+	msg_arg =3D optee_get_msg_arg(optee->ctx, ARRAY_SIZE(params), &entry,
+				    &shm, &offs);
+	if (IS_ERR(msg_arg)) {
+		rc =3D PTR_ERR(msg_arg);
+		goto out_free_shm;
+	}
+	msg_arg->cmd =3D OPTEE_MSG_CMD_GET_PROTMEM_CONFIG;
+
+	rc =3D optee->ops->to_msg_param(optee, msg_arg->params,
+				      ARRAY_SIZE(params), params,
+				      false /*!update_out*/);
+	if (rc)
+		goto out_free_msg;
+
+	rc =3D optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out_free_msg;
+	if (msg_arg->ret && msg_arg->ret !=3D TEEC_ERROR_SHORT_BUFFER) {
+		rc =3D -EINVAL;
+		goto out_free_msg;
+	}
+
+	rc =3D optee->ops->from_msg_param(optee, params, ARRAY_SIZE(params),
+					msg_arg->params, true /*update_out*/);
+	if (rc)
+		goto out_free_msg;
+
+	if (!msg_arg->ret && end_points &&
+	    *ep_count < params[1].u.memref.size / sizeof(u16)) {
+		rc =3D -EINVAL;
+		goto out_free_msg;
+	}
+
+	*min_size =3D params[0].u.value.a;
+	*min_align =3D params[0].u.value.b;
+	*ep_count =3D params[1].u.memref.size / sizeof(u16);
+
+	if (msg_arg->ret =3D=3D TEEC_ERROR_SHORT_BUFFER) {
+		rc =3D -ENOSPC;
+		goto out_free_msg;
+	}
+
+	if (end_points)
+		memcpy(end_points, tee_shm_get_va(shm_param, 0),
+		       params[1].u.memref.size);
+
+out_free_msg:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+out_free_shm:
+	if (shm_param)
+		tee_shm_free(shm_param);
+	return rc;
+}
+
+struct tee_protmem_pool *optee_protmem_alloc_cma_pool(struct optee *optee,
+						      enum tee_dma_heap_id id)
+{
+	struct optee_protmem_cma_pool *rp;
+	u32 use_case =3D id;
+	size_t min_size;
+	int rc;
+
+	rp =3D kzalloc(sizeof(*rp), GFP_KERNEL);
+	if (!rp)
+		return ERR_PTR(-ENOMEM);
+	rp->use_case =3D use_case;
+
+	rc =3D get_protmem_config(optee, use_case, &min_size, &rp->align, NULL,
+				&rp->end_point_count);
+	if (rc) {
+		if (rc !=3D -ENOSPC)
+			goto err;
+		rp->end_points =3D kcalloc(rp->end_point_count,
+					 sizeof(*rp->end_points), GFP_KERNEL);
+		if (!rp->end_points) {
+			rc =3D -ENOMEM;
+			goto err;
+		}
+		rc =3D get_protmem_config(optee, use_case, &min_size, &rp->align,
+					rp->end_points, &rp->end_point_count);
+		if (rc)
+			goto err_kfree_eps;
+	}
+
+	rp->pool.ops =3D &protmem_pool_ops_cma;
+	rp->optee =3D optee;
+	rp->page_count =3D min_size / PAGE_SIZE;
+	mutex_init(&rp->mutex);
+
+	return &rp->pool;
+
+err_kfree_eps:
+	kfree(rp->end_points);
+err:
+	kfree(rp);
+	return ERR_PTR(rc);
+}
--=20
2.43.0


--===============0695478348431637274==--

