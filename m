From: Rui Miguel Silva <rui.silva@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] optee: add writeback to valid memory type
Date: Fri, 13 Nov 2020 15:06:04 +0000
Message-ID: <20201113150604.426784-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7490624538692823087=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7490624538692823087==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Only in smp systems the cache policy is setup as write alloc, in
single cpu systems the cache policy is set as writeback and it is
normal memory, so, it should pass the is_normal_memory check in the
share memory registration.

Add the right condition to make it work in no smp systems.

Fixes: cdbcf83d29c1 ("tee: optee: check type of registered shared memory")
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>

---
 drivers/tee/optee/call.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 20b6fd7383c5..c981757ba0d4 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -534,7 +534,8 @@ void optee_free_pages_list(void *list, size_t num_entries)
 static bool is_normal_memory(pgprot_t p)
 {
 #if defined(CONFIG_ARM)
-	return (pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC;
+	return (((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC) ||
+		((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEBACK));
 #elif defined(CONFIG_ARM64)
 	return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
 #else
-- 
2.29.2


--===============7490624538692823087==--

