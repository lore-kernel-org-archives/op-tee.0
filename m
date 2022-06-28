From: Yang Yingliang <yangyingliang@huawei.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH] optee: smc_abi.c: fix wrong pointer passed to IS_ERR/PTR_ERR()
Date: Tue, 28 Jun 2022 14:52:16 +0800
Message-ID: <20220628065216.901194-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6451149037313776529=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6451149037313776529==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It should be 'rpc_arg' pass to IS_ERR/PTR_ERR().

Fixes: ed8faf6c8f8c ("optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CA=
LL_WITH_REGD_ARG")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tee/optee/smc_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 385cb0aee610..a1c1fa1a9c28 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -884,8 +884,8 @@ static int optee_smc_do_call_with_arg(struct tee_context =
*ctx,
=20
 		rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
 		rpc_arg =3D tee_shm_get_va(shm, offs + rpc_arg_offs);
-		if (IS_ERR(arg))
-			return PTR_ERR(arg);
+		if (IS_ERR(rpc_arg))
+			return PTR_ERR(rpc_arg);
 	}
=20
 	if  (rpc_arg && tee_shm_is_dynamic(shm)) {
--=20
2.25.1


--===============6451149037313776529==--

