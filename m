Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6CD606A323
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=GpVNJhYq;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXmwuQBS
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CABED50351
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795610398;
	bh=WepR+0nm3rDqx3eeqa4PKQCb+8N8m6J847jcMAulowI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GpVNJhYq1zQ1eWsDvRerLYTCrl3Eo0heWtD4S6fmt54A6cBH098ri2zHNZumyMN/W
	 foBdFQeNVODb0VbPuAGVx+2EZHh9ppFSIXCtVM9XOLpBbXPxI5F/BMMcEebjV5IjoD
	 5dBt0aPCMV9wzhDPrETyYD88Z1giXo6IzWEGDBTj7yvAK1WUjuVyMoJJEEM8wuRFqp
	 RsypoBuNnp5Xs8hKGijOmDlPkUHnfYjIQgtYoY3EWeX9xlV2dmW8IPL7d7gg0dmc/i
	 aqanT2DzM8cA6LS+mRxT/Nh7rliagmVH/y4cDiCiJrrhtM8fm+3kEE97SRkViXyF1Z
	 UZaAtlwHB0wpQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C86D544A49
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Nov 2026 12:39:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXmwuQBS;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2DDDD62996;
	Wed, 25 Nov 2026 12:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725171F000E0;
	Wed, 25 Nov 2026 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795610392;
	bh=2v4kT1AjLAqY+oIpqHS6C0TsmJDIe6D9ZCqiQcxALIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QXmwuQBSudRywx9x+dvcelQZLsBV192pHfzQvrGK3aZx6FIlBs8i+7B1pMjPhRD6t
	 ooDNQOyVRD8AFUd/XFViiigwMszDIIqZ0dibMNfuhyIv+WvCvmQdBYwdoYFNDqaLmO
	 MRYyHoFhSo1ehQT1quxXmp30wHhC3BrzlNe+o9SsbOroItF83KDANnpB5E5SIk3P76
	 sp+m85zrcMCRmNFxSK2YCAgu3SXEnkOHbh1gMiHKLE/ar2EpMOyD2d0dxtef48cOYH
	 lAtS016JQ33S57/d1oze5oav9fE/TLF7mQJxBRzYkJchFQVW8i/Ki/cnLB89T+VUbt
	 son7YjIjjN5Xw==
Date: Wed, 25 Nov 2026 18:09:44 +0530
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v6 5/7] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
Message-ID: <awbXEEw-Tk6LP2JB@sumit-xelite>
References: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
 <20261105-qcom_uefisecapp_migrate_qcomtee-v6-5-c7d68ce05c51@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-5-c7d68ce05c51@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C86D544A49
