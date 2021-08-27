From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 4/5] optee: isolate smc abi
Date: Fri, 27 Aug 2021 09:18:22 +0200
Message-ID: <20210827071822.GA1748471@jade>
In-Reply-To: <
 <CAFA6WYOZsZKfG0ZO8LGMcvQG8-pV0Z=hGF2nDFg7OW2DQO0esw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6797121924678230883=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6797121924678230883==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 05:11:00PM +0530, Sumit Garg wrote:
> On Thu, 19 Aug 2021 at 16:37, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Isolate the ABI based on raw SMCs. Code specific to the raw SMC ABI is
> > moved into smc_abi.c. This makes room for other ABIs with a clear
> > separation.
> >
> > The driver changes to use module_init()/module_exit() instead of
> > module_platform_driver(). The platform_driver_register() and
> > platform_driver_unregister() functions called directly to keep the same
> > behavior. This is needed because module_platform_driver() is based on
> > module_driver() which can only be used once in a module.
> >
> > A function optee_rpc_cmd() is factored out from the function
> > handle_rpc_func_cmd() to handle the ABI independent part of RPC
> > processing.
> >
> > This patch is not supposed to change the driver behavior, it's only a
> > matter of reorganizing the code.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/Makefile        |    6 +-
> >  drivers/tee/optee/call.c          |  339 +-------
> >  drivers/tee/optee/core.c          |  688 +--------------
> >  drivers/tee/optee/optee_private.h |  103 ++-
> >  drivers/tee/optee/rpc.c           |  217 +----
> >  drivers/tee/optee/shm_pool.c      |   89 --
> >  drivers/tee/optee/shm_pool.h      |   14 -
> >  drivers/tee/optee/smc_abi.c       | 1299 +++++++++++++++++++++++++++++
> >  8 files changed, 1439 insertions(+), 1316 deletions(-)
> >  delete mode 100644 drivers/tee/optee/shm_pool.c
> >  delete mode 100644 drivers/tee/optee/shm_pool.h
> >  create mode 100644 drivers/tee/optee/smc_abi.c
> >
>=20
> Apart from minor comments below including one related to rebase, this
> looks good to me. So feel free to add:
>=20
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>=20
> > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > index 3aa33ea9e6a6..e92f77462f40 100644
> > --- a/drivers/tee/optee/Makefile
> > +++ b/drivers/tee/optee/Makefile
> > @@ -4,8 +4,10 @@ optee-objs +=3D core.o
> >  optee-objs +=3D call.o
> >  optee-objs +=3D rpc.o
> >  optee-objs +=3D supp.o
> > -optee-objs +=3D shm_pool.o
> >  optee-objs +=3D device.o
> >
> > +optee-smc-abi-y =3D smc_abi.o
> > +optee-objs +=3D $(optee-ffa-abi-y)
>=20
> Did you mean optee-smc-abi-y here?

Yes, I'll fix, thanks.

[snip]
> > index d767eebf30bd..000000000000
> > --- a/drivers/tee/optee/shm_pool.c
> > +++ /dev/null
> > @@ -1,89 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -/*
> > - * Copyright (c) 2015, Linaro Limited
> > - * Copyright (c) 2017, EPAM Systems
> > - */
> > -#include <linux/device.h>
> > -#include <linux/dma-buf.h>
> > -#include <linux/genalloc.h>
> > -#include <linux/slab.h>
> > -#include <linux/tee_drv.h>
> > -#include "optee_private.h"
> > -#include "optee_smc.h"
> > -#include "shm_pool.h"
> > -
> > -static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > -                        struct tee_shm *shm, size_t size)
> > -{
> > -       unsigned int order =3D get_order(size);
> > -       struct page *page;
> > -       int rc =3D 0;
> > -
> > -       page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> > -       if (!page)
> > -               return -ENOMEM;
> > -
> > -       shm->kaddr =3D page_address(page);
> > -       shm->paddr =3D page_to_phys(page);
> > -       shm->size =3D PAGE_SIZE << order;
> > -
> > -       if (shm->flags & TEE_SHM_DMA_BUF) {
>=20
> I guess this series needs to be rebased on top of mainline, since now
> we have TEE_SHM_PRIV flag here [1]?
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/tee/optee/shm_pool.c

Right, I'll take care of that in the next patchset.

[snip]
> > --- /dev/null
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -0,0 +1,1299 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2015-2021, Linaro Limited
> > + * Copyright (c) 2016, EPAM Systems
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/arm-smccc.h>
> > +#include <linux/errno.h>
> > +#include <linux/io.h>
> > +#include <linux/sched.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/tee_drv.h>
> > +#include <linux/types.h>
> > +#include <linux/workqueue.h>
> > +#include "optee_private.h"
> > +#include "optee_smc.h"
> > +#include "optee_rpc_cmd.h"
> > +#define CREATE_TRACE_POINTS
> > +#include "optee_trace.h"
> > +
> > +/*
> > + * This file implement the SMC ABI used when communicating with secure w=
orld
> > + * OP-TEE OS via raw SMCs.
> > + * This file is divided into the follow sections:
>=20
> s/follow/following/

I'll fix.

Thanks,
Jens

--===============6797121924678230883==--

