From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 6/7] firmware: arm_ffa: Add support for FFA_YIELD in direct messaging
Date: Wed, 14 Aug 2024 14:48:55 +0100
Message-ID: <20240814-ffa_v1-2-v1-6-9e9abef69b21@arm.com>
In-Reply-To: <20240814-ffa_v1-2-v1-0-9e9abef69b21@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8178314694608894013=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8178314694608894013==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Successful completion of both direct messaging function can be indicated
through an invocation of FFA_YIELD or GGA_INTERRUPT by the callee.

FFA_INTERRUPT indicates that the direct request was interrupted and must
be resumed through the FFA_RUN interface which is already done in the
driver.

FFA_YIELD indicates that the receiver endpoint has transitioned to the
blocked runtime state and must be resumed through the FFA_RUN interface.
However, the way receiver endpoint gets unblocked is implementation
defined. So, the driver just sleeps for 1 - 2ms and issues FFA_RUN. It
can return to the caller with FFA_YIELD is the receiver endpoint is still
blocked.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index 8af41be4b1c1..90102ed7bd18 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -26,6 +26,7 @@
 #include <linux/arm_ffa.h>
 #include <linux/bitfield.h>
 #include <linux/cpuhotplug.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/hashtable.h>
 #include <linux/interrupt.h>
@@ -397,6 +398,18 @@ static int ffa_id_get(u16 *vm_id)
 	return 0;
 }
=20
+static inline void ffa_msg_send_wait_for_completion(ffa_value_t *ret)
+{
+	while (ret->a0 =3D=3D FFA_INTERRUPT || ret->a0 =3D=3D FFA_YIELD) {
+		if (ret->a0 =3D=3D FFA_YIELD)
+			fsleep(1000);
+
+		invoke_ffa_fn((ffa_value_t){
+			      .a0 =3D FFA_RUN, .a1 =3D ret->a1,
+			      }, ret);
+	}
+}
+
 static int ffa_msg_send_direct_req(u16 src_id, u16 dst_id, bool mode_32bit,
 				   struct ffa_send_direct_data *data)
 {
@@ -417,10 +430,7 @@ static int ffa_msg_send_direct_req(u16 src_id, u16 dst_i=
d, bool mode_32bit,
 		      .a6 =3D data->data3, .a7 =3D data->data4,
 		      }, &ret);
=20
-	while (ret.a0 =3D=3D FFA_INTERRUPT)
-		invoke_ffa_fn((ffa_value_t){
-			      .a0 =3D FFA_RUN, .a1 =3D ret.a1,
-			      }, &ret);
+	ffa_msg_send_wait_for_completion(&ret);
=20
 	if (ret.a0 =3D=3D FFA_ERROR)
 		return ffa_to_linux_errno((int)ret.a2);
@@ -482,10 +492,7 @@ static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_=
id, const uuid_t *uuid,
=20
 	invoke_ffa_fn(args, &ret);
=20
-	while (ret.a0 =3D=3D FFA_INTERRUPT)
-		invoke_ffa_fn((ffa_value_t){
-			      .a0 =3D FFA_RUN, .a1 =3D ret.a1,
-			      }, &ret);
+	ffa_msg_send_wait_for_completion(&ret);
=20
 	if (ret.a0 =3D=3D FFA_ERROR)
 		return ffa_to_linux_errno((int)ret.a2);

--=20
2.46.0


--===============8178314694608894013==--

