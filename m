From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v8 0/5] Introduction of a remoteproc tee to load signed firmware
Date: Fri, 21 Jun 2024 16:37:54 +0200
Message-ID: <20240621143759.547793-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3798665485793523371=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3798665485793523371==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Main updates from version V7[1]

Update the series based on Mathieu Poirier's comments.
Details of the updates are listed in the commit messages of the patches.

[1] https://lore.kernel.org/linux-arm-kernel/20240611073904.475019-1-arnaud.p=
ouliquen(a)foss.st.com/

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
 drivers/remoteproc/remoteproc_core.c          |  46 ++
 drivers/remoteproc/remoteproc_tee.c           | 446 ++++++++++++++++++
 drivers/remoteproc/stm32_rproc.c              | 147 ++++--
 include/linux/remoteproc.h                    |   5 +
 include/linux/remoteproc_tee.h                | 100 ++++
 8 files changed, 769 insertions(+), 44 deletions(-)
 create mode 100644 drivers/remoteproc/remoteproc_tee.c
 create mode 100644 include/linux/remoteproc_tee.h


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
--=20
2.25.1


--===============3798665485793523371==--

