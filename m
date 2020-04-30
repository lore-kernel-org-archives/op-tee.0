From: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [op-tee] [PATCH v2 1/3] tee: add support for session's client UUID generation
Date: Thu, 30 Apr 2020 15:37:09 +0300
Message-ID: <20200430123711.20083-2-vesa.jaaskelainen@vaisala.com>
In-Reply-To: <20200430123711.20083-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7530702888803252517=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7530702888803252517==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

TEE Client API defines that from user space only information needed for
specified login operations is group identifier for group based logins.

REE kernel is expected to formulate trustworthy client UUID and pass that
to TEE environment. REE kernel is required to verify that provided group
identifier for group based logins matches calling processes group
memberships.

TEE specification only defines that the information passed from REE
environment to TEE environment is encoded into on UUID.

In order to guarantee trustworthiness of client UUID user space is not
allowed to freely pass client UUID.

UUIDv5 form is used encode variable amount of information needed for
different login types.

Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@vaisala.=
com>
---
 drivers/tee/Kconfig     |   1 +
 drivers/tee/tee_core.c  | 153 ++++++++++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h |  16 +++++
 3 files changed, 170 insertions(+)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 8da63f38e6bd..806eb87d4da0 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -3,6 +3,7 @@
 config TEE
 	tristate "Trusted Execution Environment support"
 	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
+	select CRYPTO_SHA1
 	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
 	help
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 6aec502c495c..d5db206d6af2 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -6,18 +6,33 @@
 #define pr_fmt(fmt) "%s: " fmt, __func__
=20
 #include <linux/cdev.h>
+#include <linux/cred.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/uaccess.h>
+#include <crypto/hash.h>
+#include <crypto/sha.h>
 #include "tee_private.h"
=20
 #define TEE_NUM_DEVICES	32
=20
 #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
=20
+#define TEE_UUID_NS_NAME_SIZE	128
+
+/*
+ * TEE Client UUID name space identifier (UUIDv4)
+ *
+ * Value here is random UUID that is allocated as name space identifier for
+ * forming Client UUID's for TEE environment using UUIDv5 scheme.
+ */
+static const uuid_t tee_client_uuid_ns =3D UUID_INIT(0x58ac9ca0, 0x2086, 0x4=
683,
+						   0xa1, 0xb8, 0xec, 0x4b,
+						   0xc0, 0x8e, 0x01, 0xb6);
+
 /*
  * Unprivileged devices in the lower half range and privileged devices in
  * the upper half range.
@@ -110,6 +125,144 @@ static int tee_release(struct inode *inode, struct file=
 *filp)
 	return 0;
 }
=20
+/**
+ * uuid_v5() - Calculate UUIDv5
+ * @uuid: Resulting UUID
+ * @ns: Name space ID for UUIDv5 function
+ * @name: Name for UUIDv5 function
+ * @size: Size of name
+ *
+ * UUIDv5 is specific in RFC 4122.
+ *
+ * This implements section (for SHA-1):
+ * 4.3.  Algorithm for Creating a Name-Based UUID
+ */
+static int uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
+		   size_t size)
+{
+	unsigned char hash[SHA1_DIGEST_SIZE];
+	struct crypto_shash *shash =3D NULL;
+	struct shash_desc *desc =3D NULL;
+	int rc;
+
+	shash =3D crypto_alloc_shash("sha1", 0, 0);
+	if (IS_ERR(shash)) {
+		rc =3D PTR_ERR(shash);
+		pr_err("shash(sha1) allocation failed\n");
+		return rc;
+	}
+
+	desc =3D kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
+		       GFP_KERNEL);
+	if (!desc) {
+		rc =3D -ENOMEM;
+		goto out_free_shash;
+	}
+
+	desc->tfm =3D shash;
+
+	rc =3D crypto_shash_init(desc);
+	if (rc < 0)
+		goto out_free_desc;
+
+	rc =3D crypto_shash_update(desc, (const u8 *)ns, sizeof(*ns));
+	if (rc < 0)
+		goto out_free_desc;
+
+	rc =3D crypto_shash_update(desc, (const u8 *)name, size);
+	if (rc < 0)
+		goto out_free_desc;
+
+	rc =3D crypto_shash_final(desc, hash);
+	if (rc < 0)
+		goto out_free_desc;
+
+	memcpy(uuid->b, hash, UUID_SIZE);
+
+	/* Tag for version 5 */
+	uuid->b[6] =3D (hash[6] & 0x0F) | 0x50;
+	uuid->b[8] =3D (hash[8] & 0x3F) | 0x80;
+
+out_free_desc:
+	kfree(desc);
+
+out_free_shash:
+	crypto_free_shash(shash);
+	return rc;
+}
+
+int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
+				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
+{
+	const char *application_id =3D NULL;
+	gid_t ns_grp =3D (gid_t)-1;
+	kgid_t grp =3D INVALID_GID;
+	char *name =3D NULL;
+	int name_len;
+	int rc;
+
+	if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC) {
+		/* Nil UUID to be passed to TEE environment */
+		uuid_copy(uuid, &uuid_null);
+		return 0;
+	}
+
+	/*
+	 * In Linux environment client UUID is based on UUIDv5.
+	 *
+	 * Determine client UUID with following semantics for 'name':
+	 *
+	 * For TEEC_LOGIN_USER:
+	 * uid=3D<uid>
+	 *
+	 * For TEEC_LOGIN_GROUP:
+	 * gid=3D<gid>
+	 *
+	 */
+
+	name =3D kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	switch (connection_method) {
+	case TEE_IOCTL_LOGIN_USER:
+		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x",
+				    current_euid().val);
+		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
+			rc =3D -E2BIG;
+			goto out_free_name;
+		}
+		break;
+
+	case TEE_IOCTL_LOGIN_GROUP:
+		memcpy(&ns_grp, connection_data, sizeof(gid_t));
+		grp =3D make_kgid(current_user_ns(), ns_grp);
+		if (!gid_valid(grp) || !in_egroup_p(grp)) {
+			rc =3D -EPERM;
+			goto out_free_name;
+		}
+
+		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=3D%x",
+				    grp.val);
+		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
+			rc =3D -E2BIG;
+			goto out_free_name;
+		}
+		break;
+
+	default:
+		rc =3D -EINVAL;
+		goto out_free_name;
+	}
+
+	rc =3D uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
+out_free_name:
+	kfree(name);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tee_session_calc_client_uuid);
+
 static int tee_ioctl_version(struct tee_context *ctx,
 			     struct tee_ioctl_version_data __user *uvers)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 1412e9cc79ce..8471b790e858 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -165,6 +165,22 @@ int tee_device_register(struct tee_device *teedev);
  */
 void tee_device_unregister(struct tee_device *teedev);
=20
+/**
+ * tee_session_calc_client_uuid() - Calculates client UUID for session
+ * @uuid:		Resulting UUID
+ * @connection_method:	Connection method for session (TEE_IOCTL_LOGIN_*)
+ * @connectuon_data:	Connection data for opening session
+ *
+ * Based on connection method calculates UUIDv5 based client UUID.
+ *
+ * For group based logins verifies that calling process has specified
+ * credentials.
+ *
+ * @return < 0 on failure
+ */
+int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
+				 const u8 connection_data[TEE_IOCTL_UUID_LEN]);
+
 /**
  * struct tee_shm - shared memory object
  * @ctx:	context using the object
--=20
2.17.1


--===============7530702888803252517==--

