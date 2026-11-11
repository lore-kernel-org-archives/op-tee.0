Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D2606A8A3
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=0dvW1p+l;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iQGOj2ln
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BE65A45333
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794395520;
	bh=cc5VbUT5STxomR3+ZM/2jlutTvtAJlQrpsllR2H8zfo=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0dvW1p+lxPl8KIT9kYcETvFY8GYu7/Kr4UyqoGqQVrXQRIuifwPW3pyxq1CDK0fmI
	 13JW7lTeUG16XyAraOR3von4s3NgsGymmCeqDrVFqnPjXHDRycazyv7raDbozlerrc
	 NCKBza2axKpoZfJuEI+Cs+kiJ4FNDnvyXWnzi12DjPW/xVb59rTxv2Lyyh2n8krzyU
	 DznJUQVC8mh/UNjjpQxNWZOpkJ9zyBSI/SY+XSw+v3teOasrFxP7c2yMGia6z2hF3r
	 d+oM97PY5y7nh1RQgIFjizu9eSWA+ORgkPtKiliLNk5JMJhsYBVE+zRco/cstDx5u/
	 6HcoEJYHRynuw==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F36B5454D9
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 11:08:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iQGOj2ln;
	dkim-atps=neutral
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b70d5bd731so3795558a12.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395320; x=1795000120; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k28NXrt+XbqyfRaacENrrFfeZjq4XEJuuf/YvC8HY10=;
        b=iQGOj2lnvIZJs5O5HaAEetPQFk0v+ikEP9BRKLOdSOoEvu1XKfLHepMXdxjBji1YDs
         AsBumX/y/EXdcFFZrTkvo84DaM39FfE4/sP3w7nSEj51hvwH27kxWTUHVDDD8xeHBU4s
         eXITSoUgVYJAgjXW0CFlB7rkRPMhFHyvlq7mDqb1Ys+b0t15z41vB1+Wx/U7phzAm80C
         vYYuaDgGhwXLHn3b8blKjDD9n5o9WL3Je+v4fc0/uXcHBguIv2zAIxeop7vLtAhP5bqA
         CIoNfFcHP6ODWRyCJd5IKx48Y1aN4bZPWWLBx3+5Te4ZE8iA3mNy9Z2ZdOCEpokjvPZp
         avhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395320; x=1795000120;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k28NXrt+XbqyfRaacENrrFfeZjq4XEJuuf/YvC8HY10=;
        b=HyWrCFzoEmaFLcG7S9Zetc2Sc4zGya9RQgIvQ3kY7ewlSfTzcftYRO4VswXNJlwAAR
         /8Z92LX5LbsW/S1g8A7GIdNNuRhK6hZnu5ufdcoa2wg12koVUYh/KW6ZQaBc/45KIdCA
         FoQjQmsjUI7B7LqY5NwINnzKlAerOHRZTlqJWumytbAw17pz3mk/5/lFHiThqh7hFmXf
         zVrWf+mr0EMt0QZsDb0ZQ3OR/pDzaCj1+XeBj0MX05Rlxa05FBHS/0ENqDnJTQ2eE+UI
         c0qb4W9/cFIAu1NgKgG510cOVjkYNmwt092fdX6BEmksV/fzMgqiPm5FcRclTcbQA95J
         ZlGQ==
X-Forwarded-Encrypted: i=1; AL+hErFfKjdri4lVzyG6exA6v1oy/08QHxPGG7z1nFvhrH8OXzkPY5kpApXFwrHAAniad267h1kkFX8=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8M4t44MwdfMLiT9ONs54rqwtNt63d03MNzXhBQdSpCVOgRvqNa
	Z9jLpQh2OzSCHLFx/A8XovblJZuUNTntvDZNEdNsux2e0V0RbRloXMHt9dI9ps0taQOH4OSFF7C
	2j1mOTId1Ps2HHSIDjYulCg==
X-Received: from ejxe15.prod.google.com ([2002:a17:906:81cf:b0:c3f:75a:4837])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2d2c:b0:c50:6222:7b1c with SMTP id a640c23a62f3a-c5066cc68c2mr168857666b.23.1794395319574;
 Wed, 11 Nov 2026 03:08:39 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:37 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-8-vdonnefort@google.com>
