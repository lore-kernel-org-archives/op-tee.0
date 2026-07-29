Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DE9C55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:22:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 440F645355
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:22:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iDnX6y6j;
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4592944A21
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 20:38:52 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f81a3ccf9so1141172f8f.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785357531; x=1785962331; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5agbD9yaHbXYP0FRJ5aEkP5vHdaFzIC43ZEYtBQ9Cg=;
        b=iDnX6y6jiyCJnGNJtTFi6OjfUTrn4o+YN2TJzO+unS2PLaKVK2e9tQmazm/N99MREz
         wUouY+J1pqiaaI6by2aALrnP0Gm5Vp4m4ve3pOeHXtfMCn2RuGOHeW9hz0yAfRMnPX9C
         m4alSiZ0fCKjts9Y3gIWAhMWF77aaUIN2PHW7V4od7ppobJ45UWeMA6nMqq+03swddKG
         25W8B+EN4/ihfDaOTEZrcXv/ttzUqVPQpDnqd6MqE2RrVCBCKgu+RUto9mJtxkLydZy/
         61KxMdl4PzYrMK02BDPCmCpv3fd/qd+UCcSr54ApkOHHeCzyB/rFBRYSRuNz2muqMZJ2
         4s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785357531; x=1785962331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s5agbD9yaHbXYP0FRJ5aEkP5vHdaFzIC43ZEYtBQ9Cg=;
        b=kousd3poDVz3btIkickfZcH1JG3oPYSde7cEnfNHPuxaHIfdznFOVaKTgc7iqZbKLd
         /Udo7CrJ7DzsODxO6082dLN/IKhTeHMYfN96M4J7qGIskPAJtwGum0jdfS8Ay6KOSYwL
         IcghF/v/xqTd7O/CNV3Tl+YDsXjwK/USokvHetWIEvcZE5GT+aSZQ3WgIzPaUP/w5+4Q
         /Lpl8YH1MnQMbWVGyHLo0dt4vtx1wM0VlctUzUGBCYj3eYpkQCV6Q7fvMTq2tUs2XwZy
         3my4nmSsjrH50OFkFL22WBbsvwZQ7U7C7zhVpgOky/YGeTL8vN/7Co7cdlvcshxeYPQq
         LnbA==
X-Forwarded-Encrypted: i=1; AHgh+RrMX2r3gG5N9ISFw6pWZSWaRuagJp0TMqlEOG23dEztpoPLhrJYdsJvnx2Ec9xEY3vnoX9y9qI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwySZa60jYDQRyqEOrvFldYJgvOmXSxVMpHC7yDcukyDRwdiIHC
	pVemo2i4qhxrc1xQYTyadd1diiPQpaksOyBdYpYVj1BSfLa9NxM5B1SN
X-Gm-Gg: AR+sD10ZBKgECfItj1SdMeQsq1xgpzLekFDogo8wxYQYwpKxgSbyBZWWFcHN+Li7NlJ
	Em0606JBC0Bqix1VDCISNFFxWb1/LzRrQYKVEBUNKjo6RdxFJlf3h1LypwkrEuTJWG0LKdk9aKA
	fyMXazBXkqvhDTWzVA3n1tCavGi9oXiKRx/30NIZ35Anj58f4H7A2n8BwDFVsHxTnrkGM+3Tljw
	qyCNDe4FHAk9h7Wp/xsqX3QWSaNJwMZT/b7tIQoGou9ao4ttdfjcUe031m6UlZqVccPV0bUNuBK
	LazYHD54FSjOzls7yOB5ggVLAYYfmWR2TnlHz1fu+Tn72B/K9YlhCgXVg0e+ANxLVvBGN5xd0m1
	Dhlv7An1siWi1y91GeUNuYWyCL5oWZqqyAAqiCIpbOsGWjwYsuBnf5jkT6xP8VO0myPD27jw7XO
	B9CJGs17xYQvD85mbNAb6UoGDtt2327qIocJ6dCC3FL2qph3IW/7cVA3c0NRw6ORJ3L4tEj+C2n
	sqDHZIyzTNmZQeuvKv3hWcR781Jv5df+Obzht9CQE+t30On7bM0G9KebNnssNs=
X-Received: by 2002:a05:6000:430e:b0:47f:9ac6:c9bc with SMTP id ffacd0b85a97d-47fc6554653mr337068f8f.2.1785357530873;
        Wed, 29 Jul 2026 13:38:50 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b19653sm11358966f8f.30.2026.07.29.13.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 13:38:50 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: amirreza.zarrabi@oss.qualcomm.com,
	jenswi@kernel.org
Subject: [PATCH v2] tee: remove TZMEM_MODE_GENERIC
Date: Wed, 29 Jul 2026 21:38:45 +0100
Message-ID: <20260729203845.387239-1-julianbraha@gmail.com>
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
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,glider.be,oss.qualcomm.org,lists.trustedfirmware.org,vger.kernel.org,quicinc.com,oss.qualcomm.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.46:from];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.46:from];
	TAGGED_RCPT(0.00)[renesas];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4592944A21
X-Spamd-Bar: -
X-MailFrom: julianbraha@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: C4QETPPBUUR6FOWMNGI7PZLBW4P6VEYI
X-Message-ID-Hash: C4QETPPBUUR6FOWMNGI7PZLBW4P6VEYI
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:42 +0000
CC: sumit.garg@kernel.org, arnd@arndb.de, geert+renesas@glider.be, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, quic_eberman@quicinc.com, andersson@kernel.org, brgl@kernel.org, harshal.dev@oss.qualcomm.com, Julian Braha <julianbraha@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/C4QETPPBUUR6FOWMNGI7PZLBW4P6VEYI/>
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
Changes since v1:
- remove TZMEM_MODE_GENERIC instead of removing the dead select

Link:
https://lore.kernel.org/all/20260715092539.18384-1-julianbraha@gmail.com/
---
 drivers/firmware/qcom/Kconfig      | 26 +++++---------------------
 drivers/firmware/qcom/qcom_tzmem.c | 21 ---------------------
 2 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index c7f8413ab996..d99e09c5fa18 100644
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
+	  same alignment as in the 'Generic' allocator but is also explicitly marked
+	  as an SHM Bridge buffer.
 
 	  With this selected, all buffers passed to the TrustZone must be allocated
 	  using the TZMem allocator or else the TrustZone will refuse to use them.
 
-endchoice
-
 config QCOM_QSEECOM
 	bool "Qualcomm QSEECOM interface driver"
 	depends on QCOM_SCM=y
diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 0635cbeacfc8..5b3e5a3ad1ae 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -49,25 +49,6 @@ static struct device *qcom_tzmem_dev;
 static RADIX_TREE(qcom_tzmem_chunks, GFP_ATOMIC);
 static DEFINE_SPINLOCK(qcom_tzmem_chunks_lock);
 
-#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_GENERIC)
-
-static int qcom_tzmem_init(void)
-{
-	return 0;
-}
-
-static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
-{
-	return 0;
-}
-
-static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
-{
-
-}
-
-#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
-
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/of.h>
 
@@ -189,8 +170,6 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
 	kfree(handle);
 }
 
-#endif /* CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE */
-
 static int qcom_tzmem_pool_add_memory(struct qcom_tzmem_pool *pool,
 				      size_t size, gfp_t gfp)
 {
-- 
2.55.0

