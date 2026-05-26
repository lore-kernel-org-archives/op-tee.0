Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6E1CD5BB1
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:22:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7F2BC4326C
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779808941;
	bh=g2V0AM6ILggz6CDLnm+0G6e8Ih7ixVmLsP2s6I6BhEI=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=x9GjZpveHygvu1/px8HH7ZdI5BEpyi458GQDhTFgkFWs/1fRAbY1cNCg4x6b6McCq
	 SRPS6A+OnOpjWQ8MqbiKpGi5YB06pIP1TqrJGRdHsoPQvd6H+n/W7qJXwvii8P4gki
	 WRukBSdqvsZrO7bWb68mrCyyn/KVsYhDxk72azTZ5+avqtEuBqOf3etPUwuGx//n2a
	 Iaz5IGHjxxZL/YpuPhU2rePptf4jupev01Y31XiDAOu669Fu0kzL1Dl85Qvih5WChd
	 cOirpbbA+jWI8U+Q/IU0y4NJLpUZHmlerGCsgpeOBTsO9h1EaAPFeNDEmcDDkrOKRM
	 ohUH4D8feoP1A==
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6A95044E91
	for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 15:19:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ArVse7VL;
	dkim-atps=neutral
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4411a2c034fso9815072f8f.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779808793; x=1780413593; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=85gj1ffDyGndAMiyS2A+jf4wwjz9v1ON8M3WpC1uUQ4=;
        b=ArVse7VLdbpo0Oyc9MXkriQ+gogdxilh8dnxrmk4cRn/CLPKe6nwdNMY7Ht582fu5+
         5/S1UcGkZD2unvMMQRQ3GjD9txY4Stu7DJ563QtVOXOBo/GubypqfbFQ8aew4wLPT4Hs
         b5/BesHOSrxRoIL8cYPg7VK2qyn7nME6OynHtNMuO4WoVHw4mHgjCNdNeEj9olgH1xxc
         B+8g6gen9pyiTCMSSkKzt+9yAkUqnoQyE88XiyZbKj8POLlq5hBf150prNC4KiSkVuiV
         IWetucziOvowFfpEK0BmWPxCwCmfxFMVXoP4eUP1/AtQIGJ9I+g+CvAQbYbEZoD9T3Qf
         VQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808793; x=1780413593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85gj1ffDyGndAMiyS2A+jf4wwjz9v1ON8M3WpC1uUQ4=;
        b=du2vmYeywYMF/LCIA9iiG7AiSZN0OUgzZ1KFQEHK0PKZBKC7QZAPuNldFdjVCqJQ+L
         wmQIhuib90PCLQFO9sRii9DDEuE8LXrEkkgypMgnc09lTDkzrjkkZNYf//8/7+fOm7v8
         Y2lYQmUncaxSsoAcvMgX1GcfB3KXHnHxZs2oBXMGPwexdmeXyW2/vOy1VrLd5DS21Tv/
         0fBrc2B85RL+RPcyjuUC9DULMgo1MFtOcHyBj16L8/5smlPCnJ94cS17/0aU8FoxBdSx
         TZA+Dies5GHwPBIVZcQ54UQ/xqpDfkfMhy6D6mDyMpvVJ5d/AadsTUfqFaJ1YzC749En
         pCAw==
X-Gm-Message-State: AOJu0YwVlY5mpgVAd2SBUEXbVBg4jhO9DMIm152lsjSINrL9WeLpY0E8
	4JAXvSECwKty8u1uCmlslQWnlZ7QZsGQz5ftMLg/JTNN1sKARMGjL1pQeYmBqJ+ovKfaLvnaCdu
	xoX1OE9DduvC6iFS3L+90ThyIMccR0X7kjeCJSom1c1JgkeyTRG9oonk5SZi9jwrMM6i+S1tGkV
	EWdEVgCy87/SPdPAkeGgpCRlvFryVkhdNhI/UqKHbSm4zjVbYH+GPaJl4OC590
X-Received: from wrbdq16.prod.google.com ([2002:a05:6000:cd0:b0:43f:dbbf:52fd])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2883:b0:43c:f66e:f24 with SMTP id ffacd0b85a97d-45eb38c8b80mr33942919f8f.35.1779808792997;
 Tue, 26 May 2026 08:19:52 -0700 (PDT)
Date: Tue, 26 May 2026 15:19:34 +0000
In-Reply-To: <20260526151934.3783707-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260526151934.3783707-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526151934.3783707-7-smostafa@google.com>
Subject: [PATCH v5 6/6] KVM: arm64: Ensure FFA ranges are page aligned
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3glovaggkbjspjlpqxcxdlldib.zljlm-qbbifpqp.qorpqbacfojtxob.lod@flex--smostafa.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.850];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.73:from];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3glovaggkbjspjlpqxcxdlldib.zljlm-qbbifpqp.qorpqbacfojtxob.lod@flex--smostafa.bounces.google.com];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.73:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6A95044E91
X-Spamd-Bar: --
Message-ID-Hash: P23AG36PBR2XFYIG3VX6JDMXLLV6EOZ5
X-Message-ID-Hash: P23AG36PBR2XFYIG3VX6JDMXLLV6EOZ5
X-MailFrom: 3GLoVaggKBjspjlpqXcXdlldib.Zljlm-qbbifpqp.qorpqbacfojtXob.lod@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/P23AG36PBR2XFYIG3VX6JDMXLLV6EOZ5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

At the moment we only check that the size of the range is page
aligned, and truncate the address to the page boundary.
This make an assumption that TZ will do the same.

Harden this check by also checking that the base address is aligned
and reject it otherwise.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 79de358333e4..ea39e3362efe 100644
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
2.54.0.746.g67dd491aae-goog

