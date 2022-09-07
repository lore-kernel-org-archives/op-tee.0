From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 09/10] firmware: arm_ffa: Set up 32bit execution mode
 flag using partiion property
Date: Wed, 07 Sep 2022 11:01:27 +0200
Message-ID: 
 <CAHUa44Gq+7_XT2+ccAMxC=ZFh4vV=YuUGLGx0MMYrZ1wne83bw@mail.gmail.com>
In-Reply-To: <20220902124032.788488-10-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3723375970947558709=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3723375970947558709==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 2, 2022 at 2:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
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
> index dd6ab2f81580..dbbe15592173 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -647,11 +647,19 @@ static int ffa_partition_info_get(const char *uuid_st=
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
> @@ -743,6 +751,9 @@ static void ffa_setup_partitions(void)
>                                __func__, tpbuf->id);
>                         continue;
>                 }
> +
> +               if (tpbuf->properties & FFA_PARTITION_AARCH64_EXEC)

Shouldn't this be !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC)?

Before this, we used 64-bit calling convention by default for FF-A
v1.0. I suppose we would like to keep that behaviour.

Cheers,
Jens

> +                       _ffa_mode_32bit_set(ffa_dev);
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

--===============3723375970947558709==--

