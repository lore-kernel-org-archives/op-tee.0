From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v5 6/7] optee: FF-A: dynamic restricted memory allocation
Date: Tue, 18 Feb 2025 15:34:55 +0100
Message-ID: <20250218143527.1236668-7-jens.wiklander@linaro.org>
In-Reply-To: <20250218143527.1236668-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1794756215808522122=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1794756215808522122==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add support in the OP-TEE backend driver dynamic restricted memory
allocation with FF-A.

The restricted memory pools for dynamically allocated restrict memory
are instantiated when requested by user-space. This instantiation can
fail if OP-TEE doesn't support the requested use-case of restricted
memory.

Restricted memory pools based on a static carveout or dynamic allocation
can coexist for different use-cases. We use only dynamic allocation with
FF-A.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/ffa_abi.c       | 136 ++++++++++++-
 drivers/tee/optee/optee_private.h |  10 +-
 drivers/tee/optee/rstmem.c        | 317 +++++++++++++++++++++++++++++-
 3 files changed, 459 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 02e6175ac5f0..b933f12d096e 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -672,6 +672,122 @@ static int optee_ffa_do_call_with_arg(struct tee_contex=
t *ctx,
 	return optee_ffa_yielding_call(ctx, &data, rpc_arg, system_thread);
 }
