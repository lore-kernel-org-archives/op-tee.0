Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65984CD5BD5
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:05:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BA8C144E2F
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779894323;
	bh=SP4Kec8y+oWOlOQeZ//P8sSlKwGT5+/gmSM055b4H6I=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=SWjlTiIVgSsKIs9DmUAccJ/BnAv277qzjMTdT07s/oqTu0GhqEyUHfuLJQmE0OFiD
	 ANIa+wtb08Rn2rNkfhrNwvQOAKgMO+pYy7/YX6GBvi5DMkMCEebZOaWVFEaJ3gsinN
	 eUTXhJkVGel4NkTTFlm+BTZzi6z3g/qYDHtjvBsWNNfs58Y3p/hV06Qb145z3aYfs0
	 SkgvlPT4vaVos7TTcfYse8n6GdZFaJIaS+5ZAoZ1vRjTltonTRXLm8iJZ+cuV8n9v2
	 /mdYXCUjR7vqEq4Tw+pDIWtPZcZr7xDROfJKICXE98l1W+uUq1XBC0PjlOBPYBtYdw
	 f4PO0hcGbWXOw==
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3B676443EB
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 15:02:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V+5DGhOR;
	dkim-atps=neutral
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-67bca868649so9465022a12.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779894169; x=1780498969; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwo4Qh0di/1vFA0Eu7i+PSEhw4tHDX1V0gCvzn+6kjI=;
        b=V+5DGhORQJ8olfDBRfvpxgPk4dcPz/fDC7H0Jle7l8y1jIa92u3xR6LwsclWMAIkGh
         LHMaaqBB1lH8l2uv9k9O2hBaRGHdiyh1jrRQjbBfb4VBSEEEwy2/IL9eyg7a5+E1qWVW
         Y4s4zvgf9wNVj2uwLlKmkY0EJqVBQFbA7M3cF5JzPSp04EAewmX8rNgLwWuTPWFuiBtB
         eX/AiDxMvGVjl5+mN2MuK5FBxI/XUgPslJEMkXHBq4lPtM8WB8rqd/vb2/X+kKlTL4T3
         daabQH5TPiuZtH7wzPQWiS5EorbYaRd4Zl+eGvAeKX76XC1ZR1CgO8auQyMJTorqUOVT
         drrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894169; x=1780498969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwo4Qh0di/1vFA0Eu7i+PSEhw4tHDX1V0gCvzn+6kjI=;
        b=i/Z4AqlpHi1NPKGuxoeLoM6h/7hRxhhVp856lO9Xp3tcddaSBYKrUEVa5nfAlqO9SD
         izxeW2O8lMjEnRr5bBVnmsFvqGMh33uBDJUSfVvo3hB/OqsSRmx5BmMLwXhe65BIv1ow
         lkgnr7wSDYqb8b736IjVpGnpfyLAW+r8pWT/sgVHlXDITgogm7Ku+TzPWqAX5yWjmT2w
         cK+eX5pdO8IqprF5/tIb+h+GtOIzEJEeEEtBKpdxZX5/CG70DygiyumiFBl0t9srKZ8T
         Ob9Yj5Y8d4A6bmaOfAk84ZEYjFyxaA4ad8WyQAUClOZB+B8cckWvJB0sCbAJ/ThS8W1t
         UjDQ==
X-Gm-Message-State: AOJu0YzradngrJC1w3N9Ye+aG3xX4L762ogE9TnLiVtp3xfGGnqbkh0+
	MR3JoxEiTxPou4l2Ou8Sop5Fw1bz95NJIWJLeHmyuw+aXw7MhQVBOd+ngtGoU578pzSNdREvHWn
	97m3L1+aIAbxRGqQg/FfwmKqbt6wbk1oZUxWhd++Knx93rJc/W0ZVga9StlWIKcAjyv4PwlBc8d
	f1FdNMUiXJzB0QRMyxSde6TmQFx9JV5R7Z4hozhrJKfGIpytNoE3z4e38PIBrA
X-Received: from edyd3.prod.google.com ([2002:a05:6402:783:b0:688:c574:279d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a51b:20b0:689:6c2e:6cce with SMTP id 4fb4d7f45d1cf-6896c2e6e11mr5575010a12.2.1779894167979;
 Wed, 27 May 2026 08:02:47 -0700 (PDT)
Date: Wed, 27 May 2026 15:02:36 +0000
In-Reply-To: <20260527150236.1978655-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260527150236.1978655-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260527150236.1978655-7-smostafa@google.com>
Subject: [PATCH v6 6/6] KVM: arm64: Ensure FFA ranges are page aligned
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[smostafa@google.com,3lwcxaggkblokegkl2728gg8d6.4gegh-l66daklk.ljmkl657ajeo2j6.gj8@flex--smostafa.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[3lwcxaggkblokegkl2728gg8d6.4gegh-l66daklk.ljmkl657ajeo2j6.gj8@flex--smostafa.bounces.google.com:server fail];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3lwcxaggkblokegkl2728gg8d6.4gegh-l66daklk.ljmkl657ajeo2j6.gj8@flex--smostafa.bounces.google.com];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.74:from];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.74:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3B676443EB
X-Spamd-Bar: --
Message-ID-Hash: 2ME3YCWE4MM2GAPA4ALAV4FWM4ZK2T64
X-Message-ID-Hash: 2ME3YCWE4MM2GAPA4ALAV4FWM4ZK2T64
X-MailFrom: 3lwcXaggKBloKEGKL2728GG8D6.4GEGH-L66DAKLK.LJMKL657AJEO2J6.GJ8@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2ME3YCWE4MM2GAPA4ALAV4FWM4ZK2T64/>
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

However, it might decide to use the extra offset of the neighbour
page at the end, which is valid under FFA if NS is using larger
page size.

Harden this check by also checking that the base address is aligned
and reject it otherwise.

Fixes: 436090001776 ("KVM: arm64: Handle FFA_MEM_SHARE calls from the host")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index a12e01883314..daf0e328c847 100644
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

