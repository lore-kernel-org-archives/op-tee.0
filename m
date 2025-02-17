From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 4/8] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
Date: Tue, 18 Feb 2025 10:50:01 +1100
Message-ID: <368f665d-6380-4896-b173-aa987d4bf8ad@quicinc.com>
In-Reply-To: <20250217102815.GC2637163@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6505509135711002613=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6505509135711002613==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 2/17/2025 9:28 PM, Jens Wiklander wrote:
> Hi,
>=20
> On Sun, Feb 02, 2025 at 06:43:32PM -0800, Amirreza Zarrabi wrote:
>> The TEE subsystem allows session-based access to trusted services,
>> requiring a session to be established to receive a service. This
>> is not suitable for an environment that represents services as objects.
>> An object supports various operations that a client can invoke,
>> potentially generating a result or a new object that can be invoked
>> independently of the original object.
>>
>> Add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT/INOUT to represent an
>> object. Objects may reside in either TEE or userspace. To invoke an
>> object in TEE, introduce a new ioctl. Use the existing SUPPL_RECV and
>> SUPPL_SEND to invoke an object in userspace.
>>
>> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
>> ---
>>  drivers/tee/tee_core.c   | 85 +++++++++++++++++++++++++++++++++++++++++++=
+++++
>>  include/linux/tee_core.h |  4 +++
>>  include/linux/tee_drv.h  |  6 ++++
>>  include/uapi/linux/tee.h | 41 +++++++++++++++++++----
>>  4 files changed, 130 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index 9f4b9a995e16..fe435772688c 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -379,6 +379,7 @@ static int params_from_user(struct tee_context *ctx, s=
truct tee_param *params,
>>  		switch (ip.attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
>> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
>>  			break;
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
>> @@ -396,6 +397,11 @@ static int params_from_user(struct tee_context *ctx, =
struct tee_param *params,
>>  				return -EFAULT;
>> =20
>>  			break;
>> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
>> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
>> +			params[n].u.objref.id =3D ip.a;
>> +			params[n].u.objref.flags =3D ip.b;
>> +			break;
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>> @@ -469,6 +475,12 @@ static int params_to_user(struct tee_ioctl_param __us=
er *uparams,
>>  			if (put_user((u64)p->u.ubuf.size, &up->b))
>>  				return -EFAULT;
>>  			break;
>> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
>> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
>> +			if (put_user(p->u.objref.id, &up->a) ||
>> +			    put_user(p->u.objref.flags, &up->b))
>> +				return -EFAULT;
>> +			break;
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>>  			if (put_user((u64)p->u.memref.size, &up->b))
>> @@ -621,6 +633,66 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
>>  	return rc;
>>  }
>> =20
>> +static int tee_ioctl_object_invoke(struct tee_context *ctx,
>> +				   struct tee_ioctl_buf_data __user *ubuf)
>> +{
>> +	int rc;
>> +	size_t n;
>> +	struct tee_ioctl_buf_data buf;
>> +	struct tee_ioctl_object_invoke_arg __user *uarg;
>> +	struct tee_ioctl_object_invoke_arg arg;
>> +	struct tee_ioctl_param __user *uparams =3D NULL;
>> +	struct tee_param *params =3D NULL;
>> +
>> +	if (!ctx->teedev->desc->ops->object_invoke_func)
>> +		return -EINVAL;
>> +
>> +	if (copy_from_user(&buf, ubuf, sizeof(buf)))
>> +		return -EFAULT;
>> +
>> +	if (buf.buf_len > TEE_MAX_ARG_SIZE ||
>> +	    buf.buf_len < sizeof(struct tee_ioctl_object_invoke_arg))
>> +		return -EINVAL;
>> +
>> +	uarg =3D u64_to_user_ptr(buf.buf_ptr);
>> +	if (copy_from_user(&arg, uarg, sizeof(arg)))
>> +		return -EFAULT;
>> +
>> +	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) !=3D buf.buf_len)
>> +		return -EINVAL;
>> +
>> +	if (arg.num_params) {
>> +		params =3D kcalloc(arg.num_params, sizeof(struct tee_param),
>> +				 GFP_KERNEL);
>> +		if (!params)
>> +			return -ENOMEM;
>> +		uparams =3D uarg->params;
>> +		rc =3D params_from_user(ctx, params, arg.num_params, uparams);
>> +		if (rc)
>> +			goto out;
>> +	}
>> +
>> +	rc =3D ctx->teedev->desc->ops->object_invoke_func(ctx, &arg, params);
>> +	if (rc)
>> +		goto out;
>> +
>> +	if (put_user(arg.ret, &uarg->ret)) {
>> +		rc =3D -EFAULT;
>> +		goto out;
>> +	}
>> +	rc =3D params_to_user(uparams, arg.num_params, params);
>> +out:
>> +	if (params) {
>> +		/* Decrease ref count for all valid shared memory pointers */
>> +		for (n =3D 0; n < arg.num_params; n++)
>> +			if (tee_param_is_memref(params + n) &&
>> +			    params[n].u.memref.shm)
>> +				tee_shm_put(params[n].u.memref.shm);
>> +		kfree(params);
>> +	}
>> +	return rc;
>> +}
>> +
>>  static int tee_ioctl_cancel(struct tee_context *ctx,
>>  			    struct tee_ioctl_cancel_arg __user *uarg)
>>  {
>> @@ -676,6 +748,12 @@ static int params_to_supp(struct tee_context *ctx,
>>  			ip.b =3D p->u.ubuf.size;
>>  			ip.c =3D 0;
>>  			break;
>> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
>> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
>> +			ip.a =3D p->u.objref.id;
>> +			ip.b =3D p->u.objref.flags;
>> +			ip.c =3D 0;
>> +			break;
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>> @@ -783,6 +861,11 @@ static int params_from_supp(struct tee_param *params,=
 size_t num_params,
>>  			p->u.ubuf.uaddr =3D u64_to_user_ptr(ip.a);
>>  			p->u.ubuf.size =3D ip.b;
>>  			break;
>> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
>> +		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT:
>> +			p->u.objref.id =3D ip.a;
>> +			p->u.objref.flags =3D ip.b;
>> +			break;
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>>  		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>>  			/*
>> @@ -863,6 +946,8 @@ static long tee_ioctl(struct file *filp, unsigned int =
cmd, unsigned long arg)
>>  		return tee_ioctl_open_session(ctx, uarg);
>>  	case TEE_IOC_INVOKE:
>>  		return tee_ioctl_invoke(ctx, uarg);
>> +	case TEE_IOC_OBJECT_INVOKE:
>> +		return tee_ioctl_object_invoke(ctx, uarg);
>>  	case TEE_IOC_CANCEL:
>>  		return tee_ioctl_cancel(ctx, uarg);
>>  	case TEE_IOC_CLOSE_SESSION:
>> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
>> index 8a4c9e30b652..ffb04c946c70 100644
>> --- a/include/linux/tee_core.h
>> +++ b/include/linux/tee_core.h
>> @@ -72,6 +72,7 @@ struct tee_device {
>>   * @close_session:	close a session
>>   * @system_session:	declare session as a system session
>>   * @invoke_func:	invoke a trusted function
>> + * @object_invoke_func:	invoke an object
>=20
> invoke a TEE object?

I'll update.

>=20
>>   * @cancel_req:		request cancel of an ongoing invoke or open
>>   * @supp_recv:		called for supplicant to get a command
>>   * @supp_send:		called for supplicant to send a response
>> @@ -97,6 +98,9 @@ struct tee_driver_ops {
>>  	int (*invoke_func)(struct tee_context *ctx,
>>  			   struct tee_ioctl_invoke_arg *arg,
>>  			   struct tee_param *param);
>> +	int (*object_invoke_func)(struct tee_context *ctx,
>> +				  struct tee_ioctl_object_invoke_arg *arg,
>> +				  struct tee_param *param);
>>  	int (*cancel_req)(struct tee_context *ctx, u32 cancel_id, u32 session);
>>  	int (*supp_recv)(struct tee_context *ctx, u32 *func, u32 *num_params,
>>  			 struct tee_param *param);
>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>> index 130782d4d5f6..16dad7a21910 100644
>> --- a/include/linux/tee_drv.h
>> +++ b/include/linux/tee_drv.h
>> @@ -87,6 +87,11 @@ struct tee_param_ubuf {
>>  	size_t size;
>>  };
>> =20
>> +struct tee_param_objref {
>> +	u64 id;
>> +	u64 flags;
>> +};
>> +
>>  struct tee_param_value {
>>  	u64 a;
>>  	u64 b;
>> @@ -97,6 +102,7 @@ struct tee_param {
>>  	u64 attr;
>>  	union {
>>  		struct tee_param_memref memref;
>> +		struct tee_param_objref objref;
>>  		struct tee_param_ubuf ubuf;
>>  		struct tee_param_value value;
>>  	} u;
>> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
>> index 4a1dcfb4290e..0aef647d4a34 100644
>> --- a/include/uapi/linux/tee.h
>> +++ b/include/uapi/linux/tee.h
>> @@ -48,8 +48,10 @@
>>  #define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplica=
nt) */
>>  #define TEE_GEN_CAP_REG_MEM	(1 << 2)/* Supports registering shared memory=
 */
>>  #define TEE_GEN_CAP_MEMREF_NULL	(1 << 3)/* NULL MemRef support */
>> +#define TEE_GEN_CAP_OBJREF	(1 << 4)/* Supports generic object reference */
>> =20
>> -#define TEE_MEMREF_NULL		(__u64)(-1) /* NULL MemRef Buffer */
>> +#define TEE_MEMREF_NULL		((__u64)(-1)) /* NULL MemRef Buffer */
>> +#define TEE_OBJREF_NULL		((__u64)(-1)) /* NULL ObjRef Object */
>> =20
>>  /*
>>   * TEE Implementation ID
>> @@ -158,6 +160,13 @@ struct tee_ioctl_buf_data {
>>  #define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT	9
>>  #define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT	10	/* input and output */
>> =20
>> +/*
>> + * These defines object reference parameters.
>> + */
>> +#define TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT	11
>> +#define TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT	12
>> +#define TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT	13
>> +
>>  /*
>>   * Mask for the type part of the attribute, leaves room for more types
>>   */
>> @@ -195,15 +204,16 @@ struct tee_ioctl_buf_data {
>>   * @attr: attributes
>>   * @a: if a memref, offset into the shared memory object,
>>   *     else if a ubuf, address into the user buffer,
>> - *     else a value parameter
>> - * @b: if a memref or ubuf, size of the buffer, else a value parameter
>> + *     else if an objref, object identifier, else a value parameter
>> + * @b: if a memref or ubuf, size of the buffer,
>> + *     else if objref, a flag for object, else a value parameter
>=20
> flags for the object?
>=20
>>   * @c: if a memref, shared memory identifier, else a value parameter
>>   *
>>   * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, ubuf, or value is
>>   * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
>> - * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TYPE=
_UBUF_*
>> - * indicates ubuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the me=
mbers
>> - * are used.
>> + * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, TEE_PARAM_ATTR_TYPE_UBU=
F_*
>> + * indicates ubuf, and TEE_PARAM_ATTR_TYPE_OBJREF_* indicates objref.
>> + * TEE_PARAM_ATTR_TYPE_NONE indicates that none of the members are used.
>>   *
>>   * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
>>   * identifier representing the shared memory object. A memref can referen=
ce
>> @@ -411,4 +421,23 @@ struct tee_ioctl_shm_register_data {
>>   * munmap(): unmaps previously shared memory
>>   */
>> =20
>> +/**
>> + * struct tee_ioctl_invoke_func_arg - Invokes an object in a Trusted Appl=
ication.
>=20
> Please drop the terminating '.'.
>=20
> Thanks,
> Jens

Ack.

Thanks,
Amir

>=20
>> + * @object:	[in] Object id
>> + * @op:		[in] Object operation, specific to the object
>> + * @ret:	[out] return value
>> + * @num_params	[in] number of parameters following this struct
>> + */
>> +struct tee_ioctl_object_invoke_arg {
>> +	__u64 object;
>> +	__u32 op;
>> +	__u32 ret;
>> +	__u32 num_params;
>> +	/* num_params tells the actual number of element in params */
>> +	struct tee_ioctl_param params[];
>> +};
>> +
>> +#define TEE_IOC_OBJECT_INVOKE	_IOR(TEE_IOC_MAGIC, TEE_IOC_BASE + 10, \
>> +				     struct tee_ioctl_buf_data)
>> +
>>  #endif /*__TEE_H*/
>>
>> --=20
>> 2.34.1
>>


--===============6505509135711002613==--

