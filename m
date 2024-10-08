From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v10 7/7] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Wed, 09 Oct 2024 02:27:51 +0800
Message-ID: <202410090225.d3bZaaqk-lkp@intel.com>
In-Reply-To: <20241007131620.2090104-8-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7367786621608431199=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7367786621608431199==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaud,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remot=
eproc-core-Introduce-rproc_pa_to_va-helper/20241007-212358
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241007131620.2090104-8-arnaud.poul=
iquen%40foss.st.com
patch subject: [PATCH v10 7/7] remoteproc: stm32: Add support of an OP-TEE TA=
 to load the firmware
config: arm-randconfig-r054-20241008 (https://download.01.org/0day-ci/archive=
/20241009/202410090225.d3bZaaqk-lkp(a)intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef35=
66a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0241009/202410090225.d3bZaaqk-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410090225.d3bZaaqk-lkp(a)i=
ntel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: tee_client_invoke_func
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_release_f=
w) in archive vmlinux.a
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_load_fw) =
in archive vmlinux.a
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_parse_fw)=
 in archive vmlinux.a
   >>> referenced 3 more times
--
>> ld.lld: error: undefined symbol: tee_shm_register_kernel_buf
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_load_fw) =
in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: tee_shm_free
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_load_fw) =
in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: tee_client_open_session
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_register)=
 in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: tee_client_close_session
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_unregiste=
r) in archive vmlinux.a
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_remove) i=
n archive vmlinux.a
--
>> ld.lld: error: undefined symbol: tee_client_open_context
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_probe) in=
 archive vmlinux.a
--
>> ld.lld: error: undefined symbol: tee_client_close_context
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_probe) in=
 archive vmlinux.a
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_remove) i=
n archive vmlinux.a
--
>> ld.lld: error: undefined symbol: tee_bus_type
   >>> referenced by remoteproc_tee.c
   >>>               drivers/remoteproc/remoteproc_tee.o:(tee_rproc_fw_driver=
) in archive vmlinux.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REMOTEPROC_TEE
   Depends on [n]: REMOTEPROC [=3Dy] && OPTEE [=3Dn]
   Selected by [y]:
   - STM32_RPROC [=3Dy] && (ARCH_STM32 [=3Dn] || COMPILE_TEST [=3Dy]) && REMO=
TEPROC [=3Dy]

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============7367786621608431199==--

