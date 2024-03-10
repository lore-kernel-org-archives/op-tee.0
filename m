From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 1/4] remoteproc: Add TEE support
Date: Sun, 10 Mar 2024 11:18:59 +0800
Message-ID: <202403101139.NIzJMqwP-lkp@intel.com>
In-Reply-To: <20240308144708.62362-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4923935102398462621=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4923935102398462621==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 62210f7509e13a2caa7b080722a45229b8f17a0a]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remot=
eproc-Add-TEE-support/20240308-225116
base:   62210f7509e13a2caa7b080722a45229b8f17a0a
patch link:    https://lore.kernel.org/r/20240308144708.62362-2-arnaud.pouliq=
uen%40foss.st.com
patch subject: [PATCH v4 1/4] remoteproc: Add TEE support
config: arm-randconfig-r123-20240310 (https://download.01.org/0day-ci/archive=
/20240310/202403101139.NIzJMqwP-lkp(a)intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240310/202403101139.NIz=
JMqwP-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403101139.NIzJMqwP-lkp(a)i=
ntel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/tee_remoteproc.c:163:19: sparse: sparse: incorrect type=
 in assignment (different address spaces) @@     expected struct resource_tab=
le *rsc_table @@     got void [noderef] __iomem * @@
   drivers/remoteproc/tee_remoteproc.c:163:19: sparse:     expected struct re=
source_table *rsc_table
   drivers/remoteproc/tee_remoteproc.c:163:19: sparse:     got void [noderef]=
 __iomem *
>> drivers/remoteproc/tee_remoteproc.c:276:23: sparse: sparse: incorrect type=
 in argument 1 (different address spaces) @@     expected void volatile [node=
ref] __iomem *io_addr @@     got struct resource_table *rsc_table @@
   drivers/remoteproc/tee_remoteproc.c:276:23: sparse:     expected void vola=
tile [noderef] __iomem *io_addr
   drivers/remoteproc/tee_remoteproc.c:276:23: sparse:     got struct resourc=
e_table *rsc_table
   drivers/remoteproc/tee_remoteproc.c:399:38: sparse: sparse: incorrect type=
 in argument 1 (different address spaces) @@     expected void volatile [node=
ref] __iomem *io_addr @@     got struct resource_table *rsc_table @@
   drivers/remoteproc/tee_remoteproc.c:399:38: sparse:     expected void vola=
tile [noderef] __iomem *io_addr
   drivers/remoteproc/tee_remoteproc.c:399:38: sparse:     got struct resourc=
e_table *rsc_table
   drivers/remoteproc/tee_remoteproc.c: note: in included file (through arch/=
arm/include/asm/traps.h, arch/arm/include/asm/thread_info.h, include/linux/th=
read_info.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluat=
es to true

vim +163 drivers/remoteproc/tee_remoteproc.c

   131=09
   132	struct resource_table *tee_rproc_get_loaded_rsc_table(struct rproc *rp=
roc, size_t *table_sz)
   133	{
   134		struct tee_ioctl_invoke_arg arg;
   135		struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
   136		struct tee_rproc *trproc =3D rproc->tee_interface;
   137		struct resource_table *rsc_table;
   138		int ret;
   139=09
   140		if (!trproc)
   141			return ERR_PTR(-EINVAL);
   142=09
   143		tee_rproc_prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, p=
aram, 2);
   144=09
   145		param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
   146		param[2].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
   147=09
   148		ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
   149		if (ret < 0 || arg.ret !=3D 0) {
   150			dev_err(tee_rproc_ctx->dev,
   151				"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %x, ret:%x\n",
   152				arg.ret, ret);
   153			return ERR_PTR(-EIO);
   154		}
   155=09
   156		*table_sz =3D param[2].u.value.a;
   157=09
   158		/* If the size is null no resource table defined in the image */
   159		if (!*table_sz)
   160			return NULL;
   161=09
   162		/* Store the resource table address that would be updated by the remo=
te core. */
 > 163		rsc_table =3D ioremap_wc(param[1].u.value.a, *table_sz);
   164		if (IS_ERR_OR_NULL(rsc_table)) {
   165			dev_err(tee_rproc_ctx->dev, "Unable to map memory region: %lld+%zx\n=
",
   166				param[1].u.value.a, *table_sz);
   167			return ERR_PTR(-ENOMEM);
   168		}
   169=09
   170		return rsc_table;
   171	}
   172	EXPORT_SYMBOL_GPL(tee_rproc_get_loaded_rsc_table);
   173=09
   174	int tee_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
   175	{
   176		struct tee_rproc *trproc =3D rproc->tee_interface;
   177		struct resource_table *rsc_table;
   178		size_t table_sz;
   179		int ret;
   180=09
   181		ret =3D tee_rproc_load_fw(rproc, fw);
   182		if (ret)
   183			return ret;
   184=09
   185		rsc_table =3D tee_rproc_get_loaded_rsc_table(rproc, &table_sz);
   186		if (IS_ERR(rsc_table))
   187			return PTR_ERR(rsc_table);
   188=09
   189		/* Create a copy of the resource table to have same behaviour than th=
e elf loader. */
   190		rproc->cached_table =3D kmemdup(rsc_table, table_sz, GFP_KERNEL);
   191		if (!rproc->cached_table)
   192			return -ENOMEM;
   193=09
   194		rproc->table_ptr =3D rproc->cached_table;
   195		rproc->table_sz =3D table_sz;
   196		trproc->rsc_table =3D rsc_table;
   197=09
   198		return 0;
   199	}
   200	EXPORT_SYMBOL_GPL(tee_rproc_parse_fw);
   201=09
   202	struct resource_table *tee_rproc_find_loaded_rsc_table(struct rproc *r=
proc,
   203							       const struct firmware *fw)
   204	{
   205		struct tee_rproc *trproc =3D rproc->tee_interface;
   206		struct resource_table *rsc_table;
   207		size_t table_sz;
   208=09
   209		if (!trproc)
   210			return ERR_PTR(-EINVAL);
   211=09
   212		/* Check if the resourse table has already been obtained in tee_rproc=
_parse_fw() */
   213		if (trproc->rsc_table)
   214			return trproc->rsc_table;
   215=09
   216		rsc_table =3D tee_rproc_get_loaded_rsc_table(rproc, &table_sz);
   217		if (IS_ERR(rsc_table))
   218			return rsc_table;
   219=09
   220		rproc->table_sz =3D table_sz;
   221		trproc->rsc_table =3D rsc_table;
   222=09
   223		return rsc_table;
   224	}
   225	EXPORT_SYMBOL_GPL(tee_rproc_find_loaded_rsc_table);
   226=09
   227	int tee_rproc_start(struct rproc *rproc)
   228	{
   229		struct tee_ioctl_invoke_arg arg;
   230		struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
   231		struct tee_rproc *trproc =3D rproc->tee_interface;
   232		int ret;
   233=09
   234		if (!trproc)
   235			return -EINVAL;
   236=09
   237		tee_rproc_prepare_args(trproc, TA_RPROC_FW_CMD_START_FW, &arg, param,=
 0);
   238=09
   239		ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
   240		if (ret < 0 || arg.ret !=3D 0) {
   241			dev_err(tee_rproc_ctx->dev,
   242				"TA_RPROC_FW_CMD_START_FW invoke failed TEE err: %x, ret:%x\n",
   243				arg.ret, ret);
   244			if (!ret)
   245				ret =3D -EIO;
   246		}
   247=09
   248		return ret;
   249	}
   250	EXPORT_SYMBOL_GPL(tee_rproc_start);
   251=09
   252	int tee_rproc_stop(struct rproc *rproc)
   253	{
   254		struct tee_ioctl_invoke_arg arg;
   255		struct tee_param param[MAX_TEE_PARAM_ARRY_MEMBER];
   256		struct tee_rproc *trproc =3D rproc->tee_interface;
   257		int ret;
   258=09
   259		if (!trproc)
   260			return -EINVAL;
   261=09
   262		tee_rproc_prepare_args(trproc, TA_RPROC_FW_CMD_STOP_FW, &arg, param, =
0);
   263=09
   264		ret =3D tee_client_invoke_func(tee_rproc_ctx->tee_ctx, &arg, param);
   265		if (ret < 0 || arg.ret !=3D 0) {
   266			dev_err(tee_rproc_ctx->dev,
   267				"TA_RPROC_FW_CMD_STOP_FW invoke failed TEE err: %x, ret:%x\n",
   268				arg.ret, ret);
   269			if (!ret)
   270				ret =3D -EIO;
   271		}
   272=09
   273		if (!rproc->table_ptr)
   274			return ret;
   275=09
 > 276		iounmap(trproc->rsc_table);
   277		trproc->rsc_table =3D NULL;
   278		rproc->table_ptr =3D NULL;
   279=09
   280		return 0;
   281	}
   282	EXPORT_SYMBOL_GPL(tee_rproc_stop);
   283=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============4923935102398462621==--

