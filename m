From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 3/8] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Date: Mon, 17 Feb 2025 11:10:03 +0100
Message-ID: <20250217101003.GB2637163@rayden>
In-Reply-To: <=?utf-8?q?=3C20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-?=
 =?utf-8?q?3-297eacd0d34f=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1176796935018166867=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1176796935018166867==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2025 at 06:43:31PM -0800, Amirreza Zarrabi wrote:
> For drivers that can transfer data to the TEE without using shared
> memory from client, it is necessary to receive the user address
> directly, bypassing any processing by the TEE subsystem. Introduce
> TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT/OUTPUT/INOUT to represent
> userspace buffers.
>=20
> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
> ---
>  drivers/tee/tee_core.c   | 27 +++++++++++++++++++++++++++
>  include/linux/tee_drv.h  |  6 ++++++
>  include/uapi/linux/tee.h | 22 ++++++++++++++++------
>  3 files changed, 49 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 721522fe5c63..9f4b9a995e16 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -386,6 +386,16 @@ static int params_from_user(struct tee_context *ctx, s=
truct tee_param *params,
>  			params[n].u.value.b =3D ip.b;
>  			params[n].u.value.c =3D ip.c;
>  			break;
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
> +			params[n].u.ubuf.uaddr =3D u64_to_user_ptr(ip.a);
> +			params[n].u.ubuf.size =3D ip.b;
> +
> +			if (!access_ok(params[n].u.ubuf.uaddr, params[n].u.ubuf.size))

This line is over 80 columns,
https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-str=
ings

> +				return -EFAULT;
> +
> +			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> @@ -454,6 +464,11 @@ static int params_to_user(struct tee_ioctl_param __use=
r *uparams,
>  			    put_user(p->u.value.c, &up->c))
>  				return -EFAULT;
>  			break;
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
> +			if (put_user((u64)p->u.ubuf.size, &up->b))
> +				return -EFAULT;
> +			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>  			if (put_user((u64)p->u.memref.size, &up->b))
> @@ -654,6 +669,13 @@ static int params_to_supp(struct tee_context *ctx,
>  			ip.b =3D p->u.value.b;
>  			ip.c =3D p->u.value.c;
>  			break;
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
> +			ip.a =3D (u64)p->u.ubuf.uaddr;
> +			ip.b =3D p->u.ubuf.size;
> +			ip.c =3D 0;
> +			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> @@ -756,6 +778,11 @@ static int params_from_supp(struct tee_param *params, =
size_t num_params,
>  			p->u.value.b =3D ip.b;
>  			p->u.value.c =3D ip.c;
>  			break;
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
> +			p->u.ubuf.uaddr =3D u64_to_user_ptr(ip.a);

Is this needed? Compare with how TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_* is
handled below. If it's indeed needed, please add an access_ok() check.

> +			p->u.ubuf.size =3D ip.b;
> +			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>  			/*
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index d5f0c70ac95c..130782d4d5f6 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -82,6 +82,11 @@ struct tee_param_memref {
>  	struct tee_shm *shm;
>  };
> =20
> +struct tee_param_ubuf {
> +	void * __user uaddr;
> +	size_t size;
> +};
> +
>  struct tee_param_value {
>  	u64 a;
>  	u64 b;
> @@ -92,6 +97,7 @@ struct tee_param {
>  	u64 attr;
>  	union {
>  		struct tee_param_memref memref;
> +		struct tee_param_ubuf ubuf;
>  		struct tee_param_value value;
>  	} u;
>  };
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index d0430bee8292..4a1dcfb4290e 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -151,6 +151,13 @@ struct tee_ioctl_buf_data {
>  #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT	6
>  #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT	7	/* input and output */
> =20
> +/*
> + * These defines userspace buffer parameters.
> + */
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT	8
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT	9
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT	10	/* input and output */
> +
>  /*
>   * Mask for the type part of the attribute, leaves room for more types
>   */
> @@ -186,14 +193,17 @@ struct tee_ioctl_buf_data {
>  /**
>   * struct tee_ioctl_param - parameter
>   * @attr: attributes
> - * @a: if a memref, offset into the shared memory object, else a value par=
ameter
> - * @b: if a memref, size of the buffer, else a value parameter
> + * @a: if a memref, offset into the shared memory object,
> + *     else if a ubuf, address into the user buffer,

address _of_ the user buffer?

Thanks,
Jens

> + *     else a value parameter
> + * @b: if a memref or ubuf, size of the buffer, else a value parameter
>   * @c: if a memref, shared memory identifier, else a value parameter
>   *
> - * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref or value is used in
> - * the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value and
> - * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref. TEE_PARAM_ATTR_TYPE_NONE
> - * indicates that none of the members are used.
> + * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, ubuf, or value is
> + * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
> + * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TYPE_=
UBUF_*
> + * indicates ubuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the mem=
bers
> + * are used.
>   *
>   * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
>   * identifier representing the shared memory object. A memref can reference
>=20
> --=20
> 2.34.1
>=20

--===============1176796935018166867==--

