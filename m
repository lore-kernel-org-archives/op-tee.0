From: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4] tee: add support for application-based session login methods
Date: Tue, 22 Dec 2020 12:16:53 +0200
Message-ID: <253db25d-2d87-d125-92c2-2f9979167023@vaisala.com>
In-Reply-To: <20201017200218.5d532d73@akathisia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1762145119326853692=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1762145119326853692==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Elvira,

Sorry for not noticing this earlier.

And thanks for working on the application ID part.

On 2020-10-17 20:02, Elvira Khabirova wrote:
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
> Changes in v4:
> - Fix potential exe_file leaks.
>=20
> Changes in v3:
> - Remove free_app_id() and replace it with calls to kfree().
>=20
> Changes in v2:
> - Rename some functions and variables to make them shorter.
> - Include linux/security.h unconditionally.
> - Restructure error handling in tee_session_calc_client_uuid().
> ---
>   drivers/tee/Kconfig    |  29 ++++++++++
>   drivers/tee/tee_core.c | 126 ++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 147 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> index e99d840c2511..4cd6e0d2aad5 100644
> --- a/drivers/tee/Kconfig
> +++ b/drivers/tee/Kconfig
> @@ -11,6 +11,35 @@ config TEE
>   	  This implements a generic interface towards a Trusted Execution
>   	  Environment (TEE).
>  =20
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
>   if TEE
>  =20
>   menu "TEE drivers"
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 64637e09a095..a72b8c19253a 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -7,9 +7,12 @@
>  =20
>   #include <linux/cdev.h>
>   #include <linux/cred.h>
> +#include <linux/file.h>
>   #include <linux/fs.h>
>   #include <linux/idr.h>
> +#include <linux/mm.h>
>   #include <linux/module.h>
> +#include <linux/security.h>
>   #include <linux/slab.h>
>   #include <linux/tee_drv.h>
>   #include <linux/uaccess.h>
> @@ -21,7 +24,7 @@
>  =20
>   #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
>  =20
> -#define TEE_UUID_NS_NAME_SIZE	128
> +#define TEE_UUID_NS_NAME_SIZE	PATH_MAX

Just wondering should we get rid of this limit.

>  =20
>   /*
>    * TEE Client UUID name space identifier (UUIDv4)
> @@ -125,6 +128,65 @@ static int tee_release(struct inode *inode, struct fil=
e *filp)
>   	return 0;
>   }
>  =20
> +#ifdef CONFIG_TEE_APPID_SECURITY
> +static const char *get_app_id(void **data)
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
> +	/*
> +	 * An identifier string for the binary. Depends on the implementation.
> +	 * Could be, for example, a string containing the application vendor ID,
> +	 * or the binary's signature, or its hash and a timestamp.
> +	 */
> +	len =3D security_inode_getsecurity(exe_file->f_inode, name, data, true);
> +	fput(exe_file);

This is all about binary being executed and might be good for many purposes.

Just wondering as we have security context in process should we be=20
getting it from there instead? (struct cred::security)

Problem with that is that it is very security framework specific and=20
then code in here would need to be aware what security framework is=20
plugged in and so on -- so it can get complex.

There are some application launchers that setup security context and=20
then that is persisted for child processes. How that works in upstream=20
kernel today I cannot say.

If we rename CONFIG_TEE_APPID_SECURITY to more specific what happens=20
here then one could extend it later for those inherited credential cases=20
-- so perhaps rename as CONFIG_TEE_APPID_FS_XATTR_SECURITY or so?

> +
> +	if (len < 0)
> +		return ERR_PTR(len);
> +
> +	return *data;
> +}
> +#endif /* CONFIG_TEE_APPID_SECURITY */
> +
> +#ifdef CONFIG_TEE_APPID_PATH
> +static const char *get_app_id(void **data)
> +{
> +	struct file *exe_file;
> +	char *path;
> +
> +	*data =3D kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);

If we change this to PATH_MAX then we don't need to worry that in here.=20
This is anyway allocating the memory and then would follow the right=20
thing in here whatever the value of TEE_UUID_NS_NAME_SIZE would be.

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
> +	fput(exe_file);

I suppose there is a problem with file_path() in here.

It internally uses d_path() and I believe it is subject to chroot() and=20
someone could fake it a bit.

So we might want to use d_absolute_path() instead to get absolute path=20
that cannot be faked with chroot().

It seems that apparmor, ima and tomoyo is using d_absolute_path() to=20
some degree. There are some traces of namespace stuff in those=20
frameworks so I am wondering what is the right thing to do here?

> +
> +	if (IS_ERR(path)) {
> +		kfree(*data);
> +		return path;
> +	}
> +
> +	return path;
> +}
> +#endif /* CONFIG_TEE_APPID_PATH */
> +
>   /**
>    * uuid_v5() - Calculate UUIDv5
>    * @uuid: Resulting UUID
> @@ -197,6 +259,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 conn=
ection_method,
>   	gid_t ns_grp =3D (gid_t)-1;
>   	kgid_t grp =3D INVALID_GID;
>   	char *name =3D NULL;
> +	void *app_id_data =3D NULL;
> +	const char *app_id =3D NULL;
>   	int name_len;
>   	int rc;
>  =20
> @@ -217,6 +281,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 con=
nection_method,
>   	 * For TEEC_LOGIN_GROUP:
>   	 * gid=3D<gid>
>   	 *
> +	 * For TEEC_LOGIN_APPLICATION:
> +	 * app=3D<application id>
> +	 *
> +	 * For TEEC_LOGIN_USER_APPLICATION:
> +	 * uid=3D<uid>:app=3D<application id>
> +	 *
> +	 * For TEEC_LOGIN_GROUP_APPLICATION:
> +	 * gid=3D<gid>:app=3D<application id>
>   	 */
>  =20
>   	name =3D kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);

If we would move this inside to switch() then each option could handle=20
the size how it needs to be handled.

> @@ -227,10 +299,6 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 con=
nection_method,
>   	case TEE_IOCTL_LOGIN_USER:
>   		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x",
>   				    current_euid().val);
> -		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
> -			rc =3D -E2BIG;
> -			goto out_free_name;
> -		}
>   		break;
>  =20
>   	case TEE_IOCTL_LOGIN_GROUP:
> @@ -243,10 +311,49 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 co=
nnection_method,
>  =20
>   		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=3D%x",
>   				    grp.val);
> -		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
> -			rc =3D -E2BIG;
> +		break;
> +
> +	case TEE_IOCTL_LOGIN_APPLICATION:
> +		app_id =3D get_app_id(&app_id_data);
> +		if (IS_ERR(app_id)) {
> +			rc =3D PTR_ERR(app_id);
> +			goto out_free_name;
> +		}
> +

... then in here we could allocate the right amount of memory and be=20
gone for any limits.

name_len =3D snprintf(NULL, 0, ...);

then

kzalloc(name_len + 1, ...)

and then final snprintf(name, name_len + 1, ...);

Then we would be rid of this artificial TEE_UUID_NS_NAME_SIZE limit.

> +		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=3D%s",
> +				    app_id);
> +		kfree(app_id_data);
> +		break;

Thanks,
Vesa J=C3=A4=C3=A4skel=C3=A4inen

--===============1762145119326853692==--

