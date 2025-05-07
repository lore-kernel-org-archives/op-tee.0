From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 11/14] tee: add tee_shm_alloc_cma_phys_mem()
Date: Wed, 07 May 2025 18:32:08 +0200
Message-ID: 
 <CAHUa44HEPF3w=b2O-4DcRUBgF4rJUUze8zy48_g_FCQ5Y34U6A@mail.gmail.com>
In-Reply-To: <4b2f7c31-c61b-45d8-b32e-16bb91c4289b@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9031762633905642527=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9031762633905642527==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 2, 2025 at 5:11=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 02/05/2025 10:59 am, Jens Wiklander wrote:
> > Add tee_shm_alloc_cma_phys_mem() to allocate a physical memory using
> > from the default CMA pool. The memory is represented by a tee_shm object
> > using the new flag TEE_SHM_CMA_BUF to identify it as physical memory
> > from CMA.
>
> If and when it's possible to dynamically delegate any old kernel memory
> to the TEE, it's far from clear why that should involve poking around in
> CMA internals...
>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >   drivers/tee/tee_shm.c    | 55 ++++++++++++++++++++++++++++++++++++++--
> >   include/linux/tee_core.h |  4 +++
> >   2 files changed, 57 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index e1ed52ee0a16..faaa0a87bb18 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -3,8 +3,11 @@
> >    * Copyright (c) 2015-2017, 2019-2021 Linaro Limited
> >    */
> >   #include <linux/anon_inodes.h>
> > +#include <linux/cma.h>
> >   #include <linux/device.h>
> >   #include <linux/dma-buf.h>
> > +#include <linux/dma-map-ops.h>
> > +#include <linux/highmem.h>
> >   #include <linux/idr.h>
> >   #include <linux/io.h>
> >   #include <linux/mm.h>
> > @@ -13,7 +16,6 @@
> >   #include <linux/tee_core.h>
> >   #include <linux/uaccess.h>
> >   #include <linux/uio.h>
> > -#include <linux/highmem.h>
> >   #include "tee_private.h"
> >
> >   static void shm_put_kernel_pages(struct page **pages, size_t page_count)
> > @@ -49,7 +51,14 @@ static void tee_shm_release(struct tee_device *teedev,=
 struct tee_shm *shm)
> >       struct tee_shm *parent_shm =3D NULL;
> >       void *p =3D shm;
> >
> > -     if (shm->flags & TEE_SHM_DMA_BUF) {
> > +     if (shm->flags & TEE_SHM_CMA_BUF) {
> > +#if IS_ENABLED(CONFIG_CMA)
> > +             struct page *page =3D phys_to_page(shm->paddr);
> > +             struct cma *cma =3D dev_get_cma_area(&shm->ctx->teedev->dev=
);
>
> If you want dma_contiguous_default_area as the commit message implies,
> use dma_contiguous_default_area. Appearing to support per-device CMA
> pools but relying on the device not having one is pretty yucky.
>
> But again, why? If you want page-backed DMA-able memory, with all the
> other assumptions being made here, you may as well just rely on
> dma_alloc_pages(DMA_ATTR_SKIP_CPU_SYNC) doing what you want, while also
> being potentially more flexible for !CMA and non-invasive. Or at the
> very least, could the TEE delegation not be composed on top of the
> existing CMA heap allocator?

Thanks for suggesting dma_alloc_pages(). I'll use that in the next
version of the patch set.

Cheers,
Jens

>
> Thanks,
> Robin.
>
> > +
> > +             cma_release(cma, page, shm->size / PAGE_SIZE);
> > +#endif
> > +     } else if (shm->flags & TEE_SHM_DMA_BUF) {
> >               struct tee_shm_dmabuf_ref *ref;
> >
> >               ref =3D container_of(shm, struct tee_shm_dmabuf_ref, shm);
> > @@ -306,6 +315,48 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_co=
ntext *ctx, size_t size)
> >   }
> >   EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
> >
> > +struct tee_shm *tee_shm_alloc_cma_phys_mem(struct tee_context *ctx,
> > +                                        size_t page_count, size_t align)
> > +{
> > +#if IS_ENABLED(CONFIG_CMA)
> > +     struct tee_device *teedev =3D ctx->teedev;
> > +     struct cma *cma =3D dev_get_cma_area(&teedev->dev);
> > +     struct tee_shm *shm;
> > +     struct page *page;
> > +
> > +     if (!tee_device_get(teedev))
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     page =3D cma_alloc(cma, page_count, align, true/*no_warn*/);
> > +     if (!page)
> > +             goto err_put_teedev;
> > +
> > +     shm =3D kzalloc(sizeof(*shm), GFP_KERNEL);
> > +     if (!shm)
> > +             goto err_cma_crelease;
> > +
> > +     refcount_set(&shm->refcount, 1);
> > +     shm->ctx =3D ctx;
> > +     shm->paddr =3D page_to_phys(page);
> > +     shm->size =3D page_count * PAGE_SIZE;
> > +     shm->flags =3D TEE_SHM_CMA_BUF;
> > +
> > +     teedev_ctx_get(ctx);
> > +
> > +     return shm;
> > +
> > +err_cma_crelease:
> > +     cma_release(cma, page, page_count);
> > +err_put_teedev:
> > +     tee_device_put(teedev);
> > +
> > +     return ERR_PTR(-ENOMEM);
> > +#else
> > +     return ERR_PTR(-EINVAL);
> > +#endif
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_alloc_cma_phys_mem);
> > +
> >   int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t a=
lign,
> >                            int (*shm_register)(struct tee_context *ctx,
> >                                                struct tee_shm *shm,
> > diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> > index 02c07f661349..3a4e1b00fcc7 100644
> > --- a/include/linux/tee_core.h
> > +++ b/include/linux/tee_core.h
> > @@ -29,6 +29,7 @@
> >   #define TEE_SHM_POOL                BIT(2)  /* Memory allocated from po=
ol */
> >   #define TEE_SHM_PRIV                BIT(3)  /* Memory private to TEE dr=
iver */
> >   #define TEE_SHM_DMA_BUF             BIT(4)  /* Memory with dma-buf hand=
le */
> > +#define TEE_SHM_CMA_BUF              BIT(5)  /* CMA allocated memory */
> >
> >   #define TEE_DEVICE_FLAG_REGISTERED  0x1
> >   #define TEE_MAX_DEV_NAME_LEN                32
> > @@ -310,6 +311,9 @@ void *tee_get_drvdata(struct tee_device *teedev);
> >    */
> >   struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t =
size);
> >
> > +struct tee_shm *tee_shm_alloc_cma_phys_mem(struct tee_context *ctx,
> > +                                        size_t page_count, size_t align);
> > +
> >   int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t a=
lign,
> >                            int (*shm_register)(struct tee_context *ctx,
> >                                                struct tee_shm *shm,

--===============9031762633905642527==--

