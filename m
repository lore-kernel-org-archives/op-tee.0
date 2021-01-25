From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: remove need_resched() before cond_resched()
Date: Mon, 25 Jan 2021 10:54:45 +0100
Message-ID: <20210125095445.1524477-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5056008755515610529=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5056008755515610529==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Testing need_resched() before cond_resched() is not needed as an
equivalent test is done internally in cond_resched(). So drop the
need_resched() test.

Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 780d7c4fd756..7a77e375b503 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -149,8 +149,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_=
addr_t parg)
 			 */
 			optee_cq_wait_for_completion(&optee->call_queue, &w);
 		} else if (OPTEE_SMC_RETURN_IS_RPC(res.a0)) {
-			if (need_resched())
-				cond_resched();
+			cond_resched();
 			param.a0 =3D res.a0;
 			param.a1 =3D res.a1;
 			param.a2 =3D res.a2;
--=20
2.25.1


--===============5056008755515610529==--

