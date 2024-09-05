From: Dan Carpenter <dan.carpenter@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH next] optee: Fix a NULL vs IS_ERR() check
Date: Thu, 05 Sep 2024 16:17:06 +0300
Message-ID: <f8c12aed-b5d1-4522-bf95-622b8569706d@stanley.mountain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6041899589520060661=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6041899589520060661==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The tee_shm_get_va() function never returns NULL, it returns error
pointers.  Update the check to match.

Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tee/optee/rpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index a4b49fd1d46d..ebbbd42b0e3e 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -332,7 +332,7 @@ static void handle_rpc_func_rpmb_probe_next(struct tee_co=
ntext *ctx,
 	}
 	buf =3D tee_shm_get_va(params[1].u.memref.shm,
 			     params[1].u.memref.shm_offs);
-	if (!buf) {
+	if (IS_ERR(buf)) {
 		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
 		return;
 	}
--=20
2.45.2


--===============6041899589520060661==--

