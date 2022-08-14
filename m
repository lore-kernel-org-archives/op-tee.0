From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/1] tee: new ioctl to a register tee_shm from a dmabuf
 file descriptor
Date: Sun, 14 Aug 2022 09:13:00 +0800
Message-ID: <202208140900.TNSQFBzy-lkp@intel.com>
In-Reply-To: <20220812143055.12938-2-olivier.masse@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2014772376564849457=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2014772376564849457==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Olivier-Masse/tee-Add-=
tee_shm_register_fd/20220812-223302
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: arm-randconfig-r026-20220814 (https://download.01.org/0day-ci/archive=
/20220814/202208140900.TNSQFBzy-lkp(a)intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2=
f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/ma=
ke.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/994ce362c3244904f79f1=
e7d4cb436ea162421d1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Olivier-Masse/tee-Add-tee_shm_regist=
er_fd/20220812-223302
        git checkout 994ce362c3244904f79f1e7d4cb436ea162421d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D1 =
O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__aeabi_uldivmod" [drivers/mtd/mtdswap.ko] undefined!
>> ERROR: modpost: module tee uses symbol dma_buf_get from namespace DMA_BUF,=
 but does not import it.
>> ERROR: modpost: module tee uses symbol dma_buf_attach from namespace DMA_B=
UF, but does not import it.
>> ERROR: modpost: module tee uses symbol dma_buf_map_attachment from namespa=
ce DMA_BUF, but does not import it.
>> ERROR: modpost: module tee uses symbol dma_buf_unmap_attachment from names=
pace DMA_BUF, but does not import it.
>> ERROR: modpost: module tee uses symbol dma_buf_detach from namespace DMA_B=
UF, but does not import it.
>> ERROR: modpost: module tee uses symbol dma_buf_put from namespace DMA_BUF,=
 but does not import it.

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp

--===============2014772376564849457==--

