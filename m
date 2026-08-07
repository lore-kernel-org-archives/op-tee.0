Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA25C5AD4E
	for <op-tee@archiver.kernel.org>; Mon, 10 Aug 2026 06:28:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 594ED45390
	for <op-tee@archiver.kernel.org>; Mon, 10 Aug 2026 06:28:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=skApP7gZ;
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 570504423F
	for <op-tee@lists.trustedfirmware.org>; Fri,  7 Aug 2026 17:51:01 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-476a130c138so3181362f8f.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 07 Aug 2026 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786125060; x=1786729860; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmhy6Tcc7C5YHQJuzsd/r0Pq9Doq6mlOSeIDrzdteII=;
        b=skApP7gZZusWvFnO2rbhY8cYYpQpZ8Y5G4TcbbHIPwW53JW1NlAo9li25ZtoYtbrRZ
         NAuRvi+Rc3nPXgccaXBBm7/S+wCgED+5+hW0scgHTfxHlucdoRF4l2RkMV8YramlDhWI
         EHjjdiNOE8k5lHy+Gp0KQcPcF+NtvO2EbNe12lpII7KSBaeJyHOXqkp07DydbwZAUU5M
         QFWjFo2403WLE7MJ2PrE1uyOG09r49cksZ4eoSG1GrS9OBR9ATN0w8WsnInzx+S8Bq49
         WKeXd32EgmmGcCeXzu0ZtTnk8ca/5WLJ7iqv47XBD++xQPnTa9qo6GZVHSuql8F35tsO
         PQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786125060; x=1786729860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kmhy6Tcc7C5YHQJuzsd/r0Pq9Doq6mlOSeIDrzdteII=;
        b=BcS4oEUH+esHwD58X9rWjh6d+YTQvPHQS6gxjxa2EvLykglyvP34cm+3SoutBH2Tx1
         74vVi1VkimTTqlQmdc+Ahr/S8eNuZQrCKs83EWZdu5AeerAlLc2CKN/PJDrT0feLoyYH
         2SuiFKCUh08v21TIiAcaLRXDwObVvj4mkMoVy2xG7oSFJegGOp1yoX8YUH7x7UnRDMRA
         CCQ8KadM6l7xQk0hs5qK+LZ2sEZHJn5rdn4diP2bgVL+QTqDFW/c1iYJHe+RTCCSN802
         XrrTVLqQFIXhLzHD5hDGMRmHct5ylBAMJ8ZVdDbjSQiba3Ll9S7KdAz/Xf259J69GH8Q
         gH6w==
X-Forwarded-Encrypted: i=1; AHgh+RqFEguugg17RHIC321E24vMJpVChP2CYw28omyxa1uoFkRLsJYFAoff1RJaAejz3Z7NFTfYbTU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy73EsvplkE/LEQD+dWbVBFf4L2ifqrU/OJopaTdIdeUDanbYCK
	HyJeSjY8jmzRhpiXNRA8tmM+rjZORhEOjjhM49N2lw3KVmVpwkAxwfbp
X-Gm-Gg: AR+sD11aJYJsoP4g2DcYlG6smp33UwyMT7FO+0MDX8A978H5/hBbtfSYFlrLJtvC90A
	DHmQVqDdzN78Fqp6B04EC/ojkjlDYwDVlDv9ApyJjTmQkbzq53hmcnXUuusqf6kjL3q6dPYtZJN
	pKcawWTdje86dLinZG0NwB/uPqiEhe2dn+fKDsyhhWwtQBESh0rJQq98W0defNlrHkOm3QfV+Ly
	72VqWaKdDi3IbdOIiLXymJAUqpCp4GBgF4U9dP/KwVuZvqMARJQ1EMwVu7XJmVJ9c4YvaRySp49
	sgJGFcsAGIc+MhA8UhcM+xhrofT9pigFH8o9pH+/voCq544YZ79wiO6mzp5uZVZvkJy5cWduVN+
	Q6zK2wQM1IqQ39B/xATW3ysSIetb42sK8w6pynnb8T0sWlWmkhStgMnCC4pvzGpuF/ELmD29Wqa
	AU2AXwH+EalFaFNeTo79lCrWRxWyzMiOmo/ktM77eGby8RgfFVZgGehWpsz/KG3PJCuDrGQuexf
	/Fk1FPmDcrvGXTG9h5g0LztNU5VO17FPUaZdWNNDBPeROc7UoiY
