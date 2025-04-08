From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 05/10] tee: implement restricted DMA-heap
Date: Tue, 08 Apr 2025 15:28:45 +0200
Message-ID: 
 <CAHUa44EGWuVPjoxpG-S66he=6dkvkwzxNewaGKVKXUxrO41ztg@mail.gmail.com>
In-Reply-To: <Z_To9V-JOKZ7ChhE@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2844744839501243683=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2844744839501243683==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 11:14=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Tue, Apr 01, 2025 at 10:33:04AM +0200, Jens Wiklander wrote:
> > On Tue, Apr 1, 2025 at 9:58=E2=80=AFAM Sumit Garg <sumit.garg@kernel.or=
g> wrote:
> > >
> > > On Tue, Mar 25, 2025 at 11:55:46AM +0100, Jens Wiklander wrote:
> > > > Hi Sumit,
> > > >
> > >
> > > <snip>
> > >
> > > >
> > > > >
> > > > > > +
> > > > > > +#include "tee_private.h"
> > > > > > +
> > > > > > +struct tee_dma_heap {
> > > > > > +     struct dma_heap *heap;
> > > > > > +     enum tee_dma_heap_id id;
> > > > > > +     struct tee_rstmem_pool *pool;
> > > > > > +     struct tee_device *teedev;
> > > > > > +     /* Protects pool and teedev above */
> > > > > > +     struct mutex mu;
> > > > > > +};
> > > > > > +
> > > > > > +struct tee_heap_buffer {
> > > > > > +     struct tee_rstmem_pool *pool;
> > > > > > +     struct tee_device *teedev;
> > > > > > +     size_t size;
> > > > > > +     size_t offs;
> > > > > > +     struct sg_table table;
> > > > > > +};
> > > > > > +
> > > > > > +struct tee_heap_attachment {
> > > > > > +     struct sg_table table;
> > > > > > +     struct device *dev;
> > > > > > +};
> > > > > > +
> > > > > > +struct tee_rstmem_static_pool {
> > > > > > +     struct tee_rstmem_pool pool;
> > > > > > +     struct gen_pool *gen_pool;
> > > > > > +     phys_addr_t pa_base;
> > > > > > +};
> > > > > > +
> > > > > > +#if !IS_MODULE(CONFIG_TEE) && IS_ENABLED(CONFIG_DMABUF_HEAPS)
> > > > >
> > > > > Can this dependency rather be better managed via Kconfig?
> > > >
> > > > This was the easiest yet somewhat flexible solution I could find. If
> > > > you have something better, let's use that instead.
> > > >
> > >
> > > --- a/drivers/tee/optee/Kconfig
> > > +++ b/drivers/tee/optee/Kconfig
> > > @@ -5,6 +5,7 @@ config OPTEE
> > >         depends on HAVE_ARM_SMCCC
> > >         depends on MMU
> > >         depends on RPMB || !RPMB
> > > +       select DMABUF_HEAPS
> > >         help
> > >           This implements the OP-TEE Trusted Execution Environment (TEE)
> > >           driver.
> >
> > I wanted to avoid that since there are plenty of use cases where
> > DMABUF_HEAPS aren't needed.
>
> Yeah, but how the users will figure out the dependency to enable DMA
> heaps with TEE subsystem.

I hope, without too much difficulty. They are after all looking for a
way to allocate memory from a DMA heap.

> So it's better we provide a generic kernel
> Kconfig which enables all the default features.

I disagree, it should be possible to configure without DMABUF_HEAPS if desire=
d.

>
> > This seems to do the job:
> > +config TEE_DMABUF_HEAP
> > + bool
> > + depends on TEE =3D y && DMABUF_HEAPS
> >
> > We can only use DMABUF_HEAPS if the TEE subsystem is compiled into the ke=
rnel.
>
> Ah, I see. So we aren't exporting the DMA heaps APIs for TEE subsystem
> to use. We should do that such that there isn't a hard dependency to
> compile them into the kernel.

I was saving that for a later patch set as a later problem. We may
save some time by not doing it now.

Cheers,
Jens

>
> -Sumit
>
> >
> > Cheers,
> > Jens

--===============2844744839501243683==--

