From: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Date: Tue, 29 Aug 2023 22:17:41 +0530
Message-ID: <bdfa557d-434a-46fa-8e43-3517bd863f40@amd.com>
In-Reply-To: <cd226133-ed18-101b-6401-a6dcd89a1db8@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6139376804548092829=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6139376804548092829==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On 8/19/2023 4:03 PM, Alexey Kardashevskiy wrote:
> On 19/8/23 00:42, Devaraj Rangasamy wrote:
>> In systems with low memory configuration, memory gets fragmented
>> easily, and any bigger size contiguous memory allocations are likely
>> to fail.
>> Contiguous Memory Allocator (CMA) is used to overcome this
>> limitation, and to guarantee memory allocations.
>>
>> This patch adds support for CMA area exclusive to amdtee.
>> The support can be enabled if kernel have CONFIG_CMA enabled.
>> The size can be set via the AMDTEE_CMA_SIZE config option
>> at compile time or with the "amdtee_cma" kernel parameter.
>> (e.g. "amdtee_cma=3D32 for 32MB").
>>
>> Also, cma zone is utilized only for buffer allocation bigger than
>> 64k bytes. When such allocation fails, there is a fallback to the
>> buddy allocator. Since CMA requires a boot time initialization,
>> it is enabled only when amdtee is built as an inbuilt driver.
>>
>> Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
>> Co-developed-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
>> Signed-off-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
>> Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>> ---
>> =C2=A0 .../admin-guide/kernel-parameters.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++
>> =C2=A0 arch/x86/include/asm/setup.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++
>> =C2=A0 arch/x86/kernel/setup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +
>> =C2=A0 drivers/tee/amdtee/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 9 +++
>> =C2=A0 drivers/tee/amdtee/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 1 +
>> =C2=A0 drivers/tee/amdtee/amdtee_private.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +-
>> =C2=A0 drivers/tee/amdtee/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 +-
>> =C2=A0 drivers/tee/amdtee/shm_pool.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32 ++++++--
>> =C2=A0 drivers/tee/amdtee/shm_pool_cma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 78 +++++++++++++++++++
>> =C2=A0 drivers/tee/amdtee/shm_pool_cma.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 38 +++++++++
>> =C2=A0 10 files changed, 176 insertions(+), 9 deletions(-)
>> =C2=A0 create mode 100644 drivers/tee/amdtee/shm_pool_cma.c
>> =C2=A0 create mode 100644 drivers/tee/amdtee/shm_pool_cma.h
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt=20
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 722b6eca2e93..5e38423f3d53 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -363,6 +363,13 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 selects a performance level in this range and=20
>> appropriate
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 to the current workload.
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 amdtee_cma=3Dnn=C2=A0=C2=A0=C2=A0 [HW,TEE]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sets t=
he memory size reserved for contiguous memory
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alloca=
tions, to be used by amdtee device driver.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value =
is in MB and can range from 4 to 128 (MBs)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CMA wi=
ll be active only when CMA is enabled, and amdtee is
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 built =
as inbuilt driver, and not loaded as module.
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amijoy.map=3D=C2=A0=C2=A0=C2=A0 [HW,JOY] Am=
iga joystick support
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Map of devices attached to JOY0DAT and JOY1DAT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Format: <a>,<b>
>> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
>> index f3495623ac99..bb5e4b7134a2 100644
>> --- a/arch/x86/include/asm/setup.h
>> +++ b/arch/x86/include/asm/setup.h
>> @@ -66,6 +66,12 @@ extern void x86_ce4100_early_setup(void);
>> =C2=A0 static inline void x86_ce4100_early_setup(void) { }
>> =C2=A0 #endif
>> =C2=A0 +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
>> +void amdtee_cma_reserve(void);
>> +#else
>> +static inline void amdtee_cma_reserve(void) { }
>> +#endif
>> +
>> =C2=A0 #ifndef _SETUP
>> =C2=A0 =C2=A0 #include <asm/espfix.h>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index fd975a4a5200..e73433af3bfa 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -1223,6 +1223,8 @@ void __init setup_arch(char **cmdline_p)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initmem_init();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_contiguous_reserve(max_pfn_mapped << PA=
GE_SHIFT);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 amdtee_cma_reserve();
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (boot_cpu_has(X86_FEATURE_GBPAGES))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hugetlb_cma_reserve=
(PUD_SHIFT - PAGE_SHIFT);
>> =C2=A0 diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
>> index 191f9715fa9a..5843c739a7b8 100644
>> --- a/drivers/tee/amdtee/Kconfig
>> +++ b/drivers/tee/amdtee/Kconfig
>> @@ -6,3 +6,12 @@ config AMDTEE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_=
CCP_DD
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This implements AMD's Trusted E=
xecution Environment (TEE)=20
>> driver.
>> +
>> +config AMDTEE_CMA_SIZE
>> +=C2=A0=C2=A0=C2=A0 int "Size of Memory in MiB reserved in CMA for AMD-TEE"
>> +=C2=A0=C2=A0=C2=A0 default "0"
>> +=C2=A0=C2=A0=C2=A0 depends on CMA && (AMDTEE=3Dy)
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Specify the default amount of memory in Mi=
B reserved in CMA=20
>> for AMD-TEE driver
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Any amdtee shm buffer allocation larger th=
an 64k will allocate=20
>> memory from the CMA
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The default can be overridden with the ker=
nel commandline=20
>> parameter "amdtee_cma".
>> \ No newline at end of file
>> diff --git a/drivers/tee/amdtee/Makefile b/drivers/tee/amdtee/Makefile
>> index ff1485266117..a197839cfcf3 100644
>> --- a/drivers/tee/amdtee/Makefile
>> +++ b/drivers/tee/amdtee/Makefile
>> @@ -3,3 +3,4 @@ obj-$(CONFIG_AMDTEE) +=3D amdtee.o
>> =C2=A0 amdtee-objs +=3D core.o
>> =C2=A0 amdtee-objs +=3D call.o
>> =C2=A0 amdtee-objs +=3D shm_pool.o
>> +amdtee-objs +=3D shm_pool_cma.o
>> diff --git a/drivers/tee/amdtee/amdtee_private.h=20
>> b/drivers/tee/amdtee/amdtee_private.h
>> index 6d0f7062bb87..9ba47795adb6 100644
>> --- a/drivers/tee/amdtee/amdtee_private.h
>> +++ b/drivers/tee/amdtee/amdtee_private.h
>> @@ -87,11 +87,13 @@ struct shmem_desc {
>> =C2=A0=C2=A0 * struct amdtee_shm_data - Shared memory data
>> =C2=A0=C2=A0 * @kaddr:=C2=A0=C2=A0=C2=A0 Kernel virtual address of shared =
memory
>> =C2=A0=C2=A0 * @buf_id:=C2=A0=C2=A0=C2=A0 Buffer id of memory mapped by TE=
E_CMD_ID_MAP_SHARED_MEM
>> + * @is_cma:=C2=A0=C2=A0=C2=A0 Indicates whether memory is allocated from =
cma region=20
>> or not
>> =C2=A0=C2=A0 */
>> =C2=A0 struct amdtee_shm_data {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct=C2=A0 list_head shm_node;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void=C2=A0=C2=A0=C2=A0 *kaddr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0 buf_id;
>> +=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0 is_cma;
>> =C2=A0 };
>> =C2=A0 =C2=A0 /**
>> @@ -145,9 +147,9 @@ int amdtee_invoke_func(struct tee_context *ctx,
>> =C2=A0 =C2=A0 int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id=
, u32=20
>> session);
>> =C2=A0 -int amdtee_map_shmem(struct tee_shm *shm);
>> +int amdtee_map_shmem(struct tee_shm *shm, bool is_cma);
>> =C2=A0 -void amdtee_unmap_shmem(struct tee_shm *shm);
>> +void amdtee_unmap_shmem(struct tee_shm *shm, bool *is_cma);
>> =C2=A0 =C2=A0 int handle_load_ta(void *data, u32 size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
truct tee_ioctl_open_session_arg *arg);
>> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
>> index 372d64756ed6..448802dccf13 100644
>> --- a/drivers/tee/amdtee/core.c
>> +++ b/drivers/tee/amdtee/core.c
>> @@ -336,7 +336,7 @@ int amdtee_close_session(struct tee_context *ctx,=20
>> u32 session)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -int amdtee_map_shmem(struct tee_shm *shm)
>> +int amdtee_map_shmem(struct tee_shm *shm, bool is_cma)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdtee_context_data *ctxdata;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdtee_shm_data *shmnode;
>> @@ -368,6 +368,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shmnode->kaddr =3D shm->kaddr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shmnode->buf_id =3D buf_id;
>> +=C2=A0=C2=A0=C2=A0 shmnode->is_cma =3D is_cma;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctxdata =3D shm->ctx->data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&ctxdata->shm_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&shmnode->shm_node, &ctxdata->shm_=
list);
>> @@ -378,7 +379,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -void amdtee_unmap_shmem(struct tee_shm *shm)
>> +void amdtee_unmap_shmem(struct tee_shm *shm, bool *is_cma)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdtee_context_data *ctxdata;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdtee_shm_data *shmnode;
>> @@ -395,6 +396,7 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&ctxdata->shm_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(shmnode, &ctxdata->shm_=
list, shm_node)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (buf_id =3D=3D s=
hmnode->buf_id) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *is_cm=
a =3D shmnode->is_cma;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 list_del(&shmnode->shm_node);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 kfree(shmnode);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> diff --git a/drivers/tee/amdtee/shm_pool.c=20
>> b/drivers/tee/amdtee/shm_pool.c
>> index f0303126f199..9aad401387be 100644
>> --- a/drivers/tee/amdtee/shm_pool.c
>> +++ b/drivers/tee/amdtee/shm_pool.c
>> @@ -7,19 +7,30 @@
>> =C2=A0 #include <linux/tee_drv.h>
>> =C2=A0 #include <linux/psp.h>
>> =C2=A0 #include "amdtee_private.h"
>> +#include "shm_pool_cma.h"
>> =C2=A0 =C2=A0 static int pool_op_alloc(struct tee_shm_pool *pool, struct=20
>> tee_shm *shm,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 size_t size, size_t align)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int order =3D get_order(size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long va;
>> +=C2=A0=C2=A0=C2=A0 bool is_cma =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ignore alignment since this is alre=
ady going to be page aligned
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and there's no need for any larger =
alignment.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 va =3D __get_free_pages(GFP_KERNEL | __GFP_ZERO, order=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* if CMA is available, use it for higher order alloca=
tion */
>> +=C2=A0=C2=A0=C2=A0 if (amdtee_get_cma_size() && order > 6)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 va =3D amdtee_alloc_from_cma(s=
hm, order);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (va)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_cma =3D true;
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 va =3D __get_free_pages(GFP_KE=
RNEL | __GFP_ZERO, order);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!va)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> =C2=A0 @@ -28,9 +39,13 @@ static int pool_op_alloc(struct tee_shm_pool=20
>> *pool, struct tee_shm *shm,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shm->size =3D PAGE_SIZE << order;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Map the allocated memory in to TE=
E */
>> -=C2=A0=C2=A0=C2=A0 rc =3D amdtee_map_shmem(shm);
>> +=C2=A0=C2=A0=C2=A0 rc =3D amdtee_map_shmem(shm, is_cma);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_pages(va, order);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_cma)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdtee=
_free_from_cma(shm);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_p=
ages(va, order);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shm->kaddr =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -40,9 +55,16 @@ static int pool_op_alloc(struct tee_shm_pool=20
>> *pool, struct tee_shm *shm,
>> =C2=A0 =C2=A0 static void pool_op_free(struct tee_shm_pool *pool, struct=20
>> tee_shm *shm)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 bool is_cma =3D false;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Unmap the shared memory from TEE */
>> -=C2=A0=C2=A0=C2=A0 amdtee_unmap_shmem(shm);
>> -=C2=A0=C2=A0=C2=A0 free_pages((unsigned long)shm->kaddr, get_order(shm->s=
ize));
>> +=C2=A0=C2=A0=C2=A0 amdtee_unmap_shmem(shm, &is_cma);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (is_cma)
>
> No need in is_cma here and other places.
Ack.
cma_release() do have inbuilt validation, and returns true/false as=20
result for valid cma buffer release.
>
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdtee_free_from_cma(shm);
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_pages((unsigned long)shm-=
>kaddr, get_order(shm->size));
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shm->kaddr =3D NULL;
>> =C2=A0 }
>> =C2=A0 diff --git a/drivers/tee/amdtee/shm_pool_cma.c=20
>> b/drivers/tee/amdtee/shm_pool_cma.c
>> new file mode 100644
>> index 000000000000..99dda9adb1c6
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/shm_pool_cma.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
>> +
>> +#define pr_fmt(fmt) "%s: " fmt, __func__
>> +
>> +#include <linux/cma.h>
>> +#include <linux/mm.h>
>> +#include <linux/tee_drv.h>
>> +#include "shm_pool_cma.h"
>> +
>> +static struct cma *amdtee_cma;
>> +unsigned long amdtee_cma_size __initdata =3D CONFIG_AMDTEE_CMA_SIZE *=20
>> SZ_1M;
>> +
>> +static int __init early_parse_amdtee_cma(char *p)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int cmd_size;
>
> Not int but unsigned long long.
Ack.
We have reverted new exclusive cma zone.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!p)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +
>> +=C2=A0=C2=A0=C2=A0 cmd_size =3D memparse(p, NULL);
>> +=C2=A0=C2=A0=C2=A0 if (cmd_size >=3D 4 && cmd_size <=3D 256)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdtee_cma_size =3D cmd_size *=
 SZ_1M;
