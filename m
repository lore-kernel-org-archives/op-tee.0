From: Yang Li <yang.lee@linux.alibaba.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH -next v2] optee: Fix NULL but dereferenced coccicheck error
Date: Mon, 22 Nov 2021 10:20:50 +0800
Message-ID: <1637547650-4205-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7766457173853862816=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7766457173853862816==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Eliminate the following coccicheck warning:
./drivers/tee/optee/smc_abi.c:1508:12-15: ERROR: optee is NULL but
dereferenced.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 'commit 6749e69c4dad ("optee: add asynchronous notifications")'
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

change in v2:
--According to Jens's suggestion
fixed as:
        if (memremaped_shm)
                memunmap(memremaped_shm);

 drivers/tee/optee/smc_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 92759d7..d7c8235 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1505,8 +1505,8 @@ static int optee_probe(struct platform_device *pdev)
 	kfree(optee);
 err_free_pool:
 	tee_shm_pool_free(pool);
-	if (optee->smc.memremaped_shm)
-		memunmap(optee->smc.memremaped_shm);
+	if (memremaped_shm)
+		memunmap(memremaped_shm);
 	return rc;
 }
 
-- 
1.8.3.1


--===============7766457173853862816==--

