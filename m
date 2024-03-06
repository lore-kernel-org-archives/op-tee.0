From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 2/4] tee: optee: Move pool_op helper functions
Date: Wed, 06 Mar 2024 11:32:28 +0100
Message-ID: <4C606A28-D681-4F5D-AEFC-882F0E96EBD1@arm.com>
In-Reply-To: <
 <CAFA6WYMt1GNzrdkGc6_AU_KSOVaMFK4MONHwmWchzNb97GJWvg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1340164969227218356=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1340164969227218356==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 6 Mar 2024, at 8:22, Sumit Garg wrote:

> On Tue, 5 Mar 2024 at 15:49, Balint Dobszay <balint.dobszay@arm.com> wrot=
e:
>>
>> Move the pool alloc and free helper functions from the OP-TEE driver to
>> the TEE subsystem, since these could be reused in other TEE drivers.
>> This patch is not supposed to change behavior, it's only reorganizing
>> the code.
>>
>> Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
>> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
>> ---
>>  drivers/tee/optee/core.c          | 64 -------------------------------
>>  drivers/tee/optee/ffa_abi.c       |  6 +--
>>  drivers/tee/optee/optee_private.h | 12 ------
>>  drivers/tee/optee/smc_abi.c       |  9 ++---
>>  drivers/tee/tee_shm.c             | 64 +++++++++++++++++++++++++++++++
>>  include/linux/tee_core.h          | 10 +++++
>>  6 files changed, 81 insertions(+), 84 deletions(-)
>>
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Thanks for the review. I'll add your tag for the next version.

Regards,
Balint

