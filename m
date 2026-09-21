Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE3BC982ED
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:01:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D694145473
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789988495;
	bh=oJ0zGW6aMw8rKZXNikPlWrWiaIddi7KYY011U3LJm+k=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ynIqnSn5mGad50+iPg7PmL3ZSaIIFLYGfEP4D/MoCs83RPmA5Uk+flq+rSCQ/bf+0
	 0SdaYtoAoINw9nRE0OfBAV8aEXK3vUSOFAwaeAMGCZi8VJnOSjV4ezWmYi3MWzLx/0
	 ov2rDjJGNrrZEWmRD3tvGP5EmyIdCbPB2BcQ7j3at8uhmk8DKA4JXWXCN3SD739LAJ
	 dWJiAUVcmb3Ndz5toULuqH4uLNmTBSBSDnQTjkv137sjAfZONA9OQXNRMOY1OMxhBc
	 JAt1gRzKULBKXfVgt6uED3bMeFTNG7myFVYjcv/1+wK0gZqmO3nf62U8C9z3tEDAyj
	 aWY/EVpNvGyug==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EFC7D44F26
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 11:00:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uvMqtJLx;
	dkim-atps=neutral
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so23854965e9.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 04:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789988458; x=1790593258; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IM/pFcIIS9AfJIvDjZJlWaiz8Fy5HD+1VXbC/YTcKBU=;
        b=uvMqtJLxo4I6g/XC+KDClb7z44+fDiTTu9kBBvRLXM9VFljZEHgrin9nhDR+25bdJZ
         4wgeuzTmKLzeNrJLTmrKvj86lcfl4s3RTOwtG2JoQ2W8o1sHgY51LnZFn9Eg5Gv4FKFy
         nVszk+mIkcw+eLtoQ4uUUFzyI1n7zhkkQsPKwpHk86rqCVTEU6/7v4K94tt2bPMN9B/L
         Jgcuir8fAIA4LWR02f+uC9oHcIGPPgESUytWab2NTYxPWBNlPVprhO6LksEoE3yEIj+v
         DZNhA0JcJNwKhjG6sKaKjqSgwCWOEvKKCyydXYYG5ReStAl+ukyBd0NpWXaA5cKaHL/K
         m/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988458; x=1790593258;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IM/pFcIIS9AfJIvDjZJlWaiz8Fy5HD+1VXbC/YTcKBU=;
        b=BfFv+qBcd4MDnSpnwPnCgKJ/tF3OtP1qgjSv5iZxt/tPeitGqzZBCKLQYz2/DQut5f
         rbZnO9TZ05iSrRtSToUNIsf1V9E1VHYgfvmRvqcQBFMXe7+DZKEmZzP0wGx+9gaAjWj8
         31n/kAGqOFWX8O+iEVaWKCAU56wednSF0j8+yLAD+wwVfUK+zC8KdMV3ZJ9bYNcKAdY/
         6wyLiy9R1oVqFIizmFiG5I+5WiYozlDO5xl+zck+bPQM+CPeiUVkM0zvNYl8hqG2HSuY
         /pvVb3oAuJ9eqf1/0PbZUnR1C8TxdSKMQX571o/At8LumBKc60cRyiWw4xcuHw6b/Itj
         bbFg==
X-Forwarded-Encrypted: i=1; AKwUvBzhax0yEuEEPuXSf44ar+kGR5TFno7aknTGCsJPQ/tedFbdJoPeF/1/QZkHwisQSe6sHq2YQFo=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kgd8QkMIg7WzBvmIUUcSKWlrQOKrCC+dT8EOFMSXqIZn3vkHZ0
	Y9yC8tpC4bba+xLJzf5sDfzwArGaENuzFipEiMb/FlAFdSGD/WSIAwnpMxJJOTj81yMaciNpBeu
	ejYYhkI8aqkncsrfvRywTNg==
X-Received: from wmcn17-n2.prod.google.com ([2002:a05:600c:c0d1:20b0:49e:8399:b77d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b2a:b0:49e:6861:50f7 with SMTP id 5b1f17b1804b1-49fc5687df8mr141949475e9.5.1789988457579;
 Mon, 21 Sep 2026 04:00:57 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:00:43 +0100
In-Reply-To: <20260921110050.3977591-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260921110050.3977591-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921110050.3977591-2-vdonnefort@google.com>
Subject: [PATCH v2 1/8] memblock: Introduce MEMBLOCK_PTEMAP
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3aq6xagokbqybjuttkluxzmuumrk.iusuv-zkkroyzy.zxayzkjloxscgxk.uxm@flex--vdonnefort.bounces.google.com];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.70:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3aq6xagokbqybjuttkluxzmuumrk.iusuv-zkkroyzy.zxayzkjloxscgxk.uxm@flex--vdonnefort.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.70:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EFC7D44F26
X-Spamd-Bar: --
Message-ID-Hash: WNJAAP4I6GSENJ4ZLANJU7HEQEFXRRGO
X-Message-ID-Hash: WNJAAP4I6GSENJ4ZLANJU7HEQEFXRRGO
X-MailFrom: 3aQ6xagoKBqYbJUTTKLUXZMUUMRK.IUSUV-ZKKROYZY.ZXaYZKJLOXScGXK.UXM@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WNJAAP4I6GSENJ4ZLANJU7HEQEFXRRGO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

Keeping PTE-level mappings is interesting on some architectures as it
allows mapping/unmapping pages from the kernel direct map without the
risk of splitting blocks which, under the break-before-make rule, may
trigger page-faults the kernel can't handle.

However, mapping the entire direct map at PTE-level is costly. So
instead, create a new memblock flag MEMBLOCK_PTEMAP to selectively apply
a PTE-level mapping.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 include/linux/memblock.h | 18 ++++++++++++++++++
 mm/memblock.c            | 30 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index aa845f488327..13263055996d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -52,6 +52,7 @@ extern unsigned long long max_possible_pfn;
  * kernel that we know is good to use. It is the only memory that
  * allocations may happen from in this phase.
  * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
+ * @MEMBLOCK_PTEMAP: memory region to be mapped using PTE-level mapping
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -63,6 +64,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
 	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
+	MEMBLOCK_PTEMAP		= 0x100,/* PTE-level mapping */
 };
 
 /**
@@ -160,6 +162,8 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
+int memblock_mark_ptemap(phys_addr_t base, phys_addr_t size);
+int memblock_clear_ptemap(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
 
@@ -285,8 +289,16 @@ static inline bool memblock_is_mirror(struct memblock_region *m)
 	return m->flags & MEMBLOCK_MIRROR;
 }
 
+static inline void memblock_warn_invalid_map_flags(struct memblock_region *m)
+{
+	enum memblock_flags map_flags = MEMBLOCK_NOMAP | MEMBLOCK_PTEMAP;
+
+	WARN_ON_ONCE((m->flags & map_flags) == map_flags);
+}
+
 static inline bool memblock_is_nomap(struct memblock_region *m)
 {
+	memblock_warn_invalid_map_flags(m);
 	return m->flags & MEMBLOCK_NOMAP;
 }
 
@@ -305,6 +317,12 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_SCRATCH;
 }
 
+static inline bool memblock_is_ptemap(struct memblock_region *m)
+{
+	memblock_warn_invalid_map_flags(m);
+	return m->flags & MEMBLOCK_PTEMAP;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index ea0de4b5f356..8a87d4d2516d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1204,6 +1204,35 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_SCRATCH);
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
@@ -2880,6 +2909,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
 	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
+	[ilog2(MEMBLOCK_PTEMAP)] = "PTEMAP",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.55.0.1082.g2b9226bbc0-goog

