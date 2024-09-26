From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Linaro-mm-sig] Re: [RFC PATCH 0/4] Linaro restricted heap
Date: Thu, 26 Sep 2024 19:17:05 +0530
Message-ID: <2f9a4abe-b2fc-4bc7-9926-1da2d38f5080@linaro.org>
In-Reply-To: <04caa788-19a6-4336-985c-4eb191c24438@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5604655202753594244=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5604655202753594244==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 9/25/24 19:31, Christian K=C3=B6nig wrote:
> Am 25.09.24 um 14:51 schrieb Dmitry Baryshkov:
>> On Wed, Sep 25, 2024 at 10:51:15AM GMT, Christian K=C3=B6nig wrote:
>>> Am 25.09.24 um 01:05 schrieb Dmitry Baryshkov:
>>>> On Tue, Sep 24, 2024 at 01:13:18PM GMT, Andrew Davis wrote:
>>>>> On 9/23/24 1:33 AM, Dmitry Baryshkov wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, Aug 30, 2024 at 09:03:47AM GMT, Jens Wiklander wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> This patch set is based on top of Yong Wu's restricted heap patch set=
 [1].
>>>>>>> It's also a continuation on Olivier's Add dma-buf secure-heap patch s=
et [2].
>>>>>>>
>>>>>>> The Linaro restricted heap uses genalloc in the kernel to manage the =
heap
>>>>>>> carvout. This is a difference from the Mediatek restricted heap which
>>>>>>> relies on the secure world to manage the carveout.
>>>>>>>
>>>>>>> I've tried to adress the comments on [2], but [1] introduces changes =
so I'm
>>>>>>> afraid I've had to skip some comments.
>>>>>> I know I have raised the same question during LPC (in connection to
>>>>>> Qualcomm's dma-heap implementation). Is there any reason why we are
>>>>>> using generic heaps instead of allocating the dma-bufs on the device
>>>>>> side?
>>>>>>
>>>>>> In your case you already have TEE device, you can use it to allocate a=
nd
>>>>>> export dma-bufs, which then get imported by the V4L and DRM drivers.
>>>>>>
>>>>> This goes to the heart of why we have dma-heaps in the first place.
>>>>> We don't want to burden userspace with having to figure out the right
>>>>> place to get a dma-buf for a given use-case on a given hardware.
>>>>> That would be very non-portable, and fail at the core purpose of
>>>>> a kernel: to abstract hardware specifics away.
>>>> Unfortunately all proposals to use dma-buf heaps were moving in the
>>>> described direction: let app select (somehow) from a platform- and
>>>> vendor- specific list of dma-buf heaps. In the kernel we at least know
>>>> the platform on which the system is running. Userspace generally doesn't
>>>> (and shouldn't). As such, it seems better to me to keep the knowledge in
>>>> the kernel and allow userspace do its job by calling into existing
>>>> device drivers.
>>> The idea of letting the kernel fully abstract away the complexity of inter
>>> device data exchange is a completely failed design. There has been plenty=
 of
>>> evidence for that over the years.
>>>
>>> Because of this in DMA-buf it's an intentional design decision that
>>> userspace and *not* the kernel decides where and what to allocate from.
>> Hmm, ok.
>>
>>> What the kernel should provide are the necessary information what type of
>>> memory a device can work with and if certain memory is accessible or not.
>>> This is the part which is unfortunately still not well defined nor
>>> implemented at the moment.
>>>
>>> Apart from that there are a whole bunch of intentional design decision wh=
ich
>>> should prevent developers to move allocation decision inside the kernel. =
For
>>> example DMA-buf doesn't know what the content of the buffer is (except for
>>> it's total size) and which use cases a buffer will be used with.
>>>
>>> So the question if memory should be exposed through DMA-heaps or a driver
>>> specific allocator is not a question of abstraction, but rather one of the
>>> physical location and accessibility of the memory.
>>>
>>> If the memory is attached to any physical device, e.g. local memory on a
>>> dGPU, FPGA PCIe BAR, RDMA, camera internal memory etc, then expose the
>>> memory as device specific allocator.
>> So, for embedded systems with unified memory all buffers (maybe except
>> PCIe BARs) should come from DMA-BUF heaps, correct?
>
> From what I know that is correct, yes. Question is really if that will=20
> stay this way.
>
> Neural accelerators look a lot stripped down FPGAs these days and the=20
> benefit of local memory for GPUs is known for decades.
>
> Could be that designs with local specialized memory see a revival any=20
> time, who knows.
>
>>> If the memory is not physically attached to any device, but rather just
>>> memory attached to the CPU or a system wide memory controller then expose
>>> the memory as DMA-heap with specific requirements (e.g. certain sized pag=
es,
>>> contiguous, restricted, encrypted, ...).
>> Is encrypted / protected a part of the allocation contract or should it
>> be enforced separately via a call to TEE / SCM / anything else?
>
> Well that is a really good question I can't fully answer either. From=20
> what I know now I would say it depends on the design.
>
IMHO, I think Dmitry's proposal to rather allow TEE device being=20
allocator and exporter of DMA-bufs related to restricted memory makes=20
sense to me. Since it's really the TEE implementation (OP-TEE, AMD-TEE,=20
TS-TEE or future QTEE) which sets up the restrictions on a particular=20
piece of=C2=A0allocated memory. AFAIK, that happens after the DMA-buf gets=20
allocated and then user-space calls into TEE to setup which media=20
pipeline is going to access that particular DMA-buf. It can also be a=20
static contract depending on a particular platform design.

As Jens noted in the other thread, we already manage shared memory=20
allocations (from a static carve-out or dynamically mapped) for=20
communications among Linux and TEE that were based on DMA-bufs earlier=20
but since we didn't required them to be shared with other devices, so we=20
rather switched to anonymous memory.

 From user-space perspective, it's cleaner to use TEE device IOCTLs for=20
DMA-buf allocations since it already know to which underlying TEE=20
implementation it's communicating with rather than first figuring out=20
which DMA heap to use for allocation and then communicating with TEE=20
implementation.

-Sumit

--===============5604655202753594244==--

