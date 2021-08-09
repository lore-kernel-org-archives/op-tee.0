From: Christoph Gellner <cgellner@de.adit-jv.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 2/3 RESEND] tee: optee: Allow to freeze while waiting for call_queue
Date: Mon, 09 Aug 2021 09:14:51 +0200
Message-ID: <20210809071452.28508-3-cgellner@de.adit-jv.com>
In-Reply-To: <20210809071452.28508-1-cgellner@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4485498262280310471=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4485498262280310471==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

When the system is going to hibernate or suspend and the tasks of
the other entries in the call queue are frozen wait_for_completion
on the call_queue might get stuck.

Change wait to interruptible and add try_to_freeze in order to
allow that the waiting task is frozen as well.

Signed-off-by: Christoph Gellner <cgellner@de.adit-jv.com>
---
 drivers/tee/optee/call.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 6132cc8d014c..916cfa11cce2 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -12,6 +12,7 @@
 #include <linux/tee_drv.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/freezer.h>
 #include "optee_private.h"
 #include "optee_smc.h"
 #define CREATE_TRACE_POINTS
@@ -50,7 +51,12 @@ static void optee_cq_wait_init(struct optee_call_queue *cq,
 static void optee_cq_wait_for_completion(struct optee_call_queue *cq,
 					 struct optee_call_waiter *w)
 {
-	wait_for_completion(&w->c);
+	/*
+	 * wait_for_completion but allow hibernation/suspend
+	 * to freeze the waiting task
+	 */
+	while (wait_for_completion_interruptible(&w->c))
+		try_to_freeze();
 
 	mutex_lock(&cq->mutex);
 
-- 
2.32.0.rc0


--===============4485498262280310471==--

