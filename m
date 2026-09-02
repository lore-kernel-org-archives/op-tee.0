Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA725C61DD6
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:53:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 315AF45040
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788346389;
	bh=Hjs9VwVCBCQIR9TgAq/HTqzG2ZG5eMRL2SHfgwqwO1k=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=f6Nwj9oVIft/C2ZU/GrMitlFxkWfxl+WBauDyTSIxRPXxMsZKKy1Bu/eUKr9R7q3G
	 4SDAtQVUZ7UHJxIWmNRbF2JYCZPztKfosMJe6Dp18rAwSSewxM9Tb2o+zTuryNzYbt
	 05pSJdLUxbPSL9SmHX7AWWGjhaKS0meCsECeqeFqWc9VnKiZQbA78eu7MIqGSEfVnd
	 nPnRxusW9XJoA1bikk/V4IPh18ztl7B6P6TydiXZOdry89RkU+ptp5U+Af1VabBvOV
	 F/aF+0vgWIB2SpqUYo7S/lj2ondC2mtZiVhSqfRO6pjqVVlyGU6ti5Dt40MnD/MNPN
	 zKKSNbgcB+2qg==
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E41C0450A9
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 10:51:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ik9SxfHy;
	dkim-atps=neutral
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so5332035e9.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788346272; x=1788951072; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9YJxK+goKseFQhyyU1kBZycBjFaImkJiX1HLmgsMgs=;
        b=Ik9SxfHyvj2ynq20LoAQKKgzek2sArwuU6sCkRkdVF3/WKD+NpLL85eoea9erScBiZ
         hWBtXuKfl/Bh40LfNv69rJpwY9IWRcr8stS1nTNTyACzeceG2BB1Ceg7IGNgxjgHnQxT
         9YDMLjn27Yn6ittOnsqkQQQYdrETs4QmHF5ZlFgRfkkxPgrFwP2H3x5YIofhmT4AVrjq
         Yb76PMoXf7epY6p5QJFAfu3eNz86/WUYzKUA7nhT1IOf2+NGtshWUUP9FTu2WF4y2e8z
         m6QYrTr4JoyrlkeWV2N3DJ7HTK25JZIzymnC0ziXoViwvuB8TLzKKAgSsXBNNzCVh0FH
         WbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346272; x=1788951072;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9YJxK+goKseFQhyyU1kBZycBjFaImkJiX1HLmgsMgs=;
        b=VA7DIrgLyZs7kTPTe0Vo32kRz2/I/q4k2bI9X0iwhykQG3cCP1H8mRb19aNDPVtDDD
         KAGru0bxE2csInarXlY2jyPTw9ZuZsiVhQg0kCdpVgA3ORmgSwwSVuVf2nOUAQ8A0/AF
         2AX9cjo+YtVrfl0ST9hHl60IluraeJPQq0n2pF9v/UeNTzaFS+RH0rQ2hc4sh+8I7b4b
         TiHCbfI3qqQWMddw7rVKmY0fpw8TuPSaTITJbWYJ0fsR/OwtpwGz3EsF7ZFLweenWgQd
         XfI8yy8iWPOmncuL2eU2UZgyVkoPiOMG2Ew50NaL3SNBLEfkq7Fht5cswOalQfx8uQ1e
         HzEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqefFWDzSa5SP0eZkm96US/Rt5U9cZP6QOOWcxgqZAw3iCHv1GTsCvlUAt2foXR1WaDgNHYinQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mbu6PPTDwX7mPA/WbR/gjDYw7IMxSDC791zNKyv5AXvAI3gu3v
	eczWmVIGZBWucupOFQ5yrDEON5NFasn9zminfYwEMM/ZVecgHOkhx0BmuHdXqUWJ74SiULvqpyQ
	bstApUnrlnzjKBb8Z18ga8Q==
X-Received: from wmik9.prod.google.com ([2002:a7b:c409:0:b0:49b:e83:a666])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e44:b0:49c:dcf8:5216 with SMTP id 5b1f17b1804b1-49ce57e7f55mr71897835e9.6.1788346271508;
 Wed, 02 Sep 2026 03:51:11 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:06 +0100
In-Reply-To: <20260902104712.2399797-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260902104712.2399797-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902104712.2399797-5-vdonnefort@google.com>
Subject: [PATCH v9 04/10] set_memory.h: Introduce __set_direct_map*()
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org,
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3n_-xagokblon5gff67gjl8gg8d6.4gegh-l66daklk.ljmkl657ajeo2j6.gj8@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.69:from];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.69:from];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3n_-xagokblon5gff67gjl8gg8d6.4gegh-l66daklk.ljmkl657ajeo2j6.gj8@flex--vdonnefort.bounces.google.com];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E41C0450A9
X-Spamd-Bar: --
Message-ID-Hash: EG5QI2G56NC4XRV6KU5SDXEMARK73RKB
X-Message-ID-Hash: EG5QI2G56NC4XRV6KU5SDXEMARK73RKB
X-MailFrom: 3n_-XagoKBloN5GFF67GJL8GG8D6.4GEGH-L66DAKLK.LJMKL657AJEO2J6.GJ8@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EG5QI2G56NC4XRV6KU5SDXEMARK73RKB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

set_direct_map_*() implementations verify wheter the direct map can be
effectively set. This verification can be costly. Add an "advanced" API
__set_direct_map_*() where the direct map is modified without any check.
The caller must have verified it is safe earlier with one of the
can_set_direct_map() or can_set_direct_map_range() functions.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 88175c3fa751..5a1917a3fd52 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -34,6 +34,15 @@ static inline int set_direct_map_default_noflush(struct page *page)
 	return 0;
 }
 
+static inline int __set_direct_map_invalid_noflush(struct page *page)
+{
+	return 0;
+}
+static inline int __set_direct_map_default_noflush(struct page *page)
+{
+	return 0;
+}
+
 static inline int set_direct_map_valid_noflush(struct page *page,
 					       unsigned nr, bool valid)
 {
@@ -70,6 +79,22 @@ static inline bool can_set_direct_map_range(struct page *page, unsigned long nr_
 }
 #define can_set_direct_map_range can_set_direct_map_range
 #endif
+
+#ifndef __set_direct_map_invalid_noflush
+static inline int __set_direct_map_invalid_noflush(struct page *page)
+{
+	return set_direct_map_invalid_noflush(page);
+}
+#define __set_direct_map_invalid_noflush __set_direct_map_invalid_noflush
+#endif
+
+#ifndef __set_direct_map_default_noflush
+static inline int __set_direct_map_default_noflush(struct page *page)
+{
+	return set_direct_map_default_noflush(page);
+}
+#define __set_direct_map_default_noflush __set_direct_map_default_noflush
+#endif
 #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 
 #ifdef CONFIG_X86_64
-- 
2.55.0.970.g62bdec98f9-goog

