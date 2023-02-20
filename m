From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/4] introduce tee-based EFI Runtime Variable Service
Date: Mon, 20 Feb 2023 14:17:18 +0900
Message-ID: <20230220051723.1257-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8233748985911226553=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8233748985911226553==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This series introduces the tee based EFI Runtime Variable Service.

This version moves StMM related code from drivers/tee/optee to
drivers/firmware/efi/stmm, since StMM code does not contain
OP-TEE specific code and can be used with other TEE implementation.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
and tee-supplicant. The last piece is the tee-based variable access
driver to interact with OP-TEE and StandaloneMM.

Changelog:
rfc v1 -> v2:
- split patch into three patches, one for drivers/tee,
  one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
- context/session management into probe() and remove() same as other tee
client driver
- StMM variable driver is moved from driver/tee/optee to driver/firmware/efi
- use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_stmm_ef=
i.c,
  this file does not contain op-tee specific code, abstracted by tee layer and
  StMM variable driver will work on other tee implementation.
- PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
- implement query_variable_store() but currently not used
- no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_private.h.
  Other tee client drivers use 0 instead of using TEEC_SUCCESS
- remove TEEC_ERROR_EXCESS_DATA status, it is refered just to output
error message

Masahisa Kojima (4):
  efi: expose efivar generic ops register function
  efi: Add EFI_ACCESS_DENIED status code
  tee: expose tee efivar register function
  efi: Add tee-based EFI variable driver

 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |  12 +
 drivers/firmware/efi/stmm/mm_communication.h | 249 ++++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 620 +++++++++++++++++++
 drivers/tee/tee_core.c                       |  23 +
 include/linux/efi.h                          |   4 +
 include/linux/tee_drv.h                      |  23 +
 8 files changed, 947 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c

--=20
2.30.2


--===============8233748985911226553==--

