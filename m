From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for v6.11
Date: Thu, 27 Jun 2024 14:51:12 +0200
Message-ID: <20240627125112.GA2674988@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8896993137761464983=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8896993137761464983==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch fixing a few missing-field-initializers warnings
in the optee driver.

Thanks,
Jens

The following changes since commit a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6:

  Linux 6.9 (2024-05-12 14:12:29 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-fix-=
for-v6.11

for you to fetch changes up to e0556255a53d6d3d406a28362dffd972018a997c:

  tee: optee: ffa: Fix missing-field-initializers warning (2024-06-27 10:27:3=
1 +0200)

----------------------------------------------------------------
Fix optee missing-field-initializers warning

----------------------------------------------------------------
Mark-PK Tsai (1):
      tee: optee: ffa: Fix missing-field-initializers warning

 drivers/tee/optee/ffa_abi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--===============8896993137761464983==--

