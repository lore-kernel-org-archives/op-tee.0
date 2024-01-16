From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Tue, 16 Jan 2024 14:22:29 +0800
Message-ID: <202401161447.0AQqNEiO-lkp@intel.com>
In-Reply-To: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4406268439638906528=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4406268439638906528==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on robh/for-next linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remot=
eproc-Add-TEE-support/20240115-215613
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rp=
roc-next
patch link:    https://lore.kernel.org/r/20240115135249.296822-5-arnaud.pouli=
quen%40foss.st.com
patch subject: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to =
load the firmware
config: alpha-kismet-CONFIG_TEE_REMOTEPROC-CONFIG_STM32_RPROC-0-0 (https://do=
wnload.01.org/0day-ci/archive/20240116/202401161447.0AQqNEiO-lkp(a)intel.com/=
config)
reproduce: (https://download.01.org/0day-ci/archive/20240116/202401161447.0AQ=
qNEiO-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161447.0AQqNEiO-lkp(a)i=
ntel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for TEE_REMOTEPROC whe=
n selected by STM32_RPROC
  =20
   WARNING: unmet direct dependencies detected for TEE_REMOTEPROC
     Depends on [n]: REMOTEPROC [=3Dy] && OPTEE [=3Dn]
     Selected by [y]:
     - STM32_RPROC [=3Dy] && (ARCH_STM32 || COMPILE_TEST [=3Dy]) && REMOTEPRO=
C [=3Dy]

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============4406268439638906528==--

