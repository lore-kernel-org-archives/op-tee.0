From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 0/4] TEE driver for Trusted Services
Date: Tue, 05 Mar 2024 11:17:41 +0100
Message-ID: <20240305101745.213933-1-balint.dobszay@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8687724983185667778=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8687724983185667778==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This series introduces a TEE driver for Trusted Services [1].

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

Changelog:
v2[6] -> v3:
  - Add patch "tee: Refactor TEE subsystem header files" from Sumit
  - Remove unnecessary includes from core.c
  - Remove the mutex from "struct ts_context_data" since the same
    mechanism could be implemented by reusing the XArray's internal lock
  - Rename tee_shm_pool_op_*_helper functions as suggested by Sumit
  - Replace pr_* with dev_* as previously suggested by Krzysztof

v1[5] -> v2:
  - Refactor session handling to use XArray instead of IDR and linked
    list (the linked list was redundant as pointed out by Jens, and IDR
    is now deprecated in favor of XArray)
  - Refactor tstee_probe() to not call tee_device_unregister() before
    calling tee_device_register()
  - Address comments from Krzysztof and Jens
  - Address documentation comments from Randy
  - Use module_ffa_driver() macro instead of separate module init / exit
    functions
  - Reformat max line length 100 -> 80

RFC[4] -> v1:
  - Add patch for moving pool_op helper functions to the TEE subsystem,
    as suggested by Jens
  - Address comments from Sumit, add patch for documentation

[1] https://www.trustedfirmware.org/projects/trusted-services/
[2] https://developer.arm.com/documentation/den0077/
[3] https://www.arm.com/architecture/security-features/platform-security
[4] https://lore.kernel.org/linux-arm-kernel/20230927152145.111777-1-balint.d=
obszay(a)arm.com/
[5] https://lore.kernel.org/lkml/20240213145239.379875-1-balint.dobszay(a)arm=
.com/
[6] https://lore.kernel.org/lkml/20240223095133.109046-1-balint.dobszay(a)arm=
.com/


Balint Dobszay (3):
  tee: optee: Move pool_op helper functions
  tee: tstee: Add Trusted Services TEE driver
  Documentation: tee: Add TS-TEE driver

Sumit Garg (1):
  tee: Refactor TEE subsystem header files

 Documentation/tee/index.rst         |   1 +
 Documentation/tee/ts-tee.rst        |  71 ++++
 MAINTAINERS                         |   1 +
 drivers/tee/Kconfig                 |   1 +
 drivers/tee/Makefile                |   1 +
 drivers/tee/amdtee/amdtee_private.h |   2 +-
 drivers/tee/amdtee/call.c           |   2 +-
 drivers/tee/amdtee/core.c           |   3 +-
 drivers/tee/amdtee/shm_pool.c       |   2 +-
 drivers/tee/optee/call.c            |   2 +-
 drivers/tee/optee/core.c            |  66 +---
 drivers/tee/optee/device.c          |   2 +-
 drivers/tee/optee/ffa_abi.c         |   8 +-
 drivers/tee/optee/notif.c           |   2 +-
 drivers/tee/optee/optee_private.h   |  14 +-
 drivers/tee/optee/rpc.c             |   2 +-
 drivers/tee/optee/smc_abi.c         |  11 +-
 drivers/tee/tee_core.c              |   2 +-
 drivers/tee/tee_private.h           |  35 --
 drivers/tee/tee_shm.c               |  66 +++-
 drivers/tee/tee_shm_pool.c          |   2 +-
 drivers/tee/tstee/Kconfig           |  11 +
 drivers/tee/tstee/Makefile          |   3 +
 drivers/tee/tstee/core.c            | 482 ++++++++++++++++++++++++++++
 drivers/tee/tstee/tstee_private.h   |  92 ++++++
 include/linux/tee_core.h            | 306 ++++++++++++++++++
 include/linux/tee_drv.h             | 285 ++--------------
 include/uapi/linux/tee.h            |   1 +
 28 files changed, 1087 insertions(+), 389 deletions(-)
 create mode 100644 Documentation/tee/ts-tee.rst
 create mode 100644 drivers/tee/tstee/Kconfig
 create mode 100644 drivers/tee/tstee/Makefile
 create mode 100644 drivers/tee/tstee/core.c
 create mode 100644 drivers/tee/tstee/tstee_private.h
 create mode 100644 include/linux/tee_core.h

--=20
2.34.1


--===============8687724983185667778==--

