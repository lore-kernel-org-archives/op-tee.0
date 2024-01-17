From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Thu, 18 Jan 2024 07:49:37 +0800
Message-ID: <202401180740.1ud9PJYn-lkp@intel.com>
In-Reply-To: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4750993836817765944=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4750993836817765944==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on robh/for-next linus/master v6.7 next-20240117]
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
config: mips-randconfig-r112-20240117 (https://download.01.org/0day-ci/archiv=
e/20240118/202401180740.1ud9PJYn-lkp(a)intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5=
becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce: (https://download.01.org/0day-ci/archive/20240118/202401180740.1ud=
9PJYn-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401180740.1ud9PJYn-lkp(a)i=
ntel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/tee_remoteproc.c:82:26: sparse: sparse: symbol 'tee_rpr=
oc_ctx' was not declared. Should it be static?
   drivers/remoteproc/tee_remoteproc.c:166:24: sparse: sparse: incorrect type=
 in assignment (different address spaces) @@     expected void *rsc_va @@    =
 got void [noderef] __iomem * @@
   drivers/remoteproc/tee_remoteproc.c:166:24: sparse:     expected void *rsc=
_va
   drivers/remoteproc/tee_remoteproc.c:166:24: sparse:     got void [noderef]=
 __iomem *
>> drivers/remoteproc/tee_remoteproc.c:233:31: sparse: sparse: incorrect type=
 in argument 1 (different address spaces) @@     expected void const volatile=
 [noderef] __iomem *addr @@     got void *rsc_va @@
   drivers/remoteproc/tee_remoteproc.c:233:31: sparse:     expected void cons=
t volatile [noderef] __iomem *addr
   drivers/remoteproc/tee_remoteproc.c:233:31: sparse:     got void *rsc_va
   drivers/remoteproc/tee_remoteproc.c: note: in included file (through inclu=
de/linux/preempt.h, include/linux/spinlock.h, include/linux/mmzone.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluat=
es to true

vim +233 drivers/remoteproc/tee_remoteproc.c

6805d1065198e1 Arnaud Pouliquen 2024-01-15  215 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  216  int tee_rproc_stop(struct te=
e_rproc *trproc)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  217  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  218  	struct tee_ioctl_invoke_arg=
 arg;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  219  	struct tee_param param[MAX_=
TEE_PARAM_ARRY_MEMBER];
6805d1065198e1 Arnaud Pouliquen 2024-01-15  220  	int ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  221 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  222  	prepare_args(trproc, TA_RPR=
OC_FW_CMD_STOP_FW, &arg, param, 0);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  223 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  224  	ret =3D tee_client_invoke_f=
unc(tee_rproc_ctx->tee_ctx, &arg, param);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  225  	if (ret < 0 || arg.ret !=3D=
 0) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  226  		dev_err(tee_rproc_ctx->dev,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  227  			"TA_RPROC_FW_CMD_STOP_FW =
invoke failed TEE err: %x, ret:%x\n",
6805d1065198e1 Arnaud Pouliquen 2024-01-15  228  			arg.ret, ret);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  229  		if (!ret)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  230  			ret =3D -EIO;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  231  	}
6805d1065198e1 Arnaud Pouliquen 2024-01-15  232  	if (trproc->rsc_va)
6805d1065198e1 Arnaud Pouliquen 2024-01-15 @233  		iounmap(trproc->rsc_va);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  234  	trproc->rsc_va =3D NULL;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  235 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  236  	return ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  237  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15  238  EXPORT_SYMBOL_GPL(tee_rproc_=
stop);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  239 =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============4750993836817765944==--

