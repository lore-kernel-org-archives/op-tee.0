From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 2/3] optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
Date: Tue, 01 Mar 2022 20:48:29 +0100
Message-ID: <20220301194830.3557578-3-jens.wiklander@linaro.org>
In-Reply-To: <20220301194830.3557578-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0882583495345436190=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0882583495345436190==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds the secure capability OPTEE_FFA_SEC_CAP_ARG_OFFSET to indicate that
OP-TEE with FF-A can support an argument struct at a non-zero offset into
a passed shared memory object.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/ffa_abi.c   | 17 +++++++++++++++--
 drivers/tee/optee/optee_ffa.h | 12 +++++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 7686f7020616..cc863aaefcd9 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -615,12 +615,21 @@ static int optee_ffa_do_call_with_arg(struct tee_contex=
t *ctx,
 		.data0 =3D OPTEE_FFA_YIELDING_CALL_WITH_ARG,
 		.data1 =3D (u32)shm->sec_world_id,
 		.data2 =3D (u32)(shm->sec_world_id >> 32),
-		.data3 =3D shm->offset,
+		.data3 =3D 0,
 	};
 	struct optee_msg_arg *arg;
 	unsigned int rpc_arg_offs;
 	struct optee_msg_arg *rpc_arg;
=20
+	/*
+	 * The shared memory object has to start on a page when passed as
+	 * an argument struct. This is also what the shm pool allocator
+	 * returns, but check this before calling secure world to catch
+	 * eventual errors early in case something changes.
+	 */
+	if (shm->offset)
+		return -EINVAL;
+
 	arg =3D tee_shm_get_va(shm, 0);
 	if (IS_ERR(arg))
 		return PTR_ERR(arg);
@@ -678,6 +687,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device=
 *ffa_dev,
=20
 static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 				    const struct ffa_dev_ops *ops,
+				    u32 *sec_caps,
 				    unsigned int *rpc_param_count)
 {
 	struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABILITIES };
@@ -694,6 +704,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ff=
a_dev,
 	}
=20
 	*rpc_param_count =3D (u8)data.data1;
+	*sec_caps =3D data.data2;
=20
 	return true;
 }
@@ -777,6 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	struct optee *optee;
+	u32 sec_caps;
 	int rc;
=20
 	ffa_ops =3D ffa_dev_ops_get(ffa_dev);
@@ -788,7 +800,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
 		return -EINVAL;
=20
-	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
+	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
+				     &rpc_param_count))
 		return -EINVAL;
=20
 	optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
index ee3a03fc392c..97266243deaa 100644
--- a/drivers/tee/optee/optee_ffa.h
+++ b/drivers/tee/optee/optee_ffa.h
@@ -81,8 +81,16 @@
  *                   as the second MSG arg struct for
  *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
  *        Bit[31:8]: Reserved (MBZ)
- * w5-w7: Note used (MBZ)
+ * w5:	  Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_* below,
+ *	  unused bits MBZ.
+ * w6-w7: Not used (MBZ)
+ */
+/*
+ * Secure world supports giving an offset into the argument shared memory
+ * object, see also OPTEE_FFA_YIELDING_CALL_WITH_ARG
  */
+#define OPTEE_FFA_SEC_CAP_ARG_OFFSET	BIT(0)
+
 #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
=20
 /*
@@ -112,6 +120,8 @@
  *	  OPTEE_MSG_GET_ARG_SIZE(num_params) follows a struct optee_msg_arg
  *	  for RPC, this struct has reserved space for the number of RPC
  *	  parameters as returned by OPTEE_FFA_EXCHANGE_CAPABILITIES.
+ *	  MBZ unless the bit OPTEE_FFA_SEC_CAP_ARG_OFFSET is received with
+ *	  OPTEE_FFA_EXCHANGE_CAPABILITIES.
  * w7:    Not used (MBZ)
  * Resume from RPC. Register usage:
  * w3:    Service ID, OPTEE_FFA_YIELDING_CALL_RESUME
--=20
2.31.1


--===============0882583495345436190==--

