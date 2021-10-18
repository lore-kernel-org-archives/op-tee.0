From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE FF-A for V5.16
Date: Mon, 18 Oct 2021 14:13:24 +0200
Message-ID: <20211018121324.GA2943530@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6301408831732505042=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6301408831732505042==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these patches which adds support for FF-A [1] in the OP-TEE
driver. There's a bit of shuffling in the code where everyhting related to
the old SMC based ABI is moved to drivers/tee/optee/smc_abi.c, but there
should not be any changed in behavior for with the old ABI.

Note that this is based on top of the recent fix 7f565d0ead26 ("tee: optee:
Fix missing devices unregister during optee_remove") which has already been
requested to be pulled.

Thanks,
Jens

The following changes since commit 7f565d0ead264329749c0da488de9c8dfa2f18ce:

  tee: optee: Fix missing devices unregister during optee_remove (2021-10-12 =
13:24:39 +0200)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-ffa-for=
-v5.16

for you to fetch changes up to 4615e5a34b95e0d81467f6d2176f19a5d184cb5d:

  optee: add FF-A support (2021-10-18 11:44:23 +0200)

----------------------------------------------------------------
Add FF-A support in OP-TEE driver

Adds supports for the OP-TEE driver to communicate with secure world
using FF-A [1] as transport.

[1] https://developer.arm.com/documentation/den0077/latest

----------------------------------------------------------------
Jens Wiklander (5):
      tee: add sec_world_id to struct tee_shm
      optee: simplify optee_release()
      optee: refactor driver with internal callbacks
      optee: isolate smc abi
      optee: add FF-A support

 drivers/tee/optee/Makefile        |    5 +-
 drivers/tee/optee/call.c          |  445 ++----------
 drivers/tee/optee/core.c          |  719 ++------------------
 drivers/tee/optee/ffa_abi.c       |  911 +++++++++++++++++++++++++
 drivers/tee/optee/optee_ffa.h     |  153 +++++
 drivers/tee/optee/optee_msg.h     |   27 +-
 drivers/tee/optee/optee_private.h |  157 ++++-
 drivers/tee/optee/rpc.c           |  237 +------
 drivers/tee/optee/shm_pool.c      |  101 ---
 drivers/tee/optee/shm_pool.h      |   14 -
 drivers/tee/optee/smc_abi.c       | 1361 +++++++++++++++++++++++++++++++++++=
++
 include/linux/tee_drv.h           |    7 +-
 12 files changed, 2728 insertions(+), 1409 deletions(-)
 create mode 100644 drivers/tee/optee/ffa_abi.c
 create mode 100644 drivers/tee/optee/optee_ffa.h
 delete mode 100644 drivers/tee/optee/shm_pool.c
 delete mode 100644 drivers/tee/optee/shm_pool.h
 create mode 100644 drivers/tee/optee/smc_abi.c

--===============6301408831732505042==--

