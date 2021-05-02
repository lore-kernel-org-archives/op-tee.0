From: Sasha Levin <sashal@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH AUTOSEL 4.14 09/16] tee: optee: do not check memref size on
 return from Secure World
Date: Sun, 02 May 2021 10:05:37 -0400
Message-ID: <20210502140544.2720138-9-sashal@kernel.org>
In-Reply-To: <20210502140544.2720138-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4875239607424089831=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4875239607424089831==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Jerome Forissier <jerome@forissier.org>

[ Upstream commit c650b8dc7a7910eb25af0aac1720f778b29e679d ]

When Secure World returns, it may have changed the size attribute of the
memory references passed as [in/out] parameters. The GlobalPlatform TEE
Internal Core API specification does not restrict the values that this
size can take. In particular, Secure World may increase the value to be
larger than the size of the input buffer to indicate that it needs more.

Therefore, the size check in optee_from_msg_param() is incorrect and
needs to be removed. This fixes a number of failed test cases in the
GlobalPlatform TEE Initial Configuratiom Test Suite v2_0_0_0-2017_06_09
when OP-TEE is compiled without dynamic shared memory support
(CFG_CORE_DYN_SHM=3Dn).

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jerome Forissier <jerome@forissier.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 834884c370c5..63187b07dde0 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -86,16 +86,6 @@ int optee_from_msg_param(struct tee_param *params, size_t =
num_params,
 				return rc;
 			p->u.memref.shm_offs =3D mp->u.tmem.buf_ptr - pa;
 			p->u.memref.shm =3D shm;
-
-			/* Check that the memref is covered by the shm object */
-			if (p->u.memref.size) {
-				size_t o =3D p->u.memref.shm_offs +
-					   p->u.memref.size - 1;
-
-				rc =3D tee_shm_get_pa(shm, o, NULL);
-				if (rc)
-					return rc;
-			}
 			break;
 		default:
 			return -EINVAL;
--=20
2.30.2


--===============4875239607424089831==--

