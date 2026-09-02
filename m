Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF911C624DA
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:54:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 399B04506A
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788346497;
	bh=fI4ct/3pSqJy24dcpl8O0GRnGyvmcETu0BAstHM0k+s=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ZwTgy83xtUR6lVVSdYOwPXRGMVK4A8Eos++Bfa415XRxsSkgBw4lpcdU6lopGIECT
	 Nvo3kFAeZ9PwYAXs/v/zCUhydQ9F3nTKlzoweGcbvIdCIyuHBSvF7ubRp4AB0M2tfL
	 9r3YKdDf6roRziSwphfb1qiIPrYZzWDeXjWuwmXol4gBet0f+yGcTjW6Rgfs9oVPpM
	 bNfioRaVcCvH777NcIaDgVo4cTBBrXqdkKt3IaS43e9AFHbkdYWRMpvpOnQzOxt3ur
	 e9HPatmcRkn++1t/hsaPlA/wNK7kB9LbNyZGM1JVRkk7jo/VEOIkhRjyiEitVco2hp
	 CO/9NN2RsL43w==
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7D7A9453C8
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 10:51:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Wm81QcIB;
	dkim-atps=neutral
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f4bff865cso612275f8f.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788346276; x=1788951076; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IlzRHwAUXMpKspjrSSJuu5KTpj2eywEkwws+9IOUBiI=;
        b=Wm81QcIBv6aaCG4IiqbDPA7TK6gsTkNOVDJj0uKOXCU9OFnJHhdJqUktzP95pDhTWR
         W5Dd2wJEOnqBM2HHD0ie9IZD+E5WmEi1w+masEucluyrPNwpHdVUzPv0Qy+U39PfiVTC
         pxyh14MT1d1rdqiS8rnZr6KMpIqVIMXkYen7iN+dA0NUEaeb5SD3kcRKzGgJng6q0lPN
         Z/LA+hIfLEnmpRFR/nml+ESui9nv5GtV6qBpm6weFgRwfhBNRzWiN8+39X4HAJzvVHoZ
         7X5bRyPDTfrj0yJe0yVp7twVnskh9V6WeTtHVILcGVu+MQGu54/xSPKVb3XfBJEJDww8
         6rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346276; x=1788951076;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IlzRHwAUXMpKspjrSSJuu5KTpj2eywEkwws+9IOUBiI=;
        b=J3dDoAvig6v4YwQ3Pmtxo6zuX3Onbidcbq7jtUDeMIyw2gTfDoq3fy2YmnzqXp8geO
         uRN3RM16Fg3GbmDqhkEZ/bqxn9/An1niSByeoEkjnQGLf9IqJvYOCQeVdJyGGr/EWB4K
         gtHv71oxdlUDgCVCOjz6OL6Pzn+psvH3XMW9H2AtmKbwMFP2uMcGXFBn1fIrVNVdzPiz
         3ms6/txXCQq9TFP7/dA4D5nyBmKEymzfsGUKNmmv6I9tnwKzso2f4ZyCYexAgyXE+z6D
         /UgeT9PyQDEmqXG0JDFtfk4P7HOTZ/zs3AJ/t0nyyLP94nypABzSqmTIFYzzeqhNXJrP
         4bOA==
X-Forwarded-Encrypted: i=1; AKwUvBy5Zsd9LWCUhAVJwg/9dC+M6trWoNjq1R0vlmjzRkrBrbv00oZ1JLRMEaLKcENcEUrYJjaqPvc=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nDJHURP0yAhEGWuFervoRsMsfGv25N2ZJIe2Ix3hmvh+NWZOdZ
	4EkZpHlFSQDwaSj+0gtBxVjMa819HUPrdvwDNRjaAfLywWrNK2lCNSKYS8ki9fgtqFHHAddhKUA
	E74dMaU8eQTr+BaWzUrZaiA==
X-Received: from wrqr17.prod.google.com ([2002:a5d:4991:0:b0:482:abe4:58a8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f47:0:b0:482:fc30:a1b4 with SMTP id ffacd0b85a97d-48488e03952mr6019121f8f.5.1788346276079;
 Wed, 02 Sep 2026 03:51:16 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:10 +0100
In-Reply-To: <20260902104712.2399797-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260902104712.2399797-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902104712.2399797-9-vdonnefort@google.com>
Subject: [PATCH v9 08/10] arm64: Add support for MEMBLOCK_LLMAP
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3pp-xagokbl8salkkbcloqdlldib.9ljlm-qbbifpqp.qorpqbacfojt7ob.lod@flex--vdonnefort.bounces.google.com];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.72:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3pp-xagokbl8salkkbcloqdlldib.9ljlm-qbbifpqp.qorpqbacfojt7ob.lod@flex--vdonnefort.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.72:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7D7A9453C8
X-Spamd-Bar: --
Message-ID-Hash: NH53WSEJAFRHW7AGHVENLDOZL6JXONYW
X-Message-ID-Hash: NH53WSEJAFRHW7AGHVENLDOZL6JXONYW
X-MailFrom: 3pP-XagoKBl8SALKKBCLOQDLLDIB.9LJLM-QBBIFPQP.QORPQBACFOJT7OB.LOD@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NH53WSEJAFRHW7AGHVENLDOZL6JXONYW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

With the MEMBLOCK_LLMAP flag, force a last-level mapping.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 79d90226fd5d..c0fcc76914d1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1184,9 +1184,8 @@ static void __init map_mem(void)
 	phys_addr_t init_begin = __pa_symbol(__init_begin);
 	phys_addr_t init_end = __pa_symbol(__init_end);
 	phys_addr_t kernel_end = __pa_symbol(__bss_stop);
-	phys_addr_t start, end;
 	int flags = NO_EXEC_MAPPINGS;
-	u64 i;
+	struct memblock_region *r;
 
 	/*
 	 * Setting hierarchical PXNTable attributes on table entries covering
@@ -1226,9 +1225,13 @@ static void __init map_mem(void)
 		       flags);
 
 	/* map all the memory banks */
-	for_each_mem_range(i, &start, &end) {
+	for_each_mem_region(r) {
+		phys_addr_t start, end;
+
+		if (memblock_is_nomap(r))
+			continue;
 		/*
-		 * for_each_mem_range may return sub-page-aligned boundaries
+		 * for_each_mem_region may return sub-page-aligned boundaries
 		 * after memblock_mark_nomap() splits regions at byte precision.
 		 * __create_pgd_mapping_locked aligns phys down to PAGE_MASK,
 		 * which could accidentally map no-map memory on the boundary.
@@ -1237,17 +1240,23 @@ static void __init map_mem(void)
 		 * regions. The cost is at most one page of unmapped gap at
 		 * each boundary.
 		 */
-		start = PAGE_ALIGN(start);
-		end = end & PAGE_MASK;
+		start = PAGE_ALIGN(r->base);
+		end = (r->base + r->size) & PAGE_MASK;
 		if (start >= end)
 			continue;
+
+		int rflags = flags;
+
+		if (memblock_is_llmap(r))
+			rflags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
+
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
 		 * PAGE_KERNEL.
 		 */
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
-			       flags);
+			       rflags);
 	}
 }
 
-- 
2.55.0.970.g62bdec98f9-goog

