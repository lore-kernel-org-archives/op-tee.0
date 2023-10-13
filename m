From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v9 6/6] tee: optee: restore efivars ops when tee-supplicant stops
Date: Fri, 13 Oct 2023 16:45:39 +0900
Message-ID: <20231013074540.8980-7-masahisa.kojima@linaro.org>
In-Reply-To: <20231013074540.8980-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0626410282319977380=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0626410282319977380==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When tee-supplicant stops, tee-based EFI variable service
is no longer available. Restore the efivars generic ops at the
moment when tee-supplicant stops.

Linking error occurs if we set CONFIG_OPTEE=3Dy and
CONFIG_TEE_STMM_EFI=3Dm. Use IS_REACHABLE() guard to call
tee_stmm_restore_efivars_generic_ops() function.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 8 +++++++-
 drivers/tee/optee/supp.c                 | 4 ++++
 include/linux/efi.h                      | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/=
stmm/tee_stmm_efi.c
index edc165bc1bb0..e804b260edaa 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -572,10 +572,16 @@ static int tee_stmm_efi_probe(struct device *dev)
 	return 0;
 }
=20
-static int tee_stmm_efi_remove(struct device *dev)
+void tee_stmm_restore_efivars_generic_ops(void)
 {
 	efivars_unregister(&tee_efivars);
 	efivars_generic_ops_register();
+}
+EXPORT_SYMBOL_GPL(tee_stmm_restore_efivars_generic_ops);
+
+static int tee_stmm_efi_remove(struct device *dev)
+{
+	tee_stmm_restore_efivars_generic_ops();
=20
 	return 0;
 }
diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..d07d4fc4e72e 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, Linaro Limited
  */
 #include <linux/device.h>
+#include <linux/efi.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include "optee_private.h"
@@ -58,6 +59,9 @@ void optee_supp_release(struct optee_supp *supp)
 		complete(&req->c);
 	}
=20
+	if (IS_REACHABLE(CONFIG_TEE_STMM_EFI))
+		tee_stmm_restore_efivars_generic_ops();
+
 	supp->ctx =3D NULL;
 	supp->req_id =3D -1;
=20
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 489707b9b0b0..9b60893d6299 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1365,5 +1365,6 @@ extern struct blocking_notifier_head efivar_ops_nh;
=20
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);
+void tee_stmm_restore_efivars_generic_ops(void);
=20
 #endif /* _LINUX_EFI_H */
--=20
2.30.2


--===============0626410282319977380==--

