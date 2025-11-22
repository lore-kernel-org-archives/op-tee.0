Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA15CFA466
	for <op-tee@archiver.kernel.org>; Mon, 24 Nov 2025 06:21:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5FC6C4FFC5
	for <op-tee@archiver.kernel.org>; Mon, 24 Nov 2025 06:21:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=m9JYJXBD;
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3896241B81
	for <op-tee@lists.trustedfirmware.org>; Sat, 22 Nov 2025 15:00:07 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-298145fe27eso46555445ad.1
        for <op-tee@lists.trustedfirmware.org>; Sat, 22 Nov 2025 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763823606; x=1764428406; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k1HKBZgC35taQ0pVaza+vjIctdtHdL/OszhKayydk4=;
        b=m9JYJXBDg4GghB1FH2jxNQWCclfkyGz2IU9zsKpwhHtHGWrlE9bW09YNnBNNrJmhKn
         ZgdMlUoZJuiRKEKlF2T8uk9DQNYZKmfvjkGpyMYiynXUbNmrLrJsfD5/lgjg2xEesAXK
         Pvu7IqBLi+eYDH77LUyjILkx76XwW/ylNjon2HPc1FkxHKurvBwpmurVHYGgN/ejtbjN
         QFUa4RuvIxeIdDyyNF+y+2SzXa8YlzON6t6CbCuOjK2RWkNBkFivsuRJko6cAeJxVosj
         G5s1Kb13HmZSFuOUqIPaRUecgVGRBJ8PQHmCeuyawDdHS2yHd2e2fWhg80scrypzUPTE
         mPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763823606; x=1764428406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9k1HKBZgC35taQ0pVaza+vjIctdtHdL/OszhKayydk4=;
        b=EtO+3TBhLG0VOOu1aYIHLf8M5t5LGytAzWwQMON1CP4WRGiZXjPv5t0H13OvoxlMkM
         qw75PJIJ6xl8oJkzb8cG66EL5DPPY4mYj85r6ReqYa02oTyN8a/4LXntqWSizDwxMhNy
         YXCDLRXVh3M8dMvY6KLmUMjo6RDJvsjUWHP6JPcytCh8UzOS3acPj+hnjDHaDBSMg15F
         fpxMz+dzFhNg78uXNxuffvEJLH4srz1AM+CI6hgHArNHLv9UjTuznTwgztoe06cOemBl
         sG/prGn3mHdiV5h0Zr+QCWVoHndrTNxIGPZJFYZWZApu3SDlFC2hs6ndbHoFOaBKnQkw
         pHVg==
X-Forwarded-Encrypted: i=1; AJvYcCWNT3zdMhZ730Qy83rhdsAGjqQLmgynjn3j8JWlqZixx/Ulg2wbqz18bXXvSfA7JKAZe1106pM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzJ6V9ln9R1u6ufrw681rKA7TEhDWHPy+CcjBdJsctnHZ2rRyS6
	VACqy8AcL6NeoaVbIa6seu4oRJftzs6RTZ+X773t6qlxHeasSOAeKumN
X-Gm-Gg: ASbGnctKdUovMYvFY9zwLKTURaZnj/lqqLCDeZNRBiRAZR7xCrSd0nzmKpoD2m75bu7
	BymP0VzH+i6FHcqv+Y+qrUZ0+e9PQQQUa6nqhKYUXQ7UsoxPoid5n9CVgDClKDs6HcIQm+mSWoT
	9GiF0mTjTBF4wJmq74FmhoKvHFfrfKEeRfBLxBeqQDqj24P6sMyHsbOILO3YrUShnB2kBINgsPy
	l7IptzEUhTaVNs8KlwiEteH7h70Vdz9mNjf5PI/jE6TFn21fwa/jj7HSBQTdggk8qMjWc0/JPAJ
	xAD7mqqgzHaKO2C0VhREW5YIuSe1Fa7SMZ3RBqH87cNf63QncP1flj2rL8ph4TTjt+p+BoHyzHW
	bPVb4CSNzrcw17oa3NLD4ghIpK+FnVdIpc4/s90EJCIlAz735i6BtajJmK2I+5kH4ZyxsphIL7X
	eh7Aq7Hn838PyQ8JbY6CbB0G4k/fA6XfS+SlIrsUV+v/6nhM9khP+uk6dR0m6WyY8e5a8SBljlh
	ckq
X-Google-Smtp-Source: AGHT+IEsSK4FZsHETD1UZQrfReTGnNxcv/tUZNV2CDEOQ2BvxrE/PzZteqDiC6jZZVpD6ZCHU+9Pzw==
X-Received: by 2002:a17:903:2f86:b0:295:7806:1d7b with SMTP id d9443c01a7336-29b6bf37e59mr77986615ad.45.1763823605908;
        Sat, 22 Nov 2025 07:00:05 -0800 (PST)
