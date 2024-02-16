From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: make tee_bus_type const
Date: Fri, 16 Feb 2024 15:16:58 +0100
Message-ID: 
 <CAHUa44H++H2GitFCqEEv6xmYrHyhFDrM-GFogO1VZjs3LGRN+A@mail.gmail.com>
In-Reply-To: <20240213-bus_cleanup-tee-v1-1-77945ae1a172@marliere.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8757487661706988825=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8757487661706988825==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:45=E2=80=AFPM Ricardo B. Marliere
<ricardo@marliere.net> wrote:
>
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the tee_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/tee/tee_core.c  | 2 +-
>  include/linux/tee_drv.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 792d6fae4354..e59c20d74b36 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1226,7 +1226,7 @@ static int tee_client_device_uevent(const struct devi=
ce *dev,
>         return add_uevent_var(env, "MODALIAS=3Dtee:%pUb", dev_id);
>  }
>
> -struct bus_type tee_bus_type =3D {
> +const struct bus_type tee_bus_type =3D {
>         .name           =3D "tee",
>         .match          =3D tee_client_device_match,
>         .uevent         =3D tee_client_device_uevent,
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 911ddf92dcee..71632e3c5f18 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -482,7 +482,7 @@ static inline bool tee_param_is_memref(struct tee_param=
 *param)
>         }
>  }
>
> -extern struct bus_type tee_bus_type;
> +extern const struct bus_type tee_bus_type;
>
>  /**
>   * struct tee_client_device - tee based device
>
> ---
> base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
> change-id: 20240213-bus_cleanup-tee-c25729bbcd7f
>
> Best regards,
> --
> Ricardo B. Marliere <ricardo@marliere.net>
>

--===============8757487661706988825==--

