From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v10 7/7] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Tue, 08 Oct 2024 17:55:00 +0800
Message-ID: <202410081704.Zo2k0SZQ-lkp@intel.com>
In-Reply-To: <20241007131620.2090104-8-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7826894688958246022=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7826894688958246022==
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
config: parisc-randconfig-001-20241008 (https://download.01.org/0day-ci/archi=
ve/20241008/202410081704.Zo2k0SZQ-lkp(a)intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0241008/202410081704.Zo2k0SZQ-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081704.Zo2k0SZQ-lkp(a)i=
ntel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/remoteproc/remoteproc_tee.o: in function `tee_rproc=
_load_fw':
>> (.text+0xa8): undefined reference to `tee_shm_register_kernel_buf'
>> hppa-linux-ld: (.text+0x160): undefined reference to `tee_client_invoke_fu=
nc'
>> hppa-linux-ld: (.text+0x178): undefined reference to `tee_shm_free'
   hppa-linux-ld: drivers/remoteproc/remoteproc_tee.o: in function `tee_rproc=
_register':
>> (.text+0x2f4): undefined reference to `tee_client_open_session'
   hppa-linux-ld: drivers/remoteproc/remoteproc_tee.o: in function `tee_rproc=
_unregister':
>> (.text+0x3d4): undefined reference to `tee_client_close_session'
   hppa-linux-ld: drivers/remoteproc/remoteproc_tee.o: in function `tee_rproc=
_probe':
>> (.text+0x478): undefined reference to `tee_client_open_context'
>> hppa-linux-ld: (.text+0x4f8): undefined reference to `tee_client_close_con=
text'
   hppa-linux-ld: drivers/remoteproc/remoteproc_tee.o: in function `tee_rproc=
_remove':
   (.text+0x558): undefined reference to `tee_client_close_session'
   hppa-linux-ld: (.text+0x59c): undefined reference to `tee_client_close_con=
text'
   hppa-linux-ld: drivers/remoteproc/remoteproc_tee.o: in function `tee_rproc=
_start':
>> (.text+0x68c): undefined reference to `tee_client_invoke_func'
   hppa-linux-ld: drivers/remoteproc/remoteproc_tee.o: in function `tee_rproc=
_stop':
   (.text+0x7c8): undefined reference to `tee_client_invoke_func'
   hppa-linux-ld: drivers/remoteproc/remoteproc_tee.o: in function `tee_rproc=
_get_loaded_rsc_table':
   (.text+0x92c): undefined reference to `tee_client_invoke_func'
   hppa-linux-ld: drivers/remoteproc/remoteproc_tee.o: in function `tee_rproc=
_release_fw':
   (.text+0xb18): undefined reference to `tee_client_invoke_func'
>> hppa-linux-ld: drivers/remoteproc/remoteproc_tee.o:(.data+0x8): undefined =
reference to `tee_bus_type'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REMOTEPROC_TEE
   Depends on [n]: REMOTEPROC [=3Dy] && OPTEE [=3Dn]
   Selected by [y]:
   - STM32_RPROC [=3Dy] && (ARCH_STM32 || COMPILE_TEST [=3Dy]) && REMOTEPROC =
[=3Dy]

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============7826894688958246022==--

