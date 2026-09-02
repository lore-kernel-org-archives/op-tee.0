Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38080C61DD6
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:52:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6DD0545040
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788346334;
	bh=RsJ6maEfydlgRHfAusJRbg3oK58wmuxDifTUT74arNQ=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=X5g/iXpX9vKXxz/S6nzwWOjoFi2cB6O8CzEFSlvokK4N+aa1zpgATaUuYN1/qGm/s
	 c/iiJTTHC55M5pR39mXIbetIFDv/Ckox8T3qKM90J/Y/KXrP8Yy3a72lt8A1HIybU6
	 3JChtI46fjx181rbV2cva+xMDZugWH4uRUdHl84/JiehO95XB6SWIfW2y1CLssV2So
	 k7xyf8Oxq2q33gQ9TxqpJ56R2XeGwOsHUojeqirLdIbw3zdKfh6uXA5NG0osYVmIL2
	 of1dvmrCK9Ve3Hpq1esCzSaG1Qa+3bmmFLFhQe6uUgwB65e43TJGo1UrSTRbEbbGs3
	 ILmkkBvzSblPw==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8B9A943ECB
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 10:51:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cb+i0O9v;
	dkim-atps=neutral
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49953abe51fso5056985e9.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788346269; x=1788951069; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmhXowTIOzHcHY7UkEdd72g+gSt6KBOTf5gqmJgT9x4=;
        b=cb+i0O9v0rGgLigX0VJWk+g7XIcYTABgYV0SVnXQvXtJTjzpvKBavEWRXkO6z5tM2I
         apsfxndUUEOh6Nd57jPzap8544Z1/RNqH318dYM8uYhj2luOzAiOqbGXra1td8swZgjX
         +Xo251XH9H94htrwaad8CdDlToxUr8RBzTyyTTQq7fq6iLoutopNlqPqK3WOANFwaNxs
         rPxMEFOpCl1amcpcGQzaa60uO0kLyNK2qn6I+MWSbLfvv8m8Gt4rh0nxRjjxDFVNkuOv
         D05kKuOZdYJyL5Qbw6er6TgGrOkHo2ktfb3CcAV1+r18yZxUWCQqYZgdiAdvy1At4I4R
         wfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346269; x=1788951069;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BmhXowTIOzHcHY7UkEdd72g+gSt6KBOTf5gqmJgT9x4=;
        b=oVqyII4jvVSpbgvqu6EHZUrlLqlxko1JWe8lmdMMXMLzw2gfqygwVv0ZQsPlqNH+iG
         3w/xvNf80Vuuf6girvgVbtBO2f9jWOQRDDgxxScUgaDqemLdPCgZdndqPDAIhhugGQX8
         feALmgl4KJwXIJOfupIkNDmfQhZR5Qa9dO91oTGovmtNPL9QUqqNd6hGrAjo09Mi83cm
         hGpp1SwIn15+adUCxuSgioxGQNYi/s3ZHVCFURjporWcy2+hkvLwvqum5U11S35dMIog
         8/1FR5sARxe4A2ATyNm2Yie244UC1BC95ktyXe84duPYCwC7X/yHPwvXEN4XL7aG6bYD
         xJwQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFJF1jKbK6axOk9gdjdmU88JGvv92qvo31nwcyBj6mVJ7t8zcTLNz/lUxNgWIFhogNjcU6pOI=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lvu9ZDly73qKgt6l2kEIXdIbE5oVypsdvtlqg4RjhCfL4MlT7K
	MJnGtdJnJh8LnXprhFtJzmFBSi7EMDkNiat6G8fkuAc5pU8/StZ5/F2xVYHzmm7RAvpjgRGrX+G
	cqGyN+nNqpcyb63WQDv4Qpw==
