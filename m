From: Daniel Stone <daniel@fooishbar.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Thu, 13 Feb 2025 17:39:33 +0000
Message-ID: 
 <CAPj87rPHnME5Osgnf5-FSAu22mDpLj=dzvhi_NqEcOwr1ThgGw@mail.gmail.com>
In-Reply-To: <
 <CAHUa44G9hw-z6wzxg=HkVAxPKEW1yES5JTEqRWMvJUJAtcUDkQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4486714309711416875=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4486714309711416875==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 13 Feb 2025 at 15:57, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
> On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Daniel Stone <daniel@fooishbar.or=
g> wrote:
> > But just because TEE is one good backend implementation, doesn't mean
> > it should be the userspace ABI. Why should userspace care that TEE has
> > mediated the allocation instead of it being a predefined range within
> > DT?
>
> The TEE may very well use a predefined range that part is abstracted
> with the interface.

Of course. But you can also (and this has been shipped on real
devices) handle this without any per-allocation TEE needs by simply
allocating from a memory range which is predefined within DT.

From the userspace point of view, why should there be one ABI to
allocate memory from a predefined range which is delivered by DT to
the kernel, and one ABI to allocate memory from a predefined range
which is mediated by TEE?

> >  What advantage
> > does userspace get from having to have a different codepath to get a
> > different handle to memory? What about x86?
> >
> > I think this proposal is looking at it from the wrong direction.
> > Instead of working upwards from the implementation to userspace, start
> > with userspace and work downwards. The interesting property to focus
> > on is allocating memory, not that EL1 is involved behind the scenes.
>
> From what I've gathered from earlier discussions, it wasn't much of a
> problem for userspace to handle this. If the kernel were to provide it
> via a different ABI, how would it be easier to implement in the
> kernel? I think we need an example to understand your suggestion.

It is a problem for userspace, because we need to expose acceptable
parameters for allocation through the entire stack. If you look at the
dmabuf documentation in the kernel for how buffers should be allocated
and exchanged, you can see the negotiation flow for modifiers. This
permeates through KMS, EGL, Vulkan, Wayland, GStreamer, and more.

Standardising on heaps allows us to add those in a similar way. If we
have to add different allocation mechanisms, then the complexity
increases, permeating not only into all the different userspace APIs,
but also into the drivers which need to support every different
allocation mechanism even if they have no opinion on it - e.g. Mali
doesn't care in any way whether the allocation comes from a heap or
TEE or ACPI or whatever, it cares only that the memory is protected.

Does that help?

Cheers,
Daniel

--===============4486714309711416875==--

