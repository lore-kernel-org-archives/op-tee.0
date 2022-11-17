From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: optee: fix possible memory leak in optee_register_device()
Date: Thu, 17 Nov 2022 15:42:30 +0530
Message-ID: 
 <CAFA6WYNYxiEOjcV7knNSwtHYtmGpuPMt1kAb8KjLBk6Ggj2+sA@mail.gmail.com>
In-Reply-To: <20221117032220.3442738-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4813619332268631438=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4813619332268631438==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 17 Nov 2022 at 08:55, ruanjinjie <ruanjinjie@huawei.com> wrote:
>
> If device_register() returns error in optee_register_device(),
> name of kobject which is allocated in dev_set_name() called in device_add()
> is leaked.
>
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
>
> Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  drivers/tee/optee/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

There's already a prior patch posted to fix this here [1].

[1] https://lists.trustedfirmware.org/archives/list/op-tee(a)lists.trustedfir=
mware.org/thread/BMADRGTZ63GP5ORMMISW7RJPMZKINXE7/

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

--===============4813619332268631438==--

