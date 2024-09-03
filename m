From: "T.J. Mercier" <tjmercier@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 4/4] dma-buf: heaps: add Linaro restricted dmabuf heap support
Date: Tue, 03 Sep 2024 10:50:03 -0700
Message-ID: 
 <CABdmKX2KzswmiDY4oWw69_rPWs8d_Cqp7OXouSeMQaYX1SDSmw@mail.gmail.com>
In-Reply-To: <20240830070351.2855919-5-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7774412248911584787=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7774412248911584787==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 12:04=E2=80=AFAM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Add a Linaro restricted heap using the linaro,restricted-heap bindings
> implemented based on the generic restricted heap.
>
> The bindings defines a range of physical restricted memory. The heap
> manages this address range using genalloc. The allocated dma-buf file
> descriptor can later be registered with the TEE subsystem for later use
> via Trusted Applications in the secure world.
>
> Co-developed-by: Olivier Masse <olivier.masse@nxp.com>
> Signed-off-by: Olivier Masse <olivier.masse@nxp.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/dma-buf/heaps/Kconfig                 |  10 ++
>  drivers/dma-buf/heaps/Makefile                |   1 +
>  .../dma-buf/heaps/restricted_heap_linaro.c    | 165 ++++++++++++++++++
>  3 files changed, 176 insertions(+)
>  create mode 100644 drivers/dma-buf/heaps/restricted_heap_linaro.c
>
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> index 58903bc62ac8..82e2c5d09242 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -28,3 +28,13 @@ config DMABUF_HEAPS_RESTRICTED_MTK
>         help
>           Enable restricted dma-buf heaps for MediaTek platform. This heap =
is backed by
>           TEE client interfaces. If in doubt, say N.
> +
> +config DMABUF_HEAPS_RESTRICTED_LINARO
> +       bool "Linaro DMA-BUF Restricted Heap"
> +       depends on DMABUF_HEAPS_RESTRICTED
> +       help
> +         Choose this option to enable the Linaro restricted dma-buf heap.
> +         The restricted heap pools are defined according to the DT. Heaps
> +         are allocated in the pools using gen allocater.
> +         If in doubt, say N.
> +
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
> index 0028aa9d875f..66b2f67c47b5 100644
> --- a/drivers/dma-buf/heaps/Makefile
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -2,4 +2,5 @@
>  obj-$(CONFIG_DMABUF_HEAPS_CMA)         +=3D cma_heap.o
>  obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED)  +=3D restricted_heap.o
>  obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED_MTK)      +=3D restricted_heap_mtk.o
> +obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED_LINARO)   +=3D restricted_heap_linaro=
.o
>  obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)      +=3D system_heap.o
> diff --git a/drivers/dma-buf/heaps/restricted_heap_linaro.c b/drivers/dma-b=
uf/heaps/restricted_heap_linaro.c
> new file mode 100644
> index 000000000000..4b08ed514023
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/restricted_heap_linaro.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMABUF secure heap exporter
> + *
> + * Copyright 2021 NXP.
> + * Copyright 2024 Linaro Limited.
> + */
> +
> +#define pr_fmt(fmt)     "rheap_linaro: " fmt
> +
> +#include <linux/dma-buf.h>
> +#include <linux/err.h>
> +#include <linux/genalloc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +
> +#include "restricted_heap.h"
> +
> +#define MAX_HEAP_COUNT 2

Are multiple supported because of what Cyrille mentioned here about permissio=
ns?
https://lore.kernel.org/lkml/DBBPR04MB7514E006455AEA407041E4F788709(a)DBBPR04=
MB7514.eurprd04.prod.outlook.com/

So this is just some arbitrary limit? I'd prefer to have some sort of
documentation about this.


