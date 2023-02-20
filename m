From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 3/4] tee: expose tee efivar register function
Date: Mon, 20 Feb 2023 14:17:21 +0900
Message-ID: <20230220051723.1257-4-masahisa.kojima@linaro.org>
In-Reply-To: <20230220051723.1257-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6249821612240287476=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6249821612240287476==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This commit adds the functions to register/unregister
the tee-based EFI variable driver.

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/tee/tee_core.c  | 23 +++++++++++++++++++++++
 include/linux/tee_drv.h | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 98da206cd761..0dce5b135d2c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -7,6 +7,7 @@
=20
 #include <linux/cdev.h>
 #include <linux/cred.h>
+#include <linux/efi.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/module.h>
@@ -1263,6 +1264,28 @@ static void __exit tee_exit(void)
 	tee_class =3D NULL;
 }
=20
+void tee_register_efivar_ops(struct efivars *tee_efivars,
+			     struct efivar_operations *ops)
+{
+	/*
+	 * If the firmware EFI runtime services support SetVariable(),
+	 * tee-based EFI variable services are not used.
+	 */
+	if (!efivar_supports_writes()) {
+		efivars_generic_ops_unregister();
+		pr_info("Use tee-based EFI runtime variable services\n");
+		efivars_register(tee_efivars, ops);
+	}
+}
+EXPORT_SYMBOL_GPL(tee_register_efivar_ops);
+
+void tee_unregister_efivar_ops(struct efivars *tee_efivars)
+{
+	efivars_unregister(tee_efivars);
+	efivars_generic_ops_register();
+}
+EXPORT_SYMBOL_GPL(tee_unregister_efivar_ops);
+
 subsys_initcall(tee_init);
 module_exit(tee_exit);
=20
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 17eb1c5205d3..def4ea6212ee 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -7,6 +7,7 @@
 #define __TEE_DRV_H
=20
 #include <linux/device.h>
+#include <linux/efi.h>
 #include <linux/idr.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -507,4 +508,26 @@ struct tee_context *teedev_open(struct tee_device *teede=
v);
  */
 void teedev_close_context(struct tee_context *ctx);
=20
+/**
+ * tee_register_efivar_ops() - register the efivar ops
+ * @tee_efivars:	pointer to efivars structure
+ * @ops:		pointer to contain the efivar operation
+ *
+ * This function registers the tee-based efivar operation as an
+ * EFI Runtime Service.
+ *
+ */
+void tee_register_efivar_ops(struct efivars *tee_efivars,
+			     struct efivar_operations *ops);
+
+/**
+ * tee_unregister_efivar_ops() - unregister the efivar ops
+ * @tee_efivars:	pointer to efivars structure
+ *
+ * This function unregisters the tee-based efivar operation
+ * and reverts to the generic operation.
+ *
+ */
+void tee_unregister_efivar_ops(struct efivars *tee_efivars);
+
 #endif /*__TEE_DRV_H*/
--=20
2.30.2


--===============6249821612240287476==--

