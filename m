From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH] tee: optee: do not check memref size on return from Secure World
Date: Thu, 13 Jan 2022 16:27:13 +0100
Message-ID: <a4e48364368cce3c91005a3bd4fdacee086ef00d.1642087405.git.jerome@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3201947636895950037=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3201947636895950037==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Commit c650b8dc7a79 ("tee: optee: do not check memref size on return
from Secure World") was mistakenly lost in commit 4602c5842f64 ("optee:
refactor driver with internal callbacks"). Remove the unwanted code
again.

Fixes: 4602c5842f64 ("optee: refactor driver with internal callbacks")
Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 drivers/tee/optee/smc_abi.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index cf2e3293567d..09e7ec673bb6 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -71,16 +71,6 @@ static int from_msg_param_tmp_mem(struct tee_param *p, u32=
 attr,
 	p->u.memref.shm_offs =3D mp->u.tmem.buf_ptr - pa;
 	p->u.memref.shm =3D shm;
=20
-	/* Check that the memref is covered by the shm object */
-	if (p->u.memref.size) {
-		size_t o =3D p->u.memref.shm_offs +
-			   p->u.memref.size - 1;
-
-		rc =3D tee_shm_get_pa(shm, o, NULL);
-		if (rc)
-			return rc;
-	}
-
 	return 0;
 }
=20
--=20
2.32.0


--===============3201947636895950037==--

