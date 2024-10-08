From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v10 7/7] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Tue, 08 Oct 2024 08:23:10 -0600
Message-ID: <ZwVATlRbo0OdRLbj@p14s>
In-Reply-To: <202410081902.TwQcmWjk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3182555563200000032=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3182555563200000032==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From hereon and starting with this version, I will not review patchets that
don't pass the compilation bots.

Mathieu

On Tue, Oct 08, 2024 at 07:07:40PM +0800, kernel test robot wrote:
> Hi Arnaud,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on 9852d85ec9d492ebef56dc5f229416c925758edc]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/rem=
oteproc-core-Introduce-rproc_pa_to_va-helper/20241007-212358
> base:   9852d85ec9d492ebef56dc5f229416c925758edc
> patch link:    https://lore.kernel.org/r/20241007131620.2090104-8-arnaud.po=
uliquen%40foss.st.com
> patch subject: [PATCH v10 7/7] remoteproc: stm32: Add support of an OP-TEE =
TA to load the firmware
> config: alpha-kismet-CONFIG_REMOTEPROC_TEE-CONFIG_STM32_RPROC-0-0 (https://=
download.01.org/0day-ci/archive/20241008/202410081902.TwQcmWjk-lkp(a)intel.co=
m/config)
> reproduce: (https://download.01.org/0day-ci/archive/20241008/202410081902.T=
wQcmWjk-lkp(a)intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410081902.TwQcmWjk-lkp(a=
)intel.com/
>=20
> kismet warnings: (new ones prefixed by >>)
> >> kismet: WARNING: unmet direct dependencies detected for REMOTEPROC_TEE w=
hen selected by STM32_RPROC
>    WARNING: unmet direct dependencies detected for REMOTEPROC_TEE
>      Depends on [n]: REMOTEPROC [=3Dy] && OPTEE [=3Dn]
>      Selected by [y]:
>      - STM32_RPROC [=3Dy] && (ARCH_STM32 || COMPILE_TEST [=3Dy]) && REMOTEP=
ROC [=3Dy]
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

--===============3182555563200000032==--

