From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for v5.17
Date: Thu, 03 Feb 2022 14:23:23 +0100
Message-ID: <20220203132323.GA4132001@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3732275921385048576=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3732275921385048576==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this OP-TEE driver fix which decouples driver private shared
memory objects from the original tee_context. This fixes the root cause of
a shutdown problem where the driver would dead-lock waiting for tee-supplican=
t.

Thanks,
Jens

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for=
-v5.17

for you to fetch changes up to aceeafefff736057e8f93f19bbfbef26abd94604:

  optee: use driver internal tee_context for some rpc (2022-02-03 13:36:32 +0=
100)

----------------------------------------------------------------
OP-TEE fix shutdown problems

----------------------------------------------------------------
Jens Wiklander (1):
      optee: use driver internal tee_context for some rpc

 drivers/tee/optee/core.c          |  1 +
 drivers/tee/optee/ffa_abi.c       | 77 ++++++++++++++++++++++---------------=
--
 drivers/tee/optee/optee_private.h |  5 ++-
 drivers/tee/optee/smc_abi.c       | 48 +++++++++---------------
 4 files changed, 64 insertions(+), 67 deletions(-)

--===============3732275921385048576==--

