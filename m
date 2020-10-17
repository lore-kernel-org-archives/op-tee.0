From: Elvira Khabirova <e.khabirova@omprussia.ru>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v4] tee: add support for application-based session login methods
Date: Sat, 17 Oct 2020 20:02:18 +0300
Message-ID: <20201017200218.5d532d73@akathisia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4598622879766726167=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4598622879766726167==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

GP TEE Client API in addition to login methods already supported
in the kernel also defines several application-based methods:
TEEC_LOGIN_APPLICATION, TEEC_LOGIN_USER_APPLICATION, and
TEEC_LOGIN_GROUP_APPLICATION.

It specifies credentials generated for TEEC_LOGIN_APPLICATION as only
depending on the identity of the program, being persistent within one
implementation, across multiple invocations of the application
and across power cycles, enabling them to be used to disambiguate
persistent storage. The exact nature is REE-specific.

As the exact method of generating application identifier strings may
vary between vendors, setups and installations, add two suggested
methods and an exact framework for vendors to extend upon.

Signed-off-by: Elvira Khabirova <e.khabirova@omprussia.ru>
---
Changes in v4:
- Fix potential exe_file leaks.

Changes in v3:
- Remove free_app_id() and replace it with calls to kfree().

Changes in v2:
- Rename some functions and variables to make them shorter.
- Include linux/security.h unconditionally.
- Restructure error handling in tee_session_calc_client_uuid().
---
 drivers/tee/Kconfig    |  29 ++++++++++
 drivers/tee/tee_core.c | 126 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index e99d840c2511..4cd6e0d2aad5 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -11,6 +11,35 @@ config TEE
 	  This implements a generic interface towards a Trusted Execution
 	  Environment (TEE).
=20
+choice
+	prompt "Application ID for client UUID"
+	depends on TEE
+	default TEE_APPID_PATH
+	help
+	  This option allows to choose which method will be used to generate
+	  application identifiers for client UUID generation when login methods
+	  TEE_LOGIN_APPLICATION, TEE_LOGIN_USER_APPLICATION
+	  and TEE_LOGIN_GROUP_APPLICATION are used.
+	  Please be mindful of the security of each method in your particular
+	  installation.
+
+	config TEE_APPID_PATH
+		bool "Path-based application ID"
+		help
+		  Use the executable's path as an application ID.
+
+	config TEE_APPID_SECURITY
+		bool "Security extended attribute based application ID"
+		help
+		  Use the executable's security extended attribute as an application ID.
+endchoice
+
+config TEE_APPID_SECURITY_XATTR
+	string "Security extended attribute to use for application ID"
+	depends on TEE_APPID_SECURITY
+	help
+	  Attribute to be used as an application ID (with the security prefix remov=
ed).
+
 if TEE
=20
 menu "TEE drivers"
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 64637e09a095..a72b8c19253a 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -7,9 +7,12 @@
=20
 #include <linux/cdev.h>
 #include <linux/cred.h>
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
+#include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/uaccess.h>
@@ -21,7 +24,7 @@
=20
 #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
