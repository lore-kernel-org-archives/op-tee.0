From: David Hildenbrand <david@redhat.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v6 09/10] optee: FF-A: dynamic restricted memory allocation
Date: Wed, 09 Apr 2025 12:01:21 +0200
Message-ID: <561d6050-e24f-4643-806f-8a520e324d11@redhat.com>
In-Reply-To: <Z-u8MWNVNy9lLbkK@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1368752870835183724=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1368752870835183724==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 01.04.25 12:13, Sumit Garg wrote:
> + MM folks to seek guidance here.
>=20
> On Thu, Mar 27, 2025 at 09:07:34AM +0100, Jens Wiklander wrote:
>> Hi Sumit,
>>
>> On Tue, Mar 25, 2025 at 8:42=E2=80=AFAM Sumit Garg <sumit.garg@kernel.or=
g> wrote:
>>>
>>> On Wed, Mar 05, 2025 at 02:04:15PM +0100, Jens Wiklander wrote:
>>>> Add support in the OP-TEE backend driver dynamic restricted memory
>>>> allocation with FF-A.
>>>>
>>>> The restricted memory pools for dynamically allocated restrict memory
>>>> are instantiated when requested by user-space. This instantiation can
>>>> fail if OP-TEE doesn't support the requested use-case of restricted
>>>> memory.
>>>>
>>>> Restricted memory pools based on a static carveout or dynamic allocation
>>>> can coexist for different use-cases. We use only dynamic allocation with
>>>> FF-A.
>>>>
>>>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>>>> ---
>>>>   drivers/tee/optee/Makefile        |   1 +
>>>>   drivers/tee/optee/ffa_abi.c       | 143 ++++++++++++-
>>>>   drivers/tee/optee/optee_private.h |  13 +-
>>>>   drivers/tee/optee/rstmem.c        | 329 ++++++++++++++++++++++++++++++
>>>>   4 files changed, 483 insertions(+), 3 deletions(-)
>>>>   create mode 100644 drivers/tee/optee/rstmem.c
>>>>
>=20
> <snip>
>=20
>>>> diff --git a/drivers/tee/optee/rstmem.c b/drivers/tee/optee/rstmem.c
>>>> new file mode 100644
>>>> index 000000000000..ea27769934d4
>>>> --- /dev/null
>>>> +++ b/drivers/tee/optee/rstmem.c
>>>> @@ -0,0 +1,329 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (c) 2025, Linaro Limited
>>>> + */
>>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>> +
>>>> +#include <linux/errno.h>
>>>> +#include <linux/genalloc.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/string.h>
>>>> +#include <linux/tee_core.h>
>>>> +#include <linux/types.h>
>>>> +#include "optee_private.h"
>>>> +
>>>> +struct optee_rstmem_cma_pool {
>>>> +     struct tee_rstmem_pool pool;
>>>> +     struct gen_pool *gen_pool;
>>>> +     struct optee *optee;
>>>> +     size_t page_count;
>>>> +     u16 *end_points;
>>>> +     u_int end_point_count;
>>>> +     u_int align;
>>>> +     refcount_t refcount;
>>>> +     u32 use_case;
>>>> +     struct tee_shm *rstmem;
>>>> +     /* Protects when initializing and tearing down this struct */
>>>> +     struct mutex mutex;
>>>> +};
>>>> +
>>>> +static struct optee_rstmem_cma_pool *
>>>> +to_rstmem_cma_pool(struct tee_rstmem_pool *pool)
>>>> +{
>>>> +     return container_of(pool, struct optee_rstmem_cma_pool, pool);
>>>> +}
>>>> +
>>>> +static int init_cma_rstmem(struct optee_rstmem_cma_pool *rp)
>>>> +{
>>>> +     int rc;
>>>> +
>>>> +     rp->rstmem =3D tee_shm_alloc_cma_phys_mem(rp->optee->ctx, rp->page=
_count,
>>>> +                                             rp->align);
>>>> +     if (IS_ERR(rp->rstmem)) {
>>>> +             rc =3D PTR_ERR(rp->rstmem);
>>>> +             goto err_null_rstmem;
>>>> +     }
>>>> +
>>>> +     /*
>>>> +      * TODO unmap the memory range since the physical memory will
>>>> +      * become inaccesible after the lend_rstmem() call.
>>>> +      */
>>>
>>> What's your plan for this TODO? I think we need a CMA allocator here
>>> which can allocate un-mapped memory such that any cache speculation
>>> won't lead to CPU hangs once the memory restriction comes into picture.
>>
>> What happens is platform-specific. For some platforms, it might be
>> enough to avoid explicit access. Yes, a CMA allocator with unmapped
>> memory or where memory can be unmapped is one option.
>=20
> Did you get a chance to enable real memory protection on RockPi board?
> This will atleast ensure that mapped restricted memory without explicit
> access works fine. Since otherwise once people start to enable real
> memory restriction in OP-TEE, there can be chances of random hang ups
> due to cache speculation.
>=20
> MM folks,
>=20
> Basically what we are trying to achieve here is a "no-map" DT behaviour
> [1] which is rather dynamic in  nature. The use-case here is that a memory
> block allocated from CMA can be marked restricted at runtime where we
> would like the Linux not being able to directly or indirectly (cache
> speculation) access it. Once memory restriction use-case has been
> completed, the memory block can be marked as normal and freed for
> further CMA allocation.
>=20
> It will be apprciated if you can guide us regarding the appropriate APIs
> to use for un-mapping/mamping CMA allocations for this use-case.

Can we get some more information why that is even required, so we can=20
decide if that is even the right thing to do? :)

Who would mark the memory block as restricted and for which purpose?

In arch/powerpc/platforms/powernv/memtrace.c we have some arch-specific=20
code to remove the directmap after alloc_contig_pages(). See=20
memtrace_alloc_node(). But it's very arch-specific ...

--=20
Cheers,

David / dhildenb


--===============1368752870835183724==--

