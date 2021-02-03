From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE housekeeping for v5.12
Date: Wed, 03 Feb 2021 13:07:42 +0100
Message-ID: <20210203120742.GA3624453@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2208113871438699299=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2208113871438699299==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these patches fixing some comment typos and also a larger
patch syncing some internal OP-TEE driver headers with OP-TEE OS.

Thanks,
Jens

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-housekee=
ping-for-v5.12

for you to fetch changes up to 617d8e8b347edcee6da38df0aeb671fc9c9ba19c:

  optee: sync OP-TEE headers (2021-02-02 14:50:41 +0100)

----------------------------------------------------------------
TEE subsystem housekeeping

- Fixes some comment typos in header files
- Updates to use flexible-array member instead of zero-length array
- Syncs internal OP-TEE headers with the ones from OP-TEE OS

----------------------------------------------------------------
Bjorn Helgaas (1):
      tee: optee: fix 'physical' typos

Elvira Khabirova (1):
      tee: fix some comment typos in header files

Jens Wiklander (1):
      optee: sync OP-TEE headers

Tian Tao (1):
      drivers: optee: use flexible-array member instead of zero-length array

 drivers/tee/optee/optee_msg.h     | 158 +++---------------------------------=
--
 drivers/tee/optee/optee_rpc_cmd.h | 103 +++++++++++++++++++++++++
 drivers/tee/optee/optee_smc.h     |  72 +++++++++++------
 drivers/tee/optee/rpc.c           |  39 +++++-----
 include/linux/tee_drv.h           |   2 +-
 include/uapi/linux/tee.h          |   2 +-
 6 files changed, 183 insertions(+), 193 deletions(-)
 create mode 100644 drivers/tee/optee/optee_rpc_cmd.h

--===============2208113871438699299==--

