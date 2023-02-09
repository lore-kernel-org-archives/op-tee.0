From: Mario Limonciello <mario.limonciello@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/6] Export platform features from ccp driver
Date: Thu, 09 Feb 2023 16:38:02 -0600
Message-ID: <20230209223811.4993-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3710489422023726208=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3710489422023726208==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The i2c-designware-amdpsp driver communicates with a platform
features mailbox provided by the PSP.  The address used for
communication is discovered via a non-architecturally
guaranteed mechanism.

To better scale, export a feature for communication with platform
features directly from the ccp driver.

Mario Limonciello (6):
  crypto: ccp: Drop TEE support for IRQ handler
  crypto: ccp: Add a header for multiple drivers to use `__psp_pa`
  crypto: ccp: Move some PSP mailbox bit definitions into common header
  crypto: ccp: Add support for an interface for platform features
  crypto: ccp: Enable platform access interface on client PSP parts
  i2c: designware: Use PCI PSP driver for communication

 arch/x86/kvm/svm/sev.c                      |   1 +
 drivers/crypto/ccp/Makefile                 |   3 +-
 drivers/crypto/ccp/platform-access.c        | 166 ++++++++++++++++++++
 drivers/crypto/ccp/platform-access.h        |  34 ++++
 drivers/crypto/ccp/psp-dev.c                |  32 ++--
 drivers/crypto/ccp/psp-dev.h                |  11 +-
 drivers/crypto/ccp/sev-dev.c                |  16 +-
 drivers/crypto/ccp/sev-dev.h                |   2 +-
 drivers/crypto/ccp/sp-dev.h                 |   7 +
 drivers/crypto/ccp/sp-pci.c                 |   7 +
 drivers/crypto/ccp/tee-dev.c                |  17 +-
 drivers/i2c/busses/Kconfig                  |   2 +-
 drivers/i2c/busses/i2c-designware-amdpsp.c  | 149 +-----------------
 drivers/i2c/busses/i2c-designware-core.h    |   1 -
 drivers/i2c/busses/i2c-designware-platdrv.c |   1 -
 drivers/tee/amdtee/call.c                   |   2 +-
 drivers/tee/amdtee/shm_pool.c               |   2 +-
 include/linux/psp-platform-access.h         |  50 ++++++
 include/linux/psp-sev.h                     |   8 -
 include/linux/psp.h                         |  26 +++
 20 files changed, 340 insertions(+), 197 deletions(-)
 create mode 100644 drivers/crypto/ccp/platform-access.c
 create mode 100644 drivers/crypto/ccp/platform-access.h
 create mode 100644 include/linux/psp-platform-access.h
 create mode 100644 include/linux/psp.h


base-commit: c7410b425de40e9b163eef781e1bdacf1bf2962e
-- 
2.34.1


--===============3710489422023726208==--

