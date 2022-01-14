From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 00/12] tee: shared memory updates
Date: Fri, 14 Jan 2022 16:08:12 +0100
Message-ID: <20220114150824.3578829-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4681622220346882984=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4681622220346882984==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This patchset is a general cleanup of shared memory handling in the TEE
subsystem.

Until now has the in-kernel tee clients used tee_shm_alloc() and
tee_shm_register() to share memory with secure world. These two function
exposes via a flags parameter a bit more of the internals of the TEE
subsystem than one would like. So in order to make things easier are those
two functions replaced by few functions which should provide better
abstraction.

Two in-kernel tee clients are updated to use these new functions.

The shared memory pool handling is simplified, an internal matter for the
two TEE drivers OP-TEE and AMDTEE.

An OP-TEE driver internal tee_context is added to handle shared memory
allocations received via RPC, for instance the argument structure needed
to make more complex RPC requests. The tee_context used when doing such a
memory allocation must be kept until the memory is freed. With this we can
avoid keeping a tee_context of a client around for longer than necessary.

In the v1 review it was suggested [1] to allow physically non-contiguous
memory allocations by the drivers. It turned out to be harder than
anticipated so I'll save that for a separate patch.

This patchset is also available at [2] and is based on the asynchronous
notification patches [3] which was just merged during this merge window.

Thanks,
Jens

[1] https://lore.kernel.org/linux-arm-kernel/20210609145811.GJ4910(a)sequoia/
[2] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=3Dtee_s=
hm_v2
[3] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=3Dasync=
_notif

v1->v2:
* The commits three "tee: add tee_shm_alloc_kernel_buf()",
  "tpm_ftpm_tee: use tee_shm_alloc_kernel_buf()" and
  "firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()" has been merged some
  time ago as part of another patchset.
* Another in-kernel tee client is updated with the commit
  "KEYS: trusted: tee: use tee_shm_register_kernel_buf()"
* tee_shm_alloc_anon_kernel_buf() is replaced with an easier to use function
  tee_shm_alloc_priv_kernel_buf() and tee_shm_free_anon_kernel_buf() has
  been dropped.
* A driver internal struct tee_context is used to when doing driver internal
  calls to secure world.
* Adds patches to replace tee_shm_register() in a similar way as how
  tee_shm_alloc() is replaced.
* A patch is added to clean up the TEE_SHM_* flags
* Fixed a warning reported by kernel test robot <lkp@intel.com>

Jens Wiklander (12):
  hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
  tee: remove unused tee_shm_pool_alloc_res_mem()
  tee: add tee_shm_alloc_user_buf()
  tee: simplify shm pool handling
  tee: replace tee_shm_alloc()
  optee: add driver private tee_context
  optee: use driver internal tee_contex for some rpc
  optee: add optee_pool_op_free_helper()
  tee: add tee_shm_register_{user,kernel}_buf()
  KEYS: trusted: tee: use tee_shm_register_kernel_buf()
  tee: replace tee_shm_register()
  tee: refactor TEE_SHM_* flags

 drivers/char/hw_random/optee-rng.c       |   6 +-
 drivers/tee/amdtee/shm_pool.c            |  55 ++--
 drivers/tee/optee/Kconfig                |   8 -
 drivers/tee/optee/call.c                 |   2 +-
 drivers/tee/optee/core.c                 |  22 +-
 drivers/tee/optee/device.c               |   5 +-
 drivers/tee/optee/ffa_abi.c              | 136 ++++------
 drivers/tee/optee/optee_private.h        |  12 +-
 drivers/tee/optee/smc_abi.c              | 155 +++--------
 drivers/tee/tee_core.c                   |   5 +-
 drivers/tee/tee_private.h                |  11 -
 drivers/tee/tee_shm.c                    | 322 +++++++++++++++--------
 drivers/tee/tee_shm_pool.c               | 162 +++---------
 include/linux/tee_drv.h                  | 133 +++-------
 security/keys/trusted-keys/trusted_tee.c |  23 +-
 15 files changed, 434 insertions(+), 623 deletions(-)

--=20
2.31.1


--===============4681622220346882984==--

