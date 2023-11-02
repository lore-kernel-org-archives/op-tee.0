From: Jerome Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4 1/2] tee: optee: Fix supplicant based device enumeration
Date: Thu, 02 Nov 2023 10:26:26 +0100
Message-ID: <d3d6e1a6-51d1-4bc5-bb6a-f3fff1d3312f@linaro.org>
In-Reply-To: <20231102073056.174480-2-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6758091062328819019=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6758091062328819019==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 11/2/23 08:30, Sumit Garg wrote:
> Currently supplicant dependent optee device enumeration only registers
> devices whenever tee-supplicant is invoked for the first time. But it
> forgets to remove devices when tee-supplicant daemon stops running and
> closes its context gracefully. This leads to following error for fTPM
> driver during reboot/shutdown:
>=20
> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error:=
 0xffff3024
>=20
> Fix this by adding an attribute for supplicant dependent devices so that
> the user-space service can detect and detach supplicant devices before
> closing the supplicant:
>=20
> $ for dev in /sys/bus/tee/devices/*; do if [[ -f "$dev/need_supplicant" && =
-f "$dev/driver/unbind" ]]; \
>       then echo $(basename "$dev") > $dev/driver/unbind; fi done
>=20
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://github.com/OP-TEE/optee_os/issues/6094
> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration=
")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  .../ABI/testing/sysfs-bus-optee-devices         |  9 +++++++++
>  drivers/tee/optee/device.c                      | 17 +++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentat=
ion/ABI/testing/sysfs-bus-optee-devices
> index 0f58701367b6..d914f6629662 100644
> --- a/Documentation/ABI/testing/sysfs-bus-optee-devices
> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> @@ -6,3 +6,12 @@ Description:
>  		OP-TEE bus provides reference to registered drivers under this directory=
. The <uuid>
>  		matches Trusted Application (TA) driver and corresponding TA in secure O=
S. Drivers
>  		are free to create needed API under optee-ta-<uuid> directory.
> +
> +What:		/sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
> +Date:		July 2008
> +KernelVersion:	6.7
> +Contact:	op-tee(a)lists.trustedfirmware.org
> +Description:
> +		Allows to distinguish whether an OP-TEE based TA/device requires user-sp=
ace
> +		tee-supplicant to function properly or not. This attribute will be prese=
nt for
> +		devices which depend on tee-supplicant to be running.
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 64f0e047c23d..4b1092127694 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -60,7 +60,16 @@ static void optee_release_device(struct device *dev)
>  	kfree(optee_device);
>  }
> =20
> -static int optee_register_device(const uuid_t *device_uuid)
> +static ssize_t need_supplicant_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	return 0;
> +}
> +
> +static DEVICE_ATTR_RO(need_supplicant);
> +
> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>  {
>  	struct tee_client_device *optee_device =3D NULL;
>  	int rc;
> @@ -83,6 +92,10 @@ static int optee_register_device(const uuid_t *device_uu=
id)
>  		put_device(&optee_device->dev);
>  	}
> =20
> +	if (func =3D=3D PTA_CMD_GET_DEVICES_SUPP)
> +		device_create_file(&optee_device->dev,
> +				   &dev_attr_need_supplicant);
> +
>  	return rc;
>  }
> =20
> @@ -142,7 +155,7 @@ static int __optee_enumerate_devices(u32 func)
>  	num_devices =3D shm_size / sizeof(uuid_t);
> =20
>  	for (idx =3D 0; idx < num_devices; idx++) {
> -		rc =3D optee_register_device(&device_uuid[idx]);
> +		rc =3D optee_register_device(&device_uuid[idx], func);
>  		if (rc)
>  			goto out_shm;
>  	}

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks!

--=20
Jerome

--===============6758091062328819019==--

