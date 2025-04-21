From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 04/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
Date: Mon, 21 Apr 2025 19:08:11 +0530
Message-ID: <aAZKQyslOSs-A3Jv@sumit-X1>
In-Reply-To: <=?utf-8?q?=3C20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-?=
 =?utf-8?q?4-7f457073282d=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8822684306073069889=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8822684306073069889==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 07:47:26PM -0700, Amirreza Zarrabi wrote:
> The TEE subsystem allows session-based access to trusted services,
> requiring a session to be established to receive a service. This
> is not suitable for an environment that represents services as objects.
> An object supports various operations that a client can invoke,
> potentially generating a result or a new object that can be invoked
> independently of the original object.
>=20
> Add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT/INOUT to represent an
> object. Objects may reside in either TEE or userspace. To invoke an
> object in TEE, introduce a new ioctl. Use the existing SUPPL_RECV and
> SUPPL_SEND to invoke an object in userspace.
>=20
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/tee_core.c   | 85 ++++++++++++++++++++++++++++++++++++++++++++=
++++
>  include/linux/tee_core.h |  4 +++
>  include/linux/tee_drv.h  |  6 ++++
>  include/uapi/linux/tee.h | 41 +++++++++++++++++++----
>  4 files changed, 130 insertions(+), 6 deletions(-)

Minor nits from me below, otherwise this looks reasonable new IOCTL
interface to me. FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

