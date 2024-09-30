From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Linaro-mm-sig] Re: [RFC PATCH 0/4] Linaro restricted heap
Date: Mon, 30 Sep 2024 12:17:47 +0530
Message-ID: 
 <CAFA6WYPtp3H5JhxzgH9=z2EvNL7Kdku3EmG1aDkTS-gjFtNZZA@mail.gmail.com>
In-Reply-To: <7c9e3a1a6092f6574c17d7206767ece0bcefc81f.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2593719038634412126=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2593719038634412126==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Sept 2024 at 01:20, Nicolas Dufresne <nicolas@ndufresne.ca> wrot=
e:
>
> Le jeudi 26 septembre 2024 =C3=A0 19:22 +0530, Sumit Garg a =C3=A9crit :
> > [Resend in plain text format as my earlier message was rejected by
> > some mailing lists]
> >
> > On Thu, 26 Sept 2024 at 19:17, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > On 9/25/24 19:31, Christian K=C3=B6nig wrote:
> > >
> > > Am 25.09.24 um 14:51 schrieb Dmitry Baryshkov:
> > >
> > > On Wed, Sep 25, 2024 at 10:51:15AM GMT, Christian K=C3=B6nig wrote:
> > >
> > > Am 25.09.24 um 01:05 schrieb Dmitry Baryshkov:
> > >
> > > On Tue, Sep 24, 2024 at 01:13:18PM GMT, Andrew Davis wrote:
> > >
> > > On 9/23/24 1:33 AM, Dmitry Baryshkov wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Aug 30, 2024 at 09:03:47AM GMT, Jens Wiklander wrote:
> > >
> > > Hi,
> > >
> > > This patch set is based on top of Yong Wu's restricted heap patch set [=
1].
> > > It's also a continuation on Olivier's Add dma-buf secure-heap patch set=
 [2].
> > >
> > > The Linaro restricted heap uses genalloc in the kernel to manage the he=
ap
> > > carvout. This is a difference from the Mediatek restricted heap which
> > > relies on the secure world to manage the carveout.
> > >
> > > I've tried to adress the comments on [2], but [1] introduces changes so=
 I'm
