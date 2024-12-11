From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 08/10] tee: add Qualcomm TEE driver
Date: Wed, 11 Dec 2024 13:30:22 +1100
Message-ID: <62f80fb7-ea13-4ae1-a438-8d6b2d5a2f15@quicinc.com>
In-Reply-To: <
 <CAHUa44GqyaouPquw+DE1ASRwVOBw5xDstcpaNpmLmQbXmp6CuQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7987549353023230207=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7987549353023230207==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On 12/10/2024 10:58 PM, Jens Wiklander wrote:
> Hi Amirreza,
>=20
> On Tue, Dec 3, 2024 at 5:20=E2=80=AFAM Amirreza Zarrabi
> <quic_azarrabi@quicinc.com> wrote:
>>
>> Introduce basic support for invoking objects hosted in QTEE and userspace
>> through the TEE subsystem.
>>
>> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
>> ---
>>  drivers/tee/qcomtee/Makefile          |   2 +
>>  drivers/tee/qcomtee/call.c            | 707 +++++++++++++++++++++++++++++=
+++++
>>  drivers/tee/qcomtee/core.c            |   8 +
>>  drivers/tee/qcomtee/qcomtee_private.h | 166 ++++++++
>>  drivers/tee/qcomtee/user_obj.c        | 625 ++++++++++++++++++++++++++++++
>>  include/uapi/linux/tee.h              |   1 +
>>  6 files changed, 1509 insertions(+)
>>
>> diff --git a/drivers/tee/qcomtee/Makefile b/drivers/tee/qcomtee/Makefile
>> index 108bc7fdabcb..6bf91481fde3 100644
>> --- a/drivers/tee/qcomtee/Makefile
>> +++ b/drivers/tee/qcomtee/Makefile
>> @@ -1,7 +1,9 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  obj-$(CONFIG_QCOMTEE) +=3D qcomtee.o
>>  qcomtee-objs +=3D async.o
>> +qcomtee-objs +=3D call.o
>>  qcomtee-objs +=3D core.o
>>  qcomtee-objs +=3D primordial_obj.o
>>  qcomtee-objs +=3D qcom_scm.o
>>  qcomtee-objs +=3D release.o
>> +qcomtee-objs +=3D user_obj.o
>> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>> new file mode 100644
>> index 000000000000..11bb31836808
>> --- /dev/null
>> +++ b/drivers/tee/qcomtee/call.c
>> @@ -0,0 +1,707 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserve=
d.
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/tee.h>
>> +#include <linux/mm.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/firmware/qcom/qcom_tzmem.h>
>> +#include <linux/firmware/qcom/qcom_scm.h>
>> +
>> +#include "qcomtee_private.h"
>> +
>> +/**
>> + * enum qcom_tee_object_host - Object host where it is managed.
>> + * @QCOM_TEE_OBJECT_HOST_USER: objects in userspace.
>> + * @QCOM_TEE_OBJECT_HOST_TEE: objects in QTEE.
>> + *
>> + * We refer to object hosted in userspace as 'Local Object' and objects h=
osted
>> + * in QTEE as 'Remote Object'.
>> + */
>> +enum qcom_tee_object_host {
>> +       QCOM_TEE_OBJECT_HOST_USER,      /* Object that is managed in users=
pace. */
>> +       QCOM_TEE_OBJECT_HOST_TEE,       /* Object that is managed in QTEE.=
 */
>> +};
>> +
>> +/* Read object ID host information. */
>> +static enum qcom_tee_object_host qcom_tee_object_host(struct tee_param *p=
aram)
>> +{
>> +       if (param->u.objref.flags & QCOM_TEE_OBJREF_FLAG_USER)
>> +               return QCOM_TEE_OBJECT_HOST_USER;
>> +       return QCOM_TEE_OBJECT_HOST_TEE;
>> +}
>> +
>> +/* qcom_tee_context_add_qtee_object() - Add a QTEE object to the context.
>> + * @param: TEE parameter represents @object.
>> + * @object: QTEE object.
>> + * @ctx: context to add the object.
>> + *
>> + * It assumes @object is %QCOM_TEE_OBJECT_TYPE_TEE and caller has already=
 issued
>> + * qcom_tee_object_get() for @object.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_context_add_qtee_object(struct tee_param *param, struct qcom=
_tee_object *object,
>> +                                    struct qcom_tee_context *ctx)
>> +{
>> +       int ret;
>> +
>> +       guard(mutex)(&ctx->lock);
>> +       ret =3D idr_alloc(&ctx->qtee_objects_idr, object, 0, 0, GFP_KERNEL=
);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       param->u.objref.id =3D ret;
>> +       /* QTEE Object: !QCOM_TEE_OBJREF_FLAG_USER. */
>> +       param->u.objref.flags =3D 0;
>> +
>> +       return 0;
>> +}
>> +
>> +static int find_qtee_object(struct qcom_tee_object **object, unsigned lon=
g id,
>> +                           struct qcom_tee_context *ctx)
>> +{
>> +       int err =3D 0;
>> +
>> +       guard(rcu)();
>> +       /* Object release is RCU protected. */
>> +       *object =3D idr_find(&ctx->qtee_objects_idr, id);
>> +       if (!qcom_tee_object_get(*object))
>> +               err =3D -EINVAL;
>> +
>> +       return err;
>> +}
>> +
>> +static void del_qtee_object(unsigned long id, struct qcom_tee_context *ct=
x)
>> +{
>> +       struct qcom_tee_object *object;
>> +
>> +       scoped_guard(mutex, &ctx->lock)
>> +               object =3D idr_remove(&ctx->qtee_objects_idr, id);
>> +       qcom_tee_object_put(object);
>> +}
>> +
>> +/* Get the QTEE object added with qcom_tee_context_add_qtee_object(). */
>> +int qcom_tee_context_find_qtee_object(struct qcom_tee_object **object, st=
ruct tee_param *param,
>> +                                     struct qcom_tee_context *ctx)
>> +{
>> +       /* 'qtee_objects_idr' stores QTEE objects only. */
>> +       if (qcom_tee_object_host(param) !=3D QCOM_TEE_OBJECT_HOST_TEE)
>> +               return -EINVAL;
>> +       return find_qtee_object(object, param->u.objref.id, ctx);
>> +}
>> +
>> +/**
>> + * qcom_tee_context_del_qtee_object() - Delete a QTEE object from the con=
text.
>> + * @param: TEE parameter represents @object.
>> + * @ctx: context to delete the object.
>> + *
>> + * @param returned by qcom_tee_context_add_qtee_object().
>> + */
>> +void qcom_tee_context_del_qtee_object(struct tee_param *param, struct qco=
m_tee_context *ctx)
>> +{
>> +       /* 'qtee_objects_idr' stores QTEE objects only. */
>> +       if (qcom_tee_object_host(param) =3D=3D QCOM_TEE_OBJECT_HOST_TEE)
>> +               del_qtee_object(param->u.objref.id, ctx);
>> +}
>> +
>> +/**
>> + * qcom_tee_objref_to_arg() - Convert OBJREF parameter to QTEE argument i=
n a context.
>> + * @arg: QTEE argument.
>> + * @param: TEE parameter.
>> + * @ctx: context in which the conversion should happen.
>> + *
>> + * It assumes @param is OBJREF.
>> + * It does not set @arg.type; caller should initialize it to a correct
>> + * &enum qcom_tee_arg_type value.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_objref_to_arg(struct qcom_tee_arg *arg, struct tee_param *pa=
ram,
>> +                          struct qcom_tee_context *ctx)
>> +{
>> +       struct qcom_tee_object *object;
>> +       int err;
>> +
>> +       if (arg->type !=3D QCOM_TEE_ARG_TYPE_IO &&
>> +           arg->type !=3D QCOM_TEE_ARG_TYPE_OO)
>> +               return -EINVAL;
>> +
>> +       /* It is a NULL object?! */
>> +       if (param->u.objref.id =3D=3D TEE_OBJREF_NULL) {
>> +               arg->o =3D NULL_QCOM_TEE_OBJECT;
>> +
>> +               return 0;
>> +       }
>> +
>> +       switch (qcom_tee_object_host(param)) {
>> +       case QCOM_TEE_OBJECT_HOST_USER:
>> +               err =3D qcom_tee_user_param_to_object(&object, param, ctx);
>> +               if (err)
>> +                       break;
>> +
>> +               /* Keep a copy for driver as QTEE may release it (e.g. usi=
ng async msg). */
>> +               qcom_tee_object_get(object);
>> +
>> +               break;
>> +       case QCOM_TEE_OBJECT_HOST_TEE:
>> +               err =3D qcom_tee_context_find_qtee_object(&object, param, =
ctx);
>> +
>> +               break;
>> +       }
>> +
>> +       arg->o =3D err ? NULL_QCOM_TEE_OBJECT : object;
>> +
>> +       return err;
>> +}
>> +
>> +/**
>> + * qcom_tee_objref_from_arg() - Convert QTEE argument to OBJREF param in =
a context.
>> + * @param: TEE parameter.
>> + * @arg: QTEE argument.
>> + * @ctx: context in which the conversion should happen.
>> + *
>> + * It assumes @arg is of %QCOM_TEE_ARG_TYPE_IO or %QCOM_TEE_ARG_TYPE_OO.
>> + * It does not set @param.attr; caller should initialize it to a correct =
OBJREF type.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_objref_from_arg(struct tee_param *param, struct qcom_tee_arg=
 *arg,
>> +                            struct qcom_tee_context *ctx)
>> +{
>> +       struct qcom_tee_object *object;
>> +       int err;
>> +
>> +       /* param should be of OBJREF. */
>> +       if (param->attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT &&
>> +           param->attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT &&
>> +           param->attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INOUT)
>> +               return -EINVAL;
>> +
>> +       object =3D arg->o;
>> +
>> +       switch (typeof_qcom_tee_object(object)) {
>> +       case QCOM_TEE_OBJECT_TYPE_NULL:
>> +               param->u.objref.id =3D TEE_OBJREF_NULL;
>> +               err =3D 0;
>> +
>> +               break;
>> +       case QCOM_TEE_OBJECT_TYPE_CB_OBJECT:
>> +               err =3D qcom_tee_user_param_from_object(param, object, ctx=
);
>> +
>> +               break;
>> +       case QCOM_TEE_OBJECT_TYPE_TEE:
>> +               err =3D qcom_tee_context_add_qtee_object(param, object, ct=
x);
>> +
>> +               break;
>> +       case QCOM_TEE_OBJECT_TYPE_ROOT:
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return err;
>> +}
>> +
>> +/**
>> + * qcom_tee_params_to_args() - Convert TEE parameters to QTEE arguments i=
n a context.
>> + * @u: QTEE arguments.
>> + * @params: TEE parameters.
>> + * @num_params: number of elements in the parameter array.
>> + * @ctx: context in which the conversion should happen.
>> + *
>> + * It assumes @u has at least @num_param + 1 entries and has been initial=
ized
>> + * with %QCOM_TEE_ARG_TYPE_INV as &struct qcom_tee_arg.type.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +static int qcom_tee_params_to_args(struct qcom_tee_arg *u,
>> +                                  struct tee_param *params, int num_param=
s,
>> +                                  struct qcom_tee_context *ctx)
>> +{
>> +       struct qcom_tee_object *object;
>> +       int i;
>> +
>> +       for (i =3D 0; i < num_params; i++) {
>> +               switch (params[i].attr) {
>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT:
>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
>> +                       u[i].flags =3D QCOM_TEE_ARG_FLAGS_UADDR;
>> +                       u[i].b.uaddr =3D params[i].u.membuf.uaddr;
>> +                       u[i].b.size =3D params[i].u.membuf.size;
>> +
>> +                       if (params[i].attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYP=
E_MEMBUF_INPUT)
>> +                               u[i].type =3D QCOM_TEE_ARG_TYPE_IB;
>> +                       else /* TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT */
>> +                               u[i].type =3D QCOM_TEE_ARG_TYPE_OB;
>> +
>> +                       break;
>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
>> +                       u[i].type =3D QCOM_TEE_ARG_TYPE_IO;
>> +                       if (qcom_tee_objref_to_arg(&u[i], &params[i], ctx))
>> +                               goto out_failed;
>> +
>> +                       break;
>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
>> +                       u[i].type =3D QCOM_TEE_ARG_TYPE_OO;
>> +                       u[i].o =3D NULL_QCOM_TEE_OBJECT;
>> +                       break;
>> +               default: /* Unsupported TEE parameters. */
>> +                       goto out_failed;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +
>> +out_failed:
>> +
>> +       /* On ERROR: */
>> +       /* Put IO objects processed so far. */
>> +       for (--i; i >=3D 0; i--) {
>> +               if (u[i].type !=3D QCOM_TEE_ARG_TYPE_IO)
>> +                       continue;
>> +
>> +               object =3D u[i].o;
>> +               qcom_tee_user_object_set_notify(object, false);
>> +               /* For callback object, we hold a reference for the driver=
, put it. */
>> +               if (typeof_qcom_tee_object(object) =3D=3D QCOM_TEE_OBJECT_=
TYPE_CB_OBJECT)
>> +                       qcom_tee_object_put(object);
>> +               /* Put QTEE copy of object. */
>> +               qcom_tee_object_put(object);
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +/**
>> + * qcom_tee_params_from_args() - Convert QTEE arguments to TEE parameters=
 in a context.
>> + * @params: TEE parameters.
>> + * @u: QTEE arguments.
>> + * @num_params: number of elements in the parameter array.
>> + * @ctx: context in which the conversion should happen.
>> + *
>> + * @u should have been already initialized by qcom_tee_params_to_args().
>> + * This also represents end of a QTEE invocation that started with qcom_t=
ee_params_to_args()
>> + * by releasing %QCOM_TEE_ARG_TYPE_IO objects.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +static int qcom_tee_params_from_args(struct tee_param *params,
>> +                                    struct qcom_tee_arg *u, int num_param=
s,
>> +                                    struct qcom_tee_context *ctx)
>> +{
>> +       int i, np;
>> +
>> +       for (np =3D 0; u[np].type; np++) {
>> +               enum qcom_tee_arg_type at =3D u[np].type;
>> +
>> +               if (at =3D=3D QCOM_TEE_ARG_TYPE_OB) {
>> +                       /* TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT */
>> +                       params[np].u.value.b =3D u[np].b.size;
>> +
>> +               } else if (at =3D=3D QCOM_TEE_ARG_TYPE_IO) {
>> +                       /* IEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT */
>> +                       qcom_tee_object_put(u[np].o);
>> +
>> +               } else if (at =3D=3D QCOM_TEE_ARG_TYPE_OO) {
>> +                       /* TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT */
>> +                       if (qcom_tee_objref_from_arg(&params[np], &u[np], =
ctx))
>> +                               goto out_failed;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +
>> +out_failed:
>> +
>> +       /* On ERROR: */
>> +       /*  - Release params associated to QTEE objects in this context so=
 far. */
>> +       for (i =3D 0; i < np; i++) {
>> +               if (params[i].attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF=
_OUTPUT)
>> +                       qcom_tee_context_del_qtee_object(&params[i], ctx);
>> +       }
>> +       /*  - Release any IO and OO objects not processed so far. */
>> +       while (u[i].type) {
>> +               if (u[i].type =3D=3D QCOM_TEE_ARG_TYPE_OO ||
>> +                   u[i].type =3D=3D QCOM_TEE_ARG_TYPE_IO)
>> +                       qcom_tee_object_put(u[i++].o);
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +/* TEE Device Ops. */
>> +
>> +static int qcom_tee_params_check(struct tee_param *params, int num_params)
>> +{
>> +       int io =3D 0, oo =3D 0, ib =3D 0, ob =3D 0;
>> +       int i;
>> +
>> +       /* QTEE accepts 64 arguments. */
>> +       if (num_params > QCOM_TEE_ARGS_MAX)
>> +               return -EINVAL;
>> +
>> +       /* Supported parameter types. */
>> +       for (i =3D 0; i < num_params; i++) {
>> +               switch (params[i].attr) {
>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT:
>> +                       ib++; break;
>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
>> +                       ob++; break;
>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
>> +                       io++; break;
>> +               case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
>> +                       oo++; break;
>> +               default:
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       /*  QTEE accepts 16 arguments of each supported types. */
>> +       if (io > QCOM_TEE_ARGS_PER_TYPE || oo > QCOM_TEE_ARGS_PER_TYPE ||
>> +           ib > QCOM_TEE_ARGS_PER_TYPE || ob > QCOM_TEE_ARGS_PER_TYPE)
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +
>> +/* Check if user issued a permitted operation on ROOT_QCOM_TEE_OBJECT fro=
m userspace. */
>> +static int qcom_tee_root_object_check(u32 op, struct tee_param *params, i=
nt num_params)
>> +{
>> +       /* Some privileged operations recognized by QTEE. */
>> +       if (op =3D=3D 4 || op =3D=3D 8 || op =3D=3D 9)
>> +               return -EINVAL;
>> +
>> +       /* OP 5 is to register with QTEE by passing credential object as i=
nput OBJREF. */
>> +       /* TEE_OBJREF_NULL as credential object represents a privileged cl=
ient for QTEE,
>> +        * only kernel can pass TEE_OBJREF_NULL.
>> +        */
>> +       if (op =3D=3D 5) {
>> +               if (num_params !=3D 2)
>> +                       return -EINVAL;
>> +
>> +               if (params[0].attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF=
_INPUT &&
>> +                   params[1].attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF=
_OUTPUT) {
>> +                       if (params[0].u.objref.id =3D=3D TEE_OBJREF_NULL)
>> +                               return -EINVAL;
>> +
>> +               } else if (params[0].attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE=
_OBJREF_OUTPUT &&
>> +                          params[1].attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE=
_OBJREF_INPUT) {
>> +                       if (params[1].u.objref.id =3D=3D TEE_OBJREF_NULL)
>> +                               return -EINVAL;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * qcom_tee_object_invoke() - Invoke a QTEE object.
>> + * @tee_ctx: TEE context.
>> + * @arg: ioctl arguments.
>> + * @params: parameters for the object.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +static int qcom_tee_object_invoke(struct tee_context *tee_ctx,
>> +                                 struct tee_ioctl_object_invoke_arg *arg,
>> +                                 struct tee_param *params)
>> +{
>> +       struct qcom_tee_object_invoke_ctx *oic __free(kfree) =3D NULL;
>> +       struct qcom_tee_context *ctx =3D tee_ctx->data;
>> +       struct qcom_tee_arg *u __free(kfree) =3D NULL;
>> +       struct qcom_tee_object *object;
>> +       int i, ret, result;
>> +
>> +       if (qcom_tee_params_check(params, arg->num_params))
>> +               return -EINVAL;
>> +
>> +       /* Handle OBJREF reserved operations. */
>> +       if (arg->op =3D=3D QCOM_TEE_OBJREF_OP_RELEASE) {
>> +               del_qtee_object(arg->object, ctx);
>> +
>> +               return 0;
>> +       }
>> +
>> +       /* Unsupported reserved operation. */
>> +       if (arg->op > QCOM_TEE_OBJREF_OP_MIN)
>> +               return -EINVAL;
>> +
>> +       oic =3D kzalloc(sizeof(*oic), GFP_KERNEL);
>> +       if (!oic)
>> +               return -ENOMEM;
>> +
>> +       /* +1 for ending QCOM_TEE_ARG_TYPE_INV. */
>> +       u =3D kzalloc(sizeof(*u) * (arg->num_params + 1), GFP_KERNEL);
>=20
> Please use kcalloc().
>

Ack.

>> +       if (!u)
>> +               return -ENOMEM;
>> +
>> +       if (arg->object =3D=3D TEE_OBJREF_NULL &&
>> +           !qcom_tee_root_object_check(arg->op, params, arg->num_params))=
 {
>> +               /* Use ROOT if NULL is invoked. */
>> +               object =3D ROOT_QCOM_TEE_OBJECT;
>> +       } else {
>> +               /* Get object being invoked. */
>> +               ret =3D find_qtee_object(&object, arg->object, ctx);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       ret =3D qcom_tee_params_to_args(u, params, arg->num_params, ctx);
>> +       if (ret)
>> +               goto out;
>> +
>> +       ret =3D qcom_tee_object_do_invoke(oic, object, arg->op, u, &result=
);
>> +       if (!ret) {
>> +               if (!result) {
>> +                       /* Only parse QTEE response on SUCCESS. */
>> +                       ret =3D qcom_tee_params_from_args(params, u, arg->=
num_params, ctx);
>> +               } else {
>> +                       /* Put driver's IO objects copy; get in qcom_tee_p=
arams_to_args(). */
>> +                       qcom_tee_arg_for_each_input_object(i, u)
>> +                               qcom_tee_object_put(u[i++].o);
>> +               }
>> +       } else if (ret !=3D -EAGAIN && ret !=3D -ENODEV) {
>> +               /* Unable to initiate a QTEE invocation; cleanup qcom_tee_=
params_to_args(). */
>> +               qcom_tee_arg_for_each_input_object(i, u) {
>> +                       qcom_tee_user_object_set_notify(u[i].o, false);
>> +                       if (typeof_qcom_tee_object(u[i].o) =3D=3D QCOM_TEE=
_OBJECT_TYPE_CB_OBJECT)
>> +                               qcom_tee_object_put(u[i].o);
>> +                       qcom_tee_object_put(u[i].o);
>> +               }
>> +       }
>> +
>> +       arg->ret =3D result;
>> +out:
>> +       qcom_tee_object_put(object);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * qcom_tee_supp_recv() - Pick a request for the supplicant.
>> + * @tee_ctx: TEE context.
>> + * @op: requested operation on object.
>> + * @num_params: number of elements in the parameter array, updated with n=
umber used.
>> + * @params: parameters for @op.
>> + *
>> + * The first parameter is a %TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT meta p=
arameter.
>> + * On input, it provides a user buffer. This buffer is used for parameter=
s of type
>> + * %TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT in qcom_tee_cb_params_from_arg=
s().
>> + * On output, object id and request id are stored in the meta parameter.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +static int qcom_tee_supp_recv(struct tee_context *tee_ctx, u32 *op, u32 *=
num_params,
>> +                             struct tee_param *params)
>> +{
>> +       struct qcom_tee_user_object_request_data data;
>> +       struct qcom_tee_context *ctx =3D tee_ctx->data;
>> +       void __user *uaddr;
>> +       size_t ubuf_size;
>> +       int i, ret;
>> +
>> +       if (!*num_params)
>> +               return -EINVAL;
>> +
>> +       /* We expect the first parameter to be an INOUT + meta parameter. =
*/
>> +       if (params->attr !=3D (TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT | TEE=
_IOCTL_PARAM_ATTR_META))
>> +               return -EINVAL;
>> +
>> +       /* Others parameters are none. */
>> +       for (i =3D 1; i < *num_params; i++)
>> +               if (params[i].attr)
>> +                       return -EINVAL;
>> +
>> +       if (IS_ALIGNED(params->u.value.a, 8))
>> +               return -EINVAL;
>> +
>> +       /* User buffer and size from meta parameter. */
>> +       uaddr =3D u64_to_user_ptr(params->u.value.a);
>> +       ubuf_size =3D params->u.value.b;
>> +       /* Process TEE parameters. +/-1 to ignore meta parameter. */
>> +       ret =3D qcom_tee_user_object_pop(ctx, params + 1, *num_params - 1,=
 uaddr, ubuf_size, &data);
>> +       if (ret)
>> +               return ret;
>> +
>> +       params->u.value.a =3D data.object_id;
>> +       params->u.value.b =3D data.id;
>> +       params->u.value.c =3D 0;
>> +       *op =3D data.op;
>> +       *num_params =3D data.np + 1;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * qcom_tee_supp_send() - Pick a request for the supplicant.
>> + * @tee_ctx: TEE context.
>> + * @ret: return value of the request.
>> + * @num_params: number of elements in the parameter array.
>> + * @params: returned parameters.
>> + *
>> + * The first parameter is a %TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT meta p=
arameter.
>> + * It specifies the request id this response is belong to.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +static int qcom_tee_supp_send(struct tee_context *tee_ctx, u32 errno, u32=
 num_params,
>> +                             struct tee_param *params)
>> +{
>> +       struct qcom_tee_context *ctx =3D tee_ctx->data;
>> +       int id;
>> +
>> +       if (!num_params)
>> +               return -EINVAL;
>> +
>> +       /* We expect the first parameter to be an INPUT + meta parameter. =
*/
>> +       if (params->attr !=3D (TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT | TEE=
_IOCTL_PARAM_ATTR_META))
>> +               return -EINVAL;
>> +
>> +       /* Get the req_id of response. */
>> +       id =3D params->u.value.a;
>> +
>> +       /* Process TEE parameters. +/-1 to ignore meta parameter. */
>> +       return qcom_tee_user_object_submit(ctx, params + 1, num_params - 1=
, id, errno);
>> +}
>> +
>> +static int qcom_tee_open(struct tee_context *tee_context)
>> +{
>> +       struct qcom_tee_context *ctx __free(kfree) =3D NULL;
>> +       int err;
>> +
>> +       ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +       if (!ctx)
>> +               return -ENOMEM;
>> +
>> +       err =3D init_srcu_struct(&ctx->req_srcu);
>> +       if (err)
>> +               return err;
>> +
>> +       ctx->tee_context =3D tee_context;
>> +       idr_init(&ctx->qtee_objects_idr);
>> +       idr_init(&ctx->reqs_idr);
>> +       mutex_init(&ctx->lock);
>> +       init_completion(&ctx->req_c);
>> +       kref_init(&ctx->ref_cnt);
>> +
>> +       tee_context->data =3D no_free_ptr(ctx);
>> +
>> +       return 0;
>> +}
>> +
>> +static void qcom_tee_release(struct tee_context *tee_context)
>> +{
>> +       struct qcom_tee_context *ctx =3D tee_context->data;
>> +       struct qcom_tee_object *object;
>> +       int id;
>> +
>> +       /* Process QUEUED or PROCESSING requests. */
>> +       qcom_tee_requests_destroy(ctx);
>> +
>> +       /* Release QTEE objects. */
>> +       idr_for_each_entry(&ctx->qtee_objects_idr, object, id)
>> +               qcom_tee_object_put(object);
>> +
>> +       /* Put the context; wait for all user objects to go away. */
>> +       kref_put(&ctx->ref_cnt, __qcom_tee_context_destroy);
>> +}
>> +
>> +void __qcom_tee_context_destroy(struct kref *ref_cnt)
>> +{
>> +       struct qcom_tee_context *ctx =3D container_of(ref_cnt, struct qcom=
_tee_context, ref_cnt);
>> +
>> +       idr_destroy(&ctx->qtee_objects_idr);
>> +       idr_destroy(&ctx->reqs_idr);
>> +       cleanup_srcu_struct(&ctx->req_srcu);
>> +       kfree(ctx);
>> +}
>> +
>> +static void qcom_tee_get_version(struct tee_device *teedev, struct tee_io=
ctl_version_data *vers)
>> +{
>> +       struct tee_ioctl_version_data v =3D {
>> +               .impl_id =3D TEE_IMPL_ID_QTEE,
>> +               .gen_caps =3D TEE_GEN_CAP_OBJREF,
>> +       };
>> +
>> +       *vers =3D v;
>> +}
>> +
>> +static const struct tee_driver_ops qcom_tee_ops =3D {
>> +       .get_version =3D qcom_tee_get_version,
>> +       .open =3D qcom_tee_open,
>> +       .release =3D qcom_tee_release,
>> +       .object_invoke_func =3D qcom_tee_object_invoke,
>> +       .supp_recv =3D qcom_tee_supp_recv,
>> +       .supp_send =3D qcom_tee_supp_send,
>> +};
>> +
>> +static const struct tee_desc qcom_tee_desc =3D {
>> +       .name =3D "qcom_tee",
>> +       .ops =3D &qcom_tee_ops,
>> +       .owner =3D THIS_MODULE,
>> +};
>> +
>> +static int qcom_tee_probe(struct platform_device *pdev)
>> +{
>> +       struct tee_device *teedev;
>> +       int err;
>> +
>> +       if (!qcom_scm_is_available())
>> +               return -EPROBE_DEFER;
>> +
>> +       teedev =3D tee_device_alloc(&qcom_tee_desc, NULL, NULL, NULL);
>> +       if (IS_ERR(teedev))
>> +               return PTR_ERR(teedev);
>> +
>> +       err =3D tee_device_register(teedev);
>> +       if (err)
>> +               goto err_unreg_teedev;
>> +
>> +       platform_set_drvdata(pdev, teedev);
>> +       return 0;
>> +
>> +err_unreg_teedev:
>> +       tee_device_unregister(teedev);
>> +
>> +       return err;
>> +}
>> +
>> +static void qcom_tee_remove(struct platform_device *pdev)
>> +{
>> +       struct tee_device *teedev =3D platform_get_drvdata(pdev);
>> +
>> +       /* Keep a copy, tee_device_unregister() sets it to NULL. */
> teedev shouldn't be accessed after a call to tee_device_unregister()
>=20

True, but I don't access teedev after unregistering.

pdev holds a pointer to teedev, and teedev holds a pointer to the pool.
Before calling unregister, I keep a copy of the pool address for cleaning up
the pool after unregistering.

I did it this way because we don't have a private struct like optee to
hold the driver state. I'm adding struct qcomtee (following your comments
in PATCH [5/10]), so this should be removed.


>> +       struct tee_shm_pool *pool =3D teedev->pool;
>> +
>> +       /* Wait for users to go away. */
>> +       tee_device_unregister(teedev);
>> +       tee_shm_pool_free(pool);
> Why? You supplied NULL when tee_device_alloc() was called.
>=20

Sorry, this is my fault. We originally had support for TEE SHM IOCTLs.
I removed it to reduce the size of this patchset and planned to send
it later. I missed removing this part.

>> +}
>> +
>> +static const struct of_device_id qcom_tee_dt_match[] =3D {
>> +       { .compatible =3D "qcom,tee" },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_tee_dt_match);
>> +
>> +static struct platform_driver qcom_tee_platform_driver =3D {
>> +       .probe =3D qcom_tee_probe,
>> +       .remove =3D qcom_tee_remove,
>> +       .driver =3D {
>> +               .name =3D "qcom_tee",
>> +               .of_match_table =3D qcom_tee_dt_match,
>> +       },
>> +};
>> +
>> +int qcom_tee_driver_register(void)
>> +{
>> +       return platform_driver_register(&qcom_tee_platform_driver);
>> +}
>> +
>> +void qcom_tee_driver_unregister(void)
>> +{
>> +       platform_driver_unregister(&qcom_tee_platform_driver);
>> +}
>> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
>> index 79f1181cf676..545857e117db 100644
>> --- a/drivers/tee/qcomtee/core.c
>> +++ b/drivers/tee/qcomtee/core.c
>> @@ -904,8 +904,14 @@ static int __init qcom_tee_object_invoke_init(void)
>>         if (ret)
>>                 goto err_kobject_put;
>>
>> +       ret =3D qcom_tee_driver_register();
>> +       if (ret)
>> +               goto err_remove_group;
>> +
>>         return 0;
>>
>> +err_remove_group:
>> +       sysfs_remove_group(qcom_tee_object_invoke_kobj, &attr_group);
>>  err_kobject_put:
>>         /* Remove '/sys/firmware/qcom_tee'. */
>>         kobject_put(qcom_tee_object_invoke_kobj);
>> @@ -920,6 +926,8 @@ module_init(qcom_tee_object_invoke_init);
>>
>>  static void __exit qcom_tee_object_invoke_deinit(void)
>>  {
>> +       qcom_tee_driver_unregister();
>> +
>>         /* Wait for RELEASE operations for QTEE objects. */
>>         qcom_tee_release_destroy();
>>         qcom_tee_msg_buffers_destroy();
>> diff --git a/drivers/tee/qcomtee/qcomtee_private.h b/drivers/tee/qcomtee/q=
comtee_private.h
>> index c718cd2d8463..15f358260ed7 100644
>> --- a/drivers/tee/qcomtee/qcomtee_private.h
>> +++ b/drivers/tee/qcomtee/qcomtee_private.h
>> @@ -10,6 +10,14 @@
>>  #include <linux/kobject.h>
>>  #include <linux/tee_core.h>
>>
>> +/* Flags relating to object reference. */
>> +#define QCOM_TEE_OBJREF_FLAG_USER 1
>> +
>> +/* Reserved OBJREF operations. */
>> +/* These operations are not sent to QTEE and handled in driver. */
>> +#define QCOM_TEE_OBJREF_OP_MIN USHRT_MAX
>> +#define QCOM_TEE_OBJREF_OP_RELEASE (QCOM_TEE_OBJREF_OP_MIN + 1)
>> +
>>  struct qcom_tee_object *qcom_tee_idx_erase(u32 idx);
>>  void qcom_tee_object_free(struct qcom_tee_object *object);
>>
>> @@ -44,9 +52,167 @@ int __qcom_tee_object_do_invoke(struct qcom_tee_object=
_invoke_ctx *oic,
>>                                 struct qcom_tee_object *object, u32 op, st=
ruct qcom_tee_arg *u,
>>                                 int *result);
>>
>> +/**
>> + * struct qcom_tee_context - Clients or supplicants context.
>> + * @tee_context: TEE context.
>> + * @qtee_objects_idr: QTEE objects in this context.
>> + * @reqs_idr: Requests currently being processed.
>> + * @lock: mutex for @reqs_idr and @qtee_objects_idr.
>> + * @req_srcu: srcu for exclusive access to requests.
>> + * @req_c: completion used when supplicant is waiting for requests.
>> + * @released: state of this context.
>> + * @ref_cnt: ref count.
>> + */
>> +struct qcom_tee_context {
>=20
> Other drivers call their conterpart of this struct *_context_data.
> Using the same pattern here makes it easier to recognize the struct in
> the rest of the code.
>=20

Ack.

>> +       struct tee_context *tee_context;
>> +
>> +       struct idr qtee_objects_idr;
>> +       struct idr reqs_idr;
>> +       /* Synchronize access to @reqs_idr, @qtee_objects_idr and updating=
 requests state. */
>> +       struct mutex lock;
>> +       struct srcu_struct req_srcu;
>=20
> Why do you use this synchronization primitive? I don't know enough
> about this primitive to tell if you use it for the right purpose so
> perhaps you can help me understand which properties you need.
>=20

Sure, let me explain it bellow in the qcom_tee_user_object_dispatch,
where it is acually used.

>> +       struct completion req_c;
>> +
>> +       int released;
>> +
>> +       struct kref ref_cnt;
>=20
> Why does this struct need a different lifetime than struct tee_context?
>=20

This is a side effect of how QTEE objects and callback objects are released:

  - When a tee_context is closed, we release all QTEE objects in that context.
    QTEE specifies that object releases are asynchronous. So, we queue the
    releases in a workqueue and immediately return from the release callback,
    allowing the TEE subsystem to continue.

  - When the workqueue sends a release for a QTEE object, QTEE may respond
    by requesting the release of a callback object or an operation on a callb=
ack
    object. This requires a valid struct qcom_tee_context. That's why we keep=
 this
    until all callback objects are gone.

The alternative is to keep a list of callback objects in this context and
flag them as orphans. The refcount seems easier :).
=20

>> +};
>> +
>> +void __qcom_tee_context_destroy(struct kref *ref_cnt);
>> +
>> +/* qcom_tee_context_add_qtee_object() - Add a QTEE object to the context.
>> + * @param: TEE parameter represents @object.
>> + * @object: QTEE object.
>> + * @ctx: context to add the object.
>> + *
>> + * It assumes @object is %QCOM_TEE_OBJECT_TYPE_TEE and caller has already=
 issued
>> + * qcom_tee_object_get() for @object.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_context_add_qtee_object(struct tee_param *param, struct qcom=
_tee_object *object,
>> +                                    struct qcom_tee_context *ctx);
>> +
>> +/* Get the QTEE object added with qcom_tee_context_add_qtee_object(). */
>> +int qcom_tee_context_find_qtee_object(struct qcom_tee_object **object, st=
ruct tee_param *param,
>> +                                     struct qcom_tee_context *ctx);
>> +
>> +/**
>> + * qcom_tee_context_del_qtee_object() - Delete a QTEE object from the con=
text.
>> + * @param: TEE parameter represents @object.
>> + * @ctx: context to delete the object.
>> + *
>> + * @param returned by qcom_tee_context_add_qtee_object().
>> + */
>> +void qcom_tee_context_del_qtee_object(struct tee_param *param, struct qco=
m_tee_context *ctx);
>> +
>> +/**
>> + * qcom_tee_objref_to_arg() - Convert OBJREF parameter to QTEE argument i=
n a context.
>> + * @arg: QTEE argument.
>> + * @param: TEE parameter.
>> + * @ctx: context in which the conversion should happen.
>> + *
>> + * It assumes @param is OBJREF.
>> + * It does not set @arg.type; caller should initialize it to a correct
>> + * &enum qcom_tee_arg_type value.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_objref_to_arg(struct qcom_tee_arg *arg, struct tee_param *pa=
ram,
>> +                          struct qcom_tee_context *ctx);
>> +
>> +/**
>> + * qcom_tee_objref_from_arg() - Convert QTEE argument to OBJREF param in =
a context.
>> + * @param: TEE parameter.
>> + * @arg: QTEE argument.
>> + * @ctx: context in which the conversion should happen.
>> + *
>> + * It assumes @arg is of %QCOM_TEE_ARG_TYPE_IO or %QCOM_TEE_ARG_TYPE_OO.
>> + * It does not set @param.attr; caller should initialize it to a correct =
OBJREF type.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_objref_from_arg(struct tee_param *param, struct qcom_tee_arg=
 *arg,
>> +                            struct qcom_tee_context *ctx);
>> +
>> +int qcom_tee_driver_register(void);
>> +void qcom_tee_driver_unregister(void);
>> +
>>  /* OBJECTS: */
>>
>>  /* (1) Primordial Object. */
>>  extern struct qcom_tee_object qcom_tee_primordial_object;
>>
>> +/* (2) User Object API. */
>> +
>> +/* Is it a user object? */
>> +int is_qcom_tee_user_object(struct qcom_tee_object *object);
>> +
>> +/* Set user object's 'notify on release' flag. */
>> +void qcom_tee_user_object_set_notify(struct qcom_tee_object *object, bool=
 notify);
>> +
>> +/**
>> + * qcom_tee_user_param_to_object() - Convert OBJREF parameter to &struct =
qcom_tee_object.
>> + * @object: object returned.
>> + * @param: TEE parameter.
>> + * @ctx: context in which the conversion should happen.
>> + *
>> + * @param is OBJREF with %TEE_IOCTL_OBJREF_USER flags.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_user_param_to_object(struct qcom_tee_object **object, struct=
 tee_param *param,
>> +                                 struct qcom_tee_context *ctx);
>> +
>> +/* Reverse what qcom_tee_user_param_to_object() does. */
>> +int qcom_tee_user_param_from_object(struct tee_param *param, struct qcom_=
tee_object *object,
>> +                                   struct qcom_tee_context *ctx);
>> +
>> +struct qcom_tee_user_object_request_data {
>> +       int id;                         /* Id assigned to the request. */
>> +       u64 object_id;                  /* Object id being invoked by QTEE=
. */
>> +       u32 op;                         /* Requested operation on object. =
*/
>> +       int np;                         /* Number of parameters in the req=
uest.*/
>> +};
>> +
>> +/**
>> + * qcom_tee_user_object_pop() - Pop a request for a user object.
>> + * @ctx: context to look for user object.
>> + * @params: parameters for @op.
>> + * @num_params: number of elements in the parameter array.
>> + * @uaddr: user buffer for output MEMBUF parameters.
>> + * @size: size of user buffer @uaddr.
>> + * @data: information for the pop request.
>> + *
>> + * @params is filled along with @data for the picked request.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_user_object_pop(struct qcom_tee_context *ctx,
>> +                            struct tee_param *params, int num_params,
>> +                            void __user *uaddr, size_t size,
>> +                            struct qcom_tee_user_object_request_data *dat=
a);
>> +
>> +/**
>> + * qcom_tee_user_object_submit() - Submit a response for a user object.
>> + * @ctx: context to look for user object.
>> + * @params: returned parameters.
>> + * @num_params: number of elements in the parameter array.
>> + * @id: request id for the response.
>> + * @errno: result of user object invocation.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_user_object_submit(struct qcom_tee_context *ctx,
>> +                               struct tee_param *params, int num_params, =
int id, int errno);
>> +
>> +/**
>> + * qcom_tee_requests_destroy() - Destroy requests in a context.
>> + * @ctx: context for which to destroy requests.
>> + *
>> + * After calling qcom_tee_requests_destroy(), @ctx can not be reused.
>> + * It should be called on @ctx cleanup path.
>> + */
>> +void qcom_tee_requests_destroy(struct qcom_tee_context *ctx);
>> +
>>  #endif /* QCOM_TEE_PRIVATE_H */
>> diff --git a/drivers/tee/qcomtee/user_obj.c b/drivers/tee/qcomtee/user_obj=
.c
>> new file mode 100644
>> index 000000000000..4c671a3ae0de
>> --- /dev/null
>> +++ b/drivers/tee/qcomtee/user_obj.c
>> @@ -0,0 +1,625 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserve=
d.
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include "qcomtee_private.h"
>> +
>> +/**
>> + * DOC: User Objects aka Supplicants
>> + *
>> + * Any userspace process with access to the TEE device file can behave as=
 a supplicant
>> + * by creating a user object. Any TEE parameter of type OBJREF with %QCOM=
_TEE_OBJREF_FLAG_USER
>> + * flag set is considered as user object.
>> + *
>> + * A supplicant uses qcom_tee_user_object_pick() (i.e. TEE_IOC_SUPPL_RECV=
) to receive a
>> + * QTEE user object request and qcom_tee_user_object_submit() (i.e. TEE_I=
OC_SUPPL_SEND)
>> + * to submit a response. QTEE expects to receive the response, including =
OB and OO in
>> + * specific order in the message; parameters submitted with qcom_tee_user=
_object_submit()
>> + * should maintain this order.
>> + */
>> +
>> +/**
>> + * struct qcom_tee_user_object - User object.
>> + * @object: &struct qcom_tee_object representing this user object.
>> + * @ctx: context for which user object is defined.
>> + * @object_id: object ID in @ctx.
>> + * @nor: notify userspace if object is released.
>> + *
>> + * Any object managed in userspace is represented with this struct.
>> + * If @nor is set, on release a notification message is send back to the =
userspace.
>> + */
>> +struct qcom_tee_user_object {
>> +       struct qcom_tee_object object;
>> +       struct qcom_tee_context *ctx;
>> +       u64 object_id;
>> +
>> +       bool nor;
>> +};
>> +
>> +#define to_qcom_tee_user_object(o) container_of((o), struct qcom_tee_user=
_object, object)
>> +
>> +static struct qcom_tee_object_operations qcom_tee_user_object_ops;
>> +
>> +/* Is it a user object? */
>> +int is_qcom_tee_user_object(struct qcom_tee_object *object)
>> +{
>> +       return object !=3D NULL_QCOM_TEE_OBJECT &&
>> +               typeof_qcom_tee_object(object) =3D=3D QCOM_TEE_OBJECT_TYPE=
_CB_OBJECT &&
>> +               object->ops =3D=3D &qcom_tee_user_object_ops;
>> +}
>> +
>> +/* Set user object's 'notify on release' flag. */
>> +void qcom_tee_user_object_set_notify(struct qcom_tee_object *object, bool=
 notify)
>> +{
>> +       if (is_qcom_tee_user_object(object))
>> +               WRITE_ONCE(to_qcom_tee_user_object(object)->nor, notify);
>=20
> It looks like this depends on some synchronization. Please add a
> comment on how this works.
>=20

Absolutely, I'll give detail.

>> +}
>> +
>> +/**
>> + * enum qcom_tee_req_state - Current state of request.
>> + * @QCOM_TEE_REQ_QUEUED: Request is waiting for supplicant.
>> + * @QCOM_TEE_REQ_PROCESSING: Request has been picked by the supplicant.
>> + * @QCOM_TEE_REQ_PROCESSED: Response has been submitted for the request.
>> + */
>> +enum qcom_tee_req_state {
>> +       QCOM_TEE_REQ_QUEUED =3D 1,
>> +       QCOM_TEE_REQ_PROCESSING,
>> +       QCOM_TEE_REQ_PROCESSED,
>> +};
>> +
>> +/* User requests sent to supplicants. */
>> +struct qcom_tee_user_req {
>> +       enum qcom_tee_req_state state;
>> +
>> +       int req_id;                     /* Request ID. */
>> +       u64 object_id;                  /* User object ID. */
>> +       u32 op;                         /* Operation to perform on object.=
 */
>> +       struct qcom_tee_arg *args;      /* QTEE arguments for this operati=
on. */
>> +       int errno;                      /* Result of operation. */
>> +
>> +       struct completion c;            /* Completion for whoever wait for=
 results. */
>> +};
>> +
>> +/* Static placeholder for a request in PROCESSING state in qcom_tee_conte=
xt.reqs_idr.
>> + * If the thread initiated the QTEE call using qcom_tee_object_invoke() d=
ies, and supplicant
>> + * is processing the request, we replace the entry in qcom_tee_context.re=
qs_idr with
>> + * __empty_ureq. So (1) the req_id remains busy and not reused, and (2) s=
upplicant fails to
>> + * submit response and does the necessary rollback.
>> + */
>> +static struct qcom_tee_user_req __empty_ureq =3D { .state =3D QCOM_TEE_RE=
Q_PROCESSING };
>> +
>> +/* Enqueue a user request for a context. */
>> +static int qcom_tee_request_enqueue(struct qcom_tee_user_req *ureq, struc=
t qcom_tee_context *ctx)
>> +{
>> +       int ret;
>> +
>> +       guard(mutex)(&ctx->lock);
>> +       /* Supplicant is dying. */
>> +       if (ctx->released)
>> +               return -ENODEV;
>> +
>> +       ret =3D idr_alloc(&ctx->reqs_idr, ureq, 0, 0, GFP_KERNEL);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ureq->req_id =3D ret;
>> +       ureq->state =3D QCOM_TEE_REQ_QUEUED;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * qcom_tee_requests_destroy() - Destroy requests in a context.
>> + * @ctx: context for which to destroy requests.
>> + */
>> +void qcom_tee_requests_destroy(struct qcom_tee_context *ctx)
>> +{
>> +       struct qcom_tee_user_req *ureq;
>> +       int id;
>> +
>> +       guard(mutex)(&ctx->lock);
>> +
>> +       /* So qcom_tee_request_enqueue() refuses new requests. */
>> +       ctx->released =3D 1;
>> +       idr_for_each_entry(&ctx->reqs_idr, ureq, id) {
>> +               if (ureq =3D=3D &__empty_ureq)
>> +                       continue;
>> +               /* ureq in QUEUED or PROCESSING state, terminate them. */
>> +               if (ureq->op =3D=3D QCOM_TEE_OBJREF_OP_RELEASE) {
>> +                       kfree(ureq);
>> +               } else {
>> +                       ureq->state =3D QCOM_TEE_REQ_PROCESSED;
>> +                       ureq->errno =3D -ENODEV;
>> +                       complete(&ureq->c);
>> +               }
>> +       }
>> +}
>> +
>> +/**
>> + * qcom_tee_supp_pop_entry() - Pop the next request in a context.
>=20
> When you pop something you'd expect it to be removed also.
>

I'll rename it to more apporpriate name.

>> + * @ctx: context from which to pop a request.
>> + * @ubuf_size: size of available buffer for MEMBUF parameters.
>> + * @num_params: number of entries for TEE parameter array.
>> + *
>> + * It does not remove the request from &qcom_tee_context.reqs_idr.
>> + * It checks if @num_params is large enough to fit the next request argum=
ents.
>> + * It checks if @ubuf_size is large enough to fit IB buffer arguments fro=
m QTEE.
>> + * It updates request state to %QCOM_TEE_REQ_PROCESSING state.
>> + *
>> + * Return: On success return a request or NULL and ERR_PTR on failure.
>> + */
>> +static struct qcom_tee_user_req *qcom_tee_supp_pop_entry(struct qcom_tee_=
context *ctx,
>> +                                                        size_t ubuf_size,=
 int num_params)
>> +{
>> +       struct qcom_tee_user_req *ureq;
>> +       struct qcom_tee_arg *u;
>> +       int i, id;
>> +
>> +       guard(mutex)(&ctx->lock);
>> +
>> +       /* Find the a QUEUED request. */
>=20
> Is it _a_ or _the_?
>=20
>> +       idr_for_each_entry(&ctx->reqs_idr, ureq, id)
>> +               if (ureq->state =3D=3D QCOM_TEE_REQ_QUEUED)
>> +                       break;
>=20
> Will this always result in a FIFO processing?
>=20

It not a FIFO. I understand your concerns.
I'll replace it with a list.

>> +
>> +       if (!ureq)
>> +               return NULL;
>> +
>> +       u =3D ureq->args;
>> +       /* (1) Is there enough TEE parameters? */
>> +       if (num_params < qcom_tee_args_len(u))
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       /* (2) Is there enough space to pass input buffers? */
>> +       qcom_tee_arg_for_each_input_buffer(i, u) {
>> +               ubuf_size =3D size_sub(ubuf_size, u[i].b.size);
>> +               if (ubuf_size =3D=3D SIZE_MAX)
>> +                       return ERR_PTR(-EINVAL);
>> +
>> +               ubuf_size =3D round_down(ubuf_size, 8);
>> +       }
>> +
>> +       /* Ready to process request 'QUEUED -> PROCESSING'. */
>> +       ureq->state =3D QCOM_TEE_REQ_PROCESSING;
>> +
>> +       return ureq;
>> +}
>> +
>> +/* User object dispatcher. */
>> +static int qcom_tee_user_object_dispatch(struct qcom_tee_object_invoke_ct=
x *oic,
>> +                                        struct qcom_tee_object *object, u=
32 op,
>> +                                        struct qcom_tee_arg *args)
>> +{
>> +       struct qcom_tee_user_object *uo =3D to_qcom_tee_user_object(object=
);
>> +       struct qcom_tee_user_req *ureq __free(kfree);
>> +       struct qcom_tee_context *ctx =3D uo->ctx;
>> +       int errno;
>> +
>> +       ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
>> +       if (!ureq)
>> +               return -ENOMEM;
>> +
>> +       init_completion(&ureq->c);
>> +       ureq->object_id =3D uo->object_id;
>> +       ureq->op =3D op;
>> +       ureq->args =3D args;
>> +
>> +       /* Queue the request. */
>> +       if (qcom_tee_request_enqueue(ureq, ctx))
>> +               return -ENODEV;
>> +
>> +       /* Wakeup supplicant to process it. */
>> +       complete(&ctx->req_c);
>> +
>> +       /* Wait for supplicant to process the request. */
>> +       /* Supplicant is expected to process request in a timely manner. W=
e wait as KILLABLE,
>=20
> requests
>=20
>> +        * in case supplicant and invoke thread both running from a same u=
ser process, otherwise
>=20
> the same
>=20
>> +        * the process stuck on fatal signal.
>=20
> might get stuck on a fatal signal?
>=20
>> +        */
>=20
> Please combine into one comment.
>=20

Ack.

>> +       if (!wait_for_completion_state(&ureq->c, TASK_KILLABLE | TASK_FREE=
ZABLE)) {
>> +               errno =3D ureq->errno;
>> +               /* On SUCCESS, end_cb_notify frees the request. */
>> +               if (!errno)
>> +                       oic->data =3D no_free_ptr(ureq);
>> +       } else {
>> +               enum qcom_tee_req_state prev_state;
>> +
>> +               errno =3D -ENODEV;
>> +
>> +               scoped_guard(mutex, &ctx->lock) {
>> +                       prev_state =3D ureq->state;
>> +                       /* Replace ureq with '__empty_ureq' to keep req_id=
 reserved. */
>> +                       if (prev_state =3D=3D QCOM_TEE_REQ_PROCESSING)
>> +                               idr_replace(&ctx->reqs_idr, &__empty_ureq,=
 ureq->req_id);
>> +                       /* Remove ureq as supplicant has never seen this r=
equest. */
>> +                       else if (prev_state =3D=3D QCOM_TEE_REQ_QUEUED)
>> +                               idr_remove(&ctx->reqs_idr, ureq->req_id);
>> +               }
>> +
>> +               /* Wait for exclusive access to ureq. */
>> +               synchronize_srcu(&ctx->req_srcu);
>=20
> I'm sorry, I don't follow.
>

I'll try to compare it to the optee.

In optee, clients and the supplicant run in two different contexts. If the
supplicant is available, the client will wait for it to finish processing
the queued request. The supplicant is guaranteed to be timely and responsive.

In QCOMTEE:

  1. There are multiple supplicants. Any process that implements a callback
     object is considered a supplicant. The general assumption of timeliness
     or responsiveness may not apply. We allow the client to at least receive=
 fatal
     signals (this design can be extended later if a timeout is required).

  2. A client can implement a callback object and act as both a client and
     a supplicant simultaneously. To terminate such a process, we need to be
     able to accept fatal signals.

srcu is specifically used to protect the args array. After returning from
qcom_tee_user_object_dispatch, the args array might not be valid. We need to
ensure no one is accessing the args array before the retun, hence synchronize=
_srcu.
Whenever we read the contents of args, we do it within an srcu read lock.

For example, qcomtee_user_object_pop, which picks a request for the supplicant
to process, will hold the srcu read lock when marshaling the args array
to the TEE subsystem's params array.

An alternative to the srcu would be to use "context lock" ctx->lock and
hold it throughout the qcomtee_user_object_pop function, even when marshaling
the args array to the TEE subsystem's params array.

Using ctx->lock is easier to follow, but since it's shared by everyone in
a context and marshaling can be heavy depending on the type of objects,
I thought srcu would be more performant.

In other words, srcu just moves the marshaling of objects outside of ctx->loc=
k.
What do you think about keeping srcu or replacing it with ctx->lock?


Thank you so much Jens for the comments.

Best Reagrds,
Amir

> Cheers,
> Jens
>=20
>> +
>> +               /* Supplicant did some work for us, we should not discard =
it. */
>> +               if (prev_state =3D=3D QCOM_TEE_REQ_PROCESSED) {
>> +                       errno =3D ureq->errno;
>> +                       /* On SUCCESS, end_cb_notify frees the request. */
>> +                       if (!errno)
>> +                               oic->data =3D no_free_ptr(ureq);
>> +               }
>> +       }
>> +
>> +       return errno;
>> +}
>> +
>> +/* Called after submitting the callback response. */
>> +static void qcom_tee_user_object_end_cb_notify(struct qcom_tee_object_inv=
oke_ctx *oic,
>> +                                              struct qcom_tee_object *unu=
sed_object, int err)
>> +{
>> +       struct qcom_tee_user_req *ureq =3D oic->data;
>> +       struct qcom_tee_arg *u =3D ureq->args;
>> +       struct qcom_tee_object *object;
>> +       int i;
>> +
>> +       qcom_tee_arg_for_each_output_object(i, u) {
>> +               object =3D u[i].o;
>> +               /* If err, drop QTEE copy otherwise just drop driver's cop=
y. */
>> +               if (err && (typeof_qcom_tee_object(object) =3D=3D QCOM_TEE=
_OBJECT_TYPE_CB_OBJECT))
>> +                       qcom_tee_object_put(object);
>> +               qcom_tee_object_put(object);
>> +       }
>> +
>> +       kfree(ureq);
>> +}
>> +
>> +static void qcom_tee_user_object_release(struct qcom_tee_object *object)
>> +{
>> +       struct qcom_tee_user_object *uo =3D to_qcom_tee_user_object(object=
);
>> +       struct qcom_tee_context *ctx =3D uo->ctx;
>> +       struct qcom_tee_user_req *ureq;
>> +
>> +       static struct qcom_tee_arg args[] =3D { { .type =3D QCOM_TEE_ARG_T=
YPE_INV } };
>> +
>> +       if (READ_ONCE(uo->nor)) {
>> +               ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
>> +               if (ureq) {
>> +                       ureq->object_id =3D uo->object_id;
>> +                       ureq->op =3D QCOM_TEE_OBJREF_OP_RELEASE;
>> +                       ureq->args =3D args;
>> +
>> +                       /* Queue the RELEASE request and wake supplicant t=
o process it. */
>> +                       qcom_tee_request_enqueue(ureq, ctx);
>> +
>> +                       complete(&ctx->req_c);
>> +               } else {
>> +                       pr_err("failed to notify user object (%s) release.=
\n",
>> +                              qcom_tee_object_name(object));
>> +               }
>> +       }
>> +
>> +       /* Matching get is in qcom_tee_user_param_to_object(). */
>> +       kref_put(&ctx->ref_cnt, __qcom_tee_context_destroy);
>> +       kfree(uo);
>> +}
>> +
>> +static struct qcom_tee_object_operations qcom_tee_user_object_ops =3D {
>> +       .release =3D qcom_tee_user_object_release,
>> +       .notify =3D qcom_tee_user_object_end_cb_notify,
>> +       .dispatch =3D qcom_tee_user_object_dispatch,
>> +};
>> +
>> +/**
>> + * qcom_tee_user_param_to_object() - Convert OBJREF parameter to &struct =
qcom_tee_object.
>> + * @object: object returned.
>> + * @param: TEE parameter.
>> + * @ctx: context in which the conversion should happen.
>> + *
>> + * @param is OBJREF with %QCOM_TEE_OBJREF_FLAG_USER flags.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_user_param_to_object(struct qcom_tee_object **object, struct=
 tee_param *param,
>> +                                 struct qcom_tee_context *ctx)
>> +{
>> +       struct qcom_tee_user_object *user_object __free(kfree) =3D NULL;
>> +       struct qcom_tee_object *uo;
>> +       int err;
>> +
>> +       user_object =3D kzalloc(sizeof(*user_object), GFP_KERNEL);
>> +       if (!user_object)
>> +               return -ENOMEM;
>> +
>> +       user_object->ctx =3D ctx;
>> +       user_object->object_id =3D param->u.objref.id;
>> +       /* By default, always notify userspace on release. */
>> +       user_object->nor =3D true;
>> +
>> +       err =3D qcom_tee_object_user_init(&user_object->object, QCOM_TEE_O=
BJECT_TYPE_CB_OBJECT,
>> +                                       &qcom_tee_user_object_ops, "uo-%lu=
", param->u.objref.id);
>> +       if (err)
>> +               return err;
>> +
>> +       uo =3D &no_free_ptr(user_object)->object;
>> +       /* Keep context alive as user object is alive. */
>> +       kref_get(&ctx->ref_cnt);
>> +
>> +       *object =3D uo;
>> +
>> +       return 0;
>> +}
>> +
>> +/* Reverse what qcom_tee_user_param_to_object() does. */
>> +int qcom_tee_user_param_from_object(struct tee_param *param, struct qcom_=
tee_object *object,
>> +                                   struct qcom_tee_context *ctx)
>> +{
>> +       struct qcom_tee_user_object *uo;
>> +
>> +       if (!is_qcom_tee_user_object(object))
>> +               return -EINVAL;
>> +
>> +       uo =3D to_qcom_tee_user_object(object);
>> +       /* Sure if the object is in a same context as caller? */
>> +       if (uo->ctx !=3D ctx)
>> +               return -EINVAL;
>> +
>> +       param->u.objref.id =3D uo->object_id;
>> +       param->u.objref.flags =3D QCOM_TEE_OBJREF_FLAG_USER;
>> +
>> +       /* User objects are valid in the context of userspace; drop the dr=
iver copy. */
>> +       qcom_tee_object_put(object);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * qcom_tee_cb_params_from_args() - Convert QTEE arguments to TEE paramet=
ers in a context.
>> + * @params: TEE parameters.
>> + * @u: QTEE arguments.
>> + * @num_params: number of elements in the parameter array.
>> + * @ubuf_addr: user buffer for argument of type %QCOM_TEE_ARG_TYPE_IB.
>> + * @ubuf_size: size of user buffer.
>> + * @ctx: context in which the conversion should happen.
>> + *
>> + * It expects @params to have enough entries for @u. Entries in @params a=
re of
>> + * %TEE_IOCTL_PARAM_ATTR_TYPE_NONE. On failure, it puts IO objects.
>> + *
>> + * Return: On success return number of input parameters processed or <0 o=
n failure.
>> + */
>> +static int qcom_tee_cb_params_from_args(struct tee_param *params,
>> +                                       struct qcom_tee_arg *u, int num_pa=
rams,
>> +                                       void __user *ubuf_addr, size_t ubu=
f_size,
>> +                                       struct qcom_tee_context *ctx)
>> +{
>> +       int i, np =3D 0;
>> +
>> +       qcom_tee_arg_for_each(i, u) {
>> +               enum qcom_tee_arg_type at =3D u[i].type;
>> +
>> +               if (at =3D=3D QCOM_TEE_ARG_TYPE_IB) {
>> +                       params[np].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMB=
UF_INPUT;
>> +
>> +                       /* Underflow already checked in qcom_tee_supp_pop_=
entry(). */
>> +                       ubuf_size =3D round_down(ubuf_size - u[i].b.size, =
8);
>> +                       params[np].u.membuf.uaddr =3D (void * __user)(ubuf=
_addr + ubuf_size);
>> +                       params[np].u.membuf.size =3D u[i].b.size;
>> +                       if (copy_to_user(params[np].u.membuf.uaddr, u[i].b=
.addr, u[i].b.size))
>> +                               goto out_failed;
>> +
>> +                       np++;
>> +               } else if (at =3D=3D QCOM_TEE_ARG_TYPE_IO) {
>> +                       params[np].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_OBJR=
EF_INPUT;
>> +                       if (qcom_tee_objref_from_arg(&params[np], &u[i], c=
tx))
>> +                               goto out_failed;
>> +
>> +                       np++;
>> +               }
>> +       }
>> +
>> +       return np;
>> +
>> +out_failed:
>> +
>> +       /* On ERROR: */
>> +       /*  - Release params associated to QTEE objects in this context so=
 far. */
>> +       for (; np >=3D 0; np--) {
>> +               if (params[np].attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_OBJRE=
F_INPUT)
>> +                       qcom_tee_context_del_qtee_object(&params[np], ctx);
>> +       }
>> +       /*  - Release any IO objects not processed so far. */
>> +       while (u[i].type) {
>> +               if (u[i].type =3D=3D QCOM_TEE_ARG_TYPE_IO)
>> +                       qcom_tee_object_put(u[i++].o);
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +/**
>> + * qcom_tee_cb_params_to_args() - Convert TEE parameters to QTEE argument=
s in a context.
>> + * @u: QTEE arguments.
>> + * @params: TEE parameters.
>> + * @num_params: number of elements in the parameter array.
>> + * @ctx: context in which the conversion should happen.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +static int qcom_tee_cb_params_to_args(struct qcom_tee_arg *u,
>> +                                     struct tee_param *params, int num_pa=
rams,
>> +                                     struct qcom_tee_context *ctx)
>> +{
>> +       struct qcom_tee_object *object;
>> +       int i, np =3D 0;
>> +
>> +       qcom_tee_arg_for_each(i, u) {
>> +               enum qcom_tee_arg_type at =3D u[i].type;
>> +
>> +               if (at =3D=3D QCOM_TEE_ARG_TYPE_OB) {
>> +                       if (params[np].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE=
_MEMBUF_OUTPUT ||
>> +                           params[np].u.membuf.size > u[i].b.size)
>> +                               goto out_failed;
>> +
>> +                       if (copy_from_user(u[i].b.addr, params[np].u.membu=
f.uaddr, u[i].b.size))
>> +                               goto out_failed;
>> +
>> +                       u[i].b.size =3D params[np].u.membuf.size;
>> +
>> +                       np++;
>> +               } else if (at =3D=3D QCOM_TEE_ARG_TYPE_OO) {
>> +                       if (params[np].attr =3D=3D TEE_IOCTL_PARAM_ATTR_TY=
PE_OBJREF_OUTPUT) {
>> +                               if (qcom_tee_objref_to_arg(&u[i], &params[=
np], ctx))
>> +                                       goto out_failed;
>> +                       } else {
>> +                               goto out_failed;
>> +                       }
>> +
>> +                       np++;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +
>> +out_failed:
>> +
>> +       /* On ERROR: */
>> +       /* Put OO objects processed so far. */
>> +       for (--i; i >=3D 0; i--) {
>> +               if (u[i].type !=3D QCOM_TEE_ARG_TYPE_OO)
>> +                       continue;
>> +
>> +               object =3D u[i].o;
>> +               qcom_tee_user_object_set_notify(object, false);
>> +               /* For callback object, we hold a reference for the driver=
, put it. */
>> +               if (typeof_qcom_tee_object(object) =3D=3D QCOM_TEE_OBJECT_=
TYPE_CB_OBJECT)
>> +                       qcom_tee_object_put(object);
>> +               /* Put QTEE copy of object. */
>> +               qcom_tee_object_put(object);
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +/**
>> + * qcom_tee_user_object_pop() - Pop a request for a user object.
>> + * @ctx: context to look for user object.
>> + * @params: parameters for @op.
>> + * @num_params: number of elements in the parameter array.
>> + * @uaddr: user buffer for output MEMBUF parameters.
>> + * @size: size of user buffer @uaddr.
>> + * @data: information for the pop request.
>> + *
>> + * @params is filled along with @data for the picked request.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_user_object_pop(struct qcom_tee_context *ctx,
>> +                            struct tee_param *params, int num_params,
>> +                            void __user *uaddr, size_t size,
>> +                            struct qcom_tee_user_object_request_data *dat=
a)
>> +{
>> +       struct qcom_tee_user_req *ureq;
>> +       struct qcom_tee_arg *req_args;
>> +       u64 req_object_id;
>> +       u32 req_op;
>> +       int req_id;
>> +       int ret;
>> +
>> +       while (1) {
>> +               scoped_guard(srcu, &ctx->req_srcu) {
>> +                       /* Pop a request 'QUEUED -> PROCESSING'. */
>> +                       ureq =3D qcom_tee_supp_pop_entry(ctx, size, num_pa=
rams);
>> +                       if (!ureq)
>> +                               goto wait_for_request;
>> +
>> +                       /* On failure, issue with params, e.g. not enough =
space in user buffer. */
>> +                       if (IS_ERR(ureq))
>> +                               return PTR_ERR(ureq);
>> +
>> +                       /* ''Prepare user request:'' */
>> +                       req_id =3D ureq->req_id;
>> +                       req_object_id =3D ureq->object_id;
>> +                       req_op =3D ureq->op;
>> +                       req_args =3D ureq->args;
>> +                       ret =3D qcom_tee_cb_params_from_args(params, req_a=
rgs,
>> +                                                          num_params, uad=
dr,
>> +                                                          size, ctx);
>> +               }
>> +
>> +               if (ret >=3D 0)
>> +                       break;
>> +
>> +               /* On failure, issue with req_args, e.g. invalid object. */
>> +               scoped_guard(mutex, &ctx->lock) {
>> +                       /* If (!=3D __empty_req) then 'PROCESSING -> PROCE=
SSED'. */
>> +                       if (idr_remove(&ctx->reqs_idr, req_id) =3D=3D ureq=
) {
>> +                               ureq->state =3D QCOM_TEE_REQ_PROCESSED;
>> +                               ureq->errno =3D ret;
>> +                               /* Send error to QTEE. */
>> +                               complete(&ureq->c);
>> +                       }
>> +               }
>> +
>> +               /* Try next request. */
>> +               continue;
>> +
>> +wait_for_request:
>> +               /* Wait for a new QUEUED request. */
>> +               if (wait_for_completion_interruptible(&ctx->req_c))
>> +                       return -ERESTARTSYS;
>> +       }
>> +
>> +       /* It is a RELEASE message; no one is waiting for result. */
>> +       if (req_op =3D=3D QCOM_TEE_OBJREF_OP_RELEASE) {
>> +               scoped_guard(mutex, &ctx->lock)
>> +                       idr_remove(&ctx->reqs_idr, req_id);
>> +               kfree(ureq);
>> +       }
>> +
>> +       /* ''Pick a pending request:'' */
>> +       data->id =3D req_id;
>> +       data->object_id =3D req_object_id;
>> +       data->op =3D req_op;
>> +       data->np =3D ret;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * qcom_tee_user_object_submit() - Submit a response for a user object.
>> + * @ctx: context to look for user object.
>> + * @params: returned parameters.
>> + * @num_params: number of elements in the parameter array.
>> + * @id: request id for the response.
>> + * @errno: result of user object invocation.
>> + *
>> + * Return: On success return 0 or <0 on failure.
>> + */
>> +int qcom_tee_user_object_submit(struct qcom_tee_context *ctx,
>> +                               struct tee_param *params, int num_params, =
int id, int errno)
>> +{
>> +       struct qcom_tee_user_req *ureq;
>> +
>> +       scoped_guard(srcu, &ctx->req_srcu) {
>> +               scoped_guard(mutex, &ctx->lock) {
>> +                       ureq =3D idr_remove(&ctx->reqs_idr, id);
>> +                       /* Is id invalid, or no one is waiting on response=
. */
>> +                       if (ureq =3D=3D &__empty_ureq || !ureq)
>> +                               return -ENODEV;
>> +
>> +                       ureq->state =3D QCOM_TEE_REQ_PROCESSED;
>> +               }
>> +
>> +               ureq->errno =3D errno;
>> +               /* Process params only on SUCCESS. */
>> +               if (!errno)
>> +                       ureq->errno =3D qcom_tee_cb_params_to_args(ureq->a=
rgs, params,
>> +                                                                num_param=
s, ctx);
>> +
>> +               errno =3D (!errno && ureq->errno) ? ureq->errno : 0;
>> +               /* Send result to QTEE. */
>> +               complete(&ureq->c);
>> +       }
>> +
>> +       return errno;
>> +}
>> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
>> index 5d33a8009efb..00e599d1582d 100644
>> --- a/include/uapi/linux/tee.h
>> +++ b/include/uapi/linux/tee.h
>> @@ -59,6 +59,7 @@
>>  #define TEE_IMPL_ID_OPTEE      1
>>  #define TEE_IMPL_ID_AMDTEE     2
>>  #define TEE_IMPL_ID_TSTEE      3
>> +#define TEE_IMPL_ID_QTEE       4
>>
>>  /*
>>   * OP-TEE specific capabilities
>>
>> --
>> 2.34.1
>>

--===============7987549353023230207==--

