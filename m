Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1287D148B3
	for <op-tee@archiver.kernel.org>; Thu,  8 Jan 2026 07:11:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 25AF641A9B
	for <op-tee@archiver.kernel.org>; Thu,  8 Jan 2026 07:11:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Drwb6fWG;
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 63ACE4FF8F
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Jan 2026 06:45:29 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c026e074373so1572409a12.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Jan 2026 22:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767854728; x=1768459528; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AgHaSdzGFhpjrKWJPhfx+okgTbgrInnDnJ59Awpc9s=;
        b=Drwb6fWG+UU1N+PCweLmWVGlRaB4xQPQps2cyetsQEbQoc1y06DHYF9iZjj/KV20+a
         cXqD+cFxu99bxu4CS98cto9myZFUywubnpz0ZWQvaYOCqp5JE8M4Z358BXsIkjWJ9zVE
         sLFRvehukH8vPeS/5WaUd80gu9iQnHQ/Jc1H4Er5URwLyJOHsuYkFrrVTYyAbCcYjv/Q
         k1+2EsVphi0umDUCKN9rAVDuk6nQgiuy7fCSCt0k8zf3Vh7/WNYBqBngEjNFLIixv1GK
         AzmJCnEna+Hj8uKOiVsWYyVPN2408v4aWQUQeN3CGaC509UbmD6I1BbfJKd51AN6b9b2
         KrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767854728; x=1768459528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4AgHaSdzGFhpjrKWJPhfx+okgTbgrInnDnJ59Awpc9s=;
        b=XcRTaMlxy89kPFNtu3JcJ42UcZVMjmJIyQoxDZTLFD4msWIMX9GsDc0J0AfBsFLhtx
         Hc5tepCqN9y+qsc7emmyyO8y5Vr4MU+2b5NTGlxGezI5Qq5bzZ+Oh/BjWdS9OlPrRBnO
         dTR6NIpdRk6MT8MVoJokONrhBQAILUb/9k1XfwTtherBEDw9o9rnA/LA5E8M6/anC4Yu
         U0i5Jbc0XMZUN0iKXZIUv0XnnUPTojqEAG4Jk8e8z+4z0edIRCxhcMrhasiA7GUqVALu
         JVgh+tZydYFlDoZZSZhgn98f44O/UJOuODziA+IK0WZ7V6Gd2nb5ZepSd+hk5IMpUXG9
         EVsw==
X-Forwarded-Encrypted: i=1; AJvYcCXf68NH1Qz7K9c6MBeClt535G1nncyr52icTxb7pzOBzwyUX65wbNlFdu7BhvEc2cJK1z+rZlM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YztTCU/nUBkS1wzNxj8loee53KKKQIipkpy5xjYRj8uf8uRnw48
	ln3eOYllfkpv4bVm5WfP6/p3/UiYpgicjBIXzTcT1/YPbL35Rncq1ISX
X-Gm-Gg: AY/fxX6rT22G8GEtJDkLKqOhIEWBgjmBxnuk1Nkw9oO5SKP8UM/QIa8tZdmcaE5+26h
	4WlC6b4h+hHIvsDbHi+F6bur0upoP/zCStdfUAec2Nux873G2TVLTZMufFFSqD6D3i/ONkpDUgc
	7Sue++WPTbrYdNwiju3Iek+pswa6sBGBqKqsbVBwOkWDBb1McApKszAscIUQtZMW7lJGegPz/X3
	12JaNva+NQQjitumqB6t5KC5b22ccCOeT87uDjuYpkKv4hMzz/kavAav9FBgYLqPDZIFUk3tdh7
	Iw3Rq/PfPUM8WgEMY0rD1f7ehdtwnOtbxMONUs4VMAJ9jqZA2Qrp2RfpRLUP18rDN+EoAYEznAs
	gho9/qmaUk+KmiqXJ/FAgwnCnO/oQCCp4T3kzp4dLZgd9INlnsSw4VZBjcZytnXp9TeYFyr9sut
	omT4RTOur7/q72FWYjuiOwv6+2oDvGS00JS7oJxC1xeYQ9HfpkPd5XN5yo4/WcjqjaYEdOVUOcR
	7+93Jk6hjetWhzf
X-Google-Smtp-Source: AGHT+IE8cpwFdvEfxjiXZpXnLEiZi3TaeibsbE5/TP+xSDkwdtKd3mRg89Yp35x66sqUklLvxXsGKw==
X-Received: by 2002:a05:6a20:939f:b0:366:14ac:8c76 with SMTP id adf61e73a8af0-3898f9e2dcfmr4896869637.76.1767854728408;
        Wed, 07 Jan 2026 22:45:28 -0800 (PST)
