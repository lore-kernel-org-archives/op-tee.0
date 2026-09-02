Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A484C624D0
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:54:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 730BD45315
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788346443;
	bh=nMu6uOIdcSiaN+JYugdLeZy5798bpsbb/pHYStuoqbU=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JMM9tZYkUdN65F2zCaOFutTmUBqWueDKvlvHb8dMsB/G5ODzFrIWCITvUwkqv0yqX
	 VKN9KXwN9L6ZxUOkst47GZEiS8I5WCPaNIgG+SD4yb3F0/krIQCJamRlDBjIL3g6eD
	 34yFCmcvUDAdQUU65tVaCoyv78lTnSB5XA62i+4WVFHGnEJxVeD2fyfYfMluuIYZ91
	 mlC/C8yuTYsAWD9HqyF9797qRx3PTxzS+L5Qpb6Z7OZETPTpGUFT0tCMkvQtqsGGFh
	 aqx2oASllFcu11nH46LiI5Ye4wSqSJ6N5q7y2qmp/0vU+kIO2M67LYO8oKlhx8R5px
	 lxFvci+hly3ew==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8076144F37
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 10:51:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=r7lJIAdJ;
	dkim-atps=neutral
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a125f5b317so1028983a12.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788346274; x=1788951074; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gODwxuTtOVKQ6CMnGDMT0l3+wYWk2p1Ok9ZsUXJwJCE=;
        b=r7lJIAdJ1ioHeWIbFzpikr/Via4wGKfdPUK4atNQ4YYGIXAs9R8IbuVtFHrVldR4n9
         tVScWuOocgSuCRbAhBXv5aVE1m7jG0mi86/CIg+mSqux21TnLTTyIqHZ83zRL7R7HU82
         pciRqbfDXeOzdcSF36m8OX1TFixswt7Ko/R72CGLr3TToXF9ijHl5iba1qt8KBqZvfiL
         HDamI0dET+c68tXsuW/TA7PIvgX8U0PZ3HEJl4Rc37EfLay03UOvJBtPVp/ELsFT/L0H
         BzK7sm3IztIPj3MK2mZI5mzl0cDppX6O2HVo0XBuLwLwdoXLCrj9c/Q3rgShPT3M2sHr
         a6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346274; x=1788951074;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gODwxuTtOVKQ6CMnGDMT0l3+wYWk2p1Ok9ZsUXJwJCE=;
        b=fAewg1mvFJHXazMzRDrsGn/kLAOy1fVjk5XkDuhO/NFlZEwkPEW7S/t/QyHnre5Aq4
         SDYCge8eVYHbkjAq6/ooTSbQvG0KcLnzxveoNwaXwO75lu98PIOLFiogZjGcS93Tr4Zw
         hRQui0Ugdzj6oVcQdNkYpXKA0d/B/0JNVAjc9U57bCsYyIhg07p7iZ0WaxAyB8TIsoM5
         Oj9gFdKbvp77DB9KrH1ure+o93z/Cfn/e5eeubAULE5m7Y5xRewZdgIdZwKknB8hoYJi
         PqeUigxqMSLLyGwFRVG2V3y0kVFDaQSKxaoL/4HRRPNLfg/ZXMbyaWSro7+/EQEfb+x5
         KVHA==
X-Forwarded-Encrypted: i=1; AKwUvBxijDozGF4MrssR8m1IsnzLa47roAmIN99Q6N2BdrLFaxxY5h7u2mZHS9LPe9z8wPKlTdpEvxg=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kW5ozIVHOgQ5ljH7Zn7W/LPAeEsgjccZZStDScEEBnFt7vqZLo
	binKmFfT3M4KzEfMfQmqPW9T6wNOI2niWvYX6eybUFKki/mU5wEFUuDUAjaSLASzA/8LOSbDfR1
	4ptq3PrXMVKQpAY7tbOFS8Q==
X-Received: from edy6-n2.prod.google.com ([2002:a05:6402:5346:20b0:6a6:8ab2:8708])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4284:b0:6a6:32f5:ff40 with SMTP id 4fb4d7f45d1cf-6a682af8134mr2906512a12.20.1788346274084;
 Wed, 02 Sep 2026 03:51:14 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:08 +0100
In-Reply-To: <20260902104712.2399797-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260902104712.2399797-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902104712.2399797-7-vdonnefort@google.com>
Subject: [PATCH v9 06/10] arm64: Implement can_set_direct_map_range()
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3ov-xagokbl0q8jii9ajmobjjbg9.7jhjk-o99gdnon.ompno98admhr5m9.jmb@flex--vdonnefort.bounces.google.com];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.70:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3ov-xagokbl0q8jii9ajmobjjbg9.7jhjk-o99gdnon.ompno98admhr5m9.jmb@flex--vdonnefort.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.70:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8076144F37
X-Spamd-Bar: --
Message-ID-Hash: AV3ZU57PFE6NJNUKZ22GSGB43HSTCTEG
X-Message-ID-Hash: AV3ZU57PFE6NJNUKZ22GSGB43HSTCTEG
X-MailFrom: 3ov-XagoKBl0Q8JII9AJMOBJJBG9.7JHJK-O99GDNON.OMPNO98ADMHR5M9.JMB@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AV3ZU57PFE6NJNUKZ22GSGB43HSTCTEG/>
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

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 90f61b17275e..1a37f4ef130b 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -9,6 +9,9 @@
 bool can_set_direct_map(void);
 #define can_set_direct_map can_set_direct_map
 
+bool can_set_direct_map_range(struct page *page, unsigned long nr_pages);
+#define can_set_direct_map_range can_set_direct_map_range
+
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 58898ae53f5d..c59ef17eb0d0 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -103,6 +103,48 @@ bool can_set_direct_map(void)
 		system_supports_bbml3();
 }
 
+bool can_set_direct_map_range(struct page *page, unsigned long nr_pages)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	unsigned long end = addr + nr_pages * PAGE_SIZE;
+
+	if (can_set_direct_map())
+		return true;
+
+	/*
+	 * If !can_set_direct_map() then no one can split blocks and it is safe
+	 * to walk the page-table lockless.
+	 */
+	while (addr < end) {
+		pud_t *pudp, pud;
+		pmd_t *pmdp, pmd;
+		pgd_t *pgdp;
+		p4d_t *p4dp;
+
+		pgdp = pgd_offset_k(addr);
+		if (pgd_none(READ_ONCE(*pgdp)))
+			return false;
+
+		p4dp = p4d_offset(pgdp, addr);
+		if (p4d_none(READ_ONCE(*p4dp)))
+			return false;
+
+		pudp = pud_offset(p4dp, addr);
+		pud = READ_ONCE(*pudp);
+		if (pud_none(pud) || pud_leaf(pud))
+			return false;
+
+		pmdp = pmd_offset(pudp, addr);
+		pmd = READ_ONCE(*pmdp);
+		if (pmd_none(pmd) || pmd_leaf(pmd))
+			return false;
+
+		addr = pmd_addr_end(addr, end);
+	}
+
+	return true;
+}
+
 static int update_range_prot(unsigned long start, unsigned long size,
 			     pgprot_t set_mask, pgprot_t clear_mask)
 {
-- 
2.55.0.970.g62bdec98f9-goog

