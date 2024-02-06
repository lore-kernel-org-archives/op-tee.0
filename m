From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 3/3] optee: probe RPMB device using RPMB subsystem
Date: Tue, 06 Feb 2024 16:42:40 +0530
Message-ID: 
 <CAFA6WYPATEXUNfYHA1abup=kYBREJq7y=D9d1DdkJCxXqPhgAQ@mail.gmail.com>
In-Reply-To: <20240131174347.510961-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5983098426674662588=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5983098426674662588==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, 31 Jan 2024 at 23:14, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe and
> use an RPMB device via the RPBM subsystem instead of passing the RPMB
> frames via tee-supplicant in user space. A fallback mechanism is kept to
> route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> available.
>
> The OP-TEE RPC ABI is extended to support iterating over all RPMB
> devices until one is found with the expected RPMB key already
> programmed.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c          |   1 +
>  drivers/tee/optee/ffa_abi.c       |   2 +
>  drivers/tee/optee/optee_private.h |   6 +
>  drivers/tee/optee/optee_rpc_cmd.h |  33 +++++
>  drivers/tee/optee/rpc.c           | 221 ++++++++++++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c       |   2 +
>  6 files changed, 265 insertions(+)
>

[snip]

>  #endif /*__OPTEE_RPC_CMD_H*/
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index e69bc6380683..6fd6f99dafab 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/rpmb.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
>  #include "optee_private.h"
> @@ -255,6 +256,217 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx=
, struct tee_shm *shm)
>         optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
>  }
>
> +static void handle_rpc_func_rpmb_probe_reset(struct tee_context *ctx,
> +                                            struct optee *optee,
> +                                            struct optee_msg_arg *arg)
> +{
> +       struct tee_param params[1];
> +
> +       if (!IS_ENABLED(CONFIG_RPMB)) {
> +               handle_rpc_supp_cmd(ctx, optee, arg);
> +               return;
> +       }
> +
> +       if (arg->num_params !=3D ARRAY_SIZE(params) ||
> +           optee->ops->from_msg_param(optee, params, arg->num_params,
> +                                      arg->params) ||
> +           params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT) {
> +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +
> +       params[0].u.value.a =3D OPTEE_RPC_SHM_TYPE_KERNEL;
> +       params[0].u.value.b =3D 0;
> +       params[0].u.value.c =3D 0;
> +       if (optee->ops->to_msg_param(optee, arg->params,
> +                                    arg->num_params, params)) {
> +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +
> +       mutex_lock(&optee->rpmb_dev_mutex);
> +       rpmb_dev_put(optee->rpmb_dev);
> +       optee->rpmb_dev =3D NULL;
> +       mutex_unlock(&optee->rpmb_dev_mutex);
> +
> +       arg->ret =3D TEEC_SUCCESS;
> +}
> +
> +static int rpc_rpmb_match(struct device *dev, const void *data)
> +{
> +       return 1;
> +}
> +
> +static void handle_rpc_func_rpmb_probe_next(struct tee_context *ctx,
> +                                           struct optee *optee,
> +                                           struct optee_msg_arg *arg)
> +{
> +       struct rpmb_dev *start_rdev;
> +       struct rpmb_dev *rdev;
> +       struct tee_param params[2];
> +       void *buf;
> +
> +       if (!IS_ENABLED(CONFIG_RPMB)) {
> +               handle_rpc_supp_cmd(ctx, optee, arg);
> +               return;
> +       }
> +
> +       if (arg->num_params !=3D ARRAY_SIZE(params) ||
> +           optee->ops->from_msg_param(optee, params, arg->num_params,
> +                                      arg->params) ||
> +           params[0].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT ||
> +           params[1].attr !=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT) {
> +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +       buf =3D tee_shm_get_va(params[1].u.memref.shm,
> +                            params[1].u.memref.shm_offs);
> +       if (!buf) {
> +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> +               return;
> +       }
> +
> +       mutex_lock(&optee->rpmb_dev_mutex);
> +       start_rdev =3D optee->rpmb_dev;
> +       rdev =3D rpmb_dev_find_device(NULL, start_rdev, rpc_rpmb_match);
> +       rpmb_dev_put(start_rdev);
> +       optee->rpmb_dev =3D rdev;
> +       mutex_unlock(&optee->rpmb_dev_mutex);
> +
> +       if (!rdev) {
> +               arg->ret =3D TEEC_ERROR_ITEM_NOT_FOUND;

One of the major comments I have here is regarding how this implicit
dependency on eMMC driver probe is met here. What if OP-TEE based
fTPM/EFI client driver probes before eMMC driver?

-Sumit

--===============5983098426674662588==--

