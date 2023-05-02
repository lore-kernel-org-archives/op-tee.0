From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH 1/1] tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'
Date: Tue, 02 May 2023 11:54:33 +0530
Message-ID: <6a25613e87158947b4d102be4859f406edcb3f0b.1683008188.git.Rijo-john.Thomas@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0991603626518539252=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0991603626518539252==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

After TEE has completed processing of TEE_CMD_ID_LOAD_TA, set proper
value in 'return_origin' argument passed by open_session() call. To do
so, add 'return_origin' field to the structure tee_cmd_load_ta. The
Trusted OS shall update return_origin as part of TEE processing.

This change to 'struct tee_cmd_load_ta' interface requires a similar update
in AMD-TEE Trusted OS's TEE_CMD_ID_LOAD_TA interface.

This patch has been verified on Phoenix Birman setup. On older APUs,
return_origin value will be 0.

Cc: stable(a)vger.kernel.org
Tested-by: Sourabh Das <sourabh.das@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/amdtee_if.h | 10 ++++++----
 drivers/tee/amdtee/call.c      | 30 +++++++++++++++++-------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_if.h
index ff48c3e47375..e2014e21530a 100644
--- a/drivers/tee/amdtee/amdtee_if.h
+++ b/drivers/tee/amdtee/amdtee_if.h
@@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
=20
 /**
  * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
- * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
- * @hi_addr:     [in] bits [63:32] of the physical address of the TA binary
- * @size:        [in] size of TA binary in bytes
- * @ta_handle:   [out] return handle of the loaded TA
+ * @low_addr:       [in] bits [31:0] of the physical address of the TA binary
+ * @hi_addr:        [in] bits [63:32] of the physical address of the TA bina=
ry
+ * @size:           [in] size of TA binary in bytes
+ * @ta_handle:      [out] return handle of the loaded TA
+ * @return_origin:  [out] origin of return code after TEE processing
  */
 struct tee_cmd_load_ta {
 	u32 low_addr;
 	u32 hi_addr;
 	u32 size;
 	u32 ta_handle;
+	u32 return_origin;
 };
=20
 /**
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index e8cd9aaa3467..e9b63dcb3194 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct tee_ioc=
tl_open_session_arg *arg)
 	if (ret) {
 		arg->ret_origin =3D TEEC_ORIGIN_COMMS;
 		arg->ret =3D TEEC_ERROR_COMMUNICATION;
-	} else if (arg->ret =3D=3D TEEC_SUCCESS) {
-		ret =3D get_ta_refcount(load_cmd.ta_handle);
-		if (!ret) {
-			arg->ret_origin =3D TEEC_ORIGIN_COMMS;
-			arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
-
-			/* Unload the TA on error */
-			unload_cmd.ta_handle =3D load_cmd.ta_handle;
-			psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
-					    (void *)&unload_cmd,
-					    sizeof(unload_cmd), &ret);
-		} else {
-			set_session_id(load_cmd.ta_handle, 0, &arg->session);
+	} else {
+		arg->ret_origin =3D load_cmd.return_origin;
+
+		if (arg->ret =3D=3D TEEC_SUCCESS) {
+			ret =3D get_ta_refcount(load_cmd.ta_handle);
+			if (!ret) {
+				arg->ret_origin =3D TEEC_ORIGIN_COMMS;
+				arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
+
+				/* Unload the TA on error */
+				unload_cmd.ta_handle =3D load_cmd.ta_handle;
+				psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
+						    (void *)&unload_cmd,
+						    sizeof(unload_cmd), &ret);
+			} else {
+				set_session_id(load_cmd.ta_handle, 0, &arg->session);
+			}
 		}
 	}
 	mutex_unlock(&ta_refcount_mutex);
--=20
2.25.1


--===============0991603626518539252==--

