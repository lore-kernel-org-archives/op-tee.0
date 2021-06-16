From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Wed, 16 Jun 2021 12:36:42 +0200
Message-ID: <20210616103649.2662395-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7973363058841415042=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7973363058841415042==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This adds support for asynchronous notifications from OP-TEE in secure
world to the OP-TEE driver. This allows a design with a top half and bottom
half type of driver where the top half runs in secure interrupt context and
a notifications tells normal world to schedule a yielding call to do the
bottom half processing.

An interrupt is used to notify the driver that there are asynchronous
notifications pending.

v2:
* Added documentation
* Converted optee bindings to json-schema and added interrupt property
* Configure notification interrupt from DT instead of getting it
  from secure world, suggested by Ard Biesheuvel <ardb@kernel.org>.

Thanks,
Jens

Jens Wiklander (7):
  docs: staging/tee.rst: add a section on OP-TEE notifications
  dt-bindings: arm: Convert optee binding to json-schema
  dt-bindings: arm: optee: add interrupt property
  tee: fix put order in teedev_close_context()
  tee: add tee_dev_open_helper() primitive
  optee: separate notification functions
  optee: add asynchronous notifications

 .../bindings/arm/firmware/linaro,optee-tz.txt |  31 ---
 .../arm/firmware/linaro,optee-tz.yaml         |  57 +++++
 Documentation/staging/tee.rst                 |  27 +++
 drivers/tee/optee/Makefile                    |   1 +
 drivers/tee/optee/call.c                      |  27 +++
 drivers/tee/optee/core.c                      |  87 +++++--
 drivers/tee/optee/notif.c                     | 226 ++++++++++++++++++
 drivers/tee/optee/optee_msg.h                 |   9 +
 drivers/tee/optee/optee_private.h             |  23 +-
 drivers/tee/optee/optee_rpc_cmd.h             |  31 +--
 drivers/tee/optee/optee_smc.h                 |  75 +++++-
 drivers/tee/optee/rpc.c                       |  73 +-----
 drivers/tee/tee_core.c                        |  37 ++-
 include/linux/tee_drv.h                       |  27 +++
 14 files changed, 576 insertions(+), 155 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,opt=
ee-tz.txt
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,opt=
ee-tz.yaml
 create mode 100644 drivers/tee/optee/notif.c

--=20
2.31.1


--===============7973363058841415042==--

