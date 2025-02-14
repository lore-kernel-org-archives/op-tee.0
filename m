From: Boris Brezillon <boris.brezillon@collabora.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Fri, 14 Feb 2025 16:48:56 +0100
Message-ID: <20250214164856.0d2ead8a@collabora.com>
In-Reply-To: <
 <CAFA6WYOuTwRPEh3L7+hMyARB_E73xmp+OwhKyS-r4+ryS7=9sw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0407417091299120431=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0407417091299120431==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 18:37:14 +0530
Sumit Garg <sumit.garg@linaro.org> wrote:

> On Fri, 14 Feb 2025 at 15:37, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Hi,
> >
> > On Thu, Feb 13, 2025 at 6:39=E2=80=AFPM Daniel Stone <daniel@fooishbar.=
org> wrote: =20
> > >
> > > Hi,
> > >
> > > On Thu, 13 Feb 2025 at 15:57, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote: =20
> > > > On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Daniel Stone <daniel@fooish=
bar.org> wrote: =20
> > > > > But just because TEE is one good backend implementation, doesn't me=
an
> > > > > it should be the userspace ABI. Why should userspace care that TEE =
has
> > > > > mediated the allocation instead of it being a predefined range with=
in
> > > > > DT? =20
> > > >
> > > > The TEE may very well use a predefined range that part is abstracted
> > > > with the interface. =20
> > >
> > > Of course. But you can also (and this has been shipped on real
> > > devices) handle this without any per-allocation TEE needs by simply
> > > allocating from a memory range which is predefined within DT.
> > >
> > > From the userspace point of view, why should there be one ABI to
> > > allocate memory from a predefined range which is delivered by DT to
> > > the kernel, and one ABI to allocate memory from a predefined range
> > > which is mediated by TEE? =20
> >
> > We need some way to specify the protection profile (or use case as
> > I've called it in the ABI) required for the buffer. Whether it's
> > defined in DT seems irrelevant.
> > =20
> > > =20
> > > > >  What advantage
> > > > > does userspace get from having to have a different codepath to get a
> > > > > different handle to memory? What about x86?
> > > > >
> > > > > I think this proposal is looking at it from the wrong direction.
> > > > > Instead of working upwards from the implementation to userspace, st=
art
> > > > > with userspace and work downwards. The interesting property to focus
> > > > > on is allocating memory, not that EL1 is involved behind the scenes=
. =20
> > > >
> > > > From what I've gathered from earlier discussions, it wasn't much of a
> > > > problem for userspace to handle this. If the kernel were to provide it
> > > > via a different ABI, how would it be easier to implement in the
> > > > kernel? I think we need an example to understand your suggestion. =20
> > >
> > > It is a problem for userspace, because we need to expose acceptable
> > > parameters for allocation through the entire stack. If you look at the
> > > dmabuf documentation in the kernel for how buffers should be allocated
> > > and exchanged, you can see the negotiation flow for modifiers. This
> > > permeates through KMS, EGL, Vulkan, Wayland, GStreamer, and more. =20
> >
> > What dma-buf properties are you referring to?
> > dma_heap_ioctl_allocate() accepts a few flags for the resulting file
> > descriptor and no flags for the heap itself.
> > =20
> > >
> > > Standardising on heaps allows us to add those in a similar way. =20
> >
> > How would you solve this with heaps? Would you use one heap for each
> > protection profile (use case), add heap_flags, or do a bit of both?

I would say one heap per-profile.

>=20
> Christian gave an historical background here [1] as to why that hasn't
> worked in the past with DMA heaps given the scalability issues.
>=20
> [1] https://lore.kernel.org/dri-devel/e967e382-6cca-4dee-8333-39892d532f71(=
a)gmail.com/

Hm, I fail to see where Christian dismiss the dma-heaps solution in
this email. He even says:

> If the memory is not physically attached to any device, but rather just=20
memory attached to the CPU or a system wide memory controller then=20
expose the memory as DMA-heap with specific requirements (e.g. certain=20
sized pages, contiguous, restricted, encrypted, ...).

>=20
> > =20
> > > If we
> > > have to add different allocation mechanisms, then the complexity
> > > increases, permeating not only into all the different userspace APIs,
> > > but also into the drivers which need to support every different
> > > allocation mechanism even if they have no opinion on it - e.g. Mali
> > > doesn't care in any way whether the allocation comes from a heap or
> > > TEE or ACPI or whatever, it cares only that the memory is protected.
> > >
> > > Does that help? =20
> >
> > I think you're missing the stage where an unprotected buffer is
> > received and decrypted into a protected buffer. If you use the TEE for
> > decryption or to configure the involved devices for the use case, it
> > makes sense to let the TEE allocate the buffers, too. A TEE doesn't
> > have to be an OS in the secure world, it can be an abstraction to
> > support the use case depending on the design. So the restricted buffer
> > is already allocated before we reach Mali in your example.
> >
> > Allocating restricted buffers from the TEE subsystem saves us from
> > maintaining proxy dma-buf heaps. =20

Honestly, when I look at dma-heap implementations, they seem
to be trivial shells around existing (more complex) allocators, and the
boiler plate [1] to expose a dma-heap is relatively small. The dma-buf
implementation, you already have, so we're talking about a hundred
lines of code to maintain, which shouldn't be significantly more than
what you have for the new ioctl() to be honest. And I'll insist on what
Daniel said, it's a small price to pay to have a standard interface to
expose to userspace. If dma-heaps are not used for this kind things, I
honestly wonder what they will be used for...

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v6.13.2/source/drivers/dma-buf/heaps/syst=
em_heap.c#L314

--===============0407417091299120431==--

