From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: ffa: Fix missing-field-initializers warning
Date: Thu, 27 Jun 2024 13:11:17 +0800
Message-ID: <20240627051125.24084-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7604926058593477585=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7604926058593477585==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The 'missing-field-initializers' warning was reported
when building with W=3D2.
This patch ensures that the remaining fields of
'ffa_send_direct_data' are zero-initialized.

Signed-off-by: ming-jen.chang <ming-jen.chang@mediatek.com>
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/tee/optee/ffa_abi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 3235e1c719e8..1aa995752682 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -660,7 +660,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device=
 *ffa_dev,
 					const struct ffa_ops *ops)
 {
 	const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;
-	struct ffa_send_direct_data data =3D { OPTEE_FFA_GET_API_VERSION };
+	struct ffa_send_direct_data data =3D { OPTEE_FFA_GET_API_VERSION, 0, 0, 0, =
0 };
 	int rc;
=20
 	msg_ops->mode_32bit_set(ffa_dev);
@@ -677,7 +677,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device=
 *ffa_dev,
 		return false;
 	}
=20
-	data =3D (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION };
+	data =3D (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION, 0, 0, 0, =
0 };
 	rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d\n", rc);
@@ -698,7 +698,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ff=
a_dev,
 				    unsigned int *rpc_param_count,
 				    unsigned int *max_notif_value)
 {
-	struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABILITIES };
+	struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABILITIES, 0, =
0, 0, 0 };
 	int rc;
=20
 	rc =3D ops->msg_ops->sync_send_receive(ffa_dev, &data);
--=20
2.18.0


--===============7604926058593477585==--

