From: Mario Limonciello <mario.limonciello@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 2/9] crypto: ccp: Add a header for multiple drivers to use
 `__psp_pa`
Date: Thu, 02 Mar 2023 13:42:25 -0600
Message-ID: <20230302194235.1724-3-mario.limonciello@amd.com>
In-Reply-To: <20230302194235.1724-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0171125877601004543=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0171125877601004543==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The TEE subdriver for CCP, the amdtee driver and the i2c-designware-amdpsp
drivers all include `psp-sev.h` even though they don't use SEV
functionality.

Move the definition of `__psp_pa` into a common header to be included
by all of these drivers.

Reviewed-by: Jan Dabros <jsd@semihalf.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com> # For the drivers/i=
2c/busses/i2c-designware-amdpsp.c
Acked-by: Sumit Garg <sumit.garg@linaro.org> # For TEE subsystem bits
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add tags
---
 arch/x86/kvm/svm/sev.c                     |  1 +
 drivers/crypto/ccp/sev-dev.c               |  1 +
 drivers/crypto/ccp/tee-dev.c               |  2 +-
 drivers/i2c/busses/i2c-designware-amdpsp.c |  2 +-
 drivers/tee/amdtee/call.c                  |  2 +-
 drivers/tee/amdtee/shm_pool.c              |  2 +-
 include/linux/psp-sev.h                    |  8 --------
 include/linux/psp.h                        | 14 ++++++++++++++
 8 files changed, 20 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/psp.h

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c25aeb550cd9..ec18a756b7c9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -12,6 +12,7 @@
 #include <linux/kvm_host.h>
 #include <linux/kernel.h>
 #include <linux/highmem.h>
+#include <linux/psp.h>
 #include <linux/psp-sev.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e2f25926eb51..28945ca7c856 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -24,6 +24,7 @@
 #include <linux/cpufeature.h>
 #include <linux/fs.h>
 #include <linux/fs_struct.h>
+#include <linux/psp.h>
=20
 #include <asm/smp.h>
 #include <asm/cacheflush.h>
diff --git a/drivers/crypto/ccp/tee-dev.c b/drivers/crypto/ccp/tee-dev.c
index 5c9d47f3be37..f24fc953718a 100644
--- a/drivers/crypto/ccp/tee-dev.c
+++ b/drivers/crypto/ccp/tee-dev.c
@@ -13,7 +13,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/gfp.h>
-#include <linux/psp-sev.h>
+#include <linux/psp.h>
 #include <linux/psp-tee.h>
=20
 #include "psp-dev.h"
diff --git a/drivers/i2c/busses/i2c-designware-amdpsp.c b/drivers/i2c/busses/=
i2c-designware-amdpsp.c
index 8f36167bce62..80f28a1bbbef 100644
--- a/drivers/i2c/busses/i2c-designware-amdpsp.c
+++ b/drivers/i2c/busses/i2c-designware-amdpsp.c
@@ -4,7 +4,7 @@
 #include <linux/bits.h>
 #include <linux/i2c.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/psp-sev.h>
+#include <linux/psp.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
=20
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index cec6e70f0ac9..e8cd9aaa3467 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -8,7 +8,7 @@
 #include <linux/tee_drv.h>
 #include <linux/psp-tee.h>
 #include <linux/slab.h>
-#include <linux/psp-sev.h>
+#include <linux/psp.h>
 #include "amdtee_if.h"
 #include "amdtee_private.h"
=20
diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
index f87f96a291c9..f0303126f199 100644
--- a/drivers/tee/amdtee/shm_pool.c
+++ b/drivers/tee/amdtee/shm_pool.c
@@ -5,7 +5,7 @@
=20
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
-#include <linux/psp-sev.h>
+#include <linux/psp.h>
 #include "amdtee_private.h"
=20
 static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 1595088c428b..7fd17e82bab4 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -14,14 +14,6 @@
=20
 #include <uapi/linux/psp-sev.h>
=20
-#ifdef CONFIG_X86
-#include <linux/mem_encrypt.h>
-
-#define __psp_pa(x)	__sme_pa(x)
-#else
-#define __psp_pa(x)	__pa(x)
-#endif
-
 #define SEV_FW_BLOB_MAX_SIZE	0x4000	/* 16KB */
=20
 /**
diff --git a/include/linux/psp.h b/include/linux/psp.h
new file mode 100644
index 000000000000..202162487ec3
--- /dev/null
+++ b/include/linux/psp.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __PSP_H
+#define __PSP_H
+
+#ifdef CONFIG_X86
+#include <linux/mem_encrypt.h>
+
+#define __psp_pa(x)	__sme_pa(x)
+#else
+#define __psp_pa(x)	__pa(x)
+#endif
+
+#endif /* __PSP_H */
--=20
2.34.1


--===============0171125877601004543==--

