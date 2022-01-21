From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 04/12] tee: simplify shm pool handling
Date: Fri, 21 Jan 2022 18:36:15 +0530
Message-ID: 
 <CAFA6WYO-BpTmqNEDtWTCYbA+SvwJuVueL1-Yr6JcfCNFAxSHWw@mail.gmail.com>
In-Reply-To: <20220120125612.GA1174741@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1734937379375894075=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1734937379375894075==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Jan 2022 at 18:26, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Thu, Jan 20, 2022 at 03:36:45PM +0530, Sumit Garg wrote:
> > Hi Jens,
> >
> > Thanks for this cleanup.
> >
> > On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Replaces the shared memory pool based on two pools with a single pool.
> > > The alloc() function pointer in struct tee_shm_pool_ops gets another
> > > parameter, align. This makes it possible to make less than page aligned
> > > allocations from the optional reserved shared memory pool while still
> > > making user space allocations page aligned. With in practice unchanged
> > > behaviour using only a single pool for bookkeeping.
> > >
> > > The allocation algorithm in the static OP-TEE shared memory pool is
> > > changed from best-fit to first-fit since only the latter supports an
> > > alignment parameter. The best-fit algorithm was previously the default
> > > choice and not a concious one.
> >
> > typo: s/concious/conscious/
>
> Thanks
>
> >
> > AFAIU, the earlier design was to keep separate pools for differently
> > aligned memory allocation (one for 8 bytes aligned, other for
> > PAGE_SIZE aligned). But after this patch we would be mixing these
> > allocations using a first-fit algorithm. Don't you think that it would
> > lead to inefficient memory allocation (fragmentation) as compared to
> > existing one?
>
> These small private allocation are expected to be rather short lived
> so if there is fragmentation it will typically we restricted to the first
> pages.
>
> >
> > I think we need to be careful about allocation strategy for static
> > shared memory as it's a constrained resource and if a particular
> > device is using this approach then a kernel upgrade shouldn't cause
> > any regressions for that device.
>
> A typical OP-TEE private shm allocation is 224 bytes (argument struct
> with 6 parameters, needed for open session). So with an alignment of 512
> well waste a bit more than 50%. Before this we had a single page
> reserved for this so worst case usage compared to that would be 3 pages
> instead of 1 page. However, this worst case only occurs if there is a
> high preassure from multiple threads on secure world. All in all I
> believe this scales up and down better than fixed boundaries.
>
> I was chosing somewhat large alignment to avoid increasing it again. I
> have some patches in the pipe which will grow the typicall private shm
> allocation to a page at a time which then will be used for multiple
> argument structs at a time.
>

Thanks for the details. Can we have this included in the commit
message as well as in the code itself as comment for minimum alignment
as 512 bytes for future reference?

/*
 * <above description>
 */
OPTEE_MIN_STATIC_POOL_ALIGN    9 /* 512 bytes aligned */

-Sumit