Received: from aristo-PC.tail872496.ts.net (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b26fc24sm88262755ad.67.2025.11.22.07.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 07:00:04 -0800 (PST)
From: Wei Ming Chen <jj251510319013@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
Date: Sat, 22 Nov 2025 22:59:11 +0800
Message-ID: <20251122145924.381725-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121141230.489294-1-jj251510319013@gmail.com>
References: <20251121141230.489294-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: --
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3896241B81
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.214.180:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[gmail.com:+]
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: U2O6DLQBGPCJR7T4VJFFEK2J5ZNGW57T
X-Message-ID-Hash: U2O6DLQBGPCJR7T4VJFFEK2J5ZNGW57T
X-Mailman-Approved-At: Mon, 24 Nov 2025 06:21:42 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U2O6DLQBGPCJR7T4VJFFEK2J5ZNGW57T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Aristo Chen <aristo.chen@canonical.com>

Today the only way to read the OP-TEE OS version is from dmesg/journal
logs, which can be lost as buffers roll over. Capture the OS revision
(major/minor/build_id) from secure world for both SMC and FF-A ABIs, store
it in the OP-TEE driver, and expose a stable userspace readout via
/sys/class/tee/tee*/optee_os_revision.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 drivers/tee/optee/core.c          | 19 +++++++++++++++++++
 drivers/tee/optee/ffa_abi.c       | 13 +++++++++++--
 drivers/tee/optee/optee_private.h | 17 +++++++++++++++++
 drivers/tee/optee/smc_abi.c       | 13 +++++++++++--
 4 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 5b62139714ce..66409cf5da1c 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -83,8 +83,27 @@ static ssize_t rpmb_routing_model_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(rpmb_routing_model);
 
+static ssize_t optee_os_revision_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct optee *optee = dev_get_drvdata(dev);
+	struct optee_version_info *v;
+
+	if (!optee)
+		return -ENODEV;
+
+	v = &optee->version_info;
+	if (v->os_build_id)
+		return sysfs_emit(buf, "%u.%u (%016llx)\n", v->os_major,
+				  v->os_minor, (unsigned long long)v->os_build_id);
+
+	return sysfs_emit(buf, "%u.%u\n", v->os_major, v->os_minor);
+}
+static DEVICE_ATTR_RO(optee_os_revision);
+
 static struct attribute *optee_dev_attrs[] = {
 	&dev_attr_rpmb_routing_model.attr,
+	&dev_attr_optee_os_revision.attr,
 	NULL
 };
 
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index bf8390789ecf..3d4f35599dd1 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -776,7 +776,8 @@ static int optee_ffa_reclaim_protmem(struct optee *optee,
  */
 
 static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
-					const struct ffa_ops *ops)
+					const struct ffa_ops *ops,
+					struct optee_version_info *version_info)
 {
 	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
 	struct ffa_send_direct_data data = {
@@ -806,6 +807,12 @@ static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
 		pr_err("Unexpected error %d\n", rc);
 		return false;
 	}
+	if (version_info) {
+		version_info->os_major = data.data0;
+		version_info->os_minor = data.data1;
+		version_info->os_build_id = data.data2;
+	}
+
 	if (data.data2)
 		pr_info("revision %lu.%lu (%08lx)",
 			data.data0, data.data1, data.data2);
@@ -1034,6 +1041,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
 	const struct ffa_notifier_ops *notif_ops;
 	const struct ffa_ops *ffa_ops;
+	struct optee_version_info version_info = { };
 	unsigned int max_notif_value;
 	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
@@ -1047,7 +1055,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	ffa_ops = ffa_dev->ops;
 	notif_ops = ffa_ops->notifier_ops;
 
-	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
+	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &version_info))
 		return -EINVAL;
 
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
@@ -1059,6 +1067,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee)
 		return -ENOMEM;
+	optee->version_info = version_info;
 
 	pool = optee_ffa_shm_pool_alloc_pages();
 	if (IS_ERR(pool)) {
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index db9ea673fbca..3e7bcd44976b 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -19,6 +19,22 @@
 
 #define OPTEE_MAX_ARG_SIZE	1024
 
+/**
+ * struct optee_version_info - OP-TEE OS revision reported by secure world
+ * @os_major:		OP-TEE OS major version
+ * @os_minor:		OP-TEE OS minor version
+ * @os_build_id:	OP-TEE OS build identifier (0 if unspecified)
+ *
+ * Values come from OPTEE_SMC_CALL_GET_OS_REVISION (SMC ABI) or
+ * OPTEE_FFA_GET_OS_VERSION (FF-A ABI); this is the trusted OS revision, not an
+ * FF-A ABI version.
+ */
+struct optee_version_info {
+	u32 os_major;
+	u32 os_minor;
+	u64 os_build_id;
+};
+
 /* Some Global Platform error codes used in this driver */
 #define TEEC_SUCCESS			0x00000000
 #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
@@ -249,6 +265,7 @@ struct optee {
 	bool in_kernel_rpmb_routing;
 	struct work_struct scan_bus_work;
 	struct work_struct rpmb_scan_bus_work;
+	struct optee_version_info version_info;
 };
 
 struct optee_session {
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 0be663fcd52b..07c703609320 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1323,7 +1323,8 @@ static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invoke_fn)
 }
 #endif
 
-static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
+static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn,
+				      struct optee_version_info *version_info)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -1337,6 +1338,12 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
 	invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
 		  &res.smccc);
 
+	if (version_info) {
+		version_info->os_major = res.result.major;
+		version_info->os_minor = res.result.minor;
+		version_info->os_build_id = res.result.build_id;
+	}
+
 	if (res.result.build_id)
 		pr_info("revision %lu.%lu (%0*lx)", res.result.major,
 			res.result.minor, (int)sizeof(res.result.build_id) * 2,
@@ -1727,6 +1734,7 @@ static int optee_probe(struct platform_device *pdev)
 	unsigned int thread_count;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
+	struct optee_version_info version_info = { };
 	u32 max_notif_value;
 	u32 arg_cache_flags;
 	u32 sec_caps;
@@ -1745,7 +1753,7 @@ static int optee_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	optee_msg_get_os_revision(invoke_fn);
+	optee_msg_get_os_revision(invoke_fn, &version_info);
 
 	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
 		pr_warn("api revision mismatch\n");
@@ -1814,6 +1822,7 @@ static int optee_probe(struct platform_device *pdev)
 		rc = -ENOMEM;
 		goto err_free_shm_pool;
 	}
+	optee->version_info = version_info;
 
 	optee->ops = &optee_ops;
 	optee->smc.invoke_fn = invoke_fn;
-- 
2.43.0

