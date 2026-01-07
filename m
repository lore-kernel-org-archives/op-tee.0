Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AA4D0D145
	for <op-tee@archiver.kernel.org>; Wed,  7 Jan 2026 17:12:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 765404FF76
	for <op-tee@archiver.kernel.org>; Wed,  7 Jan 2026 17:12:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Dq9YRqHO;
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2C3AE4FF0F
	for <op-tee@lists.trustedfirmware.org>; Wed,  7 Jan 2026 15:26:17 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81c72659e6bso140149b3a.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Jan 2026 07:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767799576; x=1768404376; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz2n6Z9wInqkVzAF2nNuTjml6nk+rOF8YPooFH/pEXM=;
        b=Dq9YRqHOT9mMbscM7tuPtTiNYFC8EeTqUODTIXhl8MMhK7y6vVrfp02qyP+bYDAuT7
         3v1hF3UsuG7F/je5YfMPqlDQ7NrhlgUgVHs7Am3d5wla4xAj0PSHYAkYIRl9/FOYMtwJ
         /Fbl1G0ZFpeOz2WmEov4lMQPNyCD+HjNpHcOzdm8NAuG51WPRgWQLALLg7toHDxIKCpv
         dtewKs9WiHbsCPWXv4BfWH5POeq5TWL32aIEVgYPN9d4U0nO75kWdSKdZv0mnT1Uxs2P
         n83xtWWVK5dTk8dZUszkiqNlBUF+wagyE+7aIpQ5XHDEjJuyzAdeDR11okZqcO3DrHFk
         tndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799576; x=1768404376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tz2n6Z9wInqkVzAF2nNuTjml6nk+rOF8YPooFH/pEXM=;
        b=KnJRtaTuOaEqaOtxT/3f79hEgn9+XqohJyCNIkDNNyEbpUMVMWGj97Z2pHmc+vPqeN
         mEwXz71yLLgdj138PwzZqfAjKcshmIjHcH8DS5YTLsYkiDYge6UPiJOUPolbnd+tC7Ud
         Oa6Wcnf1MwdL1Ms1uJ47eekiw5C27fINYuAK/t4yQOBjw/b6QjS6NtdaeKnztieAtV+j
         eWij/sb3GJo9tAnhhIo89HtkK88hYbUq8ktbSXzSMiIukvlnuN6FqxSA9aNjnFsApwaS
         Lb4S5ocDgcDHOuKqLOSBWT0IpqywNt4sD0UKOYLHZ5zx6nV9H1jxVYoxxeoFOD3xE3Du
         zZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCXeXm9WsK5wqz4FwGw5sLnMI1YcTp/KY4m6zFcUIUp4X+gHvjwIogfuN2HK9kEFfxzhn7lSbkI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwoNK8qzau0DgLP8nixh904VT+yxZ1Vo2B9WwNf8z8zG1I/lnS2
	67vJ9IiZjloy7DImxnLAYIFLuihQP8GCcT1Ue+QL5LUy7xydKP8HlYZe
X-Gm-Gg: AY/fxX6XqWNVyrq/tN7kErSauXuWWKyEtDwvecBSGLfnKmZWHWK8ZyXqK7hq4BGT/aQ
	rVxOsAVrHhI/C6Xa0VSxrdTLuOLS6taLMyir8TV8SBEjWN5qCb/lQqB4iR/bnZ7NcOOz7Zu0gOm
	VoOriZR+CbtJ+ZglH2PBDbNNgVHHKOmrTqAKFVGCRz7+2/YjTYOS1fVfinXtAPCwrmneio2glEZ
	Z98RFulN8gzaCDahKqUyx0nXKekBmpzeI48VZUUAb7yndF0yEQdi6oyV7npPammto54M5JADH8y
	yPaP201Q7mgKJvCdxGnJZOzfdEW3JEbaQGtmhvoWRJOq8+41vIfVcOG1nQsHqfmVB9BFhzgrTZT
	X2DHnvilSneuga1SSSJ13NsYxH1mj+S8yZVVkib+LtAwmkVp5Vc06KCFdn8k6Pi7gr84jmR0OeC
	dv8tmzUEAbBw7bRK6AAF3warCQ5zewucF/XFqaprR5A69oEQQ1q6RNOGHEW64k/EE93sgNX0YFs
	PKBV67a3FcjFzkM
X-Google-Smtp-Source: AGHT+IH9fATTWKXjH3ils7kGAl7ECOMw2IkDV2AahjjjWOIYKAUR6c+mtrXFOa3ZeVNjs9458b7MFg==
X-Received: by 2002:a05:6a20:728f:b0:35d:70d2:1f11 with SMTP id adf61e73a8af0-3898f928f4cmr2614796637.36.1767799576187;
        Wed, 07 Jan 2026 07:26:16 -0800 (PST)
Received: from aristo-PC.tail872496.ts.net (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2c5bsm54957975ad.58.2026.01.07.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:26:15 -0800 (PST)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] tee: add revision sysfs attribute
Date: Wed,  7 Jan 2026 23:26:01 +0800
Message-ID: <20260107152607.902735-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230051804.6230-1-aristo.chen@canonical.com>
References: <20251230051804.6230-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.180:from];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.180:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2C3AE4FF0F
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: EMQ2GY7UEGMPQ2MEA7KTKM7WO6YMT32O
X-Message-ID-Hash: EMQ2GY7UEGMPQ2MEA7KTKM7WO6YMT32O
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:12:24 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EMQ2GY7UEGMPQ2MEA7KTKM7WO6YMT32O/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add a generic TEE revision sysfs attribute backed by a new
optional get_tee_revision() callback. The revision string is
diagnostic-only and must not be used to infer feature support.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 Documentation/ABI/testing/sysfs-class-tee | 10 +++++
 drivers/tee/tee_core.c                    | 51 ++++++++++++++++++++++-
 include/linux/tee_core.h                  |  9 ++++
 3 files changed, 69 insertions(+), 1 deletion(-)

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

