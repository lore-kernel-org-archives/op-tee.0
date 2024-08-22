From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 3/4] tee: add tee_device_set_dev_groups()
Date: Thu, 22 Aug 2024 10:41:56 +0530
Message-ID: 
 <CAFA6WYM4qmfitWdVUtJoyyeV1S2mTAA4KGZ87tUhf6prMts+2w@mail.gmail.com>
In-Reply-To: <20240814153558.708365-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2806965549907417616=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2806965549907417616==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Aug 2024 at 21:06, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Add tee_device_set_dev_groups() to TEE drivers to supply driver specific
> attribute groups. The class specific attributes are from now on added
> via the tee_class, which currently only consist of implementation_id.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c   | 19 +++++++++++++------
>  include/linux/tee_core.h | 12 ++++++++++++
>  2 files changed, 25 insertions(+), 6 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index d52e879b204e..d113679b1e2d 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -40,10 +40,7 @@ static const uuid_t tee_client_uuid_ns =3D UUID_INIT(0x5=
8ac9ca0, 0x2086, 0x4683,
>  static DECLARE_BITMAP(dev_mask, TEE_NUM_DEVICES);
>  static DEFINE_SPINLOCK(driver_lock);
>
> -static const struct class tee_class =3D {
> -       .name =3D "tee",
> -};
> -
> +static const struct class tee_class;
>  static dev_t tee_devt;
>
>  struct tee_context *teedev_open(struct tee_device *teedev)
> @@ -965,6 +962,13 @@ struct tee_device *tee_device_alloc(const struct tee_d=
esc *teedesc,
>  }
>  EXPORT_SYMBOL_GPL(tee_device_alloc);
>
> +void tee_device_set_dev_groups(struct tee_device *teedev,
> +                              const struct attribute_group **dev_groups)
> +{
> +       teedev->dev.groups =3D dev_groups;
> +}
> +EXPORT_SYMBOL_GPL(tee_device_set_dev_groups);
> +
>  static ssize_t implementation_id_show(struct device *dev,
>                                       struct device_attribute *attr, char *=
buf)
>  {
> @@ -983,6 +987,11 @@ static struct attribute *tee_dev_attrs[] =3D {
>
>  ATTRIBUTE_GROUPS(tee_dev);
>
> +static const struct class tee_class =3D {
> +       .name =3D "tee",
> +       .dev_groups =3D tee_dev_groups,
> +};
> +
>  /**
>   * tee_device_register() - Registers a TEE device
>   * @teedev:    Device to register
> @@ -1001,8 +1010,6 @@ int tee_device_register(struct tee_device *teedev)
>                 return -EINVAL;
>         }
>
> -       teedev->dev.groups =3D tee_dev_groups;
> -
>         rc =3D cdev_device_add(&teedev->cdev, &teedev->dev);
>         if (rc) {
>                 dev_err(&teedev->dev,
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index efd16ed52315..a38494d6b5f4 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -154,6 +154,18 @@ int tee_device_register(struct tee_device *teedev);
>   */
>  void tee_device_unregister(struct tee_device *teedev);
>
> +/**
> + * tee_device_set_dev_groups() - Set device attribute groups
> + * @teedev:    Device to register
> + * @dev_groups: Attribute groups
> + *
> + * Assigns the provided @dev_groups to the @teedev to be registered later
> + * with tee_device_register(). Calling this function is optional, but if
> + * it's called it must be called before tee_device_register().
> + */
> +void tee_device_set_dev_groups(struct tee_device *teedev,
> +                              const struct attribute_group **dev_groups);
> +
>  /**
>   * tee_session_calc_client_uuid() - Calculates client UUID for session
>   * @uuid:              Resulting UUID
> --
> 2.34.1
>

--===============2806965549907417616==--

