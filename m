From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v7 0/4] tee: introduce TEE system session
Date: Fri, 12 May 2023 07:42:18 +0200
Message-ID: <20230512054222.2088837-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4259422125844345964=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4259422125844345964==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series introduces TEE system sessions for TEE service sessions that
require TEE to provision resources to prevent deadlock when clients call
the TEE.

This deadlock situation can happen when a TEE service is used by low
level system resources as for example when Linux kernel uses SCMI
service embedded in TEE for clock, reset, regulator, etc... controls.
This case is detailled in patch 3/4:

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
 drivers/tee/optee/call.c          | 150 +++++++++++++++++++++++++++---
 drivers/tee/optee/core.c          |   5 +-
 drivers/tee/optee/ffa_abi.c       |  13 +--
 drivers/tee/optee/optee_private.h |  20 +++-
 drivers/tee/optee/smc_abi.c       |  31 ++++--
 drivers/tee/tee_core.c            |   8 ++
 include/linux/tee_drv.h           |  16 ++++
 8 files changed, 211 insertions(+), 36 deletions(-)

---
Changes since v6:
- Added this cover letter missing in previous patch series revisions.

-- 
2.25.1


--===============4259422125844345964==--

