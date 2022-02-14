From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE another fix for v5.17
Date: Mon, 14 Feb 2022 13:59:31 +0100
Message-ID: <20220214125931.GA1332792@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7226199779529029735=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7226199779529029735==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix taking care of a broken return
code in the error path of the two probe functions in the OP-TEE driver.

Please note that this pull request is on top of the previously just merged
patch which introduced the problem fixed here.

Thanks,
Jens

The following changes since commit aceeafefff736057e8f93f19bbfbef26abd94604:

  optee: use driver internal tee_context for some rpc (2022-02-03 13:36:32 +0=
100)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix2-fo=
r-v5.17

for you to fetch changes up to 40eb0dcf4114cbfff4d207890fa5a19e82da9fdc:

  tee: optee: fix error return code in probe function (2022-02-14 12:36:48 +0=
100)

----------------------------------------------------------------
OP-TEE fix error return code in probe functions

----------------------------------------------------------------
Yang Yingliang (1):
      tee: optee: fix error return code in probe function

 drivers/tee/optee/ffa_abi.c | 4 +++-
 drivers/tee/optee/smc_abi.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--===============7226199779529029735==--

