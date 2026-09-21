Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9454C982ED
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:02:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DF500453A7
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789988525;
	bh=nq6c2HIL7smpOLcesIc5VsHG9EFe4PxsntTqAaTUuBA=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Uwz+Ve84NoWl5Z6//TUFjLfrygqOhEUtz1aibA8SgZKZfKmEb/HcrGcVz1rOI1aD1
	 a/vvFX11CiodAFSraUoDk3rI7E1RIB5kvtOVzehONRFB0zA3vtOrd3XYMhmSYQFJv3
	 DJpREQZgG51VoD0gNpwGlA+t1oDz2WQ2sut4xdZ6D4GWpwIBw0hhBVcUrvH7qUbY7f
	 seISnZWUHuC561yM7MzCTqlFVPDoIAb69OQ8VKvWzlAQDZCgLRJ8rnCq/43IIR0+a2
	 DX8bkKk4Dh9HAKuPVtQCdzd3ucQC3Anz6XiOIu4AREc8gP69Eo2tFlWfqUxaUcxoMW
	 kQCmoxLfszg9A==
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EE777453AF
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 11:00:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GL5C3nSx;
	dkim-atps=neutral
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6aa2d82b6ccso4068048a12.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789988459; x=1790593259; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U06rcgIn0LVt5Do84ZIYuayP7YCGGpRPbIbmdcyZosY=;
        b=GL5C3nSx4Iyf4TK+Nx9ycNti4ukLELyS9fJailMaWlSBO5IPsT3ZclVPo9bkCEnFM9
         LpJhLegZAuEXHJCZ3wrbat77Bi911RaE+NZl5iVIVhSm1rNZ3c48DrkL51ZFJi2IHpEg
         A/g/vhDyKVjzEC0PBfWQrc3XO1Shd0WcflcZmc60b2gzEnLY6fAygGGQNmBZDdTBb2EU
         9wbuL39i5U94SHvw+HLZ0LUYnsEbvR8VdCWUN6del4bo/uILm0qqvlcd/eU5/IyfvUEi
         yMeyb57mGO6d5wQwyLWaW+L/QgeNQsd+7+vqIqkTmL3m5Gd3Odk0IyANahJamqmRGyET
         glbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988459; x=1790593259;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U06rcgIn0LVt5Do84ZIYuayP7YCGGpRPbIbmdcyZosY=;
        b=u8Yf4T9luYt5GdScXDl/9+mxBDowc6wEgvzVcTebSoXGA5cEXLS1envXOiHASAStwv
         1e8Nm+7NyP8gA/+Hr6/ALLSTzQUctC3Su8mQbDw6Od+nk0Xb5TkXMGq2mHNIjc1wI6Rr
         ELhNi6bHwfVAgjF5/ciZ7hRoBfYInccLRaLc4lYawOSYs6mOlibVN9jiP5BfGgFVWNbB
         oLtIxFtqLSqNDlC80Xki6t4MHqkd7DxJC7TzL7UP+bOyEzWGkHUQthVCJmCaMb6AY/U9
         G5VJ0B7YjPpG0RRbeqOq2W89wpTmLq7JAGObDWVuk1AAg28QPoIqSIJRsq3R0bMz6wdX
         sRQw==
X-Forwarded-Encrypted: i=1; AKwUvByACrfp4zIrm+oNmrifRxVyAjV57zoTmdF1gWXc1T681ygB/v8BVnSIKiiGftGPOtnfFGIvvQY=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mFDKEdBZUk9CK37ikojOUwob9JHzqS330IjumM3YJKL+rtwlsl
	Ng55kb4Vj37XvPgGEFe3PlDSHoKgtu+pMaNpAluAlof9eMMAsLQ3wmoLl+ZxRO//Hz957twNS5v
	xt2LI9Ex1uwKKlAdnU37Klg==
