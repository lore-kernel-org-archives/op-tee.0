From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: amdtee: Make use of the helper macro LIST_HEAD()
Date: Wed, 09 Feb 2022 12:46:36 +0530
Message-ID: <302e8426-5a22-23dd-2b3b-7eb6d0ee2e8d@amd.com>
In-Reply-To: <20220209032745.38570-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0437619863241715465=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0437619863241715465==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 2/9/2022 8:57 AM, Cai Huoqing wrote:
> Replace "struct list_head head =3D LIST_HEAD_INIT(head)" with
> "LIST_HEAD(head)" to simplify the code.
>=20
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
>  drivers/tee/amdtee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> index 07f36ac834c8..cec6e70f0ac9 100644
> --- a/drivers/tee/amdtee/call.c
> +++ b/drivers/tee/amdtee/call.c
> @@ -122,7 +122,7 @@ static int amd_params_to_tee_params(struct tee_param *t=
ee, u32 count,
>  }
> =20
>  static DEFINE_MUTEX(ta_refcount_mutex);
> -static struct list_head ta_list =3D LIST_HEAD_INIT(ta_list);
> +static LIST_HEAD(ta_list);
> =20

Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

Thanks,
Rijo

>  static u32 get_ta_refcount(u32 ta_handle)
>  {
>=20

--===============0437619863241715465==--