Subject: [PATCH v3 7/8] arm64: Add support for lendable-dma-pool
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3t0z0agokboazhsrrijsvxksskpi.gsqst-xiipmwxw.xvywxihjmvq0evi.svk@flex--vdonnefort.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3t0z0agokboazhsrrijsvxksskpi.gsqst-xiipmwxw.xvywxihjmvq0evi.svk@flex--vdonnefort.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.70:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.70:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F36B5454D9
X-Spamd-Bar: /
Message-ID-Hash: 3QCJSZKZA5QGLRVVQYWMZECG4VDVIIIV
X-Message-ID-Hash: 3QCJSZKZA5QGLRVVQYWMZECG4VDVIIIV
X-MailFrom: 3t0z0agoKBoAzhsrrijsvxksskpi.gsqst-xiipmwxw.xvywxihjmvq0evi.svk@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3QCJSZKZA5QGLRVVQYWMZECG4VDVIIIV/>
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

Even when the linear map uses block mappings, regions marked with
MEMBLOCK_PTEMAP are mapped at page granularity and can be modified at
runtime. Implement the architecture hooks for the lendable-dma-pool to
force the last-level mappings, validate ranges and update the direct
mapping.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/set_memory.h |  2 +
 arch/arm64/mm/dma-mapping.c         | 71 +++++++++++++++++++++++++++++
 arch/arm64/mm/pageattr.c            | 56 ++++++++++++++++++-----
 4 files changed, 118 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1075bc661833..34fe7a7eea82 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -117,6 +117,7 @@ config ARM64
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
 	select DMA_BOUNCE_UNALIGNED_KMALLOC
 	select DMA_DIRECT_REMAP
+	select DMA_LENDABLE if DMA_CMA
 	select EDAC_SUPPORT
 	select FRAME_POINTER
 	select FUNCTION_ALIGNMENT_4B
diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index b6ec938703d6..ec8bbb59e51f 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -17,6 +17,8 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
 int set_direct_map_default_noflush(struct page *page, unsigned int numpages);
+int __set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
+int __set_direct_map_default_noflush(struct page *page, unsigned int numpages);
 bool kernel_page_present(struct page *page);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 7f6f2f40dba2..c324e9826ce2 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -7,9 +7,13 @@
 #include <linux/gfp.h>
 #include <linux/cache.h>
 #include <linux/dma-map-ops.h>
+#include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <xen/xen.h>
 
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
+#include <asm/tlbflush.h>
 #include <asm/xen/xen-ops.h>
 
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
@@ -38,6 +42,73 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 	dcache_clean_poc(start, start + size);
 }
 
+#ifdef CONFIG_DMA_LENDABLE
+int __init arch_dma_mark_lendable(phys_addr_t base, phys_addr_t size)
+{
+	if (!PAGE_ALIGNED(base | size))
+		return -EINVAL;
+
+	return memblock_mark_ptemap(base, size);
+}
+
+bool __init arch_dma_is_lendable(struct page *page, unsigned int nr_pages)
+{
+	return direct_map_is_ptemap(page, nr_pages);
+}
+
+int arch_dma_zap_direct_map(struct page *page, unsigned int nr_pages,
+			    bool from_lendable)
+{
+	unsigned long start = (unsigned long)page_address(page);
+	unsigned long end = start + ((unsigned long)nr_pages << PAGE_SHIFT);
+	int ret;
+
+	/*
+	 * arch_dma_prep_coherent() only cleans as normal DMA buffers retain a
+	 * cacheable linear-map alias. Since that alias is being removed here,
+	 * also invalidate to make sure they can't be evicted later on while the
+	 * memory is secured.
+	 */
+	dcache_clean_inval_poc(start, end);
+
+	if (from_lendable) {
+		ret = __set_direct_map_invalid_noflush(page, nr_pages);
+	} else {
+		might_sleep();
+		ret = set_direct_map_invalid_noflush(page, nr_pages);
+	}
+
+	if (ret)
+		return ret;
+
+	flush_tlb_kernel_range(start, end);
+
+	return 0;
+}
+
+int arch_dma_restore_direct_map(struct page *page, unsigned int nr_pages,
+				bool from_lendable)
+{
+	unsigned long start = (unsigned long)page_address(page);
+	unsigned long end = start + ((unsigned long)nr_pages << PAGE_SHIFT);
+	int ret;
+
+	if (from_lendable) {
+		ret = __set_direct_map_default_noflush(page, nr_pages);
+	} else {
+		might_sleep();
+		ret = set_direct_map_default_noflush(page, nr_pages);
+	}
+
+	if (ret)
+		return ret;
+
+	dcache_inval_poc(start, end);
+
+	return 0;
+}
+#endif /* CONFIG_DMA_LENDABLE */
+
 void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	int cls = cache_line_size_of_cpu();
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index c7662fd2fcb2..467a420af0f5 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -167,8 +167,8 @@ bool __init direct_map_is_ptemap(struct page *page, unsigned int numpages)
 						      NULL, NULL);
 }
 
