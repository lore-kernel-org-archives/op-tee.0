Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D082ACF45C5
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 19:41:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 176C043279
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 19:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1768246904;
	bh=50gmtErSy75Us/O/RfbTvKrFVW5yaQVXNPOQprnS6fI=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QZPPWr3WJZZKD6xqy9YAyD2h3T+6T5g/eVLZwmoFMhemqGpbyVZuPImfg+S/9dSbl
	 1tF6RHTrw4rcrS9isci5dj5I7yuV2UnaxvLRE6TtE9uhADGfgT443XUOOKLfuym1/Y
	 E0Ma3vrY3kesGqp7rsHGFjLOt3iKF0/7ei77BnJDyFJC2tVS91TrYPkejZFXEf4tDQ
	 WrInvmAz5jGtrgWjwXVKKYIDst0oK2bxKMAooxT0OyxHzCFiBC5M/SXR+kB17U7TAl
	 11yAHD4mk8m446RR62X5+NEhnruD8f0mhRM/mojYNK4YWjho+oZv0HWXs39ALHqp1I
	 StRwtGtZSutqw==
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A4C7143279
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 15:48:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=GpnyyEh6;
	dkim-atps=neutral
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0386C3F859
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1768232927;
	bh=+djs32HpG4YdYqAsDJAlNbRMZxpzFWDw/DVKyB6YIWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=GpnyyEh6F+zTlHLE8a4RlbglaCqeQZ3QhTtkqTYiptcUigdOSnh3h4o5WcmoE8EpY
	 n5zsEpL/vn+0D2vX9iQAB4ZPj/M0Bn0WpgpN7RMumrNnlIezW/dy9+O+QXnRK72bsF
	 wnbouARRBhxfaDVb0Mn34u+8PODjCv9NwixL5okhac9c/YAj3PpCazqF4v3AAejsQb
	 SoKNnh95xbc7HpcZURPCxvofwlfyDuaUEBAEXjUwQUoedJ3IJkArsCt1mCBUQLIyCG
	 LqI6pjJYhuScUWb/stLbRZZmHxpYiZ1dxyRExXWWP0wKeycSnnCrOGJPSxcD5mTqrE
	 H8EzVSl6Yjz8klBTPu2wMSXNj56O1DQKf4+xXwNyDmmR+79QdO/lL1WOZb4E0byfLt
	 xHsIziid98YGNMXHHjeJLYqX2FkSnwkkdlKWP6LwYmskg2WZSYrVjhUcXprSjJpqDj
	 2pI/eNq1wIsCdY+Zd3B/hWEpQa7ySz1L6CWhqZp/Ga67alfhn/npOACrqY+aJLnL0t
	 xOQVyDg7WaFA4IX7QxFHzXQLgzosFs+hy9PmMhjWZ+YE3kMlvQhPOFnH9nVfvzOEOo
	 iCk2IJ7udyv/Vy4M9WOyuSRKIpI22OdnDEib+YWOXOfBP1/JYJoNnMvy9yN05QrjXU
	 gZz3A9N+aWqtgrJ3P3SEk/uI=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0f47c0e60so21489445ad.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 07:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232925; x=1768837725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+djs32HpG4YdYqAsDJAlNbRMZxpzFWDw/DVKyB6YIWo=;
        b=lCEGIsZyJFqUSMxaiS8rPURYmZpGK7QDv4efNdLpQ3+3yLkWxYXUFSK4wuvZ3XbfR2
         Jwm1pTRtWo7gqK8btqzhAt4GEkQLNEyZJ8AXqdilqYzzFILoQkq7c1nJjxfvAwnZh+HJ
         Kd7HSZptbTyyxOBuF1txeAyZpb+uru3jIpSjQWJAgiLaL7IVRHOUrARw8QKFgYzjvPFL
         hu6d6YaQ1wh0pDKYqZma1pIx2A/a66eFAPjrnN0eMOS0eJWVLowNKhVL4q8aqm6XPs6w
         oHGm+2JdO8ud0y5CWTGCvya1UFUPJ3ZZznsra/1UH19pWreog3ulqfyd4J/HzrN2bqeo
         FS4A==
X-Forwarded-Encrypted: i=1; AJvYcCU1Q0JC76JCJZgr2Kr4C2W58ZjfxmdM9Fxf0z0eS9Qrdxbs8Wkkl61wHCz9FrUHSeILViAlEUg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzuCwjVEVtHD9Ic4SWJAmUKYx8++TzEbyjVp8PXXGOEC79+J/Yn
	+qB5tMn7aPgCiQ3lOc9PZ5E8rr4qmbBzeJWeXLxTMwqA0+Wp8ca3kDXzoQSRlFIhNK8rtmuMG12
	83uoCcAK8vOxg3MyeRKOcFtdFCkapysCVE5EOXDK/6hGue/W2JMTfdHB2G8nWo+cYbOQJrdf9KE
	LM87mOlvMo48g=
