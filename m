From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 7/9] firmware: arm_ffa: Add v1.1 get_partition_info support
Date: Thu, 01 Sep 2022 10:43:58 +0200
Message-ID: 
 <CAHUa44Fmr=vDLbST5qwTDOtSZJq4RYqO+Y4Pij64VeBU-0BgrQ@mail.gmail.com>
In-Reply-To: <20220830100700.344594-8-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3741469840414823543=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3741469840414823543==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> FF-A v1.1 adds support to discovery the UUIDs of the partitions that was
> missing in v1.0 and which the driver workarounds by using UUIDs supplied
> by the ffa_drivers.
>
> Add the v1.1 get_partition_info support and disable the workaround if
> the detected FF-A version is greater than v1.0.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 39 ++++++++++++++++++++++++-------
>  include/linux/arm_ffa.h           |  1 +
>  2 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/d=
river.c
> index 5c8484b05c50..6822241168d6 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -264,18 +264,24 @@ static int ffa_rxtx_unmap(u16 vm_id)
>         return 0;
>  }
>
> +#define PARTITION_INFO_GET_RETURN_COUNT_ONLY   BIT(0)
> +
>  /* buffer must be sizeof(struct ffa_partition_info) * num_partitions */
>  static int
>  __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
>                          struct ffa_partition_info *buffer, int num_partiti=
ons)
>  {
> -       int count;
> +       int idx, count, flags =3D 0, size;
>         ffa_value_t partition_info;
>
> +       if (!buffer || !num_partitions) /* Just get the count for now */
> +               flags =3D PARTITION_INFO_GET_RETURN_COUNT_ONLY;
> +
>         mutex_lock(&drv_info->rx_lock);
>         invoke_ffa_fn((ffa_value_t){
>                       .a0 =3D FFA_PARTITION_INFO_GET,
>                       .a1 =3D uuid0, .a2 =3D uuid1, .a3 =3D uuid2, .a4 =3D =
uuid3,
> +                     .a5 =3D flags,
>                       }, &partition_info);
>
>         if (partition_info.a0 =3D=3D FFA_ERROR) {
> @@ -285,8 +291,15 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uui=
d2, u32 uuid3,
>
>         count =3D partition_info.a2;
>
> +       if (drv_info->version > FFA_VERSION_1_0)
> +               size =3D partition_info.a3;

What happens if this value is larger than sizeof(struct ffa_partition_info)?

> +       else
> +               size =3D 8; /* FFA_VERSION_1_0 lacks size in the response */
> +
>         if (buffer && count <=3D num_partitions)
> -               memcpy(buffer, drv_info->rx_buffer, sizeof(*buffer) * count=
);
> +               for (idx =3D 0; idx < count; idx++)
> +                       memcpy(buffer + idx, drv_info->rx_buffer + idx * si=
ze,
> +                              size);
>
>         ffa_rx_release();
>
> @@ -678,6 +691,14 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev,=
 const uuid_t *uuid)
>         int count, idx;
>         struct ffa_partition_info *pbuf, *tpbuf;
>
> +       /*
> +        * FF-A v1.1 provides UUID for each partition as part of the discov=
ery
> +        * API, the discovered UUID must be populated in the device's UUID =
and
> +        * there is no need to copy the same from the driver table.
> +        */
> +       if (drv_info->version > FFA_VERSION_1_0)
> +               return;
> +
>         count =3D ffa_partition_probe(uuid, &pbuf);
>         if (count <=3D 0)
>                 return;
> @@ -691,6 +712,7 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, =
const uuid_t *uuid)
>  static void ffa_setup_partitions(void)
>  {
>         int count, idx;
> +       uuid_t uuid;
>         struct ffa_device *ffa_dev;
>         struct ffa_partition_info *pbuf, *tpbuf;
>
> @@ -701,14 +723,15 @@ static void ffa_setup_partitions(void)
>         }
>
>         for (idx =3D 0, tpbuf =3D pbuf; idx < count; idx++, tpbuf++) {
> -               /* Note that the &uuid_null parameter will require
> +               import_uuid(&uuid, (u8 *)tpbuf->uuid);
> +
> +               /* Note that the UUID will be uuid_null and that will requi=
re

Note that if the UUID is uuid_null, that will require ...

Cheers,
Jen s

>                  * ffa_device_match() to find the UUID of this partition id
> -                * with help of ffa_device_match_uuid(). Once the FF-A spec
> -                * is updated to provide correct UUID here for each partiti=
on
> -                * as part of the discovery API, we need to pass the
> -                * discovered UUID here instead.
> +                * with help of ffa_device_match_uuid(). FF-A v1.1 and above
> +                * provides UUID here for each partition as part of the
> +                * discovery API and the same is passed.
>                  */
> -               ffa_dev =3D ffa_device_register(&uuid_null, tpbuf->id, &ffa=
_ops);
> +               ffa_dev =3D ffa_device_register(&uuid, tpbuf->id, &ffa_ops);
>                 if (!ffa_dev) {
>                         pr_err("%s: failed to register partition ID 0x%x\n",
>                                __func__, tpbuf->id);
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index eafab07c9f58..b40afa7933dc 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -107,6 +107,7 @@ struct ffa_partition_info {
>  /* partition can send and receive indirect messages. */
>  #define FFA_PARTITION_INDIRECT_MSG     BIT(2)
>         u32 properties;
> +       u32 uuid[4];
>  };
>
>  /* For use with FFA_MSG_SEND_DIRECT_{REQ,RESP} which pass data via registe=
rs */
> --
> 2.37.2
>

--===============3741469840414823543==--

