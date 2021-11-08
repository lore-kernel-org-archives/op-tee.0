From: Enrique Echeverria <enriqueoctavio@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 3/6] tee: fix put order in teedev_close_context()
Date: Mon, 08 Nov 2021 17:45:24 -0300
Message-ID: 
 <CADqfzQHcB5ypQMUV47RueBSdPHgY=Ccqq2VYxaxNJau0OR+RzQ@mail.gmail.com>
In-Reply-To: <20210723094422.2150313-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4977898432832824685=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4977898432832824685==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Unsuscribe

El vie., 23 de julio de 2021 6:46 a. m., Jens Wiklander <
jens.wiklander@linaro.org> escribió:

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
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 2b37bc408fc3..85102d12d716 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -98,8 +98,10 @@ void teedev_ctx_put(struct tee_context *ctx)
>
>  static void teedev_close_context(struct tee_context *ctx)
>  {
> -       tee_device_put(ctx->teedev);
> +       struct tee_device *teedev = ctx->teedev;
> +
>         teedev_ctx_put(ctx);
> +       tee_device_put(teedev);
>  }
>
>  static int tee_open(struct inode *inode, struct file *filp)
> --
> 2.31.1
>
>

--===============4977898432832824685==--

