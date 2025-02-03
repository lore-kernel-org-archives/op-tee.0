From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 7/8] qcomtee: add primordial object
Date: Sun, 02 Feb 2025 18:43:35 -0800
Message-ID: <20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-7-297eacd0d34f@quicinc.com>
In-Reply-To: <=?utf-8?q?=3C20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-?=
 =?utf-8?q?0-297eacd0d34f=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1280986821919786775=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1280986821919786775==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

After booting, the kernel provides a static object known as the
primordial object. This object is utilized by QTEE for native
kernel services such as yield or privileged operations.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
 drivers/tee/qcomtee/Makefile          |  1 +
 drivers/tee/qcomtee/core.c            | 15 +++++---
 drivers/tee/qcomtee/primordial_obj.c  | 65 +++++++++++++++++++++++++++++++++=
++
 drivers/tee/qcomtee/qcomtee_private.h |  3 ++
 4 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/qcomtee/Makefile b/drivers/tee/qcomtee/Makefile
index 1b14b943e5f5..a3a2d00e83f0 100644
--- a/drivers/tee/qcomtee/Makefile
+++ b/drivers/tee/qcomtee/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_QCOMTEE) +=3D qcomtee.o
 qcomtee-objs +=3D async.o
 qcomtee-objs +=3D call.o
 qcomtee-objs +=3D core.o
+qcomtee-objs +=3D primordial_obj.o
 qcomtee-objs +=3D qcom_scm.o
 qcomtee-objs +=3D release.o
 qcomtee-objs +=3D shm.o
diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index 9dbfcf62678e..5342e9462d9e 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -30,10 +30,12 @@ int qcomtee_next_arg_type(struct qcomtee_arg *u, int i,
 }
=20
 /*
- * QTEE expects IDs with the QCOMTEE_MSG_OBJECT_NS_BIT set for objects
- * of the QCOMTEE_OBJECT_TYPE_CB type.
+ * QTEE expects IDs with QCOMTEE_MSG_OBJECT_NS_BIT set for objects of
+ * QCOMTEE_OBJECT_TYPE_CB type. The first ID with QCOMTEE_MSG_OBJECT_NS_BIT
+ * set is reserved for the primordial object.
  */
-#define QCOMTEE_OBJECT_ID_START (QCOMTEE_MSG_OBJECT_NS_BIT + 1)
+#define QCOMTEE_OBJECT_PRIMORDIAL (QCOMTEE_MSG_OBJECT_NS_BIT)
+#define QCOMTEE_OBJECT_ID_START (QCOMTEE_OBJECT_PRIMORDIAL + 1)
 #define QCOMTEE_OBJECT_ID_END (UINT_MAX)
=20
 #define QCOMTEE_OBJECT_SET(p, type, ...) \
@@ -112,7 +114,9 @@ EXPORT_SYMBOL_GPL(qcomtee_object_get);
  */
 void qcomtee_object_put(struct qcomtee_object *object)
 {
-	if (object !=3D NULL_QCOMTEE_OBJECT && object !=3D ROOT_QCOMTEE_OBJECT)
+	if (object !=3D &qcomtee_primordial_object &&
+	    object !=3D NULL_QCOMTEE_OBJECT &&
+	    object !=3D ROOT_QCOMTEE_OBJECT)
 		kref_put(&object->refcount, qcomtee_object_release);
 }
 EXPORT_SYMBOL_GPL(qcomtee_object_put);
@@ -202,6 +206,9 @@ static struct qcomtee_object *qcomtee_local_object_get(un=
signed int object_id)
 {
 	struct qcomtee_object *object;
=20
+	if (object_id =3D=3D QCOMTEE_OBJECT_PRIMORDIAL)
+		return &qcomtee_primordial_object;
+
 	/*
 	 * This is not protected by an RCU read lock because we are
 	 * confident that QTEE does not issue a RELEASE request and
diff --git a/drivers/tee/qcomtee/primordial_obj.c b/drivers/tee/qcomtee/primo=
rdial_obj.c
new file mode 100644
index 000000000000..a30967d89c91
--- /dev/null
+++ b/drivers/tee/qcomtee/primordial_obj.c
@@ -0,0 +1,65 @@
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
+ * After boot, the kernel provides a static object of type
+ * %QCOMTEE_OBJECT_TYPE_CB called the primordial object. This object is used
+ * for native kernel services or privileged operations.
+ *
+ * We support:
+ *  - %QCOMTEE_OBJECT_OP_YIELD to yield by the thread running in QTEE.
+ *  - %QCOMTEE_OBJECT_OP_SLEEP to wait for a period of time.
+ */
+
+#define QCOMTEE_OBJECT_OP_YIELD 1
+#define QCOMTEE_OBJECT_OP_SLEEP 2
+
+static int
+qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
+				struct qcomtee_object *primordial_object_unused,
+				u32 op, struct qcomtee_arg *args)
+{
+	int err =3D 0;
+
+	switch (op) {
+	case QCOMTEE_OBJECT_OP_YIELD:
+		cond_resched();
+		/* No output object. */
+		oic->data =3D NULL;
+		break;
+	case QCOMTEE_OBJECT_OP_SLEEP:
+		/* Check message format matched QCOMTEE_OBJECT_OP_SLEEP op. */
+		if (qcomtee_args_len(args) !=3D 1 ||
+		    args[0].type !=3D QCOMTEE_ARG_TYPE_IB ||
+		    args[0].b.size < sizeof(u32))
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
+static struct qcomtee_object_operations qcomtee_primordial_obj_ops =3D {
+	.dispatch =3D qcomtee_primordial_obj_dispatch,
+};
+
+struct qcomtee_object qcomtee_primordial_object =3D {
+	.name =3D "primordial",
+	.object_type =3D QCOMTEE_OBJECT_TYPE_CB,
+	.ops =3D &qcomtee_primordial_obj_ops
+};
diff --git a/drivers/tee/qcomtee/qcomtee_private.h b/drivers/tee/qcomtee/qcom=
tee_private.h
index 706c200788a2..e846cb78e195 100644
--- a/drivers/tee/qcomtee/qcomtee_private.h
+++ b/drivers/tee/qcomtee/qcomtee_private.h
@@ -220,4 +220,7 @@ int qcomtee_user_object_submit(struct tee_context *ctx,
 			       struct tee_param *params, int num_params,
 			       int req_id, int errno);
=20
+/* (2) Primordial Object. */
+extern struct qcomtee_object qcomtee_primordial_object;
+
 #endif /* QCOMTEE_PRIVATE_H */

--=20
2.34.1


--===============1280986821919786775==--

