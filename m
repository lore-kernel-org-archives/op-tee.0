From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v5 4/5] optee: isolate smc abi
Date: Tue, 31 Aug 2021 09:24:11 +0200
Message-ID: <20210831072412.887565-5-jens.wiklander@linaro.org>
In-Reply-To: <20210831072412.887565-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2103423157570891762=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2103423157570891762==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Isolate the ABI based on raw SMCs. Code specific to the raw SMC ABI is
moved into smc_abi.c. This makes room for other ABIs with a clear
separation.

The driver changes to use module_init()/module_exit() instead of
module_platform_driver(). The platform_driver_register() and
platform_driver_unregister() functions called directly to keep the same
behavior. This is needed because module_platform_driver() is based on
module_driver() which can only be used once in a module.

A function optee_rpc_cmd() is factored out from the function
handle_rpc_func_cmd() to handle the ABI independent part of RPC
processing.

This patch is not supposed to change the driver behavior, it's only a
matter of reorganizing the code.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/Makefile        |    6 +-
 drivers/tee/optee/call.c          |  369 +-------
 drivers/tee/optee/core.c          |  721 ++-------------
 drivers/tee/optee/optee_private.h |  104 ++-
 drivers/tee/optee/rpc.c           |  218 +----
 drivers/tee/optee/shm_pool.c      |  101 ---
 drivers/tee/optee/shm_pool.h      |   14 -
 drivers/tee/optee/smc_abi.c       | 1360 +++++++++++++++++++++++++++++
 8 files changed, 1506 insertions(+), 1387 deletions(-)
 delete mode 100644 drivers/tee/optee/shm_pool.c
 delete mode 100644 drivers/tee/optee/shm_pool.h
 create mode 100644 drivers/tee/optee/smc_abi.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 3aa33ea9e6a6..d4e4776d2dec 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -4,8 +4,10 @@ optee-objs +=3D core.o
 optee-objs +=3D call.o
 optee-objs +=3D rpc.o
 optee-objs +=3D supp.o
-optee-objs +=3D shm_pool.o
 optee-objs +=3D device.o
=20
+optee-smc-abi-y =3D smc_abi.o
+optee-objs +=3D $(optee-smc-abi-y)
+
 # for tracing framework to find optee_trace.h
-CFLAGS_call.o :=3D -I$(src)
+CFLAGS_smc_abi.o :=3D -I$(src)
diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index ddedde45f1ee..9ff4f0812825 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -2,28 +2,17 @@
 /*
  * Copyright (c) 2015-2021, Linaro Limited
  */
-#include <linux/arm-smccc.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
-#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
-#include <linux/uaccess.h>
 #include "optee_private.h"
-#include "optee_smc.h"
-#define CREATE_TRACE_POINTS
-#include "optee_trace.h"
=20
-struct optee_call_waiter {
-	struct list_head list_node;
-	struct completion c;
-};
-
-static void optee_cq_wait_init(struct optee_call_queue *cq,
-			       struct optee_call_waiter *w)
+void optee_cq_wait_init(struct optee_call_queue *cq,
+			struct optee_call_waiter *w)
 {
 	/*
 	 * We're preparing to make a call to secure world. In case we can't
@@ -47,8 +36,8 @@ static void optee_cq_wait_init(struct optee_call_queue *cq,
 	mutex_unlock(&cq->mutex);
 }
=20
-static void optee_cq_wait_for_completion(struct optee_call_queue *cq,
-					 struct optee_call_waiter *w)
+void optee_cq_wait_for_completion(struct optee_call_queue *cq,
+				  struct optee_call_waiter *w)
 {
 	wait_for_completion(&w->c);
=20
@@ -74,8 +63,8 @@ static void optee_cq_complete_one(struct optee_call_queue *=
cq)
 	}
 }
=20
-static void optee_cq_wait_final(struct optee_call_queue *cq,
-				struct optee_call_waiter *w)
+void optee_cq_wait_final(struct optee_call_queue *cq,
+			 struct optee_call_waiter *w)
 {
 	/*
 	 * We're done with the call to secure world. The thread in secure
@@ -115,73 +104,8 @@ static struct optee_session *find_session(struct optee_c=
ontext_data *ctxdata,
 	return NULL;
 }
=20
-/**
- * optee_do_call_with_arg() - Do an SMC to OP-TEE in secure world
- * @ctx:	calling context
- * @arg:	shared memory holding the message to pass to secure world
- *
- * Does and SMC to OP-TEE in secure world and handles eventual resulting
- * Remote Procedure Calls (RPC) from OP-TEE.
- *
- * Returns return code from secure world, 0 is OK
- */
-int optee_do_call_with_arg(struct tee_context *ctx, struct tee_shm *arg)
-{
-	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-	struct optee_call_waiter w;
-	struct optee_rpc_param param =3D { };
-	struct optee_call_ctx call_ctx =3D { };
-	phys_addr_t parg;
-	int rc;
-
-	rc =3D tee_shm_get_pa(arg, 0, &parg);
-	if (rc)
-		return rc;
-
-	param.a0 =3D OPTEE_SMC_CALL_WITH_ARG;
-	reg_pair_from_64(&param.a1, &param.a2, parg);
-	/* Initialize waiter */
-	optee_cq_wait_init(&optee->call_queue, &w);
-	while (true) {
-		struct arm_smccc_res res;
-
-		trace_optee_invoke_fn_begin(&param);
-		optee->invoke_fn(param.a0, param.a1, param.a2, param.a3,
-				 param.a4, param.a5, param.a6, param.a7,
-				 &res);
-		trace_optee_invoke_fn_end(&param, &res);
-
-		if (res.a0 =3D=3D OPTEE_SMC_RETURN_ETHREAD_LIMIT) {
-			/*
-			 * Out of threads in secure world, wait for a thread
-			 * become available.
-			 */
-			optee_cq_wait_for_completion(&optee->call_queue, &w);
-		} else if (OPTEE_SMC_RETURN_IS_RPC(res.a0)) {
-			cond_resched();
-			param.a0 =3D res.a0;
-			param.a1 =3D res.a1;
-			param.a2 =3D res.a2;
-			param.a3 =3D res.a3;
-			optee_handle_rpc(ctx, &param, &call_ctx);
-		} else {
-			rc =3D res.a0;
-			break;
-		}
-	}
-
-	optee_rpc_finalize_call(&call_ctx);
-	/*
-	 * We're done with our thread in secure world, if there's any
-	 * thread waiters wake up one.
-	 */
-	optee_cq_wait_final(&optee->call_queue, &w);
-
-	return rc;
-}
-
-static struct tee_shm *get_msg_arg(struct tee_context *ctx, size_t num_param=
s,
-				   struct optee_msg_arg **msg_arg)
+struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
+				  struct optee_msg_arg **msg_arg)
 {
 	struct tee_shm *shm;
 	struct optee_msg_arg *ma;
@@ -217,7 +141,7 @@ int optee_open_session(struct tee_context *ctx,
 	uuid_t client_uuid;
=20
 	/* +2 for the meta parameters added below */
-	shm =3D get_msg_arg(ctx, arg->num_params + 2, &msg_arg);
+	shm =3D optee_get_msg_arg(ctx, arg->num_params + 2, &msg_arg);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
=20
@@ -290,7 +214,7 @@ int optee_close_session_helper(struct tee_context *ctx, u=
32 session)
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
 	struct optee_msg_arg *msg_arg;
=20
-	shm =3D get_msg_arg(ctx, 0, &msg_arg);
+	shm =3D optee_get_msg_arg(ctx, 0, &msg_arg);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
=20
@@ -338,7 +262,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee=
_ioctl_invoke_arg *arg,
 	if (!sess)
 		return -EINVAL;
=20
-	shm =3D get_msg_arg(ctx, arg->num_params, &msg_arg);
+	shm =3D optee_get_msg_arg(ctx, arg->num_params, &msg_arg);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
 	msg_arg->cmd =3D OPTEE_MSG_CMD_INVOKE_COMMAND;
@@ -384,7 +308,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_=
id, u32 session)
 	if (!sess)
 		return -EINVAL;
=20
-	shm =3D get_msg_arg(ctx, 0, &msg_arg);
+	shm =3D optee_get_msg_arg(ctx, 0, &msg_arg);
 	if (IS_ERR(shm))
 		return PTR_ERR(shm);
=20
@@ -397,182 +321,6 @@ int optee_cancel_req(struct tee_context *ctx, u32 cance=
l_id, u32 session)
 	return 0;
 }
=20
-/**
- * optee_enable_shm_cache() - Enables caching of some shared memory allocati=
on
- *			      in OP-TEE
- * @optee:	main service struct
- */
-void optee_enable_shm_cache(struct optee *optee)
-{
-	struct optee_call_waiter w;
-
-	/* We need to retry until secure world isn't busy. */
-	optee_cq_wait_init(&optee->call_queue, &w);
-	while (true) {
-		struct arm_smccc_res res;
-
-		optee->invoke_fn(OPTEE_SMC_ENABLE_SHM_CACHE, 0, 0, 0, 0, 0, 0,
-				 0, &res);
-		if (res.a0 =3D=3D OPTEE_SMC_RETURN_OK)
-			break;
-		optee_cq_wait_for_completion(&optee->call_queue, &w);
-	}
-	optee_cq_wait_final(&optee->call_queue, &w);
-}
-
-/**
- * __optee_disable_shm_cache() - Disables caching of some shared memory
- *                               allocation in OP-TEE
- * @optee:	main service struct
- * @is_mapped:	true if the cached shared memory addresses were mapped by this
- *		kernel, are safe to dereference, and should be freed
- */
-static void __optee_disable_shm_cache(struct optee *optee, bool is_mapped)
-{
-	struct optee_call_waiter w;
-
-	/* We need to retry until secure world isn't busy. */
-	optee_cq_wait_init(&optee->call_queue, &w);
-	while (true) {
-		union {
-			struct arm_smccc_res smccc;
-			struct optee_smc_disable_shm_cache_result result;
-		} res;
-
-		optee->invoke_fn(OPTEE_SMC_DISABLE_SHM_CACHE, 0, 0, 0, 0, 0, 0,
-				 0, &res.smccc);
-		if (res.result.status =3D=3D OPTEE_SMC_RETURN_ENOTAVAIL)
-			break; /* All shm's freed */
-		if (res.result.status =3D=3D OPTEE_SMC_RETURN_OK) {
-			struct tee_shm *shm;
-
-			/*
-			 * Shared memory references that were not mapped by
-			 * this kernel must be ignored to prevent a crash.
-			 */
-			if (!is_mapped)
-				continue;
-
-			shm =3D reg_pair_to_ptr(res.result.shm_upper32,
-					      res.result.shm_lower32);
-			tee_shm_free(shm);
-		} else {
-			optee_cq_wait_for_completion(&optee->call_queue, &w);
-		}
-	}
-	optee_cq_wait_final(&optee->call_queue, &w);
-}
-
-/**
- * optee_disable_shm_cache() - Disables caching of mapped shared memory
- *                             allocations in OP-TEE
- * @optee:	main service struct
- */
-void optee_disable_shm_cache(struct optee *optee)
-{
-	return __optee_disable_shm_cache(optee, true);
-}
-
-/**
- * optee_disable_unmapped_shm_cache() - Disables caching of shared memory
- *                                      allocations in OP-TEE which are not
- *                                      currently mapped
- * @optee:	main service struct
- */
-void optee_disable_unmapped_shm_cache(struct optee *optee)
-{
-	return __optee_disable_shm_cache(optee, false);
-}
-
-#define PAGELIST_ENTRIES_PER_PAGE				\
-	((OPTEE_MSG_NONCONTIG_PAGE_SIZE / sizeof(u64)) - 1)
-
-/**
- * optee_fill_pages_list() - write list of user pages to given shared
- * buffer.
- *
- * @dst: page-aligned buffer where list of pages will be stored
- * @pages: array of pages that represents shared buffer
- * @num_pages: number of entries in @pages
- * @page_offset: offset of user buffer from page start
- *
- * @dst should be big enough to hold list of user page addresses and
- *	links to the next pages of buffer
- */
-void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
-			   size_t page_offset)
-{
-	int n =3D 0;
-	phys_addr_t optee_page;
-	/*
-	 * Refer to OPTEE_MSG_ATTR_NONCONTIG description in optee_msg.h
-	 * for details.
-	 */
-	struct {
-		u64 pages_list[PAGELIST_ENTRIES_PER_PAGE];
-		u64 next_page_data;
-	} *pages_data;
-
-	/*
-	 * Currently OP-TEE uses 4k page size and it does not looks
-	 * like this will change in the future.  On other hand, there are
-	 * no know ARM architectures with page size < 4k.
-	 * Thus the next built assert looks redundant. But the following
-	 * code heavily relies on this assumption, so it is better be
-	 * safe than sorry.
-	 */
-	BUILD_BUG_ON(PAGE_SIZE < OPTEE_MSG_NONCONTIG_PAGE_SIZE);
-
-	pages_data =3D (void *)dst;
-	/*
-	 * If linux page is bigger than 4k, and user buffer offset is
-	 * larger than 4k/8k/12k/etc this will skip first 4k pages,
-	 * because they bear no value data for OP-TEE.
-	 */
-	optee_page =3D page_to_phys(*pages) +
-		round_down(page_offset, OPTEE_MSG_NONCONTIG_PAGE_SIZE);
-
-	while (true) {
-		pages_data->pages_list[n++] =3D optee_page;
-
-		if (n =3D=3D PAGELIST_ENTRIES_PER_PAGE) {
-			pages_data->next_page_data =3D
-				virt_to_phys(pages_data + 1);
-			pages_data++;
-			n =3D 0;
-		}
-
-		optee_page +=3D OPTEE_MSG_NONCONTIG_PAGE_SIZE;
-		if (!(optee_page & ~PAGE_MASK)) {
-			if (!--num_pages)
-				break;
-			pages++;
-			optee_page =3D page_to_phys(*pages);
-		}
-	}
-}
-
-/*
- * The final entry in each pagelist page is a pointer to the next
- * pagelist page.
- */
-static size_t get_pages_list_size(size_t num_entries)
-{
-	int pages =3D DIV_ROUND_UP(num_entries, PAGELIST_ENTRIES_PER_PAGE);
-
-	return pages * OPTEE_MSG_NONCONTIG_PAGE_SIZE;
-}
-
-u64 *optee_allocate_pages_list(size_t num_entries)
-{
-	return alloc_pages_exact(get_pages_list_size(num_entries), GFP_KERNEL);
-}
-
-void optee_free_pages_list(void *list, size_t num_entries)
-{
-	free_pages_exact(list, get_pages_list_size(num_entries));
-}
-
 static bool is_normal_memory(pgprot_t p)
 {
 #if defined(CONFIG_ARM)
@@ -596,7 +344,7 @@ static int __check_mem_type(struct vm_area_struct *vma, u=
nsigned long end)
 	return -EINVAL;
 }
