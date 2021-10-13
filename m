From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 3/6] tee: fix put order in teedev_close_context()
Date: Wed, 13 Oct 2021 12:39:02 +0530
Message-ID: 
 <CAFA6WYPZ-JbAhfvdWfbcgqBRnA9F-=o5k=ZzR_KYL+rAkVm3PA@mail.gmail.com>
In-Reply-To: <20211006071546.2540920-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2086760221170075183=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2086760221170075183==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Oct 2021 at 12:45, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> Prior to this patch was teedev_close_context() calling tee_device_put()
> before teedev_ctx_put() leading to teedev_ctx_release() accessing
> ctx->teedev just after the reference counter was decreased on the
> teedev. Fix this by calling teedev_ctx_put() before tee_device_put().
>
> Fixes: 217e0250cccb ("tee: use reference counting for tee_context")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 2b37bc408fc3..85102d12d716 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -98,8 +98,10 @@ void teedev_ctx_put(struct tee_context *ctx)
>
>  static void teedev_close_context(struct tee_context *ctx)
>  {
> -       tee_device_put(ctx->teedev);
> +       struct tee_device *teedev =3D ctx->teedev;
> +
>         teedev_ctx_put(ctx);
> +       tee_device_put(teedev);
>  }
>
>  static int tee_open(struct inode *inode, struct file *filp)
> --
> 2.31.1
>

--===============2086760221170075183==--