=20
-#define TEE_UUID_NS_NAME_SIZE	128
+#define TEE_UUID_NS_NAME_SIZE	PATH_MAX
=20
 /*
  * TEE Client UUID name space identifier (UUIDv4)
@@ -125,6 +128,65 @@ static int tee_release(struct inode *inode, struct file =
*filp)
 	return 0;
 }
=20
+#ifdef CONFIG_TEE_APPID_SECURITY
+static const char *get_app_id(void **data)
+{
+	struct file *exe_file;
+	const char *name =3D CONFIG_TEE_APPID_SECURITY_XATTR;
+	int len;
+
+	exe_file =3D get_mm_exe_file(current->mm);
+	if (!exe_file)
+		return ERR_PTR(-ENOENT);
+
+	if (!exe_file->f_inode) {
+		fput(exe_file);
+		return ERR_PTR(-ENOENT);
+	}
+
+	/*
+	 * An identifier string for the binary. Depends on the implementation.
+	 * Could be, for example, a string containing the application vendor ID,
+	 * or the binary's signature, or its hash and a timestamp.
+	 */
+	len =3D security_inode_getsecurity(exe_file->f_inode, name, data, true);
+	fput(exe_file);
+
+	if (len < 0)
+		return ERR_PTR(len);
+
+	return *data;
+}
+#endif /* CONFIG_TEE_APPID_SECURITY */
+
+#ifdef CONFIG_TEE_APPID_PATH
+static const char *get_app_id(void **data)
+{
+	struct file *exe_file;
+	char *path;
+
+	*data =3D kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
+	if (!*data)
+		return ERR_PTR(-ENOMEM);
+
+	exe_file =3D get_mm_exe_file(current->mm);
+	if (!exe_file) {
+		kfree(*data);
+		return ERR_PTR(-ENOENT);
+	}
+
+	path =3D file_path(exe_file, *data, TEE_UUID_NS_NAME_SIZE);
+	fput(exe_file);
+
+	if (IS_ERR(path)) {
+		kfree(*data);
+		return path;
+	}
+
+	return path;
+}
+#endif /* CONFIG_TEE_APPID_PATH */
+
 /**
  * uuid_v5() - Calculate UUIDv5
  * @uuid: Resulting UUID
@@ -197,6 +259,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connec=
tion_method,
 	gid_t ns_grp =3D (gid_t)-1;
 	kgid_t grp =3D INVALID_GID;
 	char *name =3D NULL;
+	void *app_id_data =3D NULL;
+	const char *app_id =3D NULL;
 	int name_len;
 	int rc;
=20
@@ -217,6 +281,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 conne=
ction_method,
 	 * For TEEC_LOGIN_GROUP:
 	 * gid=3D<gid>
 	 *
+	 * For TEEC_LOGIN_APPLICATION:
+	 * app=3D<application id>
+	 *
+	 * For TEEC_LOGIN_USER_APPLICATION:
+	 * uid=3D<uid>:app=3D<application id>
+	 *
+	 * For TEEC_LOGIN_GROUP_APPLICATION:
+	 * gid=3D<gid>:app=3D<application id>
 	 */
=20
 	name =3D kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
@@ -227,10 +299,6 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 conne=
ction_method,
 	case TEE_IOCTL_LOGIN_USER:
 		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x",
 				    current_euid().val);
-		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
-			rc =3D -E2BIG;
-			goto out_free_name;
-		}
 		break;
=20
 	case TEE_IOCTL_LOGIN_GROUP:
@@ -243,10 +311,49 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 conn=
ection_method,
=20
 		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=3D%x",
 				    grp.val);
-		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
-			rc =3D -E2BIG;
+		break;
+
+	case TEE_IOCTL_LOGIN_APPLICATION:
+		app_id =3D get_app_id(&app_id_data);
+		if (IS_ERR(app_id)) {
+			rc =3D PTR_ERR(app_id);
+			goto out_free_name;
+		}
+
+		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=3D%s",
+				    app_id);
+		kfree(app_id_data);
+		break;
+
+	case TEE_IOCTL_LOGIN_USER_APPLICATION:
+		app_id =3D get_app_id(&app_id_data);
+		if (IS_ERR(app_id)) {
+			rc =3D PTR_ERR(app_id);
 			goto out_free_name;
 		}
+
+		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x:app=3D%s",
+				    current_euid().val, app_id);
+		kfree(app_id_data);
+		break;
+
+	case TEE_IOCTL_LOGIN_GROUP_APPLICATION:
+		memcpy(&ns_grp, connection_data, sizeof(gid_t));
+		grp =3D make_kgid(current_user_ns(), ns_grp);
+		if (!gid_valid(grp) || !in_egroup_p(grp)) {
+			rc =3D -EPERM;
+			goto out_free_name;
+		}
+
+		app_id =3D get_app_id(&app_id_data);
+		if (IS_ERR(app_id)) {
+			rc =3D PTR_ERR(app_id);
+			goto out_free_name;
+		}
+
+		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=3D%x:app=3D%s",
+				    grp.val, app_id);
+		kfree(app_id_data);
 		break;
=20
 	default:
@@ -254,7 +361,10 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 conne=
ction_method,
 		goto out_free_name;
 	}
=20
-	rc =3D uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
+	if (name_len < TEE_UUID_NS_NAME_SIZE)
+		rc =3D uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
+	else
+		rc =3D -E2BIG;
 out_free_name:
 	kfree(name);
=20
--=20
2.28.0


--===============4598622879766726167==--

