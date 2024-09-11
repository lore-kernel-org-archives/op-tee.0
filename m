From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 4/4] dma-buf: heaps: add Linaro restricted dmabuf heap support
Date: Wed, 11 Sep 2024 07:58:36 +0200
Message-ID: 
 <CAHUa44G9j4rOZHX+XCQyM+mkru12Hy01iyj=USHHiD0raTDfZA@mail.gmail.com>
In-Reply-To: <
 <CABdmKX2Tsp-KG6_Lth7VUcZcxCfgbsBYqZ5N2h574J+sNP2SxA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3325730656589658071=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3325730656589658071==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:08=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Mon, Sep 9, 2024 at 11:06=E2=80=AFPM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > On Wed, Sep 4, 2024 at 11:42=E2=80=AFPM T.J. Mercier <tjmercier@google.=
com> wrote:
> > >
> > > On Wed, Sep 4, 2024 at 2:44=E2=80=AFAM Jens Wiklander <jens.wiklander(a=
)linaro.org> wrote:
> > > >
> > > > On Tue, Sep 3, 2024 at 7:50=E2=80=AFPM T.J. Mercier <tjmercier@goog=
le.com> wrote:
> > > > >
> > > > > On Fri, Aug 30, 2024 at 12:04=E2=80=AFAM Jens Wiklander
> > > > > <jens.wiklander@linaro.org> wrote:
> > > > > >
> > > > > > Add a Linaro restricted heap using the linaro,restricted-heap bin=
dings
> > > > > > implemented based on the generic restricted heap.
> > > > > >
> > > > > > The bindings defines a range of physical restricted memory. The h=
eap
> > > > > > manages this address range using genalloc. The allocated dma-buf =
file
> > > > > > descriptor can later be registered with the TEE subsystem for lat=
er use
> > > > > > via Trusted Applications in the secure world.
> > > > > >
> > > > > > Co-developed-by: Olivier Masse <olivier.masse@nxp.com>
> > > > > > Signed-off-by: Olivier Masse <olivier.masse@nxp.com>
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > ---
> > > > > >  drivers/dma-buf/heaps/Kconfig                 |  10 ++
> > > > > >  drivers/dma-buf/heaps/Makefile                |   1 +
> > > > > >  .../dma-buf/heaps/restricted_heap_linaro.c    | 165 ++++++++++++=
++++++
> > > > > >  3 files changed, 176 insertions(+)
> > > > > >  create mode 100644 drivers/dma-buf/heaps/restricted_heap_linaro.c
> > > > > >
> > > > > > diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heap=
s/Kconfig
> > > > > > index 58903bc62ac8..82e2c5d09242 100644
> > > > > > --- a/drivers/dma-buf/heaps/Kconfig
> > > > > > +++ b/drivers/dma-buf/heaps/Kconfig
> > > > > > @@ -28,3 +28,13 @@ config DMABUF_HEAPS_RESTRICTED_MTK
> > > > > >         help
> > > > > >           Enable restricted dma-buf heaps for MediaTek platform. =
This heap is backed by
> > > > > >           TEE client interfaces. If in doubt, say N.
> > > > > > +
> > > > > > +config DMABUF_HEAPS_RESTRICTED_LINARO
> > > > > > +       bool "Linaro DMA-BUF Restricted Heap"
> > > > > > +       depends on DMABUF_HEAPS_RESTRICTED
> > > > > > +       help
> > > > > > +         Choose this option to enable the Linaro restricted dma-=
buf heap.
> > > > > > +         The restricted heap pools are defined according to the =
DT. Heaps
> > > > > > +         are allocated in the pools using gen allocater.
> > > > > > +         If in doubt, say N.
> > > > > > +
> > > > > > diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/hea=
ps/Makefile
> > > > > > index 0028aa9d875f..66b2f67c47b5 100644
> > > > > > --- a/drivers/dma-buf/heaps/Makefile
> > > > > > +++ b/drivers/dma-buf/heaps/Makefile
> > > > > > @@ -2,4 +2,5 @@
> > > > > >  obj-$(CONFIG_DMABUF_HEAPS_CMA)         +=3D cma_heap.o
> > > > > >  obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED)  +=3D restricted_heap.o
> > > > > >  obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED_MTK)      +=3D restricted_h=
eap_mtk.o
> > > > > > +obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED_LINARO)   +=3D restricted_h=
eap_linaro.o
> > > > > >  obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)      +=3D system_heap.o
> > > > > > diff --git a/drivers/dma-buf/heaps/restricted_heap_linaro.c b/dri=
vers/dma-buf/heaps/restricted_heap_linaro.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..4b08ed514023
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/dma-buf/heaps/restricted_heap_linaro.c
> > > > > > @@ -0,0 +1,165 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * DMABUF secure heap exporter
> > > > > > + *
> > > > > > + * Copyright 2021 NXP.
> > > > > > + * Copyright 2024 Linaro Limited.
> > > > > > + */
> > > > > > +
> > > > > > +#define pr_fmt(fmt)     "rheap_linaro: " fmt
> > > > > > +
> > > > > > +#include <linux/dma-buf.h>
> > > > > > +#include <linux/err.h>
> > > > > > +#include <linux/genalloc.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/of.h>
> > > > > > +#include <linux/of_fdt.h>
> > > > > > +#include <linux/of_reserved_mem.h>
> > > > > > +#include <linux/scatterlist.h>
> > > > > > +#include <linux/slab.h>
> > > > > > +
> > > > > > +#include "restricted_heap.h"
> > > > > > +
> > > > > > +#define MAX_HEAP_COUNT 2
> > > > >
> > > > > Are multiple supported because of what Cyrille mentioned here about=
 permissions?
> > > > > https://lore.kernel.org/lkml/DBBPR04MB7514E006455AEA407041E4F788709=
(a)DBBPR04MB7514.eurprd04.prod.outlook.com/
> > > >
> > > > Yes, I kept that as is.
> > >
> > > Ok thanks.
> > >
> > > > > So this is just some arbitrary limit? I'd prefer to have some sort =
of
> > > > > documentation about this.
> > > >
> > > > How about removing the limit and using dynamic allocation instead?
> > >
> > > That works too!
> >
> > It turns out that was easier said than done. The limit is hardcoded
> > because dynamic memory allocation isn't available at that stage during
> > boot. We have a short description of this heap in Kconfig. I'll add
> > something about the limit there if that makes sense.
> >
> > Thanks,
> > Jens
>
> Ah ok sounds good.
>
> I noticed one other thing, linaro_restricted_heap_init and add_heap
> should probably have __init. Last week I sent a patch to add that for
> the CMA and system heaps.

Thanks, I'll add it.

Cheers,
Jens

--===============3325730656589658071==--

