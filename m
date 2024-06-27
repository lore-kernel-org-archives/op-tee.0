From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: ffa: Fix missing-field-initializers warning
Date: Thu, 27 Jun 2024 08:19:56 +0200
Message-ID: 
 <CAHUa44G0FRwMX5BYtiBvY4XFME=8uYbNoLRnAQCO34z0LgkJSQ@mail.gmail.com>
In-Reply-To: <20240627051125.24084-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0293037862345316476=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0293037862345316476==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 27, 2024 at 7:11=E2=80=AFAM Mark-PK Tsai <mark-pk.tsai@mediatek=
.com> wrote:
>
> The 'missing-field-initializers' warning was reported
> when building with W=3D2.
> This patch ensures that the remaining fields of
> 'ffa_send_direct_data' are zero-initialized.
>
> Signed-off-by: ming-jen.chang <ming-jen.chang@mediatek.com>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 3235e1c719e8..1aa995752682 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -660,7 +660,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_devi=
ce *ffa_dev,
>                                         const struct ffa_ops *ops)
>  {
>         const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;
> -       struct ffa_send_direct_data data =3D { OPTEE_FFA_GET_API_VERSION };
> +       struct ffa_send_direct_data data =3D { OPTEE_FFA_GET_API_VERSION, 0=
, 0, 0, 0 };

Please use designated initializers to avoid listing all the zeroes, so
this would become:
        struct ffa_send_direct_data data =3D {
                .data0 =3D OPTEE_FFA_GET_API_VERSION,
        };

The same for the other changes further down in this patch. There is an
example in for instance enable_async_notif().

>         int rc;
>
>         msg_ops->mode_32bit_set(ffa_dev);
> @@ -677,7 +677,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_devi=
ce *ffa_dev,
>                 return false;
>         }
>
> -       data =3D (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION };
> +       data =3D (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION, 0=
, 0, 0, 0 };
>         rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
>         if (rc) {
>                 pr_err("Unexpected error %d\n", rc);
> @@ -698,7 +698,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *=
ffa_dev,
>                                     unsigned int *rpc_param_count,
>                                     unsigned int *max_notif_value)
>  {
> -       struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABILIT=
IES };
> +       struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABILIT=
IES, 0, 0, 0, 0 };
>         int rc;
>
>         rc =3D ops->msg_ops->sync_send_receive(ffa_dev, &data);
> --
> 2.18.0
>

Thanks,
Jens

--===============0293037862345316476==--

