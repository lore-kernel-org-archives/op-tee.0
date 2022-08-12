From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/1] tee: new ioctl to a register tee_shm from a dmabuf
 file descriptor
Date: Fri, 12 Aug 2022 13:27:13 +0800
Message-ID: <202208121326.FWVAzlch-lkp@intel.com>
In-Reply-To: <20220811135637.6332-2-olivier.masse@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6739907784541039281=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6739907784541039281==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm-tip/drm-tip linus/master v5.19 next-20220811]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Olivier-Masse/tee-Add-=
tee_shm_register_fd/20220811-220012
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220812/2=
02208121326.FWVAzlch-lkp(a)intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=3D1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2e8827973f200fdfe6436=
6bec5a57686086f4672
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Olivier-Masse/tee-Add-tee_shm_regist=
er_fd/20220811-220012
        git checkout 2e8827973f200fdfe64366bec5a57686086f4672
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/tee.h:136:13: error: expected declaration specifiers o=
r '...' before numeric constant
     136 | } __aligned(8);
         |             ^

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp

--===============6739907784541039281==--