=20
-static int check_mem_type(unsigned long start, size_t num_pages)
+int optee_check_mem_type(unsigned long start, size_t num_pages)
 {
 	struct mm_struct *mm =3D current->mm;
 	int rc;
@@ -615,94 +363,3 @@ static int check_mem_type(unsigned long start, size_t nu=
m_pages)
=20
 	return rc;
 }
-
-int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
-		       struct page **pages, size_t num_pages,
-		       unsigned long start)
-{
-	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-	struct optee_msg_arg *msg_arg;
-	struct tee_shm *shm_arg;
-	u64 *pages_list;
-	int rc;
-
-	if (!num_pages)
-		return -EINVAL;
-
-	rc =3D check_mem_type(start, num_pages);
-	if (rc)
-		return rc;
-
-	pages_list =3D optee_allocate_pages_list(num_pages);
-	if (!pages_list)
-		return -ENOMEM;
-
-	shm_arg =3D get_msg_arg(ctx, 1, &msg_arg);
-	if (IS_ERR(shm_arg)) {
-		rc =3D PTR_ERR(shm_arg);
-		goto out;
-	}
-
-	optee_fill_pages_list(pages_list, pages, num_pages,
-			      tee_shm_get_page_offset(shm));
-
-	msg_arg->cmd =3D OPTEE_MSG_CMD_REGISTER_SHM;
-	msg_arg->params->attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
-				OPTEE_MSG_ATTR_NONCONTIG;
-	msg_arg->params->u.tmem.shm_ref =3D (unsigned long)shm;
-	msg_arg->params->u.tmem.size =3D tee_shm_get_size(shm);
-	/*
-	 * In the least bits of msg_arg->params->u.tmem.buf_ptr we
-	 * store buffer offset from 4k page, as described in OP-TEE ABI.
-	 */
-	msg_arg->params->u.tmem.buf_ptr =3D virt_to_phys(pages_list) |
-	  (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
-
-	if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
-	    msg_arg->ret !=3D TEEC_SUCCESS)
-		rc =3D -EINVAL;
-
-	tee_shm_free(shm_arg);
-out:
-	optee_free_pages_list(pages_list, num_pages);
-	return rc;
-}
-
-int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
-{
-	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
-	struct optee_msg_arg *msg_arg;
-	struct tee_shm *shm_arg;
-	int rc =3D 0;
-
-	shm_arg =3D get_msg_arg(ctx, 1, &msg_arg);
-	if (IS_ERR(shm_arg))
-		return PTR_ERR(shm_arg);
-
-	msg_arg->cmd =3D OPTEE_MSG_CMD_UNREGISTER_SHM;
-
-	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
-	msg_arg->params[0].u.rmem.shm_ref =3D (unsigned long)shm;
-
-	if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
-	    msg_arg->ret !=3D TEEC_SUCCESS)
-		rc =3D -EINVAL;
-	tee_shm_free(shm_arg);
-	return rc;
-}
-
-int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *shm,
-			    struct page **pages, size_t num_pages,
-			    unsigned long start)
-{
-	/*
-	 * We don't want to register supplicant memory in OP-TEE.
-	 * Instead information about it will be passed in RPC code.
-	 */
-	return check_mem_type(start, num_pages);
-}
-
-int optee_shm_unregister_supp(struct tee_context *ctx, struct tee_shm *shm)
-{
-	return 0;
-}
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 50650224e311..9e3b6cdbe371 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -1,260 +1,71 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2015-2021, Linaro Limited
+ * Copyright (c) 2016, EPAM Systems
  */
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
-#include <linux/arm-smccc.h>
 #include <linux/crash_dump.h>
 #include <linux/errno.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
-#include <linux/uaccess.h>
 #include <linux/workqueue.h>
 #include "optee_private.h"
