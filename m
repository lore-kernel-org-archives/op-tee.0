From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v6 0/5] Introduction of a remoteproc tee to load signed firmware
Date: Fri, 07 Jun 2024 11:33:21 +0200
Message-ID: <20240607093326.369090-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4325519379956427905=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4325519379956427905==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Main updates from the previous version [1][2]:
------------------------------------------

1) Rework resource table management
  - Rework tee_rproc_parse_fw to temporary map the resource table address
    to create a cached_table (similar to what is done in
    rproc_elf_load_rsc_table()).
  - Rename tee_rproc_get_loaded_rsc_table to tee_rproc_find_loaded_rsc_table
  - Introduce rproc_pa_to_va() allowing to translate the resource table
    physical address to virtual address based on remoteproc carveouts.

2) Merge the 2 "st,stm32-rproc.yaml" bindings patch in one
   As the st,rproc-id" is linked to the introduction of the
   "st,stm32mp1-m4-tee" compatible, merge following patches to address
   Krzysztof concern.
   - [PATCH v5 2/7] dt-bindings: remoteproc: Add compatibility for TEE support
   - [PATCH v5 3/7] dt-bindings: remoteproc: Add processor identifier property

More details on updates are listed in commits messages.

[1] https://lore.kernel.org/lkml/Zlil4YSjHxb0FRgf(a)p14s/T/
[2] https://lore.kernel.org/lkml/20240521122458.3517054-1-arnaud.pouliquen(a)=
foss.st.com/

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

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

No sysfs impact.the user only needs to provide the signed firmware image
instead of the ELF image.


For more information about the implementation, a presentation is available he=
re
(note that the format of the signed image has evolved between the presentation
and the integration in OP-TEE).

https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds

Arnaud Pouliquen (5):
  remoteproc: core: Introduce rproc_pa_to_va helper
  remoteproc: Add TEE support
  dt-bindings: remoteproc: Add compatibility for TEE support
  remoteproc: stm32: Create sub-functions to request shutdown and
    release
  remoteproc: stm32: Add support of an OP-TEE TA to load the firmware

 .../bindings/remoteproc/st,stm32-rproc.yaml   |  58 ++-
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_core.c          |  74 ++-
 drivers/remoteproc/stm32_rproc.c              | 147 ++++--
 drivers/remoteproc/tee_remoteproc.c           | 451 ++++++++++++++++++
 include/linux/remoteproc.h                    |   7 +
 include/linux/tee_remoteproc.h                |  99 ++++
 8 files changed, 801 insertions(+), 46 deletions(-)
 create mode 100644 drivers/remoteproc/tee_remoteproc.c
 create mode 100644 include/linux/tee_remoteproc.h


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
--=20
2.25.1


--===============4325519379956427905==--

