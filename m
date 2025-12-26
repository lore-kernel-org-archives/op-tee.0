Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78790E8FDB1
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 08:11:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C0BCD4618B
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 08:11:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VsUn6i4D;
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6CA3241A32
	for <op-tee@lists.trustedfirmware.org>; Fri, 26 Dec 2025 13:19:31 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0a33d0585so67751995ad.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 26 Dec 2025 05:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766755170; x=1767359970; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztmWSYWGGyLeB3+wlITLBNjlw9ipvtgyxGzajVtnRDU=;
        b=VsUn6i4DetR+zXQ3bB7pDqDUut7ikNV7fbvoqHFi9/kiti8yLkw0zwDIPjCsmWGTws
         UfnmGh+8oFr6xBnnR4Mu4fdhy4KFvsmSDcVW1OTIkD5Xm3dN4/G2kEEDB+grzW3FQCA3
         Fk+GNieH6rjUM2zDvh8nidoUWW9CYdlM0omi/pVDWIjHCOdoE8rWAM48Nna/9lIdbGkn
         xpcsx/b0RgmCxTj1JiguXVnD41xK8956nNBj2IFEsb3uZoEwoQFnO4fNwXfzhHLBhFCQ
         6HpMx6bMTBu99ikSn3ntd4u3RQAf5N2nUhWrs4CkN9vngAknOoHyka9qCdatFyxOmEjm
         wpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766755170; x=1767359970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztmWSYWGGyLeB3+wlITLBNjlw9ipvtgyxGzajVtnRDU=;
        b=jjw1eX6GhC9sMwoFhdHNPpy0a/sUPO2GlpvMk9wG740Rz7U+xK5Q8RZfqUqcXz8wPK
         tLmDWCro8MHWeHu14RMR1VtfW5DyHfYG3rh5TibXxcp6Mhn/oncZsHOwzIMcjltKjPgO
         P/9riWxIcb3RdzEW7GpkPReBr5b2J8/X26xqoYmvSS6Zo5U1jwjpxuJKo+LXP0cMxCJq
         yrUnpcFYt5R/yaInC5KBRwp16g7LpkGX6BB9pE3A1gVGWcHvyRoJGgf6SywzOdWgzowi
         VKrVLldTL1iEqDpvNF98EILvr3yOx+CmF0yYLafZBUXXLbyjB9ib1gFCZKQELu4EnV0Q
         JCXg==
X-Forwarded-Encrypted: i=1; AJvYcCWd7eNJbBBIHZmO73Q9iwAFcH8x+EnCGSH5j2HHrxmogY0hJmpGO9x9U7xRihp3dBrh15Mzy+c=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyKFJJGbRTvrcJuWP5R5g48l2ipqhvKnL2PUp07LzgtOFH5uYqU
	ViY/qCWYTc+N53XJ7TTMSXjs8+Oz6QvlwLz2whLp+GrJ4iWd4/a3V6d0
X-Gm-Gg: AY/fxX50buqIWdblkrquqyrgUjL9diapyxvJ9G47TaU93QiYc66XwOdjAm6q67Roklc
	W53QNWUOFhsVy1VpKOjclLiArUUamdiKiVdgqPrNqz/eeTvfwaYEJOXvB0vb3e+WvefdEaR4znx
	UaCKSmI7XaFB7oMtoWTGsU9+E8Flria/t/haognRTMvxtJadiE/UUvsUODMiA2PryRn3fTlgU2p
	Ot+MTp8eYSMawvJy6omA9NzJf9NXnJb9BB1stOgV9q4UHUQjgstPE1EhbV/weIuC3Q9/o7bcjws
	EMvKFkJCu7bDauuLV38ZfH1d/PEoS89D8FMQS0QyFfxVc6StQ8UP96hYzznrxQz3rzBEIZsnXyB
	dIW97kIRMldcE8TBUl2eK0vhaR3mS9eVK4BDfideB58VAdbh/YeOdBre1AMI4RBneVbcUQ8lFBs
	+xBHxOzPxtGl4miOrZW7H8JLGHwAGIsB23DArNu34rXto1BhGba3skWvxL8+XNmHSnSA5RCXu9v
	K2fP4zoU+MurlhI
