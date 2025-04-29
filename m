From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
Date: Mon, 28 Apr 2025 23:06:31 -0700
Message-ID: <20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-10-6a143640a6cb@oss.qualcomm.com>
In-Reply-To: <=?utf-8?q?=3C20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-?=
 =?utf-8?q?0-6a143640a6cb=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5738940779830588866=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5738940779830588866==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Enable userspace to allocate shared memory with QTEE. Since
QTEE handles shared memory as object, a wrapper is implemented
to represent tee_shm as an object. The shared memory identifier,
obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/Makefile          |   1 +
 drivers/tee/qcomtee/call.c            |  10 +-
 drivers/tee/qcomtee/mem_obj.c         | 172 ++++++++++++++++++++++++++++++++=
++
 drivers/tee/qcomtee/primordial_obj.c  |  50 ++++++++++
 drivers/tee/qcomtee/qcomtee_private.h |  39 ++++++++
 drivers/tee/qcomtee/shm.c             |   3 -
 6 files changed, 270 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/qcomtee/Makefile b/drivers/tee/qcomtee/Makefile
index a3a2d00e83f0..6cb9fd38dc67 100644
--- a/drivers/tee/qcomtee/Makefile
+++ b/drivers/tee/qcomtee/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_QCOMTEE) +=3D qcomtee.o
 qcomtee-objs +=3D async.o
 qcomtee-objs +=3D call.o
 qcomtee-objs +=3D core.o
+qcomtee-objs +=3D mem_obj.o
 qcomtee-objs +=3D primordial_obj.o
 qcomtee-objs +=3D qcom_scm.o
 qcomtee-objs +=3D release.o
diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 9e288723ec21..239ffc24476a 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -110,8 +110,8 @@ void qcomtee_context_del_qtee_object(struct tee_param *pa=
ram,
  * &enum qcomtee_arg_type value. It gets the object's refcount in @arg;
  * the caller should manage to put it afterward.
  *
- * For user objects (i.e. (param->u.objref.flags & QCOMTEE_OBJREF_FLAG_USER)=
),
- * qcomtee_user_param_to_object() calls qcomtee_object_get() to keep a
+ * For non-QTEE objects (i.e. !(param->u.objref.flags &
+ * QCOMTEE_OBJREF_FLAG_TEE)), qcomtee_object_get() is called to keep a
  * temporary copy for the driver as the release of objects are asynchronous
  * and they may go away even before returning from the invocation.
  *
@@ -135,6 +135,9 @@ int qcomtee_objref_to_arg(struct qcomtee_arg *arg, struct=
 tee_param *param,
 	/* param is a QTEE object: */
 	} else if (param->u.objref.flags & QCOMTEE_OBJREF_FLAG_TEE) {
 		err =3D qcomtee_context_find_qtee_object(&arg->o, param, ctx);
+	/* param is a memory object: */
+	} else if (param->u.objref.flags & QCOMTEE_OBJREF_FLAG_MEM) {
+		err =3D qcomtee_memobj_param_to_object(&arg->o, param, ctx);
 	} else {
 		err =3D -EINVAL;
 	}
@@ -181,6 +184,9 @@ int qcomtee_objref_from_arg(struct tee_param *param, stru=
ct qcomtee_arg *arg,
 		if (is_qcomtee_user_object(object))
 			err =3D qcomtee_user_param_from_object(param, object,
 							     ctx);
+		else if (is_qcomtee_memobj_object(object))
+			err =3D qcomtee_memobj_param_from_object(param, object,
+							       ctx);
 		else
 			err =3D -EINVAL;
=20
diff --git a/drivers/tee/qcomtee/mem_obj.c b/drivers/tee/qcomtee/mem_obj.c
new file mode 100644
index 000000000000..e17eb3b3dc2e
--- /dev/null
+++ b/drivers/tee/qcomtee/mem_obj.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/mm.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+
+#include "qcomtee_private.h"
+
+/**
+ * DOC: Memory and Mapping Objects
+ *
+ * QTEE uses memory objects for memory sharing with Linux.
+ * A memory object can be a standard dma_buf or a contiguous memory range,
+ * e.g., tee_shm. A memory object should support one operation: map. When
+ * invoked by QTEE, a mapping object is generated. A mapping object supports
+ * one operation: unmap.
+ *
+ *  (1) To map a memory object, QTEE invokes the primordial object with
+ *      %QCOMTEE_OBJECT_OP_MAP_REGION operation; see
+ *      qcomtee_primordial_obj_dispatch().
+ *  (2) To unmap a memory object, QTEE releases the mapping object which
+ *      calls qcomtee_mem_object_release().
+ *
+ * The map operation is implemented in the primordial object as a privileged
+ * operation instead of qcomtee_mem_object_dispatch(). Otherwise, on
+ * platforms without shm_bridge, a user can trick QTEE into writing to the
+ * kernel memory by passing a user object as a memory object and returning a
+ * random physical address as the result of the mapping request.
+ */
+
+struct qcomtee_mem_object {
+	struct qcomtee_object object;
+	struct tee_shm *shm;
+	/* QTEE requires these felids to be page aligned. */
+	phys_addr_t paddr; /* Physical address of range. */
+	size_t size; /* Size of the range. */
+};
+
+#define to_qcomtee_mem_object(o) \
+	container_of((o), struct qcomtee_mem_object, object)
+
+static struct qcomtee_object_operations qcomtee_mem_object_ops;
+
+/* Is it a memory object using tee_shm? */
+int is_qcomtee_memobj_object(struct qcomtee_object *object)
+{
+	return object !=3D NULL_QCOMTEE_OBJECT &&
+	       typeof_qcomtee_object(object) =3D=3D QCOMTEE_OBJECT_TYPE_CB &&
+	       object->ops =3D=3D &qcomtee_mem_object_ops;
+}
+
+static int qcomtee_mem_object_dispatch(struct qcomtee_object_invoke_ctx *oic,
+				       struct qcomtee_object *object, u32 op,
+				       struct qcomtee_arg *args)
+{
+	return -EINVAL;
+}
+
+static void qcomtee_mem_object_release(struct qcomtee_object *object)
+{
+	struct qcomtee_mem_object *mem_object =3D to_qcomtee_mem_object(object);
+
+	/* Matching get is in qcomtee_memobj_param_to_object(). */
+	tee_shm_put(mem_object->shm);
+	kfree(mem_object);
+}
+
+static struct qcomtee_object_operations qcomtee_mem_object_ops =3D {
+	.release =3D qcomtee_mem_object_release,
+	.dispatch =3D qcomtee_mem_object_dispatch,
+};
+
+/**
+ * qcomtee_memobj_param_to_object() - OBJREF parameter to &struct qcomtee_ob=
ject.
+ * @object: object returned.
+ * @param: TEE parameter.
+ * @ctx: context in which the conversion should happen.
+ *
+ * @param is an OBJREF with %QCOMTEE_OBJREF_FLAG_MEM flags.
+ * It calls qcomtee_object_get() to keep a copy of @object for the driver
+ * as well as a copy for QTEE.
+ *
+ * Return: On success return 0 or <0 on failure.
+ */
+int qcomtee_memobj_param_to_object(struct qcomtee_object **object,
+				   struct tee_param *param,
+				   struct tee_context *ctx)
+{
+	struct qcomtee_mem_object *mem_object __free(kfree) =3D NULL;
+	struct tee_shm *shm;
+	int err;
+
+	mem_object =3D kzalloc(sizeof(*mem_object), GFP_KERNEL);
+	if (!mem_object)
+		return -ENOMEM;
+
+	shm =3D tee_shm_get_from_id(ctx, param->u.objref.id);
+	if (!shm)
+		return -EINVAL;
+
+	/* mem-object wrapping the memref. */
+	err =3D qcomtee_object_user_init(&mem_object->object,
+				       QCOMTEE_OBJECT_TYPE_CB,
+				       &qcomtee_mem_object_ops, "tee-shm-%d",
+				       shm->id);
+	if (err) {
+		tee_shm_put(shm);
+
+		return err;
+	}
+
+	mem_object->paddr =3D shm->paddr;
+	mem_object->size =3D shm->size;
+	mem_object->shm =3D shm;
+
+	*object =3D &no_free_ptr(mem_object)->object;
+	qcomtee_object_get(*object);
+
+	return 0;
+}
+
+/* Reverse what qcomtee_memobj_param_to_object() does. */
+int qcomtee_memobj_param_from_object(struct tee_param *param,
+				     struct qcomtee_object *object,
+				     struct tee_context *ctx)
+{
+	struct qcomtee_mem_object *mem_object;
+
+	mem_object =3D to_qcomtee_mem_object(object);
+	/* Sure if the memobj is in a same context it is originated from. */
+	if (mem_object->shm->ctx !=3D ctx)
+		return -EINVAL;
+
+	param->u.objref.id =3D mem_object->shm->id;
+	param->u.objref.flags =3D QCOMTEE_OBJREF_FLAG_MEM;
+
+	/* Passing shm->id to userspace; drop the reference. */
+	qcomtee_object_put(object);
+
+	return 0;
+}
+
+/**
+ * qcomtee_mem_object_map() - Map a memory object.
+ * @object: memory object.
+ * @map_object: created mapping object.
+ * @mem_paddr: physical address of the memory.
+ * @mem_size: size of the memory.
+ * @perms: QTEE access permissions.
+ *
+ * Return: On success return 0 or <0 on failure.
+ */
+int qcomtee_mem_object_map(struct qcomtee_object *object,
+			   struct qcomtee_object **map_object, u64 *mem_paddr,
+			   u64 *mem_size, u32 *perms)
+{
+	struct qcomtee_mem_object *mem_object =3D to_qcomtee_mem_object(object);
+
+	/* Reuses the memory object as a mapping object by re-sharing it. */
+	qcomtee_object_get(&mem_object->object);
+
+	*map_object =3D &mem_object->object;
+	*mem_paddr =3D mem_object->paddr;
+	*mem_size =3D mem_object->size;
+	*perms =3D QCOM_SCM_PERM_RW;
+
+	return 0;
+}
diff --git a/drivers/tee/qcomtee/primordial_obj.c b/drivers/tee/qcomtee/primo=
rdial_obj.c
index a30967d89c91..598557f09746 100644
--- a/drivers/tee/qcomtee/primordial_obj.c
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -16,18 +16,31 @@
  * for native kernel services or privileged operations.
  *
  * We support:
+ *  - %QCOMTEE_OBJECT_OP_MAP_REGION to map a memory object and return mapping
+ *    object and mapping information (see qcomtee_mem_object_map()).
  *  - %QCOMTEE_OBJECT_OP_YIELD to yield by the thread running in QTEE.
  *  - %QCOMTEE_OBJECT_OP_SLEEP to wait for a period of time.
  */
=20
+#define QCOMTEE_OBJECT_OP_MAP_REGION 0
 #define QCOMTEE_OBJECT_OP_YIELD 1
 #define QCOMTEE_OBJECT_OP_SLEEP 2
=20
+/* Mapping information format as expected by QTEE. */
+struct qcomtee_mapping_info {
+	u64 paddr;
+	u64 len;
+	u32 perms;
+} __packed;
+
 static int
 qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
 				struct qcomtee_object *primordial_object_unused,
 				u32 op, struct qcomtee_arg *args)
 {
+	struct qcomtee_mapping_info *map_info;
+	struct qcomtee_object *mem_object;
+	struct qcomtee_object *map_object;
 	int err =3D 0;
=20
 	switch (op) {
@@ -35,6 +48,7 @@ qcomtee_primordial_obj_dispatch(struct qcomtee_object_invok=
e_ctx *oic,
 		cond_resched();
 		/* No output object. */
 		oic->data =3D NULL;
+
 		break;
 	case QCOMTEE_OBJECT_OP_SLEEP:
 		/* Check message format matched QCOMTEE_OBJECT_OP_SLEEP op. */
@@ -46,6 +60,29 @@ qcomtee_primordial_obj_dispatch(struct qcomtee_object_invo=
ke_ctx *oic,
 		msleep(*(u32 *)(args[0].b.addr));
 		/* No output object. */
 		oic->data =3D NULL;
+
+		break;
+	case QCOMTEE_OBJECT_OP_MAP_REGION:
+		if (qcomtee_args_len(args) !=3D 3 ||
+		    args[0].type !=3D QCOMTEE_ARG_TYPE_OB ||
+		    args[1].type !=3D QCOMTEE_ARG_TYPE_IO ||
+		    args[2].type !=3D QCOMTEE_ARG_TYPE_OO ||
+		    args[0].b.size < sizeof(struct qcomtee_mapping_info))
+			return -EINVAL;
+
+		map_info =3D args[0].b.addr;
+		mem_object =3D args[1].o;
+
+		qcomtee_mem_object_map(mem_object, &map_object,
+				       &map_info->paddr, &map_info->len,
+				       &map_info->perms);
+
+		args[2].o =3D map_object;
+		/* One output object; pass it for cleanup to notify. */
+		oic->data =3D map_object;
+
+		qcomtee_object_put(mem_object);
+
 		break;
 	default:
 		err =3D -EINVAL;
@@ -54,8 +91,21 @@ qcomtee_primordial_obj_dispatch(struct qcomtee_object_invo=
ke_ctx *oic,
 	return err;
 }
=20
+/* Called after submitting the callback response. */
+static void qcomtee_primordial_obj_notify(struct qcomtee_object_invoke_ctx *=
oic,
+					  struct qcomtee_object *unused,
+					  int err)
+{
+	struct qcomtee_object *object =3D oic->data;
+
+	/* If err, QTEE did not obtain mapping object. Drop it. */
+	if (object && err)
+		qcomtee_object_put(object);
+}
+
 static struct qcomtee_object_operations qcomtee_primordial_obj_ops =3D {
 	.dispatch =3D qcomtee_primordial_obj_dispatch,
+	.notify =3D qcomtee_primordial_obj_notify,
 };
=20
 struct qcomtee_object qcomtee_primordial_object =3D {
diff --git a/drivers/tee/qcomtee/qcomtee_private.h b/drivers/tee/qcomtee/qcom=
tee_private.h
index e59cfb3b79dd..a70052803399 100644
--- a/drivers/tee/qcomtee/qcomtee_private.h
+++ b/drivers/tee/qcomtee/qcomtee_private.h
@@ -15,6 +15,7 @@
 /* Flags relating to object reference. */
 #define QCOMTEE_OBJREF_FLAG_TEE BIT(0)
 #define QCOMTEE_OBJREF_FLAG_USER BIT(1)
+#define QCOMTEE_OBJREF_FLAG_MEM BIT(2)
=20
 /**
  * struct qcomtee - Main service struct.
@@ -222,4 +223,42 @@ int qcomtee_user_object_submit(struct tee_context *ctx,
 /* (2) Primordial Object. */
 extern struct qcomtee_object qcomtee_primordial_object;
=20
+/* (3) Memory Object API. */
+
+/* Is it a memory object using tee_shm? */
+int is_qcomtee_memobj_object(struct qcomtee_object *object);
+
+/**
+ * qcomtee_memobj_param_to_object() - OBJREF parameter to &struct qcomtee_ob=
ject.
+ * @object: object returned.
+ * @param: TEE parameter.
+ * @ctx: context in which the conversion should happen.
+ *
+ * @param is an OBJREF with %QCOMTEE_OBJREF_FLAG_MEM flags.
+ *
+ * Return: On success return 0 or <0 on failure.
+ */
+int qcomtee_memobj_param_to_object(struct qcomtee_object **object,
+				   struct tee_param *param,
+				   struct tee_context *ctx);
+
+/* Reverse what qcomtee_memobj_param_to_object() does. */
+int qcomtee_memobj_param_from_object(struct tee_param *param,
+				     struct qcomtee_object *object,
+				     struct tee_context *ctx);
+
+/**
+ * qcomtee_mem_object_map() - Map a memory object.
+ * @object: memory object.
+ * @map_object: created mapping object.
+ * @mem_paddr: physical address of the memory.
+ * @mem_size: size of the memory.
+ * @perms: QTEE access permissions.
+ *
+ * Return: On success return 0 or <0 on failure.
+ */
+int qcomtee_mem_object_map(struct qcomtee_object *object,
+			   struct qcomtee_object **map_object, u64 *mem_paddr,
+			   u64 *mem_size, u32 *perms);
+
 #endif /* QCOMTEE_PRIVATE_H */
diff --git a/drivers/tee/qcomtee/shm.c b/drivers/tee/qcomtee/shm.c
index 998aabe96434..9bdf9e48bfeb 100644
--- a/drivers/tee/qcomtee/shm.c
+++ b/drivers/tee/qcomtee/shm.c
@@ -113,9 +113,6 @@ static int qcomtee_shm_unregister(struct tee_context *ctx=
, struct tee_shm *shm)
 static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
 			 size_t size, size_t align)
 {
-	if (!(shm->flags & TEE_SHM_PRIV))
-		return -ENOMEM;
-
 	return tee_dyn_shm_alloc_helper(shm, size, align, qcomtee_shm_register);
 }
=20

--=20
2.34.1


--===============5738940779830588866==--

