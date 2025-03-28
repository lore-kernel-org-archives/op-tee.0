From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 08/11] tee: add Qualcomm TEE driver
Date: Sat, 29 Mar 2025 06:21:16 +0800
Message-ID: <202503290620.2KJEcZM6-lkp@intel.com>
In-Reply-To: <=?utf-8?q?=3C20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-?=
 =?utf-8?q?8-7f457073282d=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5904882536694994539=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5904882536694994539==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Amirreza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on db8da9da41bced445077925f8a886c776a47440c]

url:    https://github.com/intel-lab-lkp/linux/commits/Amirreza-Zarrabi/tee-a=
llow-a-driver-to-allocate-a-tee_device-without-a-pool/20250328-104950
base:   db8da9da41bced445077925f8a886c776a47440c
patch link:    https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-witho=
ut-mem-obj-v3-8-7f457073282d%40oss.qualcomm.com
patch subject: [PATCH v3 08/11] tee: add Qualcomm TEE driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250329/2=
02503290620.2KJEcZM6-lkp(a)intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0250329/202503290620.2KJEcZM6-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503290620.2KJEcZM6-lkp(a)i=
ntel.com/

All warnings (new ones prefixed by >>):

>> drivers/tee/qcomtee/core.c:310: warning: Function parameter or struct memb=
er 'oic' not described in 'qcomtee_object_qtee_init'


vim +310 drivers/tee/qcomtee/core.c

   298=09
   299	/**
   300	 * qcomtee_object_qtee_init() - Initialize an object for QTEE.
   301	 * @object: object returned.
   302	 * @object_id: object ID received from QTEE.
   303	 *
   304	 * Return: On failure, returns < 0 and sets @object to %NULL_QCOMTEE_O=
BJECT.
   305	 *         On success, returns 0
   306	 */
   307	static int qcomtee_object_qtee_init(struct qcomtee_object_invoke_ctx *=
oic,
   308					    struct qcomtee_object **object,
   309					    unsigned int object_id)
 > 310	{
   311		int ret =3D 0;
   312=09
   313		switch (qcomtee_object_type(object_id)) {
   314		case QCOMTEE_OBJECT_TYPE_NULL:
   315			*object =3D NULL_QCOMTEE_OBJECT;
   316=09
   317			break;
   318		case QCOMTEE_OBJECT_TYPE_CB:
   319			*object =3D qcomtee_local_object_get(object_id);
   320			if (*object =3D=3D NULL_QCOMTEE_OBJECT)
   321				ret =3D -EINVAL;
   322=09
   323			break;
   324=09
   325		default: /* QCOMTEE_OBJECT_TYPE_TEE */
   326			*object =3D qcomtee_qtee_object_alloc(oic, object_id);
   327			if (*object =3D=3D NULL_QCOMTEE_OBJECT)
   328				ret =3D -ENOMEM;
   329=09
   330			break;
   331		}
   332=09
   333		return ret;
   334	}
   335=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============5904882536694994539==--

