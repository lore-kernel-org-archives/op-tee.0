From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Linaro-mm-sig] Re: [RFC PATCH 0/4] Linaro restricted heap
Date: Fri, 27 Sep 2024 19:50:08 +0000
Message-ID: <7c9e3a1a6092f6574c17d7206767ece0bcefc81f.camel@ndufresne.ca>
In-Reply-To: <
 <CAFA6WYMd46quafJoGXjkCiPOKpYoDZdXwrNbG3QekyjB3_2FTA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2264085581284317653=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2264085581284317653==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 26 septembre 2024 =C3=A0 19:22 +0530, Sumit Garg a =C3=A9crit=C2=A0:
> [Resend in plain text format as my earlier message was rejected by
> some mailing lists]
>=20
> On Thu, 26 Sept 2024 at 19:17, Sumit Garg <sumit.garg@linaro.org> wrote:
> >=20
> > On 9/25/24 19:31, Christian K=C3=B6nig wrote:
> >=20
> > Am 25.09.24 um 14:51 schrieb Dmitry Baryshkov:
> >=20
> > On Wed, Sep 25, 2024 at 10:51:15AM GMT, Christian K=C3=B6nig wrote:
> >=20
> > Am 25.09.24 um 01:05 schrieb Dmitry Baryshkov:
> >=20
> > On Tue, Sep 24, 2024 at 01:13:18PM GMT, Andrew Davis wrote:
> >=20
> > On 9/23/24 1:33 AM, Dmitry Baryshkov wrote:
> >=20
> > Hi,
> >=20
> > On Fri, Aug 30, 2024 at 09:03:47AM GMT, Jens Wiklander wrote:
> >=20
> > Hi,
> >=20
> > This patch set is based on top of Yong Wu's restricted heap patch set [1].
> > It's also a continuation on Olivier's Add dma-buf secure-heap patch set [=
2].
> >=20
> > The Linaro restricted heap uses genalloc in the kernel to manage the heap
> > carvout. This is a difference from the Mediatek restricted heap which
> > relies on the secure world to manage the carveout.
> >=20
> > I've tried to adress the comments on [2], but [1] introduces changes so I=
'm
> > afraid I've had to skip some comments.
> >=20
> > I know I have raised the same question during LPC (in connection to
> > Qualcomm's dma-heap implementation). Is there any reason why we are
> > using generic heaps instead of allocating the dma-bufs on the device
> > side?
> >=20
> > In your case you already have TEE device, you can use it to allocate and
> > export dma-bufs, which then get imported by the V4L and DRM drivers.
> >=20
> > This goes to the heart of why we have dma-heaps in the first place.
> > We don't want to burden userspace with having to figure out the right
> > place to get a dma-buf for a given use-case on a given hardware.
> > That would be very non-portable, and fail at the core purpose of
> > a kernel: to abstract hardware specifics away.
> >=20
> > Unfortunately all proposals to use dma-buf heaps were moving in the
> > described direction: let app select (somehow) from a platform- and
> > vendor- specific list of dma-buf heaps. In the kernel we at least know
> > the platform on which the system is running. Userspace generally doesn't
> > (and shouldn't). As such, it seems better to me to keep the knowledge in
> > the kernel and allow userspace do its job by calling into existing
> > device drivers.
> >=20
> > The idea of letting the kernel fully abstract away the complexity of inter
> > device data exchange is a completely failed design. There has been plenty=
 of
> > evidence for that over the years.
> >=20
> > Because of this in DMA-buf it's an intentional design decision that
> > userspace and *not* the kernel decides where and what to allocate from.
> >=20
> > Hmm, ok.
> >=20
> > What the kernel should provide are the necessary information what type of
> > memory a device can work with and if certain memory is accessible or not.
> > This is the part which is unfortunately still not well defined nor
> > implemented at the moment.
> >=20
> > Apart from that there are a whole bunch of intentional design decision wh=
ich
> > should prevent developers to move allocation decision inside the kernel. =
For
> > example DMA-buf doesn't know what the content of the buffer is (except for
> > it's total size) and which use cases a buffer will be used with.
> >=20
> > So the question if memory should be exposed through DMA-heaps or a driver
> > specific allocator is not a question of abstraction, but rather one of the
> > physical location and accessibility of the memory.
> >=20
> > If the memory is attached to any physical device, e.g. local memory on a
> > dGPU, FPGA PCIe BAR, RDMA, camera internal memory etc, then expose the
> > memory as device specific allocator.
> >=20
> > So, for embedded systems with unified memory all buffers (maybe except
> > PCIe BARs) should come from DMA-BUF heaps, correct?
> >=20
> >=20
> > From what I know that is correct, yes. Question is really if that will st=
ay this way.
> >=20
> > Neural accelerators look a lot stripped down FPGAs these days and the ben=
efit of local memory for GPUs is known for decades.
> >=20
> > Could be that designs with local specialized memory see a revival any tim=
e, who knows.
> >=20
> > If the memory is not physically attached to any device, but rather just
> > memory attached to the CPU or a system wide memory controller then expose
> > the memory as DMA-heap with specific requirements (e.g. certain sized pag=
es,
> > contiguous, restricted, encrypted, ...).
> >=20
> > Is encrypted / protected a part of the allocation contract or should it
> > be enforced separately via a call to TEE / SCM / anything else?
> >=20
> >=20
> > Well that is a really good question I can't fully answer either. From wha=
t I know now I would say it depends on the design.
> >=20
>=20
> IMHO, I think Dmitry's proposal to rather allow the TEE device to be
> the allocator and exporter of DMA-bufs related to restricted memory
> makes sense to me. Since it's really the TEE implementation (OP-TEE,
> AMD-TEE, TS-TEE or future QTEE) which sets up the restrictions on a
> particular piece of allocated memory. AFAIK, that happens after the
> DMA-buf gets allocated and then user-space calls into TEE to set up
> which media pipeline is going to access that particular DMA-buf. It
> can also be a static contract depending on a particular platform
> design.

When the memory get the protection is hardware specific. Otherwise the design
would be really straightforward, allocate from the a heap or any random driver
API and protect that memory through an call into the TEE. Clear seperation wo=
uld
be amazingly better, but this is not how hardware and firmware designer have
seen it.=20

In some implementation, there is a carving of memory that be protected before
the kernel is booted. I believe (but I'm not affiliated with them) that MTK h=
as
hardware restriction making that design the only usable method.

In general, the handling of secure memory is bound to the TEE application for
the specific platform, it has to be separated from the generic part of tee
drivers anyway, and dmabuf heaps is in my opinion the right API for the task.

On MTK, if you have followed, when the SCP (their co-processor) is handling
restricted video, you can't even call into it anymore directly. So to drive t=
he
CODECs, everything has to be routed through the TEE. Would you say that becau=
se
of that this should not be a V4L2 driver anymore ?

>=20
> As Jens noted in the other thread, we already manage shared memory
> allocations (from a static carve-out or dynamically mapped) for
> communications among Linux and TEE that were based on DMA-bufs earlier
> but since we didn't required them to be shared with other devices, so
> we rather switched to anonymous memory.
>=20
> From user-space perspective, it's cleaner to use TEE device IOCTLs for
> DMA-buf allocations since it already knows which underlying TEE
> implementation it's communicating with rather than first figuring out
> which DMA heap to use for allocation and then communicating with TEE
> implementation.

As a user-space developer in the majority of my time, adding common code to
handle dma heaps is a lot easier and straight forward then having to glue all
the different allocators implement in various subsystems. Communicating which
heap to work can be generic and simple.

Nicolas


--===============2264085581284317653==--

