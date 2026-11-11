Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E03606A33C
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=2A0Qgs8z;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X3AwDy45
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 17DEC45045
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794395493;
	bh=ckY3sVEq1I8Hsd4AMFoNgvWRqIrJaedY/SLhOnMDgEY=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2A0Qgs8zbt68vP/bnLtThlsz0fIjAGdCQ+uxWuMFaht+hUuJL2QOsj6yOZNq4kUqO
	 ateZWK4Q0dmxFYKPrwNa85b0h6suucLPvYzDDohpyWWlpDt3CimLTU46/QKoiGL7Hw
	 m2rUdfG6oCw/rVjlY7itz9BwvGFEDD+vsEmipBRAD2kqMo9N06qb3nt5fmNxzyF6an
	 KwYXs5fNo8WKHsNeftvhKiPqNl6/t/DFph1b9oZmrxtXO96ur2mV1WWNEya8K/Ke6P
	 6GvruiwF+/VQEMJhKFZc4H749Uf3WdD4pnafMUvzC+oTaOwfLFgWhTdOdIZydGmGrh
	 gslxtzHjz9hqA==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DAB9F454D9
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 11:08:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X3AwDy45;
	dkim-atps=neutral
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4b764ffc014so28042775e9.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 03:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395319; x=1795000119; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=laMYshk/IpUNzmzRXv9ltVTwYgsKb/6KaHojH4Vu9w4=;
        b=X3AwDy45kFhx+CWucActWqxO6kHVQbhzx7TvTrAG5isk9gKcGHiF+R1Km6aXYYH8+u
         +5XoBMf8blIWuwC9P9NaPibwj0azT0XKnT69kC6L1Lkjxk4Lh7lwKNac1x6DBh/nRmxm
         9Lb+x67COM5jZkSQNAjeJmEar1LS8xDch3fRqqggUzYreWkXLA2x6mqINirM1Rneshfs
         NUlsmVrPihq9oW7DAUTz4od+wdJpKJ1b9GhqJ9y5TrgfmvwP3FQ8jV4ldMe9HY0+Q7jc
         YSobjhGK7NMr67YU/Gpq85FzJjIR0HNKVUxQTfs0mOdIEyFmi42f6DW5I9leW2YD0fMO
         qQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395319; x=1795000119;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laMYshk/IpUNzmzRXv9ltVTwYgsKb/6KaHojH4Vu9w4=;
        b=V2lzVkvz2b42h8fZWZWu/yXd2nGUMbpIONu7Nu1hGVMjwNqHUez4YcmBo1fMem64AS
         euBf4dlArziGsghptwzt7VqK+xSuE0sLyb/3rwS3JTkGbxFIZupaz5EKeDh+XL19Vu1x
         F3vcfyLZQ9niDtUlA/pu0PFfZ/6JUs9XPDf0B77heTp1aIAsIUJWYlilWY3Yhvjkcd02
         PPmRPd8n93L5zw5AC4OqarSY9tpCrPo1VZPSgZI6A3Zkkv+dZf7ba1Z0rbwYbuXjbl1T
         eObdzLviXYPv2ici1zL09z4o9xed9RZyECO6INK3w+StETxL5/P/hqrRHHtA8yd1UJHN
         Zghw==
X-Forwarded-Encrypted: i=1; AL+hErGs2eLO8hNfvajerUwBwTZlMvA+OOpxncnkF6+cJcOBPTpGfFIfncb8SoYBRRihLwPbQSCZUtE=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8ASjcR81FLhu+cp2kZ+nEnJcXjbnTqfsRlvBeEjKv7kzQklq2u
	rdzZwvcywlFchgMbyYd0yvkO1Ka+TuuLMI2LEPS68QKAqNVXmzFHAKUI2tBVGwbpn4NoUVRiulT
	nJbT4K1UXOO+hmMWDzBSmDQ==
