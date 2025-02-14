From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Fri, 14 Feb 2025 11:07:34 +0100
Message-ID: 
 <CAHUa44Gs0D1fBD0=+EDgcQUMeDv4knci9trUkYEc1J98qFV7HQ@mail.gmail.com>
In-Reply-To: <
 <CAPj87rPHnME5Osgnf5-FSAu22mDpLj=dzvhi_NqEcOwr1ThgGw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6130191956695447959=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6130191956695447959==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2025 at 6:39=E2=80=AFPM Daniel Stone <daniel@fooishbar.org>=
 wrote:
>
> Hi,
>
> On Thu, 13 Feb 2025 at 15:57, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> > On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Daniel Stone <daniel@fooishbar.=
org> wrote:
> > > But just because TEE is one good backend implementation, doesn't mean
> > > it should be the userspace ABI. Why should userspace care that TEE has
> > > mediated the allocation instead of it being a predefined range within
> > > DT?
> >
> > The TEE may very well use a predefined range that part is abstracted
> > with the interface.
>
> Of course. But you can also (and this has been shipped on real
> devices) handle this without any per-allocation TEE needs by simply
> allocating from a memory range which is predefined within DT.
>
> From the userspace point of view, why should there be one ABI to
> allocate memory from a predefined range which is delivered by DT to
> the kernel, and one ABI to allocate memory from a predefined range
> which is mediated by TEE?

We need some way to specify the protection profile (or use case as
I've called it in the ABI) required for the buffer. Whether it's
defined in DT seems irrelevant.

>
> > >  What advantage
> > > does userspace get from having to have a different codepath to get a
> > > different handle to memory? What about x86?
> > >
> > > I think this proposal is looking at it from the wrong direction.
> > > Instead of working upwards from the implementation to userspace, start
> > > with userspace and work downwards. The interesting property to focus
> > > on is allocating memory, not that EL1 is involved behind the scenes.
> >
> > From what I've gathered from earlier discussions, it wasn't much of a
> > problem for userspace to handle this. If the kernel were to provide it
> > via a different ABI, how would it be easier to implement in the
> > kernel? I think we need an example to understand your suggestion.
>
> It is a problem for userspace, because we need to expose acceptable
> parameters for allocation through the entire stack. If you look at the
> dmabuf documentation in the kernel for how buffers should be allocated
> and exchanged, you can see the negotiation flow for modifiers. This
> permeates through KMS, EGL, Vulkan, Wayland, GStreamer, and more.

What dma-buf properties are you referring to?
dma_heap_ioctl_allocate() accepts a few flags for the resulting file
descriptor and no flags for the heap itself.

>
> Standardising on heaps allows us to add those in a similar way.

How would you solve this with heaps? Would you use one heap for each
protection profile (use case), add heap_flags, or do a bit of both?

> If we
> have to add different allocation mechanisms, then the complexity
> increases, permeating not only into all the different userspace APIs,
> but also into the drivers which need to support every different
> allocation mechanism even if they have no opinion on it - e.g. Mali
> doesn't care in any way whether the allocation comes from a heap or
> TEE or ACPI or whatever, it cares only that the memory is protected.
>
> Does that help?

I think you're missing the stage where an unprotected buffer is
received and decrypted into a protected buffer. If you use the TEE for
decryption or to configure the involved devices for the use case, it
makes sense to let the TEE allocate the buffers, too. A TEE doesn't
have to be an OS in the secure world, it can be an abstraction to
support the use case depending on the design. So the restricted buffer
is already allocated before we reach Mali in your example.

Allocating restricted buffers from the TEE subsystem saves us from
maintaining proxy dma-buf heaps.

Cheers,
Jens

>
> Cheers,
> Daniel

--===============6130191956695447959==--

