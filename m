From: Christoph Gellner <cgellner@de.adit-jv.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 1/3] tee: optee: Allow to freeze the task waiting for
 tee-supplicant
Date: Wed, 26 May 2021 09:09:09 +0200
Message-ID: <20210526070911.31681-2-cgellner@de.adit-jv.com>
In-Reply-To: <20210526070911.31681-1-cgellner@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7459196689790864143=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7459196689790864143==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When the system is going to hibernate or suspend it might happen
that the tee-supplicant task is frozen first.
wait_for_completion_interruptible might get stuck in this case.

Add try_to_freeze to allow the waiting task to be frozen while
waiting for the response of tee-supplicant.

Signed-off-by: Christoph Gellner <cgellner@de.adit-jv.com>
---
 drivers/tee/optee/supp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..03c37bae6ac4 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/freezer.h>
 #include "optee_private.h"
=20
 struct optee_supp_req {
@@ -141,6 +142,8 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func=
, size_t num_params,
 			req->ret =3D TEEC_ERROR_COMMUNICATION;
 			break;
 		}
+
+		try_to_freeze();
 	}
=20
 	ret =3D req->ret;
--=20
2.32.0.rc0


--===============7459196689790864143==--

