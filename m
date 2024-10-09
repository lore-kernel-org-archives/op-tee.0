From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v11 0/7] Introduction of a remoteproc tee to load signed firmware
Date: Wed, 09 Oct 2024 10:01:01 +0200
Message-ID: <20241009080108.4170320-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6535069377089809688=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6535069377089809688==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



Main updates from version V10[1]:
- remove "select REMOTEPROC_TEE" in STM32_RPROC config to fix kernel robot

To keep history of the updates I have kept in each patches the description
of the updates versus the V9[2] revision.

Main updates from version V9[2]:

- Introduce release_fw remoteproc ops to avoid direct call of
  tee_rproc_release_fw() in remoteproc_core.c:
  - allow to remove link between remoteproc and remoteproc_tee
  - allow to build the remoteproc_tee as a module

[1] https://lore.kernel.org/linux-arm-kernel/ZwVATlRbo0OdRLbj(a)p14s/T/
[2] https://lore.kernel.org/linux-arm-kernel/ZuMIEp4cVrp1hWa7(a)p14s/T/

Tested-on: commit 9852d85ec9d4 ("Linux 6.12-rc1")

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
 drivers/remoteproc/remoteproc_tee.c           | 506 ++++++++++++++++++
 drivers/remoteproc/stm32_rproc.c              | 145 +++--
 include/linux/remoteproc.h                    |   8 +
 include/linux/remoteproc_tee.h                | 107 ++++
 8 files changed, 852 insertions(+), 55 deletions(-)
 create mode 100644 drivers/remoteproc/remoteproc_tee.c
 create mode 100644 include/linux/remoteproc_tee.h


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
--=20
2.25.1


--===============6535069377089809688==--

