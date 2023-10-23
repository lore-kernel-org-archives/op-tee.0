From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v1] core: tee_svc.c: allow to pass non-NULL memref of size 0
Date: Mon, 23 Oct 2023 23:39:23 +0900
Message-ID: <20231023143923.99009-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4785679410407392152=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4785679410407392152==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When calling TEE_InvokeTACommand() with a non-NULL memref of size
zero, function tee_svc_copy_param() will return
TEE_ERROR_BAD_PARAMETERS resulting in a panic later on.

In regard to the TEE_PARAM_TYPE_MEMREF_{INPUT,OUTPUT,INOUT} types, the
Global Platform specification says [1]:

  params[i].memref.size SHALL be initialized with a memory buffer that
  is accessible with the access rights described in the type. The
  buffer can be NULL, in which case size SHALL be set to 0 .

Note that the specification only specifies that NULL implies a size of
zero. The reciprocal: "a size of zero implies NULL" is undefined.

It is even more confusing considering that non-NULL buffer with a size
of zero are explicitly allowed by the client API [2]:

  This design allows a non-NULL buffer with a size of 0 bytes to allow
  trivial integration with any implementations of the C library
  malloc, in which is valid to allocate a zero byte buffer and receive
  a non-NULL pointer which may not be de-referenced in return.

This could become a pitfall if a TA forwards a memref received from
the REE to another TA.

Allow the TAs to pass non-NULL memref of size zero to other TAs
through TEE_InvokeTACommand() by changing the non-NULL pointer into a
NULL one in such a case.

[1] TEE Internal Core API Specification =E2=80=93 Public Release v1.3.1,
    =C2=A74.9.4 "Operation Parameters in the Internal Client API"
    Table 4-15: "Interpretation of params[i] on Entry to Internal Client API"

[2] TEE Client API Specification v1.0,
    =C2=A74.5.4 TEEC_RegisterSharedMemory,
    paragraph "Implementers' Notes"

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 core/tee/tee_svc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/core/tee/tee_svc.c b/core/tee/tee_svc.c
index f4158dca1..237a27de9 100644
--- a/core/tee/tee_svc.c
+++ b/core/tee/tee_svc.c
@@ -700,11 +700,13 @@ static TEE_Result tee_svc_copy_param(struct ts_session =
*sess,
 		case TEE_PARAM_TYPE_MEMREF_INOUT:
 			va =3D (void *)param->u[n].mem.offs;
 			s =3D param->u[n].mem.size;
-			if (!va) {
-				if (s)
-					return TEE_ERROR_BAD_PARAMETERS;
+			if (!s) {
+				param->u[n].mem.mobj =3D NULL;
 				break;
 			}
+			if (!va)
+				return TEE_ERROR_BAD_PARAMETERS;
+
 			/* uTA cannot expose its private memory */
 			if (vm_buf_is_inside_um_private(&utc->uctx, va, s))
 				return TEE_ERROR_BAD_PARAMETERS;
--
2.25.1

--===============4785679410407392152==--

