From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v13 0/7] Introduction of a remoteproc tee to load signed firmware
Date: Mon, 04 Nov 2024 14:35:08 +0100
Message-ID: <20241104133515.256497-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6258653432175277038=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6258653432175277038==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Main updates from version V12[1]:
Fix warning build by fixing the inline declaration in
remoteproc_tee.h (when CONFIG_REMOTEPROC_TEE is not set).
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410262040.PWNrKv2Q-lkp(a)int=
el.com/

Main updates from version V11[2]:
- rename structures, functions, and variables from "tee_rproc_xxx" to
  "rproc_tee_xxx",
- update rproc_tee_register to return an error instead of
  "struct rproc_tee *" pointer
 =20
[1] https://lore.kernel.org/lkml/20241025205924.2087768-1-arnaud.pouliquen(a)=
foss.st.com/
[2] https://lore.kernel.org/lkml/ZxZ4cBilIlpf3IPw(a)p14s/T/

Tested-on: commit 42f7652d3eb5 ("Linux 6.12-rc4")
Description of the feature:
--------------------------
This series proposes the implementation of a remoteproc tee driver to
communicate with a TEE trusted application responsible for authenticating
and loading the remoteproc firmware image in an Arm secure context.

1) Principle:

The remoteproc tee driver provides services to communicate with the OP-TEE
trusted application running on the Trusted Execution Context (TEE).
The trusted application in TEE manages the remote processor lifecycle:

- authenticating and loading firmware images,
- isolating and securing the remote processor memories,
- supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
- managing the start and stop of the firmware by the TEE.

2) Format of the signed image:

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/src/remoteproc_c=
ore.c#L18-L57

3) OP-TEE trusted application API:

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/include/ta_remot=
eproc.h

4) OP-TEE signature script

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/scripts/sign_rproc_fw.py

Example of usage:
sign_rproc_fw.py --in <fw1.elf> --in <fw2.elf> --out <signed_fw.sign> --key $=
{OP-TEE_PATH}/keys/default.pem


5) Impact on User space Application

No sysfs impact. The user only needs to provide the signed firmware image
instead of the ELF image.


For more information about the implementation, a presentation is available he=
re
(note that the format of the signed image has evolved between the presentation
and the integration in OP-TEE).

https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds

Arnaud Pouliquen (7):
  remoteproc: core: Introduce rproc_pa_to_va helper
  remoteproc: Add TEE support
  remoteproc: core: Refactor resource table cleanup into
    rproc_release_fw
  remoteproc: Introduce release_fw optional operation
  dt-bindings: remoteproc: Add compatibility for TEE support
  remoteproc: stm32: Create sub-functions to request shutdown and
    release
  remoteproc: stm32: Add support of an OP-TEE TA to load the firmware

 .../bindings/remoteproc/st,stm32-rproc.yaml   |  58 +-
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_core.c          |  72 ++-
 drivers/remoteproc/remoteproc_tee.c           | 510 ++++++++++++++++++
 drivers/remoteproc/stm32_rproc.c              | 139 +++--
 include/linux/remoteproc.h                    |   8 +
 include/linux/remoteproc_tee.h                | 105 ++++
 8 files changed, 848 insertions(+), 55 deletions(-)
 create mode 100644 drivers/remoteproc/remoteproc_tee.c
 create mode 100644 include/linux/remoteproc_tee.h


base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
--=20
2.25.1


--===============6258653432175277038==--

