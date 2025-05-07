From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 08/11] tee: add Qualcomm TEE driver
Date: Wed, 07 May 2025 15:58:20 +0800
Message-ID: <202505071540.hAeEOUWt-lkp@intel.com>
In-Reply-To: <=?utf-8?q?=3C20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-?=
 =?utf-8?q?8-6a143640a6cb=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0630298819061121152=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0630298819061121152==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Amirreza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 33035b665157558254b3c21c3f049fd728e72368]

url:    https://github.com/intel-lab-lkp/linux/commits/Amirreza-Zarrabi/tee-a=
llow-a-driver-to-allocate-a-tee_device-without-a-pool/20250429-140908
base:   33035b665157558254b3c21c3f049fd728e72368
patch link:    https://lore.kernel.org/r/20250428-qcom-tee-using-tee-ss-witho=
ut-mem-obj-v4-8-6a143640a6cb%40oss.qualcomm.com
patch subject: [PATCH v4 08/11] tee: add Qualcomm TEE driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250507/202=
505071540.hAeEOUWt-lkp(a)intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0250507/202505071540.hAeEOUWt-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071540.hAeEOUWt-lkp(a)i=
ntel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/tee/qcomtee/async.c:101 function parameter 'async_msg' no=
t described in 'async_release'
>> Warning: drivers/tee/qcomtee/async.c:101 Excess function parameter 'msg' d=
escription in 'async_release'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_AUX_HPD_BRIDGE
   Depends on [n]: HAS_IOMEM [=3Dy] && DRM [=3Dn] && DRM_BRIDGE [=3Dn] && OF =
[=3Dy]
   Selected by [m]:
   - UCSI_HUAWEI_GAOKUN [=3Dm] && USB_SUPPORT [=3Dy] && TYPEC [=3Dm] && TYPEC=
_UCSI [=3Dm] && EC_HUAWEI_GAOKUN [=3Dm]

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============0630298819061121152==--

