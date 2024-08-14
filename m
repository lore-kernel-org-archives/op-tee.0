From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/7] firmware: arm_ffa: FF-A basic v1.2 support
Date: Wed, 14 Aug 2024 14:48:49 +0100
Message-ID: <20240814-ffa_v1-2-v1-0-9e9abef69b21@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5796958966348573107=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5796958966348573107==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This series add basic support for FF-A v1.2.
It mainly includes support for newly added:
1. FFA_MSG_SEND_DIRECT_{REQ,RESP}2
2. FFA_PARTITION_INFO_GET_REGS
3. FFA_YIELD support in direct messaging

Apart from these, the changes include support to fetch the Rx/Tx buffer
size using FFA_FEATURES, addition of the FF-A FIDs for v1.2 and some
coding style cleanups.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Sudeep Holla (7):
      firmware: arm_ffa: Some coding style fixes
      firmware: arm_ffa: Update the FF-A command list with v1.2 additions
      firmware: arm_ffa: Move the function ffa_features() earlier
      firmware: arm_ffa: Add support for FFA_PARTITION_INFO_GET_REGS
      firmware: arm_ffa: Add support for FFA_MSG_SEND_DIRECT_{REQ,RESP}2
      firmware: arm_ffa: Add support for FFA_YIELD in direct messaging
      firmware: arm_ffa: Fetch the Rx/Tx buffer size using ffa_features()

 drivers/firmware/arm_ffa/driver.c | 240 +++++++++++++++++++++++++++++-------=
--
 include/linux/arm_ffa.h           |  12 ++
 2 files changed, 195 insertions(+), 57 deletions(-)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240814-ffa_v1-2-6c33798743f3

Best regards,
--=20
Regards,
Sudeep


--===============5796958966348573107==--

