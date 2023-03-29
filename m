From: Colin Ian King <colin.i.king@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH][next] optee: Fix spelling mistake "Unuspported" -> "Unsupported"
Date: Wed, 29 Mar 2023 10:32:00 +0100
Message-ID: <20230329093200.419041-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8685815020631710442=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8685815020631710442==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

There is a spelling mistake in a #error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tee/optee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 290b1bb0e9cd..df5fb5410b72 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -488,7 +488,7 @@ static bool is_normal_memory(pgprot_t p)
 #elif defined(CONFIG_ARM64)
 	return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
 #else
-#error "Unuspported architecture"
+#error "Unsupported architecture"
 #endif
 }
 
-- 
2.30.2


--===============8685815020631710442==--

