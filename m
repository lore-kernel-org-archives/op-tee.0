From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: optee: Fix supplicant based device enumeration
Date: Tue, 29 Aug 2023 16:33:03 +0530
Message-ID: 
 <CAFA6WYP7hgRWS_gp2AFEWDs27aOeUndB6+1dh95TtW2s1N+5Ag@mail.gmail.com>
In-Reply-To: <20230728134832.326467-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4029382825849852888=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4029382825849852888==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Fri, 28 Jul 2023 at 19:18, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Currently supplicant dependent optee device enumeration only registers
> devices whenever tee-supplicant is invoked for the first time. But it
> forgets to remove devices when tee-supplicant daemon stops running and
> closes its context gracefully. This leads to following error for fTPM
> driver during reboot/shutdown:
>
> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error:=
 0xffff3024
>
> Fix this by separating supplicant dependent devices so that the
> user-space service can detach supplicant devices before closing the
> supplicant. While at it use the global system workqueue for OP-TEE bus
> scanning work rather than our own custom one.
>
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://github.com/OP-TEE/optee_os/issues/6094

I see you have marked this issue as resolved. It would be good to have
your tested-by tag if it works for you.

-Sumit

> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration=
")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v2:
>
> Apologies for taking it too long push this v2. Actually I did brainstorm
> how to best fix this tee-supplicant dependent device probing. Its hard
> to predict the lifetime of user-space daemon from kernel space. So
> following is the least intrusive approach:
>
> - Use device names to seperate out tee-supplicant dependent devices via
>   this patch.
> - Since user-space service is aware about tee-supplicant lifespan, so
>   allow the user-space service to unbind tee-supplicant dependent
>   devices before killing the supplicant. Following command has to be
>   added to the tee-supplicant service file.
>
>   $ for dev in /sys/bus/tee/devices/*; do if [[ "$dev" =3D=3D *"optee-ta-su=
pp-"* ]]; \
>         then echo $(basename "$dev") > $dev/driver/unbind; fi done
>
>  drivers/tee/optee/core.c          | 13 ++-----------
>  drivers/tee/optee/device.c        | 13 ++++++++++---
>  drivers/tee/optee/optee_private.h |  2 --
>  3 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index d01ca47f7bde..8ee3c71bd989 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -15,7 +15,6 @@
>  #include <linux/string.h>
>  #include <linux/tee_drv.h>
>  #include <linux/types.h>
> -#include <linux/workqueue.h>
>  #include "optee_private.h"
>
>  int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *=
shm,
> @@ -110,12 +109,7 @@ int optee_open(struct tee_context *ctx, bool cap_memre=
f_null)
>
>                 if (!optee->scan_bus_done) {
>                         INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
> -                       optee->scan_bus_wq =3D create_workqueue("optee_bus_=
scan");
> -                       if (!optee->scan_bus_wq) {
> -                               kfree(ctxdata);
> -                               return -ECHILD;
> -                       }
> -                       queue_work(optee->scan_bus_wq, &optee->scan_bus_wor=
k);
> +                       schedule_work(&optee->scan_bus_work);
>                         optee->scan_bus_done =3D true;
>                 }
>         }
> @@ -159,10 +153,7 @@ void optee_release_supp(struct tee_context *ctx)
>         struct optee *optee =3D tee_get_drvdata(ctx->teedev);
>
>         optee_release_helper(ctx, optee_close_session_helper);
> -       if (optee->scan_bus_wq) {
> -               destroy_workqueue(optee->scan_bus_wq);
> -               optee->scan_bus_wq =3D NULL;
> -       }
> +
>         optee_supp_release(&optee->supp);
>  }
>
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 64f0e047c23d..78fc0a15c463 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
>         kfree(optee_device);
>  }
>
> -static int optee_register_device(const uuid_t *device_uuid)
> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>  {
>         struct tee_client_device *optee_device =3D NULL;
> +       const char *dev_name_fmt =3D NULL;
>         int rc;
>
>         optee_device =3D kzalloc(sizeof(*optee_device), GFP_KERNEL);
> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uu=
id)
>
>         optee_device->dev.bus =3D &tee_bus_type;
>         optee_device->dev.release =3D optee_release_device;
> -       if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid))=
 {
> +
> +       if (func =3D=3D PTA_CMD_GET_DEVICES_SUPP)
> +               dev_name_fmt =3D "optee-ta-supp-%pUb";
> +       else
> +               dev_name_fmt =3D "optee-ta-%pUb";
> +
> +       if (dev_set_name(&optee_device->dev, dev_name_fmt, device_uuid)) {
>                 kfree(optee_device);
>                 return -ENOMEM;
>         }
> @@ -142,7 +149,7 @@ static int __optee_enumerate_devices(u32 func)
>         num_devices =3D shm_size / sizeof(uuid_t);
>
>         for (idx =3D 0; idx < num_devices; idx++) {
> -               rc =3D optee_register_device(&device_uuid[idx]);
> +               rc =3D optee_register_device(&device_uuid[idx], func);
>                 if (rc)
>                         goto out_shm;
>         }
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_pr=
ivate.h
> index 6dcecb83c893..af4aa266c3fb 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -193,7 +193,6 @@ struct optee_ops {
>   * @pool:              shared memory pool
>   * @rpc_param_count:   If > 0 number of RPC parameters to make room for
>   * @scan_bus_done      flag if device registation was already done.
> - * @scan_bus_wq                workqueue to scan optee bus and register op=
tee drivers
>   * @scan_bus_work      workq to scan optee bus and register optee drivers
>   */
>  struct optee {
> @@ -212,7 +211,6 @@ struct optee {
>         struct tee_shm_pool *pool;
>         unsigned int rpc_param_count;
>         bool   scan_bus_done;
> -       struct workqueue_struct *scan_bus_wq;
>         struct work_struct scan_bus_work;
>  };
>
> --
> 2.34.1
>

--===============4029382825849852888==--

