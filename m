From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE kexec fixes for v5.14
Date: Mon, 26 Jul 2021 10:10:39 +0200
Message-ID: <20210726081039.GA2482361@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6232955759779363743=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6232955759779363743==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these fixes relating to OP-TEE, ftpm (firmware TPM), and
tee_bnxt_fw (Broadcom BNXT firmware manager) drivers in kexec and kdump
(emergency kexec) based workflows.

The two patches "firmware: tee_bnxt: Release TEE shm, session, and context
during kexec" and "tpm_ftpm_tee: Free and unregister TEE shared memory
during kexec" are acked by their respective maintainers.

For more details please see the description of the last patch set
https://lore.kernel.org/lkml/20210614223317.999867-1-tyhicks(a)linux.microsof=
t.com/

Thanks,
Jens

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-kexec-fi=
xes-for-v5.14

for you to fetch changes up to 914ab19e471d8fb535ed50dff108b0a615f3c2d8:

  firmware: tee_bnxt: Release TEE shm, session, and context during kexec (202=
1-07-21 07:55:50 +0200)

----------------------------------------------------------------
tee: Improve support for kexec and kdump

This fixes several bugs uncovered while exercising the OP-TEE, ftpm
(firmware TPM), and tee_bnxt_fw (Broadcom BNXT firmware manager) drivers
with kexec and kdump (emergency kexec) based workflows.

----------------------------------------------------------------
Allen Pais (2):
      optee: fix tee out of memory failure seen during kexec reboot
      firmware: tee_bnxt: Release TEE shm, session, and context during kexec

Jens Wiklander (1):
      tee: add tee_shm_alloc_kernel_buf()

Sumit Garg (1):
      tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag

Tyler Hicks (4):
      optee: Fix memory leak when failing to register shm pages
      optee: Refuse to load the driver under the kdump kernel
      optee: Clear stale cache entries during initialization
      tpm_ftpm_tee: Free and unregister TEE shared memory during kexec

 drivers/char/tpm/tpm_ftpm_tee.c         |  8 +++---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 14 ++++++++---
 drivers/tee/optee/call.c                | 38 ++++++++++++++++++++++++++---
 drivers/tee/optee/core.c                | 43 +++++++++++++++++++++++++++++++=
+-
 drivers/tee/optee/optee_private.h       |  1 +
 drivers/tee/optee/rpc.c                 |  5 ++--
 drivers/tee/optee/shm_pool.c            | 20 ++++++++++++---
 drivers/tee/tee_shm.c                   | 20 ++++++++++++++-
 include/linux/tee_drv.h                 |  2 ++
 9 files changed, 132 insertions(+), 19 deletions(-)

--===============6232955759779363743==--

