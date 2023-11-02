From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4 1/2] tee: optee: Fix supplicant based device enumeration
Date: Thu, 02 Nov 2023 16:28:21 +0200
Message-ID: 
 <CAC_iWjL_DLrKqbxvnWPmOYxLULjC46LMca5cF_sza1LDyifuWA@mail.gmail.com>
In-Reply-To: <20231102073056.174480-2-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2598272522622860032=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2598272522622860032==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Thu, 2 Nov 2023 at 09:31, Sumit Garg <sumit.garg@linaro.org> wrote:
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
> Fix this by adding an attribute for supplicant dependent devices so that
> the user-space service can detect and detach supplicant devices before
> closing the supplicant:
>
> $ for dev in /sys/bus/tee/devices/*; do if [[ -f "$dev/need_supplicant" && =
-f "$dev/driver/unbind" ]]; \
>       then echo $(basename "$dev") > $dev/driver/unbind; fi done
>
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://github.com/OP-TEE/optee_os/issues/6094
> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration=
")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  .../ABI/testing/sysfs-bus-optee-devices         |  9 +++++++++
>  drivers/tee/optee/device.c                      | 17 +++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentat=
ion/ABI/testing/sysfs-bus-optee-devices
> index 0f58701367b6..d914f6629662 100644
> --- a/Documentation/ABI/testing/sysfs-bus-optee-devices
> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> @@ -6,3 +6,12 @@ Description:
>                 OP-TEE bus provides reference to registered drivers under t=
his directory. The <uuid>
>                 matches Trusted Application (TA) driver and corresponding T=
A in secure OS. Drivers
>                 are free to create needed API under optee-ta-<uuid> directo=
ry.
> +
> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
> +Date:          July 2008

nit, date needs changing

> +KernelVersion: 6.7
> +Contact:       op-tee(a)lists.trustedfirmware.org
> +Description:
> +               Allows to distinguish whether an OP-TEE based TA/device req=
uires user-space
> +               tee-supplicant to function properly or not. This attribute =
will be present for
> +               devices which depend on tee-supplicant to be running.
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 64f0e047c23d..4b1092127694 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -60,7 +60,16 @@ static void optee_release_device(struct device *dev)
>         kfree(optee_device);
>  }
>
> -static int optee_register_device(const uuid_t *device_uuid)
> +static ssize_t

(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   char *buf)
> +{
> +       return 0;
> +}
> +
> +static DEVICE_ATTR_RO(need_supplicant);
> +
> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>  {
>         struct tee_client_device *optee_device =3D NULL;
>         int rc;
> @@ -83,6 +92,10 @@ static int optee_register_device(const uuid_t *device_uu=
id)
>                 put_device(&optee_device->dev);
>         }
>
> +       if (func =3D=3D PTA_CMD_GET_DEVICES_SUPP)
> +               device_create_file(&optee_device->dev,
> +                                  &dev_attr_need_supplicant);
> +
>         return rc;
>  }
>
> @@ -142,7 +155,7 @@ static int __optee_enumerate_devices(u32 func)
>         num_devices =3D shm_size / sizeof(uuid_t);
>
>         for (idx =3D 0; idx < num_devices; idx++) {
> -               rc =3D optee_register_device(&device_uuid[idx]);
> +               rc =3D optee_register_device(&device_uuid[idx], func);
>                 if (rc)
>                         goto out_shm;
>         }
> --
> 2.34.1
>

Other than that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

--===============2598272522622860032==--

