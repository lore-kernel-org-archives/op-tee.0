From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] tee: shared memory updates for v5.18
Date: Fri, 18 Feb 2022 19:48:02 +0100
Message-ID: <20220218184802.GA968155@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1173615190430335916=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1173615190430335916==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this TEE shared memory cleanup. Some kernel internal APIs are
replaced with easier to use counter parts. The TEE shared memory pool is
also simplified.

Note that this pull request includes two patches which are outside the TEE
subsystem:
- 231b1fc5da09 ("KEYS: trusted: tee: use tee_shm_register_kernel_buf()")
- e7ddab084740 ("hwrng: optee-rng: use tee_shm_alloc_kernel_buf()")
Those patches are reviewed by their maintainer. I've also asked the
maintainers that normally sends patches upstream for these modules if it's
OK that I take these patches via my tree. As I got no answer I assume that
it's OK.

This pull request is on top of the patch, aceeafefff73 ("optee: use driver
internal tee_context for some rpc"), I've already sent (and has since been
merged) for the 5.17 kernel. That's why I'm not including it in the stat.

Thanks,
Jens

The following changes since commit aceeafefff736057e8f93f19bbfbef26abd94604:

  optee: use driver internal tee_context for some rpc (2022-02-03 13:36:32 +0=
100)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-shm-for-=
v5.18

for you to fetch changes up to a45ea4efa358577c623d7353a6ba9af3c17f6ca0:

  tee: refactor TEE_SHM_* flags (2022-02-16 07:49:41 +0100)

----------------------------------------------------------------
TEE shared memory cleanup for v5.18

- The TEE shared memory pool based on two pools is replaced with a single
  somewhat more capable pool.
- Replaces tee_shm_alloc() and tee_shm_register() with new functions
  easier to use and maintain.  The TEE subsystem and the TEE drivers are
  updated to use the new functions instead.
- The TEE based Trusted keys routines are updated to use the new
  simplified functions above.
- The OP-TEE based rng driver is updated to use the new simplified
  functions above.
- The TEE_SHM-flags are refactored to better match their usage

----------------------------------------------------------------
Jens Wiklander (10):
      hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
      tee: remove unused tee_shm_pool_alloc_res_mem()
      tee: add tee_shm_alloc_user_buf()
      tee: simplify shm pool handling
      tee: replace tee_shm_alloc()
      optee: add optee_pool_op_free_helper()
      tee: add tee_shm_register_{user,kernel}_buf()
      KEYS: trusted: tee: use tee_shm_register_kernel_buf()
      tee: replace tee_shm_register()
      tee: refactor TEE_SHM_* flags

 drivers/char/hw_random/optee-rng.c       |   6 +-
 drivers/tee/amdtee/shm_pool.c            |  55 ++----
 drivers/tee/optee/Kconfig                |   8 -
 drivers/tee/optee/call.c                 |   2 +-
 drivers/tee/optee/core.c                 |  21 +-
 drivers/tee/optee/device.c               |   5 +-
 drivers/tee/optee/ffa_abi.c              |  63 ++----
 drivers/tee/optee/optee_private.h        |   7 +-
 drivers/tee/optee/smc_abi.c              | 125 ++++--------
 drivers/tee/tee_core.c                   |   5 +-
 drivers/tee/tee_private.h                |  15 +-
 drivers/tee/tee_shm.c                    | 320 ++++++++++++++++++++---------=
--
 drivers/tee/tee_shm_pool.c               | 162 ++++------------
 include/linux/tee_drv.h                  | 138 +++----------
 security/keys/trusted-keys/trusted_tee.c |  23 +--
 15 files changed, 388 insertions(+), 567 deletions(-)

--===============1173615190430335916==--

