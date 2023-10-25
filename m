From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/3] crypto: ccp - Use psp_tee_alloc_buffer() and
 psp_tee_free_buffer()
Date: Thu, 26 Oct 2023 05:26:13 +0800
Message-ID: <202310260529.GEey5HQc-lkp@intel.com>
In-Reply-To: <20231025065700.1556152-3-JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5378058798384428977=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5378058798384428977==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi jeshwank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on herbert-crypto-2.6/master]
[also build test WARNING on linus/master v6.6-rc7]
[cannot apply to herbert-cryptodev-2.6/master next-20231025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jeshwank/crypto-ccp-Ad=
d-function-to-allocate-and-free-memory-using-DMA-APIs/20231025-150420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.gi=
t master
patch link:    https://lore.kernel.org/r/20231025065700.1556152-3-JESHWANTHKU=
MAR.NK%40amd.com
patch subject: [PATCH 2/3] crypto: ccp - Use psp_tee_alloc_buffer() and psp_t=
ee_free_buffer()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231026=
/202310260529.GEey5HQc-lkp(a)intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0231026/202310260529.GEey5HQc-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310260529.GEey5HQc-lkp(a)i=
ntel.com/

All warnings (new ones prefixed by >>):

>> drivers/crypto/ccp/tee-dev.c:123:24: warning: no previous prototype for 't=
ee_alloc_cmd_buffer' [-Wmissing-prototypes]
     123 | struct psp_tee_buffer *tee_alloc_cmd_buffer(struct psp_tee_device =
*tee)
         |                        ^~~~~~~~~~~~~~~~~~~~


vim +/tee_alloc_cmd_buffer +123 drivers/crypto/ccp/tee-dev.c

   122=09
 > 123	struct psp_tee_buffer *tee_alloc_cmd_buffer(struct psp_tee_device *tee)
   124	{
   125		struct tee_init_ring_cmd *cmd;
   126		struct psp_tee_buffer *cmd_buffer;
   127=09
   128		cmd_buffer =3D psp_tee_alloc_buffer(sizeof(*cmd),
   129						  GFP_KERNEL | __GFP_ZERO);
   130		if (!cmd_buffer)
   131			return NULL;
   132=09
   133		cmd =3D (struct tee_init_ring_cmd *)cmd_buffer->vaddr;
   134		cmd->hi_addr =3D upper_32_bits(tee->rb_mgr.ring_buf->paddr);
   135		cmd->low_addr =3D lower_32_bits(tee->rb_mgr.ring_buf->paddr);
   136		cmd->size =3D tee->rb_mgr.ring_buf->size;
   137=09
   138		dev_dbg(tee->dev, "tee: ring address: high =3D 0x%x low =3D 0x%x size=
 =3D %u\n",
   139			cmd->hi_addr, cmd->low_addr, cmd->size);
   140=09
   141		return cmd_buffer;
   142	}
   143=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============5378058798384428977==--

