From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Tue, 16 Jan 2024 16:15:40 +0800
Message-ID: <202401161552.JWQXL1kD-lkp@intel.com>
In-Reply-To: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3014381475912806716=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3014381475912806716==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on robh/for-next linus/master v6.7 next-20240112]
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
config: um-randconfig-r113-20240116 (https://download.01.org/0day-ci/archive/=
20240116/202401161552.JWQXL1kD-lkp(a)intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0240116/202401161552.JWQXL1kD-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161552.JWQXL1kD-lkp(a)i=
ntel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/tee_remoteproc.c:82:26: sparse: sparse: symbol 'tee_rpr=
oc_ctx' was not declared. Should it be static?
>> drivers/remoteproc/tee_remoteproc.c:166:24: sparse: sparse: incorrect type=
 in assignment (different address spaces) @@     expected void *rsc_va @@    =
 got void [noderef] __iomem * @@
   drivers/remoteproc/tee_remoteproc.c:166:24: sparse:     expected void *rsc=
_va
   drivers/remoteproc/tee_remoteproc.c:166:24: sparse:     got void [noderef]=
 __iomem *
>> drivers/remoteproc/tee_remoteproc.c:233:31: sparse: sparse: incorrect type=
 in argument 1 (different address spaces) @@     expected void volatile [node=
ref] __iomem *addr @@     got void *rsc_va @@
   drivers/remoteproc/tee_remoteproc.c:233:31: sparse:     expected void vola=
tile [noderef] __iomem *addr
   drivers/remoteproc/tee_remoteproc.c:233:31: sparse:     got void *rsc_va
   drivers/remoteproc/tee_remoteproc.c: note: in included file (through inclu=
de/linux/preempt.h, include/linux/spinlock.h, include/linux/mmzone.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluat=
es to true

vim +/tee_rproc_ctx +82 drivers/remoteproc/tee_remoteproc.c

6805d1065198e1 Arnaud Pouliquen 2024-01-15   81 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  @82  struct tee_rproc_context *te=
e_rproc_ctx;
6805d1065198e1 Arnaud Pouliquen 2024-01-15   83 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15   84  static void prepare_args(str=
uct tee_rproc *trproc, int cmd, struct tee_ioctl_invoke_arg *arg,
6805d1065198e1 Arnaud Pouliquen 2024-01-15   85  			 struct tee_param *param,=
 unsigned int num_params)
6805d1065198e1 Arnaud Pouliquen 2024-01-15   86  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15   87  	memset(arg, 0, sizeof(*arg)=
);
6805d1065198e1 Arnaud Pouliquen 2024-01-15   88  	memset(param, 0, MAX_TEE_PA=
RAM_ARRY_MEMBER * sizeof(*param));
6805d1065198e1 Arnaud Pouliquen 2024-01-15   89 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15   90  	arg->func =3D cmd;
6805d1065198e1 Arnaud Pouliquen 2024-01-15   91  	arg->session =3D trproc->se=
ssion_id;
6805d1065198e1 Arnaud Pouliquen 2024-01-15   92  	arg->num_params =3D num_par=
ams + 1;
6805d1065198e1 Arnaud Pouliquen 2024-01-15   93 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15   94  	param[0] =3D (struct tee_pa=
ram) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15   95  		.attr =3D TEE_IOCTL_PARAM_=
ATTR_TYPE_VALUE_INPUT,
6805d1065198e1 Arnaud Pouliquen 2024-01-15   96  		.u.value.a =3D trproc->rpr=
oc_id,
6805d1065198e1 Arnaud Pouliquen 2024-01-15   97  	};
6805d1065198e1 Arnaud Pouliquen 2024-01-15   98  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15   99 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  100  int tee_rproc_load_fw(struct=
 tee_rproc *trproc, const struct firmware *fw)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  101  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  102  	struct tee_ioctl_invoke_arg=
 arg;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  103  	struct tee_param param[MAX_=
TEE_PARAM_ARRY_MEMBER];
6805d1065198e1 Arnaud Pouliquen 2024-01-15  104  	struct tee_shm *fw_shm;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  105  	int ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  106 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  107  	fw_shm =3D tee_shm_register=
_kernel_buf(tee_rproc_ctx->tee_ctx, (void *)fw->data, fw->size);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  108  	if (IS_ERR(fw_shm))
6805d1065198e1 Arnaud Pouliquen 2024-01-15  109  		return PTR_ERR(fw_shm);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  110 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  111  	prepare_args(trproc, TA_RPR=
OC_FW_CMD_LOAD_FW, &arg, param, 1);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  112 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  113  	/* Provide the address of t=
he firmware image */
6805d1065198e1 Arnaud Pouliquen 2024-01-15  114  	param[1] =3D (struct tee_pa=
ram) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  115  		.attr =3D TEE_IOCTL_PARAM_=
ATTR_TYPE_MEMREF_INPUT,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  116  		.u.memref =3D {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  117  			.shm =3D fw_shm,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  118  			.size =3D fw->size,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  119  			.shm_offs =3D 0,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  120  		},
6805d1065198e1 Arnaud Pouliquen 2024-01-15  121  	};
6805d1065198e1 Arnaud Pouliquen 2024-01-15  122 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  123  	ret =3D tee_client_invoke_f=
unc(tee_rproc_ctx->tee_ctx, &arg, param);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  124  	if (ret < 0 || arg.ret !=3D=
 0) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  125  		dev_err(tee_rproc_ctx->dev,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  126  			"TA_RPROC_FW_CMD_LOAD_FW =
invoke failed TEE err: %x, ret:%x\n",
6805d1065198e1 Arnaud Pouliquen 2024-01-15  127  			arg.ret, ret);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  128  		if (!ret)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  129  			ret =3D -EIO;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  130  	}
6805d1065198e1 Arnaud Pouliquen 2024-01-15  131 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  132  	tee_shm_free(fw_shm);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  133 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  134  	return ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  135  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15  136  EXPORT_SYMBOL_GPL(tee_rproc_=
load_fw);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  137 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  138  int rproc_tee_get_rsc_table(=
struct tee_rproc *trproc)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  139  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  140  	struct tee_ioctl_invoke_arg=
 arg;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  141  	struct tee_param param[MAX_=
TEE_PARAM_ARRY_MEMBER];
6805d1065198e1 Arnaud Pouliquen 2024-01-15  142  	struct rproc *rproc =3D trp=
roc->rproc;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  143  	size_t rsc_size;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  144  	int ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  145 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  146  	prepare_args(trproc, TA_RPR=
OC_FW_CMD_GET_RSC_TABLE, &arg, param, 2);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  147 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  148  	param[1].attr =3D TEE_IOCTL=
_PARAM_ATTR_TYPE_VALUE_OUTPUT;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  149  	param[2].attr =3D TEE_IOCTL=
_PARAM_ATTR_TYPE_VALUE_OUTPUT;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  150 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  151  	ret =3D tee_client_invoke_f=
unc(tee_rproc_ctx->tee_ctx, &arg, param);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  152  	if (ret < 0 || arg.ret !=3D=
 0) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  153  		dev_err(tee_rproc_ctx->dev,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  154  			"TA_RPROC_FW_CMD_GET_RSC_=
TABLE invoke failed TEE err: %x, ret:%x\n",
6805d1065198e1 Arnaud Pouliquen 2024-01-15  155  			arg.ret, ret);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  156  		return -EIO;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  157  	}
6805d1065198e1 Arnaud Pouliquen 2024-01-15  158 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  159  	rsc_size =3D param[2].u.val=
ue.a;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  160 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  161  	/* If the size is null no r=
esource table defined in the image */
6805d1065198e1 Arnaud Pouliquen 2024-01-15  162  	if (!rsc_size)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  163  		return 0;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  164 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  165  	/* Store the resource table=
 address that would be updated by the remote core . */
