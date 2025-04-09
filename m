From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v6 09/10] optee: FF-A: dynamic restricted memory allocation
Date: Wed, 09 Apr 2025 18:49:03 +0530
Message-ID: <Z_Zzx8ixuCs2Ste1@sumit-X1>
In-Reply-To: <561d6050-e24f-4643-806f-8a520e324d11@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6223010369438104288=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6223010369438104288==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks David for your response.

On Wed, Apr 09, 2025 at 12:01:21PM +0200, David Hildenbrand wrote:
> On 01.04.25 12:13, Sumit Garg wrote:
> > + MM folks to seek guidance here.
> >=20
> > On Thu, Mar 27, 2025 at 09:07:34AM +0100, Jens Wiklander wrote:
> > > Hi Sumit,
> > >=20
> > > On Tue, Mar 25, 2025 at 8:42=E2=80=AFAM Sumit Garg <sumit.garg@kernel=
.org> wrote:
> > > >=20
> > > > On Wed, Mar 05, 2025 at 02:04:15PM +0100, Jens Wiklander wrote:
> > > > > Add support in the OP-TEE backend driver dynamic restricted memory
> > > > > allocation with FF-A.
> > > > >=20
> > > > > The restricted memory pools for dynamically allocated restrict memo=
ry
> > > > > are instantiated when requested by user-space. This instantiation c=
an
> > > > > fail if OP-TEE doesn't support the requested use-case of restricted
> > > > > memory.
> > > > >=20
> > > > > Restricted memory pools based on a static carveout or dynamic alloc=
ation
> > > > > can coexist for different use-cases. We use only dynamic allocation=
 with
> > > > > FF-A.
> > > > >=20
> > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > ---
> > > > >   drivers/tee/optee/Makefile        |   1 +
> > > > >   drivers/tee/optee/ffa_abi.c       | 143 ++++++++++++-
> > > > >   drivers/tee/optee/optee_private.h |  13 +-
> > > > >   drivers/tee/optee/rstmem.c        | 329 +++++++++++++++++++++++++=
+++++
> > > > >   4 files changed, 483 insertions(+), 3 deletions(-)
> > > > >   create mode 100644 drivers/tee/optee/rstmem.c
> > > > >=20
> >=20
> > <snip>
> >=20
> > > > > diff --git a/drivers/tee/optee/rstmem.c b/drivers/tee/optee/rstmem.c
> > > > > new file mode 100644
> > > > > index 000000000000..ea27769934d4
> > > > > --- /dev/null
> > > > > +++ b/drivers/tee/optee/rstmem.c
> > > > > @@ -0,0 +1,329 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Copyright (c) 2025, Linaro Limited
> > > > > + */
> > > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > > +
> > > > > +#include <linux/errno.h>
> > > > > +#include <linux/genalloc.h>
> > > > > +#include <linux/slab.h>
> > > > > +#include <linux/string.h>
> > > > > +#include <linux/tee_core.h>
> > > > > +#include <linux/types.h>
> > > > > +#include "optee_private.h"
> > > > > +
> > > > > +struct optee_rstmem_cma_pool {
> > > > > +     struct tee_rstmem_pool pool;
> > > > > +     struct gen_pool *gen_pool;
> > > > > +     struct optee *optee;
> > > > > +     size_t page_count;
> > > > > +     u16 *end_points;
> > > > > +     u_int end_point_count;
> > > > > +     u_int align;
> > > > > +     refcount_t refcount;
> > > > > +     u32 use_case;
> > > > > +     struct tee_shm *rstmem;
> > > > > +     /* Protects when initializing and tearing down this struct */
> > > > > +     struct mutex mutex;
> > > > > +};
> > > > > +
> > > > > +static struct optee_rstmem_cma_pool *
> > > > > +to_rstmem_cma_pool(struct tee_rstmem_pool *pool)
> > > > > +{
> > > > > +     return container_of(pool, struct optee_rstmem_cma_pool, pool);
> > > > > +}
> > > > > +
> > > > > +static int init_cma_rstmem(struct optee_rstmem_cma_pool *rp)
> > > > > +{
> > > > > +     int rc;
> > > > > +
> > > > > +     rp->rstmem =3D tee_shm_alloc_cma_phys_mem(rp->optee->ctx, rp-=
>page_count,
> > > > > +                                             rp->align);
> > > > > +     if (IS_ERR(rp->rstmem)) {
> > > > > +             rc =3D PTR_ERR(rp->rstmem);
> > > > > +             goto err_null_rstmem;
> > > > > +     }
> > > > > +
> > > > > +     /*
> > > > > +      * TODO unmap the memory range since the physical memory will
> > > > > +      * become inaccesible after the lend_rstmem() call.
> > > > > +      */
> > > >=20
> > > > What's your plan for this TODO? I think we need a CMA allocator here
> > > > which can allocate un-mapped memory such that any cache speculation
> > > > won't lead to CPU hangs once the memory restriction comes into pictur=
e.
> > >=20
> > > What happens is platform-specific. For some platforms, it might be
> > > enough to avoid explicit access. Yes, a CMA allocator with unmapped
> > > memory or where memory can be unmapped is one option.
> >=20
> > Did you get a chance to enable real memory protection on RockPi board?
> > This will atleast ensure that mapped restricted memory without explicit
> > access works fine. Since otherwise once people start to enable real
> > memory restriction in OP-TEE, there can be chances of random hang ups
> > due to cache speculation.
> >=20
> > MM folks,
> >=20
> > Basically what we are trying to achieve here is a "no-map" DT behaviour
> > [1] which is rather dynamic in  nature. The use-case here is that a memory
> > block allocated from CMA can be marked restricted at runtime where we
> > would like the Linux not being able to directly or indirectly (cache
> > speculation) access it. Once memory restriction use-case has been
> > completed, the memory block can be marked as normal and freed for
> > further CMA allocation.
> >=20
> > It will be apprciated if you can guide us regarding the appropriate APIs
> > to use for un-mapping/mamping CMA allocations for this use-case.
>=20
> Can we get some more information why that is even required, so we can decide
> if that is even the right thing to do? :)

The main reason which I can see is for memory re-use. Although we should
be able to carve out memory during boot and then mark it restricted for
the entire boot cycle but without re-use. Especially for secure media
pipeline use-case where the video buffers can be sufficiently large
enough which will benefit from memory re-use.

>=20
> Who would mark the memory block as restricted and for which purpose?

It will be the higher privileged firmware/Trusted OS which can either be
the running on same CPU with higher privileges like Arm TrustZone or a
separate co-processor like AMD-TEE etc. The purpose is for secure media
pipeline, trusted UI or secure crypto use-cases where essentially the
motivation is that the Linux kernel shouldn't be able to access
decrypted content or key material in plain format but rather only the
allowed peripherals like media pipeline, crypto accelerators etc. able to
access them.

>=20
> In arch/powerpc/platforms/powernv/memtrace.c we have some arch-specific code
> to remove the directmap after alloc_contig_pages(). See
> memtrace_alloc_node(). But it's very arch-specific ...

Thanks for the reference, we are looking for something like that but
with generic code along with capability to remap when the restricted
memory block is freed and available for normal kernel usage.

-Sumit

--===============6223010369438104288==--

