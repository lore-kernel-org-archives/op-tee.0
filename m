From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Linaro-mm-sig] Re: [RFC PATCH 0/4] Linaro restricted heap
Date: Fri, 27 Sep 2024 08:16:42 +0200
Message-ID: 
 <CAHUa44GfsSjE9w4vPcbcESNoDj3exA+tfSxzbJh844CzyBVFtg@mail.gmail.com>
In-Reply-To: <2ab11399-ffa0-4940-a965-fb95a5f3b20e@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5641721427914620280=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5641721427914620280==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 26, 2024 at 4:03=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 26.09.24 um 15:52 schrieb Sumit Garg:
> > [Resend in plain text format as my earlier message was rejected by
> > some mailing lists]
> >
> > On Thu, 26 Sept 2024 at 19:17, Sumit Garg <sumit.garg@linaro.org> wrote:
> >> On 9/25/24 19:31, Christian K=C3=B6nig wrote:
> >>
> >> Am 25.09.24 um 14:51 schrieb Dmitry Baryshkov:
> >>
> >> On Wed, Sep 25, 2024 at 10:51:15AM GMT, Christian K=C3=B6nig wrote:
> >>
> >> Am 25.09.24 um 01:05 schrieb Dmitry Baryshkov:
> >>
> >> On Tue, Sep 24, 2024 at 01:13:18PM GMT, Andrew Davis wrote:
> >>
> >> On 9/23/24 1:33 AM, Dmitry Baryshkov wrote:
> >>
> >> Hi,
> >>
> >> On Fri, Aug 30, 2024 at 09:03:47AM GMT, Jens Wiklander wrote:
> >>
> >> Hi,
> >>
> >> This patch set is based on top of Yong Wu's restricted heap patch set [1=
].
> >> It's also a continuation on Olivier's Add dma-buf secure-heap patch set =
[2].
> >>
> >> The Linaro restricted heap uses genalloc in the kernel to manage the heap
> >> carvout. This is a difference from the Mediatek restricted heap which
> >> relies on the secure world to manage the carveout.
> >>
> >> I've tried to adress the comments on [2], but [1] introduces changes so =
I'm
> >> afraid I've had to skip some comments.
> >>
> >> I know I have raised the same question during LPC (in connection to
> >> Qualcomm's dma-heap implementation). Is there any reason why we are
> >> using generic heaps instead of allocating the dma-bufs on the device
> >> side?
> >>
> >> In your case you already have TEE device, you can use it to allocate and
> >> export dma-bufs, which then get imported by the V4L and DRM drivers.
> >>
> >> This goes to the heart of why we have dma-heaps in the first place.
> >> We don't want to burden userspace with having to figure out the right
> >> place to get a dma-buf for a given use-case on a given hardware.
> >> That would be very non-portable, and fail at the core purpose of
> >> a kernel: to abstract hardware specifics away.
> >>
> >> Unfortunately all proposals to use dma-buf heaps were moving in the
> >> described direction: let app select (somehow) from a platform- and
> >> vendor- specific list of dma-buf heaps. In the kernel we at least know
> >> the platform on which the system is running. Userspace generally doesn't
> >> (and shouldn't). As such, it seems better to me to keep the knowledge in
> >> the kernel and allow userspace do its job by calling into existing
> >> device drivers.
> >>
> >> The idea of letting the kernel fully abstract away the complexity of int=
er
> >> device data exchange is a completely failed design. There has been plent=
y of
> >> evidence for that over the years.
> >>
> >> Because of this in DMA-buf it's an intentional design decision that
> >> userspace and *not* the kernel decides where and what to allocate from.
> >>
> >> Hmm, ok.
> >>
> >> What the kernel should provide are the necessary information what type of
> >> memory a device can work with and if certain memory is accessible or not.
> >> This is the part which is unfortunately still not well defined nor
> >> implemented at the moment.
> >>
> >> Apart from that there are a whole bunch of intentional design decision w=
hich
> >> should prevent developers to move allocation decision inside the kernel.=
 For
> >> example DMA-buf doesn't know what the content of the buffer is (except f=
or
> >> it's total size) and which use cases a buffer will be used with.
> >>
> >> So the question if memory should be exposed through DMA-heaps or a driver
> >> specific allocator is not a question of abstraction, but rather one of t=
he
> >> physical location and accessibility of the memory.
> >>
> >> If the memory is attached to any physical device, e.g. local memory on a
> >> dGPU, FPGA PCIe BAR, RDMA, camera internal memory etc, then expose the
> >> memory as device specific allocator.
> >>
> >> So, for embedded systems with unified memory all buffers (maybe except
> >> PCIe BARs) should come from DMA-BUF heaps, correct?
> >>
> >>
> >>  From what I know that is correct, yes. Question is really if that will =
stay this way.
> >>
> >> Neural accelerators look a lot stripped down FPGAs these days and the be=
nefit of local memory for GPUs is known for decades.
> >>
> >> Could be that designs with local specialized memory see a revival any ti=
me, who knows.
> >>
> >> If the memory is not physically attached to any device, but rather just
> >> memory attached to the CPU or a system wide memory controller then expose
> >> the memory as DMA-heap with specific requirements (e.g. certain sized pa=
ges,
> >> contiguous, restricted, encrypted, ...).
> >>
> >> Is encrypted / protected a part of the allocation contract or should it
> >> be enforced separately via a call to TEE / SCM / anything else?
> >>
> >>
> >> Well that is a really good question I can't fully answer either. From wh=
at I know now I would say it depends on the design.
> >>
> > IMHO, I think Dmitry's proposal to rather allow the TEE device to be
> > the allocator and exporter of DMA-bufs related to restricted memory
> > makes sense to me. Since it's really the TEE implementation (OP-TEE,
> > AMD-TEE, TS-TEE or future QTEE) which sets up the restrictions on a
> > particular piece of allocated memory. AFAIK, that happens after the
> > DMA-buf gets allocated and then user-space calls into TEE to set up
> > which media pipeline is going to access that particular DMA-buf. It
> > can also be a static contract depending on a particular platform
> > design.
> >
> > As Jens noted in the other thread, we already manage shared memory
> > allocations (from a static carve-out or dynamically mapped) for
> > communications among Linux and TEE that were based on DMA-bufs earlier
> > but since we didn't required them to be shared with other devices, so
> > we rather switched to anonymous memory.
> >
> >  From user-space perspective, it's cleaner to use TEE device IOCTLs for
> > DMA-buf allocations since it already knows which underlying TEE
> > implementation it's communicating with rather than first figuring out
> > which DMA heap to use for allocation and then communicating with TEE
> > implementation.
>
> +1
>
> I'm not that deeply into the functionality the TEE device IOCTLs expose,
> so can't judge if what's said above is correct or not.
>
> But in general building on top of existing infrastructure and
> information is a really strong argument for a design.
>
> So from my 10 mile high point of view that sounds like the way to go.

That sounds good, I'll prepare another patch set based on that
approach so we can see all the details.

Thanks,
Jens

--===============5641721427914620280==--

