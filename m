From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fixes for v5.17
Date: Wed, 26 Jan 2022 11:26:09 +0100
Message-ID: <20220126102609.GA1516258@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8741837631781546253=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8741837631781546253==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these OP-TEE driver fixes all concerning the recent changes
regarding FF-A and asynchronous notifications.

Thanks,
Jens
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fixes-f=
or-v5.17

for you to fetch changes up to 4064c461148ab129dfe5eaeea129b4af6cf4b9b7:

  optee: add error checks in optee_ffa_do_call_with_arg() (2022-01-24 13:00:5=
9 +0100)

----------------------------------------------------------------
OP-TE fixes for v5.17

- Adds error checking in optee_ffa_do_call_with_arg()
- Reintroduces an accidentally lost fix for a memref size check
- Uses bitmap_free() to free memory obtained with bitmap_zalloc()

----------------------------------------------------------------
Christophe JAILLET (1):
      optee: Use bitmap_free() to free bitmap

Jens Wiklander (1):
      optee: add error checks in optee_ffa_do_call_with_arg()

Jerome Forissier (1):
      tee: optee: do not check memref size on return from Secure World

 drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
 drivers/tee/optee/notif.c   |  2 +-
 drivers/tee/optee/smc_abi.c | 10 ----------
 3 files changed, 13 insertions(+), 14 deletions(-)

--===============8741837631781546253==--

