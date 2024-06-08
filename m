From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 5/5] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Sat, 08 Jun 2024 11:30:05 +0800
Message-ID: <202406081159.KM501g5C-lkp@intel.com>
In-Reply-To: <20240607093326.369090-6-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7283768311730715921=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7283768311730715921==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaud,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remot=
eproc-core-Introduce-rproc_pa_to_va-helper/20240607-183305
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/20240607093326.369090-6-arnaud.pouli=
quen%40foss.st.com
patch subject: [PATCH v6 5/5] remoteproc: stm32: Add support of an OP-TEE TA =
to load the firmware
config: i386-buildonly-randconfig-002-20240608 (https://download.01.org/0day-=
ci/archive/20240608/202406081159.KM501g5C-lkp(a)intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9=
eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0240608/202406081159.KM501g5C-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081159.KM501g5C-lkp(a)i=
ntel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/remoteproc/stm32_rproc.c:23:
>> include/linux/tee_remoteproc.h:94:2: error: expected parameter declarator
      94 |         WARN_ON(1);
         |         ^
   include/asm-generic/bug.h:122:29: note: expanded from macro 'WARN_ON'
     122 | #define WARN_ON(condition) ({                                     =
      \
         |                             ^
   In file included from drivers/remoteproc/stm32_rproc.c:23:
>> include/linux/tee_remoteproc.h:94:2: error: expected ')'
   include/asm-generic/bug.h:122:29: note: expanded from macro 'WARN_ON'
     122 | #define WARN_ON(condition) ({                                     =
      \
         |                             ^
   include/linux/tee_remoteproc.h:94:2: note: to match this '('
   include/asm-generic/bug.h:122:28: note: expanded from macro 'WARN_ON'
     122 | #define WARN_ON(condition) ({                                     =
      \
         |                            ^
   In file included from drivers/remoteproc/stm32_rproc.c:23:
>> include/linux/tee_remoteproc.h:92:32: error: function cannot return functi=
on type 'struct resource_table *()'
      92 | tee_rproc_find_loaded_rsc_table(struct rproc *rproc, const struct =
firmware *fw)
         |                                ^
>> include/linux/tee_remoteproc.h:94:2: error: a function declaration without=
 a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
      94 |         WARN_ON(1);
         |         ^
   include/asm-generic/bug.h:122:28: note: expanded from macro 'WARN_ON'
     122 | #define WARN_ON(condition) ({                                     =
      \
         |                            ^
   In file included from drivers/remoteproc/stm32_rproc.c:23:
>> include/linux/tee_remoteproc.h:96:2: error: expected identifier or '('
      96 |         return NULL;
         |         ^
>> include/linux/tee_remoteproc.h:97:1: error: extraneous closing brace ('}')
      97 | }
         | ^
   6 errors generated.


vim +94 include/linux/tee_remoteproc.h

5c0eb7b2737b6e Arnaud Pouliquen 2024-06-07  90 =20
5c0eb7b2737b6e Arnaud Pouliquen 2024-06-07  91  static inline struct resource=
_table *
5c0eb7b2737b6e Arnaud Pouliquen 2024-06-07 @92  tee_rproc_find_loaded_rsc_tab=
le(struct rproc *rproc, const struct firmware *fw)
5c0eb7b2737b6e Arnaud Pouliquen 2024-06-07  93  	/* This shouldn't be possibl=
e */
5c0eb7b2737b6e Arnaud Pouliquen 2024-06-07 @94  	WARN_ON(1);
5c0eb7b2737b6e Arnaud Pouliquen 2024-06-07  95 =20
5c0eb7b2737b6e Arnaud Pouliquen 2024-06-07 @96  	return NULL;
5c0eb7b2737b6e Arnaud Pouliquen 2024-06-07 @97  }

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============7283768311730715921==--

