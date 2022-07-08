From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE Fixes for v5.19
Date: Fri, 08 Jul 2022 15:46:07 +0200
Message-ID: <20220708134607.GA901814@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8682417632659470576=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8682417632659470576==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these small fixes in the TEE subssytem. The OP-TEE driver
patch fixes an error which was introduced during the merge window. I'm
not sure if the error really can be triggered, but it would be nice to
have it fixed before the release.

Thanks,
Jens

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-fixes-=
for-v5.19

for you to fetch changes up to e5ce073c8a1e01b215a5eb32ba48f8d17ded3bd5:

  tee: tee_get_drvdata(): fix description of return value (2022-07-08 10:51:2=
4 +0200)

----------------------------------------------------------------
Fixes for TEE subsystem

A fix for the recently merged commit ed8faf6c8f8c ("optee: add
OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG").
Two small fixes in comment, repeated words etc.

----------------------------------------------------------------
Jiang Jian (1):
      optee: Remove duplicate 'of' in two places.

Marc Kleine-Budde (1):
      tee: tee_get_drvdata(): fix description of return value

Yang Yingliang (1):
      optee: smc_abi.c: fix wrong pointer passed to IS_ERR/PTR_ERR()

 drivers/tee/optee/optee_smc.h | 2 +-
 drivers/tee/optee/smc_abi.c   | 4 ++--
 drivers/tee/tee_core.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--===============8682417632659470576==--

