From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/3] tee: optee: Move pool_op helper functions
Date: Tue, 27 Feb 2024 16:49:48 +0100
Message-ID: 
 <CAHUa44G70L9CnQD6V3ivWf1hYfK0iWFt-cfg98-JGB-s8TVd-A@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNW9-7gCZQSEaV=Gcr+GLdu25rQ8MpTg9yNpX7OwyZ0Tg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8670259157363912792=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8670259157363912792==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 7:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi Balint,
>
> On Fri, 23 Feb 2024 at 15:22, Balint Dobszay <balint.dobszay@arm.com> wro=
te:
> >
> > Move the pool alloc and free helper functions from the OP-TEE driver to
> > the TEE subsystem, since these could be reused in other TEE drivers.
> > This patch is not supposed to change behavior, it's only reorganizing
> > the code.
> >
> > Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> > ---
> >  drivers/tee/optee/core.c          | 64 ------------------------------
> >  drivers/tee/optee/ffa_abi.c       |  6 +--
> >  drivers/tee/optee/optee_private.h | 12 ------
> >  drivers/tee/optee/smc_abi.c       | 11 +++---
> >  drivers/tee/tee_shm.c             | 65 +++++++++++++++++++++++++++++++
> >  include/linux/tee_drv.h           | 11 ++++++
> >  6 files changed, 85 insertions(+), 84 deletions(-)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 3aed554bc8d8..9390f21f9902 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -9,7 +9,6 @@
> >  #include <linux/crash_dump.h>
> >  #include <linux/errno.h>
> >  #include <linux/io.h>
> > -#include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> > @@ -17,69 +16,6 @@
> >  #include <linux/types.h>
> >  #include "optee_private.h"
> >
> > -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm=
 *shm,
> > -                              size_t size, size_t align,
> > -                              int (*shm_register)(struct tee_context *ct=
x,
> > -                                                  struct tee_shm *shm,
> > -                                                  struct page **pages,
> > -                                                  size_t num_pages,
> > -                                                  unsigned long start))
> > -{
> > -       size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
> > -       struct page **pages;
> > -       unsigned int i;
> > -       int rc =3D 0;
> > -
> > -       /*
> > -        * Ignore alignment since this is already going to be page aligned
> > -        * and there's no need for any larger alignment.
> > -        */
> > -       shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
> > -                                      GFP_KERNEL | __GFP_ZERO);
> > -       if (!shm->kaddr)
> > -               return -ENOMEM;
> > -
> > -       shm->paddr =3D virt_to_phys(shm->kaddr);
> > -       shm->size =3D nr_pages * PAGE_SIZE;
> > -
> > -       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > -       if (!pages) {
> > -               rc =3D -ENOMEM;
> > -               goto err;
> > -       }
> > -
> > -       for (i =3D 0; i < nr_pages; i++)
> > -               pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZ=
E);
> > -
> > -       shm->pages =3D pages;
> > -       shm->num_pages =3D nr_pages;
> > -
> > -       if (shm_register) {
> > -               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> > -                                 (unsigned long)shm->kaddr);
> > -               if (rc)
> > -                       goto err;
> > -       }
> > -
> > -       return 0;
> > -err:
> > -       free_pages_exact(shm->kaddr, shm->size);
> > -       shm->kaddr =3D NULL;
> > -       return rc;
> > -}
> > -
> > -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm=
 *shm,
> > -                              int (*shm_unregister)(struct tee_context *=
ctx,
> > -                                                    struct tee_shm *shm))
> > -{
> > -       if (shm_unregister)
> > -               shm_unregister(shm->ctx, shm);
> > -       free_pages_exact(shm->kaddr, shm->size);
> > -       shm->kaddr =3D NULL;
> > -       kfree(shm->pages);
> > -       shm->pages =3D NULL;
> > -}
> > -
> >  static void optee_bus_scan(struct work_struct *work)
> >  {
> >         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index ecb5eb079408..ee11918a2b35 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -374,14 +374,14 @@ static int optee_ffa_shm_unregister_supp(struct tee=
_context *ctx,
> >  static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
> >                              struct tee_shm *shm, size_t size, size_t ali=
gn)
> >  {
> > -       return optee_pool_op_alloc_helper(pool, shm, size, align,
> > -                                         optee_ffa_shm_register);
> > +       return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
> > +                                           optee_ffa_shm_register);
> >  }
> >
> >  static void pool_ffa_op_free(struct tee_shm_pool *pool,
> >                              struct tee_shm *shm)
> >  {
> > -       optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
> > +       tee_shm_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
> >  }
> >
> >  static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> > index 7a5243c78b55..a153285a1919 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -283,18 +283,6 @@ int optee_cancel_req(struct tee_context *ctx, u32 ca=
ncel_id, u32 session);
> >  int optee_enumerate_devices(u32 func);
> >  void optee_unregister_devices(void);
> >
> > -int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm=
 *shm,
> > -                              size_t size, size_t align,
> > -                              int (*shm_register)(struct tee_context *ct=
x,
> > -                                                  struct tee_shm *shm,
> > -                                                  struct page **pages,
> > -                                                  size_t num_pages,
> > -                                                  unsigned long start));
> > -void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm=
 *shm,
