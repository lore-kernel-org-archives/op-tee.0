Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67190C982E1
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:02:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AD2534449D
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789988554;
	bh=g0ILEDzn/1wNfpkkWXZLtbOtycO1ck/Djp6L7YWIBhE=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=b1ROcPECAWAy7S8y+enO3mFfJ/c5Hqu2XgvEPJ0ro6RwCO2/8jiDe2EWlsPGPXwOv
	 I8CyzRZuNnqmIwgxrGdISVmIX9tJtWqhhjND2FekMWDrN+XIZm4FtObo3wtbtVApkD
	 gx8GzPZpzDRq+WA39Tq38aDkFbXeHNhC26FnHFsZhEdVn7wZ3HuIQqVZVnVOZUY+W1
	 hwUH2wnmpwtnRpdIHWu3bMFgPdwvnEgveElDb6uR7hANltvG7PfF4py9TSjy79eQ5/
	 Pfe85brQVvwQdZnf5KTbR/CnORp1ckFWanvTkPQK3gCvOWiyKwDxwpA78vss9JwWDN
	 59952M2nu/14Q==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 44D7445418
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 11:01:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=X8uT8eTv;
	dkim-atps=neutral
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29c391bd2fso238539266b.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789988460; x=1790593260; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8VZDFkjWzOugDjBak5KEVL2CvMFyhCyJVy2+GxZNxI=;
        b=X8uT8eTv3zhLQNs3ZkY018j9gsbCqVVHE9MkIvtEq6CfclPiyx6snyDcQOxoFIxgJf
         ErOl2riI4N4GRTL4I/SPdLL0GvOpAFc0FDLd1Tucb4Ne0tjrehZSzWxQ4FK9GNwjQ/FH
         cVQBq8YmxDI6u75YoLRNBIMlmkMaINLrCtCH0Xg9SRlaO55edMzMgrHUV3bqGMtejEAj
         Pw3qU6UPzZ1jSfw5UYaDOqolOTF0MN0QDxoKY7pFqc6mCEkcwaExSpblKUgq2MyZIdUE
         B+Q8vKjylX9T9T59hzFWYGliaTDHbV6yfv0s7lAo/FtuNPoiondiP1/9LQ1IYepKrBcY
         +tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988460; x=1790593260;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8VZDFkjWzOugDjBak5KEVL2CvMFyhCyJVy2+GxZNxI=;
        b=sZpFvumsYUkNLNU5iYk588lqv/o6HoaPMPa7LEfFQr+wg/2W4C9bFONgxQGiJtosmX
         cQbpoWb9KWsOK+mbs8lsc87BsRjXQkqEGJ45arll2c26Crv50jeNYxKw0YqJnl20r9b6
         5da4W9pKaxRIVW7BcndGAp9L8YlYsQlNNabjB9LaZ2GFQtBHU+h/+gk4kcJRaMjaZJ+7
         SEQFYOBtDqtNEe7Azm23pK0kLoohv00uONi4oPP4vxyY8pr1vOHOCrQnAPUFBBSxC4Su
         KVN9/gaqlpLiWyRQqGGYB0l8caKgyS1Vcso0L4B2KNaeguDUCkjHu+LN7ye/sinuChpg
         L6KA==
X-Forwarded-Encrypted: i=1; AKwUvBxu4dbh0bWXJ3ghAy3u/MEzUAb15JkPJRAHP6/6iopqoCxnvcfErt1v0WKgQYC7NDaMUMiNtl4=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lliI1rIgjlvf+YjU7RBm/sUi+KpdX4mcQ5cMP2r/F8PO66CPrN
	A92BsI5WoNR1RTr3EASe9AUzzT2i039tPaMLKh4KCqzCnoKUuhFog+RTOvM+9cF2Mm89I1HOnn1
	N93NQEW9LvJH3HraBMRrlew==
X-Received: from ejcew23.prod.google.com ([2002:a17:907:9517:b0:c2a:25e5:645a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d17:b0:c26:1649:47a5 with SMTP id a640c23a62f3a-c2a15aeb6c4mr860923766b.27.1789988459841;
 Mon, 21 Sep 2026 04:00:59 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:00:45 +0100
In-Reply-To: <20260921110050.3977591-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260921110050.3977591-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921110050.3977591-4-vdonnefort@google.com>
Subject: [PATCH v2 3/8] arm64: Introduce __set_direct_map*()
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org,
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3aw6xagokbqgdlwvvmnwzbowwotm.kwuwx-bmmtqaba.bzcabmlnqzueizm.wzo@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.72:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3aw6xagokbqgdlwvvmnwzbowwotm.kwuwx-bmmtqaba.bzcabmlnqzueizm.wzo@flex--vdonnefort.bounces.google.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.218.72:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 44D7445418
X-Spamd-Bar: --
Message-ID-Hash: 6ECBGILKWMVVZ64TIDPPRJF7WICI6WNO
X-Message-ID-Hash: 6ECBGILKWMVVZ64TIDPPRJF7WICI6WNO
X-MailFrom: 3aw6xagoKBqgdLWVVMNWZbOWWOTM.KWUWX-bMMTQaba.bZcabMLNQZUeIZM.WZO@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6ECBGILKWMVVZ64TIDPPRJF7WICI6WNO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

Add implementation for the unsafe functions __set_direct_map*(). They do
not verify for can_set_direct_map() and expect the caller to do so
beforehand.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 arch/arm64/include/asm/set_memory.h |  4 ++++
 arch/arm64/mm/pageattr.c            | 22 ++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 80bb94a340fd..5e372a02b825 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -16,6 +16,10 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
 int set_direct_map_default_noflush(struct page *page, unsigned int numpages);
+int __set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
+#define __set_direct_map_invalid_noflush __set_direct_map_invalid_noflush
+int __set_direct_map_default_noflush(struct page *page, unsigned int numpages);
+#define __set_direct_map_default_noflush __set_direct_map_default_noflush
 bool kernel_page_present(struct page *page);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 5fcdb292905f..3aaba7f988ce 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -301,28 +301,38 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 					__pgprot(PTE_PRESENT_VALID_KERNEL));
 }
 
-int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages)
+int __set_direct_map_invalid_noflush(struct page *page, unsigned int numpages)
 {
 	pgprot_t clear_mask = __pgprot(PTE_PRESENT_VALID_KERNEL);
 	pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
 
+	return update_range_prot((unsigned long)page_address(page),
+				 PAGE_SIZE * numpages, set_mask, clear_mask);
+}
+
+int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages)
+{
 	if (!can_set_direct_map())
 		return 0;
 
+	return __set_direct_map_invalid_noflush(page, numpages);
+}
+
+int __set_direct_map_default_noflush(struct page *page, unsigned int numpages)
+{
+	pgprot_t set_mask = __pgprot(PTE_PRESENT_VALID_KERNEL | PTE_WRITE);
+	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
+
 	return update_range_prot((unsigned long)page_address(page),
 				 PAGE_SIZE * numpages, set_mask, clear_mask);
 }
 
 int set_direct_map_default_noflush(struct page *page, unsigned int numpages)
 {
-	pgprot_t set_mask = __pgprot(PTE_PRESENT_VALID_KERNEL | PTE_WRITE);
-	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
-
 	if (!can_set_direct_map())
 		return 0;
 
-	return update_range_prot((unsigned long)page_address(page),
-				 PAGE_SIZE * numpages, set_mask, clear_mask);
+	return __set_direct_map_default_noflush(page, numpages);
 }
 
 static int __set_memory_enc_dec(unsigned long addr,
-- 
2.55.0.1082.g2b9226bbc0-goog

