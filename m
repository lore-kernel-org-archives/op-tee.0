From: Etienne Carriere <etienne.carriere@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v11 0/4] tee: introduce TEE system sssion
Date: Mon, 16 Oct 2023 11:04:24 +0200
Message-ID: <20231016090428.1369071-1-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6416677980916766801=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6416677980916766801==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series introduces TEE system sessions for TEE service sessions that
require TEE to provision resources to prevent deadlock when clients call
the TEE.

This deadlock situation can happen when a TEE service is used by low
level system resources as for example when Linux kernel uses SCMI
service embedded in TEE for clock, reset, regulator, etc... controls.
This case is detailled in patch 2/4:

> This feature is needed to prevent a system deadlock when several TEE
> client applications invoke TEE, consuming all TEE thread contexts
> available in the secure world. The deadlock can happen in the OP-TEE
> driver for example if all these TEE threads issue an RPC call from TEE
> to Linux OS to access an eMMC RPMB partition (TEE secure storage) which
> device clock or regulator controller is accessed through an OP-TEE SCMI
> services. In that case, Linux SCMI driver must reach OP-TEE SCMI
> service without waiting until one of the consumed TEE threads is freed.

Etienne Carriere (4):
  tee: optee: system call property
  tee: system session
  tee: optee: support tracking system threads
  firmware: arm_scmi: optee: use optee system invocation

 drivers/firmware/arm_scmi/optee.c |   4 +
 drivers/tee/optee/call.c          | 130 ++++++++++++++++++++++++++++--
 drivers/tee/optee/core.c          |   5 +-
 drivers/tee/optee/ffa_abi.c       |  13 +--
 drivers/tee/optee/optee_private.h |  29 ++++++-
 drivers/tee/optee/smc_abi.c       |  31 ++++---
 drivers/tee/tee_core.c            |   8 ++
 include/linux/tee_drv.h           |  16 ++++
 8 files changed, 209 insertions(+), 27 deletions(-)
---
Changes since v11:
- Changes patch 3/4, other are unchanged.
-- 
2.25.1


--===============6416677980916766801==--

