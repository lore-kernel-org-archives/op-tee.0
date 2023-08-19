From: Alexey Kardashevskiy <aik@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Date: Sat, 19 Aug 2023 20:33:47 +1000
Message-ID: <cd226133-ed18-101b-6401-a6dcd89a1db8@amd.com>
In-Reply-To: <=?utf-8?q?=3C7531423fcb3b18ff78737ae5eabc84b0e3cb2909=2E1692369?=
 =?utf-8?q?704=2Egit=2EDevaraj=2ERangasamy=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5125331354783431590=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5125331354783431590==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/8/23 00:42, Devaraj Rangasamy wrote:
> In systems with low memory configuration, memory gets fragmented
> easily, and any bigger size contiguous memory allocations are likely
> to fail.
> Contiguous Memory Allocator (CMA) is used to overcome this
> limitation, and to guarantee memory allocations.
>=20
> This patch adds support for CMA area exclusive to amdtee.
> The support can be enabled if kernel have CONFIG_CMA enabled.
> The size can be set via the AMDTEE_CMA_SIZE config option
> at compile time or with the "amdtee_cma" kernel parameter.
> (e.g. "amdtee_cma=3D32 for 32MB").
>=20
> Also, cma zone is utilized only for buffer allocation bigger than
> 64k bytes. When such allocation fails, there is a fallback to the
> buddy allocator. Since CMA requires a boot time initialization,
> it is enabled only when amdtee is built as an inbuilt driver.
>=20
> Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> Co-developed-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
> Signed-off-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
> Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  7 ++
>   arch/x86/include/asm/setup.h                  |  6 ++
>   arch/x86/kernel/setup.c                       |  2 +
>   drivers/tee/amdtee/Kconfig                    |  9 +++
>   drivers/tee/amdtee/Makefile                   |  1 +
>   drivers/tee/amdtee/amdtee_private.h           |  6 +-
>   drivers/tee/amdtee/core.c                     |  6 +-
>   drivers/tee/amdtee/shm_pool.c                 | 32 ++++++--
>   drivers/tee/amdtee/shm_pool_cma.c             | 78 +++++++++++++++++++
>   drivers/tee/amdtee/shm_pool_cma.h             | 38 +++++++++
>   10 files changed, 176 insertions(+), 9 deletions(-)
>   create mode 100644 drivers/tee/amdtee/shm_pool_cma.c
>   create mode 100644 drivers/tee/amdtee/shm_pool_cma.h
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
> index 722b6eca2e93..5e38423f3d53 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -363,6 +363,13 @@
>   			  selects a performance level in this range and appropriate
>   			  to the current workload.
>  =20
> +	amdtee_cma=3Dnn	[HW,TEE]
> +			Sets the memory size reserved for contiguous memory
> +			allocations, to be used by amdtee device driver.
> +			Value is in MB and can range from 4 to 128 (MBs)
> +			CMA will be active only when CMA is enabled, and amdtee is
> +			built as inbuilt driver, and not loaded as module.
> +
>   	amijoy.map=3D	[HW,JOY] Amiga joystick support
>   			Map of devices attached to JOY0DAT and JOY1DAT
>   			Format: <a>,<b>
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index f3495623ac99..bb5e4b7134a2 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -66,6 +66,12 @@ extern void x86_ce4100_early_setup(void);
>   static inline void x86_ce4100_early_setup(void) { }
>   #endif
>  =20
> +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
> +void amdtee_cma_reserve(void);
> +#else
> +static inline void amdtee_cma_reserve(void) { }
> +#endif
> +
>   #ifndef _SETUP
>  =20
>   #include <asm/espfix.h>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index fd975a4a5200..e73433af3bfa 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1223,6 +1223,8 @@ void __init setup_arch(char **cmdline_p)
>   	initmem_init();
>   	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>  =20
> +	amdtee_cma_reserve();
> +
>   	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>   		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>  =20
> diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
> index 191f9715fa9a..5843c739a7b8 100644
> --- a/drivers/tee/amdtee/Kconfig
> +++ b/drivers/tee/amdtee/Kconfig
> @@ -6,3 +6,12 @@ config AMDTEE
>   	depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
>   	help
>   	  This implements AMD's Trusted Execution Environment (TEE) driver.
> +
> +config AMDTEE_CMA_SIZE
> +	int "Size of Memory in MiB reserved in CMA for AMD-TEE"
> +	default "0"
> +	depends on CMA && (AMDTEE=3Dy)
> +	help
> +	  Specify the default amount of memory in MiB reserved in CMA for AMD-TEE=
 driver
