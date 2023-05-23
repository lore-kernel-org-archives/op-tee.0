From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v4 1/3] efi: expose efivar generic ops register function
Date: Tue, 23 May 2023 18:06:04 +0900
Message-ID: <20230523090607.1433-2-masahisa.kojima@linaro.org>
In-Reply-To: <20230523090607.1433-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3140233422042865341=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3140233422042865341==
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
index abeff7dc0b58..56fcced48544 100644
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
index 7aa62c92185f..6d6c5e384345 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1338,4 +1338,7 @@ bool efi_config_table_is_usable(const efi_guid_t *guid,=
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


--===============3140233422042865341==--

