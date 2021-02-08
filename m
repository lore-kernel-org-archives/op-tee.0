From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE I2C simplification for v5.12
Date: Mon, 08 Feb 2021 13:58:53 +0100
Message-ID: <20210208125853.GA288348@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6499847669664186846=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6499847669664186846==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this fix eliminating a stack frame size warning and also
simplifying I2C access in the OP-TEE driver.

Thanks,
Jens


The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-simplif=
y-i2c-access_for-v5.12

for you to fetch changes up to 67bc809752796acb2641ca343cad5b45eef31d7c:

  optee: simplify i2c access (2021-02-08 13:42:31 +0100)

----------------------------------------------------------------
Simplify i2c acess in OP-TEE driver

----------------------------------------------------------------
Arnd Bergmann (1):
      optee: simplify i2c access

 drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

--===============6499847669664186846==--

