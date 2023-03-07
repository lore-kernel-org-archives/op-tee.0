From: Neal Frager <neal.frager@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v1 1/1] core: drivers: zynqmp_csu_puf.c: increase regen time to 6ms
Date: Tue, 07 Mar 2023 07:41:54 +0000
Message-ID: <20230307074154.39115-1-neal.frager@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2934252445310872293=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2934252445310872293==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

With further evaluation of the ZU+ PUF, we have determined that it is
possible for the PUF regeneration time to exceed 3ms.  For this reason,
the 2023.1 version of the Xilinx xilskey library will bump the wait time
for PUF regeneration to 6ms.  This patch brings optee in line with this
change.

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 core/drivers/zynqmp_csu_puf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/core/drivers/zynqmp_csu_puf.c b/core/drivers/zynqmp_csu_puf.c
index f51443b9..1f8dc4f0 100644
--- a/core/drivers/zynqmp_csu_puf.c
+++ b/core/drivers/zynqmp_csu_puf.c
@@ -24,7 +24,7 @@
 
 #define PUF_CFG0_DEFAULT		0x02
 #define PUF_SHUT_DEFAULT		0x01000100
-#define PUF_REGEN_TIME_MS		3
+#define PUF_REGEN_TIME_MS		6
 
 TEE_Result zynqmp_csu_puf_regenerate(void)
 {
-- 
2.17.1


--===============2934252445310872293==--

