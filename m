From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE load for v6.4
Date: Wed, 05 Apr 2023 08:27:01 +0200
Message-ID: <20230405062701.GA3391925@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3249741937415524681=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3249741937415524681==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this patch to enable loading of OP-TEE by the kernel.

This feature is by default disabled and should probably always be so since
it requires a quite specific security model to be secure.

Thanks,
Jens

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-load-=
for-v6.4

for you to fetch changes up to f3040daab8104ac68e2b241bc93288f63b88a3c7:

  tee: optee: Add SMC for loading OP-TEE image (2023-04-03 08:57:49 +0200)

----------------------------------------------------------------
Add SMC for OP-TEE image loading

Adds an SMC call for loading OP-TEE by the kernel.

----------------------------------------------------------------
Jeffrey Kardatzke (1):
      tee: optee: Add SMC for loading OP-TEE image

 Documentation/staging/tee.rst |  53 ++++++++++++++++
 drivers/tee/optee/Kconfig     |  17 ++++++
 drivers/tee/optee/optee_msg.h |  12 ++++
 drivers/tee/optee/optee_smc.h |  24 ++++++++
 drivers/tee/optee/smc_abi.c   | 137 ++++++++++++++++++++++++++++++++++++++++=
++
 5 files changed, 243 insertions(+)

--===============3249741937415524681==--

