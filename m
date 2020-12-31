From: Tian Tao <tiantao6@hisilicon.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] drivers: optee: use flexible-array member instead of
 zero-length array
Date: Thu, 31 Dec 2020 19:58:26 +0800
Message-ID: <1609415906-35024-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8583456957291519289=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8583456957291519289==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Use flexible-array member introduced in C99 instead of zero-length
array. Most of zero-length array was already taken care in previous
patch [1]. Now modified few more cases which were not handled earlier.

[1]. https://patchwork.kernel.org/patch/11394197/

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/tee/optee/optee_msg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 7b2d919..b1f1e90 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -199,7 +199,7 @@ struct optee_msg_arg {
 	u32 num_params;
 
 	/* num_params tells the actual number of element in params */
-	struct optee_msg_param params[0];
+	struct optee_msg_param params[];
 };
 
 /**
-- 
2.7.4


--===============8583456957291519289==--

