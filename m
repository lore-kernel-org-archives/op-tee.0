From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: optee: fix possible memory leak in optee_register_device()
Date: Thu, 10 Nov 2022 15:52:53 +0530
Message-ID: 
 <CAFA6WYNntm-C9SfDQNQxriVr_CKAn4HGNFk5mMLWzvfkbWFJ1g@mail.gmail.com>
In-Reply-To: <20221109140124.3288803-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4030399957630340975=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4030399957630340975==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Nov 2022 at 19:32, Yang Yingliang <yangyingliang@huawei.com> wrot=
e:
>
> If device_register() returns error in optee_register_device(),
> the name allocated by dev_set_name() need be freed. As comment
> of device_register() says, it should use put_device() to give
> up the reference in the error path. So fix this by calling
> put_device(), then the name can be freed in kobject_cleanup(),
> and optee_device is freed in optee_release_device().
>
> Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/tee/optee/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index f3947be13e2e..64f0e047c23d 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -80,7 +80,7 @@ static int optee_register_device(const uuid_t *device_uui=
d)
>         rc =3D device_register(&optee_device->dev);
>         if (rc) {
>                 pr_err("device registration failed, err: %d\n", rc);
> -               kfree(optee_device);
> +               put_device(&optee_device->dev);
>         }
>
>         return rc;
> --
> 2.25.1
>

--===============4030399957630340975==--

