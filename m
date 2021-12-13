From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE add async notifications for v5.17
Date: Mon, 13 Dec 2021 11:23:59 +0100
Message-ID: <20211213102359.GA1638682@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0410611773931185783=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0410611773931185783==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these patches which adds support for asynchronous notifications
from OP-TEE in secure world to the OP-TEE driver.

An edge-triggered interrupt is used to notify the the driver.

These patches has been in linux-next for a few weeks already.

Thanks,
Jens

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-async=
-notif-for-v5.17

for you to fetch changes up to b98aee466d194788bd651cb375b0e0f7e0e69865:

  optee: Fix NULL but dereferenced coccicheck error (2021-11-29 22:02:25 +010=
0)

----------------------------------------------------------------
OP-TEE Asynchronous notifications from secure world

Adds support in the SMC based OP-TEE driver to receive asynchronous
notifications from secure world using an edge-triggered interrupt as
delivery mechanism.

----------------------------------------------------------------
Jens Wiklander (6):
      docs: staging/tee.rst: add a section on OP-TEE notifications
      dt-bindings: arm: optee: add interrupt property
      tee: fix put order in teedev_close_context()
      tee: export teedev_open() and teedev_close_context()
      optee: separate notification functions
      optee: add asynchronous notifications

Yang Li (1):
      optee: Fix NULL but dereferenced coccicheck error

 .../bindings/arm/firmware/linaro,optee-tz.yaml     |   8 +
 Documentation/staging/tee.rst                      |  30 +++
 drivers/tee/optee/Makefile                         |   1 +
 drivers/tee/optee/core.c                           |   2 +-
 drivers/tee/optee/ffa_abi.c                        |   6 +-
 drivers/tee/optee/notif.c                          | 125 +++++++++++
 drivers/tee/optee/optee_msg.h                      |   9 +
 drivers/tee/optee/optee_private.h                  |  28 ++-
 drivers/tee/optee/optee_rpc_cmd.h                  |  31 +--
 drivers/tee/optee/optee_smc.h                      |  75 ++++++-
 drivers/tee/optee/rpc.c                            |  71 +-----
 drivers/tee/optee/smc_abi.c                        | 237 ++++++++++++++++++-=
--
 drivers/tee/tee_core.c                             |  10 +-
 include/linux/tee_drv.h                            |  14 ++
 14 files changed, 523 insertions(+), 124 deletions(-)
 create mode 100644 drivers/tee/optee/notif.c

--===============0410611773931185783==--

