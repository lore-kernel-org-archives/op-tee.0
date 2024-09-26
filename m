From: Andrew Davis <afd@ti.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Linaro-mm-sig] Re: [RFC PATCH 0/4] Linaro restricted heap
Date: Thu, 26 Sep 2024 09:56:11 -0500
Message-ID: <cba2c216-de99-4f54-8762-ee39018d1b43@ti.com>
In-Reply-To: <e967e382-6cca-4dee-8333-39892d532f71@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3542822167306680969=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3542822167306680969==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 9/25/24 3:51 AM, Christian K=C3=B6nig wrote:
> Am 25.09.24 um 01:05 schrieb Dmitry Baryshkov:
>> On Tue, Sep 24, 2024 at 01:13:18PM GMT, Andrew Davis wrote:
>>> On 9/23/24 1:33 AM, Dmitry Baryshkov wrote:
>>>> Hi,
>>>>
>>>> On Fri, Aug 30, 2024 at 09:03:47AM GMT, Jens Wiklander wrote:
>>>>> Hi,
>>>>>
>>>>> This patch set is based on top of Yong Wu's restricted heap patch set[1=
].
>>>>> It's also a continuation on Olivier's Add dma-buf secure-heap patch set=
 [2].
>>>>>
>>>>> The Linaro restricted heap uses genalloc in the kernel to manage the he=
ap
>>>>> carvout. This is a difference from the Mediatek restricted heap which
>>>>> relies on the secure world to manage the carveout.
>>>>>
>>>>> I've tried to adress the comments on [2], but [1] introduces changes so=
 I'm
