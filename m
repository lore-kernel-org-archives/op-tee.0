Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FC4CF45C5
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 19:41:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 13B1243284
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 19:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1768246870;
	bh=w8Br0L/bvT0WYuEE5EQYLkiDsJ01wSvNIL/fKdsiaN8=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=EEzzGWhcl7qkYj2ym7IjQYEnFEqHHo+rlBXj4EdnSURHLFfqePPbqgjgW3UV6BNig
	 cZw/X+DzPt+8uJbPchuZKqIk0xsVGK1rV6HqpOjviLQ6i1IYPDjVwANeRLKco1SLBW
	 ldG1451M47IoArOxPRviA8WYx0rweC8UgXWDvNfv/7LC6U49J85JbR8KulA7edK3ka
	 ngjFWx/NX29kBCE2RkVwYMcwjE/hCFbfWrw2DsEm/aIrtWJAXU7Mhj26p5HI7tBTDa
	 yndKJ3keH2a0p1CQ2u9R1VkeDIIjhbfaP9pUfA67WcZDSGi3EngFD/KgCRRc42gQfs
	 e8ypgR9Zro8rg==
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AC49D43252
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 15:48:45 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ZuTRCtXC;
	dkim-atps=neutral
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C70F33F2BA
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1768232924;
	bh=xi3tAFA0h0hr2WA+gvytumViirCUvRbeCoU37OBza2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=ZuTRCtXC38idZ76274gW0D987eF3psAQEGGCfRDCAFl65E+sxm4/rKzW7rvz+Sf2y
	 1CcIqqXQ67Hr20LsU37nYZJKZ0yUBHUz6/v2kvqH8j5zgvRuBqLvNmvUqwJwhHgGM/
	 +/NVIB3sZowUvSeGz+biJsZkjyQfVTJIIB17ACahn/UZlBGfZWEZykzXUueUAqk/lP
	 j/wmq7GtPKUIogUP9etKnsxHjyqjWvd37wpzqK0oDfDlbrFt3T7gt4sCcSbChpTDge
	 lKWKyEbycxrZWV/STKOrjgCj5KIm/IUg+dUKfnDAxUjvZ4z/sT6kUIdczl/ayxub2c
	 BHvN/g3X0fkT2um3MWVMyyYvsW5It+M50Sq+unWk52OTpEc1r7+AxmqQzPMcdAec4O
	 WJYkAia30NpzZ3KVKyZW0d3GT0YaDFmuubey0YmYDvykApk8F59DPSr4RoOFqUCrnF
	 t7gweHPe3QC63y0u+1yaGgmhrr6sjCo5StafwrhM4sn6XIevgJV0JC7ESTXG7as/7r
	 W7STWwMKtlB7HZ0yix2Zy98uF/ZPZy5qVIrdjOG0alRodkPLH9dj6TWmI1ND8yxN3D
	 sOOqT1kjfiwPLrSjQB0Zr0kBpL7VuGtTk6T4z0z/SfWKyj0L2G7fR3AuTZU2qFjJNj
	 j5wEb/4DAHtYDbufnVeH8nnk=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f13989cd3so153793675ad.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 07:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232923; x=1768837723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xi3tAFA0h0hr2WA+gvytumViirCUvRbeCoU37OBza2k=;
        b=VTjCRz8aUQIanitq+gQpIVc00QW8xvd8KOD1OsM3UD3dZq7F3H+Wne5lRlarSlPX+f
         dsk98XJRg2bBY+hoPvSMIOSm43Y5QiYSIasbn8kNrGtCnbLLG6XQWpG9ZAYR2EKbJPbI
         S3qp0lAJXWzNLySpy4BUzJbMRZzyFViNnUGkI544htLBAWRogPd4urDOTm6UGWnXJGGm
         kUe62evg0f3rXJk6dokhnKPKYxYRMuNXN62kv2ZAzvoF3g5OHRRhbcnWfFSVBeFbSY/F
         LlfzfFsew1jdOn2c0wmSS1moekhGjoLYWSobzR5TARLaxq105c0sWfzkC78iQ06Tpom1
         4opg==
X-Forwarded-Encrypted: i=1; AJvYcCVr1hH6ciUmEcrX4qKmLiBIHPDz4jBvHeLEFvHUKWznYbWyv7kKyRNvRtIDqy9q6j2iNZoZckw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzBtEacJa+uejWtxqwZu4Wi4NEM/SjvjsOSy0VwsMUk3RoLFenF
	lkRqGCft76gxmiTO+qR2me2Qxn4wHR/AMuI7w4PdtQIvE6qUQZv62Kk3PYDo4AV9ZEMBLaAJ9al
	jbU7cgiaXOwDnxPODvrLFkfiRA1ekUUbvikX1F9Bu48SPlZ1MqThblO+AH/f/dhrwsrTTnjGwrS
	uXk/shWKruynI=
