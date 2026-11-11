Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875A606B422
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=S5wbfiW+;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YbvGJpRK
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 446E5454E0
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794395351;
	bh=OOiCQAdm2zBDqMkF+MzD+oUszgZLaUWvJT/+G/9GuXA=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=S5wbfiW+iYeDXjKC9kNf+xkEFOlPjVErkb128dApZJB2OmAwi1TAGtzm7iWZhdnm4
	 p1PrcSU0IDlD2iV0huYU+ywOUY6I/riiyPlZ+3lZLKaIekGk3rRoKO/WkQ6bh0bZ0H
	 +f0kQNHdO25mJjXenp3yTQeHU+vHWVqdNOT6PDf0m02wyV0+O5FmVxj1AQ+DoDJ0Wz
	 Gu5QW3msD0nsGZN2ff9UsjAAMTBmaJ4aCghsymPx9eEax45pufKeIHFj9Ke6yJqGMS
	 RoZuILfaU4VDRO3HEVu0Lu6zJAquq0Yc9cRDkkTq2RnbSfuvq0d5bWJWxoFE6nfRwO
	 fKVg9hLwWEZYQ==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C8E9D454C0
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 11:08:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YbvGJpRK;
	dkim-atps=neutral
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a211bff50bso20164715e9.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395304; x=1795000104; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wg+r/G4UynsyjzcD9VFm7KNuI6HhIxNTVl9eF5+p1ZQ=;
        b=YbvGJpRKvhcx7Fm/t5ysc7CstyGl9CpEUDqiwFxYhs2zioTl1Wc6Dc+Ff+LJSpopiq
         +LtiJFsohnv2ZQIKdffgPWK7V19qugWFFPN/wIAIK3HAxDyMQan1fusIECZInMWRr68p
         q9fr3dXzxyyOpIhrzXqh0m8I+h3KW8rWZe6zd4uNKiFgjduZrRqZLBC7zsptDNQeJ4K5
         Mnk2nBEgTDn+WyrAFwd+PO4tLj3TCVf2b5eQi3KK+c75w34lI3kW1qqTHtPXNs1patTZ
         THZoPiR0/GJ/A/pR6I3creXQ624awq1rvBjDRHSQBDh/E4ecZZi167vfKMHs/IhX2GVl
         vM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395304; x=1795000104;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wg+r/G4UynsyjzcD9VFm7KNuI6HhIxNTVl9eF5+p1ZQ=;
        b=1lIkhNxdRxPSwyetf24TnyEsYBQ5dPmlOjMlUjZ7b0h+af1HB8qUQ1s9nnaCq4Fn6U
         lR9DHohmmtpLGQ1NpnE1dDzaUHqaVezAZaeYQnzThEbtoGHhwZ35CSHcJvwj4+Z/r6ly
         gOoMWl68CyRoOgVKQR8zKi0ii/5sLOjtZR2itHweHNvbk0oSne2+KixWanfvKoEznUvQ
         7noyeG2W3fD1cHPJFBKGpsNsL3vbX19ICkA1VZyyM2a1YtIGCskKbiDROGVY1IWvxvYO
         GhG0XNnF18dhVyCw4Fm8Lu4K56o4T2Nir0q5cyVHU0twAAOME90CgDqMhrOmk3WdxLKT
         Rg0g==
X-Forwarded-Encrypted: i=1; AL+hErFOjwk2k2EoHKU+P2+7VTcXH1gx/UgpOXtIDgxDEHbWwtE4xzVJGEsm8GcTIiEx7yI/wYacUp4=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9zcheQWi3KRWjQuVrTRXrwS/Gnq3fY0YkehJTKv2GjBZOaAaQl
	hBhPXZ+6zBHj9V5h4XKeSiySSMeCO43BVpDNEC9QXiKAoi/BYlInXLLVlFZbl2COXJw4YEm2AMM
	Rui5z3pGKbHw4Alb9EGT5Jg==
X-Received: from wmo18.prod.google.com ([2002:a05:600c:2312:b0:4a5:34a9:6903])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:82f1:b0:4a2:cbe:beac with SMTP id 5b1f17b1804b1-4ba093c85ebmr40371365e9.23.1794395303273;
 Wed, 11 Nov 2026 03:08:23 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:31 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-2-vdonnefort@google.com>