X-Received: by 2002:a05:6000:4212:b0:47f:81a9:3f36 with SMTP id ffacd0b85a97d-47ffd924dffmr15543175f8f.18.1786125059910;
        Fri, 07 Aug 2026 10:50:59 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8cd0sm7901243f8f.17.2026.08.07.10.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:50:59 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: amirreza.zarrabi@oss.qualcomm.com,
	jenswi@kernel.org
Subject: [PATCH v3] tee: remove TZMEM_MODE_GENERIC
Date: Fri,  7 Aug 2026 18:50:41 +0100
Message-ID: <20260807175041.3299349-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,glider.be,oss.qualcomm.org,lists.trustedfirmware.org,vger.kernel.org,quicinc.com,oss.qualcomm.com,linux.intel.com,gmail.com];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.43:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.43:from];
	TAGGED_RCPT(0.00)[renesas];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 570504423F
X-Spamd-Bar: -
X-MailFrom: julianbraha@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: K2WCS752MNDS4PU3JA5EXH2J25H5TI27
X-Message-ID-Hash: K2WCS752MNDS4PU3JA5EXH2J25H5TI27
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:28:48 +0000
CC: sumit.garg@kernel.org, arnd@arndb.de, geert+renesas@glider.be, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, quic_eberman@quicinc.com, andersson@kernel.org, brgl@kernel.org, harshal.dev@oss.qualcomm.com, nathan@kernel.org, nsc@kernel.org, jani.nikula@linux.intel.com, kees@kernel.org, Julian Braha <julianbraha@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/K2WCS752MNDS4PU3JA5EXH2J25H5TI27/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

'select' does not work on config options in a 'choice', so currently it is
possible to enable QCOMTEE without QCOM_TZMEM_MODE_SHMBRIDGE, even though
this is needed at runtime.

There are no users of the generic allocator option,
QCOM_TZMEM_MODE_GENERIC, so let's remove it. Then, we can remove the
containing choice..endchoice, which allows the 'select' to work as
intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
Changes since v2:
- add back stubs for when CONFIG_QCOM_TZMEM_MODE_GENERIC=n
- updated help text accordingly

Link:
https://lore.kernel.org/all/20260729203845.387239-1-julianbraha@gmail.com/

Changes since v1:
- remove TZMEM_MODE_GENERIC instead of removing the dead select

Link:
https://lore.kernel.org/all/20260715092539.18384-1-julianbraha@gmail.com/
---
 drivers/firmware/qcom/Kconfig      | 26 +++++---------------------
 drivers/firmware/qcom/qcom_tzmem.c |  4 ++--
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index c7f8413ab996..95b968d88dc3 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -34,33 +34,17 @@ config QCOM_TZMEM
 	tristate
 	select GENERIC_ALLOCATOR
 
-choice
-	prompt "TrustZone interface memory allocator mode"
-	depends on QCOM_TZMEM
-	default QCOM_TZMEM_MODE_GENERIC
-	help
-	  Selects the mode of the memory allocator providing memory buffers of
-	  suitable format for sharing with the TrustZone. If in doubt, select
-	  'Generic'.
-
-config QCOM_TZMEM_MODE_GENERIC
-	bool "Generic"
-	help
-	  Use the generic allocator mode. The memory is page-aligned, non-cachable
-	  and physically contiguous.
-
 config QCOM_TZMEM_MODE_SHMBRIDGE
-	bool "SHM Bridge"
+	bool "TrustZone interface memory allocator: SHM Bridge"
+	depends on QCOM_TZMEM
 	help
-	  Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
-	  in the 'Generic' allocator but is also explicitly marked as an SHM Bridge
-	  buffer.
+	  Use Qualcomm Shared Memory Bridge as memory allocator. The memory has the
+	  same alignment as in the 'Generic' allocator, which is used when this option
+	  is disabled, but is also explicitly marked as an SHM Bridge buffer.
 
 	  With this selected, all buffers passed to the TrustZone must be allocated
 	  using the TZMem allocator or else the TrustZone will refuse to use them.
 
-endchoice
-
 config QCOM_QSEECOM
 	bool "Qualcomm QSEECOM interface driver"
 	depends on QCOM_SCM=y
diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 0fd9581275f1..510474902c3a 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -50,7 +50,7 @@ static struct device *qcom_tzmem_dev;
 static RADIX_TREE(qcom_tzmem_chunks, GFP_ATOMIC);
 static DEFINE_SPINLOCK(qcom_tzmem_chunks_lock);
 
-#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_GENERIC)
+#ifndef CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE
 
 static int qcom_tzmem_init(void)
 {
@@ -67,7 +67,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
 
 }
 
-#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
+#else
 
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/of.h>
-- 
2.55.0

