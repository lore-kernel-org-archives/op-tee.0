From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 01/10] tee: tee_device_alloc(): copy dma_mask from
 parent device
Date: Mon, 10 Mar 2025 14:26:26 +0530
Message-ID: <Z86pOi874jfJJSOv@sumit-X1>
In-Reply-To: <20250305130634.1850178-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9027783809928794923=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9027783809928794923==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 02:04:07PM +0100, Jens Wiklander wrote:
> If a parent device is supplied to tee_device_alloc(), copy the dma_mask
> field into the new device. This avoids future warnings when mapping a
> DMA-buf for the device.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@kernel.org>

-Sumit

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index d113679b1e2d..685afcaa3ea1 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -922,6 +922,8 @@ struct tee_device *tee_device_alloc(const struct tee_de=
sc *teedesc,
>  	teedev->dev.class =3D &tee_class;
>  	teedev->dev.release =3D tee_release_device;
>  	teedev->dev.parent =3D dev;
> +	if (dev)
> +		teedev->dev.dma_mask =3D dev->dma_mask;
> =20
>  	teedev->dev.devt =3D MKDEV(MAJOR(tee_devt), teedev->id);
> =20
> --=20
> 2.43.0
>=20

--===============9027783809928794923==--

