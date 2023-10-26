From: Tom Lendacky <thomas.lendacky@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 0/3] Introduce DMA APIs to allocate and free TEE shared memory
Date: Thu, 26 Oct 2023 09:53:50 -0500
Message-ID: <b743d759-8f6b-b4f8-afc6-d8f11a5562ff@amd.com>
In-Reply-To: <4a261870-03e0-49f8-b968-4cbcf646d9eb@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5424691094382104843=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5424691094382104843==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 10/26/23 05:30, NK, JESHWANTHKUMAR wrote:
>=20
> On 25-Oct-23 7:01 PM, Sumit Garg wrote:
>> Hi Jeshwank,
>>
>> On Wed, 25 Oct 2023 at 12:27, jeshwank <JESHWANTHKUMAR.NK@amd.com> wrote:
>>> From: Jeshwanth Kumar N K <JESHWANTHKUMAR.NK@amd.com>
>>>
>>> At present, the shared memory for TEE ring buffer, command buffer and
>>> data buffer is allocated using get_free_pages(). The driver shares the
>>> physical address of these buffers with PSP so that it can be mapped by
>>> the Trusted OS.
>>>
>>> In this patch series we have replaced get_free_pages() with
>>> dma_alloc_coherent() to allocate shared memory to cleanup the existing
>>> allocation method.
>> Thanks for putting this together but I can't find the reasoning behind
>> this change neither in this commit message and nor in the patch
>> descriptions. Care to explain why?
>>
>> -Sumit
> Hi Sumit,
>=20
> We see that there is an advantage in using dma_alloc_coherent() over=20
> get_free_pages(). The dma-ops associated with PSP PCIe device can be=20
> overridden. This capability will be helpful when we enable virtualization=20
> support. We plan to post a virtualization related patch in future.

To be specific, you are referring to Xen virtualization support, correct?=20
Because I don't see how this works in a Qemu/KVM environment where you=20
would get a GPA and not an SPA.

If that is the case, you should clearly specify that. Also, this looks=20
like it should be introduced with the virtualization support that you=20
submit in the future and not before.

Thanks,
Tom

>=20
> Regards,
>=20
> Jeshwanth
>=20
>>
>>> Rijo Thomas (3):
>>> =C2=A0=C2=A0 crypto: ccp - Add function to allocate and free memory using=
 DMA APIs
>>> =C2=A0=C2=A0 crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_bu=
ffer()
>>> =C2=A0=C2=A0 tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buf=
fer()
>>>
>>> =C2=A0 drivers/crypto/ccp/psp-dev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 3 +
>>> =C2=A0 drivers/crypto/ccp/tee-dev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 119 ++++++++++++++++++----------
>>> =C2=A0 drivers/crypto/ccp/tee-dev.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 11 +--
>>> =C2=A0 drivers/tee/amdtee/amdtee_private.h |=C2=A0 18 ++---
>>> =C2=A0 drivers/tee/amdtee/call.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 74 ++++++++---------
>>> =C2=A0 drivers/tee/amdtee/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 72 ++++++++++-------
>>> =C2=A0 drivers/tee/amdtee/shm_pool.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 21 ++---
>>> =C2=A0 include/linux/psp-tee.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 47 +++++++++++
>>> =C2=A0 8 files changed, 221 insertions(+), 144 deletions(-)
>>>
>>> --=20
>>> 2.25.1
>>>

--===============5424691094382104843==--

