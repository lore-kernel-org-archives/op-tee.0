From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE driver for Trusted Services
Date: Thu, 25 Apr 2024 09:31:19 +0200
Message-ID: <20240425073119.GA3261080@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6163843440914701255=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6163843440914701255==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these patches that introduces a TEE driver for Trusted
Services. You can see more details below from the signed tag. These
patches have been in for a few weeks.

Thanks,
Jens

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-ts-for=
-v6.10

for you to fetch changes up to 31611cc8faa082a96009c29822d9906d893cce57:

  MAINTAINERS: tee: tstee: Add entry (2024-04-03 14:03:09 +0200)

----------------------------------------------------------------
TEE driver for Trusted Services

This introduces a TEE driver for Trusted Services [1].

Trusted Services is a TrustedFirmware.org project that provides a
framework for developing and deploying device Root of Trust services in
FF-A [2] Secure Partitions. The project hosts the reference
implementation of Arm Platform Security Architecture [3] for Arm
A-profile devices.

The FF-A Secure Partitions are accessible through the FF-A driver in
Linux. However, the FF-A driver doesn't have a user space interface so
user space clients currently cannot access Trusted Services. The goal of
this TEE driver is to bridge this gap and make Trusted Services
functionality accessible from user space.

[1] https://www.trustedfirmware.org/projects/trusted-services/
[2] https://developer.arm.com/documentation/den0077/
[3] https://www.arm.com/architecture/security-features/platform-security

----------------------------------------------------------------
Balint Dobszay (4):
      tee: optee: Move pool_op helper functions
      tee: tstee: Add Trusted Services TEE driver
      Documentation: tee: Add TS-TEE driver
      MAINTAINERS: tee: tstee: Add entry

Sumit Garg (1):
      tee: Refactor TEE subsystem header files

 Documentation/tee/index.rst         |   1 +
 Documentation/tee/ts-tee.rst        |  71 ++++++
 MAINTAINERS                         |  10 +
 drivers/tee/Kconfig                 |   1 +
 drivers/tee/Makefile                |   1 +
 drivers/tee/amdtee/amdtee_private.h |   2 +-
 drivers/tee/amdtee/call.c           |   2 +-
 drivers/tee/amdtee/core.c           |   3 +-
 drivers/tee/amdtee/shm_pool.c       |   2 +-
 drivers/tee/optee/call.c            |   2 +-
 drivers/tee/optee/core.c            |  66 +----
 drivers/tee/optee/device.c          |   2 +-
 drivers/tee/optee/ffa_abi.c         |   8 +-
 drivers/tee/optee/notif.c           |   2 +-
 drivers/tee/optee/optee_private.h   |  14 +-
 drivers/tee/optee/rpc.c             |   2 +-
 drivers/tee/optee/smc_abi.c         |  11 +-
 drivers/tee/tee_core.c              |   2 +-
 drivers/tee/tee_private.h           |  35 ---
 drivers/tee/tee_shm.c               |  67 ++++-
 drivers/tee/tee_shm_pool.c          |   2 +-
 drivers/tee/tstee/Kconfig           |  11 +
 drivers/tee/tstee/Makefile          |   3 +
 drivers/tee/tstee/core.c            | 480 ++++++++++++++++++++++++++++++++++=
++
 drivers/tee/tstee/tstee_private.h   |  92 +++++++
 include/linux/tee_core.h            | 306 +++++++++++++++++++++++
 include/linux/tee_drv.h             | 285 +++------------------
 include/uapi/linux/tee.h            |   1 +
 28 files changed, 1095 insertions(+), 389 deletions(-)
 create mode 100644 Documentation/tee/ts-tee.rst
 create mode 100644 drivers/tee/tstee/Kconfig
 create mode 100644 drivers/tee/tstee/Makefile
 create mode 100644 drivers/tee/tstee/core.c
 create mode 100644 drivers/tee/tstee/tstee_private.h
 create mode 100644 include/linux/tee_core.h

--===============6163843440914701255==--

