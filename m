From: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 1/7] firmware: smccc: Add macros for Trusted OS/App owner
 check on SMC value
Date: Tue, 01 Apr 2025 22:35:21 +0530
Message-ID: <20250401170527.344092-2-yuvraj.kernel@gmail.com>
In-Reply-To: <20250401170527.344092-1-yuvraj.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4923718650804005558=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4923718650804005558==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This patch adds ARM_SMCCC_IS_OWNER_TRUSTED_APP() and ARM_SMCCC_IS_OWNER_TRUST=
ED_OS()
macros. These can be used to identify if the SMC is targetted at a Trusted OS=
/App in
the secure world.

Signed-off-by: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
---
 include/linux/arm-smccc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index f19be5754090..da2b4565d5b3 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -56,6 +56,14 @@
 #define ARM_SMCCC_OWNER_TRUSTED_OS	50
 #define ARM_SMCCC_OWNER_TRUSTED_OS_END	63
=20
+#define ARM_SMCCC_IS_OWNER_TRUSTED_APP(smc_val) \
+		((ARM_SMCCC_OWNER_NUM(smc_val) >=3D ARM_SMCCC_OWNER_TRUSTED_APP) && \
+			(ARM_SMCCC_OWNER_NUM(smc_val) <=3D ARM_SMCCC_OWNER_TRUSTED_APP_END))
+
+#define ARM_SMCCC_IS_OWNER_TRUSTED_OS(smc_val)  \
+		((ARM_SMCCC_OWNER_NUM(smc_val) >=3D ARM_SMCCC_OWNER_TRUSTED_OS) && \
+			(ARM_SMCCC_OWNER_NUM(smc_val) <=3D ARM_SMCCC_OWNER_TRUSTED_OS_END))
+
 #define ARM_SMCCC_FUNC_QUERY_CALL_UID  0xff01
=20
 #define ARM_SMCCC_QUIRK_NONE		0
--=20
2.43.0


--===============4923718650804005558==--