X-Google-Smtp-Source: AGHT+IF7NYBU20A8LCs6nhojTiH6GLpixmvjeNlgqFZ9VS+8tOFossACncHyfq24hgxuKpwvcH11qA==
X-Received: by 2002:a17:902:fc8e:b0:2a0:a33f:304c with SMTP id d9443c01a7336-2a2f2a400b4mr234763275ad.57.1766755170381;
        Fri, 26 Dec 2025 05:19:30 -0800 (PST)
Received: from aristo-PC.tail872496.ts.net (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d6e4sm206587575ad.75.2025.12.26.05.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 05:19:29 -0800 (PST)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] tee: optee: expose OS revision via sysfs
Date: Fri, 26 Dec 2025 21:19:13 +0800
Message-ID: <20251226131920.64582-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122145924.381725-1-jj251510319013@gmail.com>
References: <20251122145924.381725-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.214.175:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[209.85.214.175:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6CA3241A32
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: OVFZ4A2W73RZA5EFWBQ2KNL3VUDM7B2S
X-Message-ID-Hash: OVFZ4A2W73RZA5EFWBQ2KNL3VUDM7B2S
X-Mailman-Approved-At: Mon, 29 Dec 2025 08:10:27 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OVFZ4A2W73RZA5EFWBQ2KNL3VUDM7B2S/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Today the only way to read the OP-TEE OS version is from dmesg/journal
logs, which can be lost as buffers roll over. Capture the OS revision
(major/minor/build_id) from secure world for both SMC and FF-A ABIs, store
it in the OP-TEE driver, and expose a stable userspace readout via
/sys/class/tee/tee*/revision.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 Documentation/ABI/testing/sysfs-class-tee | 10 +++++
 drivers/tee/optee/core.c                  | 22 ++++++++++
 drivers/tee/optee/ffa_abi.c               | 25 ++++++++++-
 drivers/tee/optee/optee_private.h         | 19 +++++++++
 drivers/tee/optee/smc_abi.c               | 25 ++++++++++-
 drivers/tee/tee_core.c                    | 52 ++++++++++++++++++++++-
 include/linux/tee_core.h                  |  5 +++
 include/linux/tee_drv.h                   |  3 ++
 8 files changed, 156 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
index c9144d16003e..6e783210104e 100644
--- a/Documentation/ABI/testing/sysfs-class-tee
+++ b/Documentation/ABI/testing/sysfs-class-tee
@@ -13,3 +13,13 @@ Description:
 		space if the variable is absent. The primary purpose
 		of this variable is to let systemd know whether
 		tee-supplicant is needed in the early boot with initramfs.
+
+What:		/sys/class/tee/tee{,priv}X/revision
+Date:		Dec 2025
+KernelVersion:	6.18
+Contact:	op-tee@lists.trustedfirmware.org
+Description:
+		Read-only revision string reported by the TEE driver. This is
+		for diagnostics only and must not be used to infer feature
+		support. Use TEE_IOC_VERSION for capability and compatibility
+		checks.
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 5b62139714ce..58ee9ac0e467 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -63,6 +63,28 @@ int optee_set_dma_mask(struct optee *optee, u_int pa_width)
 	return dma_coerce_mask_and_coherent(&optee->teedev->dev, mask);
 }
 
+int optee_get_revision(struct optee *optee, char *buf, size_t len)
+{
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
index bf8390789ecf..0a2990c2491e 100644
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
@@ -806,6 +807,12 @@ static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
 		pr_err("Unexpected error %d\n", rc);
 		return false;
 	}
