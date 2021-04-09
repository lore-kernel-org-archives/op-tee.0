From: Dan Carpenter <dan.carpenter@oracle.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes 0
Date: Fri, 09 Apr 2021 11:45:41 +0300
Message-ID: <20210409084541.GE6048@kadam>
In-Reply-To: <=?utf-8?q?=3C3150feb19421ca6b15202c853215f8b40fe35567=2E1617615?=
 =?utf-8?q?067=2Egit=2ERijo-john=2EThomas=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6938686745196084225=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6938686745196084225==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 05, 2021 at 03:13:09PM +0530, Rijo Thomas wrote:
> @@ -340,7 +398,8 @@ int handle_open_session(struct tee_ioctl_open_session_a=
rg *arg, u32 *info,
>=20
>  int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg=
 *arg)
>  {
> -	struct tee_cmd_load_ta cmd =3D {0};
> +	struct tee_cmd_unload_ta unload_cmd =3D {0};
> +	struct tee_cmd_load_ta load_cmd =3D {0};

It's better style to write:

	struct tee_cmd_unload_ta unload_cmd =3D {};

It doesn't make a difference in this case, but if the first struct
member is a pointer then {0} can generate a Sparse warning.  Or
depending on which bugs your version of GCC has it can affect whether
struct holes are initialized.  But mostly it's just the prefered style.


regards,
dan carpenter


--===============6938686745196084225==--

