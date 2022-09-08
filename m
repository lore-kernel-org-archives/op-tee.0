From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 08/10] firmware: arm_ffa: Add v1.1 get_partition_info support
Date: Thu, 08 Sep 2022 12:05:46 +0200
Message-ID: 
 <CAHUa44G_ahJe0HpPWW_WVF_=9jWYqVGJ=ozo5WA6KwMchs1zow@mail.gmail.com>
In-Reply-To: <20220907145240.1683088-9-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8532134506691825374=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8532134506691825374==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 7, 2022 at 4:52 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
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
>  drivers/firmware/arm_ffa/driver.c | 43 +++++++++++++++++++++++++------
>  include/linux/arm_ffa.h           |  1 +
>  2 files changed, 36 insertions(+), 8 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/d=
river.c
> index 2532e0f16cc9..42bc22220c69 100644
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
> +       int idx, count, flags =3D 0, sz, buf_sz;
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
> @@ -285,8 +291,19 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uui=
d2, u32 uuid3,
>
>         count =3D partition_info.a2;
>
> +       if (drv_info->version > FFA_VERSION_1_0) {
> +               buf_sz =3D sz =3D partition_info.a3;
> +               if (sz > sizeof(*buffer))
> +                       buf_sz =3D sizeof(*buffer);
> +       } else {
> +               /* FFA_VERSION_1_0 lacks size in the response */
> +               buf_sz =3D sz =3D 8;
> +       }
> +
>         if (buffer && count <=3D num_partitions)
> -               memcpy(buffer, drv_info->rx_buffer, sizeof(*buffer) * count=
);
> +               for (idx =3D 0; idx < count; idx++)
> +                       memcpy(buffer + idx, drv_info->rx_buffer + idx * sz,
> +                              buf_sz);
>
>         ffa_rx_release();
>
> @@ -681,6 +698,14 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev,=
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
> @@ -694,6 +719,7 @@ void ffa_device_match_uuid(struct ffa_device *ffa_dev, =
const uuid_t *uuid)
>  static void ffa_setup_partitions(void)
>  {
>         int count, idx;
> +       uuid_t uuid;
>         struct ffa_device *ffa_dev;
>         struct ffa_partition_info *pbuf, *tpbuf;
>
> @@ -704,14 +730,15 @@ static void ffa_setup_partitions(void)
>         }
>
>         for (idx =3D 0, tpbuf =3D pbuf; idx < count; idx++, tpbuf++) {
> -               /* Note that the &uuid_null parameter will require
> +               import_uuid(&uuid, (u8 *)tpbuf->uuid);
> +
> +               /* Note that if the UUID will be uuid_null, that will requi=
re
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
> index 4c4b06783035..09567ffd1f49 100644
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
> 2.37.3
>

--===============8532134506691825374==--