> > -                              int (*shm_unregister)(struct tee_context *=
ctx,
> > -                                                    struct tee_shm *shm)=
);
> > -
> > -
> >  void optee_remove_common(struct optee *optee);
> >  int optee_open(struct tee_context *ctx, bool cap_memref_null);
> >  void optee_release(struct tee_context *ctx);
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a37f87087e5c..b0c616b6870d 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -592,19 +592,20 @@ static int pool_op_alloc(struct tee_shm_pool *pool,
> >          * to be registered with OP-TEE.
> >          */
> >         if (shm->flags & TEE_SHM_PRIV)
> > -               return optee_pool_op_alloc_helper(pool, shm, size, align,=
 NULL);
> > +               return tee_shm_pool_op_alloc_helper(pool, shm, size, alig=
n,
> > +                                                   NULL);
> >
> > -       return optee_pool_op_alloc_helper(pool, shm, size, align,
> > -                                         optee_shm_register);
> > +       return tee_shm_pool_op_alloc_helper(pool, shm, size, align,
> > +                                           optee_shm_register);
> >  }
> >
> >  static void pool_op_free(struct tee_shm_pool *pool,
> >                          struct tee_shm *shm)
> >  {
> >         if (!(shm->flags & TEE_SHM_PRIV))
> > -               optee_pool_op_free_helper(pool, shm, optee_shm_unregister=
);
> > +               tee_shm_pool_op_free_helper(pool, shm, optee_shm_unregist=
er);
> >         else
> > -               optee_pool_op_free_helper(pool, shm, NULL);
> > +               tee_shm_pool_op_free_helper(pool, shm, NULL);
> >  }
> >T
> >  static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 731d9028b67f..641aad92ffe2 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -202,6 +202,71 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_co=
ntext *ctx, size_t size)
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
> >
> > +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
>
> I don't see the first argument (struct tee_shm_pool *pool) being used,
> so drop that. Also, we can just rename it as
> tee_dyn_shm_alloc_helper().
>
> > +                                size_t size, size_t align,
> > +                                int (*shm_register)(struct tee_context *=
ctx,
> > +                                                    struct tee_shm *shm,
> > +                                                    struct page **pages,
> > +                                                    size_t num_pages,
> > +                                                    unsigned long start))
> > +{
> > +       size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
> > +       struct page **pages;
> > +       unsigned int i;
> > +       int rc =3D 0;
> > +
> > +       /*
> > +        * Ignore alignment since this is already going to be page aligned
> > +        * and there's no need for any larger alignment.
> > +        */
> > +       shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
> > +                                      GFP_KERNEL | __GFP_ZERO);
> > +       if (!shm->kaddr)
> > +               return -ENOMEM;
> > +
> > +       shm->paddr =3D virt_to_phys(shm->kaddr);
> > +       shm->size =3D nr_pages * PAGE_SIZE;
> > +
> > +       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > +       if (!pages) {
> > +               rc =3D -ENOMEM;
> > +               goto err;
> > +       }
> > +
> > +       for (i =3D 0; i < nr_pages; i++)
> > +               pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZ=
E);
> > +
> > +       shm->pages =3D pages;
> > +       shm->num_pages =3D nr_pages;
> > +
> > +       if (shm_register) {
> > +               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> > +                                 (unsigned long)shm->kaddr);
> > +               if (rc)
> > +                       goto err;
> > +       }
> > +
> > +       return 0;
> > +err:
> > +       free_pages_exact(shm->kaddr, shm->size);
> > +       shm->kaddr =3D NULL;
> > +       return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_pool_op_alloc_helper);
> > +
> > +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
>
> Ditto tee_shm_pool_op_free_helper() -> tee_dyn_shm_free_helper()
>
> > +                                int (*shm_unregister)(struct tee_context=
 *ctx,
> > +                                                      struct tee_shm *sh=
m))
> > +{
> > +       if (shm_unregister)
> > +               shm_unregister(shm->ctx, shm);
> > +       free_pages_exact(shm->kaddr, shm->size);
> > +       shm->kaddr =3D NULL;
> > +       kfree(shm->pages);
> > +       shm->pages =3D NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(tee_shm_pool_op_free_helper);
> > +
> >  static struct tee_shm *
> >  register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 =
flags,
> >                     int id)
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 911ddf92dcee..4cf402424e71 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teedev);
> >  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t s=
ize);
> >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t=
 size);
> >
> > +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
> > +                                size_t size, size_t align,
> > +                                int (*shm_register)(struct tee_context *=
ctx,
> > +                                                    struct tee_shm *shm,
> > +                                                    struct page **pages,
> > +                                                    size_t num_pages,
> > +                                                    unsigned long start)=
);
> > +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
> > +                                int (*shm_unregister)(struct tee_context=
 *ctx,
> > +                                                      struct tee_shm *sh=
m));
> > +
>
> These rather belong to drivers/tee/tee_private.h as we shouldn't
> expose them to other kernel client drivers.

This is the right place, this .h file is for TEE drivers too.

Cheers,
Jens

>
> -Sumit
>
> >  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> >                                             void *addr, size_t length);
> >
> > --
> > 2.34.1
> >

--===============8670259157363912792==--

