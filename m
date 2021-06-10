From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/7] tee: simplify shm pool handling
Date: Thu, 10 Jun 2021 11:01:34 +0200
Message-ID: <20210610090134.GD2753553@jade>
In-Reply-To: <20210609145004.GF4910@sequoia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8610197499182927863=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8610197499182927863==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 09:50:04AM -0500, Tyler Hicks wrote:
> On 2021-06-09 12:23:19, Jens Wiklander wrote:
> > Replaces the shared memory pool based on two pools with a single pool.
> > The alloc() function pointer in struct tee_shm_pool_ops gets another
> > parameter, align. This makes it possible to make less than page aligned
> > allocations from the optional reserved shared memory pool while still
> > making user space allocations page aligned. With in practice unchanged
> > behaviour using only a single pool for bookkeeping.
> >=20
> > The optee and amdtee drivers are updated as needed to work with this
> > changed pool handling.
> >=20
> > This also removes OPTEE_SHM_NUM_PRIV_PAGES which becomes obsolete with
> > this change as the private pages can be mixed with the payload pages.
> >=20
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/amdtee/shm_pool.c |  55 ++++++------------
> >  drivers/tee/optee/Kconfig     |   8 ---
> >  drivers/tee/optee/core.c      |  72 +++--------------------
> >  drivers/tee/optee/shm_pool.c  |  51 ++++++++++-------
> >  drivers/tee/optee/shm_pool.h  |   2 +-
> >  drivers/tee/tee_private.h     |  11 ----
> >  drivers/tee/tee_shm.c         |  29 +++++-----
> >  drivers/tee/tee_shm_pool.c    | 104 +++++++++++-----------------------
> >  include/linux/tee_drv.h       |  58 +++++++------------
> >  9 files changed, 120 insertions(+), 270 deletions(-)
> >=20
> > diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
> > index 065854e2db18..81c23f30b455 100644
> > --- a/drivers/tee/amdtee/shm_pool.c
> > +++ b/drivers/tee/amdtee/shm_pool.c
> > @@ -8,13 +8,17 @@
> >  #include <linux/psp-sev.h>
> >  #include "amdtee_private.h"
> > =20
> > -static int pool_op_alloc(struct tee_shm_pool_mgr *poolm, struct tee_shm =
*shm,
> > -			 size_t size)
> > +static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
> > +			 size_t size, u_int align)
> >  {
> >  	unsigned int order =3D get_order(size);
> >  	unsigned long va;
> >  	int rc;
> > =20
> > +	/*
> > +	 * Ignore alignment since this is already going to be page aligned
> > +	 * and there's no need for any larger alignment.
> > +	 */
> >  	va =3D __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> >  	if (!va)
> >  		return -ENOMEM;
> > @@ -34,7 +38,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm=
, struct tee_shm *shm,
> >  	return 0;
> >  }
> > =20
> > -static void pool_op_free(struct tee_shm_pool_mgr *poolm, struct tee_shm =
*shm)
> > +static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
> >  {
> >  	/* Unmap the shared memory from TEE */
> >  	amdtee_unmap_shmem(shm);
> > @@ -42,52 +46,25 @@ static void pool_op_free(struct tee_shm_pool_mgr *poo=
lm, struct tee_shm *shm)
> >  	shm->kaddr =3D NULL;
> >  }
> > =20
> > -static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > +static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> >  {
> > -	kfree(poolm);
> > +	kfree(pool);
> >  }
> > =20
> > -static const struct tee_shm_pool_mgr_ops pool_ops =3D {
> > +static const struct tee_shm_pool_ops pool_ops =3D {
> >  	.alloc =3D pool_op_alloc,
> >  	.free =3D pool_op_free,
> > -	.destroy_poolmgr =3D pool_op_destroy_poolmgr,
> > +	.destroy_pool =3D pool_op_destroy_pool,
> >  };
> > =20
> > -static struct tee_shm_pool_mgr *pool_mem_mgr_alloc(void)
> > -{
> > -	struct tee_shm_pool_mgr *mgr =3D kzalloc(sizeof(*mgr), GFP_KERNEL);
> > -
> > -	if (!mgr)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -	mgr->ops =3D &pool_ops;
> > -
> > -	return mgr;
> > -}
> > -
> >  struct tee_shm_pool *amdtee_config_shm(void)
> >  {
> > -	struct tee_shm_pool_mgr *priv_mgr;
> > -	struct tee_shm_pool_mgr *dmabuf_mgr;
> > -	void *rc;
> > +	struct tee_shm_pool *pool =3D kzalloc(sizeof(*pool), GFP_KERNEL);
> > =20
> > -	rc =3D pool_mem_mgr_alloc();
> > -	if (IS_ERR(rc))
> > -		return rc;
> > -	priv_mgr =3D rc;
> > -
> > -	rc =3D pool_mem_mgr_alloc();
> > -	if (IS_ERR(rc)) {
> > -		tee_shm_pool_mgr_destroy(priv_mgr);
> > -		return rc;
> > -	}
> > -	dmabuf_mgr =3D rc;
> > +	if (!pool)
> > +		return ERR_PTR(-ENOMEM);
> > =20
> > -	rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -	if (IS_ERR(rc)) {
> > -		tee_shm_pool_mgr_destroy(priv_mgr);
> > -		tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -	}
> > +	pool->ops =3D &pool_ops;
> > =20
> > -	return rc;
> > +	return pool;
> >  }
> > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > index 3ca71e3812ed..f121c224e682 100644
> > --- a/drivers/tee/optee/Kconfig
> > +++ b/drivers/tee/optee/Kconfig
> > @@ -7,11 +7,3 @@ config OPTEE
> >  	help
> >  	  This implements the OP-TEE Trusted Execution Environment (TEE)
> >  	  driver.
> > -
> > -config OPTEE_SHM_NUM_PRIV_PAGES
> > -	int "Private Shared Memory Pages"
> > -	default 1
> > -	depends on OPTEE
> > -	help
> > -	  This sets the number of private shared memory pages to be
> > -	  used by OP-TEE TEE driver.
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index ddb8f9ecf307..0c287345f9fe 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
>=20
> This patch should also remove the #define at the top of core.c:
>=20
> #define OPTEE_SHM_NUM_PRIV_PAGES       CONFIG_OPTEE_SHM_NUM_PRIV_PAGES

Good point, I'll fix.

>=20
> > @@ -428,33 +428,6 @@ static bool optee_msg_exchange_capabilities(optee_in=
voke_fn *invoke_fn,
> >  	return true;
> >  }
> > =20
> > -static struct tee_shm_pool *optee_config_dyn_shm(void)
> > -{
> > -	struct tee_shm_pool_mgr *priv_mgr;
> > -	struct tee_shm_pool_mgr *dmabuf_mgr;
> > -	void *rc;
> > -
> > -	rc =3D optee_shm_pool_alloc_pages();
> > -	if (IS_ERR(rc))
> > -		return rc;
> > -	priv_mgr =3D rc;
> > -
> > -	rc =3D optee_shm_pool_alloc_pages();
> > -	if (IS_ERR(rc)) {
> > -		tee_shm_pool_mgr_destroy(priv_mgr);
> > -		return rc;
> > -	}
> > -	dmabuf_mgr =3D rc;
> > -
> > -	rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -	if (IS_ERR(rc)) {
> > -		tee_shm_pool_mgr_destroy(priv_mgr);
> > -		tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -	}
> > -
> > -	return rc;
> > -}
> > -
> >  static struct tee_shm_pool *
> >  optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_=
shm)
> >  {
> > @@ -468,10 +441,7 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn=
, void **memremaped_shm)
> >  	phys_addr_t begin;
> >  	phys_addr_t end;
> >  	void *va;
> > -	struct tee_shm_pool_mgr *priv_mgr;
> > -	struct tee_shm_pool_mgr *dmabuf_mgr;
> >  	void *rc;
> > -	const int sz =3D OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> > =20
> >  	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
> >  	if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
> > @@ -489,11 +459,6 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn=
, void **memremaped_shm)
> >  	paddr =3D begin;
> >  	size =3D end - begin;
> > =20
> > -	if (size < 2 * OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE) {
> > -		pr_err("too small shared memory area\n");
> > -		return ERR_PTR(-EINVAL);
> > -	}
> > -
> >  	va =3D memremap(paddr, size, MEMREMAP_WB);
> >  	if (!va) {
> >  		pr_err("shared memory ioremap failed\n");
> > @@ -501,35 +466,13 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_f=
n, void **memremaped_shm)
> >  	}
> >  	vaddr =3D (unsigned long)va;
> > =20
> > -	rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
> > -					    3 /* 8 bytes aligned */);
> > -	if (IS_ERR(rc))
> > -		goto err_memunmap;
> > -	priv_mgr =3D rc;
> > -
> > -	vaddr +=3D sz;
> > -	paddr +=3D sz;
> > -	size -=3D sz;
> > -
> > -	rc =3D tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
> > +	rc =3D tee_shm_pool_alloc_res_mem(vaddr, paddr, size,
> > +					9 /* 512 bytes aligned */);
> >  	if (IS_ERR(rc))
> > -		goto err_free_priv_mgr;
> > -	dmabuf_mgr =3D rc;
> > -
> > -	rc =3D tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> > -	if (IS_ERR(rc))
> > -		goto err_free_dmabuf_mgr;
> > -
> > -	*memremaped_shm =3D va;
> > -
> > -	return rc;
> > +		memunmap(va);
> > +	else
> > +		*memremaped_shm =3D va;
> > =20
> > -err_free_dmabuf_mgr:
> > -	tee_shm_pool_mgr_destroy(dmabuf_mgr);
> > -err_free_priv_mgr:
> > -	tee_shm_pool_mgr_destroy(priv_mgr);
> > -err_memunmap:
> > -	memunmap(va);
> >  	return rc;
> >  }
> > =20
> > @@ -637,7 +580,7 @@ static int optee_probe(struct platform_device *pdev)
> >  	 * Try to use dynamic shared memory if possible
> >  	 */
> >  	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> > -		pool =3D optee_config_dyn_shm();
> > +		pool =3D optee_shm_pool_alloc_pages();
> > =20
> >  	/*
> >  	 * If dynamic shared memory is not available or failed - try static one
> > @@ -712,8 +655,7 @@ static int optee_probe(struct platform_device *pdev)
> >  		tee_device_unregister(optee->teedev);
> >  		kfree(optee);
> >  	}
> > -	if (pool)
> > -		tee_shm_pool_free(pool);
> > +	tee_shm_pool_free(pool);
> >  	if (memremaped_shm)
> >  		memunmap(memremaped_shm);
> >  	return rc;
> > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> > index d767eebf30bd..b036714845c1 100644
> > --- a/drivers/tee/optee/shm_pool.c
> > +++ b/drivers/tee/optee/shm_pool.c
> > @@ -12,13 +12,17 @@
> >  #include "optee_smc.h"
> >  #include "shm_pool.h"
> > =20
> > -static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > -			 struct tee_shm *shm, size_t size)
> > +static int pool_op_alloc(struct tee_shm_pool *pool,
> > +			 struct tee_shm *shm, size_t size, u_int align)
> >  {
> >  	unsigned int order =3D get_order(size);
> >  	struct page *page;
> >  	int rc =3D 0;
> > =20
> > +	/*
> > +	 * Ignore alignment since this is already going to be page aligned
> > +	 * and there's no need for any larger alignment.
> > +	 */
> >  	page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> >  	if (!page)
> >  		return -ENOMEM;
> > @@ -27,47 +31,52 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poo=
lm,
> >  	shm->paddr =3D page_to_phys(page);
> >  	shm->size =3D PAGE_SIZE << order;
> > =20
> > -	if (shm->flags & TEE_SHM_DMA_BUF) {
> > +	if (shm->flags & TEE_SHM_REGISTER) {
> >  		unsigned int nr_pages =3D 1 << order, i;
> >  		struct page **pages;
> > =20
> >  		pages =3D kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
> > -		if (!pages)
> > -			return -ENOMEM;
> > -
> > -		for (i =3D 0; i < nr_pages; i++) {
> > -			pages[i] =3D page;
> > -			page++;
> > +		if (!pages) {
> > +			rc =3D -ENOMEM;
> > +			goto err;
> >  		}
> > =20
> > -		shm->flags |=3D TEE_SHM_REGISTER;
> > +		for (i =3D 0; i < nr_pages; i++)
> > +			pages[i] =3D page + i;
> > +
> >  		rc =3D optee_shm_register(shm->ctx, shm, pages, nr_pages,
> >  					(unsigned long)shm->kaddr);
> >  		kfree(pages);
> > +		if (rc)
> > +			goto err;
> >  	}
> > =20
> > +	return 0;
> > +
> > +err:
> > +	free_pages((unsigned long)shm->kaddr, order);
>=20
> This memory leak fix should be split out and sent to stable. I've sent a
> patch that does this:
>=20
>  https://lore.kernel.org/lkml/20210609002326.210024-2-tyhicks(a)linux.micro=
soft.com/

Makes sense, I'll rebase on that in the next version.

>=20
> >  	return rc;
> >  }
> > =20
> > -static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> > +static void pool_op_free(struct tee_shm_pool *pool,
> >  			 struct tee_shm *shm)
> >  {
> > -	if (shm->flags & TEE_SHM_DMA_BUF)
> > +	if (shm->flags & TEE_SHM_REGISTER)
> >  		optee_shm_unregister(shm->ctx, shm);
> > =20
> >  	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> >  	shm->kaddr =3D NULL;
> >  }
> > =20
> > -static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
> > +static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> >  {
> > -	kfree(poolm);
> > +	kfree(pool);
> >  }
> > =20
> > -static const struct tee_shm_pool_mgr_ops pool_ops =3D {
> > +static const struct tee_shm_pool_ops pool_ops =3D {
> >  	.alloc =3D pool_op_alloc,
> >  	.free =3D pool_op_free,
> > -	.destroy_poolmgr =3D pool_op_destroy_poolmgr,
> > +	.destroy_pool =3D pool_op_destroy_pool,
> >  };
> > =20
> >  /**
> > @@ -76,14 +85,14 @@ static const struct tee_shm_pool_mgr_ops pool_ops =3D=
 {
> >   * This pool is used when OP-TEE supports dymanic SHM. In this case
> >   * command buffers and such are allocated from kernel's own memory.
> >   */
> > -struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void)
> > +struct tee_shm_pool *optee_shm_pool_alloc_pages(void)
> >  {
> > -	struct tee_shm_pool_mgr *mgr =3D kzalloc(sizeof(*mgr), GFP_KERNEL);
> > +	struct tee_shm_pool *pool =3D kzalloc(sizeof(*pool), GFP_KERNEL);
> > =20
> > -	if (!mgr)
> > +	if (!pool)
> >  		return ERR_PTR(-ENOMEM);
> > =20
> > -	mgr->ops =3D &pool_ops;
> > +	pool->ops =3D &pool_ops;
> > =20
> > -	return mgr;
> > +	return pool;
> >  }
> > diff --git a/drivers/tee/optee/shm_pool.h b/drivers/tee/optee/shm_pool.h
> > index 28109d991c4b..7024b9926ada 100644
> > --- a/drivers/tee/optee/shm_pool.h
> > +++ b/drivers/tee/optee/shm_pool.h
> > @@ -9,6 +9,6 @@
> > =20
> >  #include <linux/tee_drv.h>
> > =20
> > -struct tee_shm_pool_mgr *optee_shm_pool_alloc_pages(void);
> > +struct tee_shm_pool *optee_shm_pool_alloc_pages(void);
> > =20
> >  #endif
> > diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> > index e55204df31ce..72376cf38bc0 100644
> > --- a/drivers/tee/tee_private.h
> > +++ b/drivers/tee/tee_private.h
> > @@ -12,17 +12,6 @@
> >  #include <linux/mutex.h>
> >  #include <linux/types.h>
> > =20
> > -/**
> > - * struct tee_shm_pool - shared memory pool
> > - * @private_mgr:	pool manager for shared memory only between kernel
> > - *			and secure world
> > - * @dma_buf_mgr:	pool manager for shared memory exported to user space
> > - */
> > -struct tee_shm_pool {
> > -	struct tee_shm_pool_mgr *private_mgr;
> > -	struct tee_shm_pool_mgr *dma_buf_mgr;
> > -};
> > -
> >  #define TEE_DEVICE_FLAG_REGISTERED	0x1
> >  #define TEE_MAX_DEV_NAME_LEN		32
> > =20
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 00472f5ce22e..b9dbf4bce149 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -39,14 +39,7 @@ static void tee_shm_release(struct tee_shm *shm)
> >  	}
> > =20
> >  	if (shm->flags & TEE_SHM_POOL) {
> > -		struct tee_shm_pool_mgr *poolm;
> > -
> > -		if (shm->flags & TEE_SHM_DMA_BUF)
> > -			poolm =3D teedev->pool->dma_buf_mgr;
> > -		else
> > -			poolm =3D teedev->pool->private_mgr;
> > -
> > -		poolm->ops->free(poolm, shm);
> > +		teedev->pool->ops->free(teedev->pool, shm);
> >  	} else if (shm->flags & TEE_SHM_REGISTER) {
> >  		int rc =3D teedev->desc->ops->shm_unregister(shm->ctx, shm);
> > =20
> > @@ -106,8 +99,8 @@ static const struct dma_buf_ops tee_shm_dma_buf_ops =
=3D {
> >  struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 =
flags)
> >  {
> >  	struct tee_device *teedev =3D ctx->teedev;
> > -	struct tee_shm_pool_mgr *poolm =3D NULL;
> >  	struct tee_shm *shm;
> > +	size_t align;
>=20
> You use u_int for the align parameter type in the .alloc function
> prototype. Perhaps switch it to size_t to match the argument that
> you're passing in?

OK, I'll fix.

>=20
> >  	void *ret;
> >  	int rc;
> > =20
> > @@ -139,12 +132,18 @@ struct tee_shm *tee_shm_alloc(struct tee_context *c=
tx, size_t size, u32 flags)
> > =20
> >  	shm->flags =3D flags | TEE_SHM_POOL;
> >  	shm->ctx =3D ctx;
> > -	if (flags & TEE_SHM_DMA_BUF)
> > -		poolm =3D teedev->pool->dma_buf_mgr;
> > -	else
> > -		poolm =3D teedev->pool->private_mgr;
> > +	if (flags & TEE_SHM_DMA_BUF) {
> > +		align =3D PAGE_SIZE;
> > +		/*
> > +		 * Request to register the shm in the pool allocator below
> > +		 * if supported.
> > +		 */
> > +		shm->flags |=3D TEE_SHM_REGISTER;
> > +	} else {
> > +		align =3D 2 * sizeof(long);
>=20
> Where does this alignment requirement come from?

There are some Arm instructions that requires double word aligned pointers.

I believe it's good practice for a memory allocator to keep the returned
buffers at least double word aligned, unless there's a specific reason
to do otherwise.

>=20
> > +	}
> > =20
> > -	rc =3D poolm->ops->alloc(poolm, shm, size);
> > +	rc =3D teedev->pool->ops->alloc(teedev->pool, shm, size, align);
> >  	if (rc) {
> >  		ret =3D ERR_PTR(rc);
> >  		goto err_kfree;
> > @@ -184,7 +183,7 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx=
, size_t size, u32 flags)
> >  		mutex_unlock(&teedev->mutex);
> >  	}
> >  err_pool_free:
> > -	poolm->ops->free(poolm, shm);
> > +	teedev->pool->ops->free(teedev->pool, shm);
> >  err_kfree:
> >  	kfree(shm);
> >  err_dev_put:
> > diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> > index a9f9d50fd181..5ceab73ff1b5 100644
> > --- a/drivers/tee/tee_shm_pool.c
> > +++ b/drivers/tee/tee_shm_pool.c
> > @@ -9,14 +9,16 @@
> >  #include <linux/tee_drv.h>
> >  #include "tee_private.h"
> > =20
> > -static int pool_op_gen_alloc(struct tee_shm_pool_mgr *poolm,
> > -			     struct tee_shm *shm, size_t size)
> > +static int pool_op_gen_alloc(struct tee_shm_pool *pool, struct tee_shm *=
shm,
> > +			     size_t size, u_int align)
> >  {
> >  	unsigned long va;
> > -	struct gen_pool *genpool =3D poolm->private_data;
> > -	size_t s =3D roundup(size, 1 << genpool->min_alloc_order);
> > +	struct gen_pool *genpool =3D pool->private_data;
> > +	size_t a =3D max(align, 1U << genpool->min_alloc_order);
> > +	struct genpool_data_align data =3D { .align =3D a };
> > +	size_t s =3D roundup(size, a);
> > =20
> > -	va =3D gen_pool_alloc(genpool, s);
> > +	va =3D gen_pool_alloc_algo(genpool, s, gen_pool_first_fit_align, &data);
>=20
> This is an algo change from the existing use of gen_pool_best_fit. Was
> that intentional? If so, a mention of the reasoning for this change in
> the commit message might be helpful in the future.

Best-fit was the default choice and not a conscious choice from the
beginning. We're doing first-fit now since that supports requesting an
alignment, while best-fit doesn't. I'll add something in the commit
message.

Cheers,
Jens

--===============8610197499182927863==--

