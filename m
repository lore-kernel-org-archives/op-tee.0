From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v6 09/10] optee: FF-A: dynamic restricted memory allocation
Date: Tue, 01 Apr 2025 15:43:05 +0530
Message-ID: <Z-u8MWNVNy9lLbkK@sumit-X1>
In-Reply-To: <
 <CAHUa44H1MzBLBM+Oeawca52C8PF3uAT0ggbL-zRdnBqj4LYrZg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4812023180951698904=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4812023180951698904==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+ MM folks to seek guidance here.

On Thu, Mar 27, 2025 at 09:07:34AM +0100, Jens Wiklander wrote:
> Hi Sumit,
>=20
> On Tue, Mar 25, 2025 at 8:42=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org=
> wrote:
> >
> > On Wed, Mar 05, 2025 at 02:04:15PM +0100, Jens Wiklander wrote:
> > > Add support in the OP-TEE backend driver dynamic restricted memory
> > > allocation with FF-A.
> > >
> > > The restricted memory pools for dynamically allocated restrict memory
> > > are instantiated when requested by user-space. This instantiation can
> > > fail if OP-TEE doesn't support the requested use-case of restricted
> > > memory.
> > >
> > > Restricted memory pools based on a static carveout or dynamic allocation
> > > can coexist for different use-cases. We use only dynamic allocation with
> > > FF-A.
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/tee/optee/Makefile        |   1 +
> > >  drivers/tee/optee/ffa_abi.c       | 143 ++++++++++++-
> > >  drivers/tee/optee/optee_private.h |  13 +-
> > >  drivers/tee/optee/rstmem.c        | 329 ++++++++++++++++++++++++++++++
> > >  4 files changed, 483 insertions(+), 3 deletions(-)
> > >  create mode 100644 drivers/tee/optee/rstmem.c
> > >

<snip>

