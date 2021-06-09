From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/7] tee: shared memory updates
Date: Wed, 09 Jun 2021 12:23:17 +0200
Message-ID: <20210609102324.2222332-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6510989839156338623=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6510989839156338623==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Until now has the in-kernel tee clients, tpm_ftpm_tee, hwrng: optee-rng and
firmware: tee_bnxt used shared memory objects which has been exported by
dma-buf. Dma-buf isn't needed here since it's only an interaction between
the kernel and secure world.

This patchset fixes this by intruducing three new function
tee_shm_alloc_user_buf(), tee_shm_alloc_kernel_buf() and
tee_shm_alloc_anon_kernel_buf() to be used instead of the old
tee_shm_alloc(). This should make the API a bit easier to use both within
the TEE subsystem and for the tee clients in various drivers.

The patch set starts with simplifying the shared memory pool handling, an
internal matter for the two TEE drivers OP-TEE and AMDTEE.

Thanks,
Jens

Jens Wiklander (7):
  tee: remove unused tee_shm_pool_alloc_res_mem()
  tee: simplify shm pool handling
  tee: add tee_shm_alloc_kernel_buf()
  hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
  tpm_ftpm_tee: use tee_shm_alloc_kernel_buf()
  firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()
  tee: replace tee_shm_alloc()

 drivers/char/hw_random/optee-rng.c      |   6 +-
 drivers/char/tpm/tpm_ftpm_tee.c         |   8 +-
 drivers/firmware/broadcom/tee_bnxt_fw.c |   5 +-
 drivers/tee/amdtee/shm_pool.c           |  55 ++-----
 drivers/tee/optee/Kconfig               |   8 -
 drivers/tee/optee/call.c                |  16 +-
 drivers/tee/optee/core.c                |  76 +--------
 drivers/tee/optee/device.c              |   5 +-
 drivers/tee/optee/rpc.c                 |   8 +-
 drivers/tee/optee/shm_pool.c            |  51 +++---
 drivers/tee/optee/shm_pool.h            |   2 +-
 drivers/tee/tee_core.c                  |   2 +-
 drivers/tee/tee_private.h               |  11 --
 drivers/tee/tee_shm.c                   | 209 ++++++++++++++++++------
 drivers/tee/tee_shm_pool.c              | 160 ++++--------------
 include/linux/tee_drv.h                 | 106 +++---------
 16 files changed, 291 insertions(+), 437 deletions(-)

-- 
2.31.1


--===============6510989839156338623==--

