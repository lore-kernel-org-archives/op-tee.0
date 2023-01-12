From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/3] optee: async notif with PPI + interrupt provider
Date: Thu, 12 Jan 2023 15:54:21 +0100
Message-ID: <20230112145424.3791276-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7055890371131642801=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7055890371131642801==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Dear all,

This small series aggregates 2 change proposals related to OP-TEE async notif.
I've made a single series since the 2 patches hit the same portions of optee
driver source file and I think this will help the review. If you prefer having
independent post and deal with the conflicts afterward, please tell me.

Patch "optee: add per cpu asynchronous notification" aims at allowing optee
to use a per-cpu interrupt (PPI on Arm CPUs) for async notif instead of a
shared peripheral interrupt.

The 2 next patches implement a new feature in OP-TEE, based on optee async
notif. The allow optee driver to behave as an interrupt controller, for
when a secure OP-TEE event is to be delivered to the Linux kernel as a
interrupt event.

Regards,
Etienne

Etienne Carriere (3):
  optee: add per cpu asynchronous notification
  dt-bindings: arm: optee: add interrupt controller properties
  optee core: add irq chip using optee async notification

 .../arm/firmware/linaro,optee-tz.yaml         |  19 +-
 drivers/tee/optee/optee_private.h             |  24 ++
 drivers/tee/optee/optee_smc.h                 |  78 +++++-
 drivers/tee/optee/smc_abi.c                   | 249 +++++++++++++++++-
 4 files changed, 358 insertions(+), 12 deletions(-)

-- 
2.25.1


--===============7055890371131642801==--

