From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: client UUID: Skip REE kernel login method as well
Date: Thu, 17 Sep 2020 19:10:22 +0530
Message-ID: <1600350022-4554-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6432775316376562243=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6432775316376562243==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Since the addition of session's client UUID generation via commit [1],
login via REE kernel method was disallowed. So fix that via passing
nill UUID in case of TEE_IOCTL_LOGIN_REE_KERNEL method as well.

Fixes: e33bcbab16d1 ("tee: add support for session's client UUID generation")=
 [1]
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 64637e0..2f6199e 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -200,7 +200,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connec=
tion_method,
 	int name_len;
 	int rc;
=20
-	if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC) {
+	if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC ||
+	    connection_method =3D=3D TEE_IOCTL_LOGIN_REE_KERNEL) {
 		/* Nil UUID to be passed to TEE environment */
 		uuid_copy(uuid, &uuid_null);
 		return 0;
--=20
2.7.4


--===============6432775316376562243==--

