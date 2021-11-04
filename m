From: cgel.zte@gmail.com
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] optee: fix kfree NULL pointer
Date: Thu, 04 Nov 2021 11:30:47 +0000
Message-ID: <20211104113047.28585-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6182239446352557587=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6182239446352557587==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Lv Ruyi <lv.ruyi@zte.com.cn>

This patch fixes the following Coccinelle error:
drivers/tee/optee/ffa_abi.c: 877: ERROR  optee is NULL but dereferenced.

If memory allocation fails, optee is null pointer. the code will goto err
 and release optee.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/tee/optee/ffa_abi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 6defd1ec982a..8d9d189557f9 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -811,8 +811,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee) {
-		rc = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
 	optee->pool = optee_ffa_config_dyn_shm();
 	if (IS_ERR(optee->pool)) {
-- 
2.25.1


--===============6182239446352557587==--

