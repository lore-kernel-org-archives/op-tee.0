From: Ran Wang <ran.wang_1@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] optee: enable apci support
Date: Fri, 12 Mar 2021 16:36:53 +0800
Message-ID: <20210312083653.38780-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0405260321919879646=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0405260321919879646==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch add ACPI support for optee driver.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/tee/optee/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index cf4718c6d35d..8fb261f4b9db 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -735,12 +736,21 @@ static const struct of_device_id optee_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, optee_dt_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id optee_acpi_match[] = {
+	{ "OPTEE01",},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
+#endif
+
 static struct platform_driver optee_driver = {
 	.probe  = optee_probe,
 	.remove = optee_remove,
 	.driver = {
 		.name = "optee",
 		.of_match_table = optee_dt_match,
+		.acpi_match_table = ACPI_PTR(optee_acpi_match),
 	},
 };
 module_platform_driver(optee_driver);
-- 
2.25.1


--===============0405260321919879646==--

