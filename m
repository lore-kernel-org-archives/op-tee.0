From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 09/11] qcomtee: add primordial object
Date: Wed, 14 May 2025 19:14:57 +0530
Message-ID: <aCSeWWCYNyGJakRp@sumit-X1>
In-Reply-To: <=?utf-8?q?=3C20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-?=
 =?utf-8?q?9-6a143640a6cb=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4854511449205217142=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4854511449205217142==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:06:30PM -0700, Amirreza Zarrabi wrote:
> After booting, the kernel provides a static object known as the
> primordial object. This object is utilized by QTEE for native
> kernel services such as yield or privileged operations.
>=20
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/Makefile          |  1 +
>  drivers/tee/qcomtee/core.c            | 19 +++++++---
>  drivers/tee/qcomtee/primordial_obj.c  | 65 +++++++++++++++++++++++++++++++=
++++
>  drivers/tee/qcomtee/qcomtee_private.h |  3 ++
>  4 files changed, 83 insertions(+), 5 deletions(-)

Looks reasonable to me, feel free to add:

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/tee/qcomtee/Makefile b/drivers/tee/qcomtee/Makefile
> index 1b14b943e5f5..a3a2d00e83f0 100644
> --- a/drivers/tee/qcomtee/Makefile
> +++ b/drivers/tee/qcomtee/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_QCOMTEE) +=3D qcomtee.o
>  qcomtee-objs +=3D async.o
>  qcomtee-objs +=3D call.o
>  qcomtee-objs +=3D core.o
> +qcomtee-objs +=3D primordial_obj.o
>  qcomtee-objs +=3D qcom_scm.o
>  qcomtee-objs +=3D release.o
>  qcomtee-objs +=3D shm.o
> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> index ad3b28f32529..a1ac492fd21a 100644
> --- a/drivers/tee/qcomtee/core.c
> +++ b/drivers/tee/qcomtee/core.c
> @@ -39,10 +39,12 @@ int qcomtee_next_arg_type(struct qcomtee_arg *u, int i,
>  }
> =20
>  /*
> - * QTEE expects IDs with the QCOMTEE_MSG_OBJECT_NS_BIT set for objects
> - * of the QCOMTEE_OBJECT_TYPE_CB type.
> + * QTEE expects IDs with QCOMTEE_MSG_OBJECT_NS_BIT set for objects of
> + * QCOMTEE_OBJECT_TYPE_CB type. The first ID with QCOMTEE_MSG_OBJECT_NS_BIT
> + * set is reserved for the primordial object.
>   */
> -#define QCOMTEE_OBJECT_ID_START (QCOMTEE_MSG_OBJECT_NS_BIT + 1)
> +#define QCOMTEE_OBJECT_PRIMORDIAL (QCOMTEE_MSG_OBJECT_NS_BIT)
> +#define QCOMTEE_OBJECT_ID_START (QCOMTEE_OBJECT_PRIMORDIAL + 1)
>  #define QCOMTEE_OBJECT_ID_END (U32_MAX)
> =20
>  #define QCOMTEE_OBJECT_SET(p, type, ...) \
> @@ -127,7 +129,9 @@ static void qcomtee_object_release(struct kref *refcoun=
t)
>   */
>  int qcomtee_object_get(struct qcomtee_object *object)
>  {
> -	if (object !=3D NULL_QCOMTEE_OBJECT && object !=3D ROOT_QCOMTEE_OBJECT)
> +	if (object !=3D &qcomtee_primordial_object &&
> +	    object !=3D NULL_QCOMTEE_OBJECT &&
> +	    object !=3D ROOT_QCOMTEE_OBJECT)
>  		return kref_get_unless_zero(&object->refcount);
> =20
>  	return 0;
> @@ -140,7 +144,9 @@ EXPORT_SYMBOL_GPL(qcomtee_object_get);
>   */
>  void qcomtee_object_put(struct qcomtee_object *object)
>  {
> -	if (object !=3D NULL_QCOMTEE_OBJECT && object !=3D ROOT_QCOMTEE_OBJECT)
> +	if (object !=3D &qcomtee_primordial_object &&
> +	    object !=3D NULL_QCOMTEE_OBJECT &&
> +	    object !=3D ROOT_QCOMTEE_OBJECT)
>  		kref_put(&object->refcount, qcomtee_object_release);
>  }
>  EXPORT_SYMBOL_GPL(qcomtee_object_put);
> @@ -222,6 +228,9 @@ static struct qcomtee_object *qcomtee_local_object_get(=
unsigned int object_id)
>  {
>  	struct qcomtee_object *object;
> =20
> +	if (object_id =3D=3D QCOMTEE_OBJECT_PRIMORDIAL)
> +		return &qcomtee_primordial_object;
> +
>  	guard(rcu)();
>  	object =3D xa_load(&xa_qcom_local_objects, object_id);
>  	/* It already checks for %NULL_QCOMTEE_OBJECT. */
> diff --git a/drivers/tee/qcomtee/primordial_obj.c b/drivers/tee/qcomtee/pri=
mordial_obj.c
> new file mode 100644
> index 000000000000..a30967d89c91
> --- /dev/null
> +++ b/drivers/tee/qcomtee/primordial_obj.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/delay.h>
> +#include "qcomtee_private.h"
> +
> +/**
> + * DOC: Primordial Object
> + *
> + * After boot, the kernel provides a static object of type
> + * %QCOMTEE_OBJECT_TYPE_CB called the primordial object. This object is us=
ed
> + * for native kernel services or privileged operations.
> + *
> + * We support:
> + *  - %QCOMTEE_OBJECT_OP_YIELD to yield by the thread running in QTEE.
> + *  - %QCOMTEE_OBJECT_OP_SLEEP to wait for a period of time.
> + */
> +
> +#define QCOMTEE_OBJECT_OP_YIELD 1
> +#define QCOMTEE_OBJECT_OP_SLEEP 2
> +
> +static int
> +qcomtee_primordial_obj_dispatch(struct qcomtee_object_invoke_ctx *oic,
> +				struct qcomtee_object *primordial_object_unused,
> +				u32 op, struct qcomtee_arg *args)
> +{
> +	int err =3D 0;
> +
> +	switch (op) {
> +	case QCOMTEE_OBJECT_OP_YIELD:
> +		cond_resched();
> +		/* No output object. */
> +		oic->data =3D NULL;
> +		break;
> +	case QCOMTEE_OBJECT_OP_SLEEP:
> +		/* Check message format matched QCOMTEE_OBJECT_OP_SLEEP op. */
> +		if (qcomtee_args_len(args) !=3D 1 ||
> +		    args[0].type !=3D QCOMTEE_ARG_TYPE_IB ||
> +		    args[0].b.size < sizeof(u32))
> +			return -EINVAL;
> +
> +		msleep(*(u32 *)(args[0].b.addr));
> +		/* No output object. */
> +		oic->data =3D NULL;
> +		break;
> +	default:
> +		err =3D -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
> +static struct qcomtee_object_operations qcomtee_primordial_obj_ops =3D {
> +	.dispatch =3D qcomtee_primordial_obj_dispatch,
> +};
> +
> +struct qcomtee_object qcomtee_primordial_object =3D {
> +	.name =3D "primordial",
> +	.object_type =3D QCOMTEE_OBJECT_TYPE_CB,
> +	.ops =3D &qcomtee_primordial_obj_ops
> +};
> diff --git a/drivers/tee/qcomtee/qcomtee_private.h b/drivers/tee/qcomtee/qc=
omtee_private.h
> index a6f2c0591580..e59cfb3b79dd 100644
> --- a/drivers/tee/qcomtee/qcomtee_private.h
> +++ b/drivers/tee/qcomtee/qcomtee_private.h
> @@ -219,4 +219,7 @@ int qcomtee_user_object_submit(struct tee_context *ctx,
>  			       struct tee_param *params, int num_params,
>  			       int req_id, int errno);
> =20
> +/* (2) Primordial Object. */
> +extern struct qcomtee_object qcomtee_primordial_object;
> +
>  #endif /* QCOMTEE_PRIVATE_H */
>=20
> --=20
> 2.34.1
>=20

--===============4854511449205217142==--