=20
+static int do_call_lend_rstmem(struct optee *optee, u64 cookie, u32 use_case)
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
+	msg_arg->cmd =3D OPTEE_MSG_CMD_ASSIGN_RSTMEM;
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
+static int optee_ffa_lend_rstmem(struct optee *optee, struct tee_shm *rstmem,
+				 u16 *end_points, unsigned int ep_count)
+{
+	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
+	const struct ffa_mem_ops *mem_ops =3D ffa_dev->ops->mem_ops;
+	const struct ffa_msg_ops *msg_ops =3D ffa_dev->ops->msg_ops;
+	struct ffa_send_direct_data data;
+	struct ffa_mem_region_attributes *mem_attr;
+	struct ffa_mem_ops_args args =3D {
+		.use_txbuf =3D true,
+		.tag =3D rstmem->use_case,
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
+	page =3D phys_to_page(rstmem->paddr);
+	sg_init_table(&sgl, 1);
+	sg_set_page(&sgl, page, rstmem->size, 0);
+
+	args.sg =3D &sgl;
+	rc =3D mem_ops->memory_lend(&args);
+	kfree(mem_attr);
+	if (rc)
+		return rc;
+
+	rc =3D do_call_lend_rstmem(optee, args.g_handle, rstmem->use_case);
+	if (rc)
+		goto err_reclaim;
+
+	rc =3D optee_shm_add_ffa_handle(optee, rstmem, args.g_handle);
+	if (rc)
+		goto err_unreg;
+
+	rstmem->sec_world_id =3D args.g_handle;
+
+	return 0;
+
+err_unreg:
+	data =3D (struct ffa_send_direct_data){
+		.data0 =3D OPTEE_FFA_RELEASE_RSTMEM,
+		.data1 =3D (u32)args.g_handle,
+		.data2 =3D (u32)(args.g_handle >> 32),
+	};
+	msg_ops->sync_send_receive(ffa_dev, &data);
+err_reclaim:
+	mem_ops->memory_reclaim(args.g_handle, 0);
+	return rc;
+}
+
+static int optee_ffa_reclaim_rstmem(struct optee *optee, struct tee_shm *rst=
mem)
+{
+	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
+	const struct ffa_msg_ops *msg_ops =3D ffa_dev->ops->msg_ops;
+	const struct ffa_mem_ops *mem_ops =3D ffa_dev->ops->mem_ops;
+	u64 global_handle =3D rstmem->sec_world_id;
+	struct ffa_send_direct_data data =3D {
+		.data0 =3D OPTEE_FFA_RELEASE_RSTMEM,
+		.data1 =3D (u32)global_handle,
+		.data2 =3D (u32)(global_handle >> 32)
+	};
+	int rc;
+
+	optee_shm_rem_ffa_handle(optee, global_handle);
+	rstmem->sec_world_id =3D 0;
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
@@ -785,7 +901,10 @@ static void optee_ffa_get_version(struct tee_device *tee=
dev,
 		.gen_caps =3D TEE_GEN_CAP_GP | TEE_GEN_CAP_REG_MEM |
 			    TEE_GEN_CAP_MEMREF_NULL,
 	};
+	struct optee *optee =3D tee_get_drvdata(teedev);
=20
+	if (optee->rstmem_pools)
+		v.gen_caps |=3D TEE_GEN_CAP_RSTMEM;
 	*vers =3D v;
 }
=20
@@ -804,6 +923,8 @@ static const struct tee_driver_ops optee_ffa_clnt_ops =3D=
 {
 	.cancel_req =3D optee_cancel_req,
 	.shm_register =3D optee_ffa_shm_register,
 	.shm_unregister =3D optee_ffa_shm_unregister,
+	.rstmem_alloc =3D optee_rstmem_alloc,
+	.rstmem_free =3D optee_rstmem_free,
 };
=20
 static const struct tee_desc optee_ffa_clnt_desc =3D {
@@ -820,6 +941,8 @@ static const struct tee_driver_ops optee_ffa_supp_ops =3D=
 {
 	.supp_send =3D optee_supp_send,
 	.shm_register =3D optee_ffa_shm_register, /* same as for clnt ops */
 	.shm_unregister =3D optee_ffa_shm_unregister_supp,
+	.rstmem_alloc =3D optee_rstmem_alloc,
+	.rstmem_free =3D optee_rstmem_free,
 };
=20
 static const struct tee_desc optee_ffa_supp_desc =3D {
@@ -833,6 +956,8 @@ static const struct optee_ops optee_ffa_ops =3D {
 	.do_call_with_arg =3D optee_ffa_do_call_with_arg,
 	.to_msg_param =3D optee_ffa_to_msg_param,
 	.from_msg_param =3D optee_ffa_from_msg_param,
+	.lend_rstmem =3D optee_ffa_lend_rstmem,
+	.reclaim_rstmem =3D optee_ffa_reclaim_rstmem,
 };
=20
 static void optee_ffa_remove(struct ffa_device *ffa_dev)
@@ -937,11 +1062,18 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	    (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
 		optee->in_kernel_rpmb_routing =3D true;
=20
+	if (IS_ENABLED(CONFIG_CMA) && !IS_MODULE(CONFIG_OPTEE) &&
+	    (sec_caps & OPTEE_FFA_SEC_CAP_RSTMEM)) {
+		rc =3D optee_rstmem_pools_init(optee);
+		if (rc)
+			goto err_free_pool;
+	}
+
 	teedev =3D tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
 				  optee);
 	if (IS_ERR(teedev)) {
 		rc =3D PTR_ERR(teedev);
-		goto err_free_pool;
+		goto err_free_rstmem_pools;
 	}
 	optee->teedev =3D teedev;
=20
@@ -1020,6 +1152,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	tee_device_unregister(optee->teedev);
 err_free_pool:
 	tee_shm_pool_free(pool);
+err_free_rstmem_pools:
+	optee_rstmem_pools_uninit(optee);
 err_free_optee:
 	kfree(optee);
 	return rc;
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 0491889e5b0e..dd2a3a2224bc 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -174,9 +174,14 @@ struct optee;
  * @do_call_with_arg:	enters OP-TEE in secure world
  * @to_msg_param:	converts from struct tee_param to OPTEE_MSG parameters
  * @from_msg_param:	converts from OPTEE_MSG parameters to struct tee_param
+ * @lend_rstmem:	lends physically contiguous memory as restricted
+ *			memory, inaccessible by the kernel
+ * @reclaim_rstmem:	reclaims restricted memory previously lent with
+ *			@lend_rstmem() and makes it accessible by the
+ *			kernel again
  *
  * These OPs are only supposed to be used internally in the OP-TEE driver
- * as a way of abstracting the different methogs of entering OP-TEE in
+ * as a way of abstracting the different methods of entering OP-TEE in
  * secure world.
  */
 struct optee_ops {
@@ -191,6 +196,9 @@ struct optee_ops {
 			      size_t num_params,
 			      const struct optee_msg_param *msg_params,
 			      bool update_out);
+	int (*lend_rstmem)(struct optee *optee, struct tee_shm *rstmem,
+			   u16 *end_points, unsigned int ep_count);
+	int (*reclaim_rstmem)(struct optee *optee, struct tee_shm *rstmem);
 };
=20
 /**
diff --git a/drivers/tee/optee/rstmem.c b/drivers/tee/optee/rstmem.c
index 01456bc3e2f6..9a5013e3cc5f 100644
--- a/drivers/tee/optee/rstmem.c
+++ b/drivers/tee/optee/rstmem.c
@@ -4,6 +4,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
+#include <linux/cma.h>
 #include <linux/dma-map-ops.h>
 #include <linux/errno.h>
 #include <linux/genalloc.h>
@@ -13,11 +14,314 @@
 #include <linux/types.h>
 #include "optee_private.h"
=20
+#if IS_ENABLED(CONFIG_CMA) && !IS_MODULE(CONFIG_OPTEE)
+struct optee_rstmem_cma_pool {
+	struct tee_shm_pool pool;
+	struct page *page;
+	struct optee *optee;
+	size_t page_count;
+	u16 *end_points;
+	u_int end_point_count;
+	u_int align;
+	refcount_t refcount;
+	struct tee_shm rstmem;
+	/* Protects when initializing and tearing down this struct */
+	struct mutex mutex;
+};
+
+static struct optee_rstmem_cma_pool *
+to_rstmem_cma_pool(struct tee_shm_pool *pool)
+{
+	return container_of(pool, struct optee_rstmem_cma_pool, pool);
+}
+
+static int init_cma_rstmem(struct optee_rstmem_cma_pool *rp)
+{
+	struct cma *cma =3D dev_get_cma_area(&rp->optee->teedev->dev);
+	int rc;
+
+	rp->page =3D cma_alloc(cma, rp->page_count, rp->align, true/*no_warn*/);
+	if (!rp->page)
+		return -ENOMEM;
+
+	/*
+	 * TODO unmap the memory range since the physical memory will
+	 * become inaccesible after the lend_rstmem() call.
+	 */
+
+	rp->rstmem.paddr =3D page_to_phys(rp->page);
+	rp->rstmem.size =3D rp->page_count * PAGE_SIZE;
+	rc =3D rp->optee->ops->lend_rstmem(rp->optee, &rp->rstmem,
+					 rp->end_points, rp->end_point_count);
+	if (rc)
+		goto err_release;
+
+	rp->pool.private_data =3D gen_pool_create(PAGE_SHIFT, -1);
+	if (!rp->pool.private_data) {
+		rc =3D -ENOMEM;
+		goto err_reclaim;
+	}
+
+	rc =3D gen_pool_add(rp->pool.private_data, rp->rstmem.paddr,
+			  rp->rstmem.size, -1);
+	if (rc)
+		goto err_free_pool;
+
+	refcount_set(&rp->refcount, 1);
+	return 0;
+
+err_free_pool:
+	gen_pool_destroy(rp->pool.private_data);
+err_reclaim:
+	rp->optee->ops->reclaim_rstmem(rp->optee, &rp->rstmem);
+err_release:
+	cma_release(cma, rp->page, rp->page_count);
+	rp->rstmem.paddr =3D 0;
+	rp->rstmem.size =3D 0;
+	rp->rstmem.sec_world_id =3D 0;
+	return rc;
+}
+
+static int get_cma_rstmem(struct optee_rstmem_cma_pool *rp)
+{
+	int rc =3D 0;
+
+	if (!refcount_inc_not_zero(&rp->refcount)) {
+		mutex_lock(&rp->mutex);
+		if (rp->pool.private_data) {
+			/*
+			 * Another thread has already initialized the pool
+			 * before us, or the pool was just about to be torn
+			 * down. Either way we only need to increase the
+			 * refcount and we're done.
+			 */
+			refcount_inc(&rp->refcount);
+		} else {
+			rc =3D init_cma_rstmem(rp);
+		}
+		mutex_unlock(&rp->mutex);
+	}
+
+	return rc;
+}
+
+static void release_cma_rstmem(struct optee_rstmem_cma_pool *rp)
+{
+	gen_pool_destroy(rp->pool.private_data);
+	rp->optee->ops->reclaim_rstmem(rp->optee, &rp->rstmem);
+	cma_release(dev_get_cma_area(&rp->optee->teedev->dev), rp->page,
+		    rp->page_count);
+
+	rp->pool.private_data =3D NULL;
+	rp->page =3D NULL;
+	rp->rstmem.paddr =3D 0;
+	rp->rstmem.size =3D 0;
+	rp->rstmem.sec_world_id =3D 0;
+}
+
+static void put_cma_rstmem(struct optee_rstmem_cma_pool *rp)
+{
+	if (refcount_dec_and_test(&rp->refcount)) {
+		mutex_lock(&rp->mutex);
+		if (rp->pool.private_data)
+			release_cma_rstmem(rp);
+		mutex_unlock(&rp->mutex);
+	}
+}
+
+static int rstmem_pool_op_cma_alloc(struct tee_shm_pool *pool,
+				    struct tee_shm *shm, size_t size,
+				    size_t align)
+{
+	struct optee_rstmem_cma_pool *rp =3D to_rstmem_cma_pool(pool);
+	size_t sz =3D ALIGN(size, PAGE_SIZE);
+	phys_addr_t pa;
+	int rc;
+
+	rc =3D get_cma_rstmem(rp);
+	if (rc)
+		return rc;
+
+	pa =3D gen_pool_alloc(rp->pool.private_data, sz);
+	if (!pa) {
+		put_cma_rstmem(rp);
+		return -ENOMEM;
+	}
+
+	shm->size =3D sz;
+	shm->paddr =3D pa;
+	shm->offset =3D pa - page_to_phys(rp->page);
+	shm->sec_world_id =3D rp->rstmem.sec_world_id;
+
+	return 0;
+}
+
+static void rstmem_pool_op_cma_free(struct tee_shm_pool *pool,
+				    struct tee_shm *shm)
+{
+	struct optee_rstmem_cma_pool *rp =3D to_rstmem_cma_pool(pool);
+
+	gen_pool_free(rp->pool.private_data, shm->paddr, shm->size);
+	shm->size =3D 0;
+	shm->paddr =3D 0;
+	shm->offset =3D 0;
+	shm->sec_world_id =3D 0;
+	put_cma_rstmem(rp);
+}
+
+static void pool_op_cma_destroy_pool(struct tee_shm_pool *pool)
+{
+	struct optee_rstmem_cma_pool *rp =3D to_rstmem_cma_pool(pool);
+
+	mutex_destroy(&rp->mutex);
+	kfree(rp);
+}
+
+static struct tee_shm_pool_ops rstmem_pool_ops_cma =3D {
+	.alloc =3D rstmem_pool_op_cma_alloc,
+	.free =3D rstmem_pool_op_cma_free,
+	.destroy_pool =3D pool_op_cma_destroy_pool,
+};
+
+static int get_rstmem_config(struct optee *optee, u32 use_case,
+			     size_t *min_size, u_int *min_align,
+			     u16 *end_points, u_int *ep_count)
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
+	msg_arg->cmd =3D OPTEE_MSG_CMD_GET_RSTMEM_CONFIG;
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
+static struct tee_shm_pool *alloc_rstmem_pool(struct optee *optee, u32 use_c=
ase)
+{
+	struct optee_rstmem_cma_pool *rp;
+	size_t min_size;
+	int rc;
+
+	rp =3D kzalloc(sizeof(*rp), GFP_KERNEL);
+	if (!rp)
+		return ERR_PTR(-ENOMEM);
+	rp->rstmem.use_case =3D use_case;
+
+	rc =3D get_rstmem_config(optee, use_case, &min_size, &rp->align, NULL,
+			       &rp->end_point_count);
+	if (rc) {
+		if (rc !=3D -ENOSPC)
+			goto err;
+		rp->end_points =3D kcalloc(rp->end_point_count,
+					 sizeof(*rp->end_points), GFP_KERNEL);
+		if (!rp->end_points) {
+			rc =3D -ENOMEM;
+			goto err;
+		}
+		rc =3D get_rstmem_config(optee, use_case, &min_size, &rp->align,
+				       rp->end_points, &rp->end_point_count);
+		if (rc)
+			goto err_kfree_eps;
+	}
+
+	rp->pool.ops =3D &rstmem_pool_ops_cma;
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
+#else /*CONFIG_CMA*/
+static struct tee_shm_pool *
+alloc_rstmem_pool(struct optee *optee __always_unused,
+		  u32 use_case __always_unused)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif /*CONFIG_CMA*/
+
 int optee_rstmem_alloc(struct tee_context *ctx, struct tee_shm *shm,
 		       u32 flags, u32 use_case, size_t size)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct tee_shm_pool *pool;
+	int rc;
=20
 	if (!optee->rstmem_pools)
 		return -EINVAL;
@@ -25,8 +329,17 @@ int optee_rstmem_alloc(struct tee_context *ctx, struct te=
e_shm *shm,
 		return -EINVAL;
=20
 	pool =3D xa_load(&optee->rstmem_pools->xa, use_case);
-	if (!pool)
-		return -EINVAL;
+	if (!pool) {
+		pool =3D alloc_rstmem_pool(optee, use_case);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+		rc =3D xa_insert(&optee->rstmem_pools->xa, use_case, pool,
+			       GFP_KERNEL);
+		if (rc) {
+			pool->ops->destroy_pool(pool);
+			return rc;
+		}
+	}
=20
 	return pool->ops->alloc(pool, shm, size, 0);
 }
--=20
2.43.0


--===============1794756215808522122==--

