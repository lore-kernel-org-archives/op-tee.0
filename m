From: Yang Li <yang.lee@linux.alibaba.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH -next] optee: Fix NULL but dereferenced coccicheck error
Date: Fri, 19 Nov 2021 16:05:43 +0800
Message-ID: <1637309143-53528-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7484835474507240691=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7484835474507240691==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Eliminate the following coccicheck warning:
./drivers/tee/optee/smc_abi.c:1508:12-15: ERROR: optee is NULL but
dereferenced.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 'commit 6749e69c4dad ("optee: add asynchronous notifications")'
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/tee/optee/smc_abi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 92759d7..1f471ff 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1505,8 +1505,6 @@ static int optee_probe(struct platform_device *pdev)
 	kfree(optee);
 err_free_pool:
 	tee_shm_pool_free(pool);
-	if (optee->smc.memremaped_shm)
-		memunmap(optee->smc.memremaped_shm);
 	return rc;
 }
 
-- 
1.8.3.1


--===============7484835474507240691==--

