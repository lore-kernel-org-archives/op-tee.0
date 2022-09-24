From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH] optee: Add __init/__exit annotations to module init/exit funcs
Date: Sat, 24 Sep 2022 17:28:20 +0800
Message-ID: <20220924092820.62673-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8097243886378130087=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8097243886378130087==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add missing __init/__exit annotations to module init/exit funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/tee/optee/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index daf07737c4fd..2a258bd3b6b5 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -188,7 +188,7 @@ void optee_remove_common(struct optee *optee)
 static int smc_abi_rc;
 static int ffa_abi_rc;
 
-static int optee_core_init(void)
+static int __init optee_core_init(void)
 {
 	/*
 	 * The kernel may have crashed at the same time that all available
@@ -210,7 +210,7 @@ static int optee_core_init(void)
 }
 module_init(optee_core_init);
 
-static void optee_core_exit(void)
+static void __exit optee_core_exit(void)
 {
 	if (!smc_abi_rc)
 		optee_smc_abi_unregister();
-- 
2.17.1


--===============8097243886378130087==--

