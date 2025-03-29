From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Date: Sat, 29 Mar 2025 12:58:43 +0800
Message-ID: <202503291204.imMRd3l7-lkp@intel.com>
In-Reply-To: <=?utf-8?q?=3C20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-?=
 =?utf-8?q?3-7f457073282d=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8614761057110315599=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8614761057110315599==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Amirreza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on db8da9da41bced445077925f8a886c776a47440c]

url:    https://github.com/intel-lab-lkp/linux/commits/Amirreza-Zarrabi/tee-a=
llow-a-driver-to-allocate-a-tee_device-without-a-pool/20250328-104950
base:   db8da9da41bced445077925f8a886c776a47440c
patch link:    https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-witho=
ut-mem-obj-v3-3-7f457073282d%40oss.qualcomm.com
patch subject: [PATCH v3 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
config: x86_64-randconfig-122-20250329 (https://download.01.org/0day-ci/archi=
ve/20250329/202503291204.imMRd3l7-lkp(a)intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b=
7e4de40d0804dd374721e6411c27d1d1)
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0250329/202503291204.imMRd3l7-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503291204.imMRd3l7-lkp(a)i=
ntel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tee/tee_core.c:410:48: sparse: sparse: incorrect type in assignmen=
t (different address spaces) @@     expected void *[noderef] uaddr @@     got=
 void [noderef] __user * @@
   drivers/tee/tee_core.c:410:48: sparse:     expected void *[noderef] uaddr
   drivers/tee/tee_core.c:410:48: sparse:     got void [noderef] __user *
>> drivers/tee/tee_core.c:413:30: sparse: sparse: incorrect type in argument =
1 (different address spaces) @@     expected void const [noderef] __user *ptr=
 @@     got void *[noderef] uaddr @@
   drivers/tee/tee_core.c:413:30: sparse:     expected void const [noderef] _=
_user *ptr
   drivers/tee/tee_core.c:413:30: sparse:     got void *[noderef] uaddr
   drivers/tee/tee_core.c:802:41: sparse: sparse: incorrect type in assignmen=
t (different address spaces) @@     expected void *[noderef] uaddr @@     got=
 void [noderef] __user * @@
   drivers/tee/tee_core.c:802:41: sparse:     expected void *[noderef] uaddr
   drivers/tee/tee_core.c:802:41: sparse:     got void [noderef] __user *
   drivers/tee/tee_core.c:805:30: sparse: sparse: incorrect type in argument =
1 (different address spaces) @@     expected void const [noderef] __user *ptr=
 @@     got void *[noderef] uaddr @@
   drivers/tee/tee_core.c:805:30: sparse:     expected void const [noderef] _=
_user *ptr
   drivers/tee/tee_core.c:805:30: sparse:     got void *[noderef] uaddr
>> drivers/tee/tee_core.c:413:30: sparse: sparse: dereference of noderef expr=
ession
>> drivers/tee/tee_core.c:413:30: sparse: sparse: dereference of noderef expr=
ession
   drivers/tee/tee_core.c:694:37: sparse: sparse: dereference of noderef expr=
ession
   drivers/tee/tee_core.c:805:30: sparse: sparse: dereference of noderef expr=
ession
   drivers/tee/tee_core.c:805:30: sparse: sparse: dereference of noderef expr=
ession

vim +410 drivers/tee/tee_core.c

   378=09
   379	static int params_from_user(struct tee_context *ctx, struct tee_param =
*params,
   380				    size_t num_params,
   381				    struct tee_ioctl_param __user *uparams)
   382	{
   383		size_t n;
   384=09
   385		for (n =3D 0; n < num_params; n++) {
   386			struct tee_shm *shm;
   387			struct tee_ioctl_param ip;
   388=09
   389			if (copy_from_user(&ip, uparams + n, sizeof(ip)))
   390				return -EFAULT;
   391=09
   392			/* All unused attribute bits has to be zero */
   393			if (ip.attr & ~TEE_IOCTL_PARAM_ATTR_MASK)
   394				return -EINVAL;
   395=09
   396			params[n].attr =3D ip.attr;
   397			switch (ip.attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
   398			case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
   399			case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
   400				break;
   401			case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
   402			case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
   403				params[n].u.value.a =3D ip.a;
   404				params[n].u.value.b =3D ip.b;
   405				params[n].u.value.c =3D ip.c;
   406				break;
   407			case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
   408			case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
   409			case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
 > 410				params[n].u.ubuf.uaddr =3D u64_to_user_ptr(ip.a);
   411				params[n].u.ubuf.size =3D ip.b;
   412=09
 > 413				if (!access_ok(params[n].u.ubuf.uaddr,
   414					       params[n].u.ubuf.size))
   415					return -EFAULT;
   416=09
   417				break;
   418			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
   419			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
   420			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
   421				/*
   422				 * If a NULL pointer is passed to a TA in the TEE,
   423				 * the ip.c IOCTL parameters is set to TEE_MEMREF_NULL
   424				 * indicating a NULL memory reference.
   425				 */
   426				if (ip.c !=3D TEE_MEMREF_NULL) {
   427					/*
   428					 * If we fail to get a pointer to a shared
   429					 * memory object (and increase the ref count)
   430					 * from an identifier we return an error. All
   431					 * pointers that has been added in params have
   432					 * an increased ref count. It's the callers
   433					 * responibility to do tee_shm_put() on all
   434					 * resolved pointers.
   435					 */
   436					shm =3D tee_shm_get_from_id(ctx, ip.c);
   437					if (IS_ERR(shm))
   438						return PTR_ERR(shm);
   439=09
   440					/*
   441					 * Ensure offset + size does not overflow
   442					 * offset and does not overflow the size of
   443					 * the referred shared memory object.
   444					 */
   445					if ((ip.a + ip.b) < ip.a ||
   446					    (ip.a + ip.b) > shm->size) {
   447						tee_shm_put(shm);
   448						return -EINVAL;
   449					}
   450				} else if (ctx->cap_memref_null) {
   451					/* Pass NULL pointer to OP-TEE */
   452					shm =3D NULL;
   453				} else {
   454					return -EINVAL;
   455				}
   456=09
   457				params[n].u.memref.shm_offs =3D ip.a;
   458				params[n].u.memref.size =3D ip.b;
   459				params[n].u.memref.shm =3D shm;
   460				break;
   461			default:
   462				/* Unknown attribute */
   463				return -EINVAL;
   464			}
   465		}
   466		return 0;
   467	}
   468=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============8614761057110315599==--

