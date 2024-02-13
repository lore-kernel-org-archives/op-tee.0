From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/3] TEE driver for Trusted Services
Date: Tue, 13 Feb 2024 15:52:36 +0100
Message-ID: <20240213145239.379875-1-balint.dobszay@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6572102400012525202=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6572102400012525202==
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
RFC[4] -> v1:
  - Add patch for moving pool_op helper functions to the TEE subsystem,
    as suggested by Jens
  - Address comments from Sumit, add patch for documentation

[1] https://www.trustedfirmware.org/projects/trusted-services/
[2] https://developer.arm.com/documentation/den0077/
[3] https://www.arm.com/architecture/security-features/platform-security
[4] https://lore.kernel.org/linux-arm-kernel/20230927152145.111777-1-balint.d=
obszay(a)arm.com/


Balint Dobszay (3):
  tee: optee: Move pool_op helper functions
  tee: tstee: Add Trusted Services TEE driver
  Documentation: tee: Add TS-TEE driver

 Documentation/tee/index.rst       |   1 +
 Documentation/tee/ts-tee.rst      |  70 +++++
 drivers/tee/Kconfig               |   1 +
 drivers/tee/Makefile              |   1 +
 drivers/tee/optee/core.c          |  64 ----
 drivers/tee/optee/ffa_abi.c       |   6 +-
 drivers/tee/optee/optee_private.h |  12 -
 drivers/tee/optee/smc_abi.c       |  10 +-
 drivers/tee/tee_shm.c             |  65 ++++
 drivers/tee/tstee/Kconfig         |  11 +
 drivers/tee/tstee/Makefile        |   3 +
 drivers/tee/tstee/core.c          | 501 ++++++++++++++++++++++++++++++
 drivers/tee/tstee/tstee_private.h |  92 ++++++
 include/linux/tee_drv.h           |  11 +
 include/uapi/linux/tee.h          |   1 +
 15 files changed, 765 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/tee/ts-tee.rst
 create mode 100644 drivers/tee/tstee/Kconfig
 create mode 100644 drivers/tee/tstee/Makefile
 create mode 100644 drivers/tee/tstee/core.c
 create mode 100644 drivers/tee/tstee/tstee_private.h

--=20
2.34.1


--===============6572102400012525202==--

