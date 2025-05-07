From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 07/14] tee: refactor params_from_user()
Date: Wed, 07 May 2025 18:23:01 +0530
Message-ID: <aBtXrbZ6DByMl6b4@sumit-X1>
In-Reply-To: <20250502100049.1746335-8-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0374423455630472179=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0374423455630472179==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 11:59:21AM +0200, Jens Wiklander wrote:
> Break out the memref handling into a separate helper function.
> No change in behavior.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c | 94 ++++++++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 40 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 685afcaa3ea1..820e394b9054 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -353,6 +353,55 @@ tee_ioctl_shm_register(struct tee_context *ctx,
>  	return ret;
>  }
> =20
> +static int param_from_user_memref(struct tee_context *ctx,
> +				  struct tee_param_memref *memref,
> +				  struct tee_ioctl_param *ip)
> +{
> +	struct tee_shm *shm;
> +
> +	/*
> +	 * If a NULL pointer is passed to a TA in the TEE,
> +	 * the ip.c IOCTL parameters is set to TEE_MEMREF_NULL
> +	 * indicating a NULL memory reference.
> +	 */
> +	if (ip->c !=3D TEE_MEMREF_NULL) {
> +		/*
> +		 * If we fail to get a pointer to a shared
> +		 * memory object (and increase the ref count)
> +		 * from an identifier we return an error. All
> +		 * pointers that has been added in params have
> +		 * an increased ref count. It's the callers
> +		 * responibility to do tee_shm_put() on all
> +		 * resolved pointers.
> +		 */
> +		shm =3D tee_shm_get_from_id(ctx, ip->c);
> +		if (IS_ERR(shm))
> +			return PTR_ERR(shm);
> +
> +		/*
> +		 * Ensure offset + size does not overflow
> +		 * offset and does not overflow the size of
> +		 * the referred shared memory object.
> +		 */
> +		if ((ip->a + ip->b) < ip->a ||
> +		    (ip->a + ip->b) > shm->size) {
> +			tee_shm_put(shm);
> +			return -EINVAL;
> +		}
> +	} else if (ctx->cap_memref_null) {
> +		/* Pass NULL pointer to OP-TEE */
> +		shm =3D NULL;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	memref->shm_offs =3D ip->a;
> +	memref->size =3D ip->b;
> +	memref->shm =3D shm;
> +
> +	return 0;
> +}
> +
>  static int params_from_user(struct tee_context *ctx, struct tee_param *par=
ams,
>  			    size_t num_params,
>  			    struct tee_ioctl_param __user *uparams)
> @@ -360,8 +409,8 @@ static int params_from_user(struct tee_context *ctx, st=
ruct tee_param *params,
>  	size_t n;
> =20
>  	for (n =3D 0; n < num_params; n++) {
> -		struct tee_shm *shm;
>  		struct tee_ioctl_param ip;
> +		int rc;
> =20
>  		if (copy_from_user(&ip, uparams + n, sizeof(ip)))
>  			return -EFAULT;
> @@ -384,45 +433,10 @@ static int params_from_user(struct tee_context *ctx, =
struct tee_param *params,
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> -			/*
> -			 * If a NULL pointer is passed to a TA in the TEE,
> -			 * the ip.c IOCTL parameters is set to TEE_MEMREF_NULL
> -			 * indicating a NULL memory reference.
> -			 */
> -			if (ip.c !=3D TEE_MEMREF_NULL) {
> -				/*
> -				 * If we fail to get a pointer to a shared
> -				 * memory object (and increase the ref count)
> -				 * from an identifier we return an error. All
> -				 * pointers that has been added in params have
> -				 * an increased ref count. It's the callers
> -				 * responibility to do tee_shm_put() on all
> -				 * resolved pointers.
> -				 */
> -				shm =3D tee_shm_get_from_id(ctx, ip.c);
> -				if (IS_ERR(shm))
> -					return PTR_ERR(shm);
> -
> -				/*
> -				 * Ensure offset + size does not overflow
> -				 * offset and does not overflow the size of
> -				 * the referred shared memory object.
> -				 */
> -				if ((ip.a + ip.b) < ip.a ||
> -				    (ip.a + ip.b) > shm->size) {
> -					tee_shm_put(shm);
> -					return -EINVAL;
> -				}
> -			} else if (ctx->cap_memref_null) {
> -				/* Pass NULL pointer to OP-TEE */
> -				shm =3D NULL;
> -			} else {
> -				return -EINVAL;
> -			}
> -
> -			params[n].u.memref.shm_offs =3D ip.a;
> -			params[n].u.memref.size =3D ip.b;
> -			params[n].u.memref.shm =3D shm;
> +			rc =3D param_from_user_memref(ctx, &params[n].u.memref,
> +						    &ip);
> +			if (rc)
> +				return rc;
>  			break;
>  		default:
>  			/* Unknown attribute */
> --=20
> 2.43.0
>=20

--===============0374423455630472179==--

