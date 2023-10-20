From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH] tee: tstee: Add initial Trusted Services TEE driver
Date: Fri, 20 Oct 2023 15:52:20 +0200
Message-ID: <8DD61032-21F1-45D1-9908-66792540BD5A@arm.com>
In-Reply-To: <
 <CAFA6WYNbP7F0fYAQmqfQ6keBVk-qJaoAueg0eUc1A5FhP8rU-w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7119050144913917146=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7119050144913917146==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 13 Oct 2023, at 14:47, Sumit Garg wrote:
> On Wed, 27 Sept 2023 at 20:56, Balint Dobszay <balint.dobszay@arm.com> wr=
ote:

[snip]

>> diff --git a/drivers/tee/tstee/core.c b/drivers/tee/tstee/core.c
>> new file mode 100644
>> index 000000000000..c0194638b7da
>> --- /dev/null
>> +++ b/drivers/tee/tstee/core.c
>> @@ -0,0 +1,473 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Arm Limited
>> + */
>> +
>> +#define DRIVER_NAME "Arm TSTEE"
>> +#define pr_fmt(fmt) DRIVER_NAME ": " fmt
>> +
>> +#include <linux/arm_ffa.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/limits.h>
>> +#include <linux/list.h>
>> +#include <linux/mm.h>
>> +#include <linux/module.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/slab.h>
>> +#include <linux/stat.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/types.h>
>> +#include <linux/uaccess.h>
>> +
>> +#include "tstee_private.h"
>> +
>> +#define FFA_INVALID_MEM_HANDLE U64_MAX
>> +
>> +static void arg_list_to_ffa_data(const u32 *args, struct ffa_send_direct_=
data *data)
>> +{
>> +       data->data0 =3D args[0];
>> +       data->data1 =3D args[1];
>> +       data->data2 =3D args[2];
>> +       data->data3 =3D args[3];
>> +       data->data4 =3D args[4];
>> +}
>> +
>> +static void arg_list_from_ffa_data(const struct ffa_send_direct_data *dat=
a, u32 *args)
>> +{
>> +       args[0] =3D lower_32_bits(data->data0);
>> +       args[1] =3D lower_32_bits(data->data1);
>> +       args[2] =3D lower_32_bits(data->data2);
>> +       args[3] =3D lower_32_bits(data->data3);
>> +       args[4] =3D lower_32_bits(data->data4);
>> +}
>> +
>> +static void tstee_get_version(struct tee_device *teedev, struct tee_ioctl=
_version_data *vers)
>> +{
>> +       struct tstee *tstee =3D tee_get_drvdata(teedev);
>> +       struct tee_ioctl_version_data v =3D {
>> +               .impl_id =3D TEE_IMPL_ID_TSTEE,
>> +               .impl_caps =3D tstee->ffa_dev->vm_id,
>
> So while exploring the user-space interface, I observed an anomaly
> here. The ".impl_caps" refers to "Implementation specific
> capabilities" meant to support backwards compatibility of a particular
> TEE implementation. But here I observe you are using it instead for
> endpoint_id. Can you provide the reasoning behind it? Also, do you
> plan to support multiple endpoints via this driver?

The mapping between Trusted Services SPs and TEE devices is 1:1, i.e.
each /dev/tee<n> device represents exactly one FF-A endpoint. To answer
your second question, each instance of the driver represents a single
endpoint, multiple endpoints are supported by having multiple instances
of the driver. Therefore we always return a single endpoint ID in this
field.

The reason behind the usage of this field is that somehow user space has
to be able to discover which TEE device represents which FF-A endpoint.
This is required when a client wants to invoke an SP with a specific
endpoint ID, e.g. in a system where the SP's endpoint IDs is static and
known by the client.

I understand this is not a conventional usage of this field, I couldn't
find a better way to "fit" this information into the ABI. My
understanding is this solution shouldn't cause any issues for other
TEEs, since this implementation specific field should only be parsed by
a client if it has already matched on the TEE implementation ID. Please
correct me if this assumption is wrong, or if you have any suggestions
on other ways to expose the endpoint ID to user space.

>> +               .gen_caps =3D 0,
>
> Do you plan to support TEE_GEN_CAP_REG_MEM? IOW, do you expect
> user-space to leverage TEE_IOC_SHM_REGISTER? I can see this driver
> already provides tstee_shm_register() and tstee_shm_unregister()
> callbacks.

We didn't have a use case yet that would require this feature. I will
give it some more thought, whether it's likely that it will be needed in
the future.

>> +       };
>> +
>> +       *vers =3D v;
>> +}
>> +
>> +static int tstee_open(struct tee_context *ctx)
>> +{
>> +       struct ts_context_data *ctxdata;
>> +
>> +       ctxdata =3D kzalloc(sizeof(*ctxdata), GFP_KERNEL);
>> +       if (!ctxdata)
>> +               return -ENOMEM;
>> +
>> +       mutex_init(&ctxdata->mutex);
>> +       idr_init(&ctxdata->sess_ids);
>> +       INIT_LIST_HEAD(&ctxdata->sess_list);
>> +
>> +       ctx->data =3D ctxdata;
>> +
>> +       return 0;
>> +}
>> +
>> +static void tstee_release(struct tee_context *ctx)
>> +{
>> +       struct ts_context_data *ctxdata =3D ctx->data;
>> +       struct ts_session *sess, *sess_tmp;
>> +
>> +       if (!ctxdata)
>> +               return;
>> +
>> +       list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list, list=
_node) {
>> +               list_del(&sess->list_node);
>> +               idr_remove(&ctxdata->sess_ids, sess->session_id);
>> +               kfree(sess);
>> +       }
>> +
>> +       idr_destroy(&ctxdata->sess_ids);
>> +       mutex_destroy(&ctxdata->mutex);
>> +
>> +       kfree(ctxdata);
>> +       ctx->data =3D NULL;
>> +}
>> +
>> +static struct ts_session *find_session(struct ts_context_data *ctxdata, u=
32 session_id)
>> +{
>> +       struct ts_session *sess;
>> +
>> +       list_for_each_entry(sess, &ctxdata->sess_list, list_node)
>> +               if (sess->session_id =3D=3D session_id)
>> +                       return sess;
>> +
>> +       return NULL;
>> +}
>> +
>> +static int tstee_open_session(struct tee_context *ctx, struct tee_ioctl_o=
pen_session_arg *arg,
>> +                             struct tee_param *param __always_unused)
>> +{
>> +       struct tstee *tstee =3D tee_get_drvdata(ctx->teedev);
>> +       struct ffa_device *ffa_dev =3D tstee->ffa_dev;
>> +       struct ts_context_data *ctxdata =3D ctx->data;
>> +       struct ffa_send_direct_data ffa_data;
>> +       struct ts_session *sess =3D NULL;
>> +       u32 ffa_args[5] =3D {};
>
> Please don't use magic numbers.

Ack, will fix in the next version.

>> +       int sess_id;
>> +       int rc;
>> +
>> +       ffa_args[TS_RPC_CTRL_REG] =3D TS_RPC_CTRL_PACK_IFACE_OPCODE(TS_RPC=
_MGMT_IFACE_ID,
>> +                                                                 TS_RPC_O=
P_SERVICE_INFO);
>> +
>> +       memcpy((u8 *)(ffa_args + TS_RPC_SERVICE_INFO_UUID0), arg->uuid, UU=
ID_SIZE);
>> +
>> +       arg_list_to_ffa_data(ffa_args, &ffa_data);
>> +       rc =3D ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data=
);
>> +       if (rc)
>> +               return rc;
>> +
>> +       arg_list_from_ffa_data(&ffa_data, ffa_args);
>> +
>> +       if (ffa_args[TS_RPC_SERVICE_INFO_RPC_STATUS] !=3D TS_RPC_OK)
>> +               return -ENODEV;
>> +
>> +       if (ffa_args[TS_RPC_SERVICE_INFO_IFACE] > U8_MAX)
>> +               return -EINVAL;
>> +
>> +       sess =3D kzalloc(sizeof(*sess), GFP_KERNEL);
>> +       if (!sess)
>> +               return -ENOMEM;
>> +
>> +       sess_id =3D idr_alloc(&ctxdata->sess_ids, sess, 1, 0, GFP_KERNEL);
>> +       if (sess_id < 0) {
>> +               kfree(sess);
>> +               return sess_id;
>> +       }
>> +
>> +       sess->session_id =3D sess_id;
>> +       sess->iface_id =3D ffa_args[TS_RPC_SERVICE_INFO_IFACE];
>> +
>> +       mutex_lock(&ctxdata->mutex);
>> +       list_add(&sess->list_node, &ctxdata->sess_list);
>> +       mutex_unlock(&ctxdata->mutex);
>> +
>> +       arg->session =3D sess_id;
>> +       arg->ret =3D 0;
>> +
>> +       return 0;
>> +}
>> +
>> +static int tstee_close_session(struct tee_context *ctx, u32 session)
>> +{
>> +       struct ts_context_data *ctxdata =3D ctx->data;
>> +       struct ts_session *sess;
>> +
>> +       mutex_lock(&ctxdata->mutex);
>> +       sess =3D find_session(ctxdata, session);
>> +       if (sess)
>> +               list_del(&sess->list_node);
>> +
>> +       mutex_unlock(&ctxdata->mutex);
>> +
>> +       if (!sess)
>> +               return -EINVAL;
>> +
>> +       idr_remove(&ctxdata->sess_ids, sess->session_id);
>> +       kfree(sess);
>> +
>> +       return 0;
>> +}
>> +
>> +static int tstee_invoke_func(struct tee_context *ctx, struct tee_ioctl_in=
voke_arg *arg,
>> +                            struct tee_param *param)
>> +{
>> +       struct tstee *tstee =3D tee_get_drvdata(ctx->teedev);
>> +       struct ffa_device *ffa_dev =3D tstee->ffa_dev;
>> +       struct ts_context_data *ctxdata =3D ctx->data;
>> +       struct ffa_send_direct_data ffa_data;
>> +       struct tee_shm *shm =3D NULL;
>> +       struct ts_session *sess;
>> +       u32 req_len, ffa_args[5] =3D {};
>
> ditto.

Ack.

Regards,
Balint

--===============7119050144913917146==--

