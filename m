From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v2 04/10] firmware: arm_ffa: Add support for querying FF-A features
Date: Fri, 02 Sep 2022 13:40:26 +0100
Message-ID: <20220902124032.788488-5-sudeep.holla@arm.com>
In-Reply-To: <20220902124032.788488-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7572184767138354248=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7572184767138354248==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add support for FFA_FEATURES to discover properties supported at the
FF-A interface. This interface can be used to query:
 - If an FF-A interface is implemented by the component at the higher EL,
 - If an implemented FF-A interface also implements any optional features
   described in its interface definition, and
 - Any implementation details exported by an implemented FF-A interface
   as described in its interface definition.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index 04e7cbb1b9aa..81b8d578b6ea 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -571,6 +571,32 @@ static int ffa_memory_reclaim(u64 g_handle, u32 flags)
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
 static u32 ffa_api_version_get(void)
 {
 	return drv_info->version;
--=20
2.37.3


--===============7572184767138354248==--

