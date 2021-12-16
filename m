From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE and OP-TEE fixes for v5.16
Date: Thu, 16 Dec 2021 16:07:45 +0100
Message-ID: <20211216150745.GA3347954@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7027070921044897547=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7027070921044897547==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these TEE subsystem and OP-TEE driver fixes which by coincident
all are concerning memory shared with secure world.

There's one in particular nasty race fixed when a tee_shm is about to be
teared down.

Thanks,
Jens

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/fixes-for-v=
5.16

for you to fetch changes up to 6add87fdae9bcb1d20b4503df5bd02ce5246cc8b:

  optee: Suppress false positive kmemleak report in optee_handle_rpc() (2021-=
12-16 15:32:48 +0100)

----------------------------------------------------------------
TEE and OP-TEE fixes for v5.16

- Fixes a race when a tee_shm reaches reference count 0 and is about to
  be teared down
- Fixes an incorrect page free bug in an error path of the OP-TEE shared
  memory pool handling
- Suppresses a false positive kmemleak report when allocating driver
  private shared memory buffers for OP-TEE

----------------------------------------------------------------
Jens Wiklander (1):
      tee: handle lookup of shm with reference count 0

Sumit Garg (1):
      tee: optee: Fix incorrect page free bug

Xiaolei Wang (1):
      optee: Suppress false positive kmemleak report in optee_handle_rpc()

 drivers/tee/optee/core.c    |   6 +-
 drivers/tee/optee/smc_abi.c |   2 +
 drivers/tee/tee_shm.c       | 174 +++++++++++++++++-------------------------=
--
 include/linux/tee_drv.h     |   4 +-
 4 files changed, 72 insertions(+), 114 deletions(-)

--===============7027070921044897547==--

