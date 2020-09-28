From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH] tee: add support for application-based session login methods
Date: Mon, 28 Sep 2020 15:43:47 +0200
Message-ID: <20200928134347.GA76106@jade>
In-Reply-To: <20200917183803.4a0c5263@akathisia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0562570478278028591=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0562570478278028591==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Elvira,

On Thu, Sep 17, 2020 at 06:38:03PM +0300, Elvira Khabirova wrote:
> GP TEE Client API in addition to login methods already supported
> in the kernel also defines several application-based methods:
> TEEC_LOGIN_APPLICATION, TEEC_LOGIN_USER_APPLICATION, and
> TEEC_LOGIN_GROUP_APPLICATION.
>=20
> It specifies credentials generated for TEEC_LOGIN_APPLICATION as only
> depending on the identity of the program, being persistent within one
> implementation, across multiple invocations of the application
> and across power cycles, enabling them to be used to disambiguate
> persistent storage. The exact nature is REE-specific.
>=20
> As the exact method of generating application identifier strings may
> vary between vendors, setups and installations, add two suggested
> methods and an exact framework for vendors to extend upon.
>=20
> Signed-off-by: Elvira Khabirova <e.khabirova@omprussia.ru>
> ---
>  drivers/tee/Kconfig    |  29 +++++++++
>  drivers/tee/tee_core.c | 136 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 164 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> index e99d840c2511..4cd6e0d2aad5 100644
> --- a/drivers/tee/Kconfig
> +++ b/drivers/tee/Kconfig
> @@ -11,6 +11,35 @@ config TEE
>  	  This implements a generic interface towards a Trusted Execution
>  	  Environment (TEE).
> =20
> +choice
> +	prompt "Application ID for client UUID"
> +	depends on TEE
> +	default TEE_APPID_PATH
> +	help
> +	  This option allows to choose which method will be used to generate
> +	  application identifiers for client UUID generation when login methods
> +	  TEE_LOGIN_APPLICATION, TEE_LOGIN_USER_APPLICATION
> +	  and TEE_LOGIN_GROUP_APPLICATION are used.
> +	  Please be mindful of the security of each method in your particular
> +	  installation.
> +
> +	config TEE_APPID_PATH
> +		bool "Path-based application ID"
> +		help
> +		  Use the executable's path as an application ID.
> +
> +	config TEE_APPID_SECURITY
> +		bool "Security extended attribute based application ID"
> +		help
> +		  Use the executable's security extended attribute as an application ID.
> +endchoice
> +
> +config TEE_APPID_SECURITY_XATTR
> +	string "Security extended attribute to use for application ID"
> +	depends on TEE_APPID_SECURITY
> +	help
> +	  Attribute to be used as an application ID (with the security prefix rem=
oved).
> +
>  if TEE
> =20
>  menu "TEE drivers"
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 64637e09a095..19c965dd212b 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -7,8 +7,10 @@
> =20
>  #include <linux/cdev.h>
>  #include <linux/cred.h>
> +#include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/idr.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
> @@ -17,11 +19,15 @@
>  #include <crypto/sha.h>
>  #include "tee_private.h"
> =20
> +#ifdef CONFIG_TEE_APPID_SECURITY
No need for the ifdef, just inlude the file unconditionally above.