+	if (revision) {
+		revision->os_major = data.data0;
+		revision->os_minor = data.data1;
+		revision->os_build_id = data.data2;
+	}
+
 	if (data.data2)
 		pr_info("revision %lu.%lu (%08lx)",
 			data.data0, data.data1, data.data2);
@@ -898,8 +905,12 @@ static int optee_ffa_open(struct tee_context *ctx)
 	return optee_open(ctx, true);
 }
 
+static int optee_ffa_get_tee_revision(struct tee_device *teedev,
+				      char *buf, size_t len);
+
 static const struct tee_driver_ops optee_ffa_clnt_ops = {
 	.get_version = optee_ffa_get_version,
+	.get_tee_revision = optee_ffa_get_tee_revision,
 	.open = optee_ffa_open,
 	.release = optee_release,
 	.open_session = optee_open_session,
@@ -918,6 +929,7 @@ static const struct tee_desc optee_ffa_clnt_desc = {
 
 static const struct tee_driver_ops optee_ffa_supp_ops = {
 	.get_version = optee_ffa_get_version,
+	.get_tee_revision = optee_ffa_get_tee_revision,
 	.open = optee_ffa_open,
 	.release = optee_release_supp,
 	.supp_recv = optee_supp_recv,
@@ -1034,6 +1046,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
 	const struct ffa_notifier_ops *notif_ops;
 	const struct ffa_ops *ffa_ops;
+	struct optee_revision revision = { };
 	unsigned int max_notif_value;
 	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
@@ -1047,7 +1060,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	ffa_ops = ffa_dev->ops;
 	notif_ops = ffa_ops->notifier_ops;
 
-	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
+	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &revision))
 		return -EINVAL;
 
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
@@ -1059,6 +1072,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee)
 		return -ENOMEM;
+	optee->revision = revision;
 
 	pool = optee_ffa_shm_pool_alloc_pages();
 	if (IS_ERR(pool)) {
@@ -1194,3 +1208,10 @@ void optee_ffa_abi_unregister(void)
 	if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
 		ffa_unregister(&optee_ffa_driver);
 }
+static int optee_ffa_get_tee_revision(struct tee_device *teedev,
+				      char *buf, size_t len)
+{
+	struct optee *optee = tee_get_drvdata(teedev);
+
+	return optee_get_revision(optee, buf, len);
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index db9ea673fbca..8d65f8b16b4a 100644
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
+int optee_get_revision(struct optee *optee, char *buf, size_t len);
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
index 0be663fcd52b..4dc2c16147ee 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1240,8 +1240,12 @@ static int optee_smc_open(struct tee_context *ctx)
 	return optee_open(ctx, sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL);
 }
 
+static int optee_get_tee_revision(struct tee_device *teedev,
+				  char *buf, size_t len);
+
 static const struct tee_driver_ops optee_clnt_ops = {
 	.get_version = optee_get_version,
+	.get_tee_revision = optee_get_tee_revision,
 	.open = optee_smc_open,
 	.release = optee_release,
 	.open_session = optee_open_session,
@@ -1261,6 +1265,7 @@ static const struct tee_desc optee_clnt_desc = {
 
 static const struct tee_driver_ops optee_supp_ops = {
 	.get_version = optee_get_version,
+	.get_tee_revision = optee_get_tee_revision,
 	.open = optee_smc_open,
 	.release = optee_release_supp,
 	.supp_recv = optee_supp_recv,
@@ -1323,7 +1328,8 @@ static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invoke_fn)
 }
 #endif
 
-static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
+static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn,
+				      struct optee_revision *revision)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -1337,6 +1343,12 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
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
@@ -1727,6 +1739,7 @@ static int optee_probe(struct platform_device *pdev)
 	unsigned int thread_count;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
+	struct optee_revision revision = { };
 	u32 max_notif_value;
 	u32 arg_cache_flags;
 	u32 sec_caps;
@@ -1745,7 +1758,7 @@ static int optee_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	optee_msg_get_os_revision(invoke_fn);
+	optee_msg_get_os_revision(invoke_fn, &revision);
 
 	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
 		pr_warn("api revision mismatch\n");