> +#define HEAP_NAME_LEN  32
> +
> +struct resmem_restricted {
> +       phys_addr_t base;
> +       phys_addr_t size;
> +
> +       char name[HEAP_NAME_LEN];
> +
> +       bool no_map;
> +};
> +
> +static struct resmem_restricted restricted_data[MAX_HEAP_COUNT] =3D {0};
> +static unsigned int restricted_data_count;
> +
> +static int linaro_restricted_memory_allocate(struct restricted_heap *heap,
> +                                            struct restricted_buffer *buf)
> +{
> +       struct gen_pool *pool =3D heap->priv_data;
> +       unsigned long pa;
> +       int ret;
> +
> +       buf->size =3D ALIGN(buf->size, PAGE_SIZE);
> +       pa =3D gen_pool_alloc(pool, buf->size);
> +       if (!pa)
> +               return -ENOMEM;
> +
> +       ret =3D sg_alloc_table(&buf->sg_table, 1, GFP_KERNEL);
> +       if (ret) {
> +               gen_pool_free(pool, pa, buf->size);
> +               return ret;
> +       }
> +
> +       sg_set_page(buf->sg_table.sgl, phys_to_page(pa), buf->size, 0);
> +
> +       return 0;
> +}
> +
> +static void linaro_restricted_memory_free(struct restricted_heap *heap,
> +                                         struct restricted_buffer *buf)
> +{
> +       struct gen_pool *pool =3D heap->priv_data;
> +       struct scatterlist *sg;
> +       unsigned int i;
> +
> +       for_each_sg(buf->sg_table.sgl, sg, buf->sg_table.nents, i)
> +               gen_pool_free(pool, page_to_phys(sg_page(sg)), sg->length);
> +       sg_free_table(&buf->sg_table);
> +}
> +
> +static const struct restricted_heap_ops linaro_restricted_heap_ops =3D {
> +       .alloc =3D linaro_restricted_memory_allocate,
> +       .free =3D linaro_restricted_memory_free,
> +};
> +
> +static int add_heap(struct resmem_restricted *mem)
> +{
> +       struct restricted_heap *heap;
> +       struct gen_pool *pool;
> +       int ret;
> +
> +       if (mem->base =3D=3D 0 || mem->size =3D=3D 0) {
> +               pr_err("restricted_data base or size is not correct\n");
> +               return -EINVAL;
> +       }
> +
> +       heap =3D kzalloc(sizeof(*heap), GFP_KERNEL);
> +       if (!heap)
> +               return -ENOMEM;
> +
> +       pool =3D gen_pool_create(PAGE_SHIFT, -1);
> +       if (!pool) {
> +               ret =3D -ENOMEM;
> +               goto err_free_heap;
> +       }
> +
> +       ret =3D gen_pool_add(pool, mem->base, mem->size, -1);
> +       if (ret)
> +               goto err_free_pool;
> +
> +       heap->no_map =3D mem->no_map;
> +       heap->priv_data =3D pool;
> +       heap->name =3D mem->name;
> +       heap->ops =3D &linaro_restricted_heap_ops;
> +
> +       ret =3D restricted_heap_add(heap);
> +       if (ret)
> +               goto err_free_pool;
> +
> +       return 0;
> +
> +err_free_pool:
> +       gen_pool_destroy(pool);
> +err_free_heap:
> +       kfree(heap);
> +
> +       return ret;
> +}
> +
> +static int __init rmem_restricted_heap_setup(struct reserved_mem *rmem)
> +{
> +       size_t len =3D HEAP_NAME_LEN;
> +       const char *s;
> +       bool no_map;
> +
> +       if (WARN_ONCE(restricted_data_count >=3D MAX_HEAP_COUNT,
> +                     "Cannot handle more than %u restricted heaps\n",
> +                     MAX_HEAP_COUNT))
> +               return -EINVAL;
> +
> +       no_map =3D of_get_flat_dt_prop(rmem->fdt_node, "no-map", NULL);
> +       s =3D strchr(rmem->name, '@');
> +       if (s)
> +               len =3D umin(s - rmem->name + 1, len);
> +
> +       restricted_data[restricted_data_count].base =3D rmem->base;
> +       restricted_data[restricted_data_count].size =3D rmem->size;
> +       restricted_data[restricted_data_count].no_map =3D no_map;
> +       strscpy(restricted_data[restricted_data_count].name, rmem->name, le=
n);
> +
> +       restricted_data_count++;
> +       return 0;
> +}
> +
> +RESERVEDMEM_OF_DECLARE(linaro_restricted_heap, "linaro,restricted-heap",
> +                      rmem_restricted_heap_setup);
> +
> +static int linaro_restricted_heap_init(void)
> +{
> +       unsigned int i;
> +       int ret;
> +
> +       for (i =3D 0; i < restricted_data_count; i++) {
> +               ret =3D add_heap(&restricted_data[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +       return 0;
> +}
> +
> +module_init(linaro_restricted_heap_init);
> +MODULE_DESCRIPTION("Linaro Restricted Heap Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>

--===============7774412248911584787==--

