From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2] tee: optee: Use kmemdup() to replace kmalloc + memcpy
Date: Tue, 13 Jun 2023 01:19:10 +0000
Message-ID: <20230613011853.6385-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1505095288344850864=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1505095288344850864==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Use kmemdup rather than duplicating its implementation.

./drivers/tee/optee/smc_abi.c:1542:12-19: WARNING opportunity for kmemdup.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5480
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Add one commit message.

 drivers/tee/optee/smc_abi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 3861ae06d902..d5b28fd35d66 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1541,12 +1541,11 @@ static int optee_load_fw(struct platform_device *pdev,
 	 * This uses the GFP_DMA flag to ensure we are allocated memory in the
 	 * 32-bit space since TF-A cannot map memory beyond the 32-bit boundary.
 	 */
-	data_buf = kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
+	data_buf = kmemdup(fw->data, fw->size, GFP_KERNEL | GFP_DMA);
 	if (!data_buf) {
 		rc = -ENOMEM;
 		goto fw_err;
 	}
-	memcpy(data_buf, fw->data, fw->size);
 	data_pa = virt_to_phys(data_buf);
 	reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
 	reg_pair_from_64(&data_size_high, &data_size_low, data_size);
-- 
2.20.1.7.g153144c


--===============1505095288344850864==--

