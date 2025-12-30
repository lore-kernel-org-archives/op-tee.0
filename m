Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0A0E9412E
	for <op-tee@archiver.kernel.org>; Tue, 30 Dec 2025 09:04:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3EE0243178
	for <op-tee@archiver.kernel.org>; Tue, 30 Dec 2025 09:04:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YrxStpy1;
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B11CF4184A
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Dec 2025 05:21:38 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a12ed4d205so84894005ad.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 29 Dec 2025 21:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767072098; x=1767676898; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2GsV8qUaB+Hw0Iv/qFsRwIcB+V3M/4kF9X7GuYlzgA=;
        b=YrxStpy1A1G+qW1RZYA5RtpjwkR1FDa1Cfnp25k04sijRKJd5IuJ2MumA55n57kQ5d
         51Nf5sJmmnTEM76g6vIcuF31tL1UZGr47QhjXtHA6nYhPMPFe6ed3gYd72JgTw1adGkk
         RQzykC2KuSH8LFmcZMMVOVhNrhC3NvAB9vArLL6Vepy70UqNPTtFV2LMEJ4EFpTsPfBe
         psJKCp57R0tgIhTRHAwC06qxCjfUu9/R+fKSvRC52OLBd53vV3d/ZrdTw4SoRjXvE/4H
         WtS0CruHN4fSPYpY7YFzly3JjPB8ANKhLL0ADDZOpLBWfNmLir0MX3J6gItXYYrc+L7Q
         X19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767072098; x=1767676898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2GsV8qUaB+Hw0Iv/qFsRwIcB+V3M/4kF9X7GuYlzgA=;
        b=gi+roQcBjNdlPjAgtTe/BZsKgkeIsElXVK85bK6B2ucyhgsBwUVhn3SPsS2hRmOfXH
         EeHrwX0zMBMRL9rGjC5dEGCYBVhHw8lARCLwGF/4S8HOXgJfOqCY6T3piJKB7GKUvajw
         KlvSdZSgetAbMiywZzjAJUkgXG3DqvAko2n7dYXEubtFnfD0vgmKj9oi/VZsQWAtB2QZ
         7HgSO+vZOEJyNrgrvVVrz8W+54dtw+86GWXBYnFc0lnpR90M93g14Mt+4tZGUpliZ52O
         Un8byK7IGsDX3Ro/bAiDzXzgaU0u3oI8a2Pe14fwC57YL2QFfARLehC5POwRVKgl3dgG
         lHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHWy18UVAeYHAi04cCpvgK6Aye+zXuajSc0J+qLq3ZR55XBLEbH2rXstsrdNaDwv/YORRBOfc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyp+7CyU4dViwXE1nq/nLisPjsWLPApVHtqMQEB02NJ1ttacef8
	VGOi0q1OVm3M1rRRxW0o8Gg8VkTxGE6XxIbu7uthyth6z4Zy3ihkKMgH
X-Gm-Gg: AY/fxX5VtUr/Wkx4EzSa2e8g8nzuobWmyRyTqkt8wsnoWfzJ/uQWD2diKsxF3JPJ+hz
	UXvnkjJoW2U/TM8way7PMyOqWKKi4EKZIWLXCIve0z+zSVDCYetnrEHntWXrp4VjHiJeye7tRoF
	XABCUIlqs/3mP2bDJdQTUYyB8mCj4dDW5sNRD7KTShNLf6eB/m+73Xnavgwbvf9zNUNSlg4wcF9
	F5h+XISCg7zkPaMe8iRXzKYCl3VEhgXIQriWyLpKyzmvuGizF2ZU6U0JIwXRCm45t04415pOegc
	UkYtVbFuWLHNbH6sHqCL49MIgFgFx8pH+i10o7TDG4pm2HFtolDL1jx2bHLcogg7iQ7juIdlI3H
	PDbjzw7Vr5Yf8JpR78S7Tuxx43CbmDaAqOk5vozezQUyGTsmMNWjHCFkyx0A2VqAmRmJPo0kamB
	E+Ryfx8ATkydoN2PYRqnMPbi74jkPH1gFQQ3pBhq4rtxfVdHMAXZoDHi8mV4Bu5zBT6Wq8d9gi1
	ntL+g==