> > > afraid I've had to skip some comments.
> > >
> > > I know I have raised the same question during LPC (in connection to
> > > Qualcomm's dma-heap implementation). Is there any reason why we are
> > > using generic heaps instead of allocating the dma-bufs on the device
> > > side?
> > >
> > > In your case you already have TEE device, you can use it to allocate and
> > > export dma-bufs, which then get imported by the V4L and DRM drivers.
> > >
> > > This goes to the heart of why we have dma-heaps in the first place.
> > > We don't want to burden userspace with having to figure out the right
> > > place to get a dma-buf for a given use-case on a given hardware.
> > > That would be very non-portable, and fail at the core purpose of
> > > a kernel: to abstract hardware specifics away.
> > >
> > > Unfortunately all proposals to use dma-buf heaps were moving in the
> > > described direction: let app select (somehow) from a platform- and
> > > vendor- specific list of dma-buf heaps. In the kernel we at least know
> > > the platform on which the system is running. Userspace generally doesn't
> > > (and shouldn't). As such, it seems better to me to keep the knowledge in
> > > the kernel and allow userspace do its job by calling into existing
> > > device drivers.
> > >
> > > The idea of letting the kernel fully abstract away the complexity of in=
ter
> > > device data exchange is a completely failed design. There has been plen=
ty of
> > > evidence for that over the years.
> > >
> > > Because of this in DMA-buf it's an intentional design decision that
> > > userspace and *not* the kernel decides where and what to allocate from.
> > >
> > > Hmm, ok.
> > >
> > > What the kernel should provide are the necessary information what type =
of
> > > memory a device can work with and if certain memory is accessible or no=
t.
> > > This is the part which is unfortunately still not well defined nor
> > > implemented at the moment.
> > >
> > > Apart from that there are a whole bunch of intentional design decision =
which
> > > should prevent developers to move allocation decision inside the kernel=
. For
> > > example DMA-buf doesn't know what the content of the buffer is (except =
for
> > > it's total size) and which use cases a buffer will be used with.
> > >
> > > So the question if memory should be exposed through DMA-heaps or a driv=
er
> > > specific allocator is not a question of abstraction, but rather one of =
the
> > > physical location and accessibility of the memory.
> > >
> > > If the memory is attached to any physical device, e.g. local memory on a
> > > dGPU, FPGA PCIe BAR, RDMA, camera internal memory etc, then expose the
> > > memory as device specific allocator.
> > >
> > > So, for embedded systems with unified memory all buffers (maybe except
> > > PCIe BARs) should come from DMA-BUF heaps, correct?
> > >
> > >
> > > From what I know that is correct, yes. Question is really if that will =
stay this way.
> > >
> > > Neural accelerators look a lot stripped down FPGAs these days and the b=
enefit of local memory for GPUs is known for decades.
> > >
> > > Could be that designs with local specialized memory see a revival any t=
ime, who knows.
> > >
> > > If the memory is not physically attached to any device, but rather just
> > > memory attached to the CPU or a system wide memory controller then expo=
se
> > > the memory as DMA-heap with specific requirements (e.g. certain sized p=
ages,
> > > contiguous, restricted, encrypted, ...).
> > >
> > > Is encrypted / protected a part of the allocation contract or should it
> > > be enforced separately via a call to TEE / SCM / anything else?
> > >
> > >
> > > Well that is a really good question I can't fully answer either. From w=
hat I know now I would say it depends on the design.
> > >
> >
> > IMHO, I think Dmitry's proposal to rather allow the TEE device to be
> > the allocator and exporter of DMA-bufs related to restricted memory
> > makes sense to me. Since it's really the TEE implementation (OP-TEE,
> > AMD-TEE, TS-TEE or future QTEE) which sets up the restrictions on a
> > particular piece of allocated memory. AFAIK, that happens after the
> > DMA-buf gets allocated and then user-space calls into TEE to set up
> > which media pipeline is going to access that particular DMA-buf. It
> > can also be a static contract depending on a particular platform
> > design.
>
> When the memory get the protection is hardware specific. Otherwise the desi=
gn
> would be really straightforward, allocate from the a heap or any random dri=
ver
> API and protect that memory through an call into the TEE. Clear seperation =
would
> be amazingly better, but this is not how hardware and firmware designer have
> seen it.
>
> In some implementation, there is a carving of memory that be protected befo=
re
> the kernel is booted. I believe (but I'm not affiliated with them) that MTK=
 has
> hardware restriction making that design the only usable method.

Yeah I agree with that. The point I am making here is that the TEE
subsystem can abstract all that platform/vendor specific methods for
user-space to allocate restricted memory. We already have a similar
infrastructure for shared memory among Linux and TEE implementation.
The user-space only uses TEE_IOC_SHM_ALLOC [1] where underneath it can
either allocate from static carveout of shared memory (as a reserved
memory region) OR simply allocate from the kernel heap which is
dynamically mapped into the TEE implementation. The choice here
depends on the platform/TEE implementation capability.

[1] https://docs.kernel.org/userspace-api/tee.html

>
> In general, the handling of secure memory is bound to the TEE application f=
or
> the specific platform, it has to be separated from the generic part of tee
> drivers anyway,

It is really the TEE implementation core which has the privileges to
mark a piece of memory as restricted/secure. The TEE application in
MTK is likely a pseudo TA (a terminology similar to Linux kernel
modules in the TEE world). So it is rather easier for TEE
implementation drivers to abstract out the communication with the
vendor specific TEE core implementation.

> and dmabuf heaps is in my opinion the right API for the task.

Do you really think it is better for user-space to deal with vendor
specific dmabuf heaps?

>
> On MTK, if you have followed, when the SCP (their co-processor) is handling
> restricted video, you can't even call into it anymore directly. So to drive=
 the
> CODECs, everything has to be routed through the TEE. Would you say that bec=
ause
> of that this should not be a V4L2 driver anymore ?

I am not conversant with the MTK hardware/firmware implementation. But
my point is the kernel shouldn't be exposing 10s of vendor specific
DMAbuf heaps to the user-space to choose from which can rather be just
a single TEE device IOCTL used to allocate restricted memory.

>
> >
> > As Jens noted in the other thread, we already manage shared memory
> > allocations (from a static carve-out or dynamically mapped) for
> > communications among Linux and TEE that were based on DMA-bufs earlier
> > but since we didn't required them to be shared with other devices, so
> > we rather switched to anonymous memory.
> >
> > From user-space perspective, it's cleaner to use TEE device IOCTLs for
> > DMA-buf allocations since it already knows which underlying TEE
> > implementation it's communicating with rather than first figuring out
> > which DMA heap to use for allocation and then communicating with TEE
> > implementation.
>
> As a user-space developer in the majority of my time, adding common code to
> handle dma heaps is a lot easier and straight forward then having to glue a=
ll
> the different allocators implement in various subsystems. Communicating whi=
ch
> heap to work can be generic and simple.

Yeah I agree with that notion but IMHO having ifdefry to select vendor
specific DMA heaps isn't something user-space should be dealing with.

-Sumit

>
> Nicolas
>

--===============2593719038634412126==--

