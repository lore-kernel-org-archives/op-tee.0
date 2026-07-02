Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D51C43458
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:41:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C361A45029
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782988874;
	bh=Jf+lw/4DCyppm63tP7dCDq4VU5ytrIjHJpO97z4Nh8Q=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=t6bKk+g/IF+l2C0VzItjz/y/wGShK8oNaVznRn9J4GCblW9u4WL41JxwojFl6w4wz
	 bbSDTsKb0zRkXboYo2qetycoISxoO1dAlraBDqEGI0eAHLro1GnTRGtVkZprISJw9Z
	 fxuEMiwAniKwPZgF/5gErEaMGDoPDCm36nLKCrg2D04O/yaAPO2vCI5SFqAyDAwA5C
	 3mnCyxm3nLmeVR150NiezS4hXUqyDGsD30v2E9HgYjCTvJG7q5zAC74twBr4br1A7m
	 bYJIlJQBKulb+q5yvk7ncbhCG5uqA0rlGqEfkHTJmaxNNJmjPj2HdXVqg4wUXelXZ7
	 99VkyAQc5robQ==
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2D6FB44E9C
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 10:39:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nWkfkcnj;
	dkim-atps=neutral
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c07d22d503fso163283966b.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 03:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782988757; x=1783593557; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/B2rsvapQSn12m5d81J+topBC1cosRCvCMomhxQt+E=;
        b=nWkfkcnjlLbnmyuqjwg8DnAZdmgxVL1qZq0ZKdSLqkutbdglR5EuwyX3KP32eJWFvw
         8PWbQB54bbkZnd+a53o8CyTCt2JKHNs7C2+us4v2DdCJEYL3gy2Wz0H9VaOIu5WvM2IY
         BsQGpobpLpGEcsrWRK3SMCj5CLWC+hiMx4dOAPzpmYH3ma8lZSEQqJqMGWGATF1RBThk
         YxnamiWnELxyDiR1Tv/jXzuqc16auFfuDDUEchUEdzH3eRakpoMZYZGzNmWmyu/qT9KQ
         8afnCzIq8ewWvj03hrDcotp3cZaV3gELrm9pwTpewi3Xiq4pdNKNeicRYDy9z/ZP3O4H
         SO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988757; x=1783593557;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S/B2rsvapQSn12m5d81J+topBC1cosRCvCMomhxQt+E=;
        b=Mdvsxo0/v784sEvmrLnNHJitcsDVjpK9vjr9MvZrvTN5YOaMyfuycrLFY9FSbVApXZ
         j8tebf9dM+Gb6Sn4s+J+3JdzsBn4aGuacIGBfYLL54+ued+SLBmPj02/shVNUi0XBBUl
         qVnVMIm8iU0VMslZXchSCipIkuIpOxu9apiOfq0d0L0c7Vpo3GJ1TeQlBWozfvYaCe5j
         KffCghsDjwRt8ZMDdRDaV8jIukQR22Ee+XcIQTqMT8TrmvfmUG/uBEewl3h3Kb/FVABp
         MkrBuf3zCzURK5O2Mjnnf3XU9/ZhqzaYwfi8ZEUs79wZthPhA0OFxfD9MKHWk47yXJss
         VGMw==
X-Forwarded-Encrypted: i=1; AHgh+Rof+oL6vk1eCEPbHbYulvGpQgVFRR/nSLaif1PDtycyWgoNTEz1GkIYm4kNAkLrFdFJfWwZ56I=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyQ1EA8VdTkXYpmckrY6xBm8dcuM2VlpxE1vjYPaqp1B4kJVd+0
	0UTwFy3+ZdZ893btFeoxIwv9AUTOTzXws3lk1bBsbP49bOABcqCsEXmke24LBuEUJI7UxvPm7vs
	gB/txp1BqsPB6JNaqinl45ww6MOf80w==
X-Received: from ejcht18.prod.google.com ([2002:a17:907:6092:b0:c07:60f4:6d56])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6c12:b0:bd5:18e8:1ac1 with SMTP id a640c23a62f3a-c12ae3ab429mr242035966b.5.1782988756892;
 Thu, 02 Jul 2026 03:39:16 -0700 (PDT)
Date: Thu,  2 Jul 2026 10:38:42 +0000
In-Reply-To: <20260702103848.1647249-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20260702103848.1647249-1-sebastianene@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702103848.1647249-6-sebastianene@google.com>
Subject: [PATCH v9 5/6] KVM: arm64: Ensure FFA ranges are page aligned
To: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org,
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[sebastianene@google.com,31d9gagwkamu3pml34tlypyprzzrwp.nzx@flex--sebastianene.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.74:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,kernel.org,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,31d9gagwkamu3pml34tlypyprzzrwp.nzx@flex--sebastianene.bounces.google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.74:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2D6FB44E9C
X-Spamd-Bar: /
Message-ID-Hash: MGEMIDJMSSAFTDPYYRRLXWX56JIDQYMJ
X-Message-ID-Hash: MGEMIDJMSSAFTDPYYRRLXWX56JIDQYMJ
X-MailFrom: 31D9GagwKAMU3pml34tlypyprzzrwp.nzx@flex--sebastianene.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, sebastianene@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, vdonnefort@google.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MGEMIDJMSSAFTDPYYRRLXWX56JIDQYMJ/>
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
index 2e7ab7e3319d..9c96e72e522e 100644
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

