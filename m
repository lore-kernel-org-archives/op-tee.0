Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA87EC43327
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:23:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1049944A27
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 10:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782815020;
	bh=AUwidHasjkRfCuksUik7oojH9RAiyJ76u4Xbcp4FZnc=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=U66Sxi7UofSpj4C9rpXMyeZSoWQW5p3FJia3fpaIge5XMPQEsJzuk31c3bBODIMFp
	 MzEaNNfcXGbTn/tr0MjcWT+GVOucdZp7jsWzljOynjkRADXnJ5QDnJSnb517orHI4G
	 Ad4HGVdllJ/WUiuAYV5CXfPaGZnT1zkRbZi6MfrLEceuBOeje8VguOj3XG4mu4XCYN
	 bbL8q0GRmV5ej7nQSxThONM0b3FuYM6EvpqvR3QKUmUCSHbbq0KNxMOHpDWpJSZXEo
	 i1nQZKyXt8H/QScOgWR8S71ZtkFiKCKeuklXRC6nJiEPSfILKUXqg4bWLYKwkbzCMu
	 uRdtcjpU2/QWA==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A452F44F9D
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 10:21:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dsV66Mub;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49260d6eaadso29732085e9.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782814889; x=1783419689; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gyGZakZ2i/l8Ijp+dx1ly7m47WNFgufwNDcjOd78FW4=;
        b=dsV66MubrjLCZBdw79hoEEpq0SOtvB3wzpTZX1cYSTxOlqea3EU4ljwGCBCT4hI9mZ
         ehgYFDVHoG9DPrc05RLgKcSltpaNq9r4UYP1JO/Xw+tiZQW6g2yWRKQRc7rSHzgCj6WY
         1i8720N4fOO7wJ0GLpjC5GLjNQ30UtV8JV0oiDv1IDdstkRjJcly5Gj5/yaQ1JuCnjk+
         abOC1mlj6D8XpUMJ942HlDXw2+lmDkJmHhdL3P7SoxpopUbhZaBsCFdgFQ0jcOfw7FuW
         WzTLM+tMmeIh5ATjyJgIVjRBURBAvq93iF66Z84LiremltKauRZTHvWDSiBM+mVXsgwe
         UZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814889; x=1783419689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyGZakZ2i/l8Ijp+dx1ly7m47WNFgufwNDcjOd78FW4=;
        b=hSgs3rftZ2m6Y/6odjdhmDmYT7+nTcN4O4bleFUyDHqGXid63kpnurAJVNhNNpDhp0
         M0JdFFAcbZ0dDzbbwpNwKWqcTYeKpvxr2aj7zsmVsbGqzijCuRlQqigLTErPWR/HNlrl
         orldTDu3s4UbZ0FhgC9EPb8i8xcZIWkP6++yQR0kEeq5U3+JBnNNRXr2NlvfpHDZRmLo
         dvke8BOB/oMjqWS8cQH0UVUo88G5QnB0+z95fRA8joZEgG9nWUqdxmn4oSyPEo8g0NsM
         wjuFwCweYNVitRkbgEM57oWV/4IzSPDT3TbM1Pl2VQetreZMcjAsmzPM1uI8ZtSwxotW
         L2ag==
X-Forwarded-Encrypted: i=1; AFNElJ+7Rg6gJhmSALtE9MEqlj2dTYYtEe46ks3NHsg0Czi5P6sofrr63xnzgFTYx2/2XGifh6OnHTk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx99qw0N04MOEvo3luwkD1XT3IkrDLjiC4u0ZY13ZF6hJnt7oXI
	lll0Ie8sdAPPB6+WZcd06hRjPTHoIsCKENC8pCjoe1ifbAZgh3DbJkgrJmxxSjcGOyjgcc6HmAJ
	nyXyEN7I37u9T1NfpCm7kIwUXIFQg7w==
X-Received: from wmlv8.prod.google.com ([2002:a05:600c:2148:b0:493:b8dc:89a7])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b32:b0:490:d354:bd00 with SMTP id 5b1f17b1804b1-493b82b504emr46612095e9.25.1782814889210;
 Tue, 30 Jun 2026 03:21:29 -0700 (PDT)
Date: Tue, 30 Jun 2026 10:20:58 +0000
In-Reply-To: <20260630102058.3219867-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20260630102058.3219867-2-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630102058.3219867-7-sebastianene@google.com>
Subject: [PATCH v8 5/6] KVM: arm64: Ensure FFA ranges are page aligned
To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org,
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[sebastianene@google.com,3qzhdagwkaeiwifewxmeririksskpi.gsq@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,3qzhdagwkaeiwifewxmeririksskpi.gsq@flex--sebastianene.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A452F44F9D
X-Spamd-Bar: /
Message-ID-Hash: HJD6A6JFYCAORHYTGYIN34SDTSYVOUOL
X-Message-ID-Hash: HJD6A6JFYCAORHYTGYIN34SDTSYVOUOL
X-MailFrom: 3qZhDagwKAEIwifewxmeririksskpi.gsq@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HJD6A6JFYCAORHYTGYIN34SDTSYVOUOL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

From: Mostafa Saleh <smostafa@google.com>

Harden the check for the constituent memory region page alignment
to prevent over-sharing when the negotiated FFA_PAGE_SIZE size is
smaller than the system PAGE_SIZE.
At the moment we only check that the size of the range is page
aligned, and truncate the address to the page boundary which can
annotate more memory than needed as being used by the FF-A.

Fixes: 436090001776 ("KVM: arm64: Handle FFA_MEM_SHARE calls from the host")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 14aa37846059..bb01d8f83056 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -352,7 +352,7 @@ static u32 __ffa_host_share_ranges(struct ffa_mem_region_addr_range *ranges,
 		u64 sz = (u64)range->pg_cnt * FFA_PAGE_SIZE;
 		u64 pfn = hyp_phys_to_pfn(range->address);
 
-		if (!PAGE_ALIGNED(sz))
+		if (!PAGE_ALIGNED(sz | range->address))
 			break;
 
 		if (__pkvm_host_share_ffa(pfn, sz / PAGE_SIZE))
@@ -372,7 +372,7 @@ static u32 __ffa_host_unshare_ranges(struct ffa_mem_region_addr_range *ranges,
 		u64 sz = (u64)range->pg_cnt * FFA_PAGE_SIZE;
 		u64 pfn = hyp_phys_to_pfn(range->address);
 
-		if (!PAGE_ALIGNED(sz))
+		if (!PAGE_ALIGNED(sz | range->address))
 			break;
 
 		if (__pkvm_host_unshare_ffa(pfn, sz / PAGE_SIZE))
-- 
2.55.0.rc0.799.gd6f94ed593-goog

