From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 05/10] tee: implement restricted DMA-heap
Date: Thu, 10 Apr 2025 08:49:39 +0200
Message-ID: 
 <CAHUa44GFzG8dr1Kbapbjy77c-wJb4gQVVom24eLLueOK=gCq=A@mail.gmail.com>
In-Reply-To: <Z_ZtDQQY4eouqBh8@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0626743249371689866=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0626743249371689866==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 2:50=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Tue, Apr 08, 2025 at 03:28:45PM +0200, Jens Wiklander wrote:
> > On Tue, Apr 8, 2025 at 11:14=E2=80=AFAM Sumit Garg <sumit.garg@kernel.o=
rg> wrote:
> > >
> > > On Tue, Apr 01, 2025 at 10:33:04AM +0200, Jens Wiklander wrote:
> > > > On Tue, Apr 1, 2025 at 9:58=E2=80=AFAM Sumit Garg <sumit.garg@kerne=
l.org> wrote:
> > > > >
> > > > > On Tue, Mar 25, 2025 at 11:55:46AM +0100, Jens Wiklander wrote:
> > > > > > Hi Sumit,
> > > > > >
> > > > >
> > > > > <snip>
> > > > >
> > > > > >
> > > > > > >
> > > > > > > > +
> > > > > > > > +#include "tee_private.h"
> > > > > > > > +
> > > > > > > > +struct tee_dma_heap {
> > > > > > > > +     struct dma_heap *heap;
> > > > > > > > +     enum tee_dma_heap_id id;
> > > > > > > > +     struct tee_rstmem_pool *pool;
> > > > > > > > +     struct tee_device *teedev;
> > > > > > > > +     /* Protects pool and teedev above */
> > > > > > > > +     struct mutex mu;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +struct tee_heap_buffer {
> > > > > > > > +     struct tee_rstmem_pool *pool;
> > > > > > > > +     struct tee_device *teedev;
> > > > > > > > +     size_t size;
> > > > > > > > +     size_t offs;
> > > > > > > > +     struct sg_table table;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +struct tee_heap_attachment {
> > > > > > > > +     struct sg_table table;
> > > > > > > > +     struct device *dev;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +struct tee_rstmem_static_pool {
> > > > > > > > +     struct tee_rstmem_pool pool;
> > > > > > > > +     struct gen_pool *gen_pool;
> > > > > > > > +     phys_addr_t pa_base;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +#if !IS_MODULE(CONFIG_TEE) && IS_ENABLED(CONFIG_DMABUF_HEAPS)
> > > > > > >
> > > > > > > Can this dependency rather be better managed via Kconfig?
> > > > > >
> > > > > > This was the easiest yet somewhat flexible solution I could find.=
 If
> > > > > > you have something better, let's use that instead.
> > > > > >
> > > > >
> > > > > --- a/drivers/tee/optee/Kconfig
> > > > > +++ b/drivers/tee/optee/Kconfig
> > > > > @@ -5,6 +5,7 @@ config OPTEE
> > > > >         depends on HAVE_ARM_SMCCC
> > > > >         depends on MMU
> > > > >         depends on RPMB || !RPMB
> > > > > +       select DMABUF_HEAPS
> > > > >         help
> > > > >           This implements the OP-TEE Trusted Execution Environment =
(TEE)
> > > > >           driver.
> > > >
> > > > I wanted to avoid that since there are plenty of use cases where
> > > > DMABUF_HEAPS aren't needed.
> > >
> > > Yeah, but how the users will figure out the dependency to enable DMA
> > > heaps with TEE subsystem.
> >
> > I hope, without too much difficulty. They are after all looking for a
> > way to allocate memory from a DMA heap.
> >
> > > So it's better we provide a generic kernel
> > > Kconfig which enables all the default features.
> >
> > I disagree, it should be possible to configure without DMABUF_HEAPS if de=
sired.
>
> It's hard to see a use-case for that additional compile time option. If
> you are worried about kernel size then those can be built as modules. On
> the other hand the benifit is that we avoid ifdefery and providing sane
> TEE defaults where features can be detected and enabled at runtime
> instead.

My primary concern isn't kernel size, even if it shouldn't be
irrelevant. It doesn't seem right to enable features that are not
asked for casually. In this case, it's not unreasonable or unexpected
that DMABUF_HEAPS must be explicitly enabled in the config if a heap
interface is needed. It's the same as before this patch set.

>
> >
> > >
> > > > This seems to do the job:
> > > > +config TEE_DMABUF_HEAP
> > > > + bool
> > > > + depends on TEE =3D y && DMABUF_HEAPS
> > > >
> > > > We can only use DMABUF_HEAPS if the TEE subsystem is compiled into th=
e kernel.
> > >
> > > Ah, I see. So we aren't exporting the DMA heaps APIs for TEE subsystem
> > > to use. We should do that such that there isn't a hard dependency to
> > > compile them into the kernel.
> >
> > I was saving that for a later patch set as a later problem. We may
> > save some time by not doing it now.
> >
>
> But I think it's not a correct way to just reuse internal APIs from DMA
> heaps subsystem without exporting them. It can be seen as a inter
> subsystem API contract breach. I hope it won't be an issue with DMA heap
> maintainers regarding export of those APIs.

Fair enough. I'll add a patch in the next patch set for that. I guess
the same goes for CMA.

Cheers,
Jens

--===============0626743249371689866==--

