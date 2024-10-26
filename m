From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v12 7/7] remoteproc: stm32: Add support of an OP-TEE TA to
 load the firmware
Date: Sat, 26 Oct 2024 20:45:42 +0800
Message-ID: <202410262040.PWNrKv2Q-lkp@intel.com>
In-Reply-To: <20241025205924.2087768-8-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5352927490320984752=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5352927490320984752==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaud,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 42f7652d3eb527d03665b09edac47f85fb600924]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remot=
eproc-core-Introduce-rproc_pa_to_va-helper/20241026-050443
base:   42f7652d3eb527d03665b09edac47f85fb600924
patch link:    https://lore.kernel.org/r/20241025205924.2087768-8-arnaud.poul=
iquen%40foss.st.com
patch subject: [PATCH v12 7/7] remoteproc: stm32: Add support of an OP-TEE TA=
 to load the firmware
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241026/=
202410262040.PWNrKv2Q-lkp(a)intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0241026/202410262040.PWNrKv2Q-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410262040.PWNrKv2Q-lkp(a)i=
ntel.com/

All warnings (new ones prefixed by >>):

   drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_probe':
>> drivers/remoteproc/stm32_rproc.c:904:21: warning: assignment to 'int' from=
 'struct rproc_tee *' makes integer from pointer without a cast [-Wint-conver=
sion]
     904 |                 ret =3D rproc_tee_register(dev, rproc, proc_id);
         |                     ^
   drivers/remoteproc/stm32_rproc.c:963:30: error: passing argument 1 of 'rpr=
oc_tee_unregister' from incompatible pointer type [-Werror=3Dincompatible-poi=
nter-types]
     963 |         rproc_tee_unregister(rproc);
         |                              ^~~~~
         |                              |
         |                              struct rproc *
   In file included from drivers/remoteproc/stm32_rproc.c:21:
   include/linux/remoteproc_tee.h:59:58: note: expected 'struct rproc_tee *' =
but argument is of type 'struct rproc *'
      59 | static inline int rproc_tee_unregister(struct rproc_tee *trproc)
         |                                        ~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_remove':
   drivers/remoteproc/stm32_rproc.c:986:30: error: passing argument 1 of 'rpr=
oc_tee_unregister' from incompatible pointer type [-Werror=3Dincompatible-poi=
nter-types]
     986 |         rproc_tee_unregister(rproc);
         |                              ^~~~~
         |                              |
         |                              struct rproc *
   include/linux/remoteproc_tee.h:59:58: note: expected 'struct rproc_tee *' =
but argument is of type 'struct rproc *'
      59 | static inline int rproc_tee_unregister(struct rproc_tee *trproc)
         |                                        ~~~~~~~~~~~~~~~~~~^~~~~~
   cc1: some warnings being treated as errors


vim +904 drivers/remoteproc/stm32_rproc.c

   874=09
   875	static int stm32_rproc_probe(struct platform_device *pdev)
   876	{
   877		struct device *dev =3D &pdev->dev;
   878		struct stm32_rproc *ddata;
   879		struct device_node *np =3D dev->of_node;
   880		struct rproc *rproc;
   881		unsigned int state;
   882		u32 proc_id;
   883		int ret;
   884=09
   885		ret =3D dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
   886		if (ret)
   887			return ret;
   888=09
   889		if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
   890			/*
   891			 * Delegate the firmware management to the secure context.
   892			 * The firmware loaded has to be signed.
   893			 */
   894			ret =3D of_property_read_u32(np, "st,proc-id", &proc_id);
   895			if (ret) {
   896				dev_err(dev, "failed to read st,rproc-id property\n");
   897				return ret;
   898			}
   899=09
   900			rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_tee_ops, NULL, s=
izeof(*ddata));
   901			if (!rproc)
   902				return -ENOMEM;
   903=09
 > 904			ret =3D rproc_tee_register(dev, rproc, proc_id);
   905			if (ret)
   906				return dev_err_probe(dev, ret,  "signed firmware not supported by T=
EE\n");
   907		} else {
   908			rproc =3D devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeo=
f(*ddata));
   909			if (!rproc)
   910				return -ENOMEM;
   911		}
   912=09
   913		ddata =3D rproc->priv;
   914=09
   915		rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
   916=09
   917		ret =3D stm32_rproc_parse_dt(pdev, ddata, &rproc->auto_boot);
   918		if (ret)
   919			goto free_rproc;
   920=09
   921		ret =3D stm32_rproc_of_memory_translations(pdev, ddata);
   922		if (ret)
   923			goto free_rproc;
   924=09
   925		ret =3D stm32_rproc_get_m4_status(ddata, &state);
   926		if (ret)
   927			goto free_rproc;
   928=09
   929		if (state =3D=3D M4_STATE_CRUN)
   930			rproc->state =3D RPROC_DETACHED;
   931=09
   932		rproc->has_iommu =3D false;
   933		ddata->workqueue =3D create_workqueue(dev_name(dev));
   934		if (!ddata->workqueue) {
   935			dev_err(dev, "cannot create workqueue\n");
   936			ret =3D -ENOMEM;
   937			goto free_resources;
   938		}
   939=09
   940		platform_set_drvdata(pdev, rproc);
   941=09
   942		ret =3D stm32_rproc_request_mbox(rproc);
   943		if (ret)
   944			goto free_wkq;
   945=09
   946		ret =3D rproc_add(rproc);
   947		if (ret)
   948			goto free_mb;
   949=09
   950		return 0;
   951=09
   952	free_mb:
   953		stm32_rproc_free_mbox(rproc);
   954	free_wkq:
   955		destroy_workqueue(ddata->workqueue);
   956	free_resources:
   957		rproc_resource_cleanup(rproc);
   958	free_rproc:
   959		if (device_may_wakeup(dev)) {
   960			dev_pm_clear_wake_irq(dev);
   961			device_init_wakeup(dev, false);
   962		}
   963		rproc_tee_unregister(rproc);
   964=09
   965		return ret;
   966	}
   967=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============5352927490320984752==--

