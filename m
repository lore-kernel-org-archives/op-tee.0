From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v2 1/2] optee: immediately free buffers that are released by OP-TEE
Date: Fri, 19 Jun 2020 22:33:59 +0000
Message-ID: <20200619223332.438344-2-volodymyr_babchuk@epam.com>
In-Reply-To: <20200619223332.438344-1-volodymyr_babchuk@epam.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4501884302531720587=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4501884302531720587==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Normal World can share buffer with OP-TEE for two reasons:
1. Some client application wants to exchange data with TA
2. OP-TEE asks for shared buffer for internal needs

The second case was handle more strictly than necessary:

1. In RPC request OP-TEE asks for buffer
2. NW allocates buffer and provides it via RPC response
3. Xen pins pages and translates data
4. Xen provides buffer to OP-TEE
5. OP-TEE uses it
6. OP-TEE sends request to free the buffer
7. NW frees the buffer and sends the RPC response
8. Xen unpins pages and forgets about the buffer

The problem is that Xen should forget about buffer in between stages 6
and 7. I.e. the right flow should be like this:

6. OP-TEE sends request to free the buffer
7. Xen unpins pages and forgets about the buffer
8. NW frees the buffer and sends the RPC response

This is because OP-TEE internally frees the buffer before sending the
"free SHM buffer" request. So we have no reason to hold reference for
this buffer anymore. Moreover, in multiprocessor systems NW have time
to reuse buffer cookie for another buffer. Xen complained about this
and denied the new buffer registration. I have seen this issue while
running tests on iMX SoC.

So, this patch basically corrects that behavior by freeing the buffer
earlier, when handling RPC return from OP-TEE.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

Changes from v1:
 - reworded the comments
 - added WARN() for a case when OP-TEE wants to release not the
   buffer it requeset to allocate durint this call

---
 xen/arch/arm/tee/optee.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/xen/arch/arm/tee/optee.c b/xen/arch/arm/tee/optee.c
index 6a035355db..6963238056 100644
--- a/xen/arch/arm/tee/optee.c
+++ b/xen/arch/arm/tee/optee.c
@@ -1099,6 +1099,34 @@ static int handle_rpc_return(struct optee_domain *ctx,
         if ( shm_rpc->xen_arg->cmd =3D=3D OPTEE_RPC_CMD_SHM_ALLOC )
             call->rpc_buffer_type =3D shm_rpc->xen_arg->params[0].u.value.a;
=20
+        /*
+         * OP-TEE is signalling that it has freed the buffer that it
+         * requested before. This is the right time for us to do the
+         * same.
+         */
+        if ( shm_rpc->xen_arg->cmd =3D=3D OPTEE_RPC_CMD_SHM_FREE )
+        {
+            uint64_t cookie =3D shm_rpc->xen_arg->params[0].u.value.b;
+
+            free_optee_shm_buf(ctx, cookie);
+
+            /*
+             * OP-TEE asks to free buffer, but this is not the same
+             * buffer we previously allocated for it. While nothing
+             * prevents OP-TEE from asking this, it is the strange
+             * situation. This may or may not be caused by a bug in
+             * OP-TEE or mediator. But is better to print warning.
+             */
+            if ( call->rpc_data_cookie && call->rpc_data_cookie !=3D cookie )
+            {
+                gprintk(XENLOG_ERR,
+                        "Saved RPC cookie does not corresponds to OP-TEE's (=
%"PRIx64" !=3D %"PRIx64")\n",
+                        call->rpc_data_cookie, cookie);
+
+                WARN();
+            }
+            call->rpc_data_cookie =3D 0;
+        }
         unmap_domain_page(shm_rpc->xen_arg);
     }
=20
@@ -1464,10 +1492,6 @@ static void handle_rpc_cmd(struct optee_domain *ctx, s=
truct cpu_user_regs *regs,
             }
             break;
         case OPTEE_RPC_CMD_SHM_FREE:
-            free_optee_shm_buf(ctx, shm_rpc->xen_arg->params[0].u.value.b);
-            if ( call->rpc_data_cookie =3D=3D
-                 shm_rpc->xen_arg->params[0].u.value.b )
-                call->rpc_data_cookie =3D 0;
             break;
         default:
             break;
--=20
2.26.2

--===============4501884302531720587==--

