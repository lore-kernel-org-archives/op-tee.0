From: Chen Ni <nichen@iscas.ac.cn>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: smc: remove unnecessary NULL check before
 release_firmware()
Date: Thu, 10 Apr 2025 15:56:35 +0800
Message-ID: <20250410075635.3558712-1-nichen@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2552480317963302597=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2552480317963302597==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

release_firmware() checks for NULL pointers internally.
Remove unneeded NULL check for fmw here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/tee/optee/smc_abi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index f0c3ac1103bb..26f8f7bbbe56 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1551,8 +1551,7 @@ static int optee_load_fw(struct platform_device *pdev,
 		  data_pa_high, data_pa_low, 0, 0, 0, &res);
 	if (!rc)
 		rc = res.a0;
-	if (fw)
-		release_firmware(fw);
+	release_firmware(fw);
 	kfree(data_buf);
 
 	if (!rc) {
-- 
2.25.1


--===============2552480317963302597==--

