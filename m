From: David Laight <David.Laight@ACULAB.COM>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH] optee: add error checks in optee_ffa_do_call_with_arg()
Date: Wed, 19 Jan 2022 14:18:03 +0000
Message-ID: <bf3c1583f8d7466a96bab8feb462bb36@AcuMS.aculab.com>
In-Reply-To: <20220119080736.2940906-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7113637229486343185=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7113637229486343185==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Jens Wiklander
> Sent: 19 January 2022 08:08
>=20
> Adds error checking in optee_ffa_do_call_with_arg() for correctness.
>=20
> Fixes: 4615e5a34b95 ("optee: add FF-A support")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index d8c8683863aa..d88bd2e41572 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -619,9 +619,18 @@ static int optee_ffa_do_call_with_arg(struct tee_conte=
xt *ctx,
>  		.data2 =3D (u32)(shm->sec_world_id >> 32),
>  		.data3 =3D shm->offset,
>  	};
> -	struct optee_msg_arg *arg =3D tee_shm_get_va(shm, 0);
> -	unsigned int rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> -	struct optee_msg_arg *rpc_arg =3D tee_shm_get_va(shm, rpc_arg_offs);
> +	struct optee_msg_arg *arg;
> +	unsigned int rpc_arg_offs;
> +	struct optee_msg_arg *rpc_arg;
> +
> +	arg =3D tee_shm_get_va(shm, 0);
> +	if (IS_ERR(arg))
> +		return PTR_ERR(arg);
> +
> +	rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> +	rpc_arg =3D tee_shm_get_va(shm, rpc_arg_offs);
> +	if (IS_ERR(arg))
> +		return PTR_ERR(arg);

What's this duplicate test for?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT=
, UK
Registration No: 1397386 (Wales)


--===============7113637229486343185==--

