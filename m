Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B6DD148B3
	for <op-tee@archiver.kernel.org>; Thu,  8 Jan 2026 07:10:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 007114FFA7
	for <op-tee@archiver.kernel.org>; Thu,  8 Jan 2026 07:10:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QByur/fY;
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DF13B3F5C7
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Jan 2026 06:45:26 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ba599137cf8so621216a12.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Jan 2026 22:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767854726; x=1768459526; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJMcAkBnNQF1wBYSDLmva6Qf2jsHPkWhYvujYecUWTs=;
        b=QByur/fYPgNe+33f/SVgpOcsIhz/n7TBfc/ff11MszYzoGduA0kx8m4VLVA8H2pvEX
         qFeRU9doNkWMnze79fjBc4tWLvnedkYS6etskzmUxLKG7MFAXG27zzwUWFsFWu9Obk+y
         08MbzajXXcdlGBWVNvoVr+VGgIPddyLXskO5ce674DpX8eXJDTcFB/DpxA7MpJn7tQOa
         Q3Y2YnvCFdEffUUxIdKP/OYINty0gW5IjJxgPVbpUJM1SU3G0Ye2R7L+hF2IOsfOnw4z
         rwEb/fHOgGuPmPM2U+5W9cLo3RiieqSPmMMSkXvDKy7JYMlfGhYES18Wkcaq4bnTEzA3
         C0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767854726; x=1768459526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TJMcAkBnNQF1wBYSDLmva6Qf2jsHPkWhYvujYecUWTs=;
        b=BoEVHqpJ+H7lo3hzzagGZ+taGiU1mkmkuCqSS6mB9ry6TDHpYkARJqoPjrG9zSQSIl
         DwVqiDPAWQcsEhVYxjLU+Li3wrdQZAb5hurjc8WiCnn0zMJ3WxTWiVI9ngoY+9mIUfZt
         m4RUYn3GVa4NRNFQ5vyfwSJLZUHwaCdepnFH6G0NnUqm3vwquuO9dYK/EMTATHLkO+qz
         mCa3h1Le7oeF7fCLF7fkxyDEW6BXcU+mnblDc+VTR+xClXPhvuX7zRe3VCLFUhvt+nRl
         fibEiTtawzIoWrC/EkIJDRgAc370MCCY5bU1KVpE0Bckshc/fjHJNo2kilvDswQjYX2T
         eZBg==
X-Forwarded-Encrypted: i=1; AJvYcCUobCaXGjC9Pi2EN9JB3RVGxwuqrsvrOgkEOMVTtj6+3qtyVa4meewdnn6whLHn1UcM1F0v+hM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyimd5xryrSlYLgwuOR4yTlmNlgNE159AWWkG9+bMadAXUxoIlN
	YrCusYjBDc6Fk9ZNI+NI6L9yzGhVsNFwyJrH2E1JeIXaypBXVj1xVO8X
X-Gm-Gg: AY/fxX6a9U2JKCSJKXRTqWIoIFiirUNvKm37qC8UoAtbHbjrHY41TpIU3eyP7IcgzYH
	f4bvV5bIfMs2JyLY7eKn0WdMEj0gD3iJQt42BBdJYgOsN4MBmS36v3PfSlR9U5kO4dVivPKTFSM
	b4yXXTrux/6UKuU29/S24xxORqV8Q7qgVA4Og1H4wAbtnX/I/a9OvLDG9LHm5MsroydnoDaZFBm
	+8sKvvzmZE3TV349lvk1wXpkhh1YvMiuqoqZwmP21XtXOi1dBB42hcggXR+69VCAZR11GbvMa3f
	RIAvltOJSgUqRxyx+VZ3hcmfKCkcjAJX0Fq9xyomLy1vbZ+H71HWEYBJH+U4iyXuMG9djP3fHaa
	6OMNhCGwAnkpVoyaOwtI7QosIHLvjmusFJDQCql9G1ikLuR5Z5UjfsAe0DgLiGGL0Vl7FjOehxj
	ZuUbrxGNxrJ2Pzw92fygBHFgIHAsKDOaYsvc2pMJr9bAffMKovPgukujoDfq0vytdJWA1MdQTmY
	7HorpFo9UtWeIc5
X-Google-Smtp-Source: AGHT+IG5rrfGdNDl04GsTVd3urtQrRClEYYwKkji8n0/688OpEYTe9PPah3fkmCZe9KaLzPGgWUNBQ==
X-Received: by 2002:a05:6a21:7117:b0:371:8e6d:27e8 with SMTP id adf61e73a8af0-38982b41602mr9302790637.28.1767854725651;
        Wed, 07 Jan 2026 22:45:25 -0800 (PST)
Received: from aristo-PC.tail872496.ts.net (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5dbfsm6813334a12.27.2026.01.07.22.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 22:45:25 -0800 (PST)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] tee: add revision sysfs attribute
Date: Thu,  8 Jan 2026 14:45:08 +0800
Message-ID: <20260108064517.13854-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107152607.902735-1-aristo.chen@canonical.com>
References: <20260107152607.902735-1-aristo.chen@canonical.com>
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
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.215.182:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.182:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DF13B3F5C7
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: TUL4IYYBWBZHAUIWZYXZYNRWQLPCIRNO
X-Message-ID-Hash: TUL4IYYBWBZHAUIWZYXZYNRWQLPCIRNO
X-Mailman-Approved-At: Thu, 08 Jan 2026 07:09:50 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TUL4IYYBWBZHAUIWZYXZYNRWQLPCIRNO/>
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

