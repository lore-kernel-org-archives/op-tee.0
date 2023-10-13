From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v9 1/6] efi: expose efivar generic ops register function
Date: Fri, 13 Oct 2023 16:45:34 +0900
Message-ID: <20231013074540.8980-2-masahisa.kojima@linaro.org>
In-Reply-To: <20231013074540.8980-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8888401105907639450=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8888401105907639450==
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
index 5a1e39df8b26..3ade74795ea9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1354,4 +1354,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid,=
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
2.30.2


--===============8888401105907639450==--

