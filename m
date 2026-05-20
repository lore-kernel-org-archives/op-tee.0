Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75BECD4F54
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:50:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2D66A432A9
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 20:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779310256;
	bh=+odcoytO7t3DOoLwKe5U/Z+LXQDQFnA0EDO6/U8yfWg=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=UnlQw8H7mR96elF+GO1skHYBTpQfJTuAkhZO/WI1iYsHl4vchbL9/gK4E61mKu1b/
	 avpR2xEoyqfqdpHSbo2EFFlkowGoueA+BWH0IQVbp+XeyQWKUezIagpV/yHN5ZVpo1
	 W0mxVcESwztqXKIXQ3p+krLWollyiM0vrP1OORR7c34+sY/9MTRq5N07WPUiXGbr3q
	 TEoQm/qk6O0crNAH8RiI9lKjeeClEIF8z8i875mJTelQmZ7ZjMCrtfWrwv7ySDjz5R
	 r6JBSpavlcGQkRuboomFUT6NziD866/4i29YtpSBDLvj7dtglj0XLJvGLPsIarWwpH
	 nDleasXiQ50vw==
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 523B344D95
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 20:49:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UPi9Z3k4;
	dkim-atps=neutral
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488d3eec9bcso36833435e9.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779310195; x=1779914995; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov2SNTUzKC8oN0Fvl8Z8REa9PXSOlA6pzj2Ni/hPKe8=;
        b=UPi9Z3k4iew5EgneahT8c7XwCfVdc3jzFCmTWkFMnWPzGuD3HVKIBPd7AwmBJ9nOSs
         ZBlWKVNDkAIlFTZWM7GlCAnAdHrKZuJXtw+pwsEu6tbqMKS8jRM+QnZ8GjGcMiUAOpy7
         CBplZuCBnkjG1u4DEhGlUYvZGDHmQSUMOVvnT2oCpsA1pXSUrVk7h5Pwnz2RA3Jioq2T
         w8GRsvapsC/L3L119EvJhe0U9gg+9DBGEvUF9bBzl8CTHGkrYfiDjK1pzXro2LOBxR5+
         aa00f3mIoAOWn0y6eyHHFWU1dVHCf/SFnb4aRFjcy2EheDThnIU0RHlqwQJ2b/YEFcZ7
         uGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310195; x=1779914995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov2SNTUzKC8oN0Fvl8Z8REa9PXSOlA6pzj2Ni/hPKe8=;
        b=fNRkqQhX+TPj6W042gYWaxXhBg0j6vhIj+f112QBx5eFremgzdp6wTOV2ldg8PEGRN
         6E2qxMZ6kLaXEril8qrLo+atxzE9SnvjHPCiGwD2gkQpwl0yJdanb8p5HJbE7UVoV225
         +6kMZl6IsBYJh3spp2guOyVw2N+0Wz2hvu7sEMc76WlbzXNvn/OrSGhIdkSi/LSmfAr0
         rgvCHpio70xsWe/bVvzzpv25v4cNfP/Y08dh/gtpQT4H2qXuP7nUFvovKIa6+R6LxomQ
         Dwc3TzYU0okWFPglgEKWsxtIkIeAoB+kKYEB1QNcR/OaRYjaQJx/W++HVon0i1oqNWVe
         77gg==
X-Gm-Message-State: AOJu0YxH+r7ms2ezdxKX75TZxLNo3kHxppHo48RUOTHUeudIjnjcHEnJ
	PsimnIhICt+cJ1oz7DZW19UZYndkcDZSVYh8cKMRwDfATdRTD5kzU8LBCodcE5X5mwENN+Bwylx
	H9DMou0FTSTUT8+peaFxfnuBViuYyhJOClAGKsHvW5hUHgdmkZIdgHrVLMVbBRiUrdbMDuWTHAl
	bLnAiAvfVnfmmeROHhaF5r+OkOEDOW7yzsw6+uXflStfKv2tTOMlEBp9WQzItm
X-Received: from wmrc10.prod.google.com ([2002:a05:600c:aca:b0:485:3a2f:2f7e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b75:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-48fe6321cdamr430534835e9.21.1779310195138;
 Wed, 20 May 2026 13:49:55 -0700 (PDT)
Date: Wed, 20 May 2026 20:49:45 +0000
In-Reply-To: <20260520204948.2440882-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260520204948.2440882-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520204948.2440882-3-smostafa@google.com>
Subject: [PATCH v4 2/5] firmware: arm_ffa: Fix out-of-bound writes in ffa_setup_and_transmit()
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3cx4oaggkbkauoquvchciqqing.eqoqr-vggnkuvu.vtwuvgfhktoyctg.qti@flex--smostafa.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.74:from];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3cx4oaggkbkauoquvchciqqing.eqoqr-vggnkuvu.vtwuvgfhktoyctg.qti@flex--smostafa.bounces.google.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.74:from];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 523B344D95
X-Spamd-Bar: --
Message-ID-Hash: C2BB455SQTRYGKAKNEKL3OPRSN7KGAIN
X-Message-ID-Hash: C2BB455SQTRYGKAKNEKL3OPRSN7KGAIN
X-MailFrom: 3cx4OaggKBkAuoquvchciqqing.eqoqr-vggnkuvu.vtwuvgfhktoyctg.qti@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/C2BB455SQTRYGKAKNEKL3OPRSN7KGAIN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

Sashiko (locally) reports multiple out-of-bound issues in
ffa_setup_and_transmit:
1) Writing ep_mem_access->reserved can write out of bounds for FFA
   versions < 1.2 as ffa_emad_size_get() returns 16 bytes in that case
   while reserved has an offset of 24.
   Instead of zeroing fields, memset the struct to zero first based on
   the FFA version.

2) Make sure there is enough size to write constituents.

While at it, convert the only sizeof() in the driver that uses a
type instead of variable.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/firmware/arm_ffa/driver.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index eb2782848283..b700b2e93e72 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -697,11 +697,10 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	for (idx = 0; idx < args->nattrs; idx++) {
 		ep_mem_access = buffer +
 			ffa_mem_desc_offset(buffer, idx, drv_info->version);
+		memset(ep_mem_access, 0, ffa_emad_size_get(drv_info->version));
 		ep_mem_access->receiver = args->attrs[idx].receiver;
 		ep_mem_access->attrs = args->attrs[idx].attrs;
 		ep_mem_access->composite_off = composite_offset;
-		ep_mem_access->flag = 0;
-		ep_mem_access->reserved = 0;
 		ffa_emad_impdef_value_init(drv_info->version,
 					   ep_mem_access->impdef_val,
 					   args->attrs[idx].impdef_val);
@@ -741,7 +740,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 			constituents = buffer;
 		}
 
-		if ((void *)constituents - buffer > max_fragsize) {
+		if ((void *)constituents + sizeof(*constituents) - buffer > max_fragsize) {
 			pr_err("Memory Region Fragment > Tx Buffer size\n");
 			return -EFAULT;
 		}
@@ -750,7 +749,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		constituents->pg_cnt = args->sg->length / FFA_PAGE_SIZE;
 		constituents->reserved = 0;
 		constituents++;
-		frag_len += sizeof(struct ffa_mem_region_addr_range);
+		frag_len += sizeof(*constituents);
 	} while ((args->sg = sg_next(args->sg)));
 
 	return ffa_transmit_fragment(func_id, addr, buf_sz, frag_len,
-- 
2.54.0.669.g59709faab0-goog

