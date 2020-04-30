From: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
To: op-tee@lists.trustedfirmware.org
Subject: [op-tee] [PATCH v2 2/3] tee: optee: Add support for session login
 client UUID generation
Date: Thu, 30 Apr 2020 15:37:10 +0300
Message-ID: <20200430123711.20083-3-vesa.jaaskelainen@vaisala.com>
In-Reply-To: <20200430123711.20083-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5344226273160403588=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5344226273160403588==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Adds support for client UUID generation for OP-TEE. For group based session
logins membership is verified.

Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
---
 drivers/tee/optee/call.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index cf2367ba08d6..dbed3f480dc0 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -233,9 +233,13 @@ int optee_open_session(struct tee_context *ctx,
 	msg_arg->params[1].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT |
 				  OPTEE_MSG_ATTR_META;
 	memcpy(&msg_arg->params[0].u.value, arg->uuid, sizeof(arg->uuid));
-	memcpy(&msg_arg->params[1].u.value, arg->uuid, sizeof(arg->clnt_uuid));
 	msg_arg->params[1].u.value.c = arg->clnt_login;
 
+	rc = tee_session_calc_client_uuid((uuid_t *)&msg_arg->params[1].u.value,
+					  arg->clnt_login, arg->clnt_uuid);
+	if (rc)
+		goto out;
+
 	rc = optee_to_msg_param(msg_arg->params + 2, arg->num_params, param);
 	if (rc)
 		goto out;
-- 
2.17.1


--===============5344226273160403588==--

