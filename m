From: Sahil Malhotra <sahil.malhotra@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] optee: fix format string for printing optee build_id
Date: Fri, 29 Nov 2024 12:46:48 +0100
Message-ID: <20241129114648.3048941-1-sahil.malhotra@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4408217052766643006=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4408217052766643006==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

There has been a recent change in OP-TEE to print 8 and 16 character
commit id for 32bit and 64bit architecture respectively.
In case if commit id is starting with 0 like 04d1c612ec7beaede073b8c
it is printing revision as below removing leading 0
"optee: revision 4.4 (4d1c612ec7beaed)"

Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
---
 drivers/tee/optee/smc_abi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index e9456e3e74cc..eb51dc18f32d 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1272,8 +1272,9 @@ static void optee_msg_get_os_revision(optee_invoke_fn *=
invoke_fn)
 		  &res.smccc);
=20
 	if (res.result.build_id)
-		pr_info("revision %lu.%lu (%08lx)", res.result.major,
-			res.result.minor, res.result.build_id);
+		pr_info("revision %lu.%lu (%0*lx)", res.result.major,
+			res.result.minor, (int)sizeof(res.result.build_id) * 2,
+			res.result.build_id);
 	else
 		pr_info("revision %lu.%lu", res.result.major, res.result.minor);
 }
--=20
2.34.1


--===============4408217052766643006==--

