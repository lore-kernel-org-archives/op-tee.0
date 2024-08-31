From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 4/7] remoteproc: core: Add TEE interface support for
 firmware release
Date: Sun, 01 Sep 2024 00:43:31 +0800
Message-ID: <202409010034.Tln3soEY-lkp@intel.com>
In-Reply-To: <20240830095147.3538047-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8378685746583248021=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8378685746583248021==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5be63fc19fcaa4c236b307420483578a56986a37]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remot=
eproc-core-Introduce-rproc_pa_to_va-helper/20240830-175609
base:   5be63fc19fcaa4c236b307420483578a56986a37
patch link:    https://lore.kernel.org/r/20240830095147.3538047-5-arnaud.poul=
iquen%40foss.st.com
patch subject: [PATCH v9 4/7] remoteproc: core: Add TEE interface support for=
 firmware release
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240=
901/202409010034.Tln3soEY-lkp(a)intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0240901/202409010034.Tln3soEY-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409010034.Tln3soEY-lkp(a)i=
ntel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/remoteproc/remoteproc_core.c:32:
>> include/linux/remoteproc_tee.h:52:12: warning: 'tee_rproc_parse_fw' define=
d but not used [-Wunused-function]
      52 | static int tee_rproc_parse_fw(struct rproc *rproc, const struct fi=
rmware *fw)
         |            ^~~~~~~~~~~~~~~~~~


vim +/tee_rproc_parse_fw +52 include/linux/remoteproc_tee.h

498143a453d14e Arnaud Pouliquen 2024-08-30  51 =20
498143a453d14e Arnaud Pouliquen 2024-08-30 @52  static int tee_rproc_parse_fw=
(struct rproc *rproc, const struct firmware *fw)
498143a453d14e Arnaud Pouliquen 2024-08-30  53  {
498143a453d14e Arnaud Pouliquen 2024-08-30  54  	/* This shouldn't be possibl=
e */
498143a453d14e Arnaud Pouliquen 2024-08-30  55  	WARN_ON(1);
498143a453d14e Arnaud Pouliquen 2024-08-30  56 =20
498143a453d14e Arnaud Pouliquen 2024-08-30  57  	return 0;
498143a453d14e Arnaud Pouliquen 2024-08-30  58  }
498143a453d14e Arnaud Pouliquen 2024-08-30  59 =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============8378685746583248021==--

