From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v8 10/14] dma-contiguous: export dma_contiguous_default_area
Date: Mon, 05 May 2025 12:00:12 +0200
Message-ID: 
 <CAHUa44GC-HRUNGkta-EfMD00VzPBvqcVqU4Zj7kvW8CPnahdMg@mail.gmail.com>
In-Reply-To: <43e85d6a-ef99-4d61-910e-1d62814fd9ed@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6070308872527857521=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6070308872527857521==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 2, 2025 at 3:11=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 02/05/2025 10:59 am, Jens Wiklander wrote:
> > Export the global variable dma_contiguous_default_area so
> > dev_get_cma_area() can be called a module.
>
> What dma_map_ops implementation is in a module? Without any other
> context, I can't help thinking this smells of something sketchy.

I see that you found the rest of the patch set
https://lore.kernel.org/lkml/20250502100049.1746335-1-jens.wiklander(a)linaro=
.org/

Thanks,
Jens


>
> Thanks,
> Robin.
>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: iommu(a)lists.linux.dev
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >   kernel/dma/contiguous.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 8df0dfaaca18..eb361794a9c5 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -53,6 +53,7 @@
> >   #endif
> >
> >   struct cma *dma_contiguous_default_area;
> > +EXPORT_SYMBOL(dma_contiguous_default_area);
> >
> >   /*
> >    * Default global CMA area size can be defined in kernel's .config.

--===============6070308872527857521==--

