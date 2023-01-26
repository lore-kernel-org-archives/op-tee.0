From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
Date: Thu, 26 Jan 2023 22:21:17 +0900
Message-ID: <20230126132120.1661-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1080364939850518083=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1080364939850518083==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This RFC series introduces the op-tee based EFI Runtime Variable
Service.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
and tee-supplicant. The last piece is the tee-based variable access
driver to interact with OP-TEE and StandaloneMM.

Masahisa Kojima (2):
  efi: expose efivar generic ops register function
  tee: Add op-tee helper functions for variable access

 drivers/firmware/efi/efi.c           |  12 +
 drivers/tee/optee/Kconfig            |  10 +
 drivers/tee/optee/Makefile           |   1 +
 drivers/tee/optee/mm_communication.h | 249 +++++++++++
 drivers/tee/optee/optee_private.h    |   5 +-
 drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
 drivers/tee/tee_core.c               |  23 ++
 include/linux/efi.h                  |   4 +
 include/linux/tee_drv.h              |  23 ++
 9 files changed, 924 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tee/optee/mm_communication.h
 create mode 100644 drivers/tee/optee/optee_stmm_efi.c

-- 
2.30.2


--===============1080364939850518083==--

