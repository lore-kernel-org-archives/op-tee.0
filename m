From: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 7/7] tee: optee: Notify TEE Mediator on OP-TEE driver
 initialization and release
Date: Tue, 01 Apr 2025 22:35:27 +0530
Message-ID: <20250401170527.344092-8-yuvraj.kernel@gmail.com>
In-Reply-To: <20250401170527.344092-1-yuvraj.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2532333715730374862=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2532333715730374862==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When host initializes or releases its OP-TEE driver through
optee_core_init()/optee_core_exit(), notify OP-TEE in the secure world
about this change.

If OP-TEE is built with NS-Virtualization support, it will treat SMCs coming
from the host as if it were coming from a VM (as OP-TEE does not understand
the KVM paradigm).

Hence, OPTEE_SMC_VM_CREATED and OPTEE_SMC_VM_DESTROYED SMCs have to be made
for its internal book-keeping.

Signed-off-by: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
---
 drivers/tee/optee/core.c    | 13 ++++++++++++-
 drivers/tee/optee/smc_abi.c |  6 ++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index c75fddc83576..5f2ab0ee0893 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/tee_core.h>
+#include <linux/tee_mediator.h>
 #include <linux/types.h>
 #include "optee_private.h"
=20
@@ -195,7 +196,13 @@ static bool intf_is_regged;
 static int __init optee_core_init(void)
 {
 	int rc;
-
+#ifdef CONFIG_TEE_MEDIATOR
+	if (tee_mediator_is_active()) {
+		rc =3D tee_mediator_create_host();
+		if (rc < 0)
+			return rc;
+	}
+#endif
 	/*
 	 * The kernel may have crashed@the same time that all available
 	 * secure world threads were suspended and we cannot reschedule the
@@ -240,6 +247,10 @@ static void __exit optee_core_exit(void)
 		optee_smc_abi_unregister();
 	if (!ffa_abi_rc)
 		optee_ffa_abi_unregister();
+#ifdef CONFIG_TEE_MEDIATOR
+	if (tee_mediator_is_active())
+		tee_mediator_destroy_host();
+#endif
 }
 module_exit(optee_core_exit);
=20
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index f0c3ac1103bb..a930ca8cde23 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -25,8 +25,10 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/tee_core.h>
+#include <linux/tee_mediator.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include "optee_mediator.h"
 #include "optee_private.h"
 #include "optee_smc.h"
 #include "optee_rpc_cmd.h"
@@ -1396,6 +1398,10 @@ static void optee_smccc_smc(unsigned long a0, unsigned=
 long a1,
 			    unsigned long a6, unsigned long a7,
 			    struct arm_smccc_res *res)
 {
+#ifdef CONFIG_TEE_MEDIATOR
+	if (tee_mediator_is_active())
+		a7 =3D OPTEE_HOST_VMID;
+#endif
 	arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res);
 }
=20
--=20
2.43.0


--===============2532333715730374862==--

