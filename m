From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 1/3] efi: expose efivar generic ops register function
Date: Wed, 22 Feb 2023 14:38:22 +0900
Message-ID: <20230222053825.992-2-masahisa.kojima@linaro.org>
In-Reply-To: <20230222053825.992-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8893815244525993780=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8893815244525993780==
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
index 4bb30434ee4a..abaf77773bdd 100644
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
index df88786b5947..7e5239da87bf 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1336,4 +1336,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid,=
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


--===============8893815244525993780==--

