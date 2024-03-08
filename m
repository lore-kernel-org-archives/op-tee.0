From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v4 0/4] Introduction of a remoteproc tee to load signed firmware
Date: Fri, 08 Mar 2024 14:48:29 +0000
Message-ID: <20240308144708.62362-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1288042918336748506=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1288042918336748506==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Main updates from the previous version [1]:

- Remove the alternate boot sequence: rproc_alt_fw_boot()
- Introduce tee_rproc_parse_fw function
	- create a cached table as done inrproc_elf_load_rsc_table[2],
	- PR sent to OP-TEE to allow TA_RPROC_FW_CMD_LOAD_FW service=20
	  re-entrance[3].
- Rework TEE_REMOTEPROC description in Kconfig
- Introduce proc::tee_interface

Patch commit messages list updates with more details

base-commit: 62210f7509e13a2caa7b080722a45229b8f17a0a

[1] https://lore.kernel.org/linux-arm-kernel/Zdjl6Z2ktTwi+oWp(a)p14s/T/#m53f9=
94237dc984c5dbbe3c75d2c30fcfff8548a0
[2] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/remotep=
roc_elf_loader.c#L326
[3] https://github.com/OP-TEE/optee_os/pull/6743


Description of the feature:

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
  dt-bindings: remoteproc: Add compatibility for TEE support
  remoteproc: stm32: Create sub-functions to request shutdown and
    release
  remoteproc: stm32: Add support of an OP-TEE TA to load the firmware

 .../bindings/remoteproc/st,stm32-rproc.yaml   |  51 +-
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/stm32_rproc.c              | 144 ++++--
 drivers/remoteproc/tee_remoteproc.c           | 434 ++++++++++++++++++
 include/linux/remoteproc.h                    |   4 +
 include/linux/tee_remoteproc.h                | 112 +++++
 7 files changed, 711 insertions(+), 45 deletions(-)
 create mode 100644 drivers/remoteproc/tee_remoteproc.c
 create mode 100644 include/linux/tee_remoteproc.h


base-commit: 62210f7509e13a2caa7b080722a45229b8f17a0a
--=20
2.25.1


--===============1288042918336748506==--

