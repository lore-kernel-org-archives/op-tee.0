From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE fix for v6.6
Date: Wed, 13 Sep 2023 10:39:09 +0200
Message-ID: <20230913083909.GA473533@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4777238425548294076=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4777238425548294076==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small fix that removes a few unused function declarations
in the TEE subsystem.

Thanks,
Jens

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-for-=
for-v6.6

for you to fetch changes up to 069969d6c5264d2348fd6cf0cedc00fd87ff3cee:

  tee: Remove unused declarations (2023-09-13 08:16:24 +0200)

----------------------------------------------------------------
Remove a few unused declarations in TEE subsystem

----------------------------------------------------------------
Yue Haibing (1):
      tee: Remove unused declarations

 drivers/tee/optee/optee_private.h | 2 --
 drivers/tee/tee_private.h         | 2 --
 2 files changed, 4 deletions(-)

--===============4777238425548294076==--

