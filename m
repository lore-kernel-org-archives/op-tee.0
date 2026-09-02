Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB03C61DD6
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:52:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 038BA4539C
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788346362;
	bh=NRJjfa1oBWJjVwi9irw8swmUSNokXjGSiq7EU4Eu/kY=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=f3stVatRkwvzl3UC0Lz60LDhWV7CGjLvqrjRhe6txiPm5ViglW2VRf9XCXtL1GeKO
	 R0v4HNP08+KbKxya1H7xilTf59VUe/vVFJ1okpi1mLjuWl9VfTwHrOECsfYKRX+6AV
	 NPrrgRahB7JS5KyXbxdOUoUx15ge/LFr3nQ7Cg6qKUGcTn89KHWenD+mJ8QsOx2IZI
	 wPdcM2NSbXyGNnm48Ndv5sPHxPaChoNhftgIfb7TM8dpEdP7HLcj1iueNA4pnrTYdf
	 hiC8Ahk96/8OYWeHR3Uz+qzFsuiNwdX4nPgrZUQ/wVtFGp2cgDKq2NWUBWMMic5QLV
	 QQAQZGWf02Mhw==
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DCD2045040
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 10:51:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ENQ2N6kV;
	dkim-atps=neutral
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2542cd4faaso108882366b.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788346271; x=1788951071; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nz0QJrsFl6sXg/0SkB/zVAyOBBHBg8ebGgd7F8eNZsM=;
        b=ENQ2N6kVVJd0wgf6xjwJEniSfEDfPYouWlnxJFdDiZTpeK6JIUpSu8Glr7VozDLjpS
         zDyOHIzMr7L6ENF2I3UoiQkf4kEUSL34CyXCIWlN7G6WpZHt6LCRl/F/T3Y05SkLhUI7
         M9PgdQIfeidBZ6jB1wl6Bdt+QKlNKdHRx/6Xuvb3tsjup89aIR5GBIRLpsoRVmA5dWuu
         FZIwM5AYDqz2IoBrt/yu/Y1DdewHEweL7iet/bKedbaKwP0LmpW7ljDjDmLduTpdoOmY
         AKiGZZRDuxRSrgzxlukFey0I8qTXj5Z/Sxz3VPqLWBUlsHYs3ciTaxHTpgjv7WPqVkhq
         KJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346271; x=1788951071;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nz0QJrsFl6sXg/0SkB/zVAyOBBHBg8ebGgd7F8eNZsM=;
        b=InUhKVcJHLNtUNvDy80AjojoychsJ22oRQ3vejoBLY5p+vLOufLnYSAdIOfAPUZrdY
         JPaUlJgvdgvTcwj2s7fc8HQzFafGzYKIJ/3UMTpsc4etKOiBa/mDQ9qvGKma7o5aOEN4
         kaeb5II7irQKKc+9niS8J+rFHVX2yVFeRLcA+zFkrvDcOEDQOorM3YdZYc8vZJA076ha
         NZA3c/rw0BjS2OGfLyg8f13c/PvASbIsgR/msvFUyAp/s7Vcl+R0c4tlBe6TWHpABQcN
         NhbOrFoMpOumHIPf/nS/wvzPIBoPKaiR/Y8UNwBxpYIYZdRUVnVbVArMo2BhA5fWaQiS
         vbTg==
X-Forwarded-Encrypted: i=1; AKwUvBzC+83IOAcqtA4sinu5C7Aah/B3uGJ6bUMql3IBQrLJBMWkAL4nVRjAtsjXbBx7kLb8MJ98Nvw=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lXwXBSAojpEeT+zBum1sIqkhNdPhoKmxZJOzzVAiLO1K+qtPsA
	64hxnVo22WUw5TTqehTIcSy66gN5YarG/wTnRTPMEFj10UAbNWky9ZUAzMv5xqyvG7CrXPPv2tH
	RGmF1CC3xJARUqaZsIhUGKA==
X-Received: from ejcz24.prod.google.com ([2002:a17:906:2718:b0:c25:3006:b1a0])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:807:b0:c15:f598:60c0 with SMTP id a640c23a62f3a-c25d544f52fmr257827266b.4.1788346270231;
 Wed, 02 Sep 2026 03:51:10 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:05 +0100
In-Reply-To: <20260902104712.2399797-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260902104712.2399797-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902104712.2399797-4-vdonnefort@google.com>
Subject: [PATCH v9 03/10] set_memory.h: Introduce can_set_direct_map_range()
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org,
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3nv-xagokblkm4fee56fik7ff7c5.3fdfg-k55c9jkj.kiljk5469idn1i5.fi7@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.69:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_TWELVE(0.00)[19];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3nv-xagokblkm4fee56fik7ff7c5.3fdfg-k55c9jkj.kiljk5469idn1i5.fi7@flex--vdonnefort.bounces.google.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.69:from];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DCD2045040
X-Spamd-Bar: --
Message-ID-Hash: PJI4MHZWZGZQGWCERZ4LMVSRYLFW6ZLJ
X-Message-ID-Hash: PJI4MHZWZGZQGWCERZ4LMVSRYLFW6ZLJ
X-MailFrom: 3nv-XagoKBlkM4FEE56FIK7FF7C5.3FDFG-K55C9JKJ.KILJK5469IDN1I5.FI7@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PJI4MHZWZGZQGWCERZ4LMVSRYLFW6ZLJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

While can_set_direct_map() tells whether the direct map can be modified
globally, can_set_direct_map_range() checks if a specific range can be
modified. e.g. if mapped at PTE-level.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 3030d9245f5a..88175c3fa751 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -44,6 +44,12 @@ static inline bool kernel_page_present(struct page *page)
 {
 	return true;
 }
+
+static inline bool can_set_direct_map_range(struct page *page,
+					    unsigned long nr_pages)
+{
+	return false;
+}
 #else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 /*
  * Some architectures, e.g. ARM64 can disable direct map modifications at
@@ -56,6 +62,14 @@ static inline bool can_set_direct_map(void)
 }
 #define can_set_direct_map can_set_direct_map
 #endif
+
+#ifndef can_set_direct_map_range
+static inline bool can_set_direct_map_range(struct page *page, unsigned long nr_pages)
+{
+	return can_set_direct_map();
+}
+#define can_set_direct_map_range can_set_direct_map_range
+#endif
 #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 
 #ifdef CONFIG_X86_64
-- 
2.55.0.970.g62bdec98f9-goog

