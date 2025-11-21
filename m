Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CA7CFC296
	for <op-tee@archiver.kernel.org>; Fri, 21 Nov 2025 17:20:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 003E64FF3B
	for <op-tee@archiver.kernel.org>; Fri, 21 Nov 2025 17:20:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ec454ZKp;
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 408B33F82D
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Nov 2025 14:13:21 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so2332383a91.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 21 Nov 2025 06:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763734400; x=1764339200; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBNB31SIkytJZ8jrsiUxfeS487frBMsktBBVZg93Bng=;
        b=ec454ZKpKyJ1bZ1UlJ15LF0Jt+uHgTGPE5ExKMgWCB1/rlRPcoHsddXPuM9HXfR6sj
         q54hcxWJkJCNLyPS4rNfUT5UwUnl3g80sPq0eEP/AbBuLKxrxxZs6nYo23BRDrivZ3TX
         dg6nw6QjFfp/sSyNs3W8MArXrpF/UAEXmpERkxRMnpVvtqR4w8yfuFqoQi9rqbZjcUba
         ZDgP3UvEvOnWrsG5J2h2uYqlER5hUntxer2dKUz5v14PmJlLmwi4xi1YSU/sytawHkBp
         GNq07vgzSFOpOb64TcVMzEdeLyqMNwtM6sYgewkAj7Kri1Yhb+SlqTW7YbN62hEmB8EP
         rIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734400; x=1764339200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBNB31SIkytJZ8jrsiUxfeS487frBMsktBBVZg93Bng=;
        b=tpCd1EXN5ynPJm7sL/2YF7BNg6VWYKrrJvMN8SxLl2QpI1SGFizg0mMu0jieLJZx12
         JTMxYgh6eKB6nDZ4nSsKBfye+oCXiJ5edauvkXXmHzM5pJtB3uIkXNKPdxPAPtXcCNis
         5J4gE/60w0Z5kiYkvmEe8hoL55wpbo5fxEwF3wr3bjhZwJoNNUdqVsoVhh8pjeahu8gK
         3OV0SQ4kaMxikrYwpJ+RXA3gV84sYmX8ig2E71pbkOv7lQjInKpGHGudGfugOqWP1QYV
         i6Nma/AR4og3bFY23UXw95ADBodiLgtjenuHupiMkFlBfiFAdPY08RVKULrvBtfn+YYf
         mVqA==
X-Forwarded-Encrypted: i=1; AJvYcCUEIB8WNO3/VNf8Bt1HMZbgp2A1Go3khWk4B9xOCaxy7J9oLxaY0N7AEzG7mjZWtA3Q9j0PYSA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzmyAvgzAloRNg41QofQZll0+5IV/yY/rmYYf2TVJKLQKPSxKBb
	aXm+Lsh/BaklDrGcko+X7S6q4geavnbJEa8L+FKCDXduqzjyEYgiLo7w
X-Gm-Gg: ASbGncu6V8L9eKWShAKS7I2XdddxYbHBJ1oJVN7Y4focFO75g3tV/PAB5HrAmcx7mBq
	G/pRLCLbl0moqoR6szHFDMn8dKeTnALEgLwOH1pxeT58Idj+9XUgttS5vxmhgIXgXlhBI4z6EWM
	PNj7eIMYaxQShR1ikbT02owom6lt/eUwk4pfTnHjgoiEZI5w/y+qtuUi2WS5qp9uZhWRGVPCy93
	V+GgcMGwgukKICa5eJsFQwmAIdoY+JvjutQL1Km4g/EWT9djSChfq108hHOONmbK597mqmYTEUM
	BgBuHOt5R4nB3IgUQfK8UC9zc/nj6wGyc21kwweGfqRgr4Sb6ktVRYbfWbNQ+zuXr9HiRis99LA
	nPGPYfpOv/EWSvZhaGiA6F6BWspB4xQLDz06GjlCxg7Li1xC+I8RTAO7uof9AYxkn+txdVyVM26
	YV1jlnSN8IuKFbxf3zZ9USI8uBCoNdlMz3eYTD8POMUQ+7QlrEpACbu90TKZpyLHKNDUEis5gjf
	+wu
X-Google-Smtp-Source: AGHT+IEgIeHmt6RvEUwRbPYUSYTrp3qSNBzV1eF56VWQ3CV/VtbMfIyb2Pw7dZWXrnFkuwDafbaG3g==
X-Received: by 2002:a17:90b:3d85:b0:32d:f352:f764 with SMTP id 98e67ed59e1d1-34733e6caa6mr2322233a91.2.1763734400155;
        Fri, 21 Nov 2025 06:13:20 -0800 (PST)
