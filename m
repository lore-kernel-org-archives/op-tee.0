From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for v5.16
Date: Wed, 17 Nov 2021 13:57:47 +0100
Message-ID: <20211117125747.GA2896197@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2975524501900618857=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2975524501900618857==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix to avoid a possible NULL pointer
dereference in the error handling path of a probe function.

Thanks,
Jens

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for=
-v5.16

for you to fetch changes up to c23ca66a4dadb6f050dc57358bc8d57a747c35bf:

  optee: fix kfree NULL pointer (2021-11-16 14:41:23 +0100)

----------------------------------------------------------------
Fix possible NULL pointer dereference in OP-TEE driver

----------------------------------------------------------------
Lv Ruyi (1):
      optee: fix kfree NULL pointer

 drivers/tee/optee/ffa_abi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--===============2975524501900618857==--