6805d1065198e1 Arnaud Pouliquen 2024-01-15 @166  	trproc->rsc_va =3D ioremap_=
wc(param[1].u.value.a, rsc_size);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  167  	if (IS_ERR_OR_NULL(trproc->=
rsc_va)) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  168  		dev_err(tee_rproc_ctx->dev=
, "Unable to map memory region: %lld+%zx\n",
6805d1065198e1 Arnaud Pouliquen 2024-01-15  169  			param[1].u.value.a, rsc_s=
ize);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  170  		trproc->rsc_va =3D NULL;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  171  		return -ENOMEM;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  172  	}
6805d1065198e1 Arnaud Pouliquen 2024-01-15  173 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  174  	/*
6805d1065198e1 Arnaud Pouliquen 2024-01-15  175  	 * A cached table is reques=
ted as the physical address is not mapped yet
6805d1065198e1 Arnaud Pouliquen 2024-01-15  176  	 * but remoteproc needs to =
parse the table for resources.
6805d1065198e1 Arnaud Pouliquen 2024-01-15  177  	 */
6805d1065198e1 Arnaud Pouliquen 2024-01-15  178  	rproc->cached_table =3D kme=
mdup(trproc->rsc_va, rsc_size, GFP_KERNEL);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  179  	if (!rproc->cached_table)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  180  		return -ENOMEM;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  181 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  182  	rproc->table_ptr =3D rproc-=
>cached_table;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  183  	rproc->table_sz =3D rsc_siz=
e;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  184 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  185  	return 0;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  186  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15  187  EXPORT_SYMBOL_GPL(rproc_tee_=
get_rsc_table);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  188 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  189  struct resource_table *tee_r=
proc_get_loaded_rsc_table(struct tee_rproc *trproc)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  190  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  191  	return (struct resource_tab=
le *)trproc->rsc_va;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  192  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15  193  EXPORT_SYMBOL_GPL(tee_rproc_=
get_loaded_rsc_table);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  194 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  195  int tee_rproc_start(struct t=
ee_rproc *trproc)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  196  {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  197  	struct tee_ioctl_invoke_arg=
 arg;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  198  	struct tee_param param[MAX_=
TEE_PARAM_ARRY_MEMBER];
6805d1065198e1 Arnaud Pouliquen 2024-01-15  199  	int ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  200 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  201  	prepare_args(trproc, TA_RPR=
OC_FW_CMD_START_FW, &arg, param, 0);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  202 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  203  	ret =3D tee_client_invoke_f=
unc(tee_rproc_ctx->tee_ctx, &arg, param);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  204  	if (ret < 0 || arg.ret !=3D=
 0) {
6805d1065198e1 Arnaud Pouliquen 2024-01-15  205  		dev_err(tee_rproc_ctx->dev,
6805d1065198e1 Arnaud Pouliquen 2024-01-15  206  			"TA_RPROC_FW_CMD_START_FW=
 invoke failed TEE err: %x, ret:%x\n",
6805d1065198e1 Arnaud Pouliquen 2024-01-15  207  			arg.ret, ret);
6805d1065198e1 Arnaud Pouliquen 2024-01-15  208  		if (!ret)
6805d1065198e1 Arnaud Pouliquen 2024-01-15  209  			ret =3D -EIO;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  210  	}
6805d1065198e1 Arnaud Pouliquen 2024-01-15  211 =20
6805d1065198e1 Arnaud Pouliquen 2024-01-15  212  	return ret;
6805d1065198e1 Arnaud Pouliquen 2024-01-15  213  }
6805d1065198e1 Arnaud Pouliquen 2024-01-15  214  EXPORT_SYMBOL_GPL(tee_rproc_=
start);
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

--===============3014381475912806716==--

