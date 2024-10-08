From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v10 7/7] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Tue, 08 Oct 2024 19:07:40 +0800
Message-ID: <202410081902.TwQcmWjk-lkp@intel.com>
In-Reply-To: <20241007131620.2090104-8-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7136986557153335889=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7136986557153335889==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remot=
eproc-core-Introduce-rproc_pa_to_va-helper/20241007-212358
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241007131620.2090104-8-arnaud.poul=
iquen%40foss.st.com
patch subject: [PATCH v10 7/7] remoteproc: stm32: Add support of an OP-TEE TA=
 to load the firmware
config: alpha-kismet-CONFIG_REMOTEPROC_TEE-CONFIG_STM32_RPROC-0-0 (https://do=
wnload.01.org/0day-ci/archive/20241008/202410081902.TwQcmWjk-lkp(a)intel.com/=
config)
reproduce: (https://download.01.org/0day-ci/archive/20241008/202410081902.TwQ=
cmWjk-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081902.TwQcmWjk-lkp(a)i=
ntel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for REMOTEPROC_TEE whe=
n selected by STM32_RPROC
   WARNING: unmet direct dependencies detected for REMOTEPROC_TEE
     Depends on [n]: REMOTEPROC [=3Dy] && OPTEE [=3Dn]
     Selected by [y]:
     - STM32_RPROC [=3Dy] && (ARCH_STM32 || COMPILE_TEST [=3Dy]) && REMOTEPRO=
C [=3Dy]

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============7136986557153335889==--

