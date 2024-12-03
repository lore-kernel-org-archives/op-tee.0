From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 04/10] firmware: qcom: scm: add support for object invocation
Date: Mon, 02 Dec 2024 20:19:20 -0800
Message-ID: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-4-f502ef01e016@quicinc.com>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?0-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9084891643239618922=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9084891643239618922==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
the secure world, accessed via objects. A QTEE client can invoke these
objects to request services. Similarly, QTEE can request services from
the nonsecure world using objects exported to the secure world.

This introduces low-level primitives to facilitate the invocation of
objects hosted in QTEE, as well as those hosted in the nonsecure world.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 60 ++++++++++++++++++++++++++++++++=
++
 drivers/firmware/qcom/qcom_scm.h       |  7 ++++
 include/linux/firmware/qcom/qcom_scm.h |  9 +++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_sc=
m.c
index 72bf87ddcd96..8ac570df192b 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1862,6 +1862,66 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
=20
 #endif /* CONFIG_QCOM_QSEECOM */
=20
+#ifdef CONFIG_QCOMTEE
+
+int qcom_scm_qtee_invoke_smc(u64 inbuf, u64 inbuf_size, u64 outbuf, u64 outb=
uf_size,
+			     u64 *result, u64 *response_type, u64 *data)
+{
+	struct qcom_scm_desc desc =3D {
+		.svc =3D QCOM_SCM_SVC_SMCINVOKE,
+		.cmd =3D QCOM_SCM_SMCINVOKE_INVOKE,
+		.owner =3D ARM_SMCCC_OWNER_TRUSTED_OS,
+		.args[0] =3D inbuf,
+		.args[1] =3D inbuf_size,
+		.args[2] =3D outbuf,
+		.args[3] =3D outbuf_size,
+		.arginfo =3D QCOM_SCM_ARGS(4, QCOM_SCM_RW, QCOM_SCM_VAL, QCOM_SCM_RW, QCOM=
_SCM_VAL),
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret =3D qcom_scm_call(__scm->dev, &desc, &res);
+	if (ret)
+		return ret;
+
+	*response_type =3D res.result[0];
+	*result =3D res.result[1];
+	if (data)
+		*data =3D res.result[2];
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_scm_qtee_invoke_smc);
+
+int qcom_scm_qtee_callback_response(u64 buf, u64 buf_size, u64 *result, u64 =
*response_type,
+				    u64 *data)
+{
+	struct qcom_scm_desc desc =3D {
+		.svc =3D QCOM_SCM_SVC_SMCINVOKE,
+		.cmd =3D QCOM_SCM_SMCINVOKE_CB_RSP,
+		.owner =3D ARM_SMCCC_OWNER_TRUSTED_OS,
+		.args[0] =3D buf,
+		.args[1] =3D buf_size,
+		.arginfo =3D QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
+	};
+	struct qcom_scm_res res;
+	int ret;
+
+	ret =3D qcom_scm_call(__scm->dev, &desc, &res);
+	if (ret)
+		return ret;
+
+	*response_type =3D res.result[0];
+	*result =3D res.result[1];
+	if (data)
+		*data =3D res.result[2];
+
+	return 0;
+}
+EXPORT_SYMBOL(qcom_scm_qtee_callback_response);
+
+#endif /* CONFIG_QCOMTEE */
+
 /**
  * qcom_scm_is_available() - Checks if SCM is available
  */
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_sc=
m.h
index e36b2f67607f..6b6bdee39236 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -148,6 +148,13 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_SVC_GPU			0x28
 #define QCOM_SCM_SVC_GPU_INIT_REGS		0x01
=20
+/* ARM_SMCCC_OWNER_TRUSTED_OS calls */
+
+#define QCOM_SCM_SVC_SMCINVOKE			0x06
+#define QCOM_SCM_SMCINVOKE_INVOKE_LEGACY	0x00
+#define QCOM_SCM_SMCINVOKE_CB_RSP		0x01
+#define QCOM_SCM_SMCINVOKE_INVOKE		0x02
+
 /* common error codes */
 #define QCOM_SCM_V2_EBUSY	-12
 #define QCOM_SCM_ENOMEM		-5
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/=
qcom/qcom_scm.h
index 4621aec0328c..2e2a6abf9e34 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -168,4 +168,13 @@ static inline int qcom_scm_qseecom_app_send(u32 app_id,
=20
 #endif /* CONFIG_QCOM_QSEECOM */
=20
+#ifdef CONFIG_QCOMTEE
+
+int qcom_scm_qtee_invoke_smc(u64 inbuf, u64 inbuf_size, u64 outbuf, u64 outb=
uf_size,
+			     u64 *result, u64 *response_type, u64 *data);
+int qcom_scm_qtee_callback_response(u64 buf, u64 buf_size, u64 *result, u64 =
*response_type,
+				    u64 *data);
+
+#endif /* CONFIG_QCOMTEE */
+
 #endif

--=20
2.34.1


--===============9084891643239618922==--