Received: from aristo-PC.tail872496.ts.net (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b04f3b8dsm4885040a91.12.2025.11.21.06.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:13:19 -0800 (PST)
From: Wei Ming Chen <jj251510319013@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] tee: optee: expose OS revision via sysfs
Date: Fri, 21 Nov 2025 22:12:01 +0800
Message-ID: <20251121141230.489294-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: --
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 408B33F82D
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.42:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[124.218.37.86:received,209.85.216.42:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[gmail.com:+]
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: G5J6W6OOJTR46UVX4UB7VPY6CQWIJKJK
X-Message-ID-Hash: G5J6W6OOJTR46UVX4UB7VPY6CQWIJKJK
X-Mailman-Approved-At: Fri, 21 Nov 2025 17:19:52 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G5J6W6OOJTR46UVX4UB7VPY6CQWIJKJK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Aristo Chen <aristo.chen@canonical.com>

Today the only way to read the OP-TEE OS version is from dmesg/journal
logs, which can be lost as buffers roll over. Add a minimal
optee_version_info (major/minor/build) and get_optee_revision hook,
collect the OS revision in both SMC and FF-A ABIs, and publish
/sys/class/tee/tee*/optee_os_revision for a stable userspace readout.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 drivers/tee/optee/ffa_abi.c       | 27 +++++++++++-
 drivers/tee/optee/optee_private.h |  1 +
 drivers/tee/optee/smc_abi.c       | 27 +++++++++++-
 drivers/tee/tee_core.c            | 73 ++++++++++++++++++++++++++++++-
 include/linux/tee_core.h          |  2 +
 include/linux/tee_drv.h           | 12 +++++
 6 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index bf8390789ecf..291ba3bfde7f 100644
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
@@ -893,6 +900,18 @@ static void optee_ffa_get_version(struct tee_device *teedev,
 	*vers = v;
 }
 
+static int optee_ffa_get_optee_revision(struct tee_device *teedev,
+					struct optee_version_info *vers)
+{
+	struct optee *optee = tee_get_drvdata(teedev);
+
+	if (!optee)
+		return -ENODEV;
+
+	*vers = optee->version_info;
+	return 0;
+}
+
 static int optee_ffa_open(struct tee_context *ctx)
 {
 	return optee_open(ctx, true);
@@ -900,6 +919,7 @@ static int optee_ffa_open(struct tee_context *ctx)
 
 static const struct tee_driver_ops optee_ffa_clnt_ops = {
 	.get_version = optee_ffa_get_version,
+	.get_optee_revision = optee_ffa_get_optee_revision,
 	.open = optee_ffa_open,
 	.release = optee_release,
 	.open_session = optee_open_session,
@@ -918,6 +938,7 @@ static const struct tee_desc optee_ffa_clnt_desc = {
 
 static const struct tee_driver_ops optee_ffa_supp_ops = {
 	.get_version = optee_ffa_get_version,
+	.get_optee_revision = optee_ffa_get_optee_revision,
 	.open = optee_ffa_open,
 	.release = optee_release_supp,
 	.supp_recv = optee_supp_recv,
@@ -1034,6 +1055,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 {
 	const struct ffa_notifier_ops *notif_ops;
 	const struct ffa_ops *ffa_ops;
+	struct optee_version_info version_info = { };
 	unsigned int max_notif_value;
 	unsigned int rpc_param_count;
 	struct tee_shm_pool *pool;
@@ -1047,7 +1069,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	ffa_ops = ffa_dev->ops;
 	notif_ops = ffa_ops->notifier_ops;
 
-	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
+	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops, &version_info))
 		return -EINVAL;
 
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
@@ -1059,6 +1081,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee)
 		return -ENOMEM;
+	optee->version_info = version_info;
 
 	pool = optee_ffa_shm_pool_alloc_pages();
 	if (IS_ERR(pool)) {
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index db9ea673fbca..967c015e8ffb 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -249,6 +249,7 @@ struct optee {
 	bool in_kernel_rpmb_routing;
 	struct work_struct scan_bus_work;
 	struct work_struct rpmb_scan_bus_work;
+	struct optee_version_info version_info;
 };
 
 struct optee_session {
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 0be663fcd52b..1e412949898f 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1232,6 +1232,18 @@ static void optee_get_version(struct tee_device *teedev,
 	*vers = v;
 }
 
+static int optee_get_optee_revision(struct tee_device *teedev,
+				    struct optee_version_info *vers)
+{
+	struct optee *optee = tee_get_drvdata(teedev);
+
+	if (!optee)
+		return -ENODEV;
+
+	*vers = optee->version_info;
+	return 0;
+}
+
 static int optee_smc_open(struct tee_context *ctx)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
@@ -1242,6 +1254,7 @@ static int optee_smc_open(struct tee_context *ctx)
 
 static const struct tee_driver_ops optee_clnt_ops = {
 	.get_version = optee_get_version,
+	.get_optee_revision = optee_get_optee_revision,
 	.open = optee_smc_open,
 	.release = optee_release,
 	.open_session = optee_open_session,
@@ -1261,6 +1274,7 @@ static const struct tee_desc optee_clnt_desc = {
 
 static const struct tee_driver_ops optee_supp_ops = {
 	.get_version = optee_get_version,
+	.get_optee_revision = optee_get_optee_revision,
 	.open = optee_smc_open,
 	.release = optee_release_supp,
 	.supp_recv = optee_supp_recv,
@@ -1323,7 +1337,8 @@ static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invoke_fn)
 }
 #endif
 
-static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
+static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn,
+				      struct optee_version_info *version_info)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -1337,6 +1352,12 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
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
@@ -1727,6 +1748,7 @@ static int optee_probe(struct platform_device *pdev)
 	unsigned int thread_count;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
+	struct optee_version_info version_info = { };
 	u32 max_notif_value;
 	u32 arg_cache_flags;
 	u32 sec_caps;
@@ -1745,7 +1767,7 @@ static int optee_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	optee_msg_get_os_revision(invoke_fn);
+	optee_msg_get_os_revision(invoke_fn, &version_info);
 
 	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
 		pr_warn("api revision mismatch\n");
@@ -1814,6 +1836,7 @@ static int optee_probe(struct platform_device *pdev)
 		rc = -ENOMEM;
 		goto err_free_shm_pool;
 	}
+	optee->version_info = version_info;
 
 	optee->ops = &optee_ops;
 	optee->smc.invoke_fn = invoke_fn;
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d65d47cc154e..dc23058e7be6 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1141,12 +1141,83 @@ static ssize_t implementation_id_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(implementation_id);
 
+static int tee_get_optee_revision(struct tee_device *teedev,
+				  struct optee_version_info *ver_info)
+{
+	if (!teedev->desc->ops->get_optee_revision)
+		return -ENODEV;
+
+	return teedev->desc->ops->get_optee_revision(teedev, ver_info);
+}
+
+static bool tee_is_optee(struct tee_device *teedev)
+{
+	struct tee_ioctl_version_data vers;
+
+	teedev->desc->ops->get_version(teedev, &vers);
+
+	return vers.impl_id == TEE_IMPL_ID_OPTEE;
+}
+
+static ssize_t optee_os_revision_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct tee_device *teedev = container_of(dev, struct tee_device, dev);
+	struct optee_version_info ver_info;
+	int ret;
+
+	if (!tee_is_optee(teedev))
+		return -ENODEV;
+
+	ret = tee_get_optee_revision(teedev, &ver_info);
+	if (ret)
+		return ret;
+
+	if (ver_info.os_build_id)
+		return sysfs_emit(buf, "%u.%u (%08x)\n", ver_info.os_major,
+				  ver_info.os_minor, ver_info.os_build_id);
+
+	return sysfs_emit(buf, "%u.%u\n", ver_info.os_major,
+			  ver_info.os_minor);
+}
+static DEVICE_ATTR_RO(optee_os_revision);
+
 static struct attribute *tee_dev_attrs[] = {
 	&dev_attr_implementation_id.attr,
 	NULL
 };
 
-ATTRIBUTE_GROUPS(tee_dev);
+static struct attribute *tee_optee_attrs[] = {
+	&dev_attr_optee_os_revision.attr,
+	NULL
+};
+
+static umode_t tee_optee_attr_is_visible(struct kobject *kobj,
+					 struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tee_device *teedev = container_of(dev, struct tee_device, dev);
+
+	if (tee_is_optee(teedev) && teedev->desc->ops->get_optee_revision)
+		return attr->mode;
+
+	return 0;
+}
+
+static const struct attribute_group tee_dev_group = {
+	.attrs = tee_dev_attrs,
+};
+
+static const struct attribute_group tee_optee_group = {
+	.attrs = tee_optee_attrs,
+	.is_visible = tee_optee_attr_is_visible,
+};
+
+static const struct attribute_group *tee_dev_groups[] = {
+	&tee_dev_group,
+	&tee_optee_group,
+	NULL
+};
 
 static const struct class tee_class = {
 	.name = "tee",
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index 1f3e5dad6d0d..4bd9b6b191c9 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -98,6 +98,8 @@ struct tee_device {
 struct tee_driver_ops {
 	void (*get_version)(struct tee_device *teedev,
 			    struct tee_ioctl_version_data *vers);
+	int (*get_optee_revision)(struct tee_device *teedev,
+				  struct optee_version_info *vers);
 	int (*open)(struct tee_context *ctx);
 	void (*close_context)(struct tee_context *ctx);
 	void (*release)(struct tee_context *ctx);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 88a6f9697c89..64a2fea11cb9 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -20,6 +20,18 @@
 
 struct tee_device;
 
+/**
+ * struct optee_version_info - OP-TEE version information
+ * @os_major:		OS major version
+ * @os_minor:		OS minor version
+ * @os_build_id:	OS build identifier (0 if unspecified)
+ */
+struct optee_version_info {
+	u32 os_major;
+	u32 os_minor;
+	u32 os_build_id;
+};
+
 /**
  * struct tee_context - driver specific context on file pointer data
  * @teedev:	pointer to this drivers struct tee_device
-- 
2.43.0

