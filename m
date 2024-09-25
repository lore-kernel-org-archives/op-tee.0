From: Christian König <ckoenig.leichtzumerken@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Linaro-mm-sig] Re: [RFC PATCH 0/4] Linaro restricted heap
Date: Wed, 25 Sep 2024 10:51:15 +0200
Message-ID: <e967e382-6cca-4dee-8333-39892d532f71@gmail.com>
In-Reply-To: <mzur3odofwwrdqnystozjgf3qtvb73wqjm6g2vf5dfsqiehaxk@u67fcarhm6ge>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0881275445809158128=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0881275445809158128==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 25.09.24 um 01:05 schrieb Dmitry Baryshkov:
> On Tue, Sep 24, 2024 at 01:13:18PM GMT, Andrew Davis wrote:
>> On 9/23/24 1:33 AM, Dmitry Baryshkov wrote:
>>> Hi,
>>>
>>> On Fri, Aug 30, 2024 at 09:03:47AM GMT, Jens Wiklander wrote:
>>>> Hi,
>>>>
>>>> This patch set is based on top of Yong Wu's restricted heap patch set [1=
].
>>>> It's also a continuation on Olivier's Add dma-buf secure-heap patch set =
[2].
>>>>
>>>> The Linaro restricted heap uses genalloc in the kernel to manage the heap
>>>> carvout. This is a difference from the Mediatek restricted heap which
>>>> relies on the secure world to manage the carveout.
>>>>
>>>> I've tried to adress the comments on [2], but [1] introduces changes so =
I'm
>>>> afraid I've had to skip some comments.
>>> I know I have raised the same question during LPC (in connection to
>>> Qualcomm's dma-heap implementation). Is there any reason why we are
>>> using generic heaps instead of allocating the dma-bufs on the device
>>> side?
>>>
>>> In your case you already have TEE device, you can use it to allocate and
>>> export dma-bufs, which then get imported by the V4L and DRM drivers.
>>>
>> This goes to the heart of why we have dma-heaps in the first place.
>> We don't want to burden userspace with having to figure out the right
>> place to get a dma-buf for a given use-case on a given hardware.
>> That would be very non-portable, and fail at the core purpose of
>> a kernel: to abstract hardware specifics away.
> Unfortunately all proposals to use dma-buf heaps were moving in the
> described direction: let app select (somehow) from a platform- and
> vendor- specific list of dma-buf heaps. In the kernel we at least know
> the platform on which the system is running. Userspace generally doesn't
> (and shouldn't). As such, it seems better to me to keep the knowledge in
> the kernel and allow userspace do its job by calling into existing
> device drivers.

The idea of letting the kernel fully abstract away the complexity of=20
inter device data exchange is a completely failed design. There has been=20
plenty of evidence for that over the years.

Because of this in DMA-buf it's an intentional design decision that=20
userspace and *not* the kernel decides where and what to allocate from.

What the kernel should provide are the necessary information what type=20
of memory a device can work with and if certain memory is accessible or=20
not. This is the part which is unfortunately still not well defined nor=20
implemented at the moment.

Apart from that there are a whole bunch of intentional design decision=20
which should prevent developers to move allocation decision inside the=20
kernel. For example DMA-buf doesn't know what the content of the buffer=20
is (except for it's total size) and which use cases a buffer will be=20
used with.

So the question if memory should be exposed through DMA-heaps or a=20
driver specific allocator is not a question of abstraction, but rather=20
one of the physical location and accessibility of the memory.

If the memory is attached to any physical device, e.g. local memory on a=20
dGPU, FPGA PCIe BAR, RDMA, camera internal memory etc, then expose the=20
memory as device specific allocator.

If the memory is not physically attached to any device, but rather just=20
memory attached to the CPU or a system wide memory controller then=20
expose the memory as DMA-heap with specific requirements (e.g. certain=20
sized pages, contiguous, restricted, encrypted, ...).

>> Worse, the actual interface for dma-buf exporting changes from
>> framework to framework (getting a dma-buf from DRM is different
>> than V4L, and there would be yet another API for TEE, etc..)
> But if the app is working with the particular subsystem, then it already
> talks its language. Allocating a dma-buf is just another part of the
> interface, which the app already has to support.

Correct, yes.

>> Most subsystem don't need an allocator, they work just fine
>> simply being only dma-bufs importers. Recent example being the
>> IIO subsystem[0], for which some early posting included an
>> allocator, but in the end, all that was needed was to consume
>> buffers.
>>
>> For devices that don't actually contain memory there is no
>> reason to be an exporter. What most want is just to consume
>> normal system memory. Or system memory with some constraints
>> (e.g. contiguous, coherent, restricted, etc..).
> ... secure, accessible only to the camera and video encoder, ... or
> accessible only to the video decoder and the display unit. Who specifies
> those restrictions? Can we express them in a platform-neutral way?

I once create a prototype for letting kernel drivers expose hints to=20
which DMA-heap they want to work with.

The problem is that there are tons of different use cases and you need=20
to use specific allocations for specific use cases.

>>> I have a feeling (I might be completely wrong here) that by using
>>> generic dma-buf heaps we can easily end up in a situation when the
>>> userspace depends heavily on the actual platform being used (to map the
>>> platform to heap names). I think we should instead depend on the
>>> existing devices (e.g. if there is a TEE device, use an IOCTL to
>>> allocate secured DMA BUF from it, otherwise check for QTEE device,
>>> otherwise check for some other vendor device).
>>>
>>> The mental experiment to check if the API is correct is really simple:
>>> Can you use exactly the same rootfs on several devices without
>>> any additional tuning (e.g. your QEMU, HiKey, a Mediatek board, Qualcomm
>>> laptop, etc)?
>>>
>> This is a great north star to follow. And exactly the reason we should
>> *not* be exposing device specific constraints to userspace. The constrains
>> change based on the platform. So a userspace would have to also pick
>> a different set of constraints based on each platform.
> Great, I totally agree here.

That sounds reasonable, but depends on the restriction.

For example a lot of GPUs can work with any imported memory as long as=20
it is DMA accessible for them, but they can scanout a picture to display=20
on a monitor only from their local memory.

>> Userspace knows which subsystems it will attach a buffer, and the
>> kernel knows what constraints those devices have on a given platform.
>> Ideal case is then allocate from the one exporter, attach to various
>> devices, and have the constraints solved at map time by the exporter
>> based on the set of attached devices.

That approach doesn't work. We have already tried stuff like that=20
multiple times.

>>
>> For example, on one platform the display needs contiguous buffers,
>> but on a different platform the display can scatter-gather. So
>> what heap should our generic application allocate from when it
>> wants a buffer consumable by the display, CMA or System?
>> Answer *should* be always use the generic exporter, and that
>> exporter then picks the right backing type based on the platform.
> The display can support scather-gather, the GPU needs bigger stride for
> this particular format and the video encoder decoder can not support SG.
> Which set of constraints and which buffer size should generic exporter
> select?

Yeah, exactly that's the problem. The kernel doesn't know all the=20
necessary information to make an informed allocation decision.

Sometimes you even have to insert format conversation steps and doing=20
that transparently for userspace inside the kernel is really a no-go=20
from the design side.

>> Userspace shouldn't be dealing with any of these constraints
>> (looking back, adding the CMA heap was probably incorrect,
>> and the System heap should have been the only one. Idea back
>> then was a userspace helper would show up to do the constraint
>> solving and pick the right heap. That has yet to materialize and
>> folks are still just hardcoding which heap to use..).
>>
>> Same for this restricted heap, I'd like to explore if we can
>> enhance the System heap such that when attached to the TEE framework,
>> the backing memory is either made restricted by fire-walling,
>> or allocating from a TEE carveout (based on platform).

Clearly NAK from my side to that design.

Regards,
Christian.

> Firewalling from which devices? Or rather allowing access from which
> devices? Is it possible to specify that somehow?
>
>> This will mean more inter-subsystem coordination, but we can
>> iterate on these in kernel interfaces. We cannot iterate on
>> userspace interfaces, those have to be correct the first time.
>>
>> Andrew
>>
>> [0]https://www.kernel.org/doc/html/next/iio/iio_dmabuf_api.html
>>
>>>> This can be tested on QEMU with the following steps:
>>>> repo init -uhttps://github.com/jenswi-linaro/manifest.git  -m qemu_v8.xm=
l \
>>>>           -b prototype/sdp-v1
>>>> repo sync -j8
>>>> cd build
>>>> make toolchains -j4
>>>> make all -j$(nproc)
>>>> make run-only
>>>> # login and at the prompt:
>>>> xtest --sdp-basic
>>>>
>>>> https://optee.readthedocs.io/en/latest/building/prerequisites.html
>>>> list dependencies needed to build the above.
>>>>
>>>> The tests are pretty basic, mostly checking that a Trusted Application in
>>>> the secure world can access and manipulate the memory.
>>> - Can we test that the system doesn't crash badly if user provides
>>>     non-secured memory to the users which expect a secure buffer?
>>>
>>> - At the same time corresponding entities shouldn't decode data to the
>>>     buffers accessible to the rest of the sytem.
>>>
>>>> Cheers,
>>>> Jens
>>>>
>>>> [1]https://lore.kernel.org/dri-devel/20240515112308.10171-1-yong.wu(a)me=
diatek.com/
>>>> [2]https://lore.kernel.org/lkml/20220805135330.970-1-olivier.masse(a)nxp=
.com/
>>>>
>>>> Changes since Olivier's post [2]:
>>>> * Based on Yong Wu's post [1] where much of dma-buf handling is done in
>>>>     the generic restricted heap
>>>> * Simplifications and cleanup
>>>> * New commit message for "dma-buf: heaps: add Linaro restricted dmabuf h=
eap
>>>>     support"
>>>> * Replaced the word "secure" with "restricted" where applicable
>>>>
>>>> Etienne Carriere (1):
>>>>     tee: new ioctl to a register tee_shm from a dmabuf file descriptor
>>>>
>>>> Jens Wiklander (2):
>>>>     dma-buf: heaps: restricted_heap: add no_map attribute
>>>>     dma-buf: heaps: add Linaro restricted dmabuf heap support
>>>>
>>>> Olivier Masse (1):
>>>>     dt-bindings: reserved-memory: add linaro,restricted-heap
>>>>
>>>>    .../linaro,restricted-heap.yaml               |  56 ++++++
>>>>    drivers/dma-buf/heaps/Kconfig                 |  10 ++
>>>>    drivers/dma-buf/heaps/Makefile                |   1 +
>>>>    drivers/dma-buf/heaps/restricted_heap.c       |  17 +-
>>>>    drivers/dma-buf/heaps/restricted_heap.h       |   2 +
>>>>    .../dma-buf/heaps/restricted_heap_linaro.c    | 165 ++++++++++++++++++
>>>>    drivers/tee/tee_core.c                        |  38 ++++
>>>>    drivers/tee/tee_shm.c                         | 104 ++++++++++-
>>>>    include/linux/tee_drv.h                       |  11 ++
>>>>    include/uapi/linux/tee.h                      |  29 +++
>>>>    10 files changed, 426 insertions(+), 7 deletions(-)
>>>>    create mode 100644 Documentation/devicetree/bindings/reserved-memory/=
linaro,restricted-heap.yaml
>>>>    create mode 100644 drivers/dma-buf/heaps/restricted_heap_linaro.c
>>>>
>>>> --=20
>>>> 2.34.1
>>>>

--===============0881275445809158128==--

