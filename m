From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] Fix FID for FFA_SECONDARY_EP_REGISTER_64
Date: Fri, 24 Sep 2021 17:31:28 +0100
Message-ID: <20210924163128.3363776-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8851563017918625928=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8851563017918625928==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Commit ef30482b4ad6 ("plat-vexpress: FF-A: update secondary core init")
updated secondary core init for the vexpress platform. In the process,
it used FFA_SECONDARY_EP_REGISTER with FID 0xC4000084 based on the ALP0
ABI of the spec and the TF-A upstream implementation at the time with a
note that the function ID needs to updated to the one finalied in the
spec and the TF-A implementation.

Assuming it is all finalised now, let us update the same with correct/
updated FID 0xC4000087.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Olivier Deprez <olivier.deprez@arm.com>
Cc: Balint Dobszay <balint.dobszay@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 core/arch/arm/include/ffa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/core/arch/arm/include/ffa.h b/core/arch/arm/include/ffa.h
index 20a009cacabd..b0d68173bf80 100644
--- a/core/arch/arm/include/ffa.h
+++ b/core/arch/arm/include/ffa.h
@@ -69,7 +69,7 @@
 #define FFA_MEM_RECLAIM			U(0x84000077)
 #define FFA_MEM_FRAG_RX			U(0x8400007A)
 #define FFA_MEM_FRAG_TX			U(0x8400007B)
-#define FFA_SECONDARY_EP_REGISTER_64	U(0xC4000084)
+#define FFA_SECONDARY_EP_REGISTER_64	U(0xC4000087)
 
 /* Special value for traffic targeted to the Hypervisor or SPM */
 #define FFA_TARGET_INFO_MBZ		U(0x0)
-- 
2.25.1


--===============8851563017918625928==--

