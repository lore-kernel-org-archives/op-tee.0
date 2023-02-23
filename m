From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add SMC for loading OP-TEE image
Date: Thu, 23 Feb 2023 15:51:36 +0800
Message-ID: <202302231536.Vn2DNHd4-lkp@intel.com>
In-Reply-To: <
 <20230222092409.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7334412409590593114=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7334412409590593114==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeffrey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2 next-20230223]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeffrey-Kardatzke/tee-=
optee-Add-SMC-for-loading-OP-TEE-image/20230223-012817
patch link:    https://lore.kernel.org/r/20230222092409.1.I8e7f9b01d9ac940507=
d78e15368e200a6a69bedb%40changeid
patch subject: [PATCH] tee: optee: Add SMC for loading OP-TEE image
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230223/202=
302231536.Vn2DNHd4-lkp(a)intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/ma=
ke.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c19d72729a3c17aefd43e=
283bbfe3dd5abd2b26b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeffrey-Kardatzke/tee-optee-Add-SMC-=
for-loading-OP-TEE-image/20230223-012817
        git checkout c19d72729a3c17aefd43e283bbfe3dd5abd2b26b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Darm64 olddefconfig
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302231536.Vn2DNHd4-lkp(a)int=
el.com/

All errors (new ones prefixed by >>):

>> drivers/tee/optee/smc_abi.c:1425:34: error: conflicting types for '__unuse=
d'; have 'void (*)(long unsigned int,  long unsigned int,  long unsigned int,=
  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned i=
nt,  long unsigned int,  struct arm_smccc_res *)'
    1425 |                 optee_invoke_fn *__unused) {
         |                 ~~~~~~~~~~~~~~~~~^~~~~~~~
   drivers/tee/optee/smc_abi.c:1424:57: note: previous definition of '__unuse=
d' with type 'struct platform_device *'
    1424 | static inline int optee_load_fw(struct platform_device *__unused,
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~


vim +1425 drivers/tee/optee/smc_abi.c

  1362=09
  1363	static int optee_load_fw(struct platform_device *pdev,
  1364				 optee_invoke_fn *invoke_fn)
  1365	{
  1366		const struct firmware *fw =3D NULL;
  1367		struct arm_smccc_res res;
  1368		phys_addr_t data_pa;
  1369		u8 *data_buf =3D NULL;
  1370		u64 data_size;
  1371		u32 data_pa_high, data_pa_low;
  1372		u32 data_size_high, data_size_low;
  1373		int rc;
  1374=09
  1375		rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
  1376		if (rc) {
  1377			/*
  1378			 * The firmware in the rootfs will not be accessible until we
  1379			 * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
  1380			 * that point.
  1381			 */
  1382			if (system_state < SYSTEM_RUNNING)
  1383				return -EPROBE_DEFER;
  1384			goto fw_err;
  1385		}
  1386=09
  1387		data_size =3D fw->size;
  1388		/*
  1389		 * This uses the GFP_DMA flag to ensure we are allocated memory in the
  1390		 * 32-bit space since TF-A cannot map memory beyond the 32-bit bounda=
ry.
  1391		 */
  1392		data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
  1393		if (!data_buf) {
  1394			rc =3D -ENOMEM;
  1395			goto fw_err;
  1396		}
  1397		memcpy(data_buf, fw->data, fw->size);
  1398		data_pa =3D virt_to_phys(data_buf);
  1399		reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
  1400		reg_pair_from_64(&data_size_high, &data_size_low, data_size);
  1401		goto fw_load;
  1402=09
  1403	fw_err:
  1404		pr_warn("image loading failed\n");
  1405		data_pa_high =3D data_pa_low =3D data_size_high =3D data_size_low =3D=
 0;
  1406=09
  1407	fw_load:
  1408		/*
  1409		 * Always invoke the SMC, even if loading the image fails, to indicate
  1410		 * to EL3 that we have passed the point where it should allow invoking
  1411		 * this SMC.
  1412		 */
  1413		invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
  1414			  data_pa_high, data_pa_low, 0, 0, 0, &res);
  1415		if (!rc)
  1416			rc =3D res.a0;
  1417		if (fw)
  1418			release_firmware(fw);
  1419		kfree(data_buf);
  1420=09
  1421		return rc;
  1422	}
  1423	#else
  1424	static inline int optee_load_fw(struct platform_device *__unused,
> 1425			optee_invoke_fn *__unused) {
  1426		return 0;
  1427	}
  1428	#endif
  1429=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--===============7334412409590593114==--

