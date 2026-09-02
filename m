Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3A1C624D0
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:51:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6A093453C9
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788346306;
	bh=6vwnExrPXeu4OT1kol2nQNcoEOHFQGpvOL1iKrPK/c0=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=wrRvXg0xvBvU7hW8aV2rhO3oCj3mWvpLwfIuoj7G+LMit+/XLpRa7Pp6Z86weHAAs
	 6pY1F6LfTrRlQ+otre7cRjeVCvxJgmnwV65HK6gwKmp01ymCOD2MOuet4yLkx8ZwbH
	 4j3PBhKyPC9wOMmy92z6Br+r6aBcWcI7LTHjxHlhzEQBEEEDn5l86bwFpsMKejQUgI
	 FzfMTNHq0Gqq7/EUpA+zGl0NyLmJAdJnJVv4vgaSZM5zvP/1aSwtFeg/w9hc8I9eQo
	 ln/Iuts7EjBSzLOkVsmU4JkrBNfoRH49ccljzkr6gF45m7jJZinyg59cq0QF7ZuDEB
	 3H4hx8czycQFA==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1D1F143ECB
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 10:51:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jENxOolk;
	dkim-atps=neutral
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so6363445e9.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788346268; x=1788951068; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkcdapIGW4RxTiLPx+DO8uuzWqNmooyhO69bXNbCQ5o=;
        b=jENxOolkAk6bc6ZyRpcIM/BT/FbaeqmDZ+nnwdkvgo/ri7wa/Ft+lSJzGmW8DhPs7l
         wjcITGeIJwAocG3kVniU6OQCLu4xtSPhhR1y7PGQMuW4Ziix4eNshifzcCRlcwuaWiyf
         vrG9gHWVDNNaE6fsInd+s4NfAAJEhwVfMPWxwgHW0Xe4qNSn8MYsmu9ssLzc1OORRKRk
         XUqqsnurFVL9EDoTJYu8/NorGmfLuqj9n79bfdwRg2C/m0lRNqCkW0snsL0kY8w2jUA2
         0pqMhWp14oUVaHFesrxejWVe7rg1XoknCgc/tfq2FNlG+x7qJwl6fJb/i3sGCJ7R4pzy
         wfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346268; x=1788951068;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tkcdapIGW4RxTiLPx+DO8uuzWqNmooyhO69bXNbCQ5o=;
        b=RmmGFbwssTfuMMxTSMPWApbqnoNnfc3um2UpuVEBIX+1TjZ4A9w/szQsDNjABnRWAF
         PbKvQchHKc2JhM2rfoUlx9jyrlPhHHdgYLlnRN5XprkEH212lNAd9mAncgKo8LomvcLW
         odtroCX3+hu/QBgioPTN65d7M1TZ1ibL1zn+iRpv3klGMrm8Ey18W9kZgkrni4xsGWIX
         JRD9Q1gmLFtTl5TZPPQha7qKMwHhrGif2q7N1qOn/v8wLKQyPUpv6cEno2ikx07nhEYc
         kSZJWwkRkbe6heqQl9iLZ2v5tTz1fC3EwPlQAsX3GucfINjylha5Vi9dtEp8u849GF2R
         OIKA==
X-Forwarded-Encrypted: i=1; AHgh+RpKu2+t4qS1yG2nO328xRXqFcFc/gSoTwVguKvJIq0GKqad8vHK/Er86bBkpVU9qPkJ2HX1J+w=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lh+h2nHgslCKTaR5Q2JHqOFrrNHGsYuUv8sW3F0lVqx7x4QECT
	h5ykrUJgW79ipwmfdQsQuWkeSKLbYsyesJZl1nN5GqfIU9kFx76a6AX9odP5jL7DnFib+NUMZ30
	w6Z4VIBWtuSC7KWgIlKIN/Q==
