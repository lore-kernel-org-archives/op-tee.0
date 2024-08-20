From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v2 3/7] firmware: arm_ffa: Move the function ffa_features() earlier
Date: Tue, 20 Aug 2024 15:27:56 +0100
Message-ID: <20240820-ffa_v1-2-v2-3-18c0c5f3c65e@arm.com>
In-Reply-To: <20240820-ffa_v1-2-v2-0-18c0c5f3c65e@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0592972101906789571=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0592972101906789571==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

We need to use ffa_features() in ffa_partition_probe() to detect if
the newer FFA_PARTITION_INFO_GET_REGS API is supported in the platform
or not. To avoid unnecessary forward declaration within the file, let
us just move this ffa_features() earlier.

No funtional change.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 52 +++++++++++++++++++------------------=
--
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index be77e03578cc..91681933ece9 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -212,6 +212,32 @@ static int ffa_rxtx_unmap(u16 vm_id)
 	return 0;
 }
=20
+static int ffa_features(u32 func_feat_id, u32 input_props,
+			u32 *if_props_1, u32 *if_props_2)
+{
+	ffa_value_t id;
+
+	if (!ARM_SMCCC_IS_FAST_CALL(func_feat_id) && input_props) {
+		pr_err("%s: Invalid Parameters: %x, %x", __func__,
+		       func_feat_id, input_props);
+		return ffa_to_linux_errno(FFA_RET_INVALID_PARAMETERS);
+	}
+
+	invoke_ffa_fn((ffa_value_t){
+		.a0 =3D FFA_FEATURES, .a1 =3D func_feat_id, .a2 =3D input_props,
+		}, &id);
+
+	if (id.a0 =3D=3D FFA_ERROR)
+		return ffa_to_linux_errno((int)id.a2);
+
+	if (if_props_1)
+		*if_props_1 =3D id.a2;
+	if (if_props_2)
+		*if_props_2 =3D id.a3;
+
+	return 0;
+}
+
 #define PARTITION_INFO_GET_RETURN_COUNT_ONLY	BIT(0)
=20
 /* buffer must be sizeof(struct ffa_partition_info) * num_partitions */
@@ -598,32 +624,6 @@ static int ffa_memory_reclaim(u64 g_handle, u32 flags)
 	return 0;
 }
=20
-static int ffa_features(u32 func_feat_id, u32 input_props,
-			u32 *if_props_1, u32 *if_props_2)
-{
-	ffa_value_t id;
-
-	if (!ARM_SMCCC_IS_FAST_CALL(func_feat_id) && input_props) {
-		pr_err("%s: Invalid Parameters: %x, %x", __func__,
-		       func_feat_id, input_props);
-		return ffa_to_linux_errno(FFA_RET_INVALID_PARAMETERS);
-	}
-
-	invoke_ffa_fn((ffa_value_t){
-		.a0 =3D FFA_FEATURES, .a1 =3D func_feat_id, .a2 =3D input_props,
-		}, &id);
-
-	if (id.a0 =3D=3D FFA_ERROR)
-		return ffa_to_linux_errno((int)id.a2);
-
-	if (if_props_1)
-		*if_props_1 =3D id.a2;
-	if (if_props_2)
-		*if_props_2 =3D id.a3;
-
-	return 0;
-}
-
 static int ffa_notification_bitmap_create(void)
 {
 	ffa_value_t ret;

--=20
2.46.0


--===============0592972101906789571==--