Received: from aristo-PC.tail872496.ts.net (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5dbfsm6813334a12.27.2026.01.07.22.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 22:45:28 -0800 (PST)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] tee: optee: store OS revision for TEE core
Date: Thu,  8 Jan 2026 14:45:09 +0800
Message-ID: <20260108064517.13854-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108064517.13854-1-aristo.chen@canonical.com>
References: <20260107152607.902735-1-aristo.chen@canonical.com>
 <20260108064517.13854-1-aristo.chen@canonical.com>
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
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.215.179:from];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.179:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 63ACE4FF8F
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: N3V3I36GFLBRQKYFSVUNXJ5LO7KRO7DH
X-Message-ID-Hash: N3V3I36GFLBRQKYFSVUNXJ5LO7KRO7DH
X-Mailman-Approved-At: Thu, 08 Jan 2026 07:09:50 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/N3V3I36GFLBRQKYFSVUNXJ5LO7KRO7DH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Collect OP-TEE OS revision from secure world for both SMC and FF-A
ABIs, store it in the OP-TEE driver, and expose it through the
generic get_tee_revision() callback.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 drivers/tee/optee/core.c          | 23 +++++++++++++
 drivers/tee/optee/ffa_abi.c       | 57 ++++++++++++++++++++++++-------
 drivers/tee/optee/optee_private.h | 19 +++++++++++
 drivers/tee/optee/smc_abi.c       | 15 ++++++--
 4 files changed, 99 insertions(+), 15 deletions(-)

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
index bf8390789ecf..82dbed1c87e5 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -775,6 +775,42 @@ static int optee_ffa_reclaim_protmem(struct optee *optee,
  * with a matching configuration.
  */
 
+static bool optee_ffa_get_os_revision(struct ffa_device *ffa_dev,
+					const struct ffa_ops *ops,
+					struct optee_revision *revision,
+					bool log)
+{
+	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
+	struct ffa_send_direct_data data = {
+		.data0 = OPTEE_FFA_GET_OS_VERSION,
+	};
+	int rc;
+
+	msg_ops->mode_32bit_set(ffa_dev);
+
+	rc = msg_ops->sync_send_receive(ffa_dev, &data);
+	if (rc) {
+		pr_err("Unexpected error %d\n", rc);
+		return false;
+	}
+
+	if (revision) {
+		revision->os_major = data.data0;
+		revision->os_minor = data.data1;
+		revision->os_build_id = data.data2;
+	}
+
+	if (log) {
+		if (data.data2)
+			pr_info("revision %lu.%lu (%08lx)",
+				data.data0, data.data1, data.data2);
+		else
+			pr_info("revision %lu.%lu", data.data0, data.data1);
+	}
+
+	return true;
+}
+
 static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
 					const struct ffa_ops *ops)
 {
@@ -798,19 +834,8 @@ static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
 		return false;
 	}
 
-	data = (struct ffa_send_direct_data){
-		.data0 = OPTEE_FFA_GET_OS_VERSION,
-	};
-	rc = msg_ops->sync_send_receive(ffa_dev, &data);
-	if (rc) {
-		pr_err("Unexpected error %d\n", rc);
+	if (!optee_ffa_get_os_revision(ffa_dev, ops, NULL, true))
 		return false;
-	}
-	if (data.data2)
-		pr_info("revision %lu.%lu (%08lx)",
-			data.data0, data.data1, data.data2);
-	else
-		pr_info("revision %lu.%lu", data.data0, data.data1);
 
 	return true;
 }
@@ -900,6 +925,7 @@ static int optee_ffa_open(struct tee_context *ctx)
 
 static const struct tee_driver_ops optee_ffa_clnt_ops = {
 	.get_version = optee_ffa_get_version,
+	.get_tee_revision = optee_get_revision,
 	.open = optee_ffa_open,
 	.release = optee_release,
 	.open_session = optee_open_session,
@@ -918,6 +944,7 @@ static const struct tee_desc optee_ffa_clnt_desc = {
 
 static const struct tee_driver_ops optee_ffa_supp_ops = {
 	.get_version = optee_ffa_get_version,
+	.get_tee_revision = optee_get_revision,
 	.open = optee_ffa_open,
 	.release = optee_release_supp,
 	.supp_recv = optee_supp_recv,
@@ -1060,6 +1087,12 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (!optee)
 		return -ENOMEM;
 
+	if (!optee_ffa_get_os_revision(ffa_dev, ffa_ops, &optee->revision,
+					 false)) {
+		rc = -EINVAL;
+		goto err_free_optee;
+	}
+
 	pool = optee_ffa_shm_pool_alloc_pages();
 	if (IS_ERR(pool)) {
 		rc = PTR_ERR(pool);
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
index 0be663fcd52b..51fae1ab8ef8 100644
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
@@ -1745,8 +1754,6 @@ static int optee_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	optee_msg_get_os_revision(invoke_fn);
-
 	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
 		pr_warn("api revision mismatch\n");
 		return -EINVAL;
@@ -1815,6 +1822,8 @@ static int optee_probe(struct platform_device *pdev)
 		goto err_free_shm_pool;
 	}
 
+	optee_msg_get_os_revision(invoke_fn, &optee->revision);
+
 	optee->ops = &optee_ops;
 	optee->smc.invoke_fn = invoke_fn;
 	optee->smc.sec_caps = sec_caps;
-- 
2.43.0

