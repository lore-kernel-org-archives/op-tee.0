From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v10 1/5] efi: expose efivar generic ops register function
Date: Tue, 07 Nov 2023 14:40:52 +0900
Message-ID: <20231107054057.1893-2-masahisa.kojima@linaro.org>
In-Reply-To: <20231107054057.1893-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3277082417987619516=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3277082417987619516==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This is a preparation for supporting efivar operations
provided by other than efi subsystem.
Both register and unregister functions are exposed
so that non-efi subsystem can revert the efi generic
operation.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/efi.c | 12 ++++++++++++
 include/linux/efi.h        |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1599f1176842..53ae25bbb6ac 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -231,6 +231,18 @@ static void generic_ops_unregister(void)
 	efivars_unregister(&generic_efivars);
 }
=20
+void efivars_generic_ops_register(void)
+{
+	generic_ops_register();
+}
+EXPORT_SYMBOL_GPL(efivars_generic_ops_register);
+
+void efivars_generic_ops_unregister(void)
+{
+	generic_ops_unregister();
+}
+EXPORT_SYMBOL_GPL(efivars_generic_ops_unregister);
+
 #ifdef CONFIG_EFI_CUSTOM_SSDT_OVERLAYS
 #define EFIVAR_SSDT_NAME_MAX	16UL
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 80b21d1c6eaf..08bc00dad66e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1355,4 +1355,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid,=
 unsigned long table)
=20
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, in=
t n);
=20
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
--=20
2.39.2


--===============3277082417987619516==--

