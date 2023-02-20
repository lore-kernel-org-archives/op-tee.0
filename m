From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 4/4] efi: Add tee-based EFI variable driver
Date: Mon, 20 Feb 2023 15:54:34 +0800
Message-ID: <202302201535.Ns6H0Dok-lkp@intel.com>
In-Reply-To: <20230220051723.1257-5-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0461197197311993976=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0461197197311993976==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Masahisa,

I love your patch! Perhaps something to improve:

[auto build test WARNING on efi/next]
[cannot apply to linus/master v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahisa-Kojima/efi-ex=
pose-efivar-generic-ops-register-function/20230220-132235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20230220051723.1257-5-masahisa.kojim=
a%40linaro.org
patch subject: [PATCH v2 4/4] efi: Add tee-based EFI variable driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230220/20=
2302201535.Ns6H0Dok-lkp(a)intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/ma=
ke.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8ce55b3818062f45af62b=
c5eeb52f97585d0ffd1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahisa-Kojima/efi-expose-efivar-ge=
neric-ops-register-function/20230220-132235
        git checkout 8ce55b3818062f45af62bc5eeb52f97585d0ffd1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Darm olddefconfig
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash drivers/firmware/efi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302201535.Ns6H0Dok-lkp(a)int=
el.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/stmm/tee_stmm_efi.c: In function 'tee_mm_communicate':
>> drivers/firmware/efi/stmm/tee_stmm_efi.c:60:13: warning: variable 'rc' set=
 but not used [-Wunused-but-set-variable]
      60 |         int rc;
         |             ^~


vim +/rc +60 drivers/firmware/efi/stmm/tee_stmm_efi.c

    44=09
    45	/**
    46	 * tee_mm_communicate() - Pass a buffer to StandaloneMM running in TEE
    47	 *
    48	 * @comm_buf:		locally allocated communication buffer
    49	 * @dsize:		buffer size
    50	 * Return:		status code
    51	 */
    52	static efi_status_t tee_mm_communicate(void *comm_buf, size_t dsize)
    53	{
    54		size_t buf_size;
    55		efi_status_t ret;
    56		struct efi_mm_communicate_header *mm_hdr;
    57		struct tee_ioctl_invoke_arg arg;
    58		struct tee_param param[4];
    59		struct tee_shm *shm =3D NULL;
  > 60		int rc;
    61=09
    62		if (!comm_buf)
    63			return EFI_INVALID_PARAMETER;
    64=09
    65		mm_hdr =3D (struct efi_mm_communicate_header *)comm_buf;
    66		buf_size =3D mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(size_t=
);
    67=09
    68		if (dsize !=3D buf_size)
    69			return EFI_INVALID_PARAMETER;
    70=09
    71		shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, comm_buf, buf_size);
    72		if (IS_ERR(shm)) {
    73			dev_err(pvt_data.dev, "Unable to register shared memory\n");
    74			return EFI_UNSUPPORTED;
    75		}
    76=09
    77		memset(&arg, 0, sizeof(arg));
    78		arg.func =3D PTA_STMM_CMD_COMMUNICATE;
    79		arg.session =3D pvt_data.session;
    80		arg.num_params =3D 4;
    81=09
    82		memset(param, 0, sizeof(param));
    83		param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
    84		param[0].u.memref.size =3D buf_size;
    85		param[0].u.memref.shm =3D shm;
    86		param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
    87		param[2].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
    88		param[3].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
    89=09
    90		rc =3D tee_client_invoke_func(pvt_data.ctx, &arg, param);
    91		tee_shm_free(shm);
    92=09
    93		if (arg.ret !=3D 0)
    94			return EFI_DEVICE_ERROR;
    95=09
    96		switch (param[1].u.value.a) {
    97		case ARM_SVC_SPM_RET_SUCCESS:
    98			ret =3D EFI_SUCCESS;
    99			break;
   100=09
   101		case ARM_SVC_SPM_RET_INVALID_PARAMS:
   102			ret =3D EFI_INVALID_PARAMETER;
   103			break;
   104=09
   105		case ARM_SVC_SPM_RET_DENIED:
   106			ret =3D EFI_ACCESS_DENIED;
   107			break;
   108=09
   109		case ARM_SVC_SPM_RET_NO_MEMORY:
   110			ret =3D EFI_OUT_OF_RESOURCES;
   111			break;
   112=09
   113		default:
   114			ret =3D EFI_ACCESS_DENIED;
   115		}
   116=09
   117		return ret;
   118	}
   119=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--===============0461197197311993976==--