X-Google-Smtp-Source: AGHT+IEOAqKC/AlDhenIiODDI1zlMXiQ7gMQsB0rlGI50DaGVoaN3bNOPsln+Vdx6c+3D/TlZzIGLQ==
X-Received: by 2002:a17:903:b0d:b0:2a0:9a07:f8be with SMTP id d9443c01a7336-2a2f232865fmr314445645ad.22.1767072097770;
        Mon, 29 Dec 2025 21:21:37 -0800 (PST)
Received: from aristo-PC.tail872496.ts.net (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66465sm291695105ad.15.2025.12.29.21.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 21:21:37 -0800 (PST)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] tee: optee: store OS revision for TEE core
Date: Tue, 30 Dec 2025 13:17:59 +0800
Message-ID: <20251230051804.6230-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230051804.6230-1-aristo.chen@canonical.com>
References: <20251226131920.64582-1-aristo.chen@canonical.com>
 <20251230051804.6230-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.214.170:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	BLOCKLISTDE_FAIL(0.00)[124.218.37.86:server fail,209.85.214.170:server fail];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.170:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B11CF4184A
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: VTT3Y2JLNXSYOKUITDVLUOYN6X5UO53X
X-Message-ID-Hash: VTT3Y2JLNXSYOKUITDVLUOYN6X5UO53X
X-Mailman-Approved-At: Tue, 30 Dec 2025 09:03:59 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VTT3Y2JLNXSYOKUITDVLUOYN6X5UO53X/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Collect OP-TEE OS revision from secure world for both SMC and FF-A ABIs,
store it in the OP-TEE driver, and expose it through the generic
get_tee_revision() callback.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 drivers/tee/optee/core.c          | 23 +++++++++++++++++++++++
 drivers/tee/optee/ffa_abi.c       | 14 ++++++++++++--
 drivers/tee/optee/optee_private.h | 19 +++++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 15 +++++++++++++--
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 5b62139714ce..2d807bc748bc 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -63,6 +63,29 @@ int optee_set_dma_mask(struct optee *optee, u_int pa_width)
 	return dma_coerce_mask_and_coherent(&optee->teedev->dev, mask);
 }
 
