From: Marc Kleine-Budde <mkl@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: tee_get_drvdata(): fix description of return value
Date: Mon, 06 Jun 2022 13:43:53 +0200
Message-ID: <20220606114353.3551683-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8594952303313247208=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8594952303313247208==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch fixes the description of tee_get_drvdata()'s return value.
It actually returns the driver_data pointer supplied to
tee_device_alloc() since the TEE subsystem was added to the kernel.

Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 8aa1a4836b92..cebe4963ad87 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1075,7 +1075,7 @@ EXPORT_SYMBOL_GPL(tee_device_unregister);
 /**
  * tee_get_drvdata() - Return driver_data pointer
  * @teedev:	Device containing the driver_data pointer
- * @returns the driver_data pointer supplied to tee_register().
+ * @returns the driver_data pointer supplied to tee_device_alloc().
  */
 void *tee_get_drvdata(struct tee_device *teedev)
 {
-- 
2.35.1



--===============8594952303313247208==--

