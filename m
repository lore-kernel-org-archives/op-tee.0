Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FE1C55174
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:18:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 024094527D
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:18:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=permerror header.d=gmail.com header.i=@gmail.com header.a=rsa-sha1 header.s=20251104 header.b=obAysOHu;
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DD8C944AE9
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 09:25:45 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so4536894f8f.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784107545; x=1784712345; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ovJrXpSfHO8fBtujw3rJb36LBIDFUPdMRQjx6wmbzE=;
        b=obAysOHutlxIOstEvXN8+GNjmn1+s9MpUH1iDPGHpvL6UklsoApMR8hE6DTGR6ihyo
         1wd+0foDdJGIq44ibc04+hYUW5gLvIJeCirJ3nEN2QkfbrzY3wE8kEV9P6McB19uMzpO
         kE0yPzi0Xq8/Ft2jsvhhpaQDCEO+gz1evf5X9J+THAn1xiq2dVQqV/ye2xD/bqrXSD9z
         2sUZPxsWEYnkkLkJcGpGbx3rAsQOnougmNd1NT8JPeePtFxZfrFx3SeH6yX4RaBhG46r
         XGyArR53o8eSVtyjC5f/vIpC1Z9udUyKsUmtYSGM9YfpKmlXI19W2mX9vGpgi26iCxUf
         MXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784107545; x=1784712345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ovJrXpSfHO8fBtujw3rJb36LBIDFUPdMRQjx6wmbzE=;
        b=IAyu4rAagusfk8QRvMHMalNmER6WHtObfm245rEG9hFPkMJ9Zd7UWryza/91pweizG
         sYbEbvbMdgB1Yu/8+2ipCmOyyFolzrwd3ZZ3JnN3Ij48XsMFVeJE0bQOhFXdIqXmP3+y
         lwGVrGRycmGCJdMTWsGLuCRFVZ0w5oiKPeOhUaNcLkWiiy1wvovw/fiEj1t8Ua35Zu5G
         OZnWpHCdjDD+u3V3R3bpupM2HAA36+Kq2G6JkP8ssb/FB0LLJPPGQljNmD5CwSHco+4j
         GL1yk1IDqxbM63H8IcJ+3NiX6zKDUtTfNpRVvaaCpvZG6vNXzrn6ulr17KZlOrxvqPim
         mzSg==
X-Forwarded-Encrypted: i=1; AHgh+Rrz7PYJyNx2/Dfk7EzQU4+hkkaso30MVWnoP/Fb+LAd1cDbuJyVltwZp2loFmRrxW3N+yr1uuE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzHrqXzId2CExARbLWTWNeD9BWpNT85wvsOfyc3I5UIDR0sfC9T
	5aP9C/ldWtdmtwqsspyKlS9+1YOliiWkznPHovnhJEEEFFU0vb3mIadg
X-Gm-Gg: AfdE7ckVcI5kxIcch6JjdfqxD5e6D3j1/U6n/06UrVzPCxXcjzG5gk1uk2DTMJCs++s
	NSuckUDcnjsEr2EkTcNiLcDtOQ267o1MpQQFgybr3UpvRyKZZohKu1WaiQwpncgV6fsEDz6uZS3
	AUAwpktzSB7IhWKghZFnQ6nCNiCDWDk3BAKszRw++83B4s9J+9PG9BBv78xJ1Oo2ltrj4Z8wRrL
	ChVEGVtYt+gj0siBpfoYR4Iu2xRoS7B8cWX9TbzAObm/WRSmveeGol4Ev/rIz9O/N4DJDFbdDL3
	fgflRiSKSyxENJcSR8jIL/V5GGFeRyTo6jWJz5F4qcP9OsTFZHPUiriLu0MBSk8GFAz8CPv9tfC
	/xUBgVF9HTYt4oTfDHzD2tqx+jX8qDfBxSViY2xXDp8F1wx/UH/92zd7HEo/yv18B3cg8qFW80X
	4kAPHaNsPGa72QVJoWnYHSEOT0VZa7IMJRDeIzwv4m6YpRtqX3
X-Received: by 2002:a05:6000:22c7:b0:47f:4fbf:7b21 with SMTP id ffacd0b85a97d-47f4fcc8715mr2253825f8f.12.1784107544465;
        Wed, 15 Jul 2026 02:25:44 -0700 (PDT)
Received: from nixos-office ([89.214.146.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464caeffsm13902009f8f.36.2026.07.15.02.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 02:25:44 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: amirreza.zarrabi@oss.qualcomm.com,
	jenswi@kernel.org
Subject: [PATCH] tee: remove dead select from kconfig
Date: Wed, 15 Jul 2026 10:25:39 +0100
Message-ID: <20260715092539.18384-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,glider.be,oss.qualcomm.org,lists.trustedfirmware.org,vger.kernel.org,gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.54:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-0.974];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.54:from];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DD8C944AE9
X-Spamd-Bar: /
X-MailFrom: julianbraha@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: BPLTSILAUN2TM3N5JQ6ZSTQ63P6B72KB
X-Message-ID-Hash: BPLTSILAUN2TM3N5JQ6ZSTQ63P6B72KB
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:07 +0000
CC: sumit.garg@kernel.org, arnd@arndb.de, geert+renesas@glider.be, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BPLTSILAUN2TM3N5JQ6ZSTQ63P6B72KB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

'select' does not work on config options in a 'choice', so currently it is
possible to enable QCOMTEE without QCOM_TZMEM_MODE_SHMBRIDGE.

This patch removes the select.

I've compile-tested this and found that it builds fine without
QCOM_TZMEM_MODE_SHMBRIDGE, but I don't have the hardware to runtime test.
Please advise if it would be better to make QCOM_TZMEM_MODE_SHMBRIDGE a
dependency.

This dead select was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/tee/qcomtee/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tee/qcomtee/Kconfig b/drivers/tee/qcomtee/Kconfig
index 9f19dee08db4..00e07ed80138 100644
--- a/drivers/tee/qcomtee/Kconfig
+++ b/drivers/tee/qcomtee/Kconfig
@@ -5,7 +5,6 @@ config QCOMTEE
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on !CPU_BIG_ENDIAN
 	select QCOM_SCM
-	select QCOM_TZMEM_MODE_SHMBRIDGE
 	help
 	  This option enables the Qualcomm Trusted Execution Environment (QTEE)
 	  driver. It provides an API to access services offered by QTEE and
-- 
2.54.0

