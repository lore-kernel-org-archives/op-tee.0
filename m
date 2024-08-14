From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 2/7] firmware: arm_ffa: Update the FF-A command list with v1.2
 additions
Date: Wed, 14 Aug 2024 14:48:51 +0100
Message-ID: <20240814-ffa_v1-2-v1-2-9e9abef69b21@arm.com>
In-Reply-To: <20240814-ffa_v1-2-v1-0-9e9abef69b21@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2292885537095845478=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2292885537095845478==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Arm Firmware Framework for A-profile(FFA) v1.2 introduces register based
discovery mechanism and direct messaging extensions that enables to target
specific UUID within a partition.

Let us add all the newly supported FF-A function IDs in the spec.
Also update to the error values and associated handling.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 1 +
 include/linux/arm_ffa.h           | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index b4b3ecc9824e..be77e03578cc 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -75,6 +75,7 @@ static const int ffa_linux_errmap[] =3D {
 	-EAGAIN,	/* FFA_RET_RETRY */
 	-ECANCELED,	/* FFA_RET_ABORTED */
 	-ENODATA,	/* FFA_RET_NO_DATA */
+	-EAGAIN,	/* FFA_RET_NOT_READY */
 };
=20
 static inline int ffa_to_linux_errno(int errno)
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 89683f31ae12..b34f0c0dc2c5 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -73,6 +73,11 @@
 #define FFA_FN64_MEM_PERM_GET		FFA_SMC_64(0x88)
 #define FFA_MEM_PERM_SET		FFA_SMC_32(0x89)
 #define FFA_FN64_MEM_PERM_SET		FFA_SMC_64(0x89)
+#define FFA_CONSOLE_LOG			FFA_SMC_32(0x8A)
+#define FFA_PARTITION_INFO_GET_REGS	FFA_SMC_64(0x8B)
+#define FFA_EL3_INTR_HANDLE		FFA_SMC_32(0x8C)
+#define FFA_MSG_SEND_DIRECT_REQ2	FFA_SMC_64(0x8D)
+#define FFA_MSG_SEND_DIRECT_RESP2	FFA_SMC_64(0x8E)
=20
 /*
  * For some calls it is necessary to use SMC64 to pass or return 64-bit valu=
es.

--=20
2.46.0


--===============2292885537095845478==--

