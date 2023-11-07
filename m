From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 2/2] optee: ffa_abi: add asynchronous notifications
Date: Tue, 07 Nov 2023 17:06:57 +0100
Message-ID: <20231107160657.3798803-3-jens.wiklander@linaro.org>
In-Reply-To: <20231107160657.3798803-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7654914153215586922=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7654914153215586922==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Adds support for asynchronous notifications from OP-TEE in secure world
when communicating via FF-A. In principle from OP-TEE and kernel driver
point of view this works in the same way as for the SMC ABI based
implementation.

The OP-TEE FF-A ABI is expanded in OPTEE_FFA_EXCHANGE_CAPABILITIES with
the capability OPTEE_FFA_SEC_CAP_ASYNC_NOTIF to indicate that OP-TEE
supports asynchronous notifications. OPTEE_FFA_ENABLE_ASYNC_NOTIF is
also added to tell that the driver has successfully initialized these
notifications.

Notification capability is negotiated while the driver is initialized.
If both sides supports these notifications then they are enabled.

The notification concept in this driver is merged with the FF-A concept,
the lower 64 values are reserved for FF-A as asynchronous notifications
while the synchronous notifications use the higher values.

So a FF-A notification has to be allocated for each discrete
asynchronous notification value needed. Only one asynchronous
notification value is used at the moment, the "do bottom half"
notification.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/ffa_abi.c       | 93 ++++++++++++++++++++++++++++++-
 drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
 drivers/tee/optee/optee_private.h |  4 +-
 3 files changed, 117 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 0828240f27e6..60823b41b9ad 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2021, Linaro Limited
+ * Copyright (c) 2021, 2023 Linaro Limited
  */
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -692,7 +692,8 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device=
 *ffa_dev,
 static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 				    const struct ffa_ops *ops,
 				    u32 *sec_caps,
-				    unsigned int *rpc_param_count)
+				    unsigned int *rpc_param_count,
+				    unsigned int *max_notif_value)
 {
 	struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABILITIES };
 	int rc;
@@ -709,10 +710,39 @@ static bool optee_ffa_exchange_caps(struct ffa_device *=
ffa_dev,
=20
 	*rpc_param_count =3D (u8)data.data1;
 	*sec_caps =3D data.data2;
+	if (data.data3)
+		*max_notif_value =3D data.data3;
+	else
+		*max_notif_value =3D OPTEE_DEFAULT_MAX_NOTIF_VALUE;
=20
 	return true;
 }
=20
+static void notif_callback(int notify_id, void *cb_data)
+{
+	struct optee *optee =3D cb_data;
+
+	if (notify_id =3D=3D optee->ffa.bottom_half_value)
+		optee_do_bottom_half(optee->ctx);
+	else
+		optee_notif_send(optee, notify_id);
+}
+
+static int enable_async_notif(struct optee *optee)
+{
+	struct ffa_device *ffa_dev =3D optee->ffa.ffa_dev;
+	struct ffa_send_direct_data data =3D {
+		.data0 =3D OPTEE_FFA_ENABLE_ASYNC_NOTIF,
+		.data1 =3D optee->ffa.bottom_half_value,
+	};
+	int rc;
+
+	rc =3D ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &data);
+	if (rc)
+		return rc;
+	return data.data0;
+}
+
 static void optee_ffa_get_version(struct tee_device *teedev,
 				  struct tee_ioctl_version_data *vers)
 {
@@ -775,7 +805,11 @@ static const struct optee_ops optee_ffa_ops =3D {
 static void optee_ffa_remove(struct ffa_device *ffa_dev)
 {
 	struct optee *optee =3D ffa_dev_get_drvdata(ffa_dev);
+	u32 bottom_half_id =3D optee->ffa.bottom_half_value;
=20
+	if (bottom_half_id !=3D U32_MAX)
+		ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
+							      bottom_half_id);
 	optee_remove_common(optee);
=20
 	mutex_destroy(&optee->ffa.mutex);
@@ -784,9 +818,51 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
 	kfree(optee);
 }
=20
+static int optee_ffa_async_notif_init(struct ffa_device *ffa_dev,
+				      struct optee *optee)
+{
+	bool is_per_vcpu =3D false;
+	u32 notif_id =3D 0;
+	int rc;
+
+	while (true) {
+		rc =3D ffa_dev->ops->notifier_ops->notify_request(ffa_dev,
+								is_per_vcpu,
+								notif_callback,
+								optee,
+								notif_id);
+		if (!rc)
+			break;
+		/*
+		 * -EACCES means that the notification ID was
+		 * already bound, try the next one as long as we
+		 * haven't reached the max. Any other error is a
+		 * permanent error, so skip asynchronous
+		 * notifications in that case.
+		 */
+		if (rc !=3D -EACCES)
+			return rc;
+		notif_id++;
+		if (notif_id >=3D OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE)
+			return rc;
+	}
+	optee->ffa.bottom_half_value =3D notif_id;
+
+	rc =3D enable_async_notif(optee);
+	if (rc < 0) {
+		ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
+							      notif_id);
+		optee->ffa.bottom_half_value =3D U32_MAX;
+	}
+
+	return rc;
+}
+
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
+	const struct ffa_notifier_ops *notif_ops;
 	const struct ffa_ops *ffa_ops;
