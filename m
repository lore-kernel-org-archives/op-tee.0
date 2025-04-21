From: Mario Limonciello <superm1@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 2/2] tee: Sort header includes
Date: Mon, 21 Apr 2025 10:22:23 -0500
Message-ID: <20250421152238.764659-3-superm1@kernel.org>
In-Reply-To: <20250421152238.764659-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0847529653928194670=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0847529653928194670==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mario Limonciello <mario.limonciello@amd.com>

Various headers have been added over time that are not added alphabetically
and a private header is used before one of the linux/ headers.

Resort the list.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/tee/amdtee/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index a44625d076401..fb39d9a19c698 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -6,18 +6,19 @@
  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/psp-tee.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/device.h>
 #include <linux/tee_core.h>
 #include <linux/types.h>
-#include <linux/mm.h>
 #include <linux/uaccess.h>
-#include <linux/firmware.h>
+
 #include "amdtee_private.h"
-#include <linux/psp-tee.h>
 
 static struct amdtee_driver_data *drv_data;
 static DEFINE_MUTEX(session_list_mutex);
-- 
2.43.0


--===============0847529653928194670==--

