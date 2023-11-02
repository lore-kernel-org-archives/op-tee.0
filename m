From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 1/2] tee: optee: Fix supplicant based device enumeration
Date: Thu, 02 Nov 2023 13:07:24 +0530
Message-ID: 
 <CAFA6WYNe+pt2meP-KDtG2duYqWXHHwTCnHnm97PeNsbi+PJ5ng@mail.gmail.com>
In-Reply-To: <1418e74e-175f-4b04-90d7-8bec2987c207@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8096243884471604622=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8096243884471604622==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Oct 2023 at 17:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 31.10.23 12:04, Jerome Forissier wrote:
> >
> >
> > On 10/30/23 16:59, Sumit Garg wrote:
> >> Currently supplicant dependent optee device enumeration only registers
> >> devices whenever tee-supplicant is invoked for the first time. But it
> >> forgets to remove devices when tee-supplicant daemon stops running and
> >> closes its context gracefully. This leads to following error for fTPM
> >> driver during reboot/shutdown:
> >>
> >> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke err=
or: 0xffff3024
> >>
> >> Fix this by separating supplicant dependent devices so that the
> >> user-space service can detach supplicant devices before closing the
> >> supplicant.
> >>
> >> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Link: https://github.com/OP-TEE/optee_os/issues/6094
> >> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumerat=
ion")
> >> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> ---
> >>  drivers/tee/optee/device.c | 13 ++++++++++---
> >>  1 file changed, 10 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> >> index 64f0e047c23d..78fc0a15c463 100644
> >> --- a/drivers/tee/optee/device.c
> >> +++ b/drivers/tee/optee/device.c
> >> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
> >>      kfree(optee_device);
> >>  }
> >>
> >> -static int optee_register_device(const uuid_t *device_uuid)
> >> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
> >>  {
> >>      struct tee_client_device *optee_device =3D NULL;
> >> +    const char *dev_name_fmt =3D NULL;
> >>      int rc;
> >>
> >>      optee_device =3D kzalloc(sizeof(*optee_device), GFP_KERNEL);
> >> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device=
_uuid)
> >>
> >>      optee_device->dev.bus =3D &tee_bus_type;
> >>      optee_device->dev.release =3D optee_release_device;
> >> -    if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid))=
 {
> >> +
> >> +    if (func =3D=3D PTA_CMD_GET_DEVICES_SUPP)
> >> +            dev_name_fmt =3D "optee-ta-supp-%pUb";
> >> +    else
> >> +            dev_name_fmt =3D "optee-ta-%pUb";
> >
> > That's an ABI change, isn't it?
>

Indeed it is an ABI break although we would like this to be backported
but don't want to break existing users. So I brainstormed on it and
came up with an alternative fix via device attribute in v4. Please
have a look.

> Oh, here did this come from! Yes, I recently had to adjust some systemd
> service due to carrying this patch but looking for the change only in
> upstream:
>
> https://github.com/ilbers/isar/commit/83644ddf694e51f11793e6107e4aaf68dc004=
3a5
>

You don't need to unbind all of the optee devices. v4 would help you
to maintain backwards compatibility, can you retest it?

-Sumit

> Jan
>
> >
> >> +
> >> +    if (dev_set_name(&optee_device->dev, dev_name_fmt, device_uuid)) {
> >>              kfree(optee_device);
> >>              return -ENOMEM;
> >>      }
> >> @@ -142,7 +149,7 @@ static int __optee_enumerate_devices(u32 func)
> >>      num_devices =3D shm_size / sizeof(uuid_t);
> >>
> >>      for (idx =3D 0; idx < num_devices; idx++) {
> >> -            rc =3D optee_register_device(&device_uuid[idx]);
> >> +            rc =3D optee_register_device(&device_uuid[idx], func);
> >>              if (rc)
> >>                      goto out_shm;
> >>      }
> >
>
> --
> Siemens AG, Technology
> Linux Expert Center
>

--===============8096243884471604622==--

