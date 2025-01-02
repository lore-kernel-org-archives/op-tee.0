From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for v6.14
Date: Thu, 02 Jan 2025 15:01:02 +0100
Message-ID: <20250102140102.GA3082088@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3743928630474039935=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3743928630474039935==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch fixing a version print in the optee driver.

Thanks,
Jens

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-for-=
v6.14

for you to fetch changes up to 1ff7d092dce0b2273dce4b8d33fa5856679dd25b:

  optee: fix format string for printing optee build_id (2024-12-17 11:22:46 +=
0100)

----------------------------------------------------------------
Fix format string for printing optee build_id

----------------------------------------------------------------
Sahil Malhotra (1):
      optee: fix format string for printing optee build_id

 drivers/tee/optee/smc_abi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--===============3743928630474039935==--