>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index f762e3a25119..39e688d4e974 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -9,7 +9,6 @@
>>  #include <linux/crash_dump.h>
>>  #include <linux/errno.h>
>>  #include <linux/io.h>
>> -#include <linux/mm.h>
>>  #include <linux/module.h>
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>> @@ -17,69 +16,6 @@
>>  #include <linux/types.h>
>>  #include "optee_private.h"
>>
>> -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm =
*shm,
>> -                              size_t size, size_t align,
>> -                              int (*shm_register)(struct tee_context *ctx,
>> -                                                  struct tee_shm *shm,
>> -                                                  struct page **pages,
>> -                                                  size_t num_pages,
>> -                                                  unsigned long start))
>> -{
>> -       size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
>> -       struct page **pages;
>> -       unsigned int i;
>> -       int rc =3D 0;
>> -
>> -       /*
>> -        * Ignore alignment since this is already going to be page aligned
>> -        * and there's no need for any larger alignment.
>> -        */
>> -       shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
>> -                                      GFP_KERNEL | __GFP_ZERO);
>> -       if (!shm->kaddr)
>> -               return -ENOMEM;
>> -
>> -       shm->paddr =3D virt_to_phys(shm->kaddr);
>> -       shm->size =3D nr_pages * PAGE_SIZE;
>> -
>> -       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>> -       if (!pages) {
>> -               rc =3D -ENOMEM;
>> -               goto err;
>> -       }
>> -
>> -       for (i =3D 0; i < nr_pages; i++)
>> -               pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE=
);
>> -
>> -       shm->pages =3D pages;
>> -       shm->num_pages =3D nr_pages;
>> -
>> -       if (shm_register) {
>> -               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
>> -                                 (unsigned long)shm->kaddr);
>> -               if (rc)
>> -                       goto err;
>> -       }
>> -
>> -       return 0;
>> -err:
>> -       free_pages_exact(shm->kaddr, shm->size);
>> -       shm->kaddr =3D NULL;
>> -       return rc;
>> -}
>> -
>> -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm =
*shm,
>> -                              int (*shm_unregister)(struct tee_context *c=
tx,
>> -                                                    struct tee_shm *shm))
>> -{
>> -       if (shm_unregister)
>> -               shm_unregister(shm->ctx, shm);
>> -       free_pages_exact(shm->kaddr, shm->size);
>> -       shm->kaddr =3D NULL;
>> -       kfree(shm->pages);
>> -       shm->pages =3D NULL;
>> -}
>> -
>>  static void optee_bus_scan(struct work_struct *work)
>>  {
>>         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
>> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
>> index cee8ccb84cb8..3235e1c719e8 100644
>> --- a/drivers/tee/optee/ffa_abi.c
>> +++ b/drivers/tee/optee/ffa_abi.c
>> @@ -374,14 +374,14 @@ static int optee_ffa_shm_unregister_supp(struct tee_=
context *ctx,
>>  static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
>>                              struct tee_shm *shm, size_t size, size_t alig=
n)
>>  {
>> -       return optee_pool_op_alloc_helper(pool, shm, size, align,
>> -                                         optee_ffa_shm_register);
>> +       return tee_dyn_shm_alloc_helper(shm, size, align,
>> +                                       optee_ffa_shm_register);
>>  }
>>
>>  static void pool_ffa_op_free(struct tee_shm_pool *pool,
>>                              struct tee_shm *shm)
>>  {
>> -       optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
>> +       tee_dyn_shm_free_helper(shm, optee_ffa_shm_unregister);
>>  }
>>
>>  static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
>> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_p=
rivate.h
>> index a0698ac18993..429cc20be5cc 100644
>> --- a/drivers/tee/optee/optee_private.h
>> +++ b/drivers/tee/optee/optee_private.h
>> @@ -283,18 +283,6 @@ int optee_cancel_req(struct tee_context *ctx, u32 can=
cel_id, u32 session);
>>  int optee_enumerate_devices(u32 func);
>>  void optee_unregister_devices(void);
>>
>> -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm =
*shm,
>> -                              size_t size, size_t align,
>> -                              int (*shm_register)(struct tee_context *ctx,
>> -                                                  struct tee_shm *shm,
>> -                                                  struct page **pages,
>> -                                                  size_t num_pages,
>> -                                                  unsigned long start));
>> -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm =
*shm,
>> -                              int (*shm_unregister)(struct tee_context *c=
tx,
>> -                                                    struct tee_shm *shm));
>> -
>> -
>>  void optee_remove_common(struct optee *optee);
>>  int optee_open(struct tee_context *ctx, bool cap_memref_null);
>>  void optee_release(struct tee_context *ctx);
>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
>> index 9c296b887dc1..734c484ed0f6 100644
>> --- a/drivers/tee/optee/smc_abi.c
>> +++ b/drivers/tee/optee/smc_abi.c
>> @@ -592,19 +592,18 @@ static int pool_op_alloc(struct tee_shm_pool *pool,
>>          * to be registered with OP-TEE.
>>          */
>>         if (shm->flags & TEE_SHM_PRIV)
>> -               return optee_pool_op_alloc_helper(pool, shm, size, align, =
NULL);
>> +               return tee_dyn_shm_alloc_helper(shm, size, align, NULL);
>>
>> -       return optee_pool_op_alloc_helper(pool, shm, size, align,
>> -                                         optee_shm_register);
>> +       return tee_dyn_shm_alloc_helper(shm, size, align, optee_shm_regist=
er);
>>  }
>>
>>  static void pool_op_free(struct tee_shm_pool *pool,
>>                          struct tee_shm *shm)
>>  {
>>         if (!(shm->flags & TEE_SHM_PRIV))
>> -               optee_pool_op_free_helper(pool, shm, optee_shm_unregister);
>> +               tee_dyn_shm_free_helper(shm, optee_shm_unregister);
>>         else
>> -               optee_pool_op_free_helper(pool, shm, NULL);
>> +               tee_dyn_shm_free_helper(shm, NULL);
>>  }
>>
>>  static void pool_op_destroy_pool(struct tee_shm_pool *pool)
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index 96a45c817427..5bf76c35cd9e 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -202,6 +202,70 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_con=
text *ctx, size_t size)
>>  }
>>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>>
>> +int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t ali=
gn,
>> +                            int (*shm_register)(struct tee_context *ctx,
>> +                                                struct tee_shm *shm,
>> +                                                struct page **pages,
>> +                                                size_t num_pages,
>> +                                                unsigned long start))
>> +{
>> +       size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
>> +       struct page **pages;
>> +       unsigned int i;
>> +       int rc =3D 0;
>> +
>> +       /*
>> +        * Ignore alignment since this is already going to be page aligned
>> +        * and there's no need for any larger alignment.
>> +        */
>> +       shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
>> +                                      GFP_KERNEL | __GFP_ZERO);
>> +       if (!shm->kaddr)
>> +               return -ENOMEM;
>> +
>> +       shm->paddr =3D virt_to_phys(shm->kaddr);
>> +       shm->size =3D nr_pages * PAGE_SIZE;
>> +
>> +       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>> +       if (!pages) {
>> +               rc =3D -ENOMEM;
>> +               goto err;
>> +       }
>> +
>> +       for (i =3D 0; i < nr_pages; i++)
>> +               pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE=
);
>> +
>> +       shm->pages =3D pages;
>> +       shm->num_pages =3D nr_pages;
>> +
>> +       if (shm_register) {
>> +               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
>> +                                 (unsigned long)shm->kaddr);
>> +               if (rc)
>> +                       goto err;
>> +       }
>> +
>> +       return 0;
>> +err:
>> +       free_pages_exact(shm->kaddr, shm->size);
>> +       shm->kaddr =3D NULL;
>> +       return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_dyn_shm_alloc_helper);
>> +
>> +void tee_dyn_shm_free_helper(struct tee_shm *shm,
>> +                            int (*shm_unregister)(struct tee_context *ctx,
>> +                                                  struct tee_shm *shm))
>> +{
>> +       if (shm_unregister)
>> +               shm_unregister(shm->ctx, shm);
>> +       free_pages_exact(shm->kaddr, shm->size);
>> +       shm->kaddr =3D NULL;
>> +       kfree(shm->pages);
>> +       shm->pages =3D NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(tee_dyn_shm_free_helper);
>> +
>>  static struct tee_shm *
>>  register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 f=
lags,
>>                     int id)
>> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
>> index d9b3ba8e8fa9..efd16ed52315 100644
>> --- a/include/linux/tee_core.h
>> +++ b/include/linux/tee_core.h
>> @@ -232,6 +232,16 @@ void *tee_get_drvdata(struct tee_device *teedev);
>>   */
>>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t si=
ze);
>>
>> +int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t ali=
gn,
>> +                            int (*shm_register)(struct tee_context *ctx,
>> +                                                struct tee_shm *shm,
>> +                                                struct page **pages,
>> +                                                size_t num_pages,
>> +                                                unsigned long start));
>> +void tee_dyn_shm_free_helper(struct tee_shm *shm,
>> +                            int (*shm_unregister)(struct tee_context *ctx,
>> +                                                  struct tee_shm *shm));
>> +
>>  /**
>>   * tee_shm_is_dynamic() - Check if shared memory object is of the dynamic=
 kind
>>   * @shm:       Shared memory handle
>> --
>> 2.34.1
>>

--===============1340164969227218356==--

