From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 02/10] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF
Date: Tue, 03 Dec 2024 16:01:25 +0800
Message-ID: <202412031510.Oh9kNGeK-lkp@intel.com>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?2-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8544859691073346752=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8544859691073346752==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Amirreza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f486c8aa16b8172f63bddc70116a0c897a7f3f02]

url:    https://github.com/intel-lab-lkp/linux/commits/Amirreza-Zarrabi/tee-a=
llow-a-driver-to-allocate-a-tee_device-without-a-pool/20241203-122412
base:   f486c8aa16b8172f63bddc70116a0c897a7f3f02
patch link:    https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-witho=
ut-mem-obj-v1-2-f502ef01e016%40quicinc.com
patch subject: [PATCH 02/10] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF
config: i386-buildonly-randconfig-002-20241203 (https://download.01.org/0day-=
ci/archive/20241203/202412031510.Oh9kNGeK-lkp(a)intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0241203/202412031510.Oh9kNGeK-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031510.Oh9kNGeK-lkp(a)i=
ntel.com/

All warnings (new ones prefixed by >>):

   drivers/tee/tee_core.c: In function 'params_to_supp':
>> drivers/tee/tee_core.c:669:32: warning: cast from pointer to integer of di=
fferent size [-Wpointer-to-int-cast]
     669 |                         ip.a =3D (u64)p->u.membuf.uaddr;
         |                                ^


vim +669 drivers/tee/tee_core.c

   648=09
   649	static int params_to_supp(struct tee_context *ctx,
   650				  struct tee_ioctl_param __user *uparams,
   651				  size_t num_params, struct tee_param *params)
   652	{
   653		size_t n;
   654=09
   655		for (n =3D 0; n < num_params; n++) {
   656			struct tee_ioctl_param ip;
   657			struct tee_param *p =3D params + n;
   658=09
   659			ip.attr =3D p->attr;
   660			switch (p->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
   661			case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
   662			case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
   663				ip.a =3D p->u.value.a;
   664				ip.b =3D p->u.value.b;
   665				ip.c =3D p->u.value.c;
   666				break;
   667			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT:
   668			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
 > 669				ip.a =3D (u64)p->u.membuf.uaddr;
   670				ip.b =3D p->u.membuf.size;
   671				ip.c =3D 0;
   672				break;
   673			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
   674			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
   675			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
   676				ip.b =3D p->u.memref.size;
   677				if (!p->u.memref.shm) {
   678					ip.a =3D 0;
   679					ip.c =3D (u64)-1; /* invalid shm id */
   680					break;
   681				}
   682				ip.a =3D p->u.memref.shm_offs;
   683				ip.c =3D p->u.memref.shm->id;
   684				break;
   685			default:
   686				ip.a =3D 0;
   687				ip.b =3D 0;
   688				ip.c =3D 0;
   689				break;
   690			}
   691=09
   692			if (copy_to_user(uparams + n, &ip, sizeof(ip)))
   693				return -EFAULT;
   694		}
   695=09
   696		return 0;
   697	}
   698=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============8544859691073346752==--

