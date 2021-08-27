From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 4/6] tee: add tee_dev_open_helper() primitive
Date: Fri, 27 Aug 2021 11:53:12 +0530
Message-ID: 
 <CAFA6WYM_zaVsWzP-sDuD6_xf3qgv-sQsbEAebZG6vtFrKfRpag@mail.gmail.com>
In-Reply-To: <20210826123032.1732926-5-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3108553865727220219=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3108553865727220219==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Aug 2021 at 18:00, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Adds tee_dev_open_helper() and tee_dev_ctx_put() to make it easier to
> create a driver internal struct tee_context without the usual
> tee_device_get() on the struct tee_device as that adds a circular
> reference counter dependency and would prevent the struct tee_device
> from ever being released again.

Can you elaborate regarding the circular dependency issue you are
referring to? IIUC, lifespan for struct tee_device would look like
below with normal teedev_open():

optee_probe() {
  ...
  tee_device_alloc()            <- teedev->num_users =3D 1
  tee_device_register()
  optee_notif_init()               <- tee_device_get()
  ...
}

optee_remove() {
  ...
  optee_notif_uninit()           <- tee_device_put()
  tee_device_unregister()    <- tee_device_put()
  ...
}

-Sumit

>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c  | 33 ++++++++++++++++++++++++---------
>  include/linux/tee_drv.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 85102d12d716..3beb682684a8 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -43,14 +43,11 @@ static DEFINE_SPINLOCK(driver_lock);
>  static struct class *tee_class;
>  static dev_t tee_devt;
>
> -static struct tee_context *teedev_open(struct tee_device *teedev)
> +struct tee_context *tee_dev_open_helper(struct tee_device *teedev)
>  {
>         int rc;
>         struct tee_context *ctx;
>
> -       if (!tee_device_get(teedev))
> -               return ERR_PTR(-EINVAL);
> -
>         ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
>         if (!ctx) {
>                 rc =3D -ENOMEM;
> @@ -66,10 +63,30 @@ static struct tee_context *teedev_open(struct tee_devic=
e *teedev)
>         return ctx;
>  err:
>         kfree(ctx);
> -       tee_device_put(teedev);
>         return ERR_PTR(rc);
>
>  }
> +EXPORT_SYMBOL_GPL(tee_dev_open_helper);
> +
> +void tee_dev_ctx_put(struct tee_context *ctx)
> +{
> +       teedev_ctx_put(ctx);
> +}
> +EXPORT_SYMBOL_GPL(tee_dev_ctx_put);
> +
> +static struct tee_context *teedev_open(struct tee_device *teedev)
> +{
> +       struct tee_context *ctx;
> +
> +       if (!tee_device_get(teedev))
> +               return ERR_PTR(-EINVAL);
> +
> +       ctx =3D tee_dev_open_helper(teedev);
> +       if (IS_ERR(ctx))
> +               tee_device_put(teedev);
> +
> +       return ctx;
> +}
>
>  void teedev_ctx_get(struct tee_context *ctx)
>  {
> @@ -90,10 +107,8 @@ static void teedev_ctx_release(struct kref *ref)
>
>  void teedev_ctx_put(struct tee_context *ctx)
>  {
> -       if (ctx->releasing)
> -               return;
> -
> -       kref_put(&ctx->refcount, teedev_ctx_release);
> +       if (ctx && !ctx->releasing)
> +               kref_put(&ctx->refcount, teedev_ctx_release);
>  }
>
>  static void teedev_close_context(struct tee_context *ctx)
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 3ebfea0781f1..00a31ff03049 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -458,6 +458,33 @@ static inline int tee_shm_get_id(struct tee_shm *shm)
>   */
>  struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
>
> +/**
> + * tee_dev_open_helper() - helper function to make a struct tee_context
> + * @teedev:    Device to open
> + *
> + * Creates the struct tee_context without increasing the reference counter
> + * on @teedev. This is needed for instance when a driver need an internal
> + * struct tee_context to operate on. By skipping the reference counter
> + * the circular dependency is broken.
> + *
> + * Note that this struct tee_context need special care when freeing in
> + * order to avoid the normal put on the struct tee_device.
> + * tee_dev_ctx_put() is the best choice for this.
> + *
> + * @returns a pointer 'struct tee_context' on success or an ERR_PTR on fai=
lure
> + */
> +struct tee_context *tee_dev_open_helper(struct tee_device *teedev);
> +
> +/**
> + * tee_dev_ctx_put() - helper function to release a struct tee_context
> + * @ctx:       The struct tee_context to release
> + *
> + * Note that this function doesn't do a tee_device_put() on the internal
> + * struct tee_device so this function should normal only be used when
> + * releasing a struct tee_context obtained with tee_dev_open_helper().
> + */
> +void tee_dev_ctx_put(struct tee_context *ctx);
> +
>  /**
>   * tee_client_open_context() - Open a TEE context
>   * @start:     if not NULL, continue search after this context
> --
> 2.31.1
>

--===============3108553865727220219==--