X-Gm-Gg: AY/fxX4+y/6hSOFnn5cnpbJL93HwqIe0oeLdILGCvEDS+ZLngygUU8pNGbxJHjqm5Mg
	8/llTpEXXr9XrKy8zUztqJO9Wr0XBXhM2DtnWDvcY/8eGfLSjLmFdQnLOQy6gprA7TojmWYrZhC
	nZWOv8ZttWOMmKD7BULjksd6D7KOy+cuRulJxx+eCghs2eq7lWLlpavjfj2KYssSDIVYC9PhlDw
	y1S9xgF8gFCSmTF37Y+cJlen/EGI7m2TNFYpMTW6bFv4VC+A1MSZG3/5Qot/0UA65XTA23T8UWj
	dMmqCKtJCPl0FgtShYjTj66iN9vBDohb0PQtc0+43Qq2bZFluaponelQjZ6ktccX/8IlGsBmoJI
	H4xQMyP5GChs09fgfi8W2XdHUGSute0+1v7cbp0nl07xamQGBYDM42ClRrdoye5sTfjEnpQSKmG
	b3
X-Received: by 2002:a17:903:2f92:b0:2a0:8be7:e3db with SMTP id d9443c01a7336-2a3ee42890dmr169947735ad.15.1768232923274;
        Mon, 12 Jan 2026 07:48:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG/Bdn9kh6d1Xbnfdr5evlOqrHZcbZ2VvlEKi2xSB4T5mW6NERFUM50hkryRjTdzpYjRmIIw==
X-Received: by 2002:a17:903:2f92:b0:2a0:8be7:e3db with SMTP id d9443c01a7336-2a3ee42890dmr169947465ad.15.1768232922877;
        Mon, 12 Jan 2026 07:48:42 -0800 (PST)
Received: from aristo-PC.tail872496.ts.net (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2debsm180204745ad.65.2026.01.12.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:48:42 -0800 (PST)
To: linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] tee: add revision sysfs attribute
Date: Mon, 12 Jan 2026 23:48:29 +0800
Message-ID: <20260112154833.78546-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108064517.13854-1-aristo.chen@canonical.com>
References: <20260108064517.13854-1-aristo.chen@canonical.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:185.125.188.123];
	RCVD_IN_DNSWL_MED(-0.20)[185.125.188.123:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.199:received];
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
X-Rspamd-Queue-Id: AC49D43252
X-Spamd-Bar: --
X-MailFrom: aristo.chen@canonical.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: A6TL46R73NAVQXGDEIAPBUWDD2M4SED7
X-Message-ID-Hash: A6TL46R73NAVQXGDEIAPBUWDD2M4SED7
X-Mailman-Approved-At: Mon, 12 Jan 2026 19:39:40 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/A6TL46R73NAVQXGDEIAPBUWDD2M4SED7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Aristo Chen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>

Add a generic TEE revision sysfs attribute backed by a new
optional get_tee_revision() callback. The revision string is
diagnostic-only and must not be used to infer feature support.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 Documentation/ABI/testing/sysfs-class-tee | 10 +++++
 drivers/tee/tee_core.c                    | 51 ++++++++++++++++++++++-
 include/linux/tee_core.h                  |  9 ++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/ABI/testing/sysfs-class-tee
index c9144d16003e..1a0a3050aaa9 100644
--- a/Documentation/ABI/testing/sysfs-class-tee
+++ b/Documentation/ABI/testing/sysfs-class-tee
@@ -13,3 +13,13 @@ Description:
 		space if the variable is absent. The primary purpose
 		of this variable is to let systemd know whether
 		tee-supplicant is needed in the early boot with initramfs.
+
+What:		/sys/class/tee/tee{,priv}X/revision
+Date:		Jan 2026
+KernelVersion:	6.19
+Contact:	op-tee@lists.trustedfirmware.org
+Description:
+		Read-only revision string reported by the TEE driver. This is
+		for diagnostics only and must not be used to infer feature
+		support. Use TEE_IOC_VERSION for capability and compatibility
+		checks.
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index d65d47cc154e..0a00499811c1 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1146,7 +1146,56 @@ static struct attribute *tee_dev_attrs[] = {
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
index 1f3e5dad6d0d..ee5f0bd41f43 100644
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
@@ -95,9 +98,12 @@ struct tee_device {
  * client closes the device file, even if there are existing references to the
  * context. The TEE driver can use @close_context to start cleaning up.
  */
+
 struct tee_driver_ops {
 	void (*get_version)(struct tee_device *teedev,
 			    struct tee_ioctl_version_data *vers);
+	int (*get_tee_revision)(struct tee_device *teedev,
+				char *buf, size_t len);
 	int (*open)(struct tee_context *ctx);
 	void (*close_context)(struct tee_context *ctx);
 	void (*release)(struct tee_context *ctx);
@@ -123,6 +129,9 @@ struct tee_driver_ops {
 	int (*shm_unregister)(struct tee_context *ctx, struct tee_shm *shm);
 };
 
+/* Size for TEE revision string buffer used by get_tee_revision(). */
+#define TEE_REVISION_STR_SIZE	128
+
 /**
  * struct tee_desc - Describes the TEE driver to the subsystem
  * @name:	name of driver
-- 
2.43.0

