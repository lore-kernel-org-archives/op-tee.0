From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Mon, 17 Feb 2025 11:42:55 +0530
Message-ID: 
 <CAFA6WYPc6EHQwcPuMZRm4C1P6SoDrCzEPUmju_meupB6NXQ1sg@mail.gmail.com>
In-Reply-To: <20250214164856.0d2ead8a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2879642619123359417=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2879642619123359417==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 at 21:19, Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Fri, 14 Feb 2025 18:37:14 +0530
> Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > On Fri, 14 Feb 2025 at 15:37, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Feb 13, 2025 at 6:39=E2=80=AFPM Daniel Stone <daniel@fooishba=
r.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, 13 Feb 2025 at 15:57, Jens Wiklander <jens.wiklander@linaro=
.org> wrote:
> > > > > On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Daniel Stone <daniel@fooi=
shbar.org> wrote:
> > > > > > But just because TEE is one good backend implementation, doesn't =
mean
> > > > > > it should be the userspace ABI. Why should userspace care that TE=
E has
> > > > > > mediated the allocation instead of it being a predefined range wi=
thin
> > > > > > DT?
> > > > >
> > > > > The TEE may very well use a predefined range that part is abstracted
> > > > > with the interface.
> > > >
> > > > Of course. But you can also (and this has been shipped on real
> > > > devices) handle this without any per-allocation TEE needs by simply
> > > > allocating from a memory range which is predefined within DT.
> > > >
> > > > From the userspace point of view, why should there be one ABI to
> > > > allocate memory from a predefined range which is delivered by DT to
> > > > the kernel, and one ABI to allocate memory from a predefined range
> > > > which is mediated by TEE?
> > >
> > > We need some way to specify the protection profile (or use case as
> > > I've called it in the ABI) required for the buffer. Whether it's
> > > defined in DT seems irrelevant.
> > >
> > > >
> > > > > >  What advantage
> > > > > > does userspace get from having to have a different codepath to ge=
t a
> > > > > > different handle to memory? What about x86?
> > > > > >
> > > > > > I think this proposal is looking at it from the wrong direction.
> > > > > > Instead of working upwards from the implementation to userspace, =
start
> > > > > > with userspace and work downwards. The interesting property to fo=
cus
> > > > > > on is allocating memory, not that EL1 is involved behind the scen=
es.
> > > > >
> > > > > From what I've gathered from earlier discussions, it wasn't much of=
 a
> > > > > problem for userspace to handle this. If the kernel were to provide=
 it
> > > > > via a different ABI, how would it be easier to implement in the
> > > > > kernel? I think we need an example to understand your suggestion.
> > > >
> > > > It is a problem for userspace, because we need to expose acceptable
> > > > parameters for allocation through the entire stack. If you look at the
> > > > dmabuf documentation in the kernel for how buffers should be allocated
> > > > and exchanged, you can see the negotiation flow for modifiers. This
> > > > permeates through KMS, EGL, Vulkan, Wayland, GStreamer, and more.
> > >
> > > What dma-buf properties are you referring to?
> > > dma_heap_ioctl_allocate() accepts a few flags for the resulting file
> > > descriptor and no flags for the heap itself.
> > >
> > > >
> > > > Standardising on heaps allows us to add those in a similar way.
> > >
> > > How would you solve this with heaps? Would you use one heap for each
> > > protection profile (use case), add heap_flags, or do a bit of both?
>
> I would say one heap per-profile.
>

And then it would have a per vendor multiplication factor as each
vendor enforces memory restriction in a platform specific manner which
won't scale.

> >
> > Christian gave an historical background here [1] as to why that hasn't
> > worked in the past with DMA heaps given the scalability issues.
> >
> > [1] https://lore.kernel.org/dri-devel/e967e382-6cca-4dee-8333-39892d532f7=
1(a)gmail.com/
>
> Hm, I fail to see where Christian dismiss the dma-heaps solution in
> this email. He even says:
>
> > If the memory is not physically attached to any device, but rather just
> memory attached to the CPU or a system wide memory controller then
> expose the memory as DMA-heap with specific requirements (e.g. certain
> sized pages, contiguous, restricted, encrypted, ...).

I am not saying Christian dismissed DMA heaps but rather how
scalability is an issue. What we are proposing here is a generic
interface via TEE to the firmware/Trusted OS which can perform all the
platform specific memory restrictions. This solution will scale across
vendors.

>
> >
> > >
> > > > If we
> > > > have to add different allocation mechanisms, then the complexity
> > > > increases, permeating not only into all the different userspace APIs,
> > > > but also into the drivers which need to support every different
> > > > allocation mechanism even if they have no opinion on it - e.g. Mali
> > > > doesn't care in any way whether the allocation comes from a heap or
> > > > TEE or ACPI or whatever, it cares only that the memory is protected.
> > > >
> > > > Does that help?
> > >
> > > I think you're missing the stage where an unprotected buffer is
> > > received and decrypted into a protected buffer. If you use the TEE for
> > > decryption or to configure the involved devices for the use case, it
> > > makes sense to let the TEE allocate the buffers, too. A TEE doesn't
> > > have to be an OS in the secure world, it can be an abstraction to
> > > support the use case depending on the design. So the restricted buffer
> > > is already allocated before we reach Mali in your example.
> > >
> > > Allocating restricted buffers from the TEE subsystem saves us from
> > > maintaining proxy dma-buf heaps.
>
> Honestly, when I look at dma-heap implementations, they seem
> to be trivial shells around existing (more complex) allocators, and the
> boiler plate [1] to expose a dma-heap is relatively small. The dma-buf
> implementation, you already have, so we're talking about a hundred
> lines of code to maintain, which shouldn't be significantly more than
> what you have for the new ioctl() to be honest.

It will rather be redundant vendor specific code under DMA heaps
calling into firmware/Trusted OS to enforce memory restrictions as you
can look into Mediatek example [1]. With TEE subsystem managing that
it won't be the case as we will provide a common abstraction for the
communication with underlying firmware/Trusted OS.

[1] https://lore.kernel.org/linux-arm-kernel/20240515112308.10171-1-yong.wu(a=
)mediatek.com/

> And I'll insist on what
> Daniel said, it's a small price to pay to have a standard interface to
> expose to userspace. If dma-heaps are not used for this kind things, I
> honestly wonder what they will be used for...

Let's try not to forcefully find a use-case for DMA heaps when there
is a better alternative available. I am still failing to see why you
don't consider following as a standardised user-space interface:

"When user-space has to work with restricted memory, ask TEE device to
allocate it"

-Sumit

--===============2879642619123359417==--

