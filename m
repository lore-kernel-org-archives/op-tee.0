From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
Date: Mon, 07 Aug 2023 11:53:37 +0900
Message-ID: <20230807025343.1939-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3429023131565195580=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3429023131565195580==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This series introduces the tee based EFI Runtime Variable Service.

The eMMC device is typically owned by the non-secure world(linux in
this case). There is an existing solution utilizing eMMC RPMB partition
for EFI Variables, it is implemented by interacting with
OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
and tee-supplicant. The last piece is the tee-based variable access
driver to interact with OP-TEE and StandaloneMM.

Changelog:
v7 -> v8
Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
- fix typos
- refactor error handling, direct return if applicable
- use devm_add_action_or_reset() for closing of tee context/session
- remove obvious comment

v6 -> v7
Patch #1-#4 are not updated.
Patch #5 is added into this series, original patch is here:
https://lore.kernel.org/all/20230609094532.562934-1-ilias.apalodimas(a)linaro=
.org/

There are two issues in the v6 series and v7 series addresses those.

1) efivar ops is not restored when the tee-supplicant daemon terminates.
 -> As the following patch says, user must remove the device before
    terminating tee-supplicant daemon.
    https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg(a)linaro.o=
rg/

2) cause panic when someone remounts the efivarfs as RW even if
SetVariable is not supported
 -> The fifth patch addresses this issue.
   "[PATCH v7 5/5] efivarfs: force RO when remounting if SetVariable is
    not supported"

v5 -> v6
- new patch #4 is added in this series, #1-#3 patches are unchanged.
  automatically update super block flag when the efivarops support
  SetVariable runtime service, so that user does not need to manually
  remount the efivarfs as RW.

v4 -> v5
- rebase to efi-next based on v6.4-rc1
- set generic_ops.query_variable_info, it works as expected as follows.
$ df -h /sys/firmware/efi/efivars/
Filesystem      Size  Used Avail Use% Mounted on
efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars

v3 -> v4:
- replace the reference from EDK2 to PI Specification
- remove EDK2 source code reference comments
- prepare nonblocking variant of set_variable, it just returns
  EFI_UNSUPPORTED
- remove redundant buffer size check
- argument name change in mm_communicate
- function interface changes in setup_mm_hdr to remove (void **) cast

v2 -> v3:
- add CONFIG_EFI dependency to TEE_STMM_EFI
- add missing return code check for tee_client_invoke_func()
- directly call efivars_register/unregister from tee_stmm_efi.c

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
- remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
error message



Ilias Apalodimas (1):
  efivarfs: force RO when remounting if SetVariable is not supported

Masahisa Kojima (4):
  efi: expose efivar generic ops register function
  efi: Add EFI_ACCESS_DENIED status code
  efi: Add tee-based EFI variable driver
  efivarfs: automatically update super block flag

 drivers/firmware/efi/Kconfig                 |  15 +
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |  18 +
 drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 612 +++++++++++++++++++
 drivers/firmware/efi/vars.c                  |   8 +
 fs/efivarfs/super.c                          |  45 ++
 include/linux/efi.h                          |  12 +
 8 files changed, 947 insertions(+)
 create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
 create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c


base-commit: f6e6e95ce16205025b7b8680a66c30a0c4ec2270
--=20
2.30.2


--===============3429023131565195580==--

