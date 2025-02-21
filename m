From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Fri, 21 Feb 2025 16:54:33 +0530
Message-ID: 
 <CAFA6WYMLLLSuz3y5J+DuRFAGrmwpZoWax5sasfAUhXoQXmrNNA@mail.gmail.com>
In-Reply-To: <
 <CAPj87rN-OYTzh5=Gdv619UQD5=x=U6Yt=uV4N1kCs4Zao4RVAg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1466954432817863166=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1466954432817863166==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 at 21:52, Daniel Stone <daniel@fooishbar.org> wrote:
>
> Hi Sumit,
>
> On Mon, 17 Feb 2025 at 06:13, Sumit Garg <sumit.garg@linaro.org> wrote:
> > On Fri, 14 Feb 2025 at 21:19, Boris Brezillon <boris.brezillon@collabor=
a.com> wrote:
> > > I would say one heap per-profile.
> >
> > And then it would have a per vendor multiplication factor as each
> > vendor enforces memory restriction in a platform specific manner which
> > won't scale.
>
> Yes, they do enforce it in a platform-specific manner, but so does
> TEE. There is no one golden set of semantics which is globally
> applicable between all hardware and all products in a useful manner.
>
> So, if we define protected,secure-video +
> protected,secure-video-record + protected,trusted-ui heap names, we
> have exactly the same number of axes. The only change is from uint32_t
> to string.
>
> > > > Christian gave an historical background here [1] as to why that hasn't
> > > > worked in the past with DMA heaps given the scalability issues.
> > > >
> > > > [1] https://lore.kernel.org/dri-devel/e967e382-6cca-4dee-8333-39892d5=
32f71(a)gmail.com/
> > >
> > > Hm, I fail to see where Christian dismiss the dma-heaps solution in
> > > this email. He even says:
> > >
> > > > If the memory is not physically attached to any device, but rather ju=
st
> > > memory attached to the CPU or a system wide memory controller then
> > > expose the memory as DMA-heap with specific requirements (e.g. certain
> > > sized pages, contiguous, restricted, encrypted, ...).
> >
> > I am not saying Christian dismissed DMA heaps but rather how
> > scalability is an issue. What we are proposing here is a generic
> > interface via TEE to the firmware/Trusted OS which can perform all the
> > platform specific memory restrictions. This solution will scale across
> > vendors.
>
> I read something completely different into Christian's mail.
>
> What Christian is saying is that injecting generic constraint solving
> into the kernel doesn't scale. It's not OK to build out generic
> infrastructure in the kernel which queries a bunch of leaf drivers and
> attempts to somehow come up with something which satisfies
> userspace-provided constraints.
>
> But this isn't the same thing as saying 'dma-heaps is wrong'! Again,
> there is no additional complexity in the kernel between a dma-heap
> which bridges over to TEE, and a TEE userspace interface which also
> bridges over to TEE. Both of them are completely fine according to
> what he's said.
>
> > > Honestly, when I look at dma-heap implementations, they seem
> > > to be trivial shells around existing (more complex) allocators, and the
> > > boiler plate [1] to expose a dma-heap is relatively small. The dma-buf
> > > implementation, you already have, so we're talking about a hundred
> > > lines of code to maintain, which shouldn't be significantly more than
> > > what you have for the new ioctl() to be honest.
> >
> > It will rather be redundant vendor specific code under DMA heaps
> > calling into firmware/Trusted OS to enforce memory restrictions as you
> > can look into Mediatek example [1]. With TEE subsystem managing that
> > it won't be the case as we will provide a common abstraction for the
> > communication with underlying firmware/Trusted OS.
>
> Yes, it's common for everyone who uses TEE to implement SVP. It's not
> common for the people who do _not_ use TEE to implement SVP. Which
> means that userspace has to type out both, and what we're asking in
> this thread is: why?
>
> Why should userspace have to support dma-heap allocation for platforms
> supporting SVP via a static DT-defined carveout as well as supporting
> TEE API allocation for platforms supporting SVP via a dynamic
> carveout? What benefit does it bring to have this surfaced as a
> completely separate uAPI?
>
> > > And I'll insist on what
> > > Daniel said, it's a small price to pay to have a standard interface to
> > > expose to userspace. If dma-heaps are not used for this kind things, I
> > > honestly wonder what they will be used for...
> >
> > Let's try not to forcefully find a use-case for DMA heaps when there
> > is a better alternative available.
>
> What makes it better? If you could explain very clearly the benefit
> userspace will gain from asking TEE to allocate $n bytes for
> TEE_IOC_UC_SECURE_VIDEO_PLAY, compared to asking dma-heap to allocate
> $n bytes for protected,secure-video, I think that would really help.
> Right now, I don't understand how it would be better in any way
> whatsoever for userspace. And I think your decision to implement it as
> a separate API is based on a misunderstanding of Christian's position.
>
> > I am still failing to see why you
> > don't consider following as a standardised user-space interface:
> >
> > "When user-space has to work with restricted memory, ask TEE device to
> > allocate it"
>
> As far as I can tell, having userspace work with the TEE interface
> brings zero benefit (again, please correct me if I'm wrong and explain
> how it's better). The direct cost - call it a disbenefit - it brings
> is that we have to spend a pile of time typing out support for TEE
> allocation in every media/GPU/display driver/application, and when we
> do any kind of negotiation, we have to have one protocol definition
> for TEE and one for non-TEE.
>
> dma-heaps was created to solve the problem of having too many
> 'allocate $n bytes from $specialplace' uAPIs. The proliferation was
> painful and making it difficult for userspace to do what it needed to
> do. Userspace doesn't _yet_ make full use of it, but the solution is
> to make userspace make full use of it, not to go create entirely
> separate allocation paths for unclear reasons.
>
> Besides, I'm writing this from a platform that implements SVP not via
> TEE. I've worked on platforms which implement SVP without any TEE,
> where the TEE implementation would be at best a no-op stub, and at
> worst flat-out impossible.

Can you elaborate the non-TEE use-case for Secure Video Path (SVP) a
bit more? As to how the protected/encrypted media content pipeline
works? Which architecture support does your use-case require? Is there
any higher privileged level firmware interaction required to perform
media content decryption into restricted memory? Do you plan to
upstream corresponding support in near future?

Let me try to elaborate on the Secure Video Path (SVP) flow requiring
a TEE implementation (in general terms a higher privileged firmware
managing the pipeline as the kernel/user-space has no access
permissions to the plain text media content):

- Firstly a content decryption key is securely provisioned into the
TEE implementation.
- Interaction with TEE to set up access permissions of different
peripherals in the media pipeline so that they can access restricted
memory.
- Interaction with TEE to allocate restricted memory buffers.
- Interaction with TEE to decrypt downloaded encrypted media content
from normal memory buffers to restricted memory buffers.
- Then the further media pipeline is able to process the plain media
content in restricted buffers and display it.

>
> So that's 'why not TEE as the single uAPI for SVP'.

Let's try to see if your SVP use-case really converges with TEE based
SVP such that we really need a single uAPI.

> So, again, let's
> please turn this around: _why_ TEE? Who benefits from exposing this as
> completely separate to the more generic uAPI that we specifically
> designed to handle things like this?

The bridging between DMA heaps and TEE would still require user-space
to perform an IOCTL into TEE to register the DMA-bufs as you can see
here [1]. Then it will rather be two handles for user-space to manage.
Similarly during restricted memory allocation/free we need another
glue layer under DMA heaps to TEE subsystem.

The reason is simply which has been iterated over many times in the
past threads that:

    "If user-space has to interact with a TEE device for SVP use-case
then why it's not better to ask TEE to allocate restricted DMA-bufs
too"

[1] https://lkml.indiana.edu/hypermail/linux/kernel/2408.3/08296.html

-Sumit

--===============1466954432817863166==--