X-Received: from wmph35.prod.google.com ([2002:a05:600c:49a3:b0:499:b2be:d4b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c4a6:b0:498:952:e276 with SMTP id 5b1f17b1804b1-49ce581142cmr69791455e9.8.1788346267736;
 Wed, 02 Sep 2026 03:51:07 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:03 +0100
In-Reply-To: <20260902104712.2399797-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260902104712.2399797-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902104712.2399797-2-vdonnefort@google.com>
Subject: [PATCH v9 01/10] memblock: Introduce MEMBLOCK_LLMAP
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org,
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3m_-xagokblyj1cbb23cfh4cc492.0cacd-h2296ghg.hfigh2136fakyf2.cf4@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.71:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3m_-xagokblyj1cbb23cfh4cc492.0cacd-h2296ghg.hfigh2136fakyf2.cf4@flex--vdonnefort.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.71:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1D1F143ECB
X-Spamd-Bar: --
Message-ID-Hash: KES6RAOSAVDFQ7KBRMPAUY4IRV7N2L3C
X-Message-ID-Hash: KES6RAOSAVDFQ7KBRMPAUY4IRV7N2L3C
X-MailFrom: 3m_-XagoKBlYJ1CBB23CFH4CC492.0CACD-H2296GHG.HFIGH2136FAKyF2.CF4@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KES6RAOSAVDFQ7KBRMPAUY4IRV7N2L3C/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

Keeping last-level mappings is interesting on some architectures as it
allows mapping/unmapping pages from the kernel direct map without the
risk of splitting blocks which, under the break-before-make rule, may
trigger page-faults the kernel can't handle.

However, mapping the entire direct map at PTE-level is costly. So
instead, create a new memblock flag MEMBLOCK_LLMAP to enable the system
to decide which region must be covered by mappings up to the last-level.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index d62db9e776cf..d40a5ded188d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -52,6 +52,7 @@ extern unsigned long long max_possible_pfn;
  * kernel that we know is good to use. It is the only memory that
  * allocations may happen from in this phase.
  * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
+ * @MEMBLOCK_LLMAP: memory region to be mapped using last-level mapping
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -63,6 +64,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
 	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
+	MEMBLOCK_LLMAP		= 0x100,/* last-level mapping */
 };
 
 /**
@@ -160,6 +162,8 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
+int memblock_mark_llmap(phys_addr_t base, phys_addr_t size);
+int memblock_clear_llmap(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
 void reset_all_zones_managed_pages(void);
@@ -306,6 +310,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_SCRATCH;
 }
 
+static inline bool memblock_is_llmap(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_LLMAP;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index 9ce86349a29f..1591b50503ed 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1119,6 +1119,16 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
  */
 int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 {
+	struct memblock_region *r;
+
+	memblock_cap_size(base, &size);
+
+	for_each_mem_region(r) {
+		if (memblock_is_llmap(r) &&
+		    memblock_addrs_overlap(base, size, r->base, r->size))
+			return -EINVAL;
+	}
+
 	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_NOMAP);
 }
 
@@ -1204,6 +1214,45 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_SCRATCH);
 }
 
+/**
+ * memblock_mark_llmap - Mark a memory region with flag MEMBLOCK_LLMAP.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * If supported by the architecture, such region is mapped at the last-level in
+ * the kernel direct map.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_llmap(phys_addr_t base, phys_addr_t size)
+{
+	struct memblock_region *r;
+
+	memblock_cap_size(base, &size);
+
+	for_each_mem_region(r) {
+		if (memblock_is_nomap(r) &&
+		    memblock_addrs_overlap(base, size, r->base, r->size))
+			return -EINVAL;
+	}
+
+	return memblock_setclr_flag(&memblock.memory, base, size, 1,
+				    MEMBLOCK_LLMAP);
+}
+
+/**
+ * memblock_clear_llmap - Clear flag MEMBLOCK_LLMAP for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_llmap(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 0,
+				    MEMBLOCK_LLMAP);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2886,6 +2935,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
+	[ilog2(MEMBLOCK_LLMAP)] = "LLMAP",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.55.0.970.g62bdec98f9-goog