-static int update_range_prot(unsigned long start, unsigned long size,
-			     pgprot_t set_mask, pgprot_t clear_mask)
+static int __update_range_prot(unsigned long start, unsigned long size,
+			       pgprot_t set_mask, pgprot_t clear_mask)
 {
 	struct page_change_data data;
 	int ret;
@@ -176,10 +176,6 @@ static int update_range_prot(unsigned long start, unsigned long size,
 	data.set_mask = set_mask;
 	data.clear_mask = clear_mask;
 
-	ret = split_kernel_leaf_mapping(start, start + size);
-	if (WARN_ON_ONCE(ret))
-		return ret;
-
 	lazy_mmu_mode_enable();
 
 	/*
@@ -194,6 +190,18 @@ static int update_range_prot(unsigned long start, unsigned long size,
 	return ret;
 }
 
+static int update_range_prot(unsigned long start, unsigned long size,
+			     pgprot_t set_mask, pgprot_t clear_mask)
+{
+	int ret;
+
+	ret = split_kernel_leaf_mapping(start, start + size);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
+	return __update_range_prot(start, size, set_mask, clear_mask);
+}
+
 static int __change_memory_common(unsigned long start, unsigned long size,
 				  pgprot_t set_mask, pgprot_t clear_mask)
 {
@@ -316,28 +324,52 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 					__pgprot(PTE_PRESENT_VALID_KERNEL));
 }
 
-int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages)
+int __set_direct_map_invalid_noflush(struct page *page, unsigned int numpages)
 {
 	pgprot_t clear_mask = __pgprot(PTE_PRESENT_VALID_KERNEL);
 	pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
 
+	return __update_range_prot((unsigned long)page_address(page),
+				   PAGE_SIZE * numpages, set_mask, clear_mask);
+}
+
+int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages)
+{
+	unsigned long start = (unsigned long)page_address(page);
+	int ret;
+
 	if (!can_set_direct_map())
 		return 0;
 
-	return update_range_prot((unsigned long)page_address(page),
-				 PAGE_SIZE * numpages, set_mask, clear_mask);
+	ret = split_kernel_leaf_mapping(start, start + PAGE_SIZE * numpages);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
+	return __set_direct_map_invalid_noflush(page, numpages);
 }
 
-int set_direct_map_default_noflush(struct page *page, unsigned int numpages)
+int __set_direct_map_default_noflush(struct page *page, unsigned int numpages)
 {
 	pgprot_t set_mask = __pgprot(PTE_PRESENT_VALID_KERNEL | PTE_WRITE);
 	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
 
+	return __update_range_prot((unsigned long)page_address(page),
+				   PAGE_SIZE * numpages, set_mask, clear_mask);
+}
+
+int set_direct_map_default_noflush(struct page *page, unsigned int numpages)
+{
+	unsigned long start = (unsigned long)page_address(page);
+	int ret;
+
 	if (!can_set_direct_map())
 		return 0;
 
-	return update_range_prot((unsigned long)page_address(page),
-				 PAGE_SIZE * numpages, set_mask, clear_mask);
+	ret = split_kernel_leaf_mapping(start, start + PAGE_SIZE * numpages);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
+	return __set_direct_map_default_noflush(page, numpages);
 }
 
 int __set_memory_enc_dec(unsigned long addr, int numpages, bool encrypt)
-- 
2.56.0.542.g3ef89b7020-goog

