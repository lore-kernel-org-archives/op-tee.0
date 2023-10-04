From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v10 1/4] tee: optee: system call property
Date: Wed, 04 Oct 2023 09:47:46 +0800
Message-ID: <202310040951.IEVtCbbL-lkp@intel.com>
In-Reply-To: <20231003140637.31346-2-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0331468596719703680=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0331468596719703680==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.6-rc4 next-20231003]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Etienne-Carriere/tee-o=
ptee-system-call-property/20231003-220916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20231003140637.31346-2-etienne.carri=
ere%40foss.st.com
patch subject: [PATCH v10 1/4] tee: optee: system call property
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20231004/20=
2310040951.IEVtCbbL-lkp(a)intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0231004/202310040951.IEVtCbbL-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310040951.IEVtCbbL-lkp(a)i=
ntel.com/

All warnings (new ones prefixed by >>):

>> drivers/tee/optee/ffa_abi.c:618: warning: Function parameter or member 'sy=
stem_thread' not described in 'optee_ffa_do_call_with_arg'
--
   drivers/tee/optee/smc_abi.c:818: warning: Function parameter or member 'rp=
c_arg' not described in 'optee_handle_rpc'
>> drivers/tee/optee/smc_abi.c:890: warning: Function parameter or member 'sy=
stem_thread' not described in 'optee_smc_do_call_with_arg'


vim +618 drivers/tee/optee/ffa_abi.c

4615e5a34b95e0 Jens Wiklander   2021-07-21  602 =20
4615e5a34b95e0 Jens Wiklander   2021-07-21  603  /**
4615e5a34b95e0 Jens Wiklander   2021-07-21  604   * optee_ffa_do_call_with_ar=
g() - Do a FF-A call to enter OP-TEE in secure world
4615e5a34b95e0 Jens Wiklander   2021-07-21  605   * @ctx:	calling context
4615e5a34b95e0 Jens Wiklander   2021-07-21  606   * @shm:	shared memory holdi=
ng the message to pass to secure world
5b4018b959149e Jens Wiklander   2022-01-25  607   * @offs:	offset of the mess=
age in @shm
4615e5a34b95e0 Jens Wiklander   2021-07-21  608   *
4615e5a34b95e0 Jens Wiklander   2021-07-21  609   * Does a FF-A call to OP-TE=
E in secure world and handles eventual resulting
4615e5a34b95e0 Jens Wiklander   2021-07-21  610   * Remote Procedure Calls (R=
PC) from OP-TEE.
4615e5a34b95e0 Jens Wiklander   2021-07-21  611   *
4615e5a34b95e0 Jens Wiklander   2021-07-21  612   * Returns return code from =
FF-A, 0 is OK
4615e5a34b95e0 Jens Wiklander   2021-07-21  613   */
4615e5a34b95e0 Jens Wiklander   2021-07-21  614 =20
4615e5a34b95e0 Jens Wiklander   2021-07-21  615  static int optee_ffa_do_call=
_with_arg(struct tee_context *ctx,
8f8e909e5204c3 Etienne Carriere 2023-10-03  616  				      struct tee_shm *sh=
m, u_int offs,
8f8e909e5204c3 Etienne Carriere 2023-10-03  617  				      bool system_thread)
4615e5a34b95e0 Jens Wiklander   2021-07-21 @618  {
4615e5a34b95e0 Jens Wiklander   2021-07-21  619  	struct ffa_send_direct_data=
 data =3D {
4615e5a34b95e0 Jens Wiklander   2021-07-21  620  		.data0 =3D OPTEE_FFA_YIELD=
ING_CALL_WITH_ARG,
4615e5a34b95e0 Jens Wiklander   2021-07-21  621  		.data1 =3D (u32)shm->sec_w=
orld_id,
4615e5a34b95e0 Jens Wiklander   2021-07-21  622  		.data2 =3D (u32)(shm->sec_=
world_id >> 32),
5b4018b959149e Jens Wiklander   2022-01-25  623  		.data3 =3D offs,
4615e5a34b95e0 Jens Wiklander   2021-07-21  624  	};
4064c461148ab1 Jens Wiklander   2021-12-28  625  	struct optee_msg_arg *arg;
4064c461148ab1 Jens Wiklander   2021-12-28  626  	unsigned int rpc_arg_offs;
4064c461148ab1 Jens Wiklander   2021-12-28  627  	struct optee_msg_arg *rpc_a=
rg;
4064c461148ab1 Jens Wiklander   2021-12-28  628 =20
a639b2b18a240d Jens Wiklander   2022-01-12  629  	/*
a639b2b18a240d Jens Wiklander   2022-01-12  630  	 * The shared memory object=
 has to start on a page when passed as
a639b2b18a240d Jens Wiklander   2022-01-12  631  	 * an argument struct. This=
 is also what the shm pool allocator
a639b2b18a240d Jens Wiklander   2022-01-12  632  	 * returns, but check this =
before calling secure world to catch
a639b2b18a240d Jens Wiklander   2022-01-12  633  	 * eventual errors early in=
 case something changes.
a639b2b18a240d Jens Wiklander   2022-01-12  634  	 */
a639b2b18a240d Jens Wiklander   2022-01-12  635  	if (shm->offset)
a639b2b18a240d Jens Wiklander   2022-01-12  636  		return -EINVAL;
a639b2b18a240d Jens Wiklander   2022-01-12  637 =20
5b4018b959149e Jens Wiklander   2022-01-25  638  	arg =3D tee_shm_get_va(shm,=
 offs);
4064c461148ab1 Jens Wiklander   2021-12-28  639  	if (IS_ERR(arg))
4064c461148ab1 Jens Wiklander   2021-12-28  640  		return PTR_ERR(arg);
4064c461148ab1 Jens Wiklander   2021-12-28  641 =20
4064c461148ab1 Jens Wiklander   2021-12-28  642  	rpc_arg_offs =3D OPTEE_MSG_=
GET_ARG_SIZE(arg->num_params);
5b4018b959149e Jens Wiklander   2022-01-25  643  	rpc_arg =3D tee_shm_get_va(=
shm, offs + rpc_arg_offs);
4064c461148ab1 Jens Wiklander   2021-12-28  644  	if (IS_ERR(rpc_arg))
4064c461148ab1 Jens Wiklander   2021-12-28  645  		return PTR_ERR(rpc_arg);
4615e5a34b95e0 Jens Wiklander   2021-07-21  646 =20
8f8e909e5204c3 Etienne Carriere 2023-10-03  647  	return optee_ffa_yielding_c=
all(ctx, &data, rpc_arg, system_thread);
4615e5a34b95e0 Jens Wiklander   2021-07-21  648  }
4615e5a34b95e0 Jens Wiklander   2021-07-21  649 =20

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============0331468596719703680==--

