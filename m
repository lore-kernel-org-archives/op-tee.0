From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v2 0/4] Introduction of a remoteproc tee to load signed firmware
Date: Thu, 18 Jan 2024 10:05:09 +0000
Message-ID: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8905094414749098844=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8905094414749098844==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Updates from the previous version [1]
- fix issues reported by kernel test robot,
- address Rob Herring comment on bindings.

[1] https://lore.kernel.org/linux-arm-kernel/20240115135249.296822-1-arnaud.p=
ouliquen(a)foss.st.com/T/


This series proposes the implementation of a remoteproc tee driver to
communicate with a TEE trusted application responsible for authenticating and
loading the remoteproc firmware image in an Arm secure context.

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

Arnaud Pouliquen (4):
  remoteproc: Add TEE support
  dt-bindings: remoteproc: add compatibility for TEE support
  remoteproc: stm32: create sub-functions to request shutdown and
    release
  remoteproc: stm32: Add support of an OP-TEE TA to load the firmware

 .../bindings/remoteproc/st,stm32-rproc.yaml   |  52 ++-
 drivers/remoteproc/Kconfig                    |   9 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/stm32_rproc.c              | 233 +++++++++--
 drivers/remoteproc/tee_remoteproc.c           | 393 ++++++++++++++++++
 include/linux/tee_remoteproc.h                |  99 +++++
 6 files changed, 740 insertions(+), 47 deletions(-)
 create mode 100644 drivers/remoteproc/tee_remoteproc.c
 create mode 100644 include/linux/tee_remoteproc.h


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
--=20
2.25.1


--===============8905094414749098844==--

