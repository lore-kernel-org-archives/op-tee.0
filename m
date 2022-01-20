From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2] optee: add error checks in optee_ffa_do_call_with_arg()
Date: Thu, 20 Jan 2022 08:42:32 +0100
Message-ID: <20220120074232.1084967-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0673878368763777270=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0673878368763777270==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds error checking in optee_ffa_do_call_with_arg() for correctness.

Fixes: 4615e5a34b95 ("optee: add FF-A support")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 20a1b1a3d965..0775759a29c0 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -619,9 +619,18 @@ static int optee_ffa_do_call_with_arg(struct tee_context=
 *ctx,
 		.data2 =3D (u32)(shm->sec_world_id >> 32),
 		.data3 =3D shm->offset,
 	};
-	struct optee_msg_arg *arg =3D tee_shm_get_va(shm, 0);
-	unsigned int rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
-	struct optee_msg_arg *rpc_arg =3D tee_shm_get_va(shm, rpc_arg_offs);
+	struct optee_msg_arg *arg;
+	unsigned int rpc_arg_offs;
+	struct optee_msg_arg *rpc_arg;
+
+	arg =3D tee_shm_get_va(shm, 0);
+	if (IS_ERR(arg))
+		return PTR_ERR(arg);
+
+	rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
+	rpc_arg =3D tee_shm_get_va(shm, rpc_arg_offs);
+	if (IS_ERR(rpc_arg))
+		return PTR_ERR(rpc_arg);
=20
 	return optee_ffa_yielding_call(ctx, &data, rpc_arg);
 }
--=20
2.31.1


--===============0673878368763777270==--

