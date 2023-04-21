From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix uninitialized variable in OP-TEE driver for v6.3
Date: Fri, 21 Apr 2023 09:54:43 +0200
Message-ID: <20230421075443.GA3136581@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6450252033661991541=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6450252033661991541==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch fixing an unintialized variable in the
OP-TEE driver. The error has been reported recently by the kernel test
robot.

I realize that this is late for v6.3, please queue this for v6.4 instead
if v6.3 isn't possible.

Thanks,
Jens

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-async=
-notif-fix-for-v6.3

for you to fetch changes up to 654d0310007146fae87b0c1a68f81e53ad519b14:

  optee: fix uninited async notif value (2023-04-20 14:52:25 +0200)

----------------------------------------------------------------
Fixes an uninitialized variable in OP-TEE driver

----------------------------------------------------------------
Etienne Carriere (1):
      optee: fix uninited async notif value

 drivers/tee/optee/smc_abi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--===============6450252033661991541==--

