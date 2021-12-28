From: Jan Engelhardt <jengelh@inai.de>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: combine "config" and "menu" for TEE's menuconfig
Date: Tue, 28 Dec 2021 20:57:37 +0100
Message-ID: <20211228195737.16633-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5852129588105076584=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5852129588105076584==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Don't let TEE occupy two lines in menuconfig when practically no
other (sub)menu does either.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 drivers/tee/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git drivers/tee/Kconfig drivers/tee/Kconfig
index e99d840c2511..73a147202e88 100644
--- drivers/tee/Kconfig
+++ drivers/tee/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Generic Trusted Execution Environment Configuration
-config TEE
+menuconfig TEE
 	tristate "Trusted Execution Environment support"
 	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
 	select CRYPTO
@@ -13,10 +13,7 @@ config TEE
 
 if TEE
 
-menu "TEE drivers"
-
 source "drivers/tee/optee/Kconfig"
 source "drivers/tee/amdtee/Kconfig"
-endmenu
 
 endif
-- 
2.34.1


--===============5852129588105076584==--

