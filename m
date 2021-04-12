From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes 0
Date: Mon, 12 Apr 2021 15:45:36 +0530
Message-ID: <b74535f2-b0ab-2463-cac0-ffef8db159af@amd.com>
In-Reply-To: <20210409084541.GE6048@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8487947674799224297=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8487947674799224297==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 09/04/21 2:15 pm, Dan Carpenter wrote:
> On Mon, Apr 05, 2021 at 03:13:09PM +0530, Rijo Thomas wrote:
>> @@ -340,7 +398,8 @@ int handle_open_session(struct tee_ioctl_open_session_=
arg *arg, u32 *info,
>>
>>  int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_ar=
g *arg)
>>  {
>> -	struct tee_cmd_load_ta cmd =3D {0};
>> +	struct tee_cmd_unload_ta unload_cmd =3D {0};
>> +	struct tee_cmd_load_ta load_cmd =3D {0};
>=20
> It's better style to write:
>=20
> 	struct tee_cmd_unload_ta unload_cmd =3D {};
>=20
> It doesn't make a difference in this case, but if the first struct
> member is a pointer then {0} can generate a Sparse warning.  Or
> depending on which bugs your version of GCC has it can affect whether
> struct holes are initialized.  But mostly it's just the prefered style.
>

Hi Dan,

We do not have any pointers nor do I see a possibility of structure holes, si=
nce all data
members are u32 in both struct tee_cmd_load_ta and struct tee_cmd_unload_ta. =
So, will prefer
to use {0} for now.

Thanks,
Rijo
=20
>=20
> regards,
> dan carpenter
>=20

--===============8487947674799224297==--