>
> >
> > >
> > > The optee and amdtee drivers are updated as needed to work with this
> > > changed pool handling.
> > >
> > > This also removes OPTEE_SHM_NUM_PRIV_PAGES which becomes obsolete with
> > > this change as the private pages can be mixed with the payload pages.
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/tee/amdtee/shm_pool.c     |  55 +++++-----------
> > >  drivers/tee/optee/Kconfig         |   8 ---
> > >  drivers/tee/optee/core.c          |  11 ++--
> > >  drivers/tee/optee/ffa_abi.c       |  55 ++++------------
> > >  drivers/tee/optee/optee_private.h |   4 +-
> > >  drivers/tee/optee/smc_abi.c       | 100 ++++++----------------------
> > >  drivers/tee/tee_private.h         |  11 ----
> > >  drivers/tee/tee_shm.c             |  29 ++++-----
> > >  drivers/tee/tee_shm_pool.c        | 104 ++++++++++--------------------
> > >  include/linux/tee_drv.h           |  58 ++++++-----------
> > >  10 files changed, 126 insertions(+), 309 deletions(-)
> > >
> > > diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_poo=
l.c
> > > index 065854e2db18..f87f96a291c9 100644
> > > --- a/drivers/tee/amdtee/shm_pool.c
> > > +++ b/drivers/tee/amdtee/shm_pool.c
> > > @@ -8,13 +8,17 @@
> > >  #include <linux/psp-sev.h>
> > >  #include "amdtee_private.h"
> > >
> > > -static int pool_op_alloc(struct tee_shm_pool_mgr *poolm, struct tee_sh=
m *shm,
> > > -                        size_t size)
> > > +static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *sh=
m,
> > > +                        size_t size, size_t align)
> > >  {
> > >         unsigned int order =3D get_order(size);
> > >         unsigned long va;
> > >         int rc;
> > >
> > > +       /*
> > > +        * Ignore alignment since this is already going to be page alig=
ned
> > > +        * and there's no need for any larger alignment.
> > > +        */
> > >         va =3D __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > >         if (!va)
> > >                 return -ENOMEM;
> > > @@ -34,7 +38,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poo=
lm, struct tee_shm *shm,
> > >         return 0;
> > >  }
> > >
> > > -static void pool_op_free(struct tee_shm_pool_mgr *poolm, struct tee_sh=
m *shm)
> > > +static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *sh=
m)
> > >  {
> > >         /* Unmap the shared memory from TEE */
> > >         amdtee_unmap_shmem(shm);
> > > @@ -42,52 +46,25 @@ static void pool_op_free(struct tee_shm_pool_mgr *p=
oolm, struct tee_shm *shm)
> > >         shm->kaddr =3D NULL;
> > >  }
> > >
> > > -static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > > +static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> > >  {
> > > -       kfree(poolm);
> > > +       kfree(pool);
> > >  }
> > >
> > > -static const struct tee_shm_pool_mgr_ops pool_ops =3D {
> > > +static const struct tee_shm_pool_ops pool_ops =3D {
> > >         .alloc =3D pool_op_alloc,
> > >         .free =3D pool_op_free,
> > > -       .destroy_poolmgr =3D pool_op_destroy_poolmgr,
> > > +       .destroy_pool =3D pool_op_destroy_pool,
> > >  };
> > >
> > > -static struct tee_shm_pool_mgr *pool_mem_mgr_alloc(void)
> > > -{
> > > -       struct tee_shm_pool_mgr *mgr =3D kzalloc(sizeof(*mgr), GFP_KERN=
EL);
> > > -
> > > -       if (!mgr)
> > > -               return ERR_PTR(-ENOMEM);
> > > -
> > > -       mgr->ops =3D &pool_ops;
> > > -
> > > -       return mgr;
> > > -}
> > > -
> > >  struct tee_shm_pool *amdtee_config_shm(void)
> > >  {
> > > -       struct tee_shm_pool_mgr *priv_mgr;
> > > -       struct tee_shm_pool_mgr *dmabuf_mgr;
> > > -       void *rc;
> > > +       struct tee_shm_pool *pool =3D kzalloc(sizeof(*pool), GFP_KERNEL=
);
> > >
> > > -       rc =3D pool_mem_mgr_alloc();
> > > -       if (IS_ERR(rc))
> > > -               return rc;
> > > -       priv_mgr =3D rc;
> > > -
> > > -       rc =3D pool_mem_mgr_alloc();
> > > -       if (IS_ERR(rc)) {
> > > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > > -               return rc;
> > > -       }
> > > -       dmabuf_mgr =3D rc;
> > > +       if (!pool)
> > > +               return ERR_PTR(-ENOMEM);
> > >
> > > -       rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > > -       if (IS_ERR(rc)) {
> > > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > > -               tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > > -       }
> > > +       pool->ops =3D &pool_ops;
> > >
> > > -       return rc;
> > > +       return pool;
> > >  }
> > > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > > index 3ca71e3812ed..f121c224e682 100644
> > > --- a/drivers/tee/optee/Kconfig
> > > +++ b/drivers/tee/optee/Kconfig
> > > @@ -7,11 +7,3 @@ config OPTEE
> > >         help
> > >           This implements the OP-TEE Trusted Execution Environment (TEE)
> > >           driver.
> > > -
> > > -config OPTEE_SHM_NUM_PRIV_PAGES
> > > -       int "Private Shared Memory Pages"
> > > -       default 1
> > > -       depends on OPTEE
> > > -       help
> > > -         This sets the number of private shared memory pages to be
> > > -         used by OP-TEE TEE driver.
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index 1ca320885fad..2a369e346b85 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -18,8 +18,8 @@
> > >  #include <linux/workqueue.h>
> > >  #include "optee_private.h"
> > >
> > > -int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
> > > -                              struct tee_shm *shm, size_t size,
> > > +int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
> > > +                              size_t size, size_t align,
> > >                                int (*shm_register)(struct tee_context *=
ctx,
> > >                                                    struct tee_shm *shm,
> > >                                                    struct page **pages,
> > > @@ -30,6 +30,10 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool_m=
gr *poolm,
> > >         struct page *page;
> > >         int rc =3D 0;
> > >
> > > +       /*
> > > +        * Ignore alignment since this is already going to be page alig=
ned
> > > +        * and there's no need for any larger alignment.
> > > +        */
> > >         page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> > >         if (!page)
> > >                 return -ENOMEM;
> > > @@ -51,7 +55,6 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool_mg=
r *poolm,
> > >                 for (i =3D 0; i < nr_pages; i++)
> > >                         pages[i] =3D page + i;
> > >
> > > -               shm->flags |=3D TEE_SHM_REGISTER;
> > >                 rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> > >                                   (unsigned long)shm->kaddr);
> > >                 kfree(pages);
> > > @@ -62,7 +65,7 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool_mg=
r *poolm,
> > >         return 0;
> > >
> > >  err:
> > > -       __free_pages(page, order);
> > > +       free_pages((unsigned long)shm->kaddr, order);
> > >         return rc;
> > >  }
> > >
> > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > > index 20a1b1a3d965..e690d9420966 100644
> > > --- a/drivers/tee/optee/ffa_abi.c
> > > +++ b/drivers/tee/optee/ffa_abi.c
> > > @@ -369,14 +369,14 @@ static int optee_ffa_shm_unregister_supp(struct t=
ee_context *ctx,
> > >   * The main function is optee_ffa_shm_pool_alloc_pages().
> > >   */
> > >
> > > -static int pool_ffa_op_alloc(struct tee_shm_pool_mgr *poolm,
> > > -                            struct tee_shm *shm, size_t size)
> > > +static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
> > > +                            struct tee_shm *shm, size_t size, size_t a=
lign)
> > >  {
> > > -       return optee_pool_op_alloc_helper(poolm, shm, size,
> > > +       return optee_pool_op_alloc_helper(pool, shm, size, align,
> > >                                           optee_ffa_shm_register);
> > >  }
> > >
> > > -static void pool_ffa_op_free(struct tee_shm_pool_mgr *poolm,
> > > +static void pool_ffa_op_free(struct tee_shm_pool *pool,
> > >                              struct tee_shm *shm)
> > >  {
> > >         optee_ffa_shm_unregister(shm->ctx, shm);
> > > @@ -384,15 +384,15 @@ static void pool_ffa_op_free(struct tee_shm_pool_=
mgr *poolm,
> > >         shm->kaddr =3D NULL;
> > >  }
> > >
> > > -static void pool_ffa_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > > +static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
> > >  {
> > > -       kfree(poolm);
> > > +       kfree(pool);
> > >  }
> > >
> > > -static const struct tee_shm_pool_mgr_ops pool_ffa_ops =3D {
> > > +static const struct tee_shm_pool_ops pool_ffa_ops =3D {
> > >         .alloc =3D pool_ffa_op_alloc,
> > >         .free =3D pool_ffa_op_free,
> > > -       .destroy_poolmgr =3D pool_ffa_op_destroy_poolmgr,
> > > +       .destroy_pool =3D pool_ffa_op_destroy_pool,
> > >  };
> > >
> > >  /**
> > > @@ -401,16 +401,16 @@ static const struct tee_shm_pool_mgr_ops pool_ffa=
_ops =3D {
> > >   * This pool is used with OP-TEE over FF-A. In this case command buffe=
rs
> > >   * and such are allocated from kernel's own memory.
> > >   */
> > > -static struct tee_shm_pool_mgr *optee_ffa_shm_pool_alloc_pages(void)
> > > +static struct tee_shm_pool *optee_ffa_shm_pool_alloc_pages(void)
> > >  {
> > > -       struct tee_shm_pool_mgr *mgr =3D kzalloc(sizeof(*mgr), GFP_KERN=
EL);
> > > +       struct tee_shm_pool *pool =3D kzalloc(sizeof(*pool), GFP_KERNEL=
);
> > >
> > > -       if (!mgr)
> > > +       if (!pool)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       mgr->ops =3D &pool_ffa_ops;
> > > +       pool->ops =3D &pool_ffa_ops;
> > >
> > > -       return mgr;
> > > +       return pool;
> > >  }
> > >
> > >  /*
> > > @@ -691,33 +691,6 @@ static bool optee_ffa_exchange_caps(struct ffa_dev=
ice *ffa_dev,
> > >         return true;
> > >  }
> > >
> > > -static struct tee_shm_pool *optee_ffa_config_dyn_shm(void)
> > > -{
> > > -       struct tee_shm_pool_mgr *priv_mgr;
> > > -       struct tee_shm_pool_mgr *dmabuf_mgr;
> > > -       void *rc;
> > > -
> > > -       rc =3D optee_ffa_shm_pool_alloc_pages();
> > > -       if (IS_ERR(rc))
> > > -               return rc;
> > > -       priv_mgr =3D rc;
> > > -
> > > -       rc =3D optee_ffa_shm_pool_alloc_pages();
> > > -       if (IS_ERR(rc)) {
> > > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > > -               return rc;
> > > -       }
> > > -       dmabuf_mgr =3D rc;
> > > -
> > > -       rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > > -       if (IS_ERR(rc)) {
> > > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > > -               tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > > -       }
> > > -
> > > -       return rc;
> > > -}
> > > -
> > >  static void optee_ffa_get_version(struct tee_device *teedev,
> > >                                   struct tee_ioctl_version_data *vers)
> > >  {
> > > @@ -813,7 +786,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_d=
ev)
> > >         if (!optee)
> > >                 return -ENOMEM;
> > >
> > > -       optee->pool =3D optee_ffa_config_dyn_shm();
> > > +       optee->pool =3D optee_ffa_shm_pool_alloc_pages();
> > >         if (IS_ERR(optee->pool)) {
> > >                 rc =3D PTR_ERR(optee->pool);
> > >                 optee->pool =3D NULL;
> > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > > index 46f74ab07c7e..df2450921464 100644
> > > --- a/drivers/tee/optee/optee_private.h
> > > +++ b/drivers/tee/optee/optee_private.h
> > > @@ -228,8 +228,8 @@ int optee_cancel_req(struct tee_context *ctx, u32 c=
ancel_id, u32 session);
> > >  int optee_enumerate_devices(u32 func);
> > >  void optee_unregister_devices(void);
> > >
> > > -int optee_pool_op_alloc_helper(struct tee_shm_pool_mgr *poolm,
> > > -                              struct tee_shm *shm, size_t size,
> > > +int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_s=
hm *shm,
> > > +                              size_t size, size_t align,
> > >                                int (*shm_register)(struct tee_context *=
ctx,
> > >                                                    struct tee_shm *shm,
> > >                                                    struct page **pages,
> > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > > index 449d6a72d289..b679037ea794 100644
> > > --- a/drivers/tee/optee/smc_abi.c
> > > +++ b/drivers/tee/optee/smc_abi.c
> > > @@ -42,8 +42,6 @@
> > >   * 6. Driver initialization.
> > >   */
> > >
> > > -#define OPTEE_SHM_NUM_PRIV_PAGES       CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
> > > -
> > >  /*
> > >   * 1. Convert between struct tee_param and struct optee_msg_param
> > >   *
> > > @@ -532,20 +530,21 @@ static int optee_shm_unregister_supp(struct tee_c=
ontext *ctx,
> > >   * The main function is optee_shm_pool_alloc_pages().
> > >   */
> > >
> > > -static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > > -                        struct tee_shm *shm, size_t size)
> > > +static int pool_op_alloc(struct tee_shm_pool *pool,
> > > +                        struct tee_shm *shm, size_t size, size_t align)
> > >  {
> > >         /*
> > >          * Shared memory private to the OP-TEE driver doesn't need
> > >          * to be registered with OP-TEE.
> > >          */
> > >         if (shm->flags & TEE_SHM_PRIV)
> > > -               return optee_pool_op_alloc_helper(poolm, shm, size, NUL=
L);
> > > +               return optee_pool_op_alloc_helper(pool, shm, size, alig=
n, NULL);
> > >
> > > -       return optee_pool_op_alloc_helper(poolm, shm, size, optee_shm_r=
egister);
> > > +       return optee_pool_op_alloc_helper(pool, shm, size, align,
> > > +                                         optee_shm_register);
> > >  }
> > >
> > > -static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> > > +static void pool_op_free(struct tee_shm_pool *pool,
> > >                          struct tee_shm *shm)
> > >  {
> > >         if (!(shm->flags & TEE_SHM_PRIV))
> > > @@ -555,15 +554,15 @@ static void pool_op_free(struct tee_shm_pool_mgr =
*poolm,
> > >         shm->kaddr =3D NULL;
> > >  }
> > >
> > > -static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > > +static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> > >  {
> > > -       kfree(poolm);
> > > +       kfree(pool);
> > >  }
> > >
> > > -static const struct tee_shm_pool_mgr_ops pool_ops =3D {
> > > +static const struct tee_shm_pool_ops pool_ops =3D {
> > >         .alloc =3D pool_op_alloc,
> > >         .free =3D pool_op_free,
> > > -       .destroy_poolmgr =3D pool_op_destroy_poolmgr,
> > > +       .destroy_pool =3D pool_op_destroy_pool,
> > >  };
> > >
> > >  /**
> > > @@ -572,16 +571,16 @@ static const struct tee_shm_pool_mgr_ops pool_ops=
 =3D {
> > >   * This pool is used when OP-TEE supports dymanic SHM. In this case
> > >   * command buffers and such are allocated from kernel's own memory.
> > >   */
> > > -static struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void)
> > > +static struct tee_shm_pool *optee_shm_pool_alloc_pages(void)
> > >  {
> > > -       struct tee_shm_pool_mgr *mgr =3D kzalloc(sizeof(*mgr), GFP_KERN=
EL);
> > > +       struct tee_shm_pool *pool =3D kzalloc(sizeof(*pool), GFP_KERNEL=
);
> > >
> > > -       if (!mgr)
> > > +       if (!pool)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       mgr->ops =3D &pool_ops;
> > > +       pool->ops =3D &pool_ops;
> > >
> > > -       return mgr;
> > > +       return pool;
> > >  }
> > >
> > >  /*
> > > @@ -1174,33 +1173,6 @@ static bool optee_msg_exchange_capabilities(opte=
e_invoke_fn *invoke_fn,
> > >         return true;
> > >  }
> > >
> > > -static struct tee_shm_pool *optee_config_dyn_shm(void)
> > > -{
> > > -       struct tee_shm_pool_mgr *priv_mgr;
> > > -       struct tee_shm_pool_mgr *dmabuf_mgr;
> > > -       void *rc;
> > > -
> > > -       rc =3D optee_shm_pool_alloc_pages();
> > > -       if (IS_ERR(rc))
> > > -               return rc;
> > > -       priv_mgr =3D rc;
> > > -
> > > -       rc =3D optee_shm_pool_alloc_pages();
> > > -       if (IS_ERR(rc)) {
> > > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > > -               return rc;
> > > -       }
> > > -       dmabuf_mgr =3D rc;
> > > -
> > > -       rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > > -       if (IS_ERR(rc)) {
> > > -               tee_shm_pool_mgr_destroy(priv_mgr);
> > > -               tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > > -       }
> > > -
> > > -       return rc;
> > > -}
> > > -
> > >  static struct tee_shm_pool *
> > >  optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremape=
d_shm)
> > >  {
> > > @@ -1214,10 +1186,7 @@ optee_config_shm_memremap(optee_invoke_fn *invok=
e_fn, void **memremaped_shm)
> > >         phys_addr_t begin;
> > >         phys_addr_t end;
> > >         void *va;
> > > -       struct tee_shm_pool_mgr *priv_mgr;
> > > -       struct tee_shm_pool_mgr *dmabuf_mgr;
> > >         void *rc;
> > > -       const int sz =3D OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> > >
> > >         invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.s=
mccc);
> > >         if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
> > > @@ -1235,11 +1204,6 @@ optee_config_shm_memremap(optee_invoke_fn *invok=
e_fn, void **memremaped_shm)
> > >         paddr =3D begin;
> > >         size =3D end - begin;
> > >
> > > -       if (size < 2 * OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE) {
> > > -               pr_err("too small shared memory area\n");
> > > -               return ERR_PTR(-EINVAL);
> > > -       }
> > > -
> > >         va =3D memremap(paddr, size, MEMREMAP_WB);
> > >         if (!va) {
> > >                 pr_err("shared memory ioremap failed\n");
> > > @@ -1247,35 +1211,13 @@ optee_config_shm_memremap(optee_invoke_fn *invo=
ke_fn, void **memremaped_shm)
> > >         }
> > >         vaddr =3D (unsigned long)va;
> > >
> > > -       rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
> > > -                                           3 /* 8 bytes aligned */);
> > > -       if (IS_ERR(rc))
> > > -               goto err_memunmap;
> > > -       priv_mgr =3D rc;
> > > -
> > > -       vaddr +=3D sz;
> > > -       paddr +=3D sz;
> > > -       size -=3D sz;
> > > -
> > > -       rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_=
SHIFT);
> > > +       rc =3D tee_shm_pool_alloc_res_mem(vaddr, paddr, size,
> > > +                                       9 /* 512 bytes aligned */);
> >
> > Here you are specifying minimal allocation alignment to be 512 bytes?
> > Wouldn't it be inefficient corresponding to 8 bytes aligned OP-TEE
> > private memory allocation earlier?
>
> I hope I've been able to address this above.
>
> Thanks,
> Jens
>
> >
> > -Sumit
> >
> > >         if (IS_ERR(rc))
> > > -               goto err_free_priv_mgr;
> > > -       dmabuf_mgr =3D rc;
> > > -
> > > -       rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > > -       if (IS_ERR(rc))
> > > -               goto err_free_dmabuf_mgr;
> > > -
> > > -       *memremaped_shm =3D va;
> > > -
> > > -       return rc;
> > > +               memunmap(va);
> > > +       else
> > > +               *memremaped_shm =3D va;
> > >
> > > -err_free_dmabuf_mgr:
> > > -       tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > > -err_free_priv_mgr:
> > > -       tee_shm_pool_mgr_destroy(priv_mgr);
> > > -err_memunmap:
> > > -       memunmap(va);
> > >         return rc;
> > >  }
> > >
> > > @@ -1396,7 +1338,7 @@ static int optee_probe(struct platform_device *pd=
ev)
> > >          * Try to use dynamic shared memory if possible
> > >          */
> > >         if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> > > -               pool =3D optee_config_dyn_shm();
> > > +               pool =3D optee_shm_pool_alloc_pages();
> > >
> > >         /*
> > >          * If dynamic shared memory is not available or failed - try st=
atic one
> > > diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> > > index e55204df31ce..72376cf38bc0 100644
> > > --- a/drivers/tee/tee_private.h
> > > +++ b/drivers/tee/tee_private.h
> > > @@ -12,17 +12,6 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/types.h>
> > >
> > > -/**
> > > - * struct tee_shm_pool - shared memory pool
> > > - * @private_mgr:       pool manager for shared memory only between ker=
nel
> > > - *                     and secure world
> > > - * @dma_buf_mgr:       pool manager for shared memory exported to user=
 space
> > > - */
> > > -struct tee_shm_pool {
> > > -       struct tee_shm_pool_mgr *private_mgr;
> > > -       struct tee_shm_pool_mgr *dma_buf_mgr;
> > > -};
> > > -
> > >  #define TEE_DEVICE_FLAG_REGISTERED     0x1
> > >  #define TEE_MAX_DEV_NAME_LEN           32
> > >
> > > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > > index b43178986985..2c8ce0c6801a 100644
> > > --- a/drivers/tee/tee_shm.c
> > > +++ b/drivers/tee/tee_shm.c
> > > @@ -31,14 +31,7 @@ static void release_registered_pages(struct tee_shm =
*shm)
> > >  static void tee_shm_release(struct tee_device *teedev, struct tee_shm =
*shm)
> > >  {
> > >         if (shm->flags & TEE_SHM_POOL) {
> > > -               struct tee_shm_pool_mgr *poolm;
> > > -
> > > -               if (shm->flags & TEE_SHM_DMA_BUF)
> > > -                       poolm =3D teedev->pool->dma_buf_mgr;
> > > -               else
> > > -                       poolm =3D teedev->pool->private_mgr;
> > > -
> > > -               poolm->ops->free(poolm, shm);
> > > +               teedev->pool->ops->free(teedev->pool, shm);
> > >         } else if (shm->flags & TEE_SHM_REGISTER) {
> > >                 int rc =3D teedev->desc->ops->shm_unregister(shm->ctx, =
shm);
> > >
> > > @@ -59,8 +52,8 @@ static void tee_shm_release(struct tee_device *teedev=
, struct tee_shm *shm)
> > >  struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u3=
2 flags)
> > >  {
> > >         struct tee_device *teedev =3D ctx->teedev;
> > > -       struct tee_shm_pool_mgr *poolm =3D NULL;
> > >         struct tee_shm *shm;
> > > +       size_t align;
> > >         void *ret;
> > >         int rc;
> > >
> > > @@ -93,12 +86,18 @@ struct tee_shm *tee_shm_alloc(struct tee_context *c=
tx, size_t size, u32 flags)
> > >         refcount_set(&shm->refcount, 1);
> > >         shm->flags =3D flags | TEE_SHM_POOL;
> > >         shm->ctx =3D ctx;
> > > -       if (flags & TEE_SHM_DMA_BUF)
> > > -               poolm =3D teedev->pool->dma_buf_mgr;
> > > -       else
> > > -               poolm =3D teedev->pool->private_mgr;
> > > +       if (flags & TEE_SHM_DMA_BUF) {
> > > +               align =3D PAGE_SIZE;
> > > +               /*
> > > +                * Request to register the shm in the pool allocator be=
low
> > > +                * if supported.
> > > +                */
> > > +               shm->flags |=3D TEE_SHM_REGISTER;
> > > +       } else {
> > > +               align =3D 2 * sizeof(long);
> > > +       }
> > >
> > > -       rc =3D poolm->ops->alloc(poolm, shm, size);
> > > +       rc =3D teedev->pool->ops->alloc(teedev->pool, shm, size, align);
> > >         if (rc) {
> > >                 ret =3D ERR_PTR(rc);
> > >                 goto err_kfree;
> > > @@ -118,7 +117,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *c=
tx, size_t size, u32 flags)
> > >
> > >         return shm;
> > >  err_pool_free:
> > > -       poolm->ops->free(poolm, shm);
> > > +       teedev->pool->ops->free(teedev->pool, shm);
> > >  err_kfree:
> > >         kfree(shm);
> > >  err_dev_put:
> > > diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> > > index 0e460347138a..71e0f8ae69aa 100644
> > > --- a/drivers/tee/tee_shm_pool.c
> > > +++ b/drivers/tee/tee_shm_pool.c
> > > @@ -9,14 +9,16 @@
> > >  #include <linux/tee_drv.h>
> > >  #include "tee_private.h"
> > >
> > > -static int pool_op_gen_alloc(struct tee_shm_pool_mgr *poolm,
> > > -                            struct tee_shm *shm, size_t size)
> > > +static int pool_op_gen_alloc(struct tee_shm_pool *pool, struct tee_shm=
 *shm,
> > > +                            size_t size, size_t align)
> > >  {
> > >         unsigned long va;
> > > -       struct gen_pool *genpool =3D poolm->private_data;
> > > -       size_t s =3D roundup(size, 1 << genpool->min_alloc_order);
> > > +       struct gen_pool *genpool =3D pool->private_data;
> > > +       size_t a =3D max_t(size_t, align, BIT(genpool->min_alloc_order)=
);
> > > +       struct genpool_data_align data =3D { .align =3D a };
> > > +       size_t s =3D roundup(size, a);
> > >
> > > -       va =3D gen_pool_alloc(genpool, s);
> > > +       va =3D gen_pool_alloc_algo(genpool, s, gen_pool_first_fit_align=
, &data);
> > >         if (!va)
> > >                 return -ENOMEM;
> > >
> > > @@ -24,107 +26,67 @@ static int pool_op_gen_alloc(struct tee_shm_pool_m=
gr *poolm,
> > >         shm->kaddr =3D (void *)va;
> > >         shm->paddr =3D gen_pool_virt_to_phys(genpool, va);
> > >         shm->size =3D s;
> > > +       /*
> > > +        * This is from a static shared memory pool so no need to regis=
ter
> > > +        * each chunk, and no need to unregister later either.
> > > +        */
> > > +       shm->flags &=3D ~TEE_SHM_REGISTER;
> > >         return 0;
> > >  }
> > >
> > > -static void pool_op_gen_free(struct tee_shm_pool_mgr *poolm,
> > > -                            struct tee_shm *shm)
> > > +static void pool_op_gen_free(struct tee_shm_pool *pool, struct tee_shm=
 *shm)
> > >  {
> > > -       gen_pool_free(poolm->private_data, (unsigned long)shm->kaddr,
> > > +       gen_pool_free(pool->private_data, (unsigned long)shm->kaddr,
> > >                       shm->size);
> > >         shm->kaddr =3D NULL;
> > >  }
> > >
> > > -static void pool_op_gen_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > > +static void pool_op_gen_destroy_pool(struct tee_shm_pool *pool)
> > >  {
> > > -       gen_pool_destroy(poolm->private_data);
> > > -       kfree(poolm);
> > > +       gen_pool_destroy(pool->private_data);
> > > +       kfree(pool);
> > >  }
> > >
> > > -static const struct tee_shm_pool_mgr_ops pool_ops_generic =3D {
> > > +static const struct tee_shm_pool_ops pool_ops_generic =3D {
> > >         .alloc =3D pool_op_gen_alloc,
> > >         .free =3D pool_op_gen_free,
> > > -       .destroy_poolmgr =3D pool_op_gen_destroy_poolmgr,
> > > +       .destroy_pool =3D pool_op_gen_destroy_pool,
> > >  };
> > >
> > > -struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long =
vaddr,
> > > -                                                       phys_addr_t pad=
dr,
> > > -                                                       size_t size,
> > > -                                                       int min_alloc_o=
rder)
> > > +struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
> > > +                                               phys_addr_t paddr, size=
_t size,
> > > +                                               int min_alloc_order)
> > >  {
> > >         const size_t page_mask =3D PAGE_SIZE - 1;
> > > -       struct tee_shm_pool_mgr *mgr;
> > > +       struct tee_shm_pool *pool;
> > >         int rc;
> > >
> > >         /* Start and end must be page aligned */
> > >         if (vaddr & page_mask || paddr & page_mask || size & page_mask)
> > >                 return ERR_PTR(-EINVAL);
> > >
> > > -       mgr =3D kzalloc(sizeof(*mgr), GFP_KERNEL);
> > > -       if (!mgr)
> > > +       pool =3D kzalloc(sizeof(*pool), GFP_KERNEL);
> > > +       if (!pool)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       mgr->private_data =3D gen_pool_create(min_alloc_order, -1);
> > > -       if (!mgr->private_data) {
> > > +       pool->private_data =3D gen_pool_create(min_alloc_order, -1);
> > > +       if (!pool->private_data) {
> > >                 rc =3D -ENOMEM;
> > >                 goto err;
> > >         }
> > >
> > > -       gen_pool_set_algo(mgr->private_data, gen_pool_best_fit, NULL);
> > > -       rc =3D gen_pool_add_virt(mgr->private_data, vaddr, paddr, size,=
 -1);
> > > +       rc =3D gen_pool_add_virt(pool->private_data, vaddr, paddr, size=
, -1);
> > >         if (rc) {
> > > -               gen_pool_destroy(mgr->private_data);
> > > +               gen_pool_destroy(pool->private_data);
> > >                 goto err;
> > >         }
> > >
> > > -       mgr->ops =3D &pool_ops_generic;
> > > +       pool->ops =3D &pool_ops_generic;
> > >
> > > -       return mgr;
> > > +       return pool;
> > >  err:
> > > -       kfree(mgr);
> > > +       kfree(pool);
> > >
> > >         return ERR_PTR(rc);
> > >  }
> > > -EXPORT_SYMBOL_GPL(tee_shm_pool_mgr_alloc_res_mem);
> > > -
> > > -static bool check_mgr_ops(struct tee_shm_pool_mgr *mgr)
> > > -{
> > > -       return mgr && mgr->ops && mgr->ops->alloc && mgr->ops->free &&
> > > -               mgr->ops->destroy_poolmgr;
> > > -}
> > > -
> > > -struct tee_shm_pool *tee_shm_pool_alloc(struct tee_shm_pool_mgr *priv_=
mgr,
> > > -                                       struct tee_shm_pool_mgr *dmabuf=
_mgr)
> > > -{
> > > -       struct tee_shm_pool *pool;
> > > -
> > > -       if (!check_mgr_ops(priv_mgr) || !check_mgr_ops(dmabuf_mgr))
> > > -               return ERR_PTR(-EINVAL);
> > > -
> > > -       pool =3D kzalloc(sizeof(*pool), GFP_KERNEL);
> > > -       if (!pool)
> > > -               return ERR_PTR(-ENOMEM);
> > > -
> > > -       pool->private_mgr =3D priv_mgr;
> > > -       pool->dma_buf_mgr =3D dmabuf_mgr;
> > > -
> > > -       return pool;
> > > -}
> > > -EXPORT_SYMBOL_GPL(tee_shm_pool_alloc);
> > > -
> > > -/**
> > > - * tee_shm_pool_free() - Free a shared memory pool
> > > - * @pool:      The shared memory pool to free
> > > - *
> > > - * There must be no remaining shared memory allocated from this pool w=
hen
> > > - * this function is called.
> > > - */
> > > -void tee_shm_pool_free(struct tee_shm_pool *pool)
> > > -{
> > > -       if (pool->private_mgr)
> > > -               tee_shm_pool_mgr_destroy(pool->private_mgr);
> > > -       if (pool->dma_buf_mgr)
> > > -               tee_shm_pool_mgr_destroy(pool->dma_buf_mgr);
> > > -       kfree(pool);
> > > -}
> > > -EXPORT_SYMBOL_GPL(tee_shm_pool_free);
> > > +EXPORT_SYMBOL_GPL(tee_shm_pool_alloc_res_mem);
> > > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > > index 26b450484ac1..808aa23308c2 100644
> > > --- a/include/linux/tee_drv.h
> > > +++ b/include/linux/tee_drv.h
> > > @@ -221,62 +221,39 @@ struct tee_shm {
> > >  };
> > >
> > >  /**
> > > - * struct tee_shm_pool_mgr - shared memory manager
> > > + * struct tee_shm_pool - shared memory pool
> > >   * @ops:               operations
> > >   * @private_data:      private data for the shared memory manager
> > >   */
> > > -struct tee_shm_pool_mgr {
> > > -       const struct tee_shm_pool_mgr_ops *ops;
> > > +struct tee_shm_pool {
> > > +       const struct tee_shm_pool_ops *ops;
> > >         void *private_data;
> > >  };
> > >
> > >  /**
> > > - * struct tee_shm_pool_mgr_ops - shared memory pool manager operations
> > > + * struct tee_shm_pool_ops - shared memory pool operations
> > >   * @alloc:             called when allocating shared memory
> > >   * @free:              called when freeing shared memory
> > > - * @destroy_poolmgr:   called when destroying the pool manager
> > > + * @destroy_pool:      called when destroying the pool
> > >   */
> > > -struct tee_shm_pool_mgr_ops {
> > > -       int (*alloc)(struct tee_shm_pool_mgr *poolmgr, struct tee_shm *=
shm,
> > > -                    size_t size);
> > > -       void (*free)(struct tee_shm_pool_mgr *poolmgr, struct tee_shm *=
shm);
> > > -       void (*destroy_poolmgr)(struct tee_shm_pool_mgr *poolmgr);
> > > +struct tee_shm_pool_ops {
> > > +       int (*alloc)(struct tee_shm_pool *pool, struct tee_shm *shm,
> > > +                    size_t size, size_t align);
> > > +       void (*free)(struct tee_shm_pool *pool, struct tee_shm *shm);
> > > +       void (*destroy_pool)(struct tee_shm_pool *pool);
> > >  };
> > >
> > > -/**
> > > - * tee_shm_pool_alloc() - Create a shared memory pool from shm managers
> > > - * @priv_mgr:  manager for driver private shared memory allocations
> > > - * @dmabuf_mgr:        manager for dma-buf shared memory allocations
> > > - *
> > > - * Allocation with the flag TEE_SHM_DMA_BUF set will use the range sup=
plied
> > > - * in @dmabuf, others will use the range provided by @priv.
> > > - *
> > > - * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failur=
e.
> > > - */
> > > -struct tee_shm_pool *tee_shm_pool_alloc(struct tee_shm_pool_mgr *priv_=
mgr,
> > > -                                       struct tee_shm_pool_mgr *dmabuf=
_mgr);
> > > -
> > >  /*
> > > - * tee_shm_pool_mgr_alloc_res_mem() - Create a shm manager for reserved
> > > - * memory
> > > + * tee_shm_pool_alloc_res_mem() - Create a shm manager for reserved me=
mory
> > >   * @vaddr:     Virtual address of start of pool
> > >   * @paddr:     Physical address of start of pool
> > >   * @size:      Size in bytes of the pool
> > >   *
> > > - * @returns pointer to a 'struct tee_shm_pool_mgr' or an ERR_PTR on fa=
ilure.
> > > - */
> > > -struct tee_shm_pool_mgr *tee_shm_pool_mgr_alloc_res_mem(unsigned long =
vaddr,
> > > -                                                       phys_addr_t pad=
dr,
> > > -                                                       size_t size,
> > > -                                                       int min_alloc_o=
rder);
> > > -
> > > -/**
> > > - * tee_shm_pool_mgr_destroy() - Free a shared memory manager
> > > + * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failur=
e.
> > >   */
> > > -static inline void tee_shm_pool_mgr_destroy(struct tee_shm_pool_mgr *p=
oolm)
> > > -{
> > > -       poolm->ops->destroy_poolmgr(poolm);
> > > -}
> > > +struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
> > > +                                               phys_addr_t paddr, size=
_t size,
> > > +                                               int min_alloc_order);
> > >
> > >  /**
> > >   * tee_shm_pool_free() - Free a shared memory pool
> > > @@ -285,7 +262,10 @@ static inline void tee_shm_pool_mgr_destroy(struct=
 tee_shm_pool_mgr *poolm)
> > >   * The must be no remaining shared memory allocated from this pool when
> > >   * this function is called.
> > >   */
> > > -void tee_shm_pool_free(struct tee_shm_pool *pool);
> > > +static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
> > > +{
> > > +       pool->ops->destroy_pool(pool);
> > > +}
> > >
> > >  /**
> > >   * tee_get_drvdata() - Return driver_data pointer
> > > --
> > > 2.31.1
> > >

--===============1734937379375894075==--