X-Received: from edea12.prod.google.com ([2002:a05:6402:a18c:b0:6a6:1a9:f70f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:23d5:b0:6a5:f814:2278 with SMTP id 4fb4d7f45d1cf-6aa577f5a1dmr7324139a12.2.1789988458556;
 Mon, 21 Sep 2026 04:00:58 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:00:44 +0100
In-Reply-To: <20260921110050.3977591-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260921110050.3977591-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921110050.3977591-3-vdonnefort@google.com>
Subject: [PATCH v2 2/8] arm64: Introduce can_set_direct_map_range()
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3ag6xagokbqcckvuulmvyanvvnsl.jvtvw-allspzaz.aybzalkmpytdhyl.vyn@flex--vdonnefort.bounces.google.com];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.72:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3ag6xagokbqcckvuulmvyanvvnsl.jvtvw-allspzaz.aybzalkmpytdhyl.vyn@flex--vdonnefort.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.72:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EE777453AF
X-Spamd-Bar: --
Message-ID-Hash: 6F2577VSXCE3I5IMPXUQCL6NCBQIHELL
X-Message-ID-Hash: 6F2577VSXCE3I5IMPXUQCL6NCBQIHELL
X-MailFrom: 3ag6xagoKBqccKVUULMVYaNVVNSL.JVTVW-aLLSPZaZ.aYbZaLKMPYTdHYL.VYN@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6F2577VSXCE3I5IMPXUQCL6NCBQIHELL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

For systems where can_set_direct_map() is false, it is still possible
that a subregion of the direct map can be modified if it is mapped at
the last-level. Add an implementation for can_set_direct_map_range(). It
falls back to a page table walk to verify the mapping level if
can_set_direct_map() is false.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/include/asm/set_memory.h |  3 ++
 arch/arm64/mm/pageattr.c            | 50 +++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 0091ba12200e..80bb94a340fd 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -9,6 +9,9 @@
 bool can_set_direct_map(void);
 #define can_set_direct_map can_set_direct_map
 
+bool can_set_direct_map_range(struct page *page, unsigned long numpages);
+#define can_set_direct_map_range can_set_direct_map_range
+
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 132938b32eb1..5fcdb292905f 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -102,6 +102,56 @@ bool can_set_direct_map(void)
 		arm64_kfence_can_set_direct_map() || is_realm_world();
 }
 
+static int can_set_direct_map_pud_entry(pud_t *pud, unsigned long addr,
+					unsigned long next, struct mm_walk *walk)
+{
+	if (pud_leaf(pudp_get(pud)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int can_set_direct_map_pmd_entry(pmd_t *pmd, unsigned long addr,
+					unsigned long next, struct mm_walk *walk)
+{
+	if (pmd_leaf(pmdp_get(pmd)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int can_set_direct_map_pte_hole(unsigned long addr, unsigned long next,
+				       int depth, struct mm_walk *walk)
+{
+	return -EINVAL;
+}
+
+static const struct mm_walk_ops can_set_direct_map_ops = {
+	.pud_entry	= can_set_direct_map_pud_entry,
+	.pmd_entry	= can_set_direct_map_pmd_entry,
+	.pte_hole	= can_set_direct_map_pte_hole,
+};
+
+bool can_set_direct_map_range(struct page *page, unsigned long numpages)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	unsigned long end = addr + numpages * PAGE_SIZE;
+
+	if (can_set_direct_map())
+		return true;
+
+	if (!numpages)
+		return false;
+
+	/*
+	 * If !can_set_direct_map() then no one can split blocks and it is safe
+	 * to walk the page-table lockless.
+	 */
+	return !walk_kernel_page_table_range_lockless(addr, end,
+						      &can_set_direct_map_ops,
+						      NULL, NULL);
+}
+
 static int update_range_prot(unsigned long start, unsigned long size,
 			     pgprot_t set_mask, pgprot_t clear_mask)
 {
-- 
2.55.0.1082.g2b9226bbc0-goog

