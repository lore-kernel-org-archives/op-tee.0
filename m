Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089A8CA5FCB
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:57:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 324DC454A4
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 12:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790859446;
	bh=9QeW6dEBGudx82hfUh4TbLd8zTwONzsf6NEHsk2aThY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xtjPbcQwsXNx4BW341t3nIt7bi7q7evZjhF3WvN3MWcVbiDBX76AZmn/lzHEDiKB8
	 1ShiT8LidW8cIxtdkjNsrR8OXWKm4UCY7OvVuOsLQ/G/xBLcmGHw1ChrWj4KUKuvDg
	 2fuZ4PFX4yVHeb3x2EqcsX1mbNRRdlT+LickdtCARN8mrxzFLcRmMz9W5WEWtt4NRy
	 +LiW54wIA22jAsHw/KZ/WhDxqbifMBzb2QSxw7HoDs8UOxjyVBFRk7+TxSiqZc/pQ0
	 dJm7XbYbWW76IflzSbffE17jb66THhUwCGYJBQzeCPXO36EyqMhKiIEq6ZTqG0xnlb
	 z46A3q/mm15Mg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8499A3E882
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 12:57:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWx0xDya;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E770C437BA;
	Thu,  1 Oct 2026 12:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A3A1F000FF;
	Thu,  1 Oct 2026 12:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859437;
	bh=xVLQUarHQJHENRprbSGIcDRrAF2ga5DsRylT2CdgwcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YWx0xDyazdEGelDTh5oqaahnEKeyy6OG7QtPiyfVCzTP6aZttFyKzZ/Wt3TDlDNfX
	 mWm+RJER+dAvO9M2vJ5BgaF025f/YtbLd1jT33ljxKRbir9Zi1Qliz3Ft3EX78EF4l
	 mOVvuWDCgqE5ubyMCsHbLZo1E8bttaHMMqxlJj1+d/tMZ/T4V9hF1QFbCf2wTEJ5ql
	 oh0/VLvDNOUVqikLAtYGCpubS4kK1/RnpDXObggU/PfpDDoC3xHZZcvnvTHi+dEfgD
	 hpJSC7h1eplpHT07PKkysoCvbgnMwKdOF3c1sFIZA+esyJL+NpYbiWMqWNA8Z5L0Ex
	 1ebB1mJ8O5peA==
Date: Thu, 1 Oct 2026 18:27:10 +0530
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/6] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
Message-ID: <ar5YpkQrkxbjVjAz@sumit-xelite>
Mail-Followup-To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
	Basant Kumar <basantk@qti.qualcomm.com>,
	Apurupa Pattapu <apurupa@qti.qualcomm.com>,
	Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
References: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
 <20261001-qcom_uefisecapp_migrate_qcomtee-v3-5-13df5c20c2e3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-5-13df5c20c2e3@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8499A3E882
X-Spamd-Bar: --------
Message-ID-Hash: DAIKQCR3OATSYB36GZB2XXEV5UOJGRHO
X-Message-ID-Hash: DAIKQCR3OATSYB36GZB2XXEV5UOJGRHO
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DAIKQCR3OATSYB36GZB2XXEV5UOJGRHO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, 01 Oct 2026 at 16:32:37 +0530, Harshal Dev wrote:
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
>Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>---
> drivers/tee/qcomtee/call.c           | 161 ++++++++++++++++++++++++++++++++++-
> drivers/tee/qcomtee/core.c           |   9 +-
> drivers/tee/qcomtee/qcomtee.h        |  12 +++
> drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
> drivers/tee/qcomtee/qcomtee_object.h |   3 +-
> 5 files changed, 179 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
>index b361d9c04de0..8fadb7b13e61 100644
>--- a/drivers/tee/qcomtee/call.c
>+++ b/drivers/tee/qcomtee/call.c
>@@ -675,9 +675,13 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
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

Do we really want to error out if a service isn't available? Is it
really the case that every QTEE firmware will implement each service?

> 		goto out_failed;
>+	}
>
> 	/* IB: Feature to query. */
> 	u[0].b.addr = &id;
>@@ -697,6 +701,156 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
> 	qcomtee_object_put(client_env);
> }
>
>+/**
>+ * is_qcomtee_service_available() - Check if the QTEE service identified by the UID
>+ * is available
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
>+	int error = 0;
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
>+		pr_err("%s is unavailable (%d)\n", service_name, error);

Ditto here, rather convert this into a debug message.

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
>+ * qtee_enumerate_service() - Enumerate a given QTEE service and register
>+ * it on the TEE bus as a TEE client device
>+ * @oic: context to use for the current invocation.
>+ * @client_env: Client environment object.
>+ * @service_name: Name of the QTEE service to be enumerated.
>+ * @uid: 32-bit UID used by QTEE to identify the service.
>+ *
>+ * Returns 0 on success and < 0 on failure.
>+ */
>+static int qtee_enumerate_service(struct qcomtee_object_invoke_ctx *oic,
>+				  struct qcomtee_object *client_env,
>+				  const char *service_name,
>+				  const u32 uid)
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
>+ * qtee_enumerate_services() - Enumerate all the secure services exposed by QTEE
>+ * from the static 'qtee_services' list and register them on the TEE bus as
>+ * TEE client devices.
>+ *
>+ * Not all versions of QTEE support a given service. Hence, we try to
>+ * enumerate as many services from the 'qtee_services' list as possible.
>+ * Not being able to enumerate a service shouldn't cause the driver probe
>+ * to fail since none of the services in the list are mandatory for
>+ * establishing communication with QTEE.
>+ * @ctx: TEE context.
>+ */
>+static void qtee_enumerate_services(struct tee_context *ctx)
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
>+		qtee_enumerate_service(oic, client_env,
>+				       qtee_services[idx].name,
>+				       qtee_services[idx].uid);
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
>@@ -778,6 +932,8 @@ static int qcomtee_probe(struct platform_device *pdev)
> 		QTEE_VERSION_GET_MINOR(qcomtee->qtee_version),
> 		QTEE_VERSION_GET_PATCH(qcomtee->qtee_version));
>
>+	qtee_enumerate_services(qcomtee->ctx);

Rather call it qtee_register_services() matching it's counterpart below.

-Sumit

>+
> 	return 0;
>
> err_dest_wq:
>@@ -807,6 +963,7 @@ static void qcomtee_remove(struct platform_device *pdev)
> {
> 	struct qcomtee *qcomtee = platform_get_drvdata(pdev);
>
>+	qtee_unregister_services();
> 	teedev_close_context(qcomtee->ctx);
> 	/* Wait for RELEASE operations to be processed for QTEE objects. */
> 	tee_device_unregister(qcomtee->teedev);
>diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
>index 60fe3b5776e3..4a523a95bf0e 100644
>--- a/drivers/tee/qcomtee/core.c
>+++ b/drivers/tee/qcomtee/core.c
>@@ -898,19 +898,20 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic)
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
>index f39bf63fd1c2..66d305a46c0a 100644
>--- a/drivers/tee/qcomtee/qcomtee.h
>+++ b/drivers/tee/qcomtee/qcomtee.h
>@@ -17,6 +17,8 @@
> #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
> #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
>
>+#define QTEE_UUID_NS_NAME_SIZE	        128
>+
> /**
>  * struct qcomtee - Main service struct.
>  * @teedev: client device.
>@@ -39,6 +41,16 @@ struct qcomtee {
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
>index d3740099fae0..901ba3565a73 100644
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
