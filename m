From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 06/10] qcomtee: add primordial object
Date: Mon, 02 Dec 2024 20:19:22 -0800
Message-ID: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-6-f502ef01e016@quicinc.com>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?0-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7137032885397986553=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7137032885397986553==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

After booting, the kernel provides a static object known as the primordial
object. This object is utilized by QTEE for native kernel services such as
yield or privileged operations.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
 drivers/tee/qcomtee/Makefile          |  1 +
 drivers/tee/qcomtee/core.c            | 12 +++++--
 drivers/tee/qcomtee/primordial_obj.c  | 63 +++++++++++++++++++++++++++++++++=
++
 drivers/tee/qcomtee/qcomtee_private.h |  5 +++
 4 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/qcomtee/Makefile b/drivers/tee/qcomtee/Makefile
index 7dc5e6373042..108bc7fdabcb 100644
--- a/drivers/tee/qcomtee/Makefile
+++ b/drivers/tee/qcomtee/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_QCOMTEE) +=3D qcomtee.o
 qcomtee-objs +=3D async.o
 qcomtee-objs +=3D core.o
+qcomtee-objs +=3D primordial_obj.o
 qcomtee-objs +=3D qcom_scm.o
 qcomtee-objs +=3D release.o
diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index a949ef4cceee..79f1181cf676 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -34,9 +34,11 @@ int qcom_tee_next_arg_type(struct qcom_tee_arg *u, int i, =
enum qcom_tee_arg_type
 }
=20
 /* QTEE expects IDs with QCOM_TEE_MSG_OBJECT_NS_BIT set for object of
- * QCOM_TEE_OBJECT_TYPE_CB_OBJECT type.
+ * QCOM_TEE_OBJECT_TYPE_CB_OBJECT type. The first ID with QCOM_TEE_MSG_OBJEC=
T_NS_BIT set is
+ * reserved for primordial object.
  */
-#define QCOM_TEE_OBJECT_ID_START	(QCOM_TEE_MSG_OBJECT_NS_BIT + 1)
+#define QCOM_TEE_OBJECT_PRIMORDIAL	(QCOM_TEE_MSG_OBJECT_NS_BIT)
+#define QCOM_TEE_OBJECT_ID_START	(QCOM_TEE_OBJECT_PRIMORDIAL + 1)
 #define QCOM_TEE_OBJECT_ID_END		(UINT_MAX)
=20
 #define QCOM_TEE_OBJECT_SET(p, type, ...) __QCOM_TEE_OBJECT_SET(p, type, ##_=
_VA_ARGS__, 0UL)
@@ -118,7 +120,8 @@ EXPORT_SYMBOL_GPL(qcom_tee_object_get);
  */
 void qcom_tee_object_put(struct qcom_tee_object *object)
 {
-	if (object !=3D NULL_QCOM_TEE_OBJECT &&
+	if (object !=3D &qcom_tee_primordial_object &&
+	    object !=3D NULL_QCOM_TEE_OBJECT &&
 	    object !=3D ROOT_QCOM_TEE_OBJECT)
 		kref_put(&object->refcount, qcom_tee_object_release);
 }
@@ -209,6 +212,9 @@ static struct qcom_tee_object *qcom_tee_local_object_get(=
unsigned int object_id)
 {
 	struct qcom_tee_object *object;
=20
+	if (object_id =3D=3D QCOM_TEE_OBJECT_PRIMORDIAL)
+		return &qcom_tee_primordial_object;
+
 	/* We trust QTEE does not mess the refcounts.
 	 * It does not issue RELEASE request and qcom_tee_object_get(), simultaneou=
sly.
 	 */
diff --git a/drivers/tee/qcomtee/primordial_obj.c b/drivers/tee/qcomtee/primo=
rdial_obj.c
new file mode 100644
index 000000000000..9065074b02e6
--- /dev/null
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include "qcomtee_private.h"
+
+/**
+ * DOC: Primordial Object
+ *
+ * After the boot, REE provides a static object of type %QCOM_TEE_OBJECT_TYP=
E_CB_OBJECT
+ * called primordial object. This object is used for native REE services or =
privileged operations.
+ *
+ * We support
+ *  - %QCOM_TEE_OBJECT_OP_YIELD to yield by the thread running in QTEE.
+ *  - %QCOM_TEE_OBJECT_OP_SLEEP to wait for period of time.
+ */
+
+#define QCOM_TEE_OBJECT_OP_YIELD	1
+#define QCOM_TEE_OBJECT_OP_SLEEP	2
+
+static int qcom_tee_primordial_object_dispatch(struct qcom_tee_object_invoke=
_ctx *oic,
+					       struct qcom_tee_object *primordial_object_unused,
+					       u32 op, struct qcom_tee_arg *args)
+{
+	int err =3D 0;
+
+	switch (op) {
+	case QCOM_TEE_OBJECT_OP_YIELD:
+		cond_resched();
+		/* No output object. */
+		oic->data =3D NULL;
+		break;
+	case QCOM_TEE_OBJECT_OP_SLEEP:
+		/* Check message format matched QCOM_TEE_OBJECT_OP_SLEEP op. */
+		if (qcom_tee_args_len(args) !=3D 1 ||		/* Expect 1 argument. */
+		    args[0].type !=3D QCOM_TEE_ARG_TYPE_IB ||	/* Time to sleep in ms. */
+		    args[0].b.size < sizeof(u32))		/* Buffer should hold a u32. */
+			return -EINVAL;
+
+		msleep(*(u32 *)(args[0].b.addr));
+		/* No output object. */
+		oic->data =3D NULL;
+		break;
+	default:
+		err =3D -EINVAL;
+	}
+
+	return err;
+}
+
+static struct qcom_tee_object_operations qcom_tee_primordial_object_ops =3D {
+	.dispatch =3D qcom_tee_primordial_object_dispatch,
+};
+
+struct qcom_tee_object qcom_tee_primordial_object =3D {
+	.name =3D "primordial",
+	.object_type =3D QCOM_TEE_OBJECT_TYPE_CB_OBJECT,
+	.ops =3D &qcom_tee_primordial_object_ops
+};
diff --git a/drivers/tee/qcomtee/qcomtee_private.h b/drivers/tee/qcomtee/qcom=
tee_private.h
index e3e4ef51c0b2..c718cd2d8463 100644
--- a/drivers/tee/qcomtee/qcomtee_private.h
+++ b/drivers/tee/qcomtee/qcomtee_private.h
@@ -44,4 +44,9 @@ int __qcom_tee_object_do_invoke(struct qcom_tee_object_invo=
ke_ctx *oic,
 				struct qcom_tee_object *object, u32 op,	struct qcom_tee_arg *u,
 				int *result);
=20
+/* OBJECTS: */
+
+/* (1) Primordial Object. */
+extern struct qcom_tee_object qcom_tee_primordial_object;
+
 #endif /* QCOM_TEE_PRIVATE_H */

--=20
2.34.1


--===============7137032885397986553==--

