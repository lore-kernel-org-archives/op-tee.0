From: Sasha Levin <sashal@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH AUTOSEL 6.9 06/22] tee: optee: ffa: Fix
 missing-field-initializers warning
Date: Tue, 16 Jul 2024 10:24:13 -0400
Message-ID: <20240716142519.2712487-6-sashal@kernel.org>
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2114225717483498987=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2114225717483498987==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

[ Upstream commit e0556255a53d6d3d406a28362dffd972018a997c ]

The 'missing-field-initializers' warning was reported
when building with W=3D2.
This patch use designated initializers for
'struct ffa_send_direct_data' to suppress the warning
and clarify the initialization intent.

Signed-off-by: ming-jen.chang <ming-jen.chang@mediatek.com>
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/ffa_abi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index ecb5eb079408e..c5a3e25c55dab 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -660,7 +660,9 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device=
 *ffa_dev,
 					const struct ffa_ops *ops)
 {
 	const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;
-	struct ffa_send_direct_data data =3D { OPTEE_FFA_GET_API_VERSION };
+	struct ffa_send_direct_data data =3D {
+		.data0 =3D OPTEE_FFA_GET_API_VERSION,
+	};
 	int rc;
=20
 	msg_ops->mode_32bit_set(ffa_dev);
@@ -677,7 +679,9 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device=
 *ffa_dev,
 		return false;
 	}
=20
-	data =3D (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION };
+	data =3D (struct ffa_send_direct_data){
+		.data0 =3D OPTEE_FFA_GET_OS_VERSION,
+	};
 	rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d\n", rc);
@@ -698,7 +702,9 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ff=
a_dev,
 				    unsigned int *rpc_param_count,
 				    unsigned int *max_notif_value)
 {
-	struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABILITIES };
+	struct ffa_send_direct_data data =3D {
+		.data0 =3D OPTEE_FFA_EXCHANGE_CAPABILITIES,
+	};
 	int rc;
=20
 	rc =3D ops->msg_ops->sync_send_receive(ffa_dev, &data);
--=20
2.43.0


--===============2114225717483498987==--

