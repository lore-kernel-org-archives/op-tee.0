From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 4/7] remoteproc: core: Add TEE interface support for
 firmware release
Date: Mon, 02 Sep 2024 09:18:56 +0200
Message-ID: <cfc164a7-9cf9-42d8-8b66-b4567d3971ae@foss.st.com>
In-Reply-To: <202409010034.Tln3soEY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3133133995603630237=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3133133995603630237==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 8/31/24 18:43, kernel test robot wrote:
> Hi Arnaud,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on 5be63fc19fcaa4c236b307420483578a56986a37]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/rem=
oteproc-core-Introduce-rproc_pa_to_va-helper/20240830-175609
> base:   5be63fc19fcaa4c236b307420483578a56986a37
> patch link:    https://lore.kernel.org/r/20240830095147.3538047-5-arnaud.po=
uliquen%40foss.st.com
> patch subject: [PATCH v9 4/7] remoteproc: core: Add TEE interface support f=
or firmware release
> config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/202=
40901/202409010034.Tln3soEY-lkp(a)intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20240901/202409010034.Tln3soEY-lkp(a)intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409010034.Tln3soEY-lkp(a=
)intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
>    In file included from drivers/remoteproc/remoteproc_core.c:32:
>>> include/linux/remoteproc_tee.h:52:12: warning: 'tee_rproc_parse_fw' defin=
ed but not used [-Wunused-function]
>       52 | static int tee_rproc_parse_fw(struct rproc *rproc, const struct =
firmware *fw)
>          |            ^~~~~~~~~~~~~~~~~~
>=20
>=20
> vim +/tee_rproc_parse_fw +52 include/linux/remoteproc_tee.h
>=20
> 498143a453d14e Arnaud Pouliquen 2024-08-30  51 =20
> 498143a453d14e Arnaud Pouliquen 2024-08-30 @52  static int tee_rproc_parse_=
fw(struct rproc *rproc, const struct firmware *fw)
> 498143a453d14e Arnaud Pouliquen 2024-08-30  53  {
> 498143a453d14e Arnaud Pouliquen 2024-08-30  54  	/* This shouldn't be possi=
ble */
> 498143a453d14e Arnaud Pouliquen 2024-08-30  55  	WARN_ON(1);
> 498143a453d14e Arnaud Pouliquen 2024-08-30  56 =20
> 498143a453d14e Arnaud Pouliquen 2024-08-30  57  	return 0;
> 498143a453d14e Arnaud Pouliquen 2024-08-30  58  }
> 498143a453d14e Arnaud Pouliquen 2024-08-30  59 =20
>=20

The inline attribute is missing. As it is a minor fix, I'm waiting for more
reviews before fixing it in the next version.

Regards,
Arnaud

--===============3133133995603630237==--

