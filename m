Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15C5E9412E
	for <op-tee@archiver.kernel.org>; Tue, 30 Dec 2025 09:04:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E4FF04187A
	for <op-tee@archiver.kernel.org>; Tue, 30 Dec 2025 09:04:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JEQqpsDY;
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 88F304184A
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Dec 2025 05:21:30 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a102494058so52221425ad.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 29 Dec 2025 21:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767072089; x=1767676889; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNidwSG0yf8kDbKbE4MsUauW5ztIJtpjcHMpWs+5C74=;
        b=JEQqpsDYeETiXkHhHTyOsy4z8JvCvPoshw+1PlBGXoGyqcpcnzZmLqMMHfrDQFvxVg
         +/tZI1htXQLDkmdM+PpcJ8EuO76g4+iChyNjuhjQolQmi+e0MqBBxAeBdafKpT+IPk2K
         sqm8qGRBnBdUKDsTt8kb7D8b9bz2ZHitivj8fRyQqer2dw9WFGdseBtTUjXR7APrv5A1
         i9Ph0hiFKKUGitrnbBBY7kf0BO4mDYVvdjvxuk4uLRXQw78IOKbQDU6+xbTHQrOdS6aI
         WrcG6WeCOw97MaY+wl/0MQAX2bmGySOF6H52+zfW5NPCElntoacbId+2BTu/xbT60aRM
         MU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767072089; x=1767676889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eNidwSG0yf8kDbKbE4MsUauW5ztIJtpjcHMpWs+5C74=;
        b=k3KNRzIERSU5VnBU73jO2Spe2Khc24OOUv+gEWlNGZJWEf3osdKhaWhqKJrqwN2KR8
         +vy7HYgxdYaXka3DDUPcgyH4jpn8OUvZxkVySRRpe7B3QVdtkWhMrAad8eSyb6f8zMeK
         Lqfi0KYj6913MVu/GZjLE7tS5HXM2slr7V0EYF6vuqZc98XhGvFenfqsLN8zPvwC4tPB
         3Q1JScKRM/Ji/AM1YS8e+KLQDZ3SVDNVQjnA/YFd9c2Zf6Szj7Ht+pf+K3geLIwtejxe
         KmmFy9TFdjUp86r+HzpwpxC0hH/6UfMaNMvtYfoleKznaUmxKPlNdhW+GO3Dljm1Hzgc
         bzxw==
X-Forwarded-Encrypted: i=1; AJvYcCUGHM0mjvoggadRlt/nbrzvzvEEYtXWq5dUNhK4CYAyi17cQeKqi8T9uIGx7xf5QBh3hwWuVGo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyANZZDVpMWIoBkLQ1xP6LOfcq/TH2ChcbrUTGvFemDiNwQMk72
	qUMdgk/eehli/9JDRIvaL9Pys7x2d1G595IDrTVPAEwgiX8kWZs3lc/n
X-Gm-Gg: AY/fxX7iBSGkrSQcLddp21IurjCO7jde9G8CM5za0b2M1riMszC5LgkFjpzPiMRmHxM
	Cec80LSr3EnFAPQZcxxtItrNDUsA1n7xjZOcYUuxr8r3UpHhjHhDbeI8isnBG4Fx3FUrAd3wdvp
	LDgEuSFGH4QEL9Gkcv95wvSBFcd4ILgSJe0hdQXV+yMUJxUIj7IA7Mtu24F1A2xbt29OxXezztn
	jENwNP49DgAMBumuJBe3K36yMumZKCrwEvx2PLFaUojHvrgsNC+5ocFmVcwcgQyWFz4df7G7nxh
	ezlWsE0KhUGI0gWax6nill64SFtzF4KLQGDxHqcQ5R0BWW6PqWjNGVny9m+1lbx5nBgrBLNGbEf
	25GALcEVpKYy56RSjd16qsqu2YtrQOGVD4qo0qg1QicOykS7akbj2jvDP29ju6WXucIBo8VsooP
	zR8iZbDDXg2SUR4Gru12OuHKWP9/qlHzMgHE/juPnowkZfeanNjHoAmVKbpLusxucg2iwiE0F2Y
	F+eBw==
X-Google-Smtp-Source: AGHT+IEsl88WLrOitDxeexF58fFSiCQFUmI5BDiG2Uq2WLHmUEuNwU0nzVf0xtUy4Y4XLUI0uumZ1w==
X-Received: by 2002:a17:902:cccd:b0:2a0:9238:881d with SMTP id d9443c01a7336-2a2cab15ebdmr433482245ad.15.1767072089479;
        Mon, 29 Dec 2025 21:21:29 -0800 (PST)
Received: from aristo-PC.tail872496.ts.net (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66465sm291695105ad.15.2025.12.29.21.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 21:21:28 -0800 (PST)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] tee: add revision sysfs attribute
Date: Tue, 30 Dec 2025 13:17:58 +0800
Message-ID: <20251230051804.6230-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251226131920.64582-1-aristo.chen@canonical.com>
References: <20251226131920.64582-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.175:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.214.175:from];
	BLOCKLISTDE_FAIL(0.00)[124.218.37.86:server fail,209.85.214.175:server fail];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 88F304184A
X-Spamd-Bar: --
X-MailFrom: jj251510319013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 7Z2OSQCWE73UDTMSLWOKKFSDO6KOA2MQ
X-Message-ID-Hash: 7Z2OSQCWE73UDTMSLWOKKFSDO6KOA2MQ
X-Mailman-Approved-At: Tue, 30 Dec 2025 09:03:59 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, mario.limonciello@amd.com, Rijo-john.Thomas@amd.com, amirreza.zarrabi@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7Z2OSQCWE73UDTMSLWOKKFSDO6KOA2MQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add a generic TEE revision sysfs attribute backed by a new optional
get_tee_revision() callback. The revision string is diagnostic-only and
must not be used to infer feature support.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 Documentation/ABI/testing/sysfs-class-tee | 10 +++++
 drivers/tee/tee_core.c                    | 51 ++++++++++++++++++++++-
 include/linux/tee_core.h                  |  8 ++++
 3 files changed, 68 insertions(+), 1 deletion(-)

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
index 1f3e5dad6d0d..c214c38898ca 100644
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
@@ -292,6 +297,9 @@ struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
 						phys_addr_t paddr, size_t size,
 						int min_alloc_order);
 
+/* Size for TEE revision string buffer used by get_tee_revision(). */
+#define TEE_REVISION_STR_SIZE	128
+
 /**
  * tee_shm_pool_free() - Free a shared memory pool
  * @pool:	The shared memory pool to free
-- 
2.43.0

