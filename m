From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 1/2] efi: expose efivar generic ops register function
Date: Thu, 26 Jan 2023 22:21:18 +0900
Message-ID: <20230126132120.1661-2-masahisa.kojima@linaro.org>
In-Reply-To: <20230126132120.1661-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1482413500071263067=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1482413500071263067==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This is a preparation for supporting efivar operations
provided by other than efi subsystem.
Both register and unregister functions are exposed
so that non-efi subsystem can revert the efi generic
operation.

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/efi.c | 12 ++++++++++++
 include/linux/efi.h        |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 52146f95d58e..4e576b62c170 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -227,6 +227,18 @@ static void generic_ops_unregister(void)
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
index 1a1adc8d3ba3..5e301c00e9b0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1332,4 +1332,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid,=
 unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
=20
+void efivars_generic_ops_register(void);
+void efivars_generic_ops_unregister(void);
+
 #endif /* _LINUX_EFI_H */
--=20
2.30.2


--===============1482413500071263067==--