X-Spamd-Bar: ---------
Message-ID-Hash: KJWFJLV4TGNKTZOAUULYRSR3ZYR2ECAW
X-Message-ID-Hash: KJWFJLV4TGNKTZOAUULYRSR3ZYR2ECAW
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KJWFJLV4TGNKTZOAUULYRSR3ZYR2ECAW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026 at 16:44:53 +0530, Harshal Dev wrote:
>QTEE exposes certain secure services implemented either within the QTEE
>kernel or via pre-loaded Trusted Applications (TAs). Such always-available
>services can be readily accessed by TEE client drivers via QTEE's
>object-IPC protocol if the service is registered as a device on the TEE
>bus.
>
>One such service is the EFI-variables service, implemented by the
>uefisecapp TA which enables kernel clients to access EFI variables at
>runtime.
>
>Maintain a static list of such always-available secure services and add
>support for the QCOMTEE driver to register these services as devices on
>the TEE bus during probe.
>
>Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd
>Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>---
> drivers/tee/qcomtee/call.c           | 160 ++++++++++++++++++++++++++++++++++-
> drivers/tee/qcomtee/core.c           |  10 ++-
> drivers/tee/qcomtee/qcomtee.h        |  10 +++
> drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
> drivers/tee/qcomtee/qcomtee_object.h |   3 +-
> 5 files changed, 177 insertions(+), 7 deletions(-)
>

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>index c97afaa1b4aa..96badaf98795 100644
>--- a/drivers/tee/qcomtee/call.c
>+++ b/drivers/tee/qcomtee/call.c
>@@ -676,9 +676,13 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>
> 	/* Get ''FeatureVersions Service'' object. */
> 	service = qcomtee_object_get_service(oic, client_env,
>-					     QCOMTEE_FEATURE_VER_UID);
>-	if (service == NULL_QCOMTEE_OBJECT)
>+					     QCOMTEE_FEATURE_VER_UID,
>+					     &result);
>+	if (service == NULL_QCOMTEE_OBJECT) {
>+		if (result)
>+			pr_err("FeatureVersions Service unavailable (%d)\n", result);
> 		goto out_failed;
>+	}
>
> 	/* IB: Feature to query. */
> 	u[0].b.addr = &id;
>@@ -698,6 +702,155 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
> 	qcomtee_object_put(client_env);
> }
>
>+/**
>+ * is_qcomtee_service_available() - Check if the QTEE service identified by the UID
>+ * is available.
>+ * @oic: context to use for the current invocation.
>+ * @client_env: Client environment object.
>+ * @service_name: Name of the QTEE service.
>+ * @uid: 32-bit UID of the service.
>+ *
>+ * Returns true if the service exists and is available.
>+ * Returns false if a service is not exposed by QTEE.
>+ */
>+static bool is_qcomtee_service_available(struct qcomtee_object_invoke_ctx *oic,
>+					 struct qcomtee_object *client_env,
>+					 const char *service_name, u32 uid)
>+{
>+	struct qcomtee_object *service;
>+	int error;
>+	bool ret = false;
>+
>+	/* Get service object corresponding to the uid. */
>+	service = qcomtee_object_get_service(oic, client_env, uid, &error);
>+	if (service != NULL_QCOMTEE_OBJECT) {
>+		qcomtee_object_put(service);
>+		ret = true;
>+	}
>+
>+	/* When we fail to get the service, QTEE provides the reason. */
>+	if (error)
>+		pr_debug("%s is unavailable (%d)\n", service_name, error);
>+
>+	return ret;
>+}
>+
>+/*
>+ * QTEE Service UUID name space identifier
>+ *
>+ * A random UUID that is allocated as a name space identifier for forming UUID's
>+ * representing secure services exposed by QTEE.
>+ */
>+static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
>+						     0x93, 0x4e, 0xa2, 0xf2,
>+						     0x0a, 0xba, 0x98, 0x42);
>+
>+static const struct qtee_service qtee_services[] = {
>+	{ "qcom.tz.uefisecapp",
>+	   QCOMTEE_UEFI_SEC_UID }
>+};
>+
>+static void qtee_release_service(struct device *dev)
>+{
>+	struct tee_client_device *qtee_service = to_tee_client_device(dev);
>+
>+	kfree(qtee_service);
>+}
>+
>+/**
>+ * qtee_register_service() - Register a given QTEE service on the TEE bus as a
>+ * TEE client device.
>+ * @oic: context to use for the current invocation.
>+ * @client_env: Client environment object.
>+ * @service_name: Name of the QTEE service to be enumerated.
>+ * @uid: 32-bit UID used by QTEE to identify the service.
>+ *
>+ * Returns 0 on success and < 0 on failure.
>+ */
>+static int qtee_register_service(struct qcomtee_object_invoke_ctx *oic,
>+				 struct qcomtee_object *client_env,
>+				 const char *service_name,
>+				 const u32 uid)
>+{
>+	struct tee_client_device *qtee_service;
>+	uuid_t service_uuid;
>+	int rc;
>+
>+	if (!is_qcomtee_service_available(oic, client_env, service_name, uid))
>+		return -EOPNOTSUPP;
>+
>+	tee_generate_uuid_v5(&service_uuid, &qtee_service_uuid_ns, service_name,
>+			     strlen(service_name));
>+
>+	qtee_service = kzalloc_obj(*qtee_service);
>+	if (!qtee_service)
>+		return -ENOMEM;
>+
>+	qtee_service->dev.bus = &tee_bus_type;
>+	qtee_service->dev.release = qtee_release_service;
>+	if (dev_set_name(&qtee_service->dev, "qtee-svc-%pUb", &service_uuid)) {
>+		kfree(qtee_service);
>+		return -ENOMEM;
>+	}
>+	uuid_copy(&qtee_service->id.uuid, &service_uuid);
>+
>+	rc = device_register(&qtee_service->dev);
>+	if (rc) {
>+		pr_err("QTEE service registration failed, err: %d\n", rc);
>+		put_device(&qtee_service->dev);
>+		return rc;
>+	}
>+
>+	return 0;
>+}
>+
>+/**
>+ * qtee_register_services() - Register the secure services exposed by QTEE
>+ * as mentioned in 'qtee_services' list.
>+ * @ctx: TEE context.
>+ *
>+ * Not all versions of QTEE support a given service. Hence, we try to
>+ * enumerate as many services from the 'qtee_services' list as possible.
>+ * Not being able to enumerate a service shouldn't cause the driver probe
>+ * to fail since none of the services in the list are mandatory for
>+ * establishing communication with QTEE.
>+ */
>+static void qtee_register_services(struct tee_context *ctx)
>+{
>+	u32 idx;
>+	struct qcomtee_object *client_env;
>+
>+	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
>+		qcomtee_object_invoke_ctx_alloc(ctx, true);
>+	if (!oic)
>+		return;
>+
>+	client_env = qcomtee_object_get_client_env(oic);
>+	if (client_env == NULL_QCOMTEE_OBJECT)
>+		return;
>+
>+	for (idx = 0; idx < ARRAY_SIZE(qtee_services); idx++)
>+		qtee_register_service(oic, client_env,
>+				      qtee_services[idx].name,
>+				      qtee_services[idx].uid);
>+
>+	qcomtee_object_put(client_env);
>+}
>+
>+static int qtee_unregister_service(struct device *dev, void *data)
>+{
>+	if (!strncmp(dev_name(dev), "qtee-svc", strlen("qtee-svc")))
>+		device_unregister(dev);
>+
>+	return 0;
>+}
>+
>+static void qtee_unregister_services(void)
>+{
>+	bus_for_each_dev(&tee_bus_type, NULL, NULL,
>+			 qtee_unregister_service);
>+}
>+
> static const struct tee_driver_ops qcomtee_ops = {
> 	.get_version = qcomtee_get_version,
> 	.open = qcomtee_open,
>@@ -779,6 +932,8 @@ static int qcomtee_probe(struct platform_device *pdev)
> 		QTEE_VERSION_GET_MINOR(qcomtee->qtee_version),
> 		QTEE_VERSION_GET_PATCH(qcomtee->qtee_version));
>
>+	qtee_register_services(qcomtee->ctx);
>+
> 	return 0;
>
> err_dest_wq:
>@@ -808,6 +963,7 @@ static void qcomtee_remove(struct platform_device *pdev)
> {
> 	struct qcomtee *qcomtee = platform_get_drvdata(pdev);
>
>+	qtee_unregister_services();
> 	teedev_close_context(qcomtee->ctx);
> 	/* Wait for RELEASE operations to be processed for QTEE objects. */
> 	tee_device_unregister(qcomtee->teedev);
>diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
>index 60fe3b5776e3..737d1d9ca18d 100644
>--- a/drivers/tee/qcomtee/core.c
>+++ b/drivers/tee/qcomtee/core.c
>@@ -898,19 +898,21 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic)
>
> struct qcomtee_object *
> qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
>-			   struct qcomtee_object *client_env, u32 uid)
>+			   struct qcomtee_object *client_env, u32 uid,
>+			   int *result)
> {
> 	struct qcomtee_arg u[3] = { 0 };
>-	int ret, result;
>+	int ret;
>+	*result = 0;
>
> 	u[0].b.addr = &uid;
> 	u[0].b.size = sizeof(uid);
> 	u[0].type = QCOMTEE_ARG_TYPE_IB;
> 	u[1].type = QCOMTEE_ARG_TYPE_OO;
> 	ret = qcomtee_object_do_invoke(oic, client_env, QCOMTEE_CLIENT_ENV_OPEN,
>-				       u, &result);
>+				       u, result);
>
>-	if (ret || result)
>+	if (ret || *result)
> 		return NULL_QCOMTEE_OBJECT;
>
> 	return u[1].o;
>diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
>index f39bf63fd1c2..b1fe1d317150 100644
>--- a/drivers/tee/qcomtee/qcomtee.h
>+++ b/drivers/tee/qcomtee/qcomtee.h
>@@ -39,6 +39,16 @@ struct qcomtee {
> 	u32 qtee_version;
> };
>
>+/**
>+ * struct qtee_service - A secure service exposed by QTEE identified by a 32-bit UID.
>+ * @name: Name of the QTEE service.
>+ * @uid: 32-bit UID used by QTEE to identify the service.
>+ */
>+struct qtee_service {
>+	const char *name;
>+	const u32 uid;
>+};
>+
> void qcomtee_fetch_async_reqs(struct qcomtee_object_invoke_ctx *oic);
> struct qcomtee_object *qcomtee_idx_erase(struct qcomtee_object_invoke_ctx *oic,
> 					 u32 idx);
>diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
>index 5d7b21fdd368..9278a361dc70 100644
>--- a/drivers/tee/qcomtee/qcomtee_msg.h
>+++ b/drivers/tee/qcomtee/qcomtee_msg.h
>@@ -105,6 +105,7 @@ union qcomtee_msg_arg {
> #define QTEE_VERSION_GET_MINOR(x) (((x) >> 12) & 0xffU)
> #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
>
>+#define QCOMTEE_UEFI_SEC_UID            413
> /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
>
> /* The message contains a callback request. */
>diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
>index a241ab657318..e2f2508aad8f 100644
>--- a/drivers/tee/qcomtee/qcomtee_object.h
>+++ b/drivers/tee/qcomtee/qcomtee_object.h
>@@ -317,6 +317,7 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic);
>
> struct qcomtee_object *
> qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
>-			   struct qcomtee_object *client_env, u32 uid);
>+			   struct qcomtee_object *client_env, u32 uid,
>+			   int *result);
>
> #endif /* QCOMTEE_OBJECT_H */
>
>-- 
>2.34.1
>