-#include "optee_smc.h"
-#include "shm_pool.h"
=20
-#define DRIVER_NAME "optee"
-
-#define OPTEE_SHM_NUM_PRIV_PAGES	CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
-
-static void from_msg_param_value(struct tee_param *p, u32 attr,
-				 const struct optee_msg_param *mp)
-{
-	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
-		  attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
-	p->u.value.a =3D mp->u.value.a;
-	p->u.value.b =3D mp->u.value.b;
-	p->u.value.c =3D mp->u.value.c;
-}
-
-static int from_msg_param_tmp_mem(struct tee_param *p, u32 attr,
-				  const struct optee_msg_param *mp)
-{
-	struct tee_shm *shm;
-	phys_addr_t pa;
-	int rc;
-
-	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
-		  attr - OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
-	p->u.memref.size =3D mp->u.tmem.size;
-	shm =3D (struct tee_shm *)(unsigned long)mp->u.tmem.shm_ref;
-	if (!shm) {
-		p->u.memref.shm_offs =3D 0;
-		p->u.memref.shm =3D NULL;
-		return 0;
-	}
-
-	rc =3D tee_shm_get_pa(shm, 0, &pa);
-	if (rc)
-		return rc;
-
-	p->u.memref.shm_offs =3D mp->u.tmem.buf_ptr - pa;
-	p->u.memref.shm =3D shm;
-
-	/* Check that the memref is covered by the shm object */
-	if (p->u.memref.size) {
-		size_t o =3D p->u.memref.shm_offs +
-			   p->u.memref.size - 1;
-
-		rc =3D tee_shm_get_pa(shm, o, NULL);
-		if (rc)
-			return rc;
-	}
-
-	return 0;
-}
-
-static void from_msg_param_reg_mem(struct tee_param *p, u32 attr,
-				   const struct optee_msg_param *mp)
+int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
+			       struct tee_shm *shm, size_t size,
+			       int (*shm_register)(struct tee_context *ctx,
+						   struct tee_shm *shm,
+						   struct page **pages,
+						   size_t num_pages,
+						   unsigned long start))
 {
-	struct tee_shm *shm;
+	unsigned int order =3D get_order(size);
+	struct page *page;
+	int rc =3D 0;
=20
-	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
-		  attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
-	p->u.memref.size =3D mp->u.rmem.size;
-	shm =3D (struct tee_shm *)(unsigned long)mp->u.rmem.shm_ref;
-
-	if (shm) {
-		p->u.memref.shm_offs =3D mp->u.rmem.offs;
-		p->u.memref.shm =3D shm;
-	} else {
-		p->u.memref.shm_offs =3D 0;
-		p->u.memref.shm =3D NULL;
-	}
-}
-
-/**
- * optee_from_msg_param() - convert from OPTEE_MSG parameters to
- *			    struct tee_param
- * @optee:	main service struct
- * @params:	subsystem internal parameter representation
- * @num_params:	number of elements in the parameter arrays
- * @msg_params:	OPTEE_MSG parameters
- * Returns 0 on success or <0 on failure
- */
-static int optee_from_msg_param(struct optee *optee, struct tee_param *param=
s,
-				size_t num_params,
-				const struct optee_msg_param *msg_params)
-{
-	int rc;
-	size_t n;
+	page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!page)
+		return -ENOMEM;
=20
-	for (n =3D 0; n < num_params; n++) {
-		struct tee_param *p =3D params + n;
-		const struct optee_msg_param *mp =3D msg_params + n;
-		u32 attr =3D mp->attr & OPTEE_MSG_ATTR_TYPE_MASK;
+	shm->kaddr =3D page_address(page);
+	shm->paddr =3D page_to_phys(page);
+	shm->size =3D PAGE_SIZE << order;
=20
-		switch (attr) {
-		case OPTEE_MSG_ATTR_TYPE_NONE:
-			p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
-			memset(&p->u, 0, sizeof(p->u));
-			break;
-		case OPTEE_MSG_ATTR_TYPE_VALUE_INPUT:
-		case OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT:
-		case OPTEE_MSG_ATTR_TYPE_VALUE_INOUT:
-			from_msg_param_value(p, attr, mp);
-			break;
-		case OPTEE_MSG_ATTR_TYPE_TMEM_INPUT:
-		case OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT:
-		case OPTEE_MSG_ATTR_TYPE_TMEM_INOUT:
-			rc =3D from_msg_param_tmp_mem(p, attr, mp);
-			if (rc)
-				return rc;
-			break;
-		case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
-		case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
-		case OPTEE_MSG_ATTR_TYPE_RMEM_INOUT:
-			from_msg_param_reg_mem(p, attr, mp);
-			break;
+	if (shm_register) {
+		unsigned int nr_pages =3D 1 << order, i;
+		struct page **pages;
=20
-		default:
-			return -EINVAL;
+		pages =3D kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
+		if (!pages) {
+			rc =3D -ENOMEM;
+			goto err;
 		}
-	}
-	return 0;
-}
-
-static void to_msg_param_value(struct optee_msg_param *mp,
-			       const struct tee_param *p)
-{
-	mp->attr =3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
-		   TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
-	mp->u.value.a =3D p->u.value.a;
-	mp->u.value.b =3D p->u.value.b;
-	mp->u.value.c =3D p->u.value.c;
-}
-
-static int to_msg_param_tmp_mem(struct optee_msg_param *mp,
-				const struct tee_param *p)
-{
-	int rc;
-	phys_addr_t pa;
=20
-	mp->attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_INPUT + p->attr -
-		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
-
-	mp->u.tmem.shm_ref =3D (unsigned long)p->u.memref.shm;
-	mp->u.tmem.size =3D p->u.memref.size;
+		for (i =3D 0; i < nr_pages; i++) {
+			pages[i] =3D page;
+			page++;
+		}
=20
-	if (!p->u.memref.shm) {
-		mp->u.tmem.buf_ptr =3D 0;
-		return 0;
+		shm->flags |=3D TEE_SHM_REGISTER;
+		rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
+				  (unsigned long)shm->kaddr);
+		kfree(pages);
+		if (rc)
+			goto err;
 	}
=20
-	rc =3D tee_shm_get_pa(p->u.memref.shm, p->u.memref.shm_offs, &pa);
-	if (rc)
-		return rc;
-
-	mp->u.tmem.buf_ptr =3D pa;
-	mp->attr |=3D OPTEE_MSG_ATTR_CACHE_PREDEFINED <<
-		    OPTEE_MSG_ATTR_CACHE_SHIFT;
-
-	return 0;
-}
-
-static int to_msg_param_reg_mem(struct optee_msg_param *mp,
-				const struct tee_param *p)
-{
-	mp->attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT + p->attr -
-		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
-
-	mp->u.rmem.shm_ref =3D (unsigned long)p->u.memref.shm;
-	mp->u.rmem.size =3D p->u.memref.size;
-	mp->u.rmem.offs =3D p->u.memref.shm_offs;
-	return 0;
-}
-
-/**
- * optee_to_msg_param() - convert from struct tee_params to OPTEE_MSG parame=
ters
- * @optee:	main service struct
- * @msg_params:	OPTEE_MSG parameters
- * @num_params:	number of elements in the parameter arrays
- * @params:	subsystem itnernal parameter representation
- * Returns 0 on success or <0 on failure
- */
-static int optee_to_msg_param(struct optee *optee,
-			      struct optee_msg_param *msg_params,
-			      size_t num_params, const struct tee_param *params)
-{
-	int rc;
-	size_t n;
-
-	for (n =3D 0; n < num_params; n++) {
-		const struct tee_param *p =3D params + n;
-		struct optee_msg_param *mp =3D msg_params + n;
-
-		switch (p->attr) {
-		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
-			mp->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
-			memset(&mp->u, 0, sizeof(mp->u));
-			break;
-		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
-		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
-		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
-			to_msg_param_value(mp, p);
-			break;
-		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
-		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
-		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
-			if (tee_shm_is_registered(p->u.memref.shm))
-				rc =3D to_msg_param_reg_mem(mp, p);
-			else
-				rc =3D to_msg_param_tmp_mem(mp, p);
-			if (rc)
-				return rc;
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
 	return 0;
-}
=20
-static void optee_get_version(struct tee_device *teedev,
-			      struct tee_ioctl_version_data *vers)
-{
-	struct tee_ioctl_version_data v =3D {
-		.impl_id =3D TEE_IMPL_ID_OPTEE,
-		.impl_caps =3D TEE_OPTEE_CAP_TZ,
-		.gen_caps =3D TEE_GEN_CAP_GP,
-	};
-	struct optee *optee =3D tee_get_drvdata(teedev);
-
-	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
-		v.gen_caps |=3D TEE_GEN_CAP_REG_MEM;
-	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
-		v.gen_caps |=3D TEE_GEN_CAP_MEMREF_NULL;
-	*vers =3D v;
+err:
+	__free_pages(page, order);
+	return rc;
 }
=20
 static void optee_bus_scan(struct work_struct *work)
@@ -262,7 +73,7 @@ static void optee_bus_scan(struct work_struct *work)
 	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
 }
=20
-static int optee_open(struct tee_context *ctx)
+int optee_open(struct tee_context *ctx, bool cap_memref_null)
 {
 	struct optee_context_data *ctxdata;
 	struct tee_device *teedev =3D ctx->teedev;
@@ -300,11 +111,7 @@ static int optee_open(struct tee_context *ctx)
 	mutex_init(&ctxdata->mutex);
 	INIT_LIST_HEAD(&ctxdata->sess_list);
=20
-	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
-		ctx->cap_memref_null  =3D true;
-	else
-		ctx->cap_memref_null =3D false;
-
+	ctx->cap_memref_null =3D cap_memref_null;
 	ctx->data =3D ctxdata;
 	return 0;
 }
@@ -330,12 +137,12 @@ static void optee_release_helper(struct tee_context *ct=
x,
 	ctx->data =3D NULL;
 }
=20
-static void optee_release(struct tee_context *ctx)
+void optee_release(struct tee_context *ctx)
 {
 	optee_release_helper(ctx, optee_close_session_helper);
 }
=20
-static void optee_release_supp(struct tee_context *ctx)
+void optee_release_supp(struct tee_context *ctx)
 {
 	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
=20
@@ -347,284 +154,8 @@ static void optee_release_supp(struct tee_context *ctx)
 	optee_supp_release(&optee->supp);
 }
=20
-static const struct tee_driver_ops optee_clnt_ops =3D {
-	.get_version =3D optee_get_version,
-	.open =3D optee_open,
-	.release =3D optee_release,
-	.open_session =3D optee_open_session,
-	.close_session =3D optee_close_session,
-	.invoke_func =3D optee_invoke_func,
-	.cancel_req =3D optee_cancel_req,
-	.shm_register =3D optee_shm_register,
-	.shm_unregister =3D optee_shm_unregister,
-};
-
-static const struct tee_desc optee_clnt_desc =3D {
-	.name =3D DRIVER_NAME "-clnt",
-	.ops =3D &optee_clnt_ops,
-	.owner =3D THIS_MODULE,
-};
-
-static const struct tee_driver_ops optee_supp_ops =3D {
-	.get_version =3D optee_get_version,
-	.open =3D optee_open,
-	.release =3D optee_release_supp,
-	.supp_recv =3D optee_supp_recv,
-	.supp_send =3D optee_supp_send,
-	.shm_register =3D optee_shm_register_supp,
-	.shm_unregister =3D optee_shm_unregister_supp,
-};
-
-static const struct tee_desc optee_supp_desc =3D {
-	.name =3D DRIVER_NAME "-supp",
-	.ops =3D &optee_supp_ops,
-	.owner =3D THIS_MODULE,
-	.flags =3D TEE_DESC_PRIVILEGED,
-};
-
-static const struct optee_ops optee_ops =3D {
-	.do_call_with_arg =3D optee_do_call_with_arg,
-	.to_msg_param =3D optee_to_msg_param,
-	.from_msg_param =3D optee_from_msg_param,
-};
-
-static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
-{
-	struct arm_smccc_res res;
-
-	invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
-
-	if (res.a0 =3D=3D OPTEE_MSG_UID_0 && res.a1 =3D=3D OPTEE_MSG_UID_1 &&
-	    res.a2 =3D=3D OPTEE_MSG_UID_2 && res.a3 =3D=3D OPTEE_MSG_UID_3)
-		return true;
-	return false;
-}
-
-static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
-{
-	union {
-		struct arm_smccc_res smccc;
-		struct optee_smc_call_get_os_revision_result result;
-	} res =3D {
-		.result =3D {
-			.build_id =3D 0
-		}
-	};
-
-	invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
-		  &res.smccc);
-
-	if (res.result.build_id)
-		pr_info("revision %lu.%lu (%08lx)", res.result.major,
-			res.result.minor, res.result.build_id);
-	else
-		pr_info("revision %lu.%lu", res.result.major, res.result.minor);
-}
-
-static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
-{
-	union {
-		struct arm_smccc_res smccc;
-		struct optee_smc_calls_revision_result result;
-	} res;
-
-	invoke_fn(OPTEE_SMC_CALLS_REVISION, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
-
-	if (res.result.major =3D=3D OPTEE_MSG_REVISION_MAJOR &&
-	    (int)res.result.minor >=3D OPTEE_MSG_REVISION_MINOR)
-		return true;
-	return false;
-}
-
-static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
-					    u32 *sec_caps)
-{
-	union {
-		struct arm_smccc_res smccc;
-		struct optee_smc_exchange_capabilities_result result;
-	} res;
-	u32 a1 =3D 0;
-
-	/*
-	 * TODO This isn't enough to tell if it's UP system (from kernel
-	 * point of view) or not, is_smp() returns the the information
-	 * needed, but can't be called directly from here.
-	 */
-	if (!IS_ENABLED(CONFIG_SMP) || nr_cpu_ids =3D=3D 1)
-		a1 |=3D OPTEE_SMC_NSEC_CAP_UNIPROCESSOR;
-
-	invoke_fn(OPTEE_SMC_EXCHANGE_CAPABILITIES, a1, 0, 0, 0, 0, 0, 0,
-		  &res.smccc);
-
-	if (res.result.status !=3D OPTEE_SMC_RETURN_OK)
-		return false;
-
-	*sec_caps =3D res.result.capabilities;
-	return true;
-}
-
-static struct tee_shm_pool *optee_config_dyn_shm(void)
-{
-	struct tee_shm_pool_mgr *priv_mgr;
-	struct tee_shm_pool_mgr *dmabuf_mgr;
-	void *rc;
-
-	rc =3D optee_shm_pool_alloc_pages();
-	if (IS_ERR(rc))
-		return rc;
-	priv_mgr =3D rc;
-
-	rc =3D optee_shm_pool_alloc_pages();
-	if (IS_ERR(rc)) {
-		tee_shm_pool_mgr_destroy(priv_mgr);
-		return rc;
-	}
-	dmabuf_mgr =3D rc;
-
-	rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
-	if (IS_ERR(rc)) {
-		tee_shm_pool_mgr_destroy(priv_mgr);
-		tee_shm_pool_mgr_destroy(dmabuf_mgr);
-	}
-
-	return rc;
-}
-
-static struct tee_shm_pool *
-optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
+void optee_remove_common(struct optee *optee)
 {
-	union {
-		struct arm_smccc_res smccc;
-		struct optee_smc_get_shm_config_result result;
-	} res;
-	unsigned long vaddr;
-	phys_addr_t paddr;
-	size_t size;
-	phys_addr_t begin;
-	phys_addr_t end;
-	void *va;
-	struct tee_shm_pool_mgr *priv_mgr;
-	struct tee_shm_pool_mgr *dmabuf_mgr;
-	void *rc;
-	const int sz =3D OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
-
-	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
-	if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
-		pr_err("static shm service not available\n");
-		return ERR_PTR(-ENOENT);
-	}
-
-	if (res.result.settings !=3D OPTEE_SMC_SHM_CACHED) {
-		pr_err("only normal cached shared memory supported\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	begin =3D roundup(res.result.start, PAGE_SIZE);
-	end =3D rounddown(res.result.start + res.result.size, PAGE_SIZE);
-	paddr =3D begin;
-	size =3D end - begin;
-
-	if (size < 2 * OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE) {
-		pr_err("too small shared memory area\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	va =3D memremap(paddr, size, MEMREMAP_WB);
-	if (!va) {
-		pr_err("shared memory ioremap failed\n");
-		return ERR_PTR(-EINVAL);
-	}
-	vaddr =3D (unsigned long)va;
-
-	rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
-					    3 /* 8 bytes aligned */);
-	if (IS_ERR(rc))
-		goto err_memunmap;
-	priv_mgr =3D rc;
-
-	vaddr +=3D sz;
-	paddr +=3D sz;
-	size -=3D sz;
-
-	rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
-	if (IS_ERR(rc))
-		goto err_free_priv_mgr;
-	dmabuf_mgr =3D rc;
-
-	rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
-	if (IS_ERR(rc))
-		goto err_free_dmabuf_mgr;
-
-	*memremaped_shm =3D va;
-
-	return rc;
-
-err_free_dmabuf_mgr:
-	tee_shm_pool_mgr_destroy(dmabuf_mgr);
-err_free_priv_mgr:
-	tee_shm_pool_mgr_destroy(priv_mgr);
-err_memunmap:
-	memunmap(va);
-	return rc;
-}
-
-/* Simple wrapper functions to be able to use a function pointer */
-static void optee_smccc_smc(unsigned long a0, unsigned long a1,
-			    unsigned long a2, unsigned long a3,
-			    unsigned long a4, unsigned long a5,
-			    unsigned long a6, unsigned long a7,
-			    struct arm_smccc_res *res)
-{
-	arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res);
-}
-
-static void optee_smccc_hvc(unsigned long a0, unsigned long a1,
-			    unsigned long a2, unsigned long a3,
-			    unsigned long a4, unsigned long a5,
-			    unsigned long a6, unsigned long a7,
-			    struct arm_smccc_res *res)
-{
-	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
-}
-
-static optee_invoke_fn *get_invoke_func(struct device *dev)
-{
-	const char *method;
-
-	pr_info("probing for conduit method.\n");
-
-	if (device_property_read_string(dev, "method", &method)) {
-		pr_warn("missing \"method\" property\n");
-		return ERR_PTR(-ENXIO);
-	}
-
-	if (!strcmp("hvc", method))
-		return optee_smccc_hvc;
-	else if (!strcmp("smc", method))
-		return optee_smccc_smc;
-
-	pr_warn("invalid \"method\" property: %s\n", method);
-	return ERR_PTR(-EINVAL);
-}
-
-/* optee_remove - Device Removal Routine
- * @pdev: platform device information struct
- *
- * optee_remove is called by platform subsystem to alert the driver
- * that it should release the device
- */
-
-static int optee_remove(struct platform_device *pdev)
-{
-	struct optee *optee =3D platform_get_drvdata(pdev);
-
-	/*
-	 * Ask OP-TEE to free all cached shared memory objects to decrease
-	 * reference counters and also avoid wild pointers in secure world
-	 * into the old shared memory range.
-	 */
-	optee_disable_shm_cache(optee);
-
 	/*
 	 * The two devices have to be unregistered before we can free the
 	 * other resources.
@@ -633,39 +164,13 @@ static int optee_remove(struct platform_device *pdev)
 	tee_device_unregister(optee->teedev);
=20
 	tee_shm_pool_free(optee->pool);
-	if (optee->memremaped_shm)
-		memunmap(optee->memremaped_shm);
 	optee_wait_queue_exit(&optee->wait_queue);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
-
-	kfree(optee);
-
-	return 0;
-}
-
-/* optee_shutdown - Device Removal Routine
- * @pdev: platform device information struct
- *
- * platform_shutdown is called by the platform subsystem to alert
- * the driver that a shutdown, reboot, or kexec is happening and
- * device must be disabled.
- */
-static void optee_shutdown(struct platform_device *pdev)
-{
-	optee_disable_shm_cache(platform_get_drvdata(pdev));
 }
=20
-static int optee_probe(struct platform_device *pdev)
+static int optee_core_init(void)
 {
-	optee_invoke_fn *invoke_fn;
-	struct tee_shm_pool *pool =3D ERR_PTR(-EINVAL);
-	struct optee *optee =3D NULL;
-	void *memremaped_shm =3D NULL;
-	struct tee_device *teedev;
-	u32 sec_caps;
-	int rc;
-
 	/*
 	 * The kernel may have crashed at the same time that all available
 	 * secure world threads were suspended and we cannot reschedule the
@@ -676,139 +181,15 @@ static int optee_probe(struct platform_device *pdev)
 	if (is_kdump_kernel())
 		return -ENODEV;
=20
-	invoke_fn =3D get_invoke_func(&pdev->dev);
-	if (IS_ERR(invoke_fn))
-		return PTR_ERR(invoke_fn);
-
-	if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
-		pr_warn("api uid mismatch\n");
-		return -EINVAL;
-	}
-
-	optee_msg_get_os_revision(invoke_fn);
-
-	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
-		pr_warn("api revision mismatch\n");
-		return -EINVAL;
-	}
-
-	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps)) {
-		pr_warn("capabilities mismatch\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Try to use dynamic shared memory if possible
-	 */
-	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
-		pool =3D optee_config_dyn_shm();
-
-	/*
-	 * If dynamic shared memory is not available or failed - try static one
-	 */
-	if (IS_ERR(pool) && (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
-		pool =3D optee_config_shm_memremap(invoke_fn, &memremaped_shm);
-
-	if (IS_ERR(pool))
-		return PTR_ERR(pool);
-
-	optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
-	if (!optee) {
-		rc =3D -ENOMEM;
-		goto err;
-	}
-
-	optee->ops =3D &optee_ops;
-	optee->invoke_fn =3D invoke_fn;
-	optee->sec_caps =3D sec_caps;
-
-	teedev =3D tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
-	if (IS_ERR(teedev)) {
-		rc =3D PTR_ERR(teedev);
-		goto err;
-	}
-	optee->teedev =3D teedev;
-
-	teedev =3D tee_device_alloc(&optee_supp_desc, NULL, pool, optee);
-	if (IS_ERR(teedev)) {
-		rc =3D PTR_ERR(teedev);
-		goto err;
-	}
-	optee->supp_teedev =3D teedev;
-
-	rc =3D tee_device_register(optee->teedev);
-	if (rc)
-		goto err;
-
-	rc =3D tee_device_register(optee->supp_teedev);
-	if (rc)
-		goto err;
-
-	mutex_init(&optee->call_queue.mutex);
-	INIT_LIST_HEAD(&optee->call_queue.waiters);
-	optee_wait_queue_init(&optee->wait_queue);
-	optee_supp_init(&optee->supp);
-	optee->memremaped_shm =3D memremaped_shm;
-	optee->pool =3D pool;
-
-	/*
-	 * Ensure that there are no pre-existing shm objects before enabling
-	 * the shm cache so that there's no chance of receiving an invalid
-	 * address during shutdown. This could occur, for example, if we're
-	 * kexec booting from an older kernel that did not properly cleanup the
-	 * shm cache.
-	 */
-	optee_disable_unmapped_shm_cache(optee);
-
-	optee_enable_shm_cache(optee);
-
-	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
-		pr_info("dynamic shared memory is enabled\n");
-
-	platform_set_drvdata(pdev, optee);
-
-	rc =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES);
-	if (rc) {
-		optee_remove(pdev);
-		return rc;
-	}
-
-	pr_info("initialized driver\n");
-	return 0;
-err:
-	if (optee) {
-		/*
-		 * tee_device_unregister() is safe to call even if the
-		 * devices hasn't been registered with
-		 * tee_device_register() yet.
-		 */
-		tee_device_unregister(optee->supp_teedev);
-		tee_device_unregister(optee->teedev);
-		kfree(optee);
-	}
-	if (pool)
-		tee_shm_pool_free(pool);
-	if (memremaped_shm)
-		memunmap(memremaped_shm);
-	return rc;
+	return optee_smc_abi_register();
 }
+module_init(optee_core_init);
=20
-static const struct of_device_id optee_dt_match[] =3D {
-	{ .compatible =3D "linaro,optee-tz" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, optee_dt_match);
-
-static struct platform_driver optee_driver =3D {
-	.probe  =3D optee_probe,
-	.remove =3D optee_remove,
-	.shutdown =3D optee_shutdown,
-	.driver =3D {
-		.name =3D "optee",
-		.of_match_table =3D optee_dt_match,
-	},
-};
-module_platform_driver(optee_driver);
+static void optee_core_exit(void)
+{
+	optee_smc_abi_unregister();
+}
+module_exit(optee_core_exit);
=20
 MODULE_AUTHOR("Linaro");
 MODULE_DESCRIPTION("OP-TEE driver");
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 92d59c145d4a..ca0213e330b5 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -12,6 +12,8 @@
 #include <linux/types.h>
 #include "optee_msg.h"
=20
+#define DRIVER_NAME "optee"
+
 #define OPTEE_MAX_ARG_SIZE	1024
=20
 /* Some Global Platform error codes used in this driver */
@@ -29,6 +31,11 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned lon=
g, unsigned long,
 				unsigned long, unsigned long,
 				struct arm_smccc_res *);
=20
+struct optee_call_waiter {
+	struct list_head list_node;
+	struct completion c;
+};
+
 struct optee_call_queue {
 	/* Serializes access to this struct */
 	struct mutex mutex;
@@ -66,6 +73,19 @@ struct optee_supp {
 	struct completion reqs_c;
 };
=20
+/**
+ * struct optee_smc - SMC ABI specifics
+ * @invoke_fn:		function to issue smc or hvc
+ * @memremaped_shm	virtual address of memory in shared memory pool
+ * @sec_caps:		secure world capabilities defined by
+ *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
+ */
+struct optee_smc {
+	optee_invoke_fn *invoke_fn;
+	void *memremaped_shm;
+	u32 sec_caps;
+};
+
 struct optee;
=20
 /**
@@ -95,15 +115,12 @@ struct optee_ops {
  * @ops:		internal callbacks for different ways to reach secure
  *			world
  * @teedev:		client device
- * @invoke_fn:		function to issue smc or hvc
+ * @smc:		specific to SMC ABI
  * @call_queue:		queue of threads waiting to call @invoke_fn
  * @wait_queue:		queue of threads from secure world waiting for a
  *			secure world sync object
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
- * @memremaped_shm	virtual address of memory in shared memory pool
- * @sec_caps:		secure world capabilities defined by
- *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
  * @scan_bus_done	flag if device registation was already done.
  * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
  * @scan_bus_work	workq to scan optee bus and register optee drivers
@@ -112,13 +129,11 @@ struct optee {
 	struct tee_device *supp_teedev;
 	struct tee_device *teedev;
 	const struct optee_ops *ops;
-	optee_invoke_fn *invoke_fn;
+	struct optee_smc smc;
 	struct optee_call_queue call_queue;
 	struct optee_wait_queue wait_queue;
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
-	void *memremaped_shm;
-	u32 sec_caps;
 	bool   scan_bus_done;
 	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
@@ -153,10 +168,6 @@ struct optee_call_ctx {
 	size_t num_entries;
 };
=20
-void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
-		      struct optee_call_ctx *call_ctx);
-void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx);
-
 void optee_wait_queue_init(struct optee_wait_queue *wq);
 void optee_wait_queue_exit(struct optee_wait_queue *wq);
=20
@@ -174,7 +185,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u=
32 *num_params,
 int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 		    struct tee_param *param);
=20
-int optee_do_call_with_arg(struct tee_context *ctx, struct tee_shm *arg);
 int optee_open_session(struct tee_context *ctx,
 		       struct tee_ioctl_open_session_arg *arg,
 		       struct tee_param *param);
@@ -184,28 +194,58 @@ int optee_invoke_func(struct tee_context *ctx, struct t=
ee_ioctl_invoke_arg *arg,
 		      struct tee_param *param);
 int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
=20
-void optee_enable_shm_cache(struct optee *optee);
-void optee_disable_shm_cache(struct optee *optee);
-void optee_disable_unmapped_shm_cache(struct optee *optee);
+#define PTA_CMD_GET_DEVICES		0x0
+#define PTA_CMD_GET_DEVICES_SUPP	0x1
+int optee_enumerate_devices(u32 func);
=20
-int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
-		       struct page **pages, size_t num_pages,
-		       unsigned long start);
-int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm);
+int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
+			       struct tee_shm *shm, size_t size,
+			       int (*shm_register)(struct tee_context *ctx,
+						   struct tee_shm *shm,
+						   struct page **pages,
+						   size_t num_pages,
+						   unsigned long start));
=20
-int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *shm,
-			    struct page **pages, size_t num_pages,
-			    unsigned long start);
-int optee_shm_unregister_supp(struct tee_context *ctx, struct tee_shm *shm);
=20
-u64 *optee_allocate_pages_list(size_t num_entries);
-void optee_free_pages_list(void *array, size_t num_entries);
-void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
-			   size_t page_offset);
+void optee_remove_common(struct optee *optee);
+int optee_open(struct tee_context *ctx, bool cap_memref_null);
+void optee_release(struct tee_context *ctx);
+void optee_release_supp(struct tee_context *ctx);
=20
-#define PTA_CMD_GET_DEVICES		0x0
-#define PTA_CMD_GET_DEVICES_SUPP	0x1
-int optee_enumerate_devices(u32 func);
+static inline void optee_from_msg_param_value(struct tee_param *p, u32 attr,
+					      const struct optee_msg_param *mp)
+{
+	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
+		  attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+	p->u.value.a =3D mp->u.value.a;
+	p->u.value.b =3D mp->u.value.b;
+	p->u.value.c =3D mp->u.value.c;
+}
+
+static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
+					    const struct tee_param *p)
+{
+	mp->attr =3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
+		   TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	mp->u.value.a =3D p->u.value.a;
+	mp->u.value.b =3D p->u.value.b;
+	mp->u.value.c =3D p->u.value.c;
+}
+
+void optee_cq_wait_init(struct optee_call_queue *cq,
+			struct optee_call_waiter *w);
+void optee_cq_wait_for_completion(struct optee_call_queue *cq,
+				  struct optee_call_waiter *w);
+void optee_cq_wait_final(struct optee_call_queue *cq,
+			 struct optee_call_waiter *w);
+int optee_check_mem_type(unsigned long start, size_t num_pages);
+struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
+				  struct optee_msg_arg **msg_arg);
+
+struct tee_shm *optee_rpc_cmd_alloc_suppl(struct tee_context *ctx, size_t sz=
);
+void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm);
+void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
+		   struct optee_msg_arg *arg);
=20
 /*
  * Small helpers
@@ -222,4 +262,8 @@ static inline void reg_pair_from_64(u32 *reg0, u32 *reg1,=
 u64 val)
 	*reg1 =3D val;
 }
=20
+/* Registration of the ABIs */
+int optee_smc_abi_register(void);
+void optee_smc_abi_unregister(void);
+
 #endif /*OPTEE_PRIVATE_H*/
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 309258d47790..cd642e340eaf 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -6,12 +6,10 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include "optee_private.h"
-#include "optee_smc.h"
 #include "optee_rpc_cmd.h"
=20
 struct wq_entry {
@@ -266,7 +264,7 @@ static void handle_rpc_supp_cmd(struct tee_context *ctx, =
struct optee *optee,
 	kfree(params);
 }
=20
-static struct tee_shm *cmd_alloc_suppl(struct tee_context *ctx, size_t sz)
+struct tee_shm *optee_rpc_cmd_alloc_suppl(struct tee_context *ctx, size_t sz)
 {
 	u32 ret;
 	struct tee_param param;
@@ -289,103 +287,7 @@ static struct tee_shm *cmd_alloc_suppl(struct tee_conte=
xt *ctx, size_t sz)
 	return shm;
 }
=20
-static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
-					  struct optee_msg_arg *arg,
-					  struct optee_call_ctx *call_ctx)
-{
-	phys_addr_t pa;
-	struct tee_shm *shm;
-	size_t sz;
-	size_t n;
-
-	arg->ret_origin =3D TEEC_ORIGIN_COMMS;
-
-	if (!arg->num_params ||
-	    arg->params[0].attr !=3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT) {
-		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
-		return;
-	}
-
-	for (n =3D 1; n < arg->num_params; n++) {
-		if (arg->params[n].attr !=3D OPTEE_MSG_ATTR_TYPE_NONE) {
-			arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
-			return;
-		}
-	}
-
-	sz =3D arg->params[0].u.value.b;
-	switch (arg->params[0].u.value.a) {
-	case OPTEE_RPC_SHM_TYPE_APPL:
-		shm =3D cmd_alloc_suppl(ctx, sz);
-		break;
-	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		shm =3D tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED | TEE_SHM_PRIV);
-		break;
-	default:
-		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
-		return;
-	}
-
-	if (IS_ERR(shm)) {
-		arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
-		return;
-	}
-
-	if (tee_shm_get_pa(shm, 0, &pa)) {
-		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
-		goto bad;
-	}
-
-	sz =3D tee_shm_get_size(shm);
-
-	if (tee_shm_is_registered(shm)) {
-		struct page **pages;
-		u64 *pages_list;
-		size_t page_num;
-
-		pages =3D tee_shm_get_pages(shm, &page_num);
-		if (!pages || !page_num) {
-			arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
-			goto bad;
-		}
-
-		pages_list =3D optee_allocate_pages_list(page_num);
-		if (!pages_list) {
-			arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
-			goto bad;
-		}
-
-		call_ctx->pages_list =3D pages_list;
-		call_ctx->num_entries =3D page_num;
-
-		arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
-				      OPTEE_MSG_ATTR_NONCONTIG;
-		/*
-		 * In the least bits of u.tmem.buf_ptr we store buffer offset
-		 * from 4k page, as described in OP-TEE ABI.
-		 */
-		arg->params[0].u.tmem.buf_ptr =3D virt_to_phys(pages_list) |
-			(tee_shm_get_page_offset(shm) &
-			 (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
-		arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
-		arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
-
-		optee_fill_pages_list(pages_list, pages, page_num,
-				      tee_shm_get_page_offset(shm));
-	} else {
-		arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
-		arg->params[0].u.tmem.buf_ptr =3D pa;
-		arg->params[0].u.tmem.size =3D sz;
-		arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
-	}
-
-	arg->ret =3D TEEC_SUCCESS;
-	return;
-bad:
-	tee_shm_free(shm);
-}
-
-static void cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
+void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
 {
 	struct tee_param param;
=20
@@ -410,60 +312,9 @@ static void cmd_free_suppl(struct tee_context *ctx, stru=
ct tee_shm *shm)
 	optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
 }
=20
-static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
-					 struct optee_msg_arg *arg)
-{
-	struct tee_shm *shm;
-
-	arg->ret_origin =3D TEEC_ORIGIN_COMMS;
-
-	if (arg->num_params !=3D 1 ||
-	    arg->params[0].attr !=3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT) {
-		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
-		return;
-	}
-
-	shm =3D (struct tee_shm *)(unsigned long)arg->params[0].u.value.b;
-	switch (arg->params[0].u.value.a) {
-	case OPTEE_RPC_SHM_TYPE_APPL:
-		cmd_free_suppl(ctx, shm);
-		break;
-	case OPTEE_RPC_SHM_TYPE_KERNEL:
-		tee_shm_free(shm);
-		break;
-	default:
-		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
-	}
-	arg->ret =3D TEEC_SUCCESS;
-}
-
-static void free_pages_list(struct optee_call_ctx *call_ctx)
-{
-	if (call_ctx->pages_list) {
-		optee_free_pages_list(call_ctx->pages_list,
-				      call_ctx->num_entries);
-		call_ctx->pages_list =3D NULL;
-		call_ctx->num_entries =3D 0;
-	}
-}
-
-void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx)
-{
-	free_pages_list(call_ctx);
-}
-
-static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
-				struct tee_shm *shm,
-				struct optee_call_ctx *call_ctx)
+void optee_rpc_cmd(struct tee_context *ctx, struct optee *optee,
+		   struct optee_msg_arg *arg)
 {
-	struct optee_msg_arg *arg;
-
-	arg =3D tee_shm_get_va(shm, 0);
-	if (IS_ERR(arg)) {
-		pr_err("%s: tee_shm_get_va %p failed\n", __func__, shm);
-		return;
-	}
-
 	switch (arg->cmd) {
 	case OPTEE_RPC_CMD_GET_TIME:
 		handle_rpc_func_cmd_get_time(arg);
@@ -474,13 +325,6 @@ static void handle_rpc_func_cmd(struct tee_context *ctx,=
 struct optee *optee,
 	case OPTEE_RPC_CMD_SUSPEND:
 		handle_rpc_func_cmd_wait(arg);
 		break;
-	case OPTEE_RPC_CMD_SHM_ALLOC:
-		free_pages_list(call_ctx);
-		handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
-		break;
-	case OPTEE_RPC_CMD_SHM_FREE:
-		handle_rpc_func_cmd_shm_free(ctx, arg);
-		break;
 	case OPTEE_RPC_CMD_I2C_TRANSFER:
 		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
 		break;
@@ -489,58 +333,4 @@ static void handle_rpc_func_cmd(struct tee_context *ctx,=
 struct optee *optee,
 	}
 }
=20
-/**
- * optee_handle_rpc() - handle RPC from secure world
- * @ctx:	context doing the RPC
- * @param:	value of registers for the RPC
- * @call_ctx:	call context. Preserved during one OP-TEE invocation
- *
- * Result of RPC is written back into @param.
- */
-void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
-		      struct optee_call_ctx *call_ctx)
-{
-	struct tee_device *teedev =3D ctx->teedev;
-	struct optee *optee =3D tee_get_drvdata(teedev);
-	struct tee_shm *shm;
-	phys_addr_t pa;
-
-	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
-	case OPTEE_SMC_RPC_FUNC_ALLOC:
-		shm =3D tee_shm_alloc(ctx, param->a1,
-				    TEE_SHM_MAPPED | TEE_SHM_PRIV);
-		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
-			reg_pair_from_64(&param->a1, &param->a2, pa);
-			reg_pair_from_64(&param->a4, &param->a5,
-					 (unsigned long)shm);
-		} else {
-			param->a1 =3D 0;
-			param->a2 =3D 0;
-			param->a4 =3D 0;
-			param->a5 =3D 0;
-		}
-		break;
-	case OPTEE_SMC_RPC_FUNC_FREE:
-		shm =3D reg_pair_to_ptr(param->a1, param->a2);
-		tee_shm_free(shm);
-		break;
-	case OPTEE_SMC_RPC_FUNC_FOREIGN_INTR:
-		/*
-		 * A foreign interrupt was raised while secure world was
-		 * executing, since they are handled in Linux a dummy RPC is
-		 * performed to let Linux take the interrupt through the normal
-		 * vector.
-		 */
-		break;
-	case OPTEE_SMC_RPC_FUNC_CMD:
-		shm =3D reg_pair_to_ptr(param->a1, param->a2);
-		handle_rpc_func_cmd(ctx, optee, shm, call_ctx);
-		break;
-	default:
-		pr_warn("Unknown RPC func 0x%x\n",
-			(u32)OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0));
-		break;
-	}
=20
-	param->a0 =3D OPTEE_SMC_CALL_RETURN_FROM_RPC;
-}
diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
deleted file mode 100644
index c41a9a501a6e..000000000000
--- a/drivers/tee/optee/shm_pool.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2015, Linaro Limited
- * Copyright (c) 2017, EPAM Systems
- */
-#include <linux/device.h>
-#include <linux/dma-buf.h>
-#include <linux/genalloc.h>
-#include <linux/slab.h>
-#include <linux/tee_drv.h>
-#include "optee_private.h"
-#include "optee_smc.h"
-#include "shm_pool.h"
-
-static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
-			 struct tee_shm *shm, size_t size)
-{
-	unsigned int order =3D get_order(size);
-	struct page *page;
-	int rc =3D 0;
-
-	page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!page)
-		return -ENOMEM;
-
-	shm->kaddr =3D page_address(page);
-	shm->paddr =3D page_to_phys(page);
-	shm->size =3D PAGE_SIZE << order;
-
-	/*
-	 * Shared memory private to the OP-TEE driver doesn't need
-	 * to be registered with OP-TEE.
-	 */
-	if (!(shm->flags & TEE_SHM_PRIV)) {
-		unsigned int nr_pages =3D 1 << order, i;
-		struct page **pages;
-
-		pages =3D kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
-		if (!pages) {
-			rc =3D -ENOMEM;
-			goto err;
-		}
-
-		for (i =3D 0; i < nr_pages; i++) {
-			pages[i] =3D page;
-			page++;
-		}
-
-		shm->flags |=3D TEE_SHM_REGISTER;
-		rc =3D optee_shm_register(shm->ctx, shm, pages, nr_pages,
-					(unsigned long)shm->kaddr);
-		kfree(pages);
-		if (rc)
-			goto err;
-	}
-
-	return 0;
-
-err:
-	__free_pages(page, order);
-	return rc;
-}
-
-static void pool_op_free(struct tee_shm_pool_mgr *poolm,
-			 struct tee_shm *shm)
-{
-	if (!(shm->flags & TEE_SHM_PRIV))
-		optee_shm_unregister(shm->ctx, shm);
-
-	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
-	shm->kaddr =3D NULL;
-}
-
-static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
-{
-	kfree(poolm);
-}
-
-static const struct tee_shm_pool_mgr_ops pool_ops =3D {
-	.alloc =3D pool_op_alloc,
-	.free =3D pool_op_free,
-	.destroy_poolmgr =3D pool_op_destroy_poolmgr,
-};
-
-/**
- * optee_shm_pool_alloc_pages() - create page-based allocator pool
- *
- * This pool is used when OP-TEE supports dymanic SHM. In this case
- * command buffers and such are allocated from kernel's own memory.
- */
-struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void)
-{
-	struct tee_shm_pool_mgr *mgr =3D kzalloc(sizeof(*mgr), GFP_KERNEL);
-
-	if (!mgr)
-		return ERR_PTR(-ENOMEM);
-
-	mgr->ops =3D &pool_ops;
-
-	return mgr;
-}
diff --git a/drivers/tee/optee/shm_pool.h b/drivers/tee/optee/shm_pool.h
deleted file mode 100644
index 28109d991c4b..000000000000
--- a/drivers/tee/optee/shm_pool.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2015, Linaro Limited
- * Copyright (c) 2016, EPAM Systems
- */
-
-#ifndef SHM_POOL_H
-#define SHM_POOL_H
-
-#include <linux/tee_drv.h>
-
-struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void);
-
-#endif
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
new file mode 100644
index 000000000000..32e0d4feb030
--- /dev/null
+++ b/drivers/tee/optee/smc_abi.c
@@ -0,0 +1,1360 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015-2021, Linaro Limited
+ * Copyright (c) 2016, EPAM Systems
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tee_drv.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+#include "optee_private.h"
+#include "optee_smc.h"
+#include "optee_rpc_cmd.h"
+#define CREATE_TRACE_POINTS
+#include "optee_trace.h"
+
+/*
+ * This file implement the SMC ABI used when communicating with secure world
+ * OP-TEE OS via raw SMCs.
+ * This file is divided into the following sections:
+ * 1. Convert between struct tee_param and struct optee_msg_param
+ * 2. Low level support functions to register shared memory in secure world
+ * 3. Dynamic shared memory pool based on alloc_pages()
+ * 4. Do a normal scheduled call into secure world
+ * 5. Driver initialization.
+ */
+
+#define OPTEE_SHM_NUM_PRIV_PAGES	CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
+
+/*
+ * 1. Convert between struct tee_param and struct optee_msg_param
+ *
+ * optee_from_msg_param() and optee_to_msg_param() are the main
+ * functions.
+ */
+
+static int from_msg_param_tmp_mem(struct tee_param *p, u32 attr,
+				  const struct optee_msg_param *mp)
+{
+	struct tee_shm *shm;
+	phys_addr_t pa;
+	int rc;
+
+	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
+		  attr - OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
+	p->u.memref.size =3D mp->u.tmem.size;
+	shm =3D (struct tee_shm *)(unsigned long)mp->u.tmem.shm_ref;
+	if (!shm) {
+		p->u.memref.shm_offs =3D 0;
+		p->u.memref.shm =3D NULL;
+		return 0;
+	}
+
+	rc =3D tee_shm_get_pa(shm, 0, &pa);
+	if (rc)
+		return rc;
+
+	p->u.memref.shm_offs =3D mp->u.tmem.buf_ptr - pa;
+	p->u.memref.shm =3D shm;
+
+	/* Check that the memref is covered by the shm object */
+	if (p->u.memref.size) {
+		size_t o =3D p->u.memref.shm_offs +
+			   p->u.memref.size - 1;
+
+		rc =3D tee_shm_get_pa(shm, o, NULL);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static void from_msg_param_reg_mem(struct tee_param *p, u32 attr,
+				   const struct optee_msg_param *mp)
+{
+	struct tee_shm *shm;
+
+	p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
+		  attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
+	p->u.memref.size =3D mp->u.rmem.size;
+	shm =3D (struct tee_shm *)(unsigned long)mp->u.rmem.shm_ref;
+
+	if (shm) {
+		p->u.memref.shm_offs =3D mp->u.rmem.offs;
+		p->u.memref.shm =3D shm;
+	} else {
+		p->u.memref.shm_offs =3D 0;
+		p->u.memref.shm =3D NULL;
+	}
+}
+
+/**
+ * optee_from_msg_param() - convert from OPTEE_MSG parameters to
+ *			    struct tee_param
+ * @optee:	main service struct
+ * @params:	subsystem internal parameter representation
+ * @num_params:	number of elements in the parameter arrays
+ * @msg_params:	OPTEE_MSG parameters
+ * Returns 0 on success or <0 on failure
+ */
+static int optee_from_msg_param(struct optee *optee, struct tee_param *param=
s,
+				size_t num_params,
+				const struct optee_msg_param *msg_params)
+{
+	int rc;
+	size_t n;
+
+	for (n =3D 0; n < num_params; n++) {
+		struct tee_param *p =3D params + n;
+		const struct optee_msg_param *mp =3D msg_params + n;
+		u32 attr =3D mp->attr & OPTEE_MSG_ATTR_TYPE_MASK;
+
+		switch (attr) {
+		case OPTEE_MSG_ATTR_TYPE_NONE:
+			p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
+			memset(&p->u, 0, sizeof(p->u));
+			break;
+		case OPTEE_MSG_ATTR_TYPE_VALUE_INPUT:
+		case OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT:
+		case OPTEE_MSG_ATTR_TYPE_VALUE_INOUT:
+			optee_from_msg_param_value(p, attr, mp);
+			break;
+		case OPTEE_MSG_ATTR_TYPE_TMEM_INPUT:
+		case OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT:
+		case OPTEE_MSG_ATTR_TYPE_TMEM_INOUT:
+			rc =3D from_msg_param_tmp_mem(p, attr, mp);
+			if (rc)
+				return rc;
+			break;
+		case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
+		case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
+		case OPTEE_MSG_ATTR_TYPE_RMEM_INOUT:
+			from_msg_param_reg_mem(p, attr, mp);
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int to_msg_param_tmp_mem(struct optee_msg_param *mp,
+				const struct tee_param *p)
+{
+	int rc;
+	phys_addr_t pa;
+
+	mp->attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_INPUT + p->attr -
+		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+
+	mp->u.tmem.shm_ref =3D (unsigned long)p->u.memref.shm;
+	mp->u.tmem.size =3D p->u.memref.size;
+
+	if (!p->u.memref.shm) {
+		mp->u.tmem.buf_ptr =3D 0;
+		return 0;
+	}
+
+	rc =3D tee_shm_get_pa(p->u.memref.shm, p->u.memref.shm_offs, &pa);
+	if (rc)
+		return rc;
+
+	mp->u.tmem.buf_ptr =3D pa;
+	mp->attr |=3D OPTEE_MSG_ATTR_CACHE_PREDEFINED <<
+		    OPTEE_MSG_ATTR_CACHE_SHIFT;
+
+	return 0;
+}
+
+static int to_msg_param_reg_mem(struct optee_msg_param *mp,
+				const struct tee_param *p)
+{
+	mp->attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT + p->attr -
+		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+
+	mp->u.rmem.shm_ref =3D (unsigned long)p->u.memref.shm;
+	mp->u.rmem.size =3D p->u.memref.size;
+	mp->u.rmem.offs =3D p->u.memref.shm_offs;
+	return 0;
+}
+
+/**
+ * optee_to_msg_param() - convert from struct tee_params to OPTEE_MSG parame=
ters
+ * @optee:	main service struct
+ * @msg_params:	OPTEE_MSG parameters
+ * @num_params:	number of elements in the parameter arrays
+ * @params:	subsystem itnernal parameter representation
+ * Returns 0 on success or <0 on failure
+ */
+static int optee_to_msg_param(struct optee *optee,
+			      struct optee_msg_param *msg_params,
+			      size_t num_params, const struct tee_param *params)
+{
+	int rc;
+	size_t n;
+
+	for (n =3D 0; n < num_params; n++) {
+		const struct tee_param *p =3D params + n;
+		struct optee_msg_param *mp =3D msg_params + n;
+
+		switch (p->attr) {
+		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
+			mp->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
+			memset(&mp->u, 0, sizeof(mp->u));
+			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
+			optee_to_msg_param_value(mp, p);
+			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
+			if (tee_shm_is_registered(p->u.memref.shm))
+				rc =3D to_msg_param_reg_mem(mp, p);
+			else
+				rc =3D to_msg_param_tmp_mem(mp, p);
+			if (rc)
+				return rc;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/*
+ * 2. Low level support functions to register shared memory in secure world
+ *
+ * Functions to enable/disable shared memory caching in secure world, that
+ * is, lazy freeing of previously allocated shared memory. Freeing is
+ * performed when a request has been compled.
+ *
+ * Functions to register and unregister shared memory both for normal
+ * clients and for tee-supplicant.
+ */
+
+/**
+ * optee_enable_shm_cache() - Enables caching of some shared memory allocati=
on
+ *			      in OP-TEE
+ * @optee:	main service struct
+ */
+static void optee_enable_shm_cache(struct optee *optee)
+{
+	struct optee_call_waiter w;
+
+	/* We need to retry until secure world isn't busy. */
+	optee_cq_wait_init(&optee->call_queue, &w);
+	while (true) {
+		struct arm_smccc_res res;
+
+		optee->smc.invoke_fn(OPTEE_SMC_ENABLE_SHM_CACHE,
+				     0, 0, 0, 0, 0, 0, 0, &res);
+		if (res.a0 =3D=3D OPTEE_SMC_RETURN_OK)
+			break;
+		optee_cq_wait_for_completion(&optee->call_queue, &w);
+	}
+	optee_cq_wait_final(&optee->call_queue, &w);
+}
+
+/**
+ * __optee_disable_shm_cache() - Disables caching of some shared memory
+ *				 allocation in OP-TEE
+ * @optee:	main service struct
+ * @is_mapped:	true if the cached shared memory addresses were mapped by this
+ *		kernel, are safe to dereference, and should be freed
+ */
+static void __optee_disable_shm_cache(struct optee *optee, bool is_mapped)
+{
+	struct optee_call_waiter w;
+
+	/* We need to retry until secure world isn't busy. */
+	optee_cq_wait_init(&optee->call_queue, &w);
+	while (true) {
+		union {
+			struct arm_smccc_res smccc;
+			struct optee_smc_disable_shm_cache_result result;
+		} res;
+
+		optee->smc.invoke_fn(OPTEE_SMC_DISABLE_SHM_CACHE,
+				     0, 0, 0, 0, 0, 0, 0, &res.smccc);
+		if (res.result.status =3D=3D OPTEE_SMC_RETURN_ENOTAVAIL)
+			break; /* All shm's freed */
+		if (res.result.status =3D=3D OPTEE_SMC_RETURN_OK) {
+			struct tee_shm *shm;
+
+			/*
+			 * Shared memory references that were not mapped by
+			 * this kernel must be ignored to prevent a crash.
+			 */
+			if (!is_mapped)
+				continue;
+
+			shm =3D reg_pair_to_ptr(res.result.shm_upper32,
+					      res.result.shm_lower32);
+			tee_shm_free(shm);
+		} else {
+			optee_cq_wait_for_completion(&optee->call_queue, &w);
+		}
+	}
+	optee_cq_wait_final(&optee->call_queue, &w);
+}
+
+/**
+ * optee_disable_shm_cache() - Disables caching of mapped shared memory
+ *			       allocations in OP-TEE
+ * @optee:	main service struct
+ */
+void optee_disable_shm_cache(struct optee *optee)
+{
+	return __optee_disable_shm_cache(optee, true);
+}
+
+/**
+ * optee_disable_unmapped_shm_cache() - Disables caching of shared memory
+ *					allocations in OP-TEE which are not
+ *					currently mapped
+ * @optee:	main service struct
+ */
+void optee_disable_unmapped_shm_cache(struct optee *optee)
+{
+	return __optee_disable_shm_cache(optee, false);
+}
+
+#define PAGELIST_ENTRIES_PER_PAGE				\
+	((OPTEE_MSG_NONCONTIG_PAGE_SIZE / sizeof(u64)) - 1)
+
+/*
+ * The final entry in each pagelist page is a pointer to the next
+ * pagelist page.
+ */
+static size_t get_pages_list_size(size_t num_entries)
+{
+	int pages =3D DIV_ROUND_UP(num_entries, PAGELIST_ENTRIES_PER_PAGE);
+
+	return pages * OPTEE_MSG_NONCONTIG_PAGE_SIZE;
+}
+
+static u64 *optee_allocate_pages_list(size_t num_entries)
+{
+	return alloc_pages_exact(get_pages_list_size(num_entries), GFP_KERNEL);
+}
+
+static void optee_free_pages_list(void *list, size_t num_entries)
+{
+	free_pages_exact(list, get_pages_list_size(num_entries));
+}
+
+/**
+ * optee_fill_pages_list() - write list of user pages to given shared
+ * buffer.
+ *
+ * @dst: page-aligned buffer where list of pages will be stored
+ * @pages: array of pages that represents shared buffer
+ * @num_pages: number of entries in @pages
+ * @page_offset: offset of user buffer from page start
+ *
+ * @dst should be big enough to hold list of user page addresses and
+ *	links to the next pages of buffer
+ */
+static void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pag=
es,
+				  size_t page_offset)
+{
+	int n =3D 0;
+	phys_addr_t optee_page;
+	/*
+	 * Refer to OPTEE_MSG_ATTR_NONCONTIG description in optee_msg.h
+	 * for details.
+	 */
+	struct {
+		u64 pages_list[PAGELIST_ENTRIES_PER_PAGE];
+		u64 next_page_data;
+	} *pages_data;
+
+	/*
+	 * Currently OP-TEE uses 4k page size and it does not looks
+	 * like this will change in the future.  On other hand, there are
+	 * no know ARM architectures with page size < 4k.
+	 * Thus the next built assert looks redundant. But the following
+	 * code heavily relies on this assumption, so it is better be
+	 * safe than sorry.
+	 */
+	BUILD_BUG_ON(PAGE_SIZE < OPTEE_MSG_NONCONTIG_PAGE_SIZE);
+
+	pages_data =3D (void *)dst;
+	/*
+	 * If linux page is bigger than 4k, and user buffer offset is
+	 * larger than 4k/8k/12k/etc this will skip first 4k pages,
+	 * because they bear no value data for OP-TEE.
+	 */
+	optee_page =3D page_to_phys(*pages) +
+		round_down(page_offset, OPTEE_MSG_NONCONTIG_PAGE_SIZE);
+
+	while (true) {
+		pages_data->pages_list[n++] =3D optee_page;
+
+		if (n =3D=3D PAGELIST_ENTRIES_PER_PAGE) {
+			pages_data->next_page_data =3D
+				virt_to_phys(pages_data + 1);
+			pages_data++;
+			n =3D 0;
+		}
+
+		optee_page +=3D OPTEE_MSG_NONCONTIG_PAGE_SIZE;
+		if (!(optee_page & ~PAGE_MASK)) {
+			if (!--num_pages)
+				break;
+			pages++;
+			optee_page =3D page_to_phys(*pages);
+		}
+	}
+}
+
+static int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
+			      struct page **pages, size_t num_pages,
+			      unsigned long start)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm_arg;
+	u64 *pages_list;
+	int rc;
+
+	if (!num_pages)
+		return -EINVAL;
+
+	rc =3D optee_check_mem_type(start, num_pages);
+	if (rc)
+		return rc;
+
+	pages_list =3D optee_allocate_pages_list(num_pages);
+	if (!pages_list)
+		return -ENOMEM;
+
+	shm_arg =3D optee_get_msg_arg(ctx, 1, &msg_arg);
+	if (IS_ERR(shm_arg)) {
+		rc =3D PTR_ERR(shm_arg);
+		goto out;
+	}
+
+	optee_fill_pages_list(pages_list, pages, num_pages,
+			      tee_shm_get_page_offset(shm));
+
+	msg_arg->cmd =3D OPTEE_MSG_CMD_REGISTER_SHM;
+	msg_arg->params->attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
+				OPTEE_MSG_ATTR_NONCONTIG;
+	msg_arg->params->u.tmem.shm_ref =3D (unsigned long)shm;
+	msg_arg->params->u.tmem.size =3D tee_shm_get_size(shm);
+	/*
+	 * In the least bits of msg_arg->params->u.tmem.buf_ptr we
+	 * store buffer offset from 4k page, as described in OP-TEE ABI.
+	 */
+	msg_arg->params->u.tmem.buf_ptr =3D virt_to_phys(pages_list) |
+	  (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
+
+	if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
+	    msg_arg->ret !=3D TEEC_SUCCESS)
+		rc =3D -EINVAL;
+
+	tee_shm_free(shm_arg);
+out:
+	optee_free_pages_list(pages_list, num_pages);
+	return rc;
+}
+
+static int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm_arg;
+	int rc =3D 0;
+
+	shm_arg =3D optee_get_msg_arg(ctx, 1, &msg_arg);
+	if (IS_ERR(shm_arg))
+		return PTR_ERR(shm_arg);
+
+	msg_arg->cmd =3D OPTEE_MSG_CMD_UNREGISTER_SHM;
+
+	msg_arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
+	msg_arg->params[0].u.rmem.shm_ref =3D (unsigned long)shm;
+
+	if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
+	    msg_arg->ret !=3D TEEC_SUCCESS)
+		rc =3D -EINVAL;
+	tee_shm_free(shm_arg);
+	return rc;
+}
+
+static int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *=
shm,
+				   struct page **pages, size_t num_pages,
+				   unsigned long start)
+{
+	/*
+	 * We don't want to register supplicant memory in OP-TEE.
+	 * Instead information about it will be passed in RPC code.
+	 */
+	return optee_check_mem_type(start, num_pages);
+}
+
+static int optee_shm_unregister_supp(struct tee_context *ctx,
+				     struct tee_shm *shm)
+{
+	return 0;
+}
+
+/*
+ * 3. Dynamic shared memory pool based on alloc_pages()
+ *
+ * Implements an OP-TEE specific shared memory pool which is used
+ * when dynamic shared memory is supported by secure world.
+ *
+ * The main function is optee_shm_pool_alloc_pages().
+ */
+
+static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
+			 struct tee_shm *shm, size_t size)
+{
+	/*
+	 * Shared memory private to the OP-TEE driver doesn't need
+	 * to be registered with OP-TEE.
+	 */
+	if (shm->flags & TEE_SHM_PRIV)
+		return optee_pool_op_alloc_helper(poolm, shm, size, NULL);
+
+	return optee_pool_op_alloc_helper(poolm, shm, size, optee_shm_register);
+}
+
+static void pool_op_free(struct tee_shm_pool_mgr *poolm,
+			 struct tee_shm *shm)
+{
+	if (!(shm->flags & TEE_SHM_PRIV))
+		optee_shm_unregister(shm->ctx, shm);
+
+	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	shm->kaddr =3D NULL;
+}
+
+static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
+{
+	kfree(poolm);
+}
+
+static const struct tee_shm_pool_mgr_ops pool_ops =3D {
+	.alloc =3D pool_op_alloc,
+	.free =3D pool_op_free,
+	.destroy_poolmgr =3D pool_op_destroy_poolmgr,
+};
+
+/**
+ * optee_shm_pool_alloc_pages() - create page-based allocator pool
+ *
+ * This pool is used when OP-TEE supports dymanic SHM. In this case
+ * command buffers and such are allocated from kernel's own memory.
+ */
+static struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void)
+{
+	struct tee_shm_pool_mgr *mgr =3D kzalloc(sizeof(*mgr), GFP_KERNEL);
+
+	if (!mgr)
+		return ERR_PTR(-ENOMEM);
+
+	mgr->ops =3D &pool_ops;
+
+	return mgr;
+}
+
+/*
+ * 4. Do a normal scheduled call into secure world
+ *
+ * The function optee_smc_do_call_with_arg() performs a normal scheduled
+ * call into secure world. During this call may normal world request help
+ * from normal world using RPCs, Remote Procedure Calls. This includes
+ * delivery of non-secure interrupts to for instance allow rescheduling of
+ * the current task.
+ */
+
+static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
+					 struct optee_msg_arg *arg)
+{
+	struct tee_shm *shm;
+
+	arg->ret_origin =3D TEEC_ORIGIN_COMMS;
+
+	if (arg->num_params !=3D 1 ||
+	    arg->params[0].attr !=3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT) {
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	shm =3D (struct tee_shm *)(unsigned long)arg->params[0].u.value.b;
+	switch (arg->params[0].u.value.a) {
+	case OPTEE_RPC_SHM_TYPE_APPL:
+		optee_rpc_cmd_free_suppl(ctx, shm);
+		break;
+	case OPTEE_RPC_SHM_TYPE_KERNEL:
+		tee_shm_free(shm);
+		break;
+	default:
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+	}
+	arg->ret =3D TEEC_SUCCESS;
+}
+
+static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
+					  struct optee_msg_arg *arg,
+					  struct optee_call_ctx *call_ctx)
+{
+	phys_addr_t pa;
+	struct tee_shm *shm;
+	size_t sz;
+	size_t n;
+
+	arg->ret_origin =3D TEEC_ORIGIN_COMMS;
+
+	if (!arg->num_params ||
+	    arg->params[0].attr !=3D OPTEE_MSG_ATTR_TYPE_VALUE_INPUT) {
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	for (n =3D 1; n < arg->num_params; n++) {
+		if (arg->params[n].attr !=3D OPTEE_MSG_ATTR_TYPE_NONE) {
+			arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+			return;
+		}
+	}
+
+	sz =3D arg->params[0].u.value.b;
+	switch (arg->params[0].u.value.a) {
+	case OPTEE_RPC_SHM_TYPE_APPL:
+		shm =3D optee_rpc_cmd_alloc_suppl(ctx, sz);
+		break;
+	case OPTEE_RPC_SHM_TYPE_KERNEL:
+		shm =3D tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED | TEE_SHM_PRIV);
+		break;
+	default:
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	if (IS_ERR(shm)) {
+		arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
+		return;
+	}
+
+	if (tee_shm_get_pa(shm, 0, &pa)) {
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		goto bad;
+	}
+
+	sz =3D tee_shm_get_size(shm);
+
+	if (tee_shm_is_registered(shm)) {
+		struct page **pages;
+		u64 *pages_list;
+		size_t page_num;
+
+		pages =3D tee_shm_get_pages(shm, &page_num);
+		if (!pages || !page_num) {
+			arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
+			goto bad;
+		}
+
+		pages_list =3D optee_allocate_pages_list(page_num);
+		if (!pages_list) {
+			arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
+			goto bad;
+		}
+
+		call_ctx->pages_list =3D pages_list;
+		call_ctx->num_entries =3D page_num;
+
+		arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
+				      OPTEE_MSG_ATTR_NONCONTIG;
+		/*
+		 * In the least bits of u.tmem.buf_ptr we store buffer offset
+		 * from 4k page, as described in OP-TEE ABI.
+		 */
+		arg->params[0].u.tmem.buf_ptr =3D virt_to_phys(pages_list) |
+			(tee_shm_get_page_offset(shm) &
+			 (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
+		arg->params[0].u.tmem.size =3D tee_shm_get_size(shm);
+		arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
+
+		optee_fill_pages_list(pages_list, pages, page_num,
+				      tee_shm_get_page_offset(shm));
+	} else {
+		arg->params[0].attr =3D OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
+		arg->params[0].u.tmem.buf_ptr =3D pa;
+		arg->params[0].u.tmem.size =3D sz;
+		arg->params[0].u.tmem.shm_ref =3D (unsigned long)shm;
+	}
+
+	arg->ret =3D TEEC_SUCCESS;
+	return;
+bad:
+	tee_shm_free(shm);
+}
+
+static void free_pages_list(struct optee_call_ctx *call_ctx)
+{
+	if (call_ctx->pages_list) {
+		optee_free_pages_list(call_ctx->pages_list,
+				      call_ctx->num_entries);
+		call_ctx->pages_list =3D NULL;
+		call_ctx->num_entries =3D 0;
+	}
+}
+
+static void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx)
+{
+	free_pages_list(call_ctx);
+}
+
+static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
+				struct tee_shm *shm,
+				struct optee_call_ctx *call_ctx)
+{
+	struct optee_msg_arg *arg;
+
+	arg =3D tee_shm_get_va(shm, 0);
+	if (IS_ERR(arg)) {
+		pr_err("%s: tee_shm_get_va %p failed\n", __func__, shm);
+		return;
+	}
+
+	switch (arg->cmd) {
+	case OPTEE_RPC_CMD_SHM_ALLOC:
+		free_pages_list(call_ctx);
+		handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
+		break;
+	case OPTEE_RPC_CMD_SHM_FREE:
+		handle_rpc_func_cmd_shm_free(ctx, arg);
+		break;
+	default:
+		optee_rpc_cmd(ctx, optee, arg);
+	}
+}
+
+/**
+ * optee_handle_rpc() - handle RPC from secure world
+ * @ctx:	context doing the RPC
+ * @param:	value of registers for the RPC
+ * @call_ctx:	call context. Preserved during one OP-TEE invocation
+ *
+ * Result of RPC is written back into @param.
+ */
+static void optee_handle_rpc(struct tee_context *ctx,
+			     struct optee_rpc_param *param,
+			     struct optee_call_ctx *call_ctx)
+{
+	struct tee_device *teedev =3D ctx->teedev;
+	struct optee *optee =3D tee_get_drvdata(teedev);
+	struct tee_shm *shm;
+	phys_addr_t pa;
+
+	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
+	case OPTEE_SMC_RPC_FUNC_ALLOC:
+		shm =3D tee_shm_alloc(ctx, param->a1, TEE_SHM_MAPPED);
+		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
+			reg_pair_from_64(&param->a1, &param->a2, pa);
+			reg_pair_from_64(&param->a4, &param->a5,
+					 (unsigned long)shm);
+		} else {
+			param->a1 =3D 0;
+			param->a2 =3D 0;
+			param->a4 =3D 0;
+			param->a5 =3D 0;
+		}
+		break;
+	case OPTEE_SMC_RPC_FUNC_FREE:
+		shm =3D reg_pair_to_ptr(param->a1, param->a2);
+		tee_shm_free(shm);
+		break;
+	case OPTEE_SMC_RPC_FUNC_FOREIGN_INTR:
+		/*
+		 * A foreign interrupt was raised while secure world was
+		 * executing, since they are handled in Linux a dummy RPC is
+		 * performed to let Linux take the interrupt through the normal
+		 * vector.
+		 */
+		break;
+	case OPTEE_SMC_RPC_FUNC_CMD:
+		shm =3D reg_pair_to_ptr(param->a1, param->a2);
+		handle_rpc_func_cmd(ctx, optee, shm, call_ctx);
+		break;
+	default:
+		pr_warn("Unknown RPC func 0x%x\n",
+			(u32)OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0));
+		break;
+	}
+
+	param->a0 =3D OPTEE_SMC_CALL_RETURN_FROM_RPC;
+}
+
+/**
+ * optee_smc_do_call_with_arg() - Do an SMC to OP-TEE in secure world
+ * @ctx:	calling context
+ * @arg:	shared memory holding the message to pass to secure world
+ *
+ * Does and SMC to OP-TEE in secure world and handles eventual resulting
+ * Remote Procedure Calls (RPC) from OP-TEE.
+ *
+ * Returns return code from secure world, 0 is OK
+ */
+static int optee_smc_do_call_with_arg(struct tee_context *ctx,
+				      struct tee_shm *arg)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	struct optee_call_waiter w;
+	struct optee_rpc_param param =3D { };
+	struct optee_call_ctx call_ctx =3D { };
+	phys_addr_t parg;
+	int rc;
+
+	rc =3D tee_shm_get_pa(arg, 0, &parg);
+	if (rc)
+		return rc;
+
+	param.a0 =3D OPTEE_SMC_CALL_WITH_ARG;
+	reg_pair_from_64(&param.a1, &param.a2, parg);
+	/* Initialize waiter */
+	optee_cq_wait_init(&optee->call_queue, &w);
+	while (true) {
+		struct arm_smccc_res res;
+
+		trace_optee_invoke_fn_begin(&param);
+		optee->smc.invoke_fn(param.a0, param.a1, param.a2, param.a3,
+				     param.a4, param.a5, param.a6, param.a7,
+				     &res);
+		trace_optee_invoke_fn_end(&param, &res);
+
+		if (res.a0 =3D=3D OPTEE_SMC_RETURN_ETHREAD_LIMIT) {
+			/*
+			 * Out of threads in secure world, wait for a thread
+			 * become available.
+			 */
+			optee_cq_wait_for_completion(&optee->call_queue, &w);
+		} else if (OPTEE_SMC_RETURN_IS_RPC(res.a0)) {
+			cond_resched();
+			param.a0 =3D res.a0;
+			param.a1 =3D res.a1;
+			param.a2 =3D res.a2;
+			param.a3 =3D res.a3;
+			optee_handle_rpc(ctx, &param, &call_ctx);
+		} else {
+			rc =3D res.a0;
+			break;
+		}
+	}
+
+	optee_rpc_finalize_call(&call_ctx);
+	/*
+	 * We're done with our thread in secure world, if there's any
+	 * thread waiters wake up one.
+	 */
+	optee_cq_wait_final(&optee->call_queue, &w);
+
+	return rc;
+}
+
+/*
+ * 5. Driver initialization
+ *
+ * During driver inititialization is secure world probed to find out which
+ * features it supports so the driver can be initialized with a matching
+ * configuration. This involves for instance support for dynamic shared
+ * memory instead of a static memory carvout.
+ */
+
+static void optee_get_version(struct tee_device *teedev,
+			      struct tee_ioctl_version_data *vers)
+{
+	struct tee_ioctl_version_data v =3D {
+		.impl_id =3D TEE_IMPL_ID_OPTEE,
+		.impl_caps =3D TEE_OPTEE_CAP_TZ,
+		.gen_caps =3D TEE_GEN_CAP_GP,
+	};
+	struct optee *optee =3D tee_get_drvdata(teedev);
+
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
+		v.gen_caps |=3D TEE_GEN_CAP_REG_MEM;
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL)
+		v.gen_caps |=3D TEE_GEN_CAP_MEMREF_NULL;
+	*vers =3D v;
+}
+
+static int optee_smc_open(struct tee_context *ctx)
+{
+	struct optee *optee =3D tee_get_drvdata(ctx->teedev);
+	u32 sec_caps =3D optee->smc.sec_caps;
+
+	return optee_open(ctx, sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL);
+}
+
+static const struct tee_driver_ops optee_clnt_ops =3D {
+	.get_version =3D optee_get_version,
+	.open =3D optee_smc_open,
+	.release =3D optee_release,
+	.open_session =3D optee_open_session,
+	.close_session =3D optee_close_session,
+	.invoke_func =3D optee_invoke_func,
+	.cancel_req =3D optee_cancel_req,
+	.shm_register =3D optee_shm_register,
+	.shm_unregister =3D optee_shm_unregister,
+};
+
+static const struct tee_desc optee_clnt_desc =3D {
+	.name =3D DRIVER_NAME "-clnt",
+	.ops =3D &optee_clnt_ops,
+	.owner =3D THIS_MODULE,
+};
+
+static const struct tee_driver_ops optee_supp_ops =3D {
+	.get_version =3D optee_get_version,
+	.open =3D optee_smc_open,
+	.release =3D optee_release_supp,
+	.supp_recv =3D optee_supp_recv,
+	.supp_send =3D optee_supp_send,
+	.shm_register =3D optee_shm_register_supp,
+	.shm_unregister =3D optee_shm_unregister_supp,
+};
+
+static const struct tee_desc optee_supp_desc =3D {
+	.name =3D DRIVER_NAME "-supp",
+	.ops =3D &optee_supp_ops,
+	.owner =3D THIS_MODULE,
+	.flags =3D TEE_DESC_PRIVILEGED,
+};
+
+static const struct optee_ops optee_ops =3D {
+	.do_call_with_arg =3D optee_smc_do_call_with_arg,
+	.to_msg_param =3D optee_to_msg_param,
+	.from_msg_param =3D optee_from_msg_param,
+};
+
+static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
+{
+	struct arm_smccc_res res;
+
+	invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0 =3D=3D OPTEE_MSG_UID_0 && res.a1 =3D=3D OPTEE_MSG_UID_1 &&
+	    res.a2 =3D=3D OPTEE_MSG_UID_2 && res.a3 =3D=3D OPTEE_MSG_UID_3)
+		return true;
+	return false;
+}
+
+static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
+{
+	union {
+		struct arm_smccc_res smccc;
+		struct optee_smc_call_get_os_revision_result result;
+	} res =3D {
+		.result =3D {
+			.build_id =3D 0
+		}
+	};
+
+	invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
+		  &res.smccc);
+
+	if (res.result.build_id)
+		pr_info("revision %lu.%lu (%08lx)", res.result.major,
+			res.result.minor, res.result.build_id);
+	else
+		pr_info("revision %lu.%lu", res.result.major, res.result.minor);
+}
+
+static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
+{
+	union {
+		struct arm_smccc_res smccc;
+		struct optee_smc_calls_revision_result result;
+	} res;
+
+	invoke_fn(OPTEE_SMC_CALLS_REVISION, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
+
+	if (res.result.major =3D=3D OPTEE_MSG_REVISION_MAJOR &&
+	    (int)res.result.minor >=3D OPTEE_MSG_REVISION_MINOR)
+		return true;
+	return false;
+}
+
+static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
+					    u32 *sec_caps)
+{
+	union {
+		struct arm_smccc_res smccc;
+		struct optee_smc_exchange_capabilities_result result;
+	} res;
+	u32 a1 =3D 0;
+
+	/*
+	 * TODO This isn't enough to tell if it's UP system (from kernel
+	 * point of view) or not, is_smp() returns the information
+	 * needed, but can't be called directly from here.
+	 */
+	if (!IS_ENABLED(CONFIG_SMP) || nr_cpu_ids =3D=3D 1)
+		a1 |=3D OPTEE_SMC_NSEC_CAP_UNIPROCESSOR;
+
+	invoke_fn(OPTEE_SMC_EXCHANGE_CAPABILITIES, a1, 0, 0, 0, 0, 0, 0,
+		  &res.smccc);
+
+	if (res.result.status !=3D OPTEE_SMC_RETURN_OK)
+		return false;
+
+	*sec_caps =3D res.result.capabilities;
+	return true;
+}
+
+static struct tee_shm_pool *optee_config_dyn_shm(void)
+{
+	struct tee_shm_pool_mgr *priv_mgr;
+	struct tee_shm_pool_mgr *dmabuf_mgr;
+	void *rc;
+
+	rc =3D optee_shm_pool_alloc_pages();
+	if (IS_ERR(rc))
+		return rc;
+	priv_mgr =3D rc;
+
+	rc =3D optee_shm_pool_alloc_pages();
+	if (IS_ERR(rc)) {
+		tee_shm_pool_mgr_destroy(priv_mgr);
+		return rc;
+	}
+	dmabuf_mgr =3D rc;
+
+	rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
+	if (IS_ERR(rc)) {
+		tee_shm_pool_mgr_destroy(priv_mgr);
+		tee_shm_pool_mgr_destroy(dmabuf_mgr);
+	}
+
+	return rc;
+}
+
+static struct tee_shm_pool *
+optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
+{
+	union {
+		struct arm_smccc_res smccc;
+		struct optee_smc_get_shm_config_result result;
+	} res;
+	unsigned long vaddr;
+	phys_addr_t paddr;
+	size_t size;
+	phys_addr_t begin;
+	phys_addr_t end;
+	void *va;
+	struct tee_shm_pool_mgr *priv_mgr;
+	struct tee_shm_pool_mgr *dmabuf_mgr;
+	void *rc;
+	const int sz =3D OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
+
+	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
+	if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
+		pr_err("static shm service not available\n");
+		return ERR_PTR(-ENOENT);
+	}
+
+	if (res.result.settings !=3D OPTEE_SMC_SHM_CACHED) {
+		pr_err("only normal cached shared memory supported\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	begin =3D roundup(res.result.start, PAGE_SIZE);
+	end =3D rounddown(res.result.start + res.result.size, PAGE_SIZE);
+	paddr =3D begin;
+	size =3D end - begin;
+
+	if (size < 2 * OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE) {
+		pr_err("too small shared memory area\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	va =3D memremap(paddr, size, MEMREMAP_WB);
+	if (!va) {
+		pr_err("shared memory ioremap failed\n");
+		return ERR_PTR(-EINVAL);
+	}
+	vaddr =3D (unsigned long)va;
+
+	rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
+					    3 /* 8 bytes aligned */);
+	if (IS_ERR(rc))
+		goto err_memunmap;
+	priv_mgr =3D rc;
+
+	vaddr +=3D sz;
+	paddr +=3D sz;
+	size -=3D sz;
+
+	rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
+	if (IS_ERR(rc))
+		goto err_free_priv_mgr;
+	dmabuf_mgr =3D rc;
+
+	rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
+	if (IS_ERR(rc))
+		goto err_free_dmabuf_mgr;
+
+	*memremaped_shm =3D va;
+
+	return rc;
+
+err_free_dmabuf_mgr:
+	tee_shm_pool_mgr_destroy(dmabuf_mgr);
+err_free_priv_mgr:
+	tee_shm_pool_mgr_destroy(priv_mgr);
+err_memunmap:
+	memunmap(va);
+	return rc;
+}
+
+/* Simple wrapper functions to be able to use a function pointer */
+static void optee_smccc_smc(unsigned long a0, unsigned long a1,
+			    unsigned long a2, unsigned long a3,
+			    unsigned long a4, unsigned long a5,
+			    unsigned long a6, unsigned long a7,
+			    struct arm_smccc_res *res)
+{
+	arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res);
+}
+
+static void optee_smccc_hvc(unsigned long a0, unsigned long a1,
+			    unsigned long a2, unsigned long a3,
+			    unsigned long a4, unsigned long a5,
+			    unsigned long a6, unsigned long a7,
+			    struct arm_smccc_res *res)
+{
+	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
+}
+
+static optee_invoke_fn *get_invoke_func(struct device *dev)
+{
+	const char *method;
+
+	pr_info("probing for conduit method.\n");
+
+	if (device_property_read_string(dev, "method", &method)) {
+		pr_warn("missing \"method\" property\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	if (!strcmp("hvc", method))
+		return optee_smccc_hvc;
+	else if (!strcmp("smc", method))
+		return optee_smccc_smc;
+
+	pr_warn("invalid \"method\" property: %s\n", method);
+	return ERR_PTR(-EINVAL);
+}
+
+/* optee_remove - Device Removal Routine
+ * @pdev: platform device information struct
+ *
+ * optee_remove is called by platform subsystem to alert the driver
+ * that it should release the device
+ */
+static int optee_smc_remove(struct platform_device *pdev)
+{
+	struct optee *optee =3D platform_get_drvdata(pdev);
+
+	/*
+	 * Ask OP-TEE to free all cached shared memory objects to decrease
+	 * reference counters and also avoid wild pointers in secure world
+	 * into the old shared memory range.
+	 */
+	optee_disable_shm_cache(optee);
+
+	optee_remove_common(optee);
+
+	if (optee->smc.memremaped_shm)
+		memunmap(optee->smc.memremaped_shm);
+
+	kfree(optee);
+
+	return 0;
+}
+
+/* optee_shutdown - Device Removal Routine
+ * @pdev: platform device information struct
+ *
+ * platform_shutdown is called by the platform subsystem to alert
+ * the driver that a shutdown, reboot, or kexec is happening and
+ * device must be disabled.
+ */
+static void optee_shutdown(struct platform_device *pdev)
+{
+	optee_disable_shm_cache(platform_get_drvdata(pdev));
+}
+
+static int optee_probe(struct platform_device *pdev)
+{
+	optee_invoke_fn *invoke_fn;
+	struct tee_shm_pool *pool =3D ERR_PTR(-EINVAL);
+	struct optee *optee =3D NULL;
+	void *memremaped_shm =3D NULL;
+	struct tee_device *teedev;
+	u32 sec_caps;
+	int rc;
+
+	invoke_fn =3D get_invoke_func(&pdev->dev);
+	if (IS_ERR(invoke_fn))
+		return PTR_ERR(invoke_fn);
+
+	if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
+		pr_warn("api uid mismatch\n");
+		return -EINVAL;
+	}
+
+	optee_msg_get_os_revision(invoke_fn);
+
+	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
+		pr_warn("api revision mismatch\n");
+		return -EINVAL;
+	}
+
+	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps)) {
+		pr_warn("capabilities mismatch\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Try to use dynamic shared memory if possible
+	 */
+	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
+		pool =3D optee_config_dyn_shm();
+
+	/*
+	 * If dynamic shared memory is not available or failed - try static one
+	 */
+	if (IS_ERR(pool) && (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
+		pool =3D optee_config_shm_memremap(invoke_fn, &memremaped_shm);
+
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
+	if (!optee) {
+		rc =3D -ENOMEM;
+		goto err;
+	}
+
+	optee->ops =3D &optee_ops;
+	optee->smc.invoke_fn =3D invoke_fn;
+	optee->smc.sec_caps =3D sec_caps;
+
+	teedev =3D tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
+	if (IS_ERR(teedev)) {
+		rc =3D PTR_ERR(teedev);
+		goto err;
+	}
+	optee->teedev =3D teedev;
+
+	teedev =3D tee_device_alloc(&optee_supp_desc, NULL, pool, optee);
+	if (IS_ERR(teedev)) {
+		rc =3D PTR_ERR(teedev);
+		goto err;
+	}
+	optee->supp_teedev =3D teedev;
+
+	rc =3D tee_device_register(optee->teedev);
+	if (rc)
+		goto err;
+
+	rc =3D tee_device_register(optee->supp_teedev);
+	if (rc)
+		goto err;
+
+	mutex_init(&optee->call_queue.mutex);
+	INIT_LIST_HEAD(&optee->call_queue.waiters);
+	optee_wait_queue_init(&optee->wait_queue);
+	optee_supp_init(&optee->supp);
+	optee->smc.memremaped_shm =3D memremaped_shm;
+	optee->pool =3D pool;
+
+	/*
+	 * Ensure that there are no pre-existing shm objects before enabling
+	 * the shm cache so that there's no chance of receiving an invalid
+	 * address during shutdown. This could occur, for example, if we're
+	 * kexec booting from an older kernel that did not properly cleanup the
+	 * shm cache.
+	 */
+	optee_disable_unmapped_shm_cache(optee);
+
+	optee_enable_shm_cache(optee);
+
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
+		pr_info("dynamic shared memory is enabled\n");
+
+	platform_set_drvdata(pdev, optee);
+
+	rc =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES);
+	if (rc) {
+		optee_smc_remove(pdev);
+		return rc;
+	}
+
+	pr_info("initialized driver\n");
+	return 0;
+err:
+	if (optee) {
+		/*
+		 * tee_device_unregister() is safe to call even if the
+		 * devices hasn't been registered with
+		 * tee_device_register() yet.
+		 */
+		tee_device_unregister(optee->supp_teedev);
+		tee_device_unregister(optee->teedev);
+		kfree(optee);
+	}
+	if (pool)
+		tee_shm_pool_free(pool);
+	if (memremaped_shm)
+		memunmap(memremaped_shm);
+	return rc;
+}
+
+static const struct of_device_id optee_dt_match[] =3D {
+	{ .compatible =3D "linaro,optee-tz" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, optee_dt_match);
+
+static struct platform_driver optee_driver =3D {
+	.probe  =3D optee_probe,
+	.remove =3D optee_smc_remove,
+	.shutdown =3D optee_shutdown,
+	.driver =3D {
+		.name =3D "optee",
+		.of_match_table =3D optee_dt_match,
+	},
+};
+
+int optee_smc_abi_register(void)
+{
+	return platform_driver_register(&optee_driver);
+}
+
+void optee_smc_abi_unregister(void)
+{
+	platform_driver_unregister(&optee_driver);
+}
--=20
2.31.1


--===============2103423157570891762==--

