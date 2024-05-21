From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RESEND PATCH v5 0/7] Introduction of a remoteproc tee to load signed
 firmware
Date: Tue, 21 May 2024 14:24:51 +0200
Message-ID: <20240521122458.3517054-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1583638969851638766=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1583638969851638766==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Main updates from the previous version [1]:
------------------------------------------

1) use proc->table_ptr as unique reference to point to the resource table
 --> update remoteproc_core.c to implement management of the resource table
     base on rproc->rproc->tee_interface new field:
     - on start get the resource table address from TEE remoteproc instead
       of finding it in firmware (ops choice to confirm)
     - on stop unmap the resource table before updating the
       proc->table_ptr pointer.

2) retrieve the TEE rproc Identifier from the device tree instead of
   hardcoding it
 -->  Add a new "st,proc-id" property in device tree.

More details on updates are listed in commits messages

[1] https://lore.kernel.org/linux-arm-kernel/20240115135249.296822-1-arnaud.p=
ouliquen(a)foss.st.com/T/#m9ebb2e8f6d5e90f055827e4f227ce0877bc6d761

base-commit: c8d8f841e95bcc07ac8c5621fc171a24f1fd5cdb

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
  remoteproc: Add TEE support
  dt-bindings: remoteproc: Add compatibility for TEE support
  dt-bindings: remoteproc: Add processor identifier property
  remoteproc: core introduce rproc_set_rsc_table_on_start function
  remoteproc: core: support of the tee interface
  remoteproc: stm32: Create sub-functions to request shutdown and
    release
  remoteproc: stm32: Add support of an OP-TEE TA to load the firmware

 .../bindings/remoteproc/st,stm32-rproc.yaml   |  58 ++-
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_core.c          | 135 +++---
 drivers/remoteproc/stm32_rproc.c              | 149 ++++--
 drivers/remoteproc/tee_remoteproc.c           | 429 ++++++++++++++++++
 include/linux/remoteproc.h                    |   4 +
 include/linux/tee_remoteproc.h                |  99 ++++
 8 files changed, 784 insertions(+), 101 deletions(-)
 create mode 100644 drivers/remoteproc/tee_remoteproc.c
 create mode 100644 include/linux/tee_remoteproc.h

--=20
2.25.1


--===============1583638969851638766==--

