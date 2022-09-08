From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 09/10] firmware: arm_ffa: Set up 32bit execution mode
 flag using partiion property
Date: Thu, 08 Sep 2022 12:08:00 +0200
Message-ID: 
 <CAHUa44ETVSsfpnUHWU=cuwZqpQbEUeUVetJMkxyCMrCFt5rM9g@mail.gmail.com>
In-Reply-To: <20220907145240.1683088-10-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6151601621947853876=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6151601621947853876==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 7, 2022 at 4:53 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> FF-A v1.1 adds a flag in the partition properties to indicate if the
> partition runs in the AArch32 or AArch64 execution state. Use the same
> to set-up the 32-bit execution flag mode in the ffa_dev automatically
> and ignore any requests to do the same from the ffa_driver.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 13 ++++++++++++-
>  include/linux/arm_ffa.h           |  2 ++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/d=
river.c
> index 42bc22220c69..34e12a2a98fe 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -648,11 +648,19 @@ static int ffa_partition_info_get(const char *uuid_st=
r,
>         return 0;
>  }
>
> -static void ffa_mode_32bit_set(struct ffa_device *dev)
> +static void _ffa_mode_32bit_set(struct ffa_device *dev)
>  {
>         dev->mode_32bit =3D true;
>  }
>
> +static void ffa_mode_32bit_set(struct ffa_device *dev)
> +{
> +       if (drv_info->version > FFA_VERSION_1_0)
> +               return;
> +
> +       _ffa_mode_32bit_set(dev);
> +}
> +
>  static int ffa_sync_send_receive(struct ffa_device *dev,
>                                  struct ffa_send_direct_data *data)
>  {
> @@ -744,6 +752,9 @@ static void ffa_setup_partitions(void)
>                                __func__, tpbuf->id);
>                         continue;
>                 }
> +
> +               if (!(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
> +                       _ffa_mode_32bit_set(ffa_dev);

For FF-A 1.0 it looks like we change the dev->mode_32bit default value
from false to true. Or am I missing something?

Cheers,
Jens

>         }
>         kfree(pbuf);
>  }
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 09567ffd1f49..5964b6104996 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -106,6 +106,8 @@ struct ffa_partition_info {
>  #define FFA_PARTITION_DIRECT_SEND      BIT(1)
>  /* partition can send and receive indirect messages. */
>  #define FFA_PARTITION_INDIRECT_MSG     BIT(2)
> +/* partition runs in the AArch64 execution state. */
> +#define FFA_PARTITION_AARCH64_EXEC     BIT(8)
>         u32 properties;
>         u32 uuid[4];
>  };
> --
> 2.37.3
>

--===============6151601621947853876==--