@@ -1814,6 +1827,7 @@ static int optee_probe(struct platform_device *pdev)
 		rc = -ENOMEM;
 		goto err_free_shm_pool;
 	}
+	optee->revision = revision;
 
 	optee->ops = &optee_ops;
 	optee->smc.invoke_fn = invoke_fn;
@@ -1971,3 +1985,10 @@ void optee_smc_abi_unregister(void)
 {
 	platform_driver_unregister(&optee_driver);
 }
+static int optee_get_tee_revision(struct tee_device *teedev,
+				  char *buf, size_t len)
+{
+	struct optee *optee = tee_get_drvdata(teedev);
+
+	return optee_get_revision(optee, buf, len);
+}
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d65d47cc154e..0ba0e16462b9 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -13,6 +13,7 @@
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/tee_core.h>
+#include <linux/tee_drv.h>
 #include <linux/uaccess.h>
 #include <crypto/sha1.h>
 #include "tee_private.h"
@@ -1146,7 +1147,56 @@ static struct attribute *tee_dev_attrs[] = {
 	NULL
 };
 
-ATTRIBUTE_GROUPS(tee_dev);
+static const struct attribute_group tee_dev_group = {
+	.attrs = tee_dev_attrs,
+};
+
+static ssize_t revision_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct tee_device *teedev = container_of(dev, struct tee_device, dev);
+	char version[TEE_REVISION_STR_SIZE];
+	int ret;
+
+	if (!teedev->desc->ops->get_tee_revision)
+		return -ENODEV;
+
+	ret = teedev->desc->ops->get_tee_revision(teedev, version,
+						  sizeof(version));
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%s\n", version);
+}
+static DEVICE_ATTR_RO(revision);
+
+static struct attribute *tee_revision_attrs[] = {
+	&dev_attr_revision.attr,
+	NULL
+};
+
+static umode_t tee_revision_attr_is_visible(struct kobject *kobj,
+					    struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tee_device *teedev = container_of(dev, struct tee_device, dev);
+
+	if (teedev->desc->ops->get_tee_revision)
+		return attr->mode;
+
+	return 0;
+}
+
+static const struct attribute_group tee_revision_group = {
+	.attrs = tee_revision_attrs,
+	.is_visible = tee_revision_attr_is_visible,
+};
+
+static const struct attribute_group *tee_dev_groups[] = {
+	&tee_dev_group,
+	&tee_revision_group,
+	NULL
+};
 
 static const struct class tee_class = {
 	.name = "tee",
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index 1f3e5dad6d0d..de11612afa62 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -76,6 +76,9 @@ struct tee_device {
 /**
  * struct tee_driver_ops - driver operations vtable
  * @get_version:	returns version of driver
+ * @get_tee_revision:	returns revision string (diagnostic only);
+ *			do not infer feature support from this, use
+ *			TEE_IOC_VERSION instead
  * @open:		called for a context when the device file is opened
  * @close_context:	called when the device file is closed
  * @release:		called to release the context
@@ -98,6 +101,8 @@ struct tee_device {
 struct tee_driver_ops {
 	void (*get_version)(struct tee_device *teedev,
 			    struct tee_ioctl_version_data *vers);
+	int (*get_tee_revision)(struct tee_device *teedev,
+				char *buf, size_t len);
 	int (*open)(struct tee_context *ctx);
 	void (*close_context)(struct tee_context *ctx);
 	void (*release)(struct tee_context *ctx);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 88a6f9697c89..e76238d435ce 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -322,4 +322,7 @@ struct tee_client_driver {
 #define to_tee_client_driver(d) \
 		container_of_const(d, struct tee_client_driver, driver)
 
+/* Size for TEE revision string buffer used by get_tee_revision(). */
+#define TEE_REVISION_STR_SIZE	128
+
 #endif /*__TEE_DRV_H*/
-- 
2.43.0

