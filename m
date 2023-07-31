From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v7 4/5] efivarfs: automatically update super block flag
Date: Mon, 31 Jul 2023 15:50:39 +0900
Message-ID: <20230731065041.1447-5-masahisa.kojima@linaro.org>
In-Reply-To: <20230731065041.1447-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7061016409685247639=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7061016409685247639==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

efivar operation is updated when the tee_stmm_efi module is probed.
tee_stmm_efi module supports SetVariable runtime service,
but user needs to manually remount the efivarfs as RW to enable
the write access if the previous efivar operation does not support
SerVariable and efivarfs is mounted as read-only.

This commit notifies the update of efivar operation to
efivarfs subsystem, then drops SB_RDONLY flag if the efivar
operation supports SetVariable.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/efi.c  |  6 ++++++
 drivers/firmware/efi/vars.c |  8 ++++++++
 fs/efivarfs/super.c         | 33 +++++++++++++++++++++++++++++++++
 include/linux/efi.h         |  8 ++++++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d108cf03e19d..00494fcf16ba 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -32,6 +32,7 @@
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
 #include <linux/security.h>
+#include <linux/notifier.h>
=20
 #include <asm/early_ioremap.h>
=20
@@ -184,6 +185,9 @@ static const struct attribute_group efi_subsys_attr_group=
 =3D {
 	.is_visible =3D efi_attr_is_visible,
 };
=20
+struct blocking_notifier_head efivar_ops_nh;
+EXPORT_SYMBOL_GPL(efivar_ops_nh);
+
 static struct efivars generic_efivars;
 static struct efivar_operations generic_ops;
=20
@@ -442,6 +446,8 @@ static int __init efisubsys_init(void)
 		platform_device_register_simple("efivars", 0, NULL, 0);
 	}
=20
+	BLOCKING_INIT_NOTIFIER_HEAD(&efivar_ops_nh);
+
 	error =3D sysfs_create_group(efi_kobj, &efi_subsys_attr_group);
 	if (error) {
 		pr_err("efi: Sysfs attribute export failed with error %d.\n",
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index e9dc7116daf1..f654e6f6af87 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -63,6 +63,7 @@ int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops)
 {
 	int rv;
+	int event;
=20
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
@@ -77,6 +78,13 @@ int efivars_register(struct efivars *efivars,
=20
 	__efivars =3D efivars;
=20
+	if (efivar_supports_writes())
+		event =3D EFIVAR_OPS_RDWR;
+	else
+		event =3D EFIVAR_OPS_RDONLY;
+
+	blocking_notifier_call_chain(&efivar_ops_nh, event, NULL);
+
 	pr_info("Registered efivars operations\n");
 	rv =3D 0;
 out:
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..0f6e4d223aea 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -14,11 +14,36 @@
 #include <linux/slab.h>
 #include <linux/magic.h>
 #include <linux/statfs.h>
+#include <linux/notifier.h>
=20
 #include "internal.h"
=20
 LIST_HEAD(efivarfs_list);
=20
+struct efivarfs_info {
+	struct super_block *sb;
+	struct notifier_block nb;
+};
+
+static struct efivarfs_info info;
+
+static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long ev=
ent,
+				 void *data)
+{
+	switch (event) {
+	case EFIVAR_OPS_RDONLY:
+		info.sb->s_flags |=3D SB_RDONLY;
+		break;
+	case EFIVAR_OPS_RDWR:
+		info.sb->s_flags &=3D ~SB_RDONLY;
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
 static void efivarfs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
@@ -255,6 +280,12 @@ static int efivarfs_fill_super(struct super_block *sb, s=
truct fs_context *fc)
 	if (!root)
 		return -ENOMEM;
=20
+	info.sb =3D sb;
+	info.nb.notifier_call =3D efivarfs_ops_notifier;
+	err =3D blocking_notifier_chain_register(&efivar_ops_nh, &info.nb);
+	if (err)
+		return err;
+
 	INIT_LIST_HEAD(&efivarfs_list);
=20
 	err =3D efivar_init(efivarfs_callback, (void *)sb, true, &efivarfs_list);
@@ -281,6 +312,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
=20
 static void efivarfs_kill_sb(struct super_block *sb)
 {
+	blocking_notifier_chain_unregister(&efivar_ops_nh, &info.nb);
+	info.sb =3D NULL;
 	kill_litter_super(sb);
=20
 	if (!efivar_is_available())
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 657f7e203374..2533e4f2547f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1350,6 +1350,14 @@ bool efi_config_table_is_usable(const efi_guid_t *guid=
, unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
=20
+/*
+ * efivar ops event type
+ */
+#define EFIVAR_OPS_RDONLY 0
+#define EFIVAR_OPS_RDWR 1
+
+extern struct blocking_notifier_head efivar_ops_nh;
+
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);
=20
--=20
2.30.2


--===============7061016409685247639==--

