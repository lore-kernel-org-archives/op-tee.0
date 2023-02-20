From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 3/4] tee: expose tee efivar register function
Date: Mon, 20 Feb 2023 15:54:31 +0800
Message-ID: <202302201500.rOtaNOWt-lkp@intel.com>
In-Reply-To: <20230220051723.1257-4-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2987321064209702428=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2987321064209702428==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Masahisa,

I love your patch! Yet something to improve:

[auto build test ERROR on efi/next]
[also build test ERROR on next-20230217]
[cannot apply to linus/master v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahisa-Kojima/efi-ex=
pose-efivar-generic-ops-register-function/20230220-132235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20230220051723.1257-4-masahisa.kojim=
a%40linaro.org
patch subject: [PATCH v2 3/4] tee: expose tee efivar register function
config: nios2-randconfig-r036-20230220 (https://download.01.org/0day-ci/archi=
ve/20230220/202302201500.rOtaNOWt-lkp(a)intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/ma=
ke.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c9bb47729e4c5c9999ce5=
23e6c72785e897d9ae6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahisa-Kojima/efi-expose-efivar-ge=
neric-ops-register-function/20230220-132235
        git checkout c9bb47729e4c5c9999ce523e6c72785e897d9ae6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dnios2 olddefconfig
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dnios2 SHELL=3D/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302201500.rOtaNOWt-lkp(a)int=
el.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/tee/tee_core.o: in function `tee_register_efivar_o=
ps':
>> tee_core.c:(.text+0x2634): undefined reference to `efivar_supports_writes'
   tee_core.c:(.text+0x2634): relocation truncated to fit: R_NIOS2_CALL26 aga=
inst `efivar_supports_writes'
>> nios2-linux-ld: tee_core.c:(.text+0x2654): undefined reference to `efivars=
_generic_ops_unregister'
   tee_core.c:(.text+0x2654): relocation truncated to fit: R_NIOS2_CALL26 aga=
inst `efivars_generic_ops_unregister'
>> nios2-linux-ld: tee_core.c:(.text+0x2674): undefined reference to `efivars=
_register'
   tee_core.c:(.text+0x2674): relocation truncated to fit: R_NIOS2_CALL26 aga=
inst `efivars_register'
   nios2-linux-ld: drivers/tee/tee_core.o: in function `tee_unregister_efivar=
_ops':
>> tee_core.c:(.text+0x2684): undefined reference to `efivars_unregister'
   tee_core.c:(.text+0x2684): relocation truncated to fit: R_NIOS2_CALL26 aga=
inst `efivars_unregister'
>> nios2-linux-ld: tee_core.c:(.text+0x2688): undefined reference to `efivars=
_generic_ops_register'
   tee_core.c:(.text+0x2688): relocation truncated to fit: R_NIOS2_CALL26 aga=
inst `efivars_generic_ops_register'

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--===============2987321064209702428==--

