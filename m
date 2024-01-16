From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 4/4] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Tue, 16 Jan 2024 16:46:21 +0800
Message-ID: <202401161603.5dloSqiJ-lkp@intel.com>
In-Reply-To: <20240115135249.296822-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8777270652613889826=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8777270652613889826==
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
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240116/=
202401161603.5dloSqiJ-lkp(a)intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5=
becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0240116/202401161603.5dloSqiJ-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161603.5dloSqiJ-lkp(a)i=
ntel.com/

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/stm32_rproc.c:977:6: warning: variable 'trproc' is used=
 uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     977 |         if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/stm32_rproc.c:991:8: note: uninitialized use occurs here
     991 |                             trproc ? &st_rproc_tee_ops : &st_rproc=
_ops,
         |                             ^~~~~~
   drivers/remoteproc/stm32_rproc.c:977:2: note: remove the 'if' if its condi=
tion is always true
     977 |         if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/remoteproc/stm32_rproc.c:968:26: note: initialize the variable 'tr=
proc' to silence this warning
     968 |         struct tee_rproc *trproc;
         |                                 ^
         |                                  =3D NULL
   1 warning generated.


vim +977 drivers/remoteproc/stm32_rproc.c

   962=09
   963	static int stm32_rproc_probe(struct platform_device *pdev)
   964	{
   965		struct device *dev =3D &pdev->dev;
   966		struct stm32_rproc *ddata;
   967		struct device_node *np =3D dev->of_node;
   968		struct tee_rproc *trproc;
   969		struct rproc *rproc;
   970		unsigned int state;
   971		int ret;
   972=09
   973		ret =3D dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
   974		if (ret)
   975			return ret;
   976=09
 > 977		if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
   978			trproc =3D tee_rproc_register(dev, STM32_MP1_M4_PROC_ID);
   979			if (IS_ERR(trproc)) {
   980				dev_err_probe(dev, PTR_ERR(trproc),
   981					      "signed firmware not supported by TEE\n");
   982				return PTR_ERR(trproc);
   983			}
   984			/*
   985			 * Delegate the firmware management to the secure context.
   986			 * The firmware loaded has to be signed.
   987			 */
   988			dev_info(dev, "Support of signed firmware only\n");
   989		}
   990		rproc =3D rproc_alloc(dev, np->name,
   991				    trproc ? &st_rproc_tee_ops : &st_rproc_ops,
   992				    NULL, sizeof(*ddata));
   993		if (!rproc) {
   994			ret =3D -ENOMEM;
   995			goto free_tee;
   996		}
   997=09
   998		ddata =3D rproc->priv;
   999		ddata->trproc =3D trproc;
  1000		if (trproc)
  1001			trproc->rproc =3D rproc;
  1002=09
  1003		rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
  1004=09
  1005		ret =3D stm32_rproc_parse_dt(pdev, ddata, &rproc->auto_boot);
  1006		if (ret)
  1007			goto free_rproc;
  1008=09
  1009		ret =3D stm32_rproc_of_memory_translations(pdev, ddata);
  1010		if (ret)
  1011			goto free_rproc;
  1012=09
  1013		ret =3D stm32_rproc_get_m4_status(ddata, &state);
  1014		if (ret)
  1015			goto free_rproc;
  1016=09
  1017		if (state =3D=3D M4_STATE_CRUN)
  1018			rproc->state =3D RPROC_DETACHED;
  1019=09
  1020		rproc->has_iommu =3D false;
  1021		ddata->workqueue =3D create_workqueue(dev_name(dev));
  1022		if (!ddata->workqueue) {
  1023			dev_err(dev, "cannot create workqueue\n");
  1024			ret =3D -ENOMEM;
  1025			goto free_resources;
  1026		}
  1027=09
  1028		platform_set_drvdata(pdev, rproc);
  1029=09
  1030		ret =3D stm32_rproc_request_mbox(rproc);
  1031		if (ret)
  1032			goto free_wkq;
  1033=09
  1034		ret =3D rproc_add(rproc);
  1035		if (ret)
  1036			goto free_mb;
  1037=09
  1038		return 0;
  1039=09
  1040	free_mb:
  1041		stm32_rproc_free_mbox(rproc);
  1042	free_wkq:
  1043		destroy_workqueue(ddata->workqueue);
  1044	free_resources:
  1045		rproc_resource_cleanup(rproc);
  1046	free_rproc:
  1047		if (device_may_wakeup(dev)) {
  1048			dev_pm_clear_wake_irq(dev);
  1049			device_init_wakeup(dev, false);
  1050		}
  1051		rproc_free(rproc);
  1052	free_tee:
  1053		if (trproc)
  1054			tee_rproc_unregister(trproc);
  1055=09
  1056		return ret;
  1057	}
  1058=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============8777270652613889826==--

