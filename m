From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE cleanup for v6.8
Date: Thu, 14 Dec 2023 14:22:37 +0100
Message-ID: <20231214132237.GA3092763@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8290388665100470932=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8290388665100470932==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these two small patches for the OP-TEE driver that remove a
redundant custom workqueue and add a description of an argument of a
optee_handle_rpc().

Note that this pull request is made on top of optee-supplicant-fix-for-v6.7
7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
which was merged into v6.7-rc5, but in turn was based on top of v6.6. I
did it like this because the Tested-bys where provided in this context.

Thanks,
Jens

The following changes since commit 7269cba53d906cf257c139d3b3a53ad272176bca:

  tee: optee: Fix supplicant based device enumeration (2023-11-03 09:27:20 +0=
100)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-clean=
up-for-v6.8

for you to fetch changes up to b19773a1c6c02f5efc35e9f506aeddd2c7d2ac29:

  optee: add missing description of RPC argument reference (2023-12-11 15:02:=
12 +0100)

----------------------------------------------------------------
OP-TEE cleanup

- Remove a redundant custom workqueue in the OP-TEE driver.
- Fix a missing description of an argument to optee_handle_rpc().

----------------------------------------------------------------
Etienne Carriere (1):
      optee: add missing description of RPC argument reference

Sumit Garg (1):
      tee: optee: Remove redundant custom workqueue

 drivers/tee/optee/core.c          | 13 ++-----------
 drivers/tee/optee/optee_private.h |  2 --
 drivers/tee/optee/smc_abi.c       |  1 +
 3 files changed, 3 insertions(+), 13 deletions(-)

--===============8290388665100470932==--

