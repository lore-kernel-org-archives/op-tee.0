From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 02/10] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF
Date: Mon, 02 Dec 2024 20:19:18 -0800
Message-ID: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-2-f502ef01e016@quicinc.com>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?0-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7957682909500322543=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7957682909500322543==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

For drivers that can transfer data to the TEE without needing shared
memory from client, it is necessary to receive the user address
directly, bypassing any processing by the TEE subsystem. Introduce
TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT/OUTPUT/INOUT to represent
userspace buffers.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
 drivers/tee/tee_core.c   | 26 ++++++++++++++++++++++++++
 include/linux/tee_drv.h  |  6 ++++++
 include/uapi/linux/tee.h | 22 ++++++++++++++++------
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 24edce4cdbaa..942ff5b359b2 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -381,6 +381,16 @@ static int params_from_user(struct tee_context *ctx, str=
uct tee_param *params,
 			params[n].u.value.b =3D ip.b;
 			params[n].u.value.c =3D ip.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
+			params[n].u.membuf.uaddr =3D u64_to_user_ptr(ip.a);
+			params[n].u.membuf.size =3D ip.b;
+
+			if (!access_ok(params[n].u.membuf.uaddr, params[n].u.membuf.size))
+				return -EFAULT;
+
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -449,6 +459,11 @@ static int params_to_user(struct tee_ioctl_param __user =
*uparams,
 			    put_user(p->u.value.c, &up->c))
 				return -EFAULT;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
+			if (put_user((u64)p->u.membuf.size, &up->b))
+				return -EFAULT;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			if (put_user((u64)p->u.memref.size, &up->b))
@@ -649,6 +664,12 @@ static int params_to_supp(struct tee_context *ctx,
 			ip.b =3D p->u.value.b;
 			ip.c =3D p->u.value.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
+			ip.a =3D (u64)p->u.membuf.uaddr;
+			ip.b =3D p->u.membuf.size;
+			ip.c =3D 0;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -751,6 +772,11 @@ static int params_from_supp(struct tee_param *params, si=
ze_t num_params,
 			p->u.value.b =3D ip.b;
 			p->u.value.c =3D ip.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
+			p->u.membuf.uaddr =3D u64_to_user_ptr(ip.a);
+			p->u.membuf.size =3D ip.b;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			/*
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index a54c203000ed..b66e611fece4 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -82,6 +82,11 @@ struct tee_param_memref {
 	struct tee_shm *shm;
 };
=20
+struct tee_param_membuf {
+	void * __user uaddr;
+	size_t size;
+};
+
 struct tee_param_value {
 	u64 a;
 	u64 b;
@@ -92,6 +97,7 @@ struct tee_param {
 	u64 attr;
 	union {
 		struct tee_param_memref memref;
+		struct tee_param_membuf membuf;
 		struct tee_param_value value;
 	} u;
 };
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index d0430bee8292..fae68386968a 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -151,6 +151,13 @@ struct tee_ioctl_buf_data {
 #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT	6
 #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT	7	/* input and output */
=20
+/*
+ * These defines memory buffer parameters.
+ */
+#define TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT	8
+#define TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT	9
+#define TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT	10	/* input and output */
+
 /*
  * Mask for the type part of the attribute, leaves room for more types
  */
@@ -186,14 +193,17 @@ struct tee_ioctl_buf_data {
 /**
  * struct tee_ioctl_param - parameter
  * @attr: attributes
- * @a: if a memref, offset into the shared memory object, else a value param=
eter
- * @b: if a memref, size of the buffer, else a value parameter
+ * @a: if a memref, offset into the shared memory object,
+ *     else if a membuf, address into the user buffer,
+ *     else a value parameter
+ * @b: if a memref or membuf, size of the buffer, else a value parameter
  * @c: if a memref, shared memory identifier, else a value parameter
  *
- * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref or value is used in
- * the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value and
- * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref. TEE_PARAM_ATTR_TYPE_NONE
- * indicates that none of the members are used.
+ * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, membuf, or value is
+ * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
+ * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TYPE_ME=
MBUF_*
+ * indicates membuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the mem=
bers
+ * are used.
  *
  * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
  * identifier representing the shared memory object. A memref can reference

--=20
2.34.1


--===============7957682909500322543==--

