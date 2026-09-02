Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1699C61DD6
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:54:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 09265451E5
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788346470;
	bh=BkWHB+IxRJyp/mrL2MDxtxRI3LoQB6qxpIKEIBvf9+w=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3pmTWGktltRKOQ+aHa6BlV9J6jFfctGVDb2JasVF+OkD62qt1B79Ia9ZkokvLI4j8
	 0LdjKqpSNX7mrJdkyqCC0OIxcUSZI3uHu/2cbTXtzU9lAK9Hjb1iFU958kcy6yXSqy
	 k9VzVyZvkk6yAqC/zlgGT3XQHMYPQuCrsgMP3sp7vTjChUacVJHb+ytWXFTWOkcIMJ
	 UC2zLax5spPEi+HXafZdyOxEpUMB6G9sCl+WdwJb+cNrGoseedYbe6YTC4i/coAEsA
	 yKWxTpeY4NkyfC1P/6N3G7VHMRuiUtFR0oVxTZQVg0iJSW2YjCS6PRn3G54tWtk11Q
	 oLGExqJ0lb4IA==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 77025453CE
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 10:51:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iNrdTuMh;
	dkim-atps=neutral
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49b8c651ac0so10256845e9.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788346275; x=1788951075; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNWZLpQFf8So7isbdfRHNiNRkktdYQTRcSFjKmsQSY0=;
        b=iNrdTuMhys4vCED7/oz6Y8pcbiw9OcwG88LNFbwxbXQ3TR7H7gjSYxKLEq7XnXiYG3
         G8e16KlsrLuqdnfIT5jgViswhw4KbH4KbVE0kuadaVzXntiKJsTcqKobeX5Fco3F8qB+
         4r3NwcDbJqJCLMrWsiB6TEajks8chF5xidS05wdffz087vlHARTitsL4Ltjal2cJ3vhO
         KDd0Ba3rZaPk5DH016o7/Y+7X+eD/BE0/+r99UkvkPqwuTeh5XVY/jgHjgb3vvR4wARG
         kCgnNEA9JrG28+VqCU30IZP+pI0V/2T82ltPN4o0CVF2jXT96jhIkX8C+mtePNOR7kEE
         3CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346275; x=1788951075;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TNWZLpQFf8So7isbdfRHNiNRkktdYQTRcSFjKmsQSY0=;
        b=UFz1IPTEr6ZvcokVv00XXXTZs0bmIeK2sMEB3DcqWrUJqoTtsUvjvppZ3kN0EXS/Ke
         C7tXLokFereEjvjGXVUPQoeO17+0p7PCOGgp6IYjyMr6hrUO1PWLe/RtIFqsAm5SucxY
         giUolKc5GDTxVFzmv33vuIJMpxxamZvNyzmvv/0ht/LQjnc7ox3O4SzMe6kQWmNjkVev
         CGnKn2QXHe+HvMvwIUoTzBqDFo8fjKtAO9L36s8iQLbWTN7rIJPwGtDO8eAxlNyCQkhL
         EKqjK9s263jPalTSF9dsJ8qYeHHo4nIC0nzVPIrvtxgHHow7C3rG53vs8lWVNJCOGLKw
         6PpA==
X-Forwarded-Encrypted: i=1; AHgh+Rr02Eu7u+szslnS4/mdXU6o8l9twAnp3+GEW2KaNnRPbG+4Sh0/LGZjSLD872qjFTkMmmW3nvo=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++k1lkTuywus77GQ5zfXCpmZhsGyVS8FDI2EndEASGXG8q2kd0ZI
	2dvSXgPKIPNgpvPdJLODczORtLVwElfrcwSmYYb7REcXYCgIkGYF/qVhMBTORpNiLRY537t/Ojc
	nM9tz35yyUUGVY58ZL20zDg==
X-Received: from wrpe17.prod.google.com ([2002:adf:f351:0:b0:484:3204:23be])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e93:b0:499:cd34:100d with SMTP id 5b1f17b1804b1-49ce57f5235mr66954815e9.7.1788346275192;
 Wed, 02 Sep 2026 03:51:15 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:09 +0100
In-Reply-To: <20260902104712.2399797-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260902104712.2399797-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902104712.2399797-8-vdonnefort@google.com>
Subject: [PATCH v9 07/10] arm64: Implement __set_direct_map*()
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3o_-xagokbl4r9kjjabknpckkcha.8kikl-paaheopo.pnqopa9benis6na.knc@flex--vdonnefort.bounces.google.com];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.71:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3o_-xagokbl4r9kjjabknpckkcha.8kikl-paaheopo.pnqopa9benis6na.knc@flex--vdonnefort.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.71:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 77025453CE
X-Spamd-Bar: --
Message-ID-Hash: 2XVXLKP6F4SC46DSCDS5PZUKNQ66HMUW
X-Message-ID-Hash: 2XVXLKP6F4SC46DSCDS5PZUKNQ66HMUW
X-MailFrom: 3o_-XagoKBl4R9KJJABKNPCKKCHA.8KIKL-PAAHEOPO.PNQOPA9BENIS6NA.KNC@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2XVXLKP6F4SC46DSCDS5PZUKNQ66HMUW/>
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

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 1a37f4ef130b..080a40846bbe 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -16,6 +16,10 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+int __set_direct_map_invalid_noflush(struct page *page);
+#define __set_direct_map_invalid_noflush __set_direct_map_invalid_noflush
+int __set_direct_map_default_noflush(struct page *page);
+#define __set_direct_map_default_noflush __set_direct_map_default_noflush
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index c59ef17eb0d0..28adab0edace 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -294,28 +294,38 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 					__pgprot(PTE_PRESENT_VALID_KERNEL));
 }
 
-int set_direct_map_invalid_noflush(struct page *page)
+int __set_direct_map_invalid_noflush(struct page *page)
 {
 	pgprot_t clear_mask = __pgprot(PTE_PRESENT_VALID_KERNEL);
 	pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
 
+	return update_range_prot((unsigned long)page_address(page),
+				 PAGE_SIZE, set_mask, clear_mask);
+}
+
+int set_direct_map_invalid_noflush(struct page *page)
+{
 	if (!can_set_direct_map())
 		return 0;
 
+	return __set_direct_map_invalid_noflush(page);
+}
+
+int __set_direct_map_default_noflush(struct page *page)
+{
+	pgprot_t set_mask = __pgprot(PTE_PRESENT_VALID_KERNEL | PTE_WRITE);
+	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
+
 	return update_range_prot((unsigned long)page_address(page),
 				 PAGE_SIZE, set_mask, clear_mask);
 }
 
 int set_direct_map_default_noflush(struct page *page)
 {
-	pgprot_t set_mask = __pgprot(PTE_PRESENT_VALID_KERNEL | PTE_WRITE);
-	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
-
 	if (!can_set_direct_map())
 		return 0;
 
-	return update_range_prot((unsigned long)page_address(page),
-				 PAGE_SIZE, set_mask, clear_mask);
+	return __set_direct_map_default_noflush(page);
 }
 
 static int __set_memory_enc_dec(unsigned long addr,
-- 
2.55.0.970.g62bdec98f9-goog

