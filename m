From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE reserved system thread for 6.8
Date: Mon, 11 Dec 2023 11:26:00 +0100
Message-ID: <20231211102600.GA571787@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6360733485577338823=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6360733485577338823==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these patches that enables SCMI with OP-TEE transport to to
reserve a thread in the secure world to guarentee that requests will not
have to wait for a thread to become available.

Thanks,
Jens

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/system-thre=
ad-for-v6.8

for you to fetch changes up to 4b391c9c37646f25118355f414b9e6d9fefe782f:

  firmware: arm_scmi: optee: use optee system invocation (2023-11-17 15:48:03=
 +0100)

----------------------------------------------------------------
OP-TEE add reserved system thread

Add support for a reserved system thread in the SMC-ABI of the OP-TEE driver.
SCMI with OP-TEE transport uses this to guarantee that it will always have
a thread available in the secure world.

----------------------------------------------------------------
Etienne Carriere (4):
      tee: optee: system thread call property
      tee: system session
      tee: optee: support tracking system threads
      firmware: arm_scmi: optee: use optee system invocation

 drivers/firmware/arm_scmi/optee.c |   4 ++
 drivers/tee/optee/call.c          | 130 ++++++++++++++++++++++++++++++++++++=
--
 drivers/tee/optee/core.c          |   5 +-
 drivers/tee/optee/ffa_abi.c       |  14 ++--
 drivers/tee/optee/optee_private.h |  29 ++++++++-
 drivers/tee/optee/smc_abi.c       |  32 +++++++---
 drivers/tee/tee_core.c            |   8 +++
 include/linux/tee_drv.h           |  16 +++++
 8 files changed, 211 insertions(+), 27 deletions(-)

--===============6360733485577338823==--

