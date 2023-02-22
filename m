From: Jules Maselbas <jmaselbas@kalray.eu>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: Fix typo Unuspported -> Unsupported
Date: Wed, 22 Feb 2023 17:30:14 +0000
Message-ID: <20230222173009.19874-1-jmaselbas@kalray.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6668301777624606563=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6668301777624606563==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Fix typo Unuspported -> Unsupported

Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
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
2.17.1


--===============6668301777624606563==--

