From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v9 0/7] Introduction of a remoteproc tee to load signed firmware
Date: Fri, 30 Aug 2024 11:51:40 +0200
Message-ID: <20240830095147.3538047-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8246999743405243313=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8246999743405243313==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Main updates from version V8[1]:

Add support for tee_rproc_release_fw(), which allows releasing firmware
that has been loaded. This service is used if an error occurs between
the loading of the firmware image and the start of the remote processor.
It is also called on remote processor shutdown.

Associated with this series, an update has been sent to OP-TEE for the
support of the TA_RPROC_CMD_RELEASE_FW TEE command [2].

[1] https://lore.kernel.org/linux-arm-kernel/20240621143759.547793-4-arnaud.p=
ouliquen(a)foss.st.com/T/
[2]https://github.com/OP-TEE/optee_os/pull/7019

Tested-on: commit 5be63fc19fca ("Linux 6.11-rc5")

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

Arnaud Pouliquen (7):
  remoteproc: core: Introduce rproc_pa_to_va helper
  remoteproc: Add TEE support
  remoteproc: core: Refactor resource table cleanup into
    rproc_release_fw
  remoteproc: core: Add TEE interface support for firmware release
  dt-bindings: remoteproc: Add compatibility for TEE support
  remoteproc: stm32: Create sub-functions to request shutdown and
    release
  remoteproc: stm32: Add support of an OP-TEE TA to load the firmware

 .../bindings/remoteproc/st,stm32-rproc.yaml   |  58 ++-
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_core.c          |  77 ++-
 drivers/remoteproc/remoteproc_tee.c           | 486 ++++++++++++++++++
 drivers/remoteproc/stm32_rproc.c              | 147 ++++--
 include/linux/remoteproc.h                    |   5 +
 include/linux/remoteproc_tee.h                | 109 ++++
 8 files changed, 836 insertions(+), 57 deletions(-)
 create mode 100644 drivers/remoteproc/remoteproc_tee.c
 create mode 100644 include/linux/remoteproc_tee.h


base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
--=20
2.25.1


--===============8246999743405243313==--

