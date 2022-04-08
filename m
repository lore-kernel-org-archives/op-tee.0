From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: Add Arm FF-A TEE driver
Date: Sat, 09 Apr 2022 04:50:51 +0800
Message-ID: <202204090424.doAuWAHT-lkp@intel.com>
In-Reply-To: <20220408134144.1532704-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8980914989681153685=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8980914989681153685==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on linux/master v5.18-rc1]
[cannot apply to next-20220408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sudeep-Holla/tee-Add-A=
rm-FF-A-TEE-driver/20220408-214327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 18=
31fed559732b132aef0ea8261ac77e73f7eadf
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220409=
/202204090424.doAuWAHT-lkp(a)intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/ma=
ke.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e95f1810cd4b79dd9b737=
8d1d7769ddbd2d9e1df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sudeep-Holla/tee-Add-Arm-FF-A-TEE-dr=
iver/20220408-214327
        git checkout e95f1810cd4b79dd9b7378d1d7769ddbd2d9e1df
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cross O=
=3Dbuild_dir ARCH=3Dpowerpc INSTALL_HDR_PATH=3D/tmp/usr/src/linux-headers-pow=
erpc-allnoconfig-e95f1810cd4b79dd9b7378d1d7769ddbd2d9e1df headers_install

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/arm_ffa_tee.h: missing "WITH Linux-syscall-note"=
 for SPDX-License-Identifier
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/linux/arm_ffa_t=
ee.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1280: headers] Error 2
   make[1]: Target 'headers_install' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'headers_install' not remade because of errors.

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp

--===============8980914989681153685==--