+int optee_get_revision(struct tee_device *teedev, char *buf, size_t len)
+{
+	struct optee *optee = tee_get_drvdata(teedev);
+	u64 build_id;
+
+	if (!optee)
+		return -ENODEV;
+	if (!buf || !len)
+		return -EINVAL;
+
+	build_id = optee->revision.os_build_id;
+	if (build_id)
+		scnprintf(buf, len, "%u.%u (%016llx)",
+			  optee->revision.os_major,
+			  optee->revision.os_minor,
+			  (unsigned long long)build_id);
+	else
+		scnprintf(buf, len, "%u.%u", optee->revision.os_major,
+			  optee->revision.os_minor);
+
+	return 0;
+}
+
 static void optee_bus_scan(struct work_struct *work)
 {
 	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index bf8390789ecf..d67ca1ec9506 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -776,7 +776,8 @@ static int optee_ffa_reclaim_protmem(struct optee *optee,
  */
 
 static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
-					const struct ffa_ops *ops)
+					const struct ffa_ops *ops,
+					struct optee_revision *revision)
 {
 	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
 	struct ffa_send_direct_data data = {
@@ -806,6 +807,11 @@ static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
 		pr_err("Unexpected error %d\n", rc);
 		return false;
 	}
+	if (revision) {
+		revision->os_major = data.data0;
+		revision->os_minor = data.data1;
+		revision->os_build_id = data.data2;
+	}
 	if (data.data2)
 		pr_info("revision %lu.%lu (%08lx)",
 			data.data0, data.data1, data.data2);
@@ -900,6 +906,7 @@ static int optee_ffa_open(struct tee_context *ctx)
 
 static const struct tee_driver_ops optee_ffa_clnt_ops = {
 	.get_version = optee_ffa_get_version,
+	.get_tee_revision = optee_get_revision,
 	.open = optee_ffa_open,
 	.release = optee_release,
 	.open_session = optee_open_session,
@@ -918,6 +925,7 @@ static const struct tee_desc optee_ffa_clnt_desc = {
 
 static const struct tee_driver_ops optee_ffa_supp_ops = {
 	.get_version = optee_ffa_get_version,
+	.get_tee_revision = optee_get_revision,
 	.open = optee_ffa_open,
 	.release = optee_release_supp,
 	.supp_recv = optee_supp_recv,
@@ -1034,6 +1042,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
 	const struct ffa_notifier_ops *notif_ops;
 	const struct ffa_ops *ffa_ops;
+	struct optee_revision revision = { };
 	unsigned int max_notif_value;
 	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
@@ -1047,7 +1056,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	ffa_ops = ffa_dev->ops;
 	notif_ops = ffa_ops->notifier_ops;
 
-	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
+	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &revision))
 		return -EINVAL;
 
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
@@ -1059,6 +1068,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee)
 		return -ENOMEM;
+	optee->revision = revision;
 
 	pool = optee_ffa_shm_pool_alloc_pages();
 	if (IS_ERR(pool)) {
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index db9ea673fbca..acd3051c4879 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -171,6 +171,24 @@ struct optee_ffa {
 
 struct optee;
 
+/**
+ * struct optee_revision - OP-TEE OS revision reported by secure world
+ * @os_major:		OP-TEE OS major version
+ * @os_minor:		OP-TEE OS minor version
+ * @os_build_id:	OP-TEE OS build identifier (0 if unspecified)
+ *
+ * Values come from OPTEE_SMC_CALL_GET_OS_REVISION (SMC ABI) or
+ * OPTEE_FFA_GET_OS_VERSION (FF-A ABI); this is the trusted OS revision, not an
+ * FF-A ABI version.
+ */
+struct optee_revision {
+	u32 os_major;
+	u32 os_minor;
+	u64 os_build_id;
+};
+
+int optee_get_revision(struct tee_device *teedev, char *buf, size_t len);
+
 /**
  * struct optee_ops - OP-TEE driver internal operations
  * @do_call_with_arg:	enters OP-TEE in secure world
@@ -249,6 +267,7 @@ struct optee {
 	bool in_kernel_rpmb_routing;
 	struct work_struct scan_bus_work;
 	struct work_struct rpmb_scan_bus_work;
+	struct optee_revision revision;
 };
 
 struct optee_session {
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 0be663fcd52b..0baaf7986a35 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1242,6 +1242,7 @@ static int optee_smc_open(struct tee_context *ctx)
 
 static const struct tee_driver_ops optee_clnt_ops = {
 	.get_version = optee_get_version,
+	.get_tee_revision = optee_get_revision,
 	.open = optee_smc_open,
 	.release = optee_release,
 	.open_session = optee_open_session,
@@ -1261,6 +1262,7 @@ static const struct tee_desc optee_clnt_desc = {
 
 static const struct tee_driver_ops optee_supp_ops = {
 	.get_version = optee_get_version,
+	.get_tee_revision = optee_get_revision,
 	.open = optee_smc_open,
 	.release = optee_release_supp,
 	.supp_recv = optee_supp_recv,
@@ -1323,7 +1325,8 @@ static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invoke_fn)
 }
 #endif
 
-static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
+static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn,
+				      struct optee_revision *revision)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -1337,6 +1340,12 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
 	invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
 		  &res.smccc);
 
+	if (revision) {
+		revision->os_major = res.result.major;
+		revision->os_minor = res.result.minor;
+		revision->os_build_id = res.result.build_id;
+	}
+
 	if (res.result.build_id)
 		pr_info("revision %lu.%lu (%0*lx)", res.result.major,
 			res.result.minor, (int)sizeof(res.result.build_id) * 2,
@@ -1727,6 +1736,7 @@ static int optee_probe(struct platform_device *pdev)
 	unsigned int thread_count;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
+	struct optee_revision revision = { };
 	u32 max_notif_value;
 	u32 arg_cache_flags;
 	u32 sec_caps;
@@ -1745,7 +1755,7 @@ static int optee_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	optee_msg_get_os_revision(invoke_fn);
+	optee_msg_get_os_revision(invoke_fn, &revision);
 
 	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
 		pr_warn("api revision mismatch\n");
@@ -1837,6 +1847,7 @@ static int optee_probe(struct platform_device *pdev)
 		goto err_unreg_teedev;
 	}
 	optee->supp_teedev = teedev;
+	optee->revision = revision;
 
 	optee_set_dev_group(optee);
 
-- 
2.43.0