>>>>> afraid I've had to skip some comments.
>>>> I know I have raised the same question during LPC (in connection to
>>>> Qualcomm's dma-heap implementation). Is there any reason why we are
>>>> using generic heaps instead of allocating the dma-bufs on the device
>>>> side?
>>>>
>>>> In your case you already have TEE device, you can use it to allocate and
>>>> export dma-bufs, which then get imported by the V4L and DRM drivers.
>>>>
>>> This goes to the heart of why we have dma-heaps in the first place.
>>> We don't want to burden userspace with having to figure out the right
>>> place to get a dma-buf for a given use-case on a given hardware.
>>> That would be very non-portable, and fail at the core purpose of
>>> a kernel: to abstract hardware specifics away.
>> Unfortunately all proposals to use dma-buf heaps were moving in the
>> described direction: let app select (somehow) from a platform- and
>> vendor- specific list of dma-buf heaps. In the kernel we at least know
>> the platform on which the system is running. Userspace generally doesn't
>> (and shouldn't). As such, it seems better to me to keep the knowledge in
>> the kernel and allow userspace do its job by calling into existing
>> device drivers.
>=20
> The idea of letting the kernel fully abstract away the complexity of inter =
device data exchange is a completely failed design. There has been plentyof e=
vidence for that over the years.
>=20

And forcing userspace to figure it all out is also an unsolved problem
after all these years. Neither side wants to get their hands dirty, but
it is fundamentally a kernel problem to handle these device complexities.

> Because of this in DMA-buf it's an intentional design decision that userspa=
ce and *not* the kernel decides where and what to allocate from.
>=20

DMA-buf attach and map stages are split from each other, to me this indicates
the design intended the actual backing allocation to be chosen based on attac=
hed
devices at map time, not at allocation time. Meaning userspace doesn't really=
 get
to choose the backing storage.

> What the kernel should provide are the necessary information what type ofme=
mory a device can work with and if certain memory is accessible or not. This =
is the part which is unfortunately still not well defined nor implemented at =
the moment.
>=20

This sounds like the kernel provided "hints" solution. Given enough hints,
the correct Heap would become obvious, and so a complete hint based solution
is one step away from just having the kernel simply make that one correct
selection for you.

> Apart from that there are a whole bunch of intentional design decision whic=
h should prevent developers to move allocation decision inside the kernel. Fo=
r example DMA-buf doesn't know what the content of the buffer is (except for =
it's total size) and which use cases a buffer will be used with.
>=20
> So the question if memory should be exposed through DMA-heaps or a driversp=
ecific allocator is not a question of abstraction, but rather one of thephysi=
cal location and accessibility of the memory.
>=20
> If the memory is attached to any physical device, e.g. local memory on a dG=
PU, FPGA PCIe BAR, RDMA, camera internal memory etc, then expose the memory a=
s device specific allocator.
>=20
> If the memory is not physically attached to any device, but rather just mem=
ory attached to the CPU or a system wide memory controller then expose the me=
mory as DMA-heap with specific requirements (e.g. certain sized pages, contig=
uous, restricted, encrypted, ...).
>=20

Agree with the first part, some exporters are just giving out CPU memory
but with some specific constraint (some subsystems get a pass like V4L2
as it came out before DMA-heaps, but no reason to keep making new allocators
for each and every subsystem just because they may have some memory
constraint on the consumption side).

>>> Worse, the actual interface for dma-buf exporting changes from
>>> framework to framework (getting a dma-buf from DRM is different
>>> than V4L, and there would be yet another API for TEE, etc..)
>> But if the app is working with the particular subsystem, then it already
>> talks its language. Allocating a dma-buf is just another part of the
>> interface, which the app already has to support.
>=20
> Correct, yes.
>=20

Importing the buffer to a given subsystem with be subsystem specific yes,
but I don't see how that means allocating the buffer should have to be too.
For instance I need one of these new "restricted" heaps to pass to V4L2,
I'll need to know how to use V4L2 sure, but why should I have to deal with
the TEE subsystem to get that buffer as proposed? The common allocator
could have handled this.

>>> Most subsystem don't need an allocator, they work just fine
>>> simply being only dma-bufs importers. Recent example being the
>>> IIO subsystem[0], for which some early posting included an
>>> allocator, but in the end, all that was needed was to consume
>>> buffers.
>>>
>>> For devices that don't actually contain memory there is no
>>> reason to be an exporter. What most want is just to consume
>>> normal system memory. Or system memory with some constraints
>>> (e.g. contiguous, coherent, restricted, etc..).
>> ... secure, accessible only to the camera and video encoder, ... or
>> accessible only to the video decoder and the display unit. Who specifies
>> those restrictions? Can we express them in a platform-neutral way?
>=20
> I once create a prototype for letting kernel drivers expose hints to which =
DMA-heap they want to work with.
>=20
> The problem is that there are tons of different use cases and you need tous=
e specific allocations for specific use cases.
>=20
>>>> I have a feeling (I might be completely wrong here) that by using
>>>> generic dma-buf heaps we can easily end up in a situation when the
>>>> userspace depends heavily on the actual platform being used (to map the
>>>> platform to heap names). I think we should instead depend on the
>>>> existing devices (e.g. if there is a TEE device, use an IOCTL to
>>>> allocate secured DMA BUF from it, otherwise check for QTEE device,
>>>> otherwise check for some other vendor device).
>>>>
>>>> The mental experiment to check if the API is correct is really simple:
>>>> Can you use exactly the same rootfs on several devices without
>>>> any additional tuning (e.g. your QEMU, HiKey, a Mediatek board, Qualcomm
>>>> laptop, etc)?
>>>>
>>> This is a great north star to follow. And exactly the reason we should
>>> *not* be exposing device specific constraints to userspace. The constrains
>>> change based on the platform. So a userspace would have to also pick
>>> a different set of constraints based on each platform.
>> Great, I totally agree here.
>=20
> That sounds reasonable, but depends on the restriction.
>=20
> For example a lot of GPUs can work with any imported memory as long as itis=
 DMA accessible for them, but they can scanout a picture to display on amonit=
or only from their local memory.
>=20

And in this case, attaching the DMA-buf to that monitor for scanout
should fail at attach time, if we had a way to properly communicate
constraints between importer and exporter..

>>> Userspace knows which subsystems it will attach a buffer, and the
>>> kernel knows what constraints those devices have on a given platform.
>>> Ideal case is then allocate from the one exporter, attach to various
>>> devices, and have the constraints solved at map time by the exporter
>>> based on the set of attached devices.
>=20
> That approach doesn't work. We have already tried stuff like that multiple =
times.
>=20

Past failures don't guarantee future failure :)

>>> For example, on one platform the display needs contiguous buffers,
>>> but on a different platform the display can scatter-gather. So
>>> what heap should our generic application allocate from when it
>>> wants a buffer consumable by the display, CMA or System?
>>> Answer *should* be always use the generic exporter, and that
>>> exporter then picks the right backing type based on the platform.
>> The display can support scather-gather, the GPU needs bigger stride for
>> this particular format and the video encoder decoder can not support SG.
>> Which set of constraints and which buffer size should generic exporter
>> select?
>=20
> Yeah, exactly that's the problem. The kernel doesn't know all the necessary=
 information to make an informed allocation decision.
>=20

Why not? For instance when we attach a buffer for scanout we provide
all the format/stride/etc info. What we are missing is a backchannel
to provide these to the exporter as a set of constraints that those
formats impose on a memory area for a given device.

> Sometimes you even have to insert format conversation steps and doing that =
transparently for userspace inside the kernel is really a no-go from the desi=
gn side.
>=20

Agree, we cannot be doing conversions like that in-kernel. We need
the format and constraints solved at an earlier step.

Andrew

>>> Userspace shouldn't be dealing with any of these constraints
>>> (looking back, adding the CMA heap was probably incorrect,
>>> and the System heap should have been the only one. Idea back
>>> then was a userspace helper would show up to do the constraint
>>> solving and pick the right heap. That has yet to materialize and
>>> folks are still just hardcoding which heap to use..).
>>>
>>> Same for this restricted heap, I'd like to explore if we can
>>> enhance the System heap such that when attached to the TEE framework,
>>> the backing memory is either made restricted by fire-walling,
>>> or allocating from a TEE carveout (based on platform).
>=20
> Clearly NAK from my side to that design.
>=20
> Regards,
> Christian.
>=20
>> Firewalling from which devices? Or rather allowing access from which
>> devices? Is it possible to specify that somehow?
>>
>>> This will mean more inter-subsystem coordination, but we can
>>> iterate on these in kernel interfaces. We cannot iterate on
>>> userspace interfaces, those have to be correct the first time.
>>>
>>> Andrew
>>>
>>> [0]https://www.kernel.org/doc/html/next/iio/iio_dmabuf_api.html
>>>
>>>>> This can be tested on QEMU with the following steps:
>>>>> repo init -uhttps://github.com/jenswi-linaro/manifest.git  -m qemu_v8.x=
ml \
>>>>>           -b prototype/sdp-v1
>>>>> repo sync -j8
>>>>> cd build
>>>>> make toolchains -j4
>>>>> make all -j$(nproc)
>>>>> make run-only
>>>>> # login and at the prompt:
>>>>> xtest --sdp-basic
>>>>>
>>>>> https://optee.readthedocs.io/en/latest/building/prerequisites.html
>>>>> list dependencies needed to build the above.
>>>>>
>>>>> The tests are pretty basic, mostly checking that a Trusted Application =
in
>>>>> the secure world can access and manipulate the memory.
>>>> - Can we test that the system doesn't crash badly if user provides
>>>>     non-secured memory to the users which expect a secure buffer?
>>>>
>>>> - At the same time corresponding entities shouldn't decode data to the
>>>>     buffers accessible to the rest of the sytem.
>>>>
>>>>> Cheers,
>>>>> Jens
>>>>>
>>>>> [1]https://lore.kernel.org/dri-devel/20240515112308.10171-1-yong.wu(a)m=
ediatek.com/
>>>>> [2]https://lore.kernel.org/lkml/20220805135330.970-1-olivier.masse(a)nx=
p.com/
>>>>>
>>>>> Changes since Olivier's post [2]:
>>>>> * Based on Yong Wu's post [1] where much of dma-buf handling is done in
>>>>>     the generic restricted heap
>>>>> * Simplifications and cleanup
>>>>> * New commit message for "dma-buf: heaps: add Linaro restricted dmabuf =
heap
>>>>>     support"
>>>>> * Replaced the word "secure" with "restricted" where applicable
>>>>>
>>>>> Etienne Carriere (1):
>>>>>     tee: new ioctl to a register tee_shm from a dmabuf file descriptor
>>>>>
>>>>> Jens Wiklander (2):
>>>>>     dma-buf: heaps: restricted_heap: add no_map attribute
>>>>>     dma-buf: heaps: add Linaro restricted dmabuf heap support
>>>>>
>>>>> Olivier Masse (1):
>>>>>     dt-bindings: reserved-memory: add linaro,restricted-heap
>>>>>
>>>>>    .../linaro,restricted-heap.yaml               |  56 ++++++
>>>>>    drivers/dma-buf/heaps/Kconfig                 |  10 ++
>>>>>    drivers/dma-buf/heaps/Makefile                |   1 +
>>>>>    drivers/dma-buf/heaps/restricted_heap.c       |  17 +-
>>>>>    drivers/dma-buf/heaps/restricted_heap.h       |   2 +
>>>>>    .../dma-buf/heaps/restricted_heap_linaro.c    | 165 ++++++++++++++++=
++
>>>>>    drivers/tee/tee_core.c                        |  38 ++++
>>>>>    drivers/tee/tee_shm.c                         | 104 ++++++++++-
>>>>>    include/linux/tee_drv.h                       |  11 ++
>>>>>    include/uapi/linux/tee.h                      |  29 +++
>>>>>    10 files changed, 426 insertions(+), 7 deletions(-)
>>>>>    create mode 100644 Documentation/devicetree/bindings/reserved-memory=
/linaro,restricted-heap.yaml
>>>>>    create mode 100644 drivers/dma-buf/heaps/restricted_heap_linaro.c
>>>>>
>>>>> --=20
>>>>> 2.34.1
>>>>>
>=20

--===============3542822167306680969==--

