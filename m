From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 1/2] tee: replace cdev_add + device_add with cdev_device_add
Date: Fri, 18 Sep 2020 10:41:00 +0200
Message-ID: <20200918084100.GA1219771@jade>
In-Reply-To: <20200901103335.685-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3390967891535396578=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3390967891535396578==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 11:33:34AM +0100, Sudeep Holla wrote:
> Commit 233ed09d7fda ("chardev: add helper function to register char devs
> with a struct device") added a helper function 'cdev_device_add'.
>=20
> Make use of cdev_device_add in tee_device_register to replace cdev_add
> and device_add. Since cdev_device_add takes care of setting the
> kobj->parent, drop explicit initialisation in tee_device_alloc.
>=20
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/tee/tee_core.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)

Thanks for the nice cleanups. I'm picking up this patch and
"[PATCH 2/2] tee: avoid explicit sysfs_create/delete_group by
initialising dev->groups".

Cheers,
Jens

>=20
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 64637e09a095..b4a8b362d78f 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -917,7 +917,6 @@ struct tee_device *tee_device_alloc(const struct tee_de=
sc *teedesc,
> =20
>  	cdev_init(&teedev->cdev, &tee_fops);
>  	teedev->cdev.owner =3D teedesc->owner;
> -	teedev->cdev.kobj.parent =3D &teedev->dev.kobj;
> =20
>  	dev_set_drvdata(&teedev->dev, driver_data);
>  	device_initialize(&teedev->dev);
> @@ -985,24 +984,15 @@ int tee_device_register(struct tee_device *teedev)
>  		return -EINVAL;
>  	}
> =20
> -	rc =3D cdev_add(&teedev->cdev, teedev->dev.devt, 1);
> +	rc =3D cdev_device_add(&teedev->cdev, &teedev->dev);
>  	if (rc) {
>  		dev_err(&teedev->dev,
> -			"unable to cdev_add() %s, major %d, minor %d, err=3D%d\n",
> +			"unable to cdev_device_add() %s, major %d, minor %d, err=3D%d\n",
>  			teedev->name, MAJOR(teedev->dev.devt),
>  			MINOR(teedev->dev.devt), rc);
>  		return rc;
>  	}
> =20
> -	rc =3D device_add(&teedev->dev);
> -	if (rc) {
> -		dev_err(&teedev->dev,
> -			"unable to device_add() %s, major %d, minor %d, err=3D%d\n",
> -			teedev->name, MAJOR(teedev->dev.devt),
> -			MINOR(teedev->dev.devt), rc);
> -		goto err_device_add;
> -	}
> -
>  	rc =3D sysfs_create_group(&teedev->dev.kobj, &tee_dev_group);
>  	if (rc) {
>  		dev_err(&teedev->dev,
> @@ -1014,9 +1004,7 @@ int tee_device_register(struct tee_device *teedev)
>  	return 0;
> =20
>  err_sysfs_create_group:
> -	device_del(&teedev->dev);
> -err_device_add:
> -	cdev_del(&teedev->cdev);
> +	cdev_device_del(&teedev->cdev, &teedev->dev);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(tee_device_register);
> @@ -1062,8 +1050,7 @@ void tee_device_unregister(struct tee_device *teedev)
> =20
>  	if (teedev->flags & TEE_DEVICE_FLAG_REGISTERED) {
>  		sysfs_remove_group(&teedev->dev.kobj, &tee_dev_group);
> -		cdev_del(&teedev->cdev);
> -		device_del(&teedev->dev);
> +		cdev_device_del(&teedev->cdev, &teedev->dev);
>  	}
> =20
>  	tee_device_put(teedev);
> --=20
> 2.17.1
>=20

--===============3390967891535396578==--