X-Received: from wmbgx10.prod.google.com ([2002:a05:600c:858a:b0:49b:96b9:9d0f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b18:b0:49c:d26a:cf70 with SMTP id 5b1f17b1804b1-49ce583adbemr59327195e9.15.1788346269076;
 Wed, 02 Sep 2026 03:51:09 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:04 +0100
In-Reply-To: <20260902104712.2399797-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260902104712.2399797-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902104712.2399797-3-vdonnefort@google.com>
Subject: [PATCH v9 02/10] of: reserved_mem: Introduce "ll-map" property
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3nf-xagokblgl3edd45ehj6ee6b4.2ecef-j44b8iji.jhkij4358hcm0h4.eh6@flex--vdonnefort.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3nf-xagokblgl3edd45ehj6ee6b4.2ecef-j44b8iji.jhkij4358hcm0h4.eh6@flex--vdonnefort.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.70:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8B9A943ECB
X-Spamd-Bar: --
Message-ID-Hash: AJ5M7LZN2Q6PTCOTSMMEIC2E3FG7ZQIJ
X-Message-ID-Hash: AJ5M7LZN2Q6PTCOTSMMEIC2E3FG7ZQIJ
X-MailFrom: 3nf-XagoKBlgL3EDD45EHJ6EE6B4.2ECEF-J44B8IJI.JHKIJ4358HCM0H4.EH6@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AJ5M7LZN2Q6PTCOTSMMEIC2E3FG7ZQIJ/>
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

Add an "ll-map" property for reserved-memory regions. When set, it
splits the underlying memblock and sets the MEMBLOCK_LLMAP flag.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8c9d6395d6a3..9ff2d02cb149 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -32,9 +32,32 @@ static struct reserved_mem *reserved_mem __refdata = reserved_mem_array;
 static int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
 static int reserved_mem_count;
 
+enum of_rmem_flags {
+	OF_RMEM_NONE		= 0,
+	OF_RMEM_NOMAP		= BIT(0),
+	OF_RMEM_LLMAP		= BIT(1),
+};
+
+static int __init of_reserved_mem_flags(unsigned long node, enum of_rmem_flags *flags)
+{
+	*flags = OF_RMEM_NONE;
+
+	if (of_get_flat_dt_prop(node, "no-map", NULL))
+		*flags |= OF_RMEM_NOMAP;
+	if (of_get_flat_dt_prop(node, "ll-map", NULL))
+		*flags |= OF_RMEM_LLMAP;
+
+	if ((*flags & OF_RMEM_NOMAP) && (*flags & OF_RMEM_LLMAP)) {
+		pr_err("Reserved memory: no-map and ll-map are mutually exclusive\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
-	phys_addr_t align, phys_addr_t start, phys_addr_t end, bool nomap,
-	phys_addr_t *res_base)
+	phys_addr_t align, phys_addr_t start, phys_addr_t end,
+	enum of_rmem_flags flags, phys_addr_t *res_base)
 {
 	phys_addr_t base;
 	int err = 0;
@@ -46,10 +69,21 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 		return -ENOMEM;
 
 	*res_base = base;
-	if (nomap) {
-		err = memblock_mark_nomap(base, size);
-		if (err)
+	if (flags & OF_RMEM_LLMAP) {
+		err = memblock_mark_llmap(base, size);
+		if (err) {
 			memblock_phys_free(base, size);
+			return err;
+		}
+	}
+
+	if (flags & OF_RMEM_NOMAP) {
+		err = memblock_mark_nomap(base, size);
+		if (err) {
+			if (flags & OF_RMEM_LLMAP)
+				memblock_clear_llmap(base, size);
+			memblock_phys_free(base, size);
+		}
 	}
 
 	if (!err)
@@ -119,17 +153,29 @@ static int fdt_fixup_reserved_mem_node(unsigned long node,
 				       phys_addr_t base, phys_addr_t size);
 
 static int __init early_init_dt_reserve_memory(phys_addr_t base,
-					       phys_addr_t size, bool nomap)
+					       phys_addr_t size,
+					       enum of_rmem_flags flags)
 {
-	if (nomap) {
+	int err;
+
+	if (flags & OF_RMEM_LLMAP) {
+		err = memblock_mark_llmap(base, size);
+		if (err)
+			return err;
+	}
+
+	if (flags & OF_RMEM_NOMAP) {
 		/*
 		 * If the memory is already reserved (by another region), we
 		 * should not allow it to be marked nomap, but don't worry
 		 * if the region isn't memory as it won't be mapped.
 		 */
 		if (memblock_overlaps_region(&memblock.memory, base, size) &&
-		    memblock_is_region_reserved(base, size))
+		    memblock_is_region_reserved(base, size)) {
+			if (flags & OF_RMEM_LLMAP)
+				memblock_clear_llmap(base, size);
 			return -EBUSY;
+		}
 
 		return memblock_mark_nomap(base, size);
 	}
@@ -143,10 +189,10 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
 static int __init __reserved_mem_reserve_reg(unsigned long node,
 					     const char *uname)
 {
+	enum of_rmem_flags flags;
 	phys_addr_t base, size;
-	int len, err;
 	const __be32 *prop;
-	bool nomap;
+	int len, err;
 	u64 b, s;
 
 	prop = of_flat_dt_get_addr_size_prop(node, "reg", &len);
@@ -157,7 +203,9 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 		pr_warn("Reserved memory: node '%s' has %d <base size> entries, only the first is used\n",
 			uname, len);
 
-	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	err = of_reserved_mem_flags(node, &flags);
+	if (err)
+		return err;
 
 	err = fdt_validate_reserved_mem_node(node, NULL);
 	if (err && err != -ENODEV)
@@ -167,7 +215,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	base = b;
 	size = s;
 
-	if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
+	if (size && early_init_dt_reserve_memory(base, size, flags) == 0) {
 		fdt_fixup_reserved_mem_node(node, base, size);
 		pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 			 uname, &base, (unsigned long)(size / SZ_1M));
@@ -399,8 +447,8 @@ int __init fdt_scan_reserved_mem(void)
  *	reserved regions to keep the reserved memory contiguous if possible.
  */
 static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
-	phys_addr_t align, phys_addr_t start, phys_addr_t end, bool nomap,
-	phys_addr_t *res_base)
+	phys_addr_t align, phys_addr_t start, phys_addr_t end,
+	enum of_rmem_flags flags, phys_addr_t *res_base)
 {
 	bool prev_bottom_up = memblock_bottom_up();
 	bool bottom_up = false, top_down = false;
@@ -435,7 +483,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
 		memblock_set_bottom_up(bottom_up);
 
 	ret = early_init_dt_alloc_reserved_memory_arch(size, align,
-			start, end, nomap, res_base);
+			start, end, flags, res_base);
 
 	/* Restore old setting if needed */
 	if (bottom_up != top_down)
@@ -452,9 +500,9 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 {
 	phys_addr_t start = 0, end = 0;
 	phys_addr_t base = 0, align = 0, size;
+	enum of_rmem_flags flags;
 	int i, len;
 	const __be32 *prop;
-	bool nomap;
 	int ret;
 
 	prop = of_get_flat_dt_prop(node, "size", &len);
@@ -477,7 +525,9 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
 	}
 
-	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	ret = of_reserved_mem_flags(node, &flags);
+	if (ret)
+		return ret;
 
 	ret = fdt_validate_reserved_mem_node(node, &align);
 	if (ret && ret != -ENODEV)
@@ -495,7 +545,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 
 			base = 0;
 			ret = __reserved_mem_alloc_in_range(size, align,
-					start, end, nomap, &base);
+					start, end, flags, &base);
 			if (ret == 0) {
 				pr_debug("allocated memory for '%s' node: base %pa, size %lu MiB\n",
 					uname, &base,
@@ -505,7 +555,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		}
 	} else {
 		ret = early_init_dt_alloc_reserved_memory_arch(size, align,
-							0, 0, nomap, &base);
+							0, 0, flags, &base);
 		if (ret == 0)
 			pr_debug("allocated memory for '%s' node: base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
@@ -635,8 +685,8 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem,
 static void __init fdt_init_reserved_mem_node(unsigned long node, const char *uname,
 					      phys_addr_t base, phys_addr_t size)
 {
+	enum of_rmem_flags flags;
 	int err = 0;
-	bool nomap;
 
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
@@ -650,14 +700,19 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 	rmem->base = base;
 	rmem->size = size;
 
-	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	err = of_reserved_mem_flags(node, &flags);
+	if (err)
+		return;
 
 	err = __reserved_mem_init_node(rmem, node);
 	if (err != 0 && err != -ENODEV) {
 		pr_info("node %s compatible matching fail\n", rmem->name);
 		rmem->name = NULL;
 
-		if (nomap)
+		if (flags & OF_RMEM_LLMAP)
+			memblock_clear_llmap(rmem->base, rmem->size);
+
+		if (flags & OF_RMEM_NOMAP)
 			memblock_clear_nomap(rmem->base, rmem->size);
 		else
 			memblock_phys_free(rmem->base, rmem->size);
@@ -667,9 +722,10 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 		bool reusable =
 			(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
 
-		pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
+		pr_info("%pa..%pa (%lu KiB) %s %s %s %s\n",
 			&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
-			nomap ? "nomap" : "map",
+			(flags & OF_RMEM_LLMAP) ? "last-level " : "",
+			(flags & OF_RMEM_NOMAP) ? "nomap" : "map",
 			reusable ? "reusable" : "non-reusable",
 			rmem->name ? rmem->name : "unknown");
 	}
-- 
2.55.0.970.g62bdec98f9-goog

