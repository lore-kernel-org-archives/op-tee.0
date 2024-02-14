From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/3] tee: optee: Move pool_op helper functions
Date: Wed, 14 Feb 2024 21:01:22 +0800
Message-ID: <202402142042.JLQEGKBr-lkp@intel.com>
In-Reply-To: <20240213145239.379875-2-balint.dobszay@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4668347474234388653=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4668347474234388653==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Balint,

kernel test robot noticed the following build errors:

[auto build test ERROR on lwn/docs-next]
[also build test ERROR on soc/for-next linus/master v6.8-rc4 next-20240214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Balint-Dobszay/tee-opt=
ee-Move-pool_op-helper-functions/20240213-225716
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20240213145239.379875-2-balint.dobsz=
ay%40arm.com
patch subject: [PATCH 1/3] tee: optee: Move pool_op helper functions
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240214/2=
02402142042.JLQEGKBr-lkp(a)intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0240214/202402142042.JLQEGKBr-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402142042.JLQEGKBr-lkp(a)i=
ntel.com/

All errors (new ones prefixed by >>):

   drivers/tee/tee_shm.c: In function 'tee_shm_pool_op_alloc_helper':
>> drivers/tee/tee_shm.c:227:22: error: implicit declaration of function 'vir=
t_to_phys'; did you mean 'virt_to_pfn'? [-Werror=3Dimplicit-function-declarat=
ion]
     227 |         shm->paddr =3D virt_to_phys(shm->kaddr);
         |                      ^~~~~~~~~~~~
         |                      virt_to_pfn
   cc1: some warnings being treated as errors


vim +227 drivers/tee/tee_shm.c

   204=09
   205	int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee=
_shm *shm,
   206					 size_t size, size_t align,
   207					 int (*shm_register)(struct tee_context *ctx,
   208							     struct tee_shm *shm,
   209							     struct page **pages,
   210							     size_t num_pages,
   211							     unsigned long start))
   212	{
   213		size_t nr_pages =3D roundup(size, PAGE_SIZE) / PAGE_SIZE;
   214		struct page **pages;
   215		unsigned int i;
   216		int rc =3D 0;
   217=09
   218		/*
   219		 * Ignore alignment since this is already going to be page aligned
   220		 * and there's no need for any larger alignment.
   221		 */
   222		shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
   223					       GFP_KERNEL | __GFP_ZERO);
   224		if (!shm->kaddr)
   225			return -ENOMEM;
   226=09
 > 227		shm->paddr =3D virt_to_phys(shm->kaddr);
   228		shm->size =3D nr_pages * PAGE_SIZE;
   229=09
   230		pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
   231		if (!pages) {
   232			rc =3D -ENOMEM;
   233			goto err;
   234		}
   235=09
   236		for (i =3D 0; i < nr_pages; i++)
   237			pages[i] =3D virt_to_page((u8 *)shm->kaddr + i * PAGE_SIZE);
   238=09
   239		shm->pages =3D pages;
   240		shm->num_pages =3D nr_pages;
   241=09
   242		if (shm_register) {
   243			rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
   244					  (unsigned long)shm->kaddr);
   245			if (rc)
   246				goto err;
   247		}
   248=09
   249		return 0;
   250	err:
   251		free_pages_exact(shm->kaddr, shm->size);
   252		shm->kaddr =3D NULL;
   253		return rc;
   254	}
   255	EXPORT_SYMBOL_GPL(tee_shm_pool_op_alloc_helper);
   256=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============4668347474234388653==--

