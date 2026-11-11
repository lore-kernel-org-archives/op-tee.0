Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A63606A8A7
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=58Wr2CKM;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ACytvDiG
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 60E7D45503
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794395378;
	bh=Ebr8GkqeP4eaNDU9kZ478xQ8FikIVF7osCbohKV4Sv8=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=58Wr2CKMMkN7yBVBd/EhQcbLGVlGO80HFxGS9oLw2K0OC/VqEXl3TgowNMFs+EkPt
	 zHDmdNFdlkmRW87CC82jHN+b58AFhQnYVgMI/+lw1+ZOpwXwKZDaeQDJbhAxZzAYDO
	 eHWT6rYYViLSFqUAPERuoK5Z/bo4gRijqDvVIDsOXgsqvmGq1wukN3eoLQlnWd4IBq
	 UlM8MCDkw/M2pZCNEsGLkHhXrRWAIHtnF9mUlrKXnH05BY83DFf6en6d9AD4QA8/41
	 xZUMu5VvR4aDvTOjegAOTYC4760D2XaJutxR2XZABrI8/ZUe1BuZdFvjo9PBhN3bpz
	 ja8GyikCzgwkQ==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E8912454C0
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 11:08:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ACytvDiG;
	dkim-atps=neutral
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4b8b3cd61a5so17935455e9.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 03:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395305; x=1795000105; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pd2LkXH74KyjkxP8lUXKvl1JOnJh/9hivuqWG2OIXns=;
        b=ACytvDiGKlyfdzYBzMmCQx+3urZuLk5IaOXoSggzhdCo9CaqOdNdyRYDvwHTEGQrGb
         uZCY8UqEC2pc7rn9SOz88djnd2ct1S7eQIa5TAz4ADwIDdmKisNl1GuvjiivPybUOYD+
         o2P3n/fUBm6ZDgkn8DbY9ZaihtY7t9mr4lmrmMsGYUSX50+TkBwOiju7xa6tex3b46BT
         93NgK0v0tUvF0kqgI5jfAmnKQdlFZcL5TTDpSsmOPTPd8jfGIdfXZ99CuRm7L7Sjwrz6
         uZa4Yv549kXJ9EHBOQrWV14nVKi3uxO3eqYU+btMWEdHqiqeBpUyS/VhBdkKP6/ZgY9e
         6rdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395305; x=1795000105;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pd2LkXH74KyjkxP8lUXKvl1JOnJh/9hivuqWG2OIXns=;
        b=qqWcAG6Ei03VT0NPIGuWRYOYoFG0FdqQ8VvjYWGPH57AFs/QJps0ByJDWvf5LfNXvv
         TCMIDvWJuKI+YmQhcGxyd5Eht9f6BX+cWBx9+f6xeFD4h4jveA4lcBq1osenTVEqiAlq
         jP+GB+/77mKCw3wlSwsQX6RR7od8Rv/62/grdsiXhVKRO6Uk6BIafDI50fHFUC9TRtDz
         ujCqRsMJYRNN/PqgWJtr/KHlNdQK58rPjD9da/YFsp/63MisVKI3oFuI4Z2Y2fFP0bCS
         bk7RJaNhqRB/HtpuwHtxCburV/rUB1rVNpKi4ofan4EOFOOQO12o7O0C7HPp5Dim7CxO
         90hQ==
X-Forwarded-Encrypted: i=1; AL+hErHCxhnnMdlzvvwM4bM0waQ4lBR6RIYTZBIrKkLT1hpzOTz9i+4qw/Bmr3UInZ9MHNN7Ob51+zE=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z86W9R+hQQF5pLWiCV4zxScREPnd+uA2tKCjoyIh/kA5bv5gcqt
	8BfS7JTbRtCC7CLPxrAYeRGfBzMxs+tRsfmmySDXcxkH9pjcaHeQJpj9jVeYnXilFAn54enBVUn
	l5pgs8Z4xYZcKv+gD8IBfEg==
X-Received: from wman16.prod.google.com ([2002:a05:600c:6c50:b0:4a1:e44e:ffd0])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c08b:b0:4ba:4928:8aec with SMTP id 5b1f17b1804b1-4ba49288bdemr21813875e9.9.1794395304668;
 Wed, 11 Nov 2026 03:08:24 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:32 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-3-vdonnefort@google.com>
Subject: [PATCH v3 2/8] arm64: Add support for MEMBLOCK_PTEMAP
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3qez0agokbneksdcctudgivddvat.rdbde-ittaxhih.igjhitsuxgblpgt.dgv@flex--vdonnefort.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3qez0agokbneksdcctudgivddvat.rdbde-ittaxhih.igjhitsuxgblpgt.dgv@flex--vdonnefort.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.70:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.70:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E8912454C0
X-Spamd-Bar: /
Message-ID-Hash: SU4O7HABQQ6WBOUNAB32BFKDYUWW27BO
X-Message-ID-Hash: SU4O7HABQQ6WBOUNAB32BFKDYUWW27BO
X-MailFrom: 3qEz0agoKBnEkSdccTUdgiVddVaT.Rdbde-iTTaXhih.igjhiTSUXgblPgT.dgV@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SU4O7HABQQ6WBOUNAB32BFKDYUWW27BO/>
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

With the MEMBLOCK_PTEMAP flag, force a PTE-level mapping. This also
disables contiguous PTEs to make sure any page from the memblock can be
safely unmapped from the linear map.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/mm/mmu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 140520b351e2..a4cafafa1d82 100644
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
@@ -1226,9 +1225,14 @@ static void __init map_mem(void)
 		       flags);
 
 	/* map all the memory banks */
-	for_each_mem_range(i, &start, &end) {
+	for_each_mem_region(r) {
+		phys_addr_t start, end;
+		int rflags = flags;
+
+		if (memblock_is_nomap(r))
+			continue;
 		/*
-		 * for_each_mem_range may return sub-page-aligned boundaries
+		 * for_each_mem_region may return sub-page-aligned boundaries
 		 * after memblock_mark_nomap() splits regions at byte precision.
 		 * __create_pgd_mapping_locked aligns phys down to PAGE_MASK,
 		 * which could accidentally map no-map memory on the boundary.
@@ -1237,17 +1241,21 @@ static void __init map_mem(void)
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
+		if (memblock_is_ptemap(r))
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
2.56.0.542.g3ef89b7020-goog

