From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Thu, 18 Jan 2024 15:37:55 +0800
Message-ID: <202401181522.bvg4EMU4-lkp@intel.com>
In-Reply-To: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3496067444427558690=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3496067444427558690==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaud,

kernel test robot noticed the following build errors:

[auto build test ERROR on remoteproc/rproc-next]
[also build test ERROR on linus/master v6.7 next-20240117]
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
config: arm64-randconfig-r081-20240118 (https://download.01.org/0day-ci/archi=
ve/20240118/202401181522.bvg4EMU4-lkp(a)intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0240118/202401181522.bvg4EMU4-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401181522.bvg4EMU4-lkp(a)i=
ntel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rp=
roc_load_fw':
>> tee_remoteproc.c:(.text+0x138): undefined reference to `tee_shm_register_k=
ernel_buf'
>> tee_remoteproc.c:(.text+0x138): relocation truncated to fit: R_AARCH64_CAL=
L26 against undefined symbol `tee_shm_register_kernel_buf'
>> aarch64-linux-ld: tee_remoteproc.c:(.text+0x18c): undefined reference to `=
tee_client_invoke_func'
>> tee_remoteproc.c:(.text+0x18c): relocation truncated to fit: R_AARCH64_CAL=
L26 against undefined symbol `tee_client_invoke_func'
>> aarch64-linux-ld: tee_remoteproc.c:(.text+0x1ac): undefined reference to `=
tee_shm_free'
>> tee_remoteproc.c:(.text+0x1ac): relocation truncated to fit: R_AARCH64_CAL=
L26 against undefined symbol `tee_shm_free'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rp=
roc_start':
>> tee_remoteproc.c:(.text+0x240): undefined reference to `tee_client_invoke_=
func'
   tee_remoteproc.c:(.text+0x240): relocation truncated to fit: R_AARCH64_CAL=
L26 against undefined symbol `tee_client_invoke_func'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `rproc_=
tee_get_rsc_table':
   tee_remoteproc.c:(.text+0x2dc): undefined reference to `tee_client_invoke_=
func'
   tee_remoteproc.c:(.text+0x2dc): relocation truncated to fit: R_AARCH64_CAL=
L26 against undefined symbol `tee_client_invoke_func'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rp=
roc_stop':
   tee_remoteproc.c:(.text+0x408): undefined reference to `tee_client_invoke_=
func'
   tee_remoteproc.c:(.text+0x408): relocation truncated to fit: R_AARCH64_CAL=
L26 against undefined symbol `tee_client_invoke_func'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rp=
roc_register':
>> tee_remoteproc.c:(.text+0x51c): undefined reference to `tee_client_open_se=
ssion'
>> tee_remoteproc.c:(.text+0x51c): relocation truncated to fit: R_AARCH64_CAL=
L26 against undefined symbol `tee_client_open_session'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rp=
roc_unregister':
>> tee_remoteproc.c:(.text+0x624): undefined reference to `tee_client_close_s=
ession'
>> tee_remoteproc.c:(.text+0x624): relocation truncated to fit: R_AARCH64_CAL=
L26 against undefined symbol `tee_client_close_session'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rp=
roc_probe':
>> tee_remoteproc.c:(.text+0x6b0): undefined reference to `tee_client_open_co=
ntext'
>> tee_remoteproc.c:(.text+0x6b0): relocation truncated to fit: R_AARCH64_CAL=
L26 against undefined symbol `tee_client_open_context'
>> aarch64-linux-ld: tee_remoteproc.c:(.text+0x6e0): undefined reference to `=
tee_client_close_context'
>> tee_remoteproc.c:(.text+0x6e0): relocation truncated to fit: R_AARCH64_CAL=
L26 against undefined symbol `tee_client_close_context'
   aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o: in function `tee_rp=
roc_remove':
   tee_remoteproc.c:(.text+0x78c): undefined reference to `tee_client_close_s=
ession'
   tee_remoteproc.c:(.text+0x78c): additional relocation overflows omitted fr=
om the output
   aarch64-linux-ld: tee_remoteproc.c:(.text+0x7dc): undefined reference to `=
tee_client_close_context'
>> aarch64-linux-ld: drivers/remoteproc/tee_remoteproc.o:(.data+0x10): undefi=
ned reference to `tee_bus_type'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for TEE_REMOTEPROC
   Depends on [m]: REMOTEPROC [=3Dy] && OPTEE [=3Dm]
   Selected by [y]:
   - STM32_RPROC [=3Dy] && (ARCH_STM32 [=3Dy] || COMPILE_TEST [=3Dy]) && REMO=
TEPROC [=3Dy]

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============3496067444427558690==--