X-Received: from wmbgx4.prod.google.com ([2002:a05:600c:8584:b0:4a1:cf4b:72c2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1912:b0:4b2:612d:908c with SMTP id 5b1f17b1804b1-4ba093d13f1mr36933745e9.34.1794395318533;
 Wed, 11 Nov 2026 03:08:38 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:36 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-7-vdonnefort@google.com>
Subject: [PATCH v3 6/8] arm64: Introduce direct_map_is_ptemap()
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3tkz0agokbn8ygrqqhiruwjrrjoh.frprs-whholvwv.wuxvwhgilupzduh.ruj@flex--vdonnefort.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3tkz0agokbn8ygrqqhiruwjrrjoh.frprs-whholvwv.wuxvwhgilupzduh.ruj@flex--vdonnefort.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.71:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.71:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DAB9F454D9
X-Spamd-Bar: /
Message-ID-Hash: AMOW4XEHZXJLH2A5VIC5NGXJ7F6VRAKF
X-Message-ID-Hash: AMOW4XEHZXJLH2A5VIC5NGXJ7F6VRAKF
X-MailFrom: 3tkz0agoKBn8ygrqqhiruwjrrjoh.frprs-whholvwv.wuxvwhgilupzduh.ruj@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AMOW4XEHZXJLH2A5VIC5NGXJ7F6VRAKF/>
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

Regions marked with MEMBLOCK_PTEMAP are mapped at page granularity so
their direct mapping can be modified without splitting blocks at
runtime. Introduce direct_map_is_ptemap(), which walks the kernel page
tables during init to verify that every page in a range is backed by a
present non-contiguous PTE.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/include/asm/set_memory.h |  4 ++
 arch/arm64/mm/pageattr.c            | 65 +++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 0091ba12200e..b6ec938703d6 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -3,12 +3,16 @@
 #ifndef _ASM_ARM64_SET_MEMORY_H
 #define _ASM_ARM64_SET_MEMORY_H
 
+#include <linux/init.h>
+
 #include <asm/mem_encrypt.h>
 #include <asm-generic/set_memory.h>
 
 bool can_set_direct_map(void);
 #define can_set_direct_map can_set_direct_map
 
+bool __init direct_map_is_ptemap(struct page *page, unsigned int numpages);
+
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index de7bf95003ea..c7662fd2fcb2 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -102,6 +102,71 @@ bool can_set_direct_map(void)
 		arm64_kfence_can_set_direct_map() || is_realm_world();
 }
 
+static int __init direct_map_is_ptemap_pud_entry(pud_t *pud, unsigned long addr,
+						 unsigned long next,
+						 struct mm_walk *walk)
+{
+	if (pud_leaf(pudp_get(pud)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __init direct_map_is_ptemap_pmd_entry(pmd_t *pmd, unsigned long addr,
+						 unsigned long next,
+						 struct mm_walk *walk)
+{
+	if (pmd_leaf(pmdp_get(pmd)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __init direct_map_is_ptemap_pte_entry(pte_t *pte, unsigned long addr,
+						 unsigned long next,
+						 struct mm_walk *walk)
+{
+	pte_t val = __ptep_get(pte);
+
+	if (!pte_present(val) || pte_cont(val))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __init direct_map_is_ptemap_pte_hole(unsigned long addr,
+						unsigned long next, int depth,
+						struct mm_walk *walk)
+{
+	return -EINVAL;
+}
+
+static const struct mm_walk_ops direct_map_is_ptemap_ops __initconst = {
+	.pud_entry	= direct_map_is_ptemap_pud_entry,
+	.pmd_entry	= direct_map_is_ptemap_pmd_entry,
+	.pte_entry	= direct_map_is_ptemap_pte_entry,
+	.pte_hole	= direct_map_is_ptemap_pte_hole,
+};
+
+bool __init direct_map_is_ptemap(struct page *page, unsigned int numpages)
+{
+	unsigned long addr, end;
+
+	if (!pfn_valid(page_to_pfn(page)) || !numpages)
+		return false;
+
+	addr = (unsigned long)page_address(page);
+	end = addr + PAGE_SIZE * numpages;
+
+	/*
+	 * Called during boot before runtime linear-map splitting, so it is
+	 * safe to walk the page-table lockless.
+	 */
+	return !walk_kernel_page_table_range_lockless(addr, end,
+						      &direct_map_is_ptemap_ops,
+						      NULL, NULL);
+}
+
 static int update_range_prot(unsigned long start, unsigned long size,
 			     pgprot_t set_mask, pgprot_t clear_mask)
 {
-- 
2.56.0.542.g3ef89b7020-goog