>
> Change the doc to use 4M and 256M instead of plain 4 and 256. Or stop=20
> using memparse().
>
> /me sad.
>
Ack.
Thanks for review.
>
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("invalid amdtee_cma siz=
e: %lu\n", amdtee_cma_size);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +early_param("amdtee_cma", early_parse_amdtee_cma);
>> +
>> +void __init amdtee_cma_reserve(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D cma_declare_contiguous(0, amdtee_cma_size, 0, =
0, 0, false,=20
>> "amdtee", &amdtee_cma);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Failed to reserve CMA =
region of size %lu\n",=20
>> amdtee_cma_size);
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("Reserved %lu bytes CM=
A for amdtee\n",=20
>> amdtee_cma_size);
>> +}
>> +
>> +unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned=20
>> int order)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct page *page =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 unsigned long va =3D 0;
>> +=C2=A0=C2=A0=C2=A0 int nr_pages =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (amdtee_cma) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_pages =3D 1 << order;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D cma_alloc(amdtee_cma,=
 nr_pages, 0, false);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (page)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 va =3D=
 (unsigned long)page_to_virt(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_deb=
ug("failed to allocate from CMA region\n");
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("CMA region is not av=
ailable\n");
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return va;
>> +}
>> +
>> +void amdtee_free_from_cma(struct tee_shm *shm)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct page *page;
>> +=C2=A0=C2=A0=C2=A0 int nr_pages =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (amdtee_cma) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_pages =3D 1 << get_order(sh=
m->size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page =3D virt_to_page(shm->kad=
dr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cma_release(amdtee_cma, page, =
nr_pages);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("CMA region is not avai=
lable\n");
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +#endif /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
>> diff --git a/drivers/tee/amdtee/shm_pool_cma.h=20
>> b/drivers/tee/amdtee/shm_pool_cma.h
>> new file mode 100644
>> index 000000000000..d1cde11cbede
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/shm_pool_cma.h
>> @@ -0,0 +1,38 @@
>> +/* SPDX-License-Identifier: MIT */
>> +
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#ifndef SHM_POOL_CMA_H
>> +#define SHM_POOL_CMA_H
>> +
>> +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
>> +
>> +extern unsigned long amdtee_cma_size;
>> +
>> +static inline unsigned long amdtee_get_cma_size(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return amdtee_cma_size;
>> +}
>> +
>> +unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned=20
>> int order);
>> +
>> +void amdtee_free_from_cma(struct tee_shm *shm);
>> +
>> +#else /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
>> +
>> +static inline unsigned long amdtee_get_cma_size(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static inline unsigned long amdtee_alloc_from_cma(struct tee_shm=20
>> *shm, unsigned int order)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static inline void amdtee_free_from_cma(struct tee_shm *shm) { }
>> +
>> +#endif /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
>> +#endif /* SHM_POOL_CMA_H */
>

--===============6139376804548092829==--

