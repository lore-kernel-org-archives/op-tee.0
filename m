From: Christoph Gellner <cgellner@de.adit-jv.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 3/3] tee: optee: Allow to freeze while waiting in
 OPTEE_RPC_WAIT_QUEUE_SLEEP
Date: Fri, 16 Jul 2021 17:45:00 +0200
Message-ID: <20210716154500.10115-4-cgellner@de.adit-jv.com>
In-Reply-To: <20210716154500.10115-1-cgellner@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3066269450418568353=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3066269450418568353==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When the system is going to hibernate or suspend and the task calling
the corresponding OPTEE_RPC_WAIT_QUEUE_WAKEUP gets frozen waiting
for completion in OPTEE_RPC_WAIT_QUEUE_SLEEP might get stuck.

Change wait to interruptible and add try_to_freeze in order to
allow that the waiting task is frozen as well.

Signed-off-by: Christoph Gellner <cgellner@de.adit-jv.com>
---
 drivers/tee/optee/rpc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 1849180b0278..0851b19be529 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/freezer.h>
 #include "optee_private.h"
 #include "optee_smc.h"
 #include "optee_rpc_cmd.h"
@@ -169,7 +170,13 @@ static void wq_sleep(struct optee_wait_queue *wq, u32 ke=
y)
 	struct wq_entry *w =3D wq_entry_get(wq, key);
=20
 	if (w) {
-		wait_for_completion(&w->c);
+		/*
+		 * wait_for_completion but allow hibernation/suspend
+		 * to freeze the waiting task
+		 */
+		while (wait_for_completion_interruptible(&w->c))
+			try_to_freeze();
+
 		mutex_lock(&wq->mu);
 		list_del(&w->link);
 		mutex_unlock(&wq->mu);
--=20
2.32.0.rc0


--===============3066269450418568353==--