>=20
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index bc862a11d437..d39205128b09 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -397,6 +397,7 @@ static int params_from_user(struct tee_context *ctx, st=
ruct tee_param *params,
>  		switch (ip.attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
>  			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
> @@ -415,6 +416,11 @@ static int params_from_user(struct tee_context *ctx, s=
truct tee_param *params,
>  				return -EFAULT;
> =20
>  			break;
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
> +			params[n].u.objref.id =3D ip.a;
> +			params[n].u.objref.flags =3D ip.b;
> +			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> @@ -488,6 +494,12 @@ static int params_to_user(struct tee_ioctl_param __use=
r *uparams,
>  			if (put_user((u64)p->u.ubuf.size, &up->b))
>  				return -EFAULT;
>  			break;
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
> +			if (put_user(p->u.objref.id, &up->a) ||
> +			    put_user(p->u.objref.flags, &up->b))
> +				return -EFAULT;
> +			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>  			if (put_user((u64)p->u.memref.size, &up->b))
> @@ -640,6 +652,66 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
>  	return rc;
>  }
> =20
> +static int tee_ioctl_object_invoke(struct tee_context *ctx,
> +				   struct tee_ioctl_buf_data __user *ubuf)
> +{
> +	int rc;
> +	size_t n;
> +	struct tee_ioctl_buf_data buf;
> +	struct tee_ioctl_object_invoke_arg __user *uarg;
> +	struct tee_ioctl_object_invoke_arg arg;
> +	struct tee_ioctl_param __user *uparams =3D NULL;
> +	struct tee_param *params =3D NULL;
> +
> +	if (!ctx->teedev->desc->ops->object_invoke_func)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&buf, ubuf, sizeof(buf)))
> +		return -EFAULT;
> +
> +	if (buf.buf_len > TEE_MAX_ARG_SIZE ||
> +	    buf.buf_len < sizeof(struct tee_ioctl_object_invoke_arg))
> +		return -EINVAL;
> +
> +	uarg =3D u64_to_user_ptr(buf.buf_ptr);
> +	if (copy_from_user(&arg, uarg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) !=3D buf.buf_len)
> +		return -EINVAL;
> +
> +	if (arg.num_params) {
> +		params =3D kcalloc(arg.num_params, sizeof(struct tee_param),
> +				 GFP_KERNEL);
> +		if (!params)
> +			return -ENOMEM;
> +		uparams =3D uarg->params;
> +		rc =3D params_from_user(ctx, params, arg.num_params, uparams);
> +		if (rc)
> +			goto out;
> +	}
> +
> +	rc =3D ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
> +	if (rc)
> +		goto out;
> +
> +	if (put_user(arg.ret, &uarg->ret)) {
> +		rc =3D -EFAULT;
> +		goto out;
> +	}
> +	rc =3D params_to_user(uparams, arg.num_params, params);
> +out:
> +	if (params) {
> +		/* Decrease ref count for all valid shared memory pointers */
> +		for (n =3D 0; n < arg.num_params; n++)
> +			if (tee_param_is_memref(params + n) &&
> +			    params[n].u.memref.shm)
> +				tee_shm_put(params[n].u.memref.shm);
> +		kfree(params);
> +	}
> +	return rc;
> +}
> +
>  static int tee_ioctl_cancel(struct tee_context *ctx,
>  			    struct tee_ioctl_cancel_arg __user *uarg)
>  {
> @@ -695,6 +767,12 @@ static int params_to_supp(struct tee_context *ctx,
>  			ip.b =3D p->u.ubuf.size;
>  			ip.c =3D 0;
>  			break;
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
> +			ip.a =3D p->u.objref.id;
> +			ip.b =3D p->u.objref.flags;
> +			ip.c =3D 0;
> +			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> @@ -807,6 +885,11 @@ static int params_from_supp(struct tee_param *params, =
size_t num_params,
>  				return -EFAULT;
> =20
>  			break;
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
> +			p->u.objref.id =3D ip.a;
> +			p->u.objref.flags =3D ip.b;
> +			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>  			/*
> @@ -887,6 +970,8 @@ static long tee_ioctl(struct file *filp, unsigned int c=
md, unsigned long arg)
>  		return tee_ioctl_open_session(ctx, uarg);
>  	case TEE_IOC_INVOKE:
>  		return tee_ioctl_invoke(ctx, uarg);
> +	case TEE_IOC_OBJECT_INVOKE:
> +		return tee_ioctl_object_invoke(ctx, uarg);
>  	case TEE_IOC_CANCEL:
>  		return tee_ioctl_cancel(ctx, uarg);
>  	case TEE_IOC_CLOSE_SESSION:
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index 8a4c9e30b652..26b8795cb678 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -72,6 +72,7 @@ struct tee_device {
>   * @close_session:	close a session
>   * @system_session:	declare session as a system session
>   * @invoke_func:	invoke a trusted function
> + * @object_invoke_func:	invoke a TEE object
>   * @cancel_req:		request cancel of an ongoing invoke or open
>   * @supp_recv:		called for supplicant to get a command
>   * @supp_send:		called for supplicant to send a response
> @@ -97,6 +98,9 @@ struct tee_driver_ops {
>  	int (*invoke_func)(struct tee_context *ctx,
>  			   struct tee_ioctl_invoke_arg *arg,
>  			   struct tee_param *param);
> +	int (*object_invoke_func)(struct tee_context *ctx,
> +				  struct tee_ioctl_object_invoke_arg *arg,
> +				  struct tee_param *param);
>  	int (*cancel_req)(struct tee_context *ctx, u32 cancel_id, u32 session);
>  	int (*supp_recv)(struct tee_context *ctx, u32 *func, u32 *num_params,
>  			 struct tee_param *param);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index d773f91c6bdd..7cc57e84db95 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -87,6 +87,11 @@ struct tee_param_ubuf {
>  	size_t size;
>  };
> =20
> +struct tee_param_objref {
> +	u64 id;
> +	u64 flags;
> +};
> +
>  struct tee_param_value {
>  	u64 a;
>  	u64 b;
> @@ -97,6 +102,7 @@ struct tee_param {
>  	u64 attr;
>  	union {
>  		struct tee_param_memref memref;
> +		struct tee_param_objref objref;
>  		struct tee_param_ubuf ubuf;
>  		struct tee_param_value value;
>  	} u;
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index 3e9b1ec5dfde..8642ce7e4772 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -48,8 +48,10 @@
>  #define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplican=
t) */
>  #define TEE_GEN_CAP_REG_MEM	(1 << 2)/* Supports registering shared memory =
*/
>  #define TEE_GEN_CAP_MEMREF_NULL	(1 << 3)/* NULL MemRef support */
> +#define TEE_GEN_CAP_OBJREF	(1 << 4)/* Supports generic object reference */
> =20
> -#define TEE_MEMREF_NULL		(__u64)(-1) /* NULL MemRef Buffer */
> +#define TEE_MEMREF_NULL		((__u64)(-1)) /* NULL MemRef Buffer */
> +#define TEE_OBJREF_NULL		((__u64)(-1)) /* NULL ObjRef Object */
> =20
>  /*
>   * TEE Implementation ID
> @@ -158,6 +160,13 @@ struct tee_ioctl_buf_data {
>  #define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT	9
>  #define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT	10	/* input and output */
> =20
> +/*
> + * These defines object reference parameters.
> + */
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT	11
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT	12
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT	13
> +
>  /*
>   * Mask for the type part of the attribute, leaves room for more types
>   */
> @@ -195,15 +204,16 @@ struct tee_ioctl_buf_data {
>   * @attr: attributes
>   * @a: if a memref, offset into the shared memory object,
>   *     else if a ubuf, address of the user buffer,
> - *     else a value parameter
> - * @b: if a memref or ubuf, size of the buffer, else a value parameter
> + *     else if an objref, object identifier, else a value parameter
> + * @b: if a memref or ubuf, size of the buffer,
> + *     else if objref, flags for the object, else a value parameter
>   * @c: if a memref, shared memory identifier, else a value parameter
>   *
>   * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, ubuf, or value is
>   * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
> - * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TYPE_=
UBUF_*
> - * indicates ubuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the mem=
bers
> - * are used.
> + * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, TEE_PARAM_ATTR_TYPE_UBUF=
_*
> + * indicates ubuf, and TEE_PARAM_ATTR_TYPE_OBJREF_* indicates objref.
> + * TEE_PARAM_ATTR_TYPE_NONE indicates that none of the members are used.
>   *
>   * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
>   * identifier representing the shared memory object. A memref can reference
> @@ -411,4 +421,23 @@ struct tee_ioctl_shm_register_data {
>   * munmap(): unmaps previously shared memory
>   */
> =20
> +/**
> + * struct tee_ioctl_invoke_func_arg - Invokes an object in a Trusted Appli=
cation
> + * @object:	[in] Object id
> + * @op:		[in] Object operation, specific to the object
> + * @ret:	[out] return value
> + * @num_params	[in] number of parameters following this struct
> + */
> +struct tee_ioctl_object_invoke_arg {
> +	__u64 object;

nit: I would rather rename it as: s/object/id/

> +	__u32 op;
> +	__u32 ret;

nit: do you think ret_origin will add value here? It is useful to know
from which stack layer the error originated from.

-Sumit

> +	__u32 num_params;
> +	/* num_params tells the actual number of element in params */
> +	struct tee_ioctl_param params[];
> +};
> +
> +#define TEE_IOC_OBJECT_INVOKE	_IOR(TEE_IOC_MAGIC, TEE_IOC_BASE + 10, \
> +				     struct tee_ioctl_buf_data)
> +
>  #endif /*__TEE_H*/
>=20
> --=20
> 2.34.1
>=20
>=20

--===============8822684306073069889==--

