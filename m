From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to
 print GUIDs
Date: Thu, 12 Sep 2024 07:50:08 +0200
Message-ID: 
 <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
In-Reply-To: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8277317562211822175=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8277317562211822175==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace the custom approach with the %pUl printk() format specifier.
> No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tee/amdtee/core.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

Thanks, the patch looks like a nice simplificatrion.

Rijo, Devaraj, does this work for you?

Cheers,
Jens

>
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index e487231d25dc..d3201eff1b74 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -14,6 +14,7 @@
>  #include <linux/mm.h>
>  #include <linux/uaccess.h>
>  #include <linux/firmware.h>
> +#include <linux/uuid.h>
>  #include "amdtee_private.h"
>  #include <linux/psp-tee.h>
>
> @@ -172,21 +173,11 @@ static int copy_ta_binary(struct tee_context *ctx, vo=
id *ptr, void **ta,
>  {
>         const struct firmware *fw;
>         char fw_name[TA_PATH_MAX];
> -       struct {
> -               u32 lo;
> -               u16 mid;
> -               u16 hi_ver;
> -               u8 seq_n[8];
> -       } *uuid =3D ptr;
>         int n, rc =3D 0;
> +       guid_t uuid;
>
> -       n =3D snprintf(fw_name, TA_PATH_MAX,
> -                    "%s/%08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.bi=
n",
> -                    TA_LOAD_PATH, uuid->lo, uuid->mid, uuid->hi_ver,
> -                    uuid->seq_n[0], uuid->seq_n[1],
> -                    uuid->seq_n[2], uuid->seq_n[3],
> -                    uuid->seq_n[4], uuid->seq_n[5],
> -                    uuid->seq_n[6], uuid->seq_n[7]);
> +       import_guid(&uuid, ptr);
> +       n =3D snprintf(fw_name, TA_PATH_MAX, "%s/%pUl.bin", TA_LOAD_PATH, &=
uuid);
>         if (n < 0 || n >=3D TA_PATH_MAX) {
>                 pr_err("failed to get firmware name\n");
>                 return -EINVAL;
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

--===============8277317562211822175==--

