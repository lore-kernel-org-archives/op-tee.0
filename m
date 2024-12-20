From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 5/6] optee: FF-A: dynamic restricted memory allocation
Date: Fri, 20 Dec 2024 22:38:53 +0800
Message-ID: <202412202214.OdgzpOke-lkp@intel.com>
In-Reply-To: <20241217100809.3962439-6-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7631273858136734150=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7631273858136734150==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

kernel test robot noticed the following build errors:

[auto build test ERROR on fac04efc5c793dccbd07e2d59af9f90b7fc0dca4]

url:    https://github.com/intel-lab-lkp/linux/commits/Jens-Wiklander/tee-add=
-restricted-memory-allocation/20241217-181101
base:   fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
patch link:    https://lore.kernel.org/r/20241217100809.3962439-6-jens.wiklan=
der%40linaro.org
patch subject: [PATCH v4 5/6] optee: FF-A: dynamic restricted memory allocati=
on
config: arm64-randconfig-002-20241220 (https://download.01.org/0day-ci/archiv=
e/20241220/202412202214.OdgzpOke-lkp(a)intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf=
88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0241220/202412202214.OdgzpOke-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412202214.OdgzpOke-lkp(a)i=
ntel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/tee/optee/rstmem.c:8:
   In file included from include/linux/dma-map-ops.h:9:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enume=
ration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-convers=
ion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/tee/optee/rstmem.c:311:67: error: expected ')'
     311 | static struct tee_shm_pool *alloc_rstmem_pool(struct optee *optee =
__unused,
         |                                                                   ^
   drivers/tee/optee/rstmem.c:311:46: note: to match this '('
     311 | static struct tee_shm_pool *alloc_rstmem_pool(struct optee *optee =
__unused,
         |                                              ^
>> drivers/tee/optee/rstmem.c:332:35: error: too many arguments to function c=
all, expected single argument 'optee', have 2 arguments
     332 |                 pool =3D alloc_rstmem_pool(optee, use_case);
         |                        ~~~~~~~~~~~~~~~~~        ^~~~~~~~
   drivers/tee/optee/rstmem.c:311:29: note: 'alloc_rstmem_pool' declared here
     311 | static struct tee_shm_pool *alloc_rstmem_pool(struct optee *optee =
__unused,
         |                             ^                 ~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


vim +311 drivers/tee/optee/rstmem.c

   268=09
   269	static struct tee_shm_pool *alloc_rstmem_pool(struct optee *optee, u32=
 use_case)
   270	{
   271		struct optee_rstmem_cma_pool *rp;
   272		size_t min_size;
   273		int rc;
   274=09
   275		rp =3D kzalloc(sizeof(*rp), GFP_KERNEL);
   276		if (!rp)
   277			return ERR_PTR(-ENOMEM);
   278		rp->rstmem.use_case =3D use_case;
   279=09
   280		rc =3D get_rstmem_config(optee, use_case, &min_size, &rp->align, NULL,
   281				       &rp->end_point_count);
   282		if (rc) {
   283			if (rc !=3D -ENOSPC)
   284				goto err;
   285			rp->end_points =3D kcalloc(rp->end_point_count,
   286						 sizeof(*rp->end_points), GFP_KERNEL);
   287			if (!rp->end_points) {
   288				rc =3D -ENOMEM;
   289				goto err;
   290			}
   291			rc =3D get_rstmem_config(optee, use_case, &min_size, &rp->align,
   292					       rp->end_points, &rp->end_point_count);
   293			if (rc)
   294				goto err_kfree_eps;
   295		}
   296=09
   297		rp->pool.ops =3D &rstmem_pool_ops_cma;
   298		rp->optee =3D optee;
   299		rp->page_count =3D min_size / PAGE_SIZE;
   300		mutex_init(&rp->mutex);
   301=09
   302		return &rp->pool;
   303=09
   304	err_kfree_eps:
   305		kfree(rp->end_points);
   306	err:
   307		kfree(rp);
   308		return ERR_PTR(rc);
   309	}
   310	#else /*CONFIG_CMA*/
 > 311	static struct tee_shm_pool *alloc_rstmem_pool(struct optee *optee __un=
used,
   312						      u32 use_case __unused)
   313	{
   314		return ERR_PTR(-EINVAL);
   315	}
   316	#endif /*CONFIG_CMA*/
   317=09
   318	int optee_rstmem_alloc(struct tee_context *ctx, struct tee_shm *shm,
   319			       u32 flags, u32 use_case, size_t size)
   320	{
   321		struct optee *optee =3D tee_get_drvdata(ctx->teedev);
   322		struct tee_shm_pool *pool;
   323		int rc;
   324=09
   325		if (!optee->rstmem_pools)
   326			return -EINVAL;
   327		if (flags)
   328			return -EINVAL;
   329=09
   330		pool =3D xa_load(&optee->rstmem_pools->xa, use_case);
   331		if (!pool) {
 > 332			pool =3D alloc_rstmem_pool(optee, use_case);
   333			if (IS_ERR(pool))
   334				return PTR_ERR(pool);
   335			rc =3D xa_insert(&optee->rstmem_pools->xa, use_case, pool,
   336				       GFP_KERNEL);
   337			if (rc) {
   338				pool->ops->destroy_pool(pool);
   339				return rc;
   340			}
   341		}
   342=09
   343		return pool->ops->alloc(pool, shm, size, 0);
   344	}
   345=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============7631273858136734150==--

