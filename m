From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: fix compiler warning in tee_shm_register()
Date: Mon, 22 Aug 2022 10:28:46 +0200
Message-ID: <20220822082846.3558520-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3160410984113002628=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3160410984113002628==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Include <linux/uaccess.h> to avoid the warning:
   drivers/tee/tee_shm.c: In function 'tee_shm_register':
>> drivers/tee/tee_shm.c:242:14: error: implicit declaration of function 'acc=
ess_ok' [-Werror=3Dimplicit-function-declaration]
     242 |         if (!access_ok((void __user *)addr, length))
         |              ^~~~~~~~~
   cc1: some warnings being treated as errors

Fixes: 573ae4f13f63 ("tee: add overflow check in register_shm_helper()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 1175f3a46859..27295bda3e0b 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/uaccess.h>
 #include <linux/uio.h>
 #include "tee_private.h"
=20
--=20
2.31.1


--===============3160410984113002628==--

