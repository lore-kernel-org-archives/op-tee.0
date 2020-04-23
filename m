From: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
To: op-tee@lists.trustedfirmware.org
Subject: [op-tee] [PATCH 3/3] [RFC] tee: add support for app id for client
 UUID generation
Date: Thu, 23 Apr 2020 18:17:01 +0300
Message-ID: <20200423151701.111231-4-vesa.jaaskelainen@vaisala.com>
In-Reply-To: <20200423151701.111231-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2386476802648307569=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2386476802648307569==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Linux kernel does not provide common contex for application identifier,
instead different security frameworks provide own means to define
application identifier for running process. Code includes place holder for
such solutions but is left for later implementation.

Open questions:

1. App ID source

How to specify what source is used for app id?

Does it need to be protected on runtime?
- Should this be Kconfig setting?
- Cnfigure once during runtime thru sysfs or so?
- Configure from device tree?

2. Formatting for App ID

Should there be common format? Or common keyword id?

3. How to handle custom App ID sources

Android has own App ID so does Tizen.

Should there be place holder for this where to make local patch?

Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@vaisala.=
com>
---
 drivers/tee/tee_core.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 872272bf9dec..df03bd0071da 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -125,6 +125,15 @@ static int tee_release(struct inode *inode, struct file =
*filp)
 	return 0;
 }
=20
+static const char *tee_session_get_application_id(void)
+{
+	return NULL;
+}
+
+static void tee_session_free_application_id(const char *app_id)
+{
+}
+
 /**
  * uuid_v5() - Calculate UUIDv5
  * @uuid: Resulting UUID
@@ -217,6 +226,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 conne=
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
@@ -240,6 +257,34 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 conne=
ction_method,
 		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=3D%x", grp.val);
 		break;
=20
+	case TEE_IOCTL_LOGIN_APPLICATION:
+		application_id =3D tee_session_get_application_id();
+		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "app=3D%s",
+			  application_id);
+		tee_session_free_application_id(application_id);
+		break;
+
+	case TEE_IOCTL_LOGIN_USER_APPLICATION:
+		application_id =3D tee_session_get_application_id();
+		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x:app=3D%s",
+			  current_euid().val, application_id);
+		tee_session_free_application_id(application_id);
+		break;
+
+	case TEE_IOCTL_LOGIN_GROUP_APPLICATION:
+		memcpy(&ns_grp, connection_data, sizeof(gid_t));
+		grp =3D make_kgid(current_user_ns(), ns_grp);
+		if (!gid_valid(grp) || !in_egroup_p(grp)) {
+			rc =3D -EPERM;
+			goto out;
+		}
+
+		application_id =3D tee_session_get_application_id();
+		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=3D%x:app=3D%s",
+			  grp.val, application_id);
+		tee_session_free_application_id(application_id);
+		break;
+
 	default:
 		rc =3D -EINVAL;
 		goto out;
--=20
2.17.1


--===============2386476802648307569==--

