From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 5/5] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Sat, 08 Jun 2024 12:45:05 +0800
Message-ID: <202406081214.qFAil90A-lkp@intel.com>
In-Reply-To: <20240607093326.369090-6-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1143611579778255346=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1143611579778255346==
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
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240608/2=
02406081214.qFAil90A-lkp(a)intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0240608/202406081214.qFAil90A-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081214.qFAil90A-lkp(a)i=
ntel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bug.h:5,
                    from include/linux/fortify-string.h:6,
                    from include/linux/string.h:374,
                    from include/linux/dma-mapping.h:7,
                    from drivers/remoteproc/stm32_rproc.c:9:
>> arch/s390/include/asm/bug.h:53:21: error: expected declaration specifiers =
or '...' before '{' token
      53 | #define WARN_ON(x) ({                                   \
         |                     ^
   include/linux/tee_remoteproc.h:94:9: note: in expansion of macro 'WARN_ON'
      94 |         WARN_ON(1);
         |         ^~~~~~~
   In file included from drivers/remoteproc/stm32_rproc.c:23:
   include/linux/tee_remoteproc.h:96:9: error: expected identifier or '(' bef=
ore 'return'
      96 |         return NULL;
         |         ^~~~~~
   include/linux/tee_remoteproc.h:97:1: error: expected identifier or '(' bef=
ore '}' token
      97 | }
         | ^
   drivers/remoteproc/stm32_rproc.c:717:34: error: 'tee_rproc_find_loaded_rsc=
_table' undeclared here (not in a function); did you mean 'rproc_find_loaded_=
rsc_table'?
     717 |         .find_loaded_rsc_table =3D tee_rproc_find_loaded_rsc_table,
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                  rproc_find_loaded_rsc_table


vim +53 arch/s390/include/asm/bug.h

a9df8e325d0de5 arch/s390/include/asm/bug.h Heiko Carstens 2010-01-13  52 =20
c0007f1a65762e include/asm-s390/bug.h      Heiko Carstens 2007-04-27 @53  #de=
fine WARN_ON(x) ({					\
fd0cbdd378258f include/asm-s390/bug.h      Heiko Carstens 2007-08-02  54  	in=
t __ret_warn_on =3D !!(x);			\
c0007f1a65762e include/asm-s390/bug.h      Heiko Carstens 2007-04-27  55  	if=
 (__builtin_constant_p(__ret_warn_on)) {	\
c0007f1a65762e include/asm-s390/bug.h      Heiko Carstens 2007-04-27  56  		i=
f (__ret_warn_on)			\
b2be05273a1744 arch/s390/include/asm/bug.h Ben Hutchings  2010-04-03  57  			=
__WARN();			\
c0007f1a65762e include/asm-s390/bug.h      Heiko Carstens 2007-04-27  58  	} =
else {					\
c0007f1a65762e include/asm-s390/bug.h      Heiko Carstens 2007-04-27  59  		i=
f (unlikely(__ret_warn_on))		\
b2be05273a1744 arch/s390/include/asm/bug.h Ben Hutchings  2010-04-03  60  			=
__WARN();			\
c0007f1a65762e include/asm-s390/bug.h      Heiko Carstens 2007-04-27  61  	}	=
					\
c0007f1a65762e include/asm-s390/bug.h      Heiko Carstens 2007-04-27  62  	un=
likely(__ret_warn_on);			\
c0007f1a65762e include/asm-s390/bug.h      Heiko Carstens 2007-04-27  63  })
c0007f1a65762e include/asm-s390/bug.h      Heiko Carstens 2007-04-27  64 =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============1143611579778255346==--

