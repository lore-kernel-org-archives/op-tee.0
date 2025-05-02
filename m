From: Robin Murphy <robin.murphy@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 01/14] tee: tee_device_alloc(): copy dma_mask from
 parent device
Date: Fri, 02 May 2025 14:36:50 +0100
Message-ID: <6236d3cb-fbf2-4a41-a84a-276aa8079b9a@arm.com>
In-Reply-To: <20250502100049.1746335-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1918067828247008183=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1918067828247008183==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 02/05/2025 10:59 am, Jens Wiklander wrote:
> If a parent device is supplied to tee_device_alloc(), copy the dma_mask
> field into the new device. This avoids future warnings when mapping a
> DMA-buf for the device.

That also sounds dodgy. If the parent device is the hardware device=20
physically performing the DMA, then that is the device which should be=20
passed to the DMA API. Trying to copy random bits of one device's=20
configuration to another device and hoping it will work is not robust -=20
not only is DMA-relevant information all over the place, including in=20
archdata and/or bus/IOMMU driver-private data, but it can also opens up=20
a whole can of subtle lifecycle issues...

> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@kernel.org>
> ---
>   drivers/tee/tee_core.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index d113679b1e2d..685afcaa3ea1 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -922,6 +922,8 @@ struct tee_device *tee_device_alloc(const struct tee_de=
sc *teedesc,
>   	teedev->dev.class =3D &tee_class;
>   	teedev->dev.release =3D tee_release_device;
>   	teedev->dev.parent =3D dev;
> +	if (dev)
> +		teedev->dev.dma_mask =3D dev->dma_mask;

...for instance, I don't see any obvious guarantee that "dev" can't go=20
away during the lifetime of "teedev" and leave this pointer dangling.

Thanks,
Robin.

>  =20
>   	teedev->dev.devt =3D MKDEV(MAJOR(tee_devt), teedev->id);
>  =20

--===============1918067828247008183==--

