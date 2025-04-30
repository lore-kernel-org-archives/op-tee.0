From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: Prevent size calculation wraparound on 32-bit kernels
Date: Wed, 30 Apr 2025 13:52:39 +0200
Message-ID: 
 <CAHUa44E_JZdYnGrReP0zWCP1wdu2BdJ9DSZZ3a2OiobRj61ThQ@mail.gmail.com>
In-Reply-To: <20250428-tee-sizecheck-v1-1-5c3c25a2fa79@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6519803676638639287=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6519803676638639287==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:06=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> The current code around TEE_IOCTL_PARAM_SIZE() is a bit wrong on
> 32-bit kernels: Multiplying a user-provided 32-bit value with the
> size of a structure can wrap around on such platforms.
>
> Fix it by using saturating arithmetic for the size calculation.
>
> This has no security consequences because, in all users of
> TEE_IOCTL_PARAM_SIZE(), the subsequent kcalloc() implicitly checks
> for wrapping.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Note that I don't have a test device with a TEE; I only compile-tested
> the change on an x86-64 build.
> ---
>  drivers/tee/tee_core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Looks good, I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index d113679b1e2d..acc7998758ad 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/fs.h>
>  #include <linux/idr.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/slab.h>
>  #include <linux/tee_core.h>
>  #include <linux/uaccess.h>
> @@ -19,7 +20,7 @@
>
>  #define TEE_NUM_DEVICES        32
>
> -#define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
> +#define TEE_IOCTL_PARAM_SIZE(x) (size_mul(sizeof(struct tee_param), (x)))
>
>  #define TEE_UUID_NS_NAME_SIZE  128
>
> @@ -487,7 +488,7 @@ static int tee_ioctl_open_session(struct tee_context *c=
tx,
>         if (copy_from_user(&arg, uarg, sizeof(arg)))
>                 return -EFAULT;
>
> -       if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) !=3D buf.buf=
_len)
> +       if (size_add(sizeof(arg), TEE_IOCTL_PARAM_SIZE(arg.num_params)) !=
=3D buf.buf_len)
>                 return -EINVAL;
>
>         if (arg.num_params) {
> @@ -565,7 +566,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
>         if (copy_from_user(&arg, uarg, sizeof(arg)))
>                 return -EFAULT;
>
> -       if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) !=3D buf.buf=
_len)
> +       if (size_add(sizeof(arg), TEE_IOCTL_PARAM_SIZE(arg.num_params)) !=
=3D buf.buf_len)
>                 return -EINVAL;
>
>         if (arg.num_params) {
> @@ -699,7 +700,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
>         if (get_user(num_params, &uarg->num_params))
>                 return -EFAULT;
>
> -       if (sizeof(*uarg) + TEE_IOCTL_PARAM_SIZE(num_params) !=3D buf.buf_l=
en)
> +       if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) !=3D =
buf.buf_len)
>                 return -EINVAL;
>
>         params =3D kcalloc(num_params, sizeof(struct tee_param), GFP_KERNEL=
);
> @@ -798,7 +799,7 @@ static int tee_ioctl_supp_send(struct tee_context *ctx,
>             get_user(num_params, &uarg->num_params))
>                 return -EFAULT;
>
> -       if (sizeof(*uarg) + TEE_IOCTL_PARAM_SIZE(num_params) > buf.buf_len)
> +       if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) > buf=
.buf_len)
>                 return -EINVAL;
>
>         params =3D kcalloc(num_params, sizeof(struct tee_param), GFP_KERNEL=
);
>
> ---
> base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
> change-id: 20250428-tee-sizecheck-299d5eff8fc7
>
> --
> Jann Horn <jannh@google.com>
>

--===============6519803676638639287==--

