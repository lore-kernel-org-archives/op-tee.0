From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v6 4/6] tee: export teedev_open() and teedev_close_context()
Date: Wed, 13 Oct 2021 12:39:51 +0530
Message-ID: 
 <CAFA6WYOZ4Ux4XvMa_tZgR+mZbuNb0ypABvyUeMKc1ngAYR8zVA@mail.gmail.com>
In-Reply-To: <20211006071546.2540920-5-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7608598713342478834=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7608598713342478834==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Oct 2021 at 12:46, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> Exports the two functions teedev_open() and teedev_close_context() in
> order to make it easier to create a driver internal struct tee_context.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c  |  6 ++++--
>  include/linux/tee_drv.h | 14 ++++++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 85102d12d716..3fc426dad2df 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -43,7 +43,7 @@ static DEFINE_SPINLOCK(driver_lock);
>  static struct class *tee_class;
>  static dev_t tee_devt;
>
> -static struct tee_context *teedev_open(struct tee_device *teedev)
> +struct tee_context *teedev_open(struct tee_device *teedev)
>  {
>         int rc;
>         struct tee_context *ctx;
> @@ -70,6 +70,7 @@ static struct tee_context *teedev_open(struct tee_device =
*teedev)
>         return ERR_PTR(rc);
>
>  }
> +EXPORT_SYMBOL_GPL(teedev_open);
>
>  void teedev_ctx_get(struct tee_context *ctx)
>  {
> @@ -96,13 +97,14 @@ void teedev_ctx_put(struct tee_context *ctx)
>         kref_put(&ctx->refcount, teedev_ctx_release);
>  }
>
> -static void teedev_close_context(struct tee_context *ctx)
> +void teedev_close_context(struct tee_context *ctx)
>  {
>         struct tee_device *teedev =3D ctx->teedev;
>
>         teedev_ctx_put(ctx);
>         tee_device_put(teedev);
>  }
> +EXPORT_SYMBOL_GPL(teedev_close_context);
>
>  static int tee_open(struct inode *inode, struct file *filp)
>  {
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 3ebfea0781f1..26f42c4cd7a1 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -582,4 +582,18 @@ struct tee_client_driver {
>  #define to_tee_client_driver(d) \
>                 container_of(d, struct tee_client_driver, driver)
>
> +/**
> + * teedev_open() - Open a struct tee_device
> + * @teedev:    Device to open
> + *
> + * @return a pointer to struct tee_context on success or an ERR_PTR on fai=
lure.
> + */
> +struct tee_context *teedev_open(struct tee_device *teedev);
> +
> +/**
> + * teedev_close_context() - closes a struct tee_context
> + * @ctx:       The struct tee_context to close
> + */
> +void teedev_close_context(struct tee_context *ctx);
> +
>  #endif /*__TEE_DRV_H*/
> --
> 2.31.1
>

--===============7608598713342478834==--

