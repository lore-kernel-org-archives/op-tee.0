From: Mario Limonciello <mario.limonciello@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/9] Export platform features from ccp driver
Date: Thu, 02 Mar 2023 13:42:23 -0600
Message-ID: <20230302194235.1724-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2421773255537300065=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2421773255537300065==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The i2c-designware-amdpsp driver communicates with a platform
features mailbox provided by the PSP.  The address used for
communication is discovered via a non-architecturally
guaranteed mechanism.

To better scale, export a feature for communication with platform
features directly from the ccp driver.

v1->v2:
 * Pick up tags
 * Fix dependencies
 * Add support for Skyrim (3 new patches in series)

Mario Limonciello (9):
  crypto: ccp: Drop TEE support for IRQ handler
  crypto: ccp: Add a header for multiple drivers to use `__psp_pa`
  crypto: ccp: Move some PSP mailbox bit definitions into common header
  crypto: ccp: Add support for an interface for platform features
  crypto: ccp: Enable platform access interface on client PSP parts
  i2c: designware: Use PCI PSP driver for communication
  crypto: ccp: Add support for ringing a platform doorbell
  i2c: designware: Add doorbell support for Skyrim
  crypto: ccp: Add doorbell register offset

 arch/x86/kvm/svm/sev.c                      |   1 +
 drivers/crypto/ccp/Makefile                 |   3 +-
 drivers/crypto/ccp/platform-access.c        | 216 ++++++++++++++++++++
 drivers/crypto/ccp/platform-access.h        |  34 +++
 drivers/crypto/ccp/psp-dev.c                |  32 +--
 drivers/crypto/ccp/psp-dev.h                |  11 +-
 drivers/crypto/ccp/sev-dev.c                |  16 +-
 drivers/crypto/ccp/sev-dev.h                |   2 +-
 drivers/crypto/ccp/sp-dev.h                 |   8 +
 drivers/crypto/ccp/sp-pci.c                 |   8 +
 drivers/crypto/ccp/tee-dev.c                |  17 +-
 drivers/i2c/busses/Kconfig                  |   2 +-
 drivers/i2c/busses/i2c-designware-amdpsp.c  | 179 +++-------------
 drivers/i2c/busses/i2c-designware-core.h    |   1 -
 drivers/i2c/busses/i2c-designware-platdrv.c |   2 +-
 drivers/tee/amdtee/call.c                   |   2 +-
 drivers/tee/amdtee/shm_pool.c               |   2 +-
 include/linux/psp-platform-access.h         |  65 ++++++
 include/linux/psp-sev.h                     |   8 -
 include/linux/psp.h                         |  29 +++
 20 files changed, 432 insertions(+), 206 deletions(-)
 create mode 100644 drivers/crypto/ccp/platform-access.c
 create mode 100644 drivers/crypto/ccp/platform-access.h
 create mode 100644 include/linux/psp-platform-access.h
 create mode 100644 include/linux/psp.h

-- 
2.34.1


--===============2421773255537300065==--

