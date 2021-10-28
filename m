From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE FF-A fix for V5.16
Date: Thu, 28 Oct 2021 20:51:42 +0200
Message-ID: <20211028185142.GA2489375@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2417497892119521075=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2417497892119521075==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix which takes care of a couple of
spell errors in a few log messages. These log messages was added in the
recently pulled 4615e5a34b95 ("optee: add FF-A support").

Thanks,
Jens

The following changes since commit 4615e5a34b95e0d81467f6d2176f19a5d184cb5d:

  optee: add FF-A support (2021-10-18 11:44:23 +0200)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-ffa-fix=
-for-v5.16

for you to fetch changes up to 1b73a9e4986a4e9065bacf1e5ab2dfda17b54161:

  optee: Fix spelling mistake "reclain" -> "reclaim" (2021-10-28 11:41:39 +02=
00)

----------------------------------------------------------------
Fix spell errors in OP-TEE FF-A driver log messages

----------------------------------------------------------------
Colin Ian King (1):
      optee: Fix spelling mistake "reclain" -> "reclaim"

 drivers/tee/optee/ffa_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--===============2417497892119521075==--

