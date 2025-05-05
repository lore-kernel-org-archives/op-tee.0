From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 01/14] tee: tee_device_alloc(): copy dma_mask from
 parent device
Date: Mon, 05 May 2025 14:10:11 +0200
Message-ID: 
 <CAHUa44EhdHZofZHRWQ8SJUn4OcAuMwzxxdfjhLQuXQXx4KEaUA@mail.gmail.com>
In-Reply-To: <6236d3cb-fbf2-4a41-a84a-276aa8079b9a@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3010756910458350486=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3010756910458350486==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 2, 2025 at 3:36=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 02/05/2025 10:59 am, Jens Wiklander wrote:
> > If a parent device is supplied to tee_device_alloc(), copy the dma_mask
> > field into the new device. This avoids future warnings when mapping a
> > DMA-buf for the device.
>
> That also sounds dodgy. If the parent device is the hardware device
> physically performing the DMA, then that is the device which should be
> passed to the DMA API. Trying to copy random bits of one device's
> configuration to another device and hoping it will work is not robust -
> not only is DMA-relevant information all over the place, including in
> archdata and/or bus/IOMMU driver-private data, but it can also opens up
> a whole can of subtle lifecycle issues...

We have a reference to the parent device until the teedev goes away.
The dma_maks needed by tee_shm_register_fd() in
https://lore.kernel.org/lkml/20250502100049.1746335-9-jens.wiklander(a)linaro=
.org/
to be able to extract the PA from a DMA-buf allocated from another DMA
heap. We can drop this patch and support for unrelated DMA heaps in
tee_shm_register_fd() without losing critical features from the patch
set if we can't handle dma_mask in this way.

>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Reviewed-by: Sumit Garg <sumit.garg@kernel.org>
> > ---
> >   drivers/tee/tee_core.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index d113679b1e2d..685afcaa3ea1 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -922,6 +922,8 @@ struct tee_device *tee_device_alloc(const struct tee_=
desc *teedesc,
> >       teedev->dev.class =3D &tee_class;
> >       teedev->dev.release =3D tee_release_device;
> >       teedev->dev.parent =3D dev;
> > +     if (dev)
> > +             teedev->dev.dma_mask =3D dev->dma_mask;
>
> ...for instance, I don't see any obvious guarantee that "dev" can't go
> away during the lifetime of "teedev" and leave this pointer dangling.

A successful call to tee_device_alloc() must be followed by a call to
tee_device_register() or tee_device_unregister(). The former calls
cdev_device_add(), which results in a call to device_add() and an
increased reference to teedev->dev.parent, "dev" in question.

Thanks,
Jens

>
> Thanks,
> Robin.
>
> >
> >       teedev->dev.devt =3D MKDEV(MAJOR(tee_devt), teedev->id);
> >

--===============3010756910458350486==--

