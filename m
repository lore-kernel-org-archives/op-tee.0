From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] optee i2c for v5.10
Date: Fri, 21 Aug 2020 12:05:32 +0200
Message-ID: <20200821100532.GA1868056@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2444166625970669359=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2444166625970669359==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this patch enabling i2c access from secure world via a
trampoline in the OP-TEE driver.

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-i2c-for=
-v5.10

for you to fetch changes up to c05210ab975771e161427eb47696b869d820bdaf:

  drivers: optee: allow op-tee to access devices on the i2c bus (2020-08-21 1=
1:41:45 +0200)

----------------------------------------------------------------
Enable i2c device access from OP-TEE RPC

Extends the OP-TEE RPC protocol to enable I2C device access. This allows
a driver in secure world to access devices on a normal world I2C bus.

----------------------------------------------------------------
Jorge Ramirez-Ortiz (1):
      drivers: optee: allow op-tee to access devices on the i2c bus

 drivers/tee/optee/optee_msg.h     | 21 +++++++++
 drivers/tee/optee/optee_private.h |  1 +
 drivers/tee/optee/rpc.c           | 95 +++++++++++++++++++++++++++++++++++++=
++
 3 files changed, 117 insertions(+)

--===============2444166625970669359==--

