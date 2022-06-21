From: Jiang Jian <jiangjian@cdjrlc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] optee: Remove duplicate 'of' in two places.
Date: Wed, 22 Jun 2022 00:16:48 +0800
Message-ID: <20220621161648.20117-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8918940385933993494=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8918940385933993494==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

file: ./drivers/tee/optee/optee_smc.h
line: 192
 * a2   Size of of SHM
chanegd to
 * a2   Size of SHM

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/tee/optee/optee_smc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index c60896cf71cb..73b5e7760d10 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -189,7 +189,7 @@ struct optee_smc_call_get_os_revision_result {
  * Have config return register usage:
  * a0	OPTEE_SMC_RETURN_OK
  * a1	Physical address of start of SHM
- * a2	Size of of SHM
+ * a2	Size of SHM
  * a3	Cache settings of memory, as defined by the
  *	OPTEE_SMC_SHM_* values above
  * a4-7	Preserved
-- 
2.17.1


--===============8918940385933993494==--

