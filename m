From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/4] Asynchronous notifications from secure world
Date: Wed, 09 Jun 2021 08:09:06 +0200
Message-ID: <20210609060910.1500481-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5964132903689672683=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5964132903689672683==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This adds support for asynchronous notifications from OP-TEE in secure
world to the OP-TEE driver. This allows a design with a top half and bottom
half type of driver where the top half runs in secure interrupt context and
a notifications tells normal world to schedule a yielding call to do the
bottom half processing.

An SPI interrupt is used to notify the driver that there are asynchronous
notifications pending.

Thanks,
Jens

Jens Wiklander (4):
  tee: fix put order in teedev_close_context()
  tee: add tee_dev_open_helper() primitive
  optee: separate notification functions
  optee: add asynchronous notifications

 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/call.c          |  27 ++++
 drivers/tee/optee/core.c          | 104 ++++++++++----
 drivers/tee/optee/notif.c         | 226 ++++++++++++++++++++++++++++++
 drivers/tee/optee/optee_msg.h     |   9 ++
 drivers/tee/optee/optee_private.h |  23 +--
 drivers/tee/optee/optee_rpc_cmd.h |  31 ++--
 drivers/tee/optee/optee_smc.h     |  79 ++++++++++-
 drivers/tee/optee/rpc.c           |  73 ++--------
 drivers/tee/tee_core.c            |  37 +++--
 include/linux/tee_drv.h           |  27 ++++
 11 files changed, 512 insertions(+), 125 deletions(-)
 create mode 100644 drivers/tee/optee/notif.c

-- 
2.31.1


--===============5964132903689672683==--