+	unsigned int max_notif_value;
 	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
 	struct tee_device *teedev;
@@ -797,12 +873,13 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	int rc;
=20
 	ffa_ops =3D ffa_dev->ops;
+	notif_ops =3D ffa_ops->notifier_ops;
=20
 	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
 		return -EINVAL;
=20
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
-				     &rpc_param_count))
+				     &rpc_param_count, &max_notif_value))
 		return -EINVAL;
 	if (sec_caps & OPTEE_FFA_SEC_CAP_ARG_OFFSET)
 		arg_cache_flags |=3D OPTEE_SHM_ARG_SHARED;
@@ -820,6 +897,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
=20
 	optee->ops =3D &optee_ffa_ops;
 	optee->ffa.ffa_dev =3D ffa_dev;
+	optee->ffa.bottom_half_value =3D U32_MAX;
 	optee->rpc_param_count =3D rpc_param_count;
=20
 	teedev =3D tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
@@ -864,6 +942,12 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	rc =3D optee_notif_init(optee, OPTEE_DEFAULT_MAX_NOTIF_VALUE);
 	if (rc)
 		goto err_close_ctx;
+	if (sec_caps & OPTEE_FFA_SEC_CAP_ASYNC_NOTIF) {
+		rc =3D optee_ffa_async_notif_init(ffa_dev, optee);
+		if (rc < 0)
+			pr_err("Failed to initialize async notifications: %d",
+			       rc);
+	}
=20
 	rc =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc)
@@ -874,6 +958,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
=20
 err_unregister_devices:
 	optee_unregister_devices();
+	if (optee->ffa.bottom_half_value !=3D U32_MAX)
+		notif_ops->notify_relinquish(ffa_dev,
+					     optee->ffa.bottom_half_value);
 	optee_notif_uninit(optee);
 err_close_ctx:
 	teedev_close_context(ctx);
diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
index 97266243deaa..5db779dc00de 100644
--- a/drivers/tee/optee/optee_ffa.h
+++ b/drivers/tee/optee/optee_ffa.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-2-Clause */
 /*
- * Copyright (c) 2019-2021, Linaro Limited
+ * Copyright (c) 2019-2021, 2023 Linaro Limited
  */
=20
 /*
@@ -73,7 +73,7 @@
  *
  * Call register usage:
  * w3:    Service ID, OPTEE_FFA_EXCHANGE_CAPABILITIES
- * w4-w7: Note used (MBZ)
+ * w4-w7: Not used (MBZ)
  *
  * Return register usage:
  * w3:    Error code, 0 on success
@@ -82,14 +82,16 @@
  *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
  *        Bit[31:8]: Reserved (MBZ)
  * w5:	  Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_* below,
- *	  unused bits MBZ.
- * w6-w7: Not used (MBZ)
+ * w6:	  The maximum secure world notification number
+ * w7:	  Not used (MBZ)
  */
 /*
  * Secure world supports giving an offset into the argument shared memory
  * object, see also OPTEE_FFA_YIELDING_CALL_WITH_ARG
  */
 #define OPTEE_FFA_SEC_CAP_ARG_OFFSET	BIT(0)
+/* OP-TEE supports asynchronous notification via FF-A */
+#define OPTEE_FFA_SEC_CAP_ASYNC_NOTIF	BIT(1)
=20
 #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
=20
@@ -108,6 +110,24 @@
  */
 #define OPTEE_FFA_UNREGISTER_SHM	OPTEE_FFA_BLOCKING_CALL(3)
=20
+/*
+ * Inform OP-TEE that the normal world is able to receive asynchronous
+ * notifications.
+ *
+ * Call register usage:
+ * w3:    Service ID, OPTEE_FFA_ENABLE_ASYNC_NOTIF
+ * w4:	  Notification value to request bottom half processing, should be
+ *	  less than OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE.
+ * w5-w7: Not used (MBZ)
+ *
+ * Return register usage:
+ * w3:    Error code, 0 on success
+ * w4-w7: Note used (MBZ)
+ */
+#define OPTEE_FFA_ENABLE_ASYNC_NOTIF	OPTEE_FFA_BLOCKING_CALL(5)
+
+#define OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE 64
+
 /*
  * Call with struct optee_msg_arg as argument in the supplied shared memory
  * with a zero internal offset and normal cached memory attributes.
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_priv=
ate.h
index 2165bd11e6ac..91f4ec45e388 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -129,12 +129,14 @@ struct optee_smc {
  * struct optee_ffa_data -  FFA communication struct
  * @ffa_dev		FFA device, contains the destination id, the id of
  *			OP-TEE in secure world
- * @ffa_ops		FFA operations
+ * @bottom_half_value	Notification ID used for bottom half signalling or
+ *			U32_MAX if unused
  * @mutex		Serializes access to @global_ids
  * @global_ids		FF-A shared memory global handle translation
  */
 struct optee_ffa {
 	struct ffa_device *ffa_dev;
+	u32 bottom_half_value;
 	/* Serializes access to @global_ids */
 	struct mutex mutex;
 	struct rhashtable global_ids;
--=20
2.34.1


--===============7654914153215586922==--

