From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9] tee: optee: Add SMC for loading OP-TEE image
Date: Thu, 16 Mar 2023 02:41:17 +0800
Message-ID: <202303160226.q1JZZFAw-lkp@intel.com>
In-Reply-To: <
 <20230314135704.v9.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0665607060656783879=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0665607060656783879==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeffrey,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeffrey-Kardatzke/tee-=
optee-Add-SMC-for-loading-OP-TEE-image/20230315-045847
patch link:    https://lore.kernel.org/r/20230314135704.v9.1.I8e7f9b01d9ac940=
507d78e15368e200a6a69bedb%40changeid
patch subject: [PATCH v9] tee: optee: Add SMC for loading OP-TEE image
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/cab42c7807bc48ef66457=
3253d3f37c6bf7c1d08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeffrey-Kardatzke/tee-optee-Add-SMC-=
for-loading-OP-TEE-image/20230315-045847
        git checkout cab42c7807bc48ef664573253d3f37c6bf7c1d08
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_W=
ARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160226.q1JZZFAw-lkp(a)int=
el.com/

All warnings (new ones prefixed by >>):

>> Documentation/staging/tee.rst:233: WARNING: Unexpected indentation.
>> Documentation/staging/tee.rst:234: WARNING: Block quote ends without a bla=
nk line; unexpected unindent.
>> Documentation/staging/tee.rst:237: WARNING: Enumerated list ends without a=
 blank line; unexpected unindent.

vim +233 Documentation/staging/tee.rst

   230=09
   231	1. Boot chain security.
   232	   Attack vector: Replace the OP-TEE OS image in the rootfs to gain co=
ntrol of
 > 233	                  the system.
 > 234	   Migitation: There must be boot chain security that verifies the ker=
nel and
   235	               rootfs, otherwise an attacker can modify the loaded OP-=
TEE
   236	               binary by modifying it in the rootfs.
 > 237	3. Alternate boot modes.
   238	   Attack vector: Using an alternate boot mode (i.e. recovery mode), t=
he OP-TEE
   239	                  driver isn't loaded, leaving the SMC hole open.
   240	   Mitigation: If there are alternate methods of booting the device, s=
uch as a
   241	               recovery mode, it should be ensured that the same mitig=
ations are
   242	               applied in that mode.
   243	3. Attacks prior to SMC invocation.
   244	   Attack vector: Code that is executed prior to issuing the SMC call =
to load
   245	                  OP-TEE can be exploited to then load an alternate OS=
 image.
   246	   Mitigation: The OP-TEE driver must be loaded before any potential a=
ttack
   247	               vectors are opened up. This should include mounting of =
any
   248	               modifiable filesystems, opening of network ports or com=
municating
   249	               with external devices (e.g. USB).
   250	4. Blocking SMC call to load OP-TEE.
   251	   Attack vector: Prevent the driver from being probed, so the SMC cal=
l to load
   252	                  OP-TEE isn't executed when desired, leaving it open =
to being
   253	                  executed later and loading a modified OS.
   254	   Mitigation: It is recommended to build the OP-TEE driver as an incl=
uded
   255	               driver rather than a module to prevent exploits that ma=
y cause
   256	               the module to not be loaded.
   257=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--===============0665607060656783879==--

