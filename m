From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: optee: Fix kernel panic caused by incorrect error handling
Date: Mon, 04 Mar 2024 11:15:11 +0530
Message-ID: 
 <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com>
In-Reply-To: <20240301143731.3494455-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4573313641961816680=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4573313641961816680==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+ Arnd

On Fri, 1 Mar 2024 at 20:07, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> The error path while failing to register devices on the TEE bus has a
> bug leading to kernel panic as follows:
>
> [   15.398930] Unable to handle kernel paging request at virtual address ff=
ff07ed00626d7c
> [   15.406913] Mem abort info:
> [   15.409722]   ESR =3D 0x0000000096000005
> [   15.413490]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   15.418814]   SET =3D 0, FnV =3D 0
> [   15.421878]   EA =3D 0, S1PTW =3D 0
> [   15.425031]   FSC =3D 0x05: level 1 translation fault
> [   15.429922] Data abort info:
> [   15.432813]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> [   15.438310]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [   15.443372]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [   15.448697] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000d9e3e0=
00
> [   15.455413] [ffff07ed00626d7c] pgd=3D1800000bffdf9003, p4d=3D1800000bffd=
f9003, pud=3D0000000000000000
> [   15.464146] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>
> Commit 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
> lead to the introduction of this bug. So fix it appropriately.
>
> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218542
> Fixes: 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
> Cc: stable(a)vger.kernel.org
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Jens, Arnd,

Is there any chance for this fix to make it into v6.8 release?

-Sumit

> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 9d2afac96acc..d296c70ddfdc 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -90,13 +90,14 @@ static int optee_register_device(const uuid_t *device_u=
uid, u32 func)
>         if (rc) {
>                 pr_err("device registration failed, err: %d\n", rc);
>                 put_device(&optee_device->dev);
> +               return rc;
>         }
>
>         if (func =3D=3D PTA_CMD_GET_DEVICES_SUPP)
>                 device_create_file(&optee_device->dev,
>                                    &dev_attr_need_supplicant);
>
> -       return rc;
> +       return 0;
>  }
>
>  static int __optee_enumerate_devices(u32 func)
> --
> 2.34.1
>

--===============4573313641961816680==--

