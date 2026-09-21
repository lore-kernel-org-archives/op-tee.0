Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D998C982ED
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:03:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6A9114546A
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789988583;
	bh=T1lTuSns2JnhV92+IGU44xR9WvLQO0g0vxZhyWYcjGM=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qKChj9gUsouhVRe+Op2fWw/3+SxtEG13udrHQSDLK9ij2L5s20UJHtp5v0eM1Nbyn
	 /XAvQmQJTMHN4OE3jvGdD8Ow08lg2sAJEeDBrB0/8VRkwNyPKD8vNs1nkf2hFc3Z2/
	 Pe1kPqBLXzskArBjx1hZHVlw4mES/a+KsJjsXdJsf+MjgnYDh7RmjufIwcFv96z3wk
	 /xrc5CtDWaXLTbsfXCEpa9iyy2XimgCImjTcxoCuF0AgbwE8TkIR/DKmNrS/QNNomi
	 wJ0EkE2bwz/SmMYrt2pNpOaVUhdg9HncXsr2fcwiTrtFm777gcRfCVg3Cf37KTiD3i
	 W8JuoVHnmNS7Q==
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 671944449D
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 11:01:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rFvfm2Vj;
	dkim-atps=neutral
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49d0ae342b9so20768955e9.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789988461; x=1790593261; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVYg8Lj489hznrzIM+7T33EpvHOqUo3+jajnUbYBZtQ=;
        b=rFvfm2VjEcrA6sZTtsfzkBa5sOy+WswdHXO4ncCn/YNtdM40ZZtXvMxnEEi+fQjoes
         xwVrdp0QQpgT4MCr3YTXQrEOde+Mb6HLIxnSR7D3N7nEmIQANzyzDG0Bf9OtnhOPZjiG
         PAHEvvIpfzvIkn1VYElVAzWhVO2wHI0MHk3cJYzx7Znoi31EtGPF5ISLgFrYrCYhInMu
         w5K2lmdvQd5dEeUbJuedDIr3CWjbmYPIOf7DXLJYMR4TJwEbOULchU1hIoGpae0AlisN
         sUeDBn5AMBxdLtbuT1gqjYh0ymryMuJxpbcSlu+DpZWgk84A9NBc7hBOa6WlzkPsTKxo
         gdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988461; x=1790593261;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVYg8Lj489hznrzIM+7T33EpvHOqUo3+jajnUbYBZtQ=;
        b=Lsl5OrO47FuCdAfCRpQRl+T9glDsAyJY4IbGkFnfduhd1iPSmxs45DDbzChd/ippxE
         UpRX4NxUsNDAA3WONGqzg4aYVkeoX3MhTb1EcGPlpWPhGHNNVknSeGw778UxWU5mV8SA
         R7HsZb7ZvdTx5/uaVcZ/PZ1j19pheMK3n7nMJg/KdAsOxM66Ynw23N0uIs1/KxsIxV5k
         aihHmbWdPoz9hnLPbvE2dAxbCw7fICob8TK4TJzkyhOfKSPjlYjHDJmpix9iz49LnzPD
         F6VNKmEqk3BNjKU9ekHzrPpodFiUwiVNFT1FiyVcACZNM9zYbYqRHBM+hNkXMg4NabCj
         Xodg==
X-Forwarded-Encrypted: i=1; AKwUvBzX6nJEKuxkBxvVVdyxlqDjqozJC1z+iYEJnabuzEcqpR+ztE9UaHM6QtkG5yiFpM3cWs6DBhw=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kRRNEVzy/FTnJUVEAx2DMmbJmZIrCw3fZeIwnj1binIbTiW8fJ
	6X+43cTOYJDp7d46AcoKgHekGWelUHbVheFtfWuBOyhdtoXf4Kpb75Ao1+vQ4J5+JTmbemA6cN9
	5if5CRKoBCt/YLT/D/mwXdg==
X-Received: from wmbd4.prod.google.com ([2002:a05:600c:58c4:b0:49e:81b9:5272])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6217:b0:49e:8418:389d with SMTP id 5b1f17b1804b1-49fc571423dmr133093905e9.9.1789988461055;
 Mon, 21 Sep 2026 04:01:01 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:00:46 +0100
In-Reply-To: <20260921110050.3977591-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260921110050.3977591-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921110050.3977591-5-vdonnefort@google.com>
Subject: [PATCH v2 4/8] arm64: Add support for MEMBLOCK_PTEMAP
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3bq6xagokbqofnyxxopybdqyyqvo.mywyz-doovscdc.dbecdonpsbwgkbo.ybq@flex--vdonnefort.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3bq6xagokbqofnyxxopybdqyyqvo.mywyz-doovscdc.dbecdonpsbwgkbo.ybq@flex--vdonnefort.bounces.google.com];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 671944449D
X-Spamd-Bar: --
Message-ID-Hash: D457VYX26FBHUGAAKKU2HIRTYWPRJJDZ
X-Message-ID-Hash: D457VYX26FBHUGAAKKU2HIRTYWPRJJDZ
X-MailFrom: 3bQ6xagoKBqofNYXXOPYbdQYYQVO.MYWYZ-dOOVScdc.dbecdONPSbWgKbO.YbQ@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/D457VYX26FBHUGAAKKU2HIRTYWPRJJDZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

With the MEMBLOCK_PTEMAP flag, force a PTE-level mapping.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/mm/mmu.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 79d90226fd5d..6b22b43a5f77 100644
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
2.55.0.1082.g2b9226bbc0-goog