> +	  Any amdtee shm buffer allocation larger than 64k will allocate memory f=
rom the CMA
> +	  The default can be overridden with the kernel commandline parameter "am=
dtee_cma".
> \ No newline at end of file
> diff --git a/drivers/tee/amdtee/Makefile b/drivers/tee/amdtee/Makefile
> index ff1485266117..a197839cfcf3 100644
> --- a/drivers/tee/amdtee/Makefile
> +++ b/drivers/tee/amdtee/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_AMDTEE) +=3D amdtee.o
>   amdtee-objs +=3D core.o
>   amdtee-objs +=3D call.o
>   amdtee-objs +=3D shm_pool.o
> +amdtee-objs +=3D shm_pool_cma.o
> diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdte=
e_private.h
> index 6d0f7062bb87..9ba47795adb6 100644
> --- a/drivers/tee/amdtee/amdtee_private.h
> +++ b/drivers/tee/amdtee/amdtee_private.h
> @@ -87,11 +87,13 @@ struct shmem_desc {
>    * struct amdtee_shm_data - Shared memory data
>    * @kaddr:	Kernel virtual address of shared memory
>    * @buf_id:	Buffer id of memory mapped by TEE_CMD_ID_MAP_SHARED_MEM
> + * @is_cma:	Indicates whether memory is allocated from cma region or not
>    */
>   struct amdtee_shm_data {
>   	struct  list_head shm_node;
>   	void    *kaddr;
>   	u32     buf_id;
> +	bool    is_cma;
>   };
>  =20
>   /**
> @@ -145,9 +147,9 @@ int amdtee_invoke_func(struct tee_context *ctx,
>  =20
>   int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session=
);
>  =20
> -int amdtee_map_shmem(struct tee_shm *shm);
> +int amdtee_map_shmem(struct tee_shm *shm, bool is_cma);
>  =20
> -void amdtee_unmap_shmem(struct tee_shm *shm);
> +void amdtee_unmap_shmem(struct tee_shm *shm, bool *is_cma);
>  =20
>   int handle_load_ta(void *data, u32 size,
>   		   struct tee_ioctl_open_session_arg *arg);
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 372d64756ed6..448802dccf13 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -336,7 +336,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 s=
ession)
>   	return 0;
>   }
>  =20
> -int amdtee_map_shmem(struct tee_shm *shm)
> +int amdtee_map_shmem(struct tee_shm *shm, bool is_cma)
>   {
>   	struct amdtee_context_data *ctxdata;
>   	struct amdtee_shm_data *shmnode;
> @@ -368,6 +368,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
>  =20
>   	shmnode->kaddr =3D shm->kaddr;
>   	shmnode->buf_id =3D buf_id;
> +	shmnode->is_cma =3D is_cma;
>   	ctxdata =3D shm->ctx->data;
>   	mutex_lock(&ctxdata->shm_mutex);
>   	list_add(&shmnode->shm_node, &ctxdata->shm_list);
> @@ -378,7 +379,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
>   	return 0;
>   }
>  =20
> -void amdtee_unmap_shmem(struct tee_shm *shm)
> +void amdtee_unmap_shmem(struct tee_shm *shm, bool *is_cma)
>   {
>   	struct amdtee_context_data *ctxdata;
>   	struct amdtee_shm_data *shmnode;
> @@ -395,6 +396,7 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
>   	mutex_lock(&ctxdata->shm_mutex);
>   	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
>   		if (buf_id =3D=3D shmnode->buf_id) {
> +			*is_cma =3D shmnode->is_cma;
>   			list_del(&shmnode->shm_node);
>   			kfree(shmnode);
>   			break;
> diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
> index f0303126f199..9aad401387be 100644
> --- a/drivers/tee/amdtee/shm_pool.c
> +++ b/drivers/tee/amdtee/shm_pool.c
> @@ -7,19 +7,30 @@
>   #include <linux/tee_drv.h>
>   #include <linux/psp.h>
>   #include "amdtee_private.h"
> +#include "shm_pool_cma.h"
>  =20
>   static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>   			 size_t size, size_t align)
>   {
>   	unsigned int order =3D get_order(size);
>   	unsigned long va;
> +	bool is_cma =3D false;
>   	int rc;
>  =20
>   	/*
>   	 * Ignore alignment since this is already going to be page aligned
>   	 * and there's no need for any larger alignment.
>   	 */
> -	va =3D __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +
> +	/* if CMA is available, use it for higher order allocation */
> +	if (amdtee_get_cma_size() && order > 6)
> +		va =3D amdtee_alloc_from_cma(shm, order);
> +
> +	if (va)
> +		is_cma =3D true;
> +	else
> +		va =3D __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +
>   	if (!va)
>   		return -ENOMEM;
>  =20
> @@ -28,9 +39,13 @@ static int pool_op_alloc(struct tee_shm_pool *pool, stru=
ct tee_shm *shm,
>   	shm->size =3D PAGE_SIZE << order;
>  =20
>   	/* Map the allocated memory in to TEE */
> -	rc =3D amdtee_map_shmem(shm);
> +	rc =3D amdtee_map_shmem(shm, is_cma);
>   	if (rc) {
> -		free_pages(va, order);
> +		if (is_cma)
> +			amdtee_free_from_cma(shm);
> +		else
> +			free_pages(va, order);
> +
>   		shm->kaddr =3D NULL;
>   		return rc;
>   	}
> @@ -40,9 +55,16 @@ static int pool_op_alloc(struct tee_shm_pool *pool, stru=
ct tee_shm *shm,
>  =20
>   static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
>   {
> +	bool is_cma =3D false;
> +
>   	/* Unmap the shared memory from TEE */
> -	amdtee_unmap_shmem(shm);
> -	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +	amdtee_unmap_shmem(shm, &is_cma);
> +
> +	if (is_cma)

No need in is_cma here and other places.


> +		amdtee_free_from_cma(shm);
> +	else
> +		free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +
>   	shm->kaddr =3D NULL;
>   }
>  =20
> diff --git a/drivers/tee/amdtee/shm_pool_cma.c b/drivers/tee/amdtee/shm_poo=
l_cma.c
> new file mode 100644
> index 000000000000..99dda9adb1c6
> --- /dev/null
> +++ b/drivers/tee/amdtee/shm_pool_cma.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
> +
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
> +#include <linux/cma.h>
> +#include <linux/mm.h>
> +#include <linux/tee_drv.h>
> +#include "shm_pool_cma.h"
> +
> +static struct cma *amdtee_cma;
> +unsigned long amdtee_cma_size __initdata =3D CONFIG_AMDTEE_CMA_SIZE * SZ_1=
M;
> +
> +static int __init early_parse_amdtee_cma(char *p)
> +{
> +	int cmd_size;

Not int but unsigned long long.

> +
> +	if (!p)
> +		return 1;
> +
> +	cmd_size =3D memparse(p, NULL);
> +	if (cmd_size >=3D 4 && cmd_size <=3D 256)
> +		amdtee_cma_size =3D cmd_size * SZ_1M;

Change the doc to use 4M and 256M instead of plain 4 and 256. Or stop=20
using memparse().

/me sad.


> +	else
> +		pr_err("invalid amdtee_cma size: %lu\n", amdtee_cma_size);
> +
> +	return 0;
> +}
> +early_param("amdtee_cma", early_parse_amdtee_cma);
> +
> +void __init amdtee_cma_reserve(void)
> +{
> +	int ret;
> +
> +	ret =3D cma_declare_contiguous(0, amdtee_cma_size, 0, 0, 0, false, "amdte=
e", &amdtee_cma);
> +	if (ret)
> +		pr_err("Failed to reserve CMA region of size %lu\n", amdtee_cma_size);
> +	else
> +		pr_info("Reserved %lu bytes CMA for amdtee\n", amdtee_cma_size);
> +}
> +
> +unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned int orde=
r)
> +{
> +	struct page *page =3D NULL;
> +	unsigned long va =3D 0;
> +	int nr_pages =3D 0;
> +
> +	if (amdtee_cma) {
> +		nr_pages =3D 1 << order;
> +		page =3D cma_alloc(amdtee_cma, nr_pages, 0, false);
> +		if (page)
> +			va =3D (unsigned long)page_to_virt(page);
> +		else
> +			pr_debug("failed to allocate from CMA region\n");
> +	} else {
> +		pr_debug("CMA region is not available\n");
> +	}
> +	return va;
> +}
> +
> +void amdtee_free_from_cma(struct tee_shm *shm)
> +{
> +	struct page *page;
> +	int nr_pages =3D 0;
> +
> +	if (amdtee_cma) {
> +		nr_pages =3D 1 << get_order(shm->size);
> +		page =3D virt_to_page(shm->kaddr);
> +		cma_release(amdtee_cma, page, nr_pages);
> +	} else {
> +		pr_err("CMA region is not available\n");
> +	}
> +}
> +#endif /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
> diff --git a/drivers/tee/amdtee/shm_pool_cma.h b/drivers/tee/amdtee/shm_poo=
l_cma.h
> new file mode 100644
> index 000000000000..d1cde11cbede
> --- /dev/null
> +++ b/drivers/tee/amdtee/shm_pool_cma.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef SHM_POOL_CMA_H
> +#define SHM_POOL_CMA_H
> +
> +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
> +
> +extern unsigned long amdtee_cma_size;
> +
> +static inline unsigned long amdtee_get_cma_size(void)
> +{
> +	return amdtee_cma_size;
> +}
> +
> +unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned int orde=
r);
> +
> +void amdtee_free_from_cma(struct tee_shm *shm);
> +
> +#else /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
> +
> +static inline unsigned long amdtee_get_cma_size(void)
> +{
> +	return 0;
> +}
> +
> +static inline unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, uns=
igned int order)
> +{
> +	return 0;
> +}
> +
> +static inline void amdtee_free_from_cma(struct tee_shm *shm) { }
> +
> +#endif /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
> +#endif /* SHM_POOL_CMA_H */

--=20
Alexey


--===============5125331354783431590==--

