From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: make tee_class constant
Date: Mon, 09 Oct 2023 11:04:33 +0530
Message-ID: 
 <CAFA6WYNbMsEE7OF0SpLN5gQx5-TNPXD7Zm+2tVu21xdpzKU=Xg@mail.gmail.com>
In-Reply-To: <2023100613-lustiness-affiliate-7dcb@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6221060164706285320=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6221060164706285320==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Oct 2023 at 19:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tee/tee_core.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>

Apart from nit below, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 0eb342de0b00..5ddfd5d9ac7f 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -40,7 +40,10 @@ static const uuid_t tee_client_uuid_ns =3D UUID_INIT(0x5=
8ac9ca0, 0x2086, 0x4683,
>  static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
>  static DEFINE_SPINLOCK(driver_lock);
>
> -static struct class *tee_class;
> +static const struct class tee_class =3D {
> +       .name =3D "tee",
> +};
> +
>  static dev_t tee_devt;
>
>  struct tee_context *teedev_open(struct tee_device *teedev)
> @@ -919,7 +922,7 @@ struct tee_device *tee_device_alloc(const struct tee_de=
sc *teedesc,
>                  teedesc->flags & TEE_DESC_PRIVILEGED ? "priv" : "",
>                  teedev->id - offs);
>
> -       teedev->dev.class =3D tee_class;
> +       teedev->dev.class =3D &tee_class;
>         teedev->dev.release =3D tee_release_device;
>         teedev->dev.parent =3D dev;
>
> @@ -1112,7 +1115,7 @@ tee_client_open_context(struct tee_context *start,
>                 dev =3D &start->teedev->dev;
>
>         do {
> -               dev =3D class_find_device(tee_class, dev, &match_data, matc=
h_dev);
> +               dev =3D class_find_device(&tee_class, dev, &match_data, mat=
ch_dev);
>                 if (!dev) {
>                         ctx =3D ERR_PTR(-ENOENT);
>                         break;
> @@ -1226,10 +1229,10 @@ static int __init tee_init(void)
>  {
>         int rc;
>
> -       tee_class =3D class_create("tee");
> -       if (IS_ERR(tee_class)) {
> +       rc =3D class_register(&tee_class);
> +       if (rc) {
>                 pr_err("couldn't create class\n");

nit: this error message should be updated as well.

-Sumit

> -               return PTR_ERR(tee_class);
> +               return rc;
>         }
>
>         rc =3D alloc_chrdev_region(&tee_devt, 0, TEE_NUM_DEVICES, "tee");
> @@ -1249,8 +1252,7 @@ static int __init tee_init(void)
>  out_unreg_chrdev:
>         unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
>  out_unreg_class:
> -       class_destroy(tee_class);
> -       tee_class =3D NULL;
> +       class_unregister(&tee_class);
>
>         return rc;
>  }
> @@ -1259,8 +1261,7 @@ static void __exit tee_exit(void)
>  {
>         bus_unregister(&tee_bus_type);
>         unregister_chrdev_region(tee_devt, TEE_NUM_DEVICES);
> -       class_destroy(tee_class);
> -       tee_class =3D NULL;
> +       class_unregister(&tee_class);
>  }
>
>  subsys_initcall(tee_init);
> --
> 2.42.0
>

--===============6221060164706285320==--

