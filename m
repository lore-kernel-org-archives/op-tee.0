From: Bjorn Helgaas <helgaas@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: fix 'physical' typos
Date: Tue, 26 Jan 2021 15:15:07 -0600
Message-ID: <20210126211507.2920362-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1254479488165145471=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1254479488165145471==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix misspellings of "physical".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/tee/optee/optee_smc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 777ad54d4c2c..b52eb34b4237 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -139,7 +139,7 @@ struct optee_smc_call_get_os_revision_result {
  *					optee_msg_arg.
  * OPTEE_SMC_RETURN_ETHREAD_LIMIT	Number of Trusted OS threads exceeded,
  *					try again later.
- * OPTEE_SMC_RETURN_EBADADDR		Bad physcial pointer to struct
+ * OPTEE_SMC_RETURN_EBADADDR		Bad physical pointer to struct
  *					optee_msg_arg.
  * OPTEE_SMC_RETURN_EBADCMD		Bad/unknown cmd in struct optee_msg_arg
  * OPTEE_SMC_RETURN_IS_RPC()		Call suspended by RPC call to normal
-- 
2.25.1


--===============1254479488165145471==--