> > > diff --git a/drivers/tee/optee/rstmem.c b/drivers/tee/optee/rstmem.c
> > > new file mode 100644
> > > index 000000000000..ea27769934d4
> > > --- /dev/null
> > > +++ b/drivers/tee/optee/rstmem.c
> > > @@ -0,0 +1,329 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2025, Linaro Limited
> > > + */
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/errno.h>
> > > +#include <linux/genalloc.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/string.h>
> > > +#include <linux/tee_core.h>
> > > +#include <linux/types.h>
> > > +#include "optee_private.h"
> > > +
> > > +struct optee_rstmem_cma_pool {
> > > +     struct tee_rstmem_pool pool;
> > > +     struct gen_pool *gen_pool;
> > > +     struct optee *optee;
> > > +     size_t page_count;
> > > +     u16 *end_points;
> > > +     u_int end_point_count;
> > > +     u_int align;
> > > +     refcount_t refcount;
> > > +     u32 use_case;
> > > +     struct tee_shm *rstmem;
> > > +     /* Protects when initializing and tearing down this struct */
> > > +     struct mutex mutex;
> > > +};
> > > +
> > > +static struct optee_rstmem_cma_pool *
> > > +to_rstmem_cma_pool(struct tee_rstmem_pool *pool)
> > > +{
> > > +     return container_of(pool, struct optee_rstmem_cma_pool, pool);
> > > +}
> > > +
> > > +static int init_cma_rstmem(struct optee_rstmem_cma_pool *rp)
> > > +{
> > > +     int rc;
> > > +
> > > +     rp->rstmem =3D tee_shm_alloc_cma_phys_mem(rp->optee->ctx, rp->pag=
e_count,
> > > +                                             rp->align);
> > > +     if (IS_ERR(rp->rstmem)) {
> > > +             rc =3D PTR_ERR(rp->rstmem);
> > > +             goto err_null_rstmem;
> > > +     }
> > > +
> > > +     /*
> > > +      * TODO unmap the memory range since the physical memory will
> > > +      * become inaccesible after the lend_rstmem() call.
> > > +      */
> >
> > What's your plan for this TODO? I think we need a CMA allocator here
> > which can allocate un-mapped memory such that any cache speculation
> > won't lead to CPU hangs once the memory restriction comes into picture.
>=20
> What happens is platform-specific. For some platforms, it might be
> enough to avoid explicit access. Yes, a CMA allocator with unmapped
> memory or where memory can be unmapped is one option.

Did you get a chance to enable real memory protection on RockPi board?
This will atleast ensure that mapped restricted memory without explicit
access works fine. Since otherwise once people start to enable real
memory restriction in OP-TEE, there can be chances of random hang ups
due to cache speculation.

MM folks,

Basically what we are trying to achieve here is a "no-map" DT behaviour
[1] which is rather dynamic in  nature. The use-case here is that a memory
block allocated from CMA can be marked restricted at runtime where we
would like the Linux not being able to directly or indirectly (cache
speculation) access it. Once memory restriction use-case has been
completed, the memory block can be marked as normal and freed for
further CMA allocation.

It will be apprciated if you can guide us regarding the appropriate APIs
to use for un-mapping/mamping CMA allocations for this use-case.

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/re=
served-memory/reserved-memory.yaml#L79

-Sumit

>=20
> >
> > > +     rc =3D rp->optee->ops->lend_rstmem(rp->optee, rp->rstmem, rp->end=
_points,
> > > +                                      rp->end_point_count, rp->use_cas=
e);
> > > +     if (rc)
> > > +             goto err_put_shm;
> > > +     rp->rstmem->flags |=3D TEE_SHM_DYNAMIC;
> > > +
> > > +     rp->gen_pool =3D gen_pool_create(PAGE_SHIFT, -1);
> > > +     if (!rp->gen_pool) {
> > > +             rc =3D -ENOMEM;
> > > +             goto err_reclaim;
> > > +     }
> > > +
> > > +     rc =3D gen_pool_add(rp->gen_pool, rp->rstmem->paddr,
> > > +                       rp->rstmem->size, -1);
> > > +     if (rc)
> > > +             goto err_free_pool;
> > > +
> > > +     refcount_set(&rp->refcount, 1);
> > > +     return 0;
> > > +
> > > +err_free_pool:
> > > +     gen_pool_destroy(rp->gen_pool);
> > > +     rp->gen_pool =3D NULL;
> > > +err_reclaim:
> > > +     rp->optee->ops->reclaim_rstmem(rp->optee, rp->rstmem);
> > > +err_put_shm:
> > > +     tee_shm_put(rp->rstmem);
> > > +err_null_rstmem:
> > > +     rp->rstmem =3D NULL;
> > > +     return rc;
> > > +}
> > > +
> > > +static int get_cma_rstmem(struct optee_rstmem_cma_pool *rp)
> > > +{
> > > +     int rc =3D 0;
> > > +
> > > +     if (!refcount_inc_not_zero(&rp->refcount)) {
> > > +             mutex_lock(&rp->mutex);
> > > +             if (rp->gen_pool) {
> > > +                     /*
> > > +                      * Another thread has already initialized the pool
> > > +                      * before us, or the pool was just about to be to=
rn
> > > +                      * down. Either way we only need to increase the
> > > +                      * refcount and we're done.
> > > +                      */
> > > +                     refcount_inc(&rp->refcount);
> > > +             } else {
> > > +                     rc =3D init_cma_rstmem(rp);
> > > +             }
> > > +             mutex_unlock(&rp->mutex);
> > > +     }
> > > +
> > > +     return rc;
> > > +}
> > > +
> > > +static void release_cma_rstmem(struct optee_rstmem_cma_pool *rp)
> > > +{
> > > +     gen_pool_destroy(rp->gen_pool);
> > > +     rp->gen_pool =3D NULL;
> > > +
> > > +     rp->optee->ops->reclaim_rstmem(rp->optee, rp->rstmem);
> > > +     rp->rstmem->flags &=3D ~TEE_SHM_DYNAMIC;
> > > +
> > > +     WARN(refcount_read(&rp->rstmem->refcount) !=3D 1, "Unexpected ref=
count");
> > > +     tee_shm_put(rp->rstmem);
> > > +     rp->rstmem =3D NULL;
> > > +}
> > > +
> > > +static void put_cma_rstmem(struct optee_rstmem_cma_pool *rp)
> > > +{
> > > +     if (refcount_dec_and_test(&rp->refcount)) {
> > > +             mutex_lock(&rp->mutex);
> > > +             if (rp->gen_pool)
> > > +                     release_cma_rstmem(rp);
> > > +             mutex_unlock(&rp->mutex);
> > > +     }
> > > +}
> > > +
> > > +static int rstmem_pool_op_cma_alloc(struct tee_rstmem_pool *pool,
> > > +                                 struct sg_table *sgt, size_t size,
> > > +                                 size_t *offs)
> > > +{
> > > +     struct optee_rstmem_cma_pool *rp =3D to_rstmem_cma_pool(pool);
> > > +     size_t sz =3D ALIGN(size, PAGE_SIZE);
> > > +     phys_addr_t pa;
> > > +     int rc;
> > > +
> > > +     rc =3D get_cma_rstmem(rp);
> > > +     if (rc)
> > > +             return rc;
> > > +
> > > +     pa =3D gen_pool_alloc(rp->gen_pool, sz);
> > > +     if (!pa) {
> > > +             rc =3D -ENOMEM;
> > > +             goto err_put;
> > > +     }
> > > +
> > > +     rc =3D sg_alloc_table(sgt, 1, GFP_KERNEL);
> > > +     if (rc)
> > > +             goto err_free;
> > > +
> > > +     sg_set_page(sgt->sgl, phys_to_page(pa), size, 0);
> > > +     *offs =3D pa - rp->rstmem->paddr;
> > > +
> > > +     return 0;
> > > +err_free:
> > > +     gen_pool_free(rp->gen_pool, pa, size);
> > > +err_put:
> > > +     put_cma_rstmem(rp);
> > > +
> > > +     return rc;
> > > +}
> > > +
> > > +static void rstmem_pool_op_cma_free(struct tee_rstmem_pool *pool,
> > > +                                 struct sg_table *sgt)
> > > +{
> > > +     struct optee_rstmem_cma_pool *rp =3D to_rstmem_cma_pool(pool);
> > > +     struct scatterlist *sg;
> > > +     int i;
> > > +
> > > +     for_each_sgtable_sg(sgt, sg, i)
> > > +             gen_pool_free(rp->gen_pool, sg_phys(sg), sg->length);
> > > +     sg_free_table(sgt);
> > > +     put_cma_rstmem(rp);
> > > +}
> > > +
> > > +static int rstmem_pool_op_cma_update_shm(struct tee_rstmem_pool *pool,
> > > +                                      struct sg_table *sgt, size_t off=
s,
> > > +                                      struct tee_shm *shm,
> > > +                                      struct tee_shm **parent_shm)
> > > +{
> > > +     struct optee_rstmem_cma_pool *rp =3D to_rstmem_cma_pool(pool);
> > > +
> > > +     *parent_shm =3D rp->rstmem;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void pool_op_cma_destroy_pool(struct tee_rstmem_pool *pool)
> > > +{
> > > +     struct optee_rstmem_cma_pool *rp =3D to_rstmem_cma_pool(pool);
> > > +
> > > +     mutex_destroy(&rp->mutex);
> > > +     kfree(rp);
> > > +}
> > > +
> > > +static struct tee_rstmem_pool_ops rstmem_pool_ops_cma =3D {
> > > +     .alloc =3D rstmem_pool_op_cma_alloc,
> > > +     .free =3D rstmem_pool_op_cma_free,
> > > +     .update_shm =3D rstmem_pool_op_cma_update_shm,
> > > +     .destroy_pool =3D pool_op_cma_destroy_pool,
> > > +};
> > > +
> > > +static int get_rstmem_config(struct optee *optee, u32 use_case,
> > > +                          size_t *min_size, u_int *min_align,
> > > +                          u16 *end_points, u_int *ep_count)
> >
> > I guess this end points terminology is specific to FF-A ABI. Is there
> > any relevance for this in the common APIs?
>=20
> Yes, endpoints are specific to FF-A ABI. The list of end-points must
> be presented to FFA_MEM_LEND. We're relying on the secure world to
> know which endpoints are needed for a specific use case.
>=20
> Cheers,
> Jens
>=20
> >
> > -Sumit
> >
> > > +{
> > > +     struct tee_param params[2] =3D {
> > > +             [0] =3D {
> > > +                     .attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT,
> > > +                     .u.value.a =3D use_case,
> > > +             },
> > > +             [1] =3D {
> > > +                     .attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT,
> > > +             },
> > > +     };
> > > +     struct optee_shm_arg_entry *entry;
> > > +     struct tee_shm *shm_param =3D NULL;
> > > +     struct optee_msg_arg *msg_arg;
> > > +     struct tee_shm *shm;
> > > +     u_int offs;
> > > +     int rc;
> > > +
> > > +     if (end_points && *ep_count) {
> > > +             params[1].u.memref.size =3D *ep_count * sizeof(*end_point=
s);
> > > +             shm_param =3D tee_shm_alloc_priv_buf(optee->ctx,
> > > +                                                params[1].u.memref.siz=
e);
> > > +             if (IS_ERR(shm_param))
> > > +                     return PTR_ERR(shm_param);
> > > +             params[1].u.memref.shm =3D shm_param;
> > > +     }
> > > +
> > > +     msg_arg =3D optee_get_msg_arg(optee->ctx, ARRAY_SIZE(params), &en=
try,
> > > +                                 &shm, &offs);
> > > +     if (IS_ERR(msg_arg)) {
> > > +             rc =3D PTR_ERR(msg_arg);
> > > +             goto out_free_shm;
> > > +     }
> > > +     msg_arg->cmd =3D OPTEE_MSG_CMD_GET_RSTMEM_CONFIG;
> > > +
> > > +     rc =3D optee->ops->to_msg_param(optee, msg_arg->params,
> > > +                                   ARRAY_SIZE(params), params,
> > > +                                   false /*!update_out*/);
> > > +     if (rc)
> > > +             goto out_free_msg;
> > > +
> > > +     rc =3D optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
> > > +     if (rc)
> > > +             goto out_free_msg;
> > > +     if (msg_arg->ret && msg_arg->ret !=3D TEEC_ERROR_SHORT_BUFFER) {
> > > +             rc =3D -EINVAL;
> > > +             goto out_free_msg;
> > > +     }
> > > +
> > > +     rc =3D optee->ops->from_msg_param(optee, params, ARRAY_SIZE(param=
s),
> > > +                                     msg_arg->params, true /*update_ou=
t*/);
> > > +     if (rc)
> > > +             goto out_free_msg;
> > > +
> > > +     if (!msg_arg->ret && end_points &&
> > > +         *ep_count < params[1].u.memref.size / sizeof(u16)) {
> > > +             rc =3D -EINVAL;
> > > +             goto out_free_msg;
> > > +     }
> > > +
> > > +     *min_size =3D params[0].u.value.a;
> > > +     *min_align =3D params[0].u.value.b;
> > > +     *ep_count =3D params[1].u.memref.size / sizeof(u16);
> > > +
> > > +     if (msg_arg->ret =3D=3D TEEC_ERROR_SHORT_BUFFER) {
> > > +             rc =3D -ENOSPC;
> > > +             goto out_free_msg;
> > > +     }
> > > +
> > > +     if (end_points)
> > > +             memcpy(end_points, tee_shm_get_va(shm_param, 0),
> > > +                    params[1].u.memref.size);
> > > +
> > > +out_free_msg:
> > > +     optee_free_msg_arg(optee->ctx, entry, offs);
> > > +out_free_shm:
> > > +     if (shm_param)
> > > +             tee_shm_free(shm_param);
> > > +     return rc;
> > > +}
> > > +
> > > +struct tee_rstmem_pool *optee_rstmem_alloc_cma_pool(struct optee *opte=
e,
> > > +                                                 enum tee_dma_heap_id =
id)
> > > +{
> > > +     struct optee_rstmem_cma_pool *rp;
> > > +     u32 use_case =3D id;
> > > +     size_t min_size;
> > > +     int rc;
> > > +
> > > +     rp =3D kzalloc(sizeof(*rp), GFP_KERNEL);
> > > +     if (!rp)
> > > +             return ERR_PTR(-ENOMEM);
> > > +     rp->use_case =3D use_case;
> > > +
> > > +     rc =3D get_rstmem_config(optee, use_case, &min_size, &rp->align, =
NULL,
> > > +                            &rp->end_point_count);
> > > +     if (rc) {
> > > +             if (rc !=3D -ENOSPC)
> > > +                     goto err;
> > > +             rp->end_points =3D kcalloc(rp->end_point_count,
> > > +                                      sizeof(*rp->end_points), GFP_KER=
NEL);
> > > +             if (!rp->end_points) {
> > > +                     rc =3D -ENOMEM;
> > > +                     goto err;
> > > +             }
> > > +             rc =3D get_rstmem_config(optee, use_case, &min_size, &rp-=
>align,
> > > +                                    rp->end_points, &rp->end_point_cou=
nt);
> > > +             if (rc)
> > > +                     goto err_kfree_eps;
> > > +     }
> > > +
> > > +     rp->pool.ops =3D &rstmem_pool_ops_cma;
> > > +     rp->optee =3D optee;
> > > +     rp->page_count =3D min_size / PAGE_SIZE;
> > > +     mutex_init(&rp->mutex);
> > > +
> > > +     return &rp->pool;
> > > +
> > > +err_kfree_eps:
> > > +     kfree(rp->end_points);
> > > +err:
> > > +     kfree(rp);
> > > +     return ERR_PTR(rc);
> > > +}
> > > --
> > > 2.43.0
> > >

--===============4812023180951698904==--

