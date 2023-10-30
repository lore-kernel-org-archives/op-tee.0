From: "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 0/3] Introduce DMA APIs to allocate and free TEE shared memory
Date: Mon, 30 Oct 2023 11:51:06 +0530
Message-ID: <f21143fb-91d2-4186-938e-0d147e32aa76@amd.com>
In-Reply-To: <b743d759-8f6b-b4f8-afc6-d8f11a5562ff@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6330158657995041623=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6330158657995041623==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Tom,

On 26-Oct-23 8:23 PM, Tom Lendacky wrote:
> On 10/26/23 05:30, NK, JESHWANTHKUMAR wrote:
>>
>> On 25-Oct-23 7:01 PM, Sumit Garg wrote:
>>> Hi Jeshwank,
>>>
>>> On Wed, 25 Oct 2023 at 12:27, jeshwank <JESHWANTHKUMAR.NK@amd.com> 
>>> wrote:
>>>> From: Jeshwanth Kumar N K <JESHWANTHKUMAR.NK@amd.com>
>>>>
>>>> At present, the shared memory for TEE ring buffer, command buffer and
>>>> data buffer is allocated using get_free_pages(). The driver shares the
>>>> physical address of these buffers with PSP so that it can be mapped by
>>>> the Trusted OS.
>>>>
>>>> In this patch series we have replaced get_free_pages() with
>>>> dma_alloc_coherent() to allocate shared memory to cleanup the existing
>>>> allocation method.
>>> Thanks for putting this together but I can't find the reasoning behind
>>> this change neither in this commit message and nor in the patch
>>> descriptions. Care to explain why?
>>>
>>> -Sumit
>> Hi Sumit,
>>
>> We see that there is an advantage in using dma_alloc_coherent() over 
>> get_free_pages(). The dma-ops associated with PSP PCIe device can be 
>> overridden. This capability will be helpful when we enable 
>> virtualization support. We plan to post a virtualization related 
>> patch in future.
>
> To be specific, you are referring to Xen virtualization support, 
> correct? Because I don't see how this works in a Qemu/KVM environment 
> where you would get a GPA and not an SPA.

The patch is not specific to Xen. We have verified it in Qemu/KVM and 
Xen PV mode. Support for Xen PVH mode will be added as a separate patch.

>
> If that is the case, you should clearly specify that. Also, this looks 
> like it should be introduced with the virtualization support that you 
> submit in the future and not before.

I will update the commit message in the next version of the patch series 
to include these details.

> Thanks,
> Tom
>
>>
>> Regards,
>>
>> Jeshwanth
>>
>>>
>>>> Rijo Thomas (3):
>>>>    crypto: ccp - Add function to allocate and free memory using DMA 
>>>> APIs
>>>>    crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>>>>    tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>>>>
>>>>   drivers/crypto/ccp/psp-dev.c        |   3 +
>>>>   drivers/crypto/ccp/tee-dev.c        | 119 
>>>> ++++++++++++++++++----------
>>>>   drivers/crypto/ccp/tee-dev.h        |  11 +--
>>>>   drivers/tee/amdtee/amdtee_private.h |  18 ++---
>>>>   drivers/tee/amdtee/call.c           |  74 ++++++++---------
>>>>   drivers/tee/amdtee/core.c           |  72 ++++++++++-------
>>>>   drivers/tee/amdtee/shm_pool.c       |  21 ++---
>>>>   include/linux/psp-tee.h             |  47 +++++++++++
>>>>   8 files changed, 221 insertions(+), 144 deletions(-)
>>>>
>>>> -- 
>>>> 2.25.1
>>>>

--===============6330158657995041623==--

