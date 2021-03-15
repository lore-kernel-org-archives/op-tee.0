From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: amdtee: unload TA only when its refcount becomes 0
Date: Mon, 15 Mar 2021 10:29:10 +0100
Message-ID: <20210315092910.GA1707987@jade>
In-Reply-To: <=?utf-8?q?=3C4fafc43b8b6bb779fea87ecc5579afaab8a5f3ad=2E1615097?=
 =?utf-8?q?779=2Egit=2ERijo-john=2EThomas=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5305484948843558001=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5305484948843558001==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 07, 2021 at 12:05:01PM +0530, Rijo Thomas wrote:
> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
>=20
> If it is a single instance TA, the TA should not get unloaded from AMD
> Secure Processor, while it is still in use in another TEE context.
>=20
> Therefore reference count TA and unload it when the count becomes zero.
>=20
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
>  drivers/tee/amdtee/amdtee_private.h | 13 +++++
>  drivers/tee/amdtee/call.c           | 73 +++++++++++++++++++++++++++--
>  drivers/tee/amdtee/core.c           | 15 +++---
>  3 files changed, 92 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdte=
e_private.h
> index 337c8d82f74e..6d0f7062bb87 100644
> --- a/drivers/tee/amdtee/amdtee_private.h
> +++ b/drivers/tee/amdtee/amdtee_private.h
> @@ -21,6 +21,7 @@
>  #define TEEC_SUCCESS			0x00000000
>  #define TEEC_ERROR_GENERIC		0xFFFF0000
>  #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
> +#define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
>  #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
> =20
>  #define TEEC_ORIGIN_COMMS		0x00000002
> @@ -93,6 +94,18 @@ struct amdtee_shm_data {
>  	u32     buf_id;
>  };
> =20
> +/**
> + * struct amdtee_ta_data - Keeps track of all TAs loaded in AMD Secure
> + *			   Processor
> + * @ta_handle:	Handle to TA loaded in TEE
> + * @refcount:	Reference count for the loaded TA
> + */
> +struct amdtee_ta_data {
> +	struct list_head list_node;
> +	u32 ta_handle;
> +	u32 refcount;
> +};
> +
>  #define LOWER_TWO_BYTE_MASK	0x0000FFFF
> =20
>  /**
> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> index 096dd4d92d39..e10601417ea3 100644
> --- a/drivers/tee/amdtee/call.c
> +++ b/drivers/tee/amdtee/call.c
> @@ -121,15 +121,69 @@ static int amd_params_to_tee_params(struct tee_param =
*tee, u32 count,
>  	return ret;
>  }
> =20
> +static DEFINE_MUTEX(ta_refcount_mutex);
> +static struct list_head ta_list =3D LIST_HEAD_INIT(ta_list);
> +
> +static u32 get_ta_refcount(u32 ta_handle)
> +{
> +	struct amdtee_ta_data *ta_data;
> +	u32 count =3D 0;
> +
> +	/* Caller must hold a mutex */
> +	list_for_each_entry(ta_data, &ta_list, list_node)
> +		if (ta_data->ta_handle =3D=3D ta_handle)
> +			return ++ta_data->refcount;
> +
> +	ta_data =3D kzalloc(sizeof(*ta_data), GFP_KERNEL);
> +	if (ta_data) {
> +		ta_data->ta_handle =3D ta_handle;
> +		ta_data->refcount =3D 1;
> +		count =3D ta_data->refcount;
> +		list_add(&ta_data->list_node, &ta_list);
> +	}
> +
> +	return count;
> +}
> +
> +static u32 put_ta_refcount(u32 ta_handle)
> +{
> +	struct amdtee_ta_data *ta_data;
> +	u32 count =3D 0;
> +
> +	/* Caller must hold a mutex */
> +	list_for_each_entry(ta_data, &ta_list, list_node)
> +		if (ta_data->ta_handle =3D=3D ta_handle) {
> +			count =3D --ta_data->refcount;
> +			if (count =3D=3D 0) {
> +				list_del(&ta_data->list_node);
> +				kfree(ta_data);
> +				break;
> +			}
> +		}
> +
> +	return count;
> +}
> +
>  int handle_unload_ta(u32 ta_handle)
>  {
>  	struct tee_cmd_unload_ta cmd =3D {0};
> -	u32 status;
> +	u32 status, count;
>  	int ret;
> =20
>  	if (!ta_handle)
>  		return -EINVAL;
> =20
> +	mutex_lock(&ta_refcount_mutex);
> +
> +	count =3D put_ta_refcount(ta_handle);
> +
> +	if (count) {
> +		pr_debug("unload ta: not unloading %u count %u\n",
> +			 ta_handle, count);
> +		ret =3D -EBUSY;
> +		goto unlock;
> +	}
> +
>  	cmd.ta_handle =3D ta_handle;
> =20
>  	ret =3D psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA, (void *)&cmd,
> @@ -137,8 +191,12 @@ int handle_unload_ta(u32 ta_handle)
>  	if (!ret && status !=3D 0) {
>  		pr_err("unload ta: status =3D 0x%x\n", status);
>  		ret =3D -EBUSY;
> +	} else {
> +		pr_debug("unloaded ta handle %u\n", ta_handle);
>  	}
> =20
> +unlock:
> +	mutex_unlock(&ta_refcount_mutex);
>  	return ret;
>  }
> =20
> @@ -357,14 +415,23 @@ int handle_load_ta(void *data, u32 size, struct tee_i=
octl_open_session_arg *arg)
>  	cmd.low_addr =3D lower_32_bits(blob);
>  	cmd.size =3D size;
> =20
> +	mutex_lock(&ta_refcount_mutex);
> +
>  	ret =3D psp_tee_process_cmd(TEE_CMD_ID_LOAD_TA, (void *)&cmd,
>  				  sizeof(cmd), &arg->ret);
>  	if (ret) {
>  		arg->ret_origin =3D TEEC_ORIGIN_COMMS;
>  		arg->ret =3D TEEC_ERROR_COMMUNICATION;
> -	} else {
> -		set_session_id(cmd.ta_handle, 0, &arg->session);
> +	} else if (arg->ret =3D=3D TEEC_SUCCESS) {
> +		ret =3D get_ta_refcount(cmd.ta_handle);
> +		if (!ret) {

If this occurs, how is the TA unloaded from secure world?

Thanks,=20
Jens

> +			arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> +			arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> +		} else {
> +			set_session_id(cmd.ta_handle, 0, &arg->session);
> +		}
>  	}
> +	mutex_unlock(&ta_refcount_mutex);
> =20
>  	pr_debug("load TA: TA handle =3D 0x%x, RO =3D 0x%x, ret =3D 0x%x\n",
>  		 cmd.ta_handle, arg->ret_origin, arg->ret);
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 8a6a8f30bb42..da6b88e80dc0 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -59,10 +59,9 @@ static void release_session(struct amdtee_session *sess)
>  			continue;
> =20
>  		handle_close_session(sess->ta_handle, sess->session_info[i]);
> +		handle_unload_ta(sess->ta_handle);
>  	}
> =20
> -	/* Unload Trusted Application once all sessions are closed */
> -	handle_unload_ta(sess->ta_handle);
>  	kfree(sess);
>  }
> =20
> @@ -224,8 +223,6 @@ static void destroy_session(struct kref *ref)
>  	struct amdtee_session *sess =3D container_of(ref, struct amdtee_session,
>  						   refcount);
> =20
> -	/* Unload the TA from TEE */
> -	handle_unload_ta(sess->ta_handle);
>  	mutex_lock(&session_list_mutex);
>  	list_del(&sess->list_node);
>  	mutex_unlock(&session_list_mutex);
> @@ -238,7 +235,7 @@ int amdtee_open_session(struct tee_context *ctx,
>  {
>  	struct amdtee_context_data *ctxdata =3D ctx->data;
>  	struct amdtee_session *sess =3D NULL;
> -	u32 session_info;
> +	u32 session_info, ta_handle;
>  	size_t ta_size;
>  	int rc, i;
>  	void *ta;
> @@ -259,11 +256,14 @@ int amdtee_open_session(struct tee_context *ctx,
>  	if (arg->ret !=3D TEEC_SUCCESS)
>  		goto out;
> =20
> +	ta_handle =3D get_ta_handle(arg->session);
> +
>  	mutex_lock(&session_list_mutex);
>  	sess =3D alloc_session(ctxdata, arg->session);
>  	mutex_unlock(&session_list_mutex);
> =20
>  	if (!sess) {
> +		handle_unload_ta(ta_handle);
>  		rc =3D -ENOMEM;
>  		goto out;
>  	}
> @@ -277,6 +277,7 @@ int amdtee_open_session(struct tee_context *ctx,
> =20
>  	if (i >=3D TEE_NUM_SESSIONS) {
>  		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
> +		handle_unload_ta(ta_handle);
>  		kref_put(&sess->refcount, destroy_session);
>  		rc =3D -ENOMEM;
>  		goto out;
> @@ -289,12 +290,13 @@ int amdtee_open_session(struct tee_context *ctx,
>  		spin_lock(&sess->lock);
>  		clear_bit(i, sess->sess_mask);
>  		spin_unlock(&sess->lock);
> +		handle_unload_ta(ta_handle);
>  		kref_put(&sess->refcount, destroy_session);
>  		goto out;
>  	}
> =20
>  	sess->session_info[i] =3D session_info;
> -	set_session_id(sess->ta_handle, i, &arg->session);
> +	set_session_id(ta_handle, i, &arg->session);
>  out:
>  	free_pages((u64)ta, get_order(ta_size));
>  	return rc;
> @@ -329,6 +331,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 s=
ession)
> =20
>  	/* Close the session */
>  	handle_close_session(ta_handle, session_info);
> +	handle_unload_ta(ta_handle);
> =20
>  	kref_put(&sess->refcount, destroy_session);
> =20
> --=20
> 2.17.1
>=20

--===============5305484948843558001==--