X-Gm-Gg: AY/fxX7P3IE66WT5SAJw1LGU3+ivTsR5aW37z2x/qbZJzni5J+yN0ItG4s6tnMKGkkL
	K/rqkCenBS2ycnD3Lnu/e2OO22BtCux8fh0/ChpUz0xop9B4uVj5lmvOFq0Ng6J/a0e5EElIm3E
	6RfG3iMgCeRqEFMhjb88WSvuQlbYq/HkTN262EPo986EloRpwenXErSJbkbWyDlHUSYkDp1AJEx
	RsvRw7p65MRQFJPmpUF+UUWgMTwIEzQ1HhdyPDOb3TqO2O6r4W5cAJvb72f224gRySFyaYCqWcT
	xfD9AA4gESOeN/5x/627h9ohYpzfKN1beMiMc78/rI3D4T+KDJ7QSJ4v450C32oqOHFlkW2Afec
	gaoz9xhPKe7BA0P28L9p4SwHYw2yOfoXK7CVlxY9Go64vzWJm6ROf+YVH+VkoVZk8c+f03lkALq
	hc
X-Received: by 2002:a17:902:e88a:b0:2a0:c1fc:3de5 with SMTP id d9443c01a7336-2a3ee4b4c20mr129494715ad.51.1768232925468;
        Mon, 12 Jan 2026 07:48:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGx5X81H2sVu9HZw3vz/rWnL3PQrR6fYfjBMhOAegTyWa7x/pCfhE3id8N1QxeUJD8c6w0HQ==
X-Received: by 2002:a17:902:e88a:b0:2a0:c1fc:3de5 with SMTP id d9443c01a7336-2a3ee4b4c20mr129494625ad.51.1768232925117;
        Mon, 12 Jan 2026 07:48:45 -0800 (PST)
Received: from aristo-PC.tail872496.ts.net (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2debsm180204745ad.65.2026.01.12.07.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:48:44 -0800 (PST)
To: linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] tee: optee: store OS revision for TEE core
Date: Mon, 12 Jan 2026 23:48:30 +0800
Message-ID: <20260112154833.78546-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260112154833.78546-1-aristo.chen@canonical.com>
References: <20260108064517.13854-1-aristo.chen@canonical.com>
 <20260112154833.78546-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.70 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[canonical.com:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:185.125.188.123:c];
	RCVD_IN_DNSWL_MED(-0.20)[185.125.188.123:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ASN(0.00)[asn:41231, ipnet:185.125.188.0/23, country:GB];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[canonical.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A4C7143279
X-Spamd-Bar: --
X-MailFrom: aristo.chen@canonical.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: H3TYXFR2QH27D4HX2QPDCLVEW6TTDU4L
X-Message-ID-Hash: H3TYXFR2QH27D4HX2QPDCLVEW6TTDU4L
X-Mailman-Approved-At: Mon, 12 Jan 2026 19:39:40 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/H3TYXFR2QH27D4HX2QPDCLVEW6TTDU4L/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Aristo Chen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>

Collect OP-TEE OS revision from secure world for both SMC and FF-A
ABIs, store it in the OP-TEE driver, and expose it through the
generic get_tee_revision() callback.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 drivers/tee/optee/core.c          | 23 +++++++++++++
 drivers/tee/optee/ffa_abi.c       | 54 +++++++++++++++++++++++--------
 drivers/tee/optee/optee_private.h | 19 +++++++++++
 drivers/tee/optee/smc_abi.c       | 15 +++++++--
 4 files changed, 94 insertions(+), 17 deletions(-)

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
index bf8390789ecf..8fc72aa95722 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -775,6 +775,39 @@ static int optee_ffa_reclaim_protmem(struct optee *optee,
  * with a matching configuration.
  */
 
+static bool optee_ffa_get_os_revision(struct ffa_device *ffa_dev,
+				      const struct ffa_ops *ops,
+				      struct optee_revision *revision)
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
+	if (data.data2)
+		pr_info("revision %lu.%lu (%08lx)",
+			data.data0, data.data1, data.data2);
+	else
+		pr_info("revision %lu.%lu", data.data0, data.data1);
+
+	return true;
+}
+
 static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
 					const struct ffa_ops *ops)
 {
@@ -798,20 +831,6 @@ static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
 		return false;
 	}
 
-	data = (struct ffa_send_direct_data){
-		.data0 = OPTEE_FFA_GET_OS_VERSION,
-	};
-	rc = msg_ops->sync_send_receive(ffa_dev, &data);
-	if (rc) {
-		pr_err("Unexpected error %d\n", rc);
-		return false;
-	}
-	if (data.data2)
-		pr_info("revision %lu.%lu (%08lx)",
-			data.data0, data.data1, data.data2);
-	else
-		pr_info("revision %lu.%lu", data.data0, data.data1);
-
 	return true;
 }
 
@@ -900,6 +919,7 @@ static int optee_ffa_open(struct tee_context *ctx)
 
 static const struct tee_driver_ops optee_ffa_clnt_ops = {
 	.get_version = optee_ffa_get_version,
+	.get_tee_revision = optee_get_revision,
 	.open = optee_ffa_open,
 	.release = optee_release,
 	.open_session = optee_open_session,
@@ -918,6 +938,7 @@ static const struct tee_desc optee_ffa_clnt_desc = {
 
 static const struct tee_driver_ops optee_ffa_supp_ops = {
 	.get_version = optee_ffa_get_version,
+	.get_tee_revision = optee_get_revision,
 	.open = optee_ffa_open,
 	.release = optee_release_supp,
 	.supp_recv = optee_supp_recv,
@@ -1060,6 +1081,11 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (!optee)
 		return -ENOMEM;
 
+	if (!optee_ffa_get_os_revision(ffa_dev, ffa_ops, &optee->revision)) {
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

