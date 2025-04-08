From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v6 09/10] optee: FF-A: dynamic restricted memory allocation
Date: Tue, 08 Apr 2025 15:39:33 +0200
Message-ID: 
 <CAHUa44EV=q35i-anXkAF2N7mY8gmWqfMbU0YXARHHOas5iKxHw@mail.gmail.com>
In-Reply-To: <Z_TqTUpGhz1s-F8h@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3776355562830346690=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3776355562830346690==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 11:20=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Tue, Apr 01, 2025 at 02:26:59PM +0200, Jens Wiklander wrote:
> > On Tue, Apr 1, 2025 at 12:13=E2=80=AFPM Sumit Garg <sumit.garg@kernel.o=
rg> wrote:
> > >
> > > + MM folks to seek guidance here.
> > >
> > > On Thu, Mar 27, 2025 at 09:07:34AM +0100, Jens Wiklander wrote:
> > > > Hi Sumit,
> > > >
> > > > On Tue, Mar 25, 2025 at 8:42=E2=80=AFAM Sumit Garg <sumit.garg@kern=
el.org> wrote:
> > > > >
> > > > > On Wed, Mar 05, 2025 at 02:04:15PM +0100, Jens Wiklander wrote:
> > > > > > Add support in the OP-TEE backend driver dynamic restricted memory
> > > > > > allocation with FF-A.
> > > > > >
> > > > > > The restricted memory pools for dynamically allocated restrict me=
mory
> > > > > > are instantiated when requested by user-space. This instantiation=
 can
> > > > > > fail if OP-TEE doesn't support the requested use-case of restrict=
ed
> > > > > > memory.
> > > > > >
> > > > > > Restricted memory pools based on a static carveout or dynamic all=
ocation
> > > > > > can coexist for different use-cases. We use only dynamic allocati=
on with
> > > > > > FF-A.
> > > > > >
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > ---
> > > > > >  drivers/tee/optee/Makefile        |   1 +
> > > > > >  drivers/tee/optee/ffa_abi.c       | 143 ++++++++++++-
> > > > > >  drivers/tee/optee/optee_private.h |  13 +-
> > > > > >  drivers/tee/optee/rstmem.c        | 329 ++++++++++++++++++++++++=
++++++
> > > > > >  4 files changed, 483 insertions(+), 3 deletions(-)
> > > > > >  create mode 100644 drivers/tee/optee/rstmem.c
> > > > > >
> > >
> > > <snip>
> > >
> > > > > > diff --git a/drivers/tee/optee/rstmem.c b/drivers/tee/optee/rstme=
m.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..ea27769934d4
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/tee/optee/rstmem.c
> > > > > > @@ -0,0 +1,329 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +/*
> > > > > > + * Copyright (c) 2025, Linaro Limited
> > > > > > + */
> > > > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > > > +
> > > > > > +#include <linux/errno.h>
> > > > > > +#include <linux/genalloc.h>
> > > > > > +#include <linux/slab.h>
> > > > > > +#include <linux/string.h>
> > > > > > +#include <linux/tee_core.h>
> > > > > > +#include <linux/types.h>
> > > > > > +#include "optee_private.h"
> > > > > > +
> > > > > > +struct optee_rstmem_cma_pool {
> > > > > > +     struct tee_rstmem_pool pool;
> > > > > > +     struct gen_pool *gen_pool;
> > > > > > +     struct optee *optee;
> > > > > > +     size_t page_count;
> > > > > > +     u16 *end_points;
> > > > > > +     u_int end_point_count;
> > > > > > +     u_int align;
> > > > > > +     refcount_t refcount;
> > > > > > +     u32 use_case;
> > > > > > +     struct tee_shm *rstmem;
> > > > > > +     /* Protects when initializing and tearing down this struct =
*/
> > > > > > +     struct mutex mutex;
> > > > > > +};
> > > > > > +
> > > > > > +static struct optee_rstmem_cma_pool *
> > > > > > +to_rstmem_cma_pool(struct tee_rstmem_pool *pool)
> > > > > > +{
> > > > > > +     return container_of(pool, struct optee_rstmem_cma_pool, poo=
l);
> > > > > > +}
> > > > > > +
> > > > > > +static int init_cma_rstmem(struct optee_rstmem_cma_pool *rp)
> > > > > > +{
> > > > > > +     int rc;
> > > > > > +
> > > > > > +     rp->rstmem =3D tee_shm_alloc_cma_phys_mem(rp->optee->ctx, r=
p->page_count,
> > > > > > +                                             rp->align);
> > > > > > +     if (IS_ERR(rp->rstmem)) {
> > > > > > +             rc =3D PTR_ERR(rp->rstmem);
> > > > > > +             goto err_null_rstmem;
> > > > > > +     }
> > > > > > +
> > > > > > +     /*
> > > > > > +      * TODO unmap the memory range since the physical memory wi=
ll
> > > > > > +      * become inaccesible after the lend_rstmem() call.
> > > > > > +      */
> > > > >
> > > > > What's your plan for this TODO? I think we need a CMA allocator here
> > > > > which can allocate un-mapped memory such that any cache speculation
> > > > > won't lead to CPU hangs once the memory restriction comes into pict=
ure.
> > > >
> > > > What happens is platform-specific. For some platforms, it might be
> > > > enough to avoid explicit access. Yes, a CMA allocator with unmapped
> > > > memory or where memory can be unmapped is one option.
> > >
> > > Did you get a chance to enable real memory protection on RockPi board?
> >
> > No, I don't think I have access to the needed documentation for the
> > board to set it up for relevant peripherals.
> >
> > > This will atleast ensure that mapped restricted memory without explicit
> > > access works fine. Since otherwise once people start to enable real
> > > memory restriction in OP-TEE, there can be chances of random hang ups
> > > due to cache speculation.
> >
> > A hypervisor in the normal world can also make the memory inaccessible
> > to the kernel. That shouldn't cause any hangups due to cache
> > speculation.
>
> The hypervisor should unmap the memory from EL2 translation tables which
> I think should disallow the cache speculation to take place. However,
> without hypervisor here the memory remains mapped in normal world which
> can lead to cache speculation for restricted buffers. That's why we
> should atleast test on one platform with real memory protection enabled
> to rule out any assumptions we make.

Do I hear a volunteer? ;-)

Anyway, this isn't something that can be enabled in the kernel alone.
Only platforms where the firmware has been updated will be affected.
If this can't be supported on a particular platform, there's still the
option with a static carveout.

Cheers,
Jens

>
> -Sumit
>
> >
> > Cheers,
> > Jens
> >
> > >
> > > MM folks,
> > >
> > > Basically what we are trying to achieve here is a "no-map" DT behaviour
> > > [1] which is rather dynamic in  nature. The use-case here is that a mem=
ory
> > > block allocated from CMA can be marked restricted at runtime where we
> > > would like the Linux not being able to directly or indirectly (cache
> > > speculation) access it. Once memory restriction use-case has been
> > > completed, the memory block can be marked as normal and freed for
> > > further CMA allocation.
> > >
> > > It will be apprciated if you can guide us regarding the appropriate APIs
> > > to use for un-mapping/mamping CMA allocations for this use-case.
> > >
> > > [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/sche=
mas/reserved-memory/reserved-memory.yaml#L79
> > >
> > > -Sumit

--===============3776355562830346690==--