> +#include <linux/security.h>
> +#endif
> +
>  #define TEE_NUM_DEVICES	32
> =20
>  #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
> =20
> -#define TEE_UUID_NS_NAME_SIZE	128
> +#define TEE_UUID_NS_NAME_SIZE	PATH_MAX
> =20
>  /*
>   * TEE Client UUID name space identifier (UUIDv4)
> @@ -125,6 +131,67 @@ static int tee_release(struct inode *inode, struct fil=
e *filp)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_TEE_APPID_SECURITY
> +static const char *tee_session_get_application_id(void **data)
static char *get_app_id(void) should be enough.

> +{
> +	struct file *exe_file;
> +	const char *name =3D CONFIG_TEE_APPID_SECURITY_XATTR;
> +	int len;
> +
> +	exe_file =3D get_mm_exe_file(current->mm);
> +	if (!exe_file)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (!exe_file->f_inode) {
> +		fput(exe_file);
> +		return ERR_PTR(-ENOENT);
> +	}
> +

You could perhaps add a comment here on the expected properties of this
data. Something along (don't know if I'm even close) "string
representation of the the hash of the binary and time stamp".

> +	len =3D security_inode_getsecurity(exe_file->f_inode, name, data, true);
> +	if (len < 0)
> +		return ERR_PTR(len);
> +
> +	fput(exe_file);
> +
> +	return *data;
> +}
> +#endif /* CONFIG_TEE_APPID_SECURITY */
> +
> +#ifdef CONFIG_TEE_APPID_PATH
> +static const char *tee_session_get_application_id(void **data)
> +{
> +	struct file *exe_file;
> +	char *path;
> +
> +	*data =3D kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> +	if (!*data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	exe_file =3D get_mm_exe_file(current->mm);
> +	if (!exe_file) {
> +		kfree(*data);
> +		return ERR_PTR(-ENOENT);
> +	}
> +
> +	path =3D file_path(exe_file, *data, TEE_UUID_NS_NAME_SIZE);
> +	if (IS_ERR(path)) {
> +		kfree(*data);
> +		return path;
> +	}
> +
> +	fput(exe_file);
> +
> +	return path;
> +}
> +#endif /* CONFIG_TEE_APPID_PATH */
> +
> +#if defined(CONFIG_TEE_APPID_PATH) || defined(CONFIG_TEE_APPID_SECURITY)
> +static void tee_session_free_application_id(void *data)
> +{
> +	kfree(data);
> +}
This function isn't needed, we can call kfree() directly.

> +#endif /* CONFIG_TEE_APPID_PATH || CONFIG_TEE_APPID_SECURITY */
> +
>  /**
>   * uuid_v5() - Calculate UUIDv5
>   * @uuid: Resulting UUID
> @@ -197,6 +264,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 conn=
ection_method,
>  	gid_t ns_grp =3D (gid_t)-1;
>  	kgid_t grp =3D INVALID_GID;
>  	char *name =3D NULL;
> +	void *application_id_data =3D NULL;
This isn't needed

> +	const char *application_id =3D NULL;
char *app_id =3D NULL;

>  	int name_len;
>  	int rc;
> =20
> @@ -217,6 +286,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 con=
nection_method,
>  	 * For TEEC_LOGIN_GROUP:
>  	 * gid=3D<gid>
>  	 *
> +	 * For TEEC_LOGIN_APPLICATION:
> +	 * app=3D<application id>
> +	 *
> +	 * For TEEC_LOGIN_USER_APPLICATION:
> +	 * uid=3D<uid>:app=3D<application id>
> +	 *
> +	 * For TEEC_LOGIN_GROUP_APPLICATION:
> +	 * gid=3D<gid>:app=3D<application id>
>  	 */
> =20
>  	name =3D kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> @@ -249,6 +326,63 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 con=
nection_method,
>  		}
>  		break;
> =20
> +	case TEE_IOCTL_LOGIN_APPLICATION:
> +		application_id =3D tee_session_get_application_id(&application_id_data);
> +		if (IS_ERR(application_id)) {
> +			rc =3D PTR_ERR(application_id);
> +			goto out_free_name;
> +		}
> +
> +		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=3D%s",
> +				    application_id);
> +		tee_session_free_application_id(application_id_data);
> +
> +		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
> +			rc =3D -E2BIG;
> +			goto out_free_name;
> +		}
It looks like we remove these tests and replace them with
if (name_len < TEE_UUID_NS_NAME_SIZE)
        rc =3D uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
else
        rc =3D -E2BIG

below, just above the "out_free_name:" label.

This function is small and simple enough that it should be easy to see
what's going on any way.

Thanks,
Jens

> +		break;
> +
> +	case TEE_IOCTL_LOGIN_USER_APPLICATION:
> +		application_id =3D tee_session_get_application_id(&application_id_data);
> +		if (IS_ERR(application_id)) {
> +			rc =3D PTR_ERR(application_id);
> +			goto out_free_name;
> +		}
> +
> +		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x:app=3D%s",
> +				    current_euid().val, application_id);
> +		tee_session_free_application_id(application_id_data);
> +
> +		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
> +			rc =3D -E2BIG;
> +			goto out_free_name;
> +		}
> +		break;
> +
> +	case TEE_IOCTL_LOGIN_GROUP_APPLICATION:
> +		memcpy(&ns_grp, connection_data, sizeof(gid_t));
> +		grp =3D make_kgid(current_user_ns(), ns_grp);
> +		if (!gid_valid(grp) || !in_egroup_p(grp)) {
> +			rc =3D -EPERM;
> +			goto out_free_name;
> +		}
> +
> +		application_id =3D tee_session_get_application_id(&application_id_data);
> +		if (IS_ERR(application_id)) {
> +			rc =3D PTR_ERR(application_id);
> +			goto out_free_name;
> +		}
> +		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=3D%x:app=3D%s",
> +				    grp.val, application_id);
> +		tee_session_free_application_id(application_id_data);
> +
> +		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
> +			rc =3D -E2BIG;
> +			goto out_free_name;
> +		}
> +		break;
> +
>  	default:
>  		rc =3D -EINVAL;
>  		goto out_free_name;
> --=20
> 2.28.0
>=20

--===============0562570478278028591==--