Subject: [PATCH v3 1/8] memblock: Introduce MEMBLOCK_PTEMAP
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3p0z0agokbnajrcbbstcfhuccuzs.qcacd-hsszwghg.hfighsrtwfakofs.cfu@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20260707];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3p0z0agokbnajrcbbstcfhuccuzs.qcacd-hsszwghg.hfighsrtwfakofs.cfu@flex--vdonnefort.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.71:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.71:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C8E9D454C0
X-Spamd-Bar: /
Message-ID-Hash: 2RYVZDY6YRMZ44OVMUS2PQCVQONF3R5A
X-Message-ID-Hash: 2RYVZDY6YRMZ44OVMUS2PQCVQONF3R5A
X-MailFrom: 3p0z0agoKBnAjRcbbSTcfhUccUZS.Qcacd-hSSZWghg.hfighSRTWfakOfS.cfU@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2RYVZDY6YRMZ44OVMUS2PQCVQONF3R5A/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Keeping PTE-level mappings is interesting for arm64 as it allows
mapping/unmapping pages from the kernel direct map without the risk of
splitting blocks which, under the break-before-make rule, may trigger
page-faults the kernel can't handle.

However, mapping the entire direct map at PTE-level is costly. So
instead, create a new memblock flag MEMBLOCK_PTEMAP to selectively apply
a PTE-level mapping.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 include/linux/memblock.h |  9 +++++++++
 mm/memblock.c            | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 40e6e0aa2f8d..67ef20a1c5e2 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -52,6 +52,7 @@ extern unsigned long long max_possible_pfn;
  * know is good to use. It is the only memory that allocations may happen from
  * in this phase.
  * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
+ * @MEMBLOCK_PTEMAP: memory region to be mapped using PTE-level mapping
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -63,6 +64,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_NOPRSRV	= 0x40,	/* memory with no KHO preservations */
 	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
+	MEMBLOCK_PTEMAP		= 0x100,/* PTE-level mapping */
 };
 
 /**
@@ -160,6 +162,8 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_noprsrv(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_noprsrv(phys_addr_t base, phys_addr_t size);
+int memblock_mark_ptemap(phys_addr_t base, phys_addr_t size);
+int memblock_clear_ptemap(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
 
@@ -305,6 +309,11 @@ static inline bool memblock_is_kho_noprsrv(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_NOPRSRV;
 }
 
+static inline bool memblock_is_ptemap(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_PTEMAP;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index a450092a80fb..b8b6e762917a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1068,10 +1068,15 @@ static int __init_memblock memblock_setclr_flag(struct memblock_type *type,
 	for (i = start_rgn; i < end_rgn; i++) {
 		struct memblock_region *r = &type->regions[i];
 
-		if (set)
+		if (set) {
+			enum memblock_flags map_flags =
+				MEMBLOCK_NOMAP | MEMBLOCK_PTEMAP;
+
 			r->flags |= flag;
-		else
+			WARN_ON_ONCE((r->flags & map_flags) == map_flags);
+		} else {
 			r->flags &= ~flag;
+		}
 	}
 
 	memblock_merge_regions(type, start_rgn, end_rgn);
@@ -1221,6 +1226,35 @@ __init int memblock_clear_kho_noprsrv(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_NOPRSRV);
 }
 
+/**
+ * memblock_mark_ptemap - Mark a memory region with flag MEMBLOCK_PTEMAP.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * If supported by the architecture, such region is mapped using PTE-level
+ * mappings in the kernel direct map.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_ptemap(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 1,
+				    MEMBLOCK_PTEMAP);
+}
+
+/**
+ * memblock_clear_ptemap - Clear flag MEMBLOCK_PTEMAP for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_ptemap(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 0,
+				    MEMBLOCK_PTEMAP);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2854,6 +2888,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_NOPRSRV)] = "KHO_NOPRSRV",
 	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
+	[ilog2(MEMBLOCK_PTEMAP)] = "PTEMAP",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.56.0.542.g3ef89b7020-goog

