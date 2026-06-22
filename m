Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FB2CDB46F
	for <op-tee@archiver.kernel.org>; Mon, 22 Jun 2026 09:23:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1681143B5A
	for <op-tee@archiver.kernel.org>; Mon, 22 Jun 2026 09:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782120220;
	bh=xRGw/5WdO17oARE2tbE39dqLOEvwz63PJBHom1jLzGY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=g6ojmxYXjWPAd8kzNj22QlZlwAG+nKCfQ+RKcKgr1wnNvsC8K1grdPg2/eMZeWjmv
	 ohzAjo8ffi29wele4bEwj7xZ7zfcx/v+1jHeYlv8tikhQBMFku9yH1ANgH51KbgiWc
	 gVQYNJ17b4ilvbAmr7jBvhEjH3g2Pt5/fAqlLXYBoVkOF0PL1h42SvMJADljmj1Li+
	 TCBSIPlaOcMDjcxDanBoSLG/x6VLyZDxDjwCvLrdM7fpCGIlpVrWrSaGAtJv7n0goB
	 U7T1UlrsjvnzPqi22c/T808lrBddkGYnyiCtjMBppieBzc/et38o4ULH+3NWRZXp8Q
	 3i5YAZSA97aQQ==
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2460843941
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 09:23:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mVHMBuPa;
	dkim-atps=neutral
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-695a3842230so23981a12.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 02:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782120212; x=1782725012; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lG9c7IfmrMj5SYE5QngWHzgS5zVNj1KkYNbZ00E7vJE=;
        b=mVHMBuPaZkaP2qDdO/Oklu1aq3T+2aT3I2Ehs/tWMn8vRt1wHnU7511dQ3J0ZIRziQ
         2HdwqCE35Xp27vvvO8FjH2CtCHyQnJ8AYhd4gol/9cSRLHszJ2y4wKA6cY6siBusSoZo
         8FHlxoPHD5Sq0tJaS8UzZDHvAstfI4MSlOWcvS7cUPGg2/8N/tRyNf0mi+LjMlSxzz1O
         X2m6yZPrHsLWbcIFx04ZEVsAKmjTtAbIrHdsDWQqUlnUqG40u7jClfHbwTXrcfpGB9Sd
         DLCAisrF4xcyez84Xd0ptA6w6ne9aKpyErXmOctZkMujbpzfFeg+DfQPlJ7bJJMyQFZ+
         nPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782120212; x=1782725012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG9c7IfmrMj5SYE5QngWHzgS5zVNj1KkYNbZ00E7vJE=;
        b=SO1B9IlSP/01wj8T13Yfm1ygrfoyj44QsFQ6J69wKGRdzW0kXW9pRuaY3m0msaR3du
         92OVPGDxjOtO4sqrl4l2PklOjq5xQVwFYp9subRXLiVP51cqDj1JfyUXQRchms69p4dH
         1BclfK5u1zkYbFNnqwH7IsXdHVybJMdOShvVebNpbRSktgV1wkI58ktduWjx3YwmNEeb
         K/HUOej3uCbL5HVey595uIy3sbuado74TFGt0g3ApXenx1xAV2hNzSOSu75uy3nlMKEA
         oLp/MHPMchc3HCjJ76qbIe4QPu4u8m/64uNtWMiCfOuAQpfyx0JMcmgRO9sHcZM+knrW
         03KA==
X-Forwarded-Encrypted: i=1; AFNElJ9oAGCuP6TIJVTN4yL+D6tMcAQzWID/temgwgbsE9az80GpapwcNik7aWh2rgUUIPtx7xd/8iA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YygikQvwQ8LBW9CuoZZj2Gunoqnu/odQ3RTC65hpPIjnW+Ih1QA
	ORORPCdbucrTQxjKi/523qidK6R1oY5g0fgoIsyON/AJ4vq8YB3hmuG9U31CgdsoMw==
X-Gm-Gg: AfdE7cljwpS3XCWmzXRXkgQG7SMStg/zTX+71Y/SKs9jSD76rI9MbZ1en1I+ymnrJJv
	6zpvsd1+LJke/bA1KN/QvvyUsWgl8ERoaFsx1SMZwaL3sSaglCK54/shqKk1ZVnjGrnkLUmI44j
	cxx84YWxCMB/u4LH5FFL7MfoX7FJplZZf5He90Sn+4ew5vPbQnTUVNkp4e4EMh3GYmIkh2PdEbN
	hNDyX0EYhor2kHYFFsadIA41Es9WoVxzxn4t5om6hfcNxHoWNGYlZJQ/p3GW47oUTEXlzcDygrB
	Ex1RycuYUPFW3udKvWJHUIMAL6CBoMV2lxA9vJq5R8tmPEjsQa8TomMTpj//c1UIms49fKs+aN4
	mSk91uoSJ3oDe7w/F72u16xCpLdlJfw5DqR7XWTUrpWIfACy0fe2UIYQ0oY2QXF3u0j3VUlnUB4
	yjIGlXWSWioe1Y/iTE7xs+zTNdOVVFx5gkw6SDfxQv2ZA1HfcrXYHyNd2zcdU=
X-Received: by 2002:a05:6402:a58a:20b0:671:dad9:8caf with SMTP id 4fb4d7f45d1cf-697498db0b9mr73558a12.5.1782120211444;
        Mon, 22 Jun 2026 02:23:31 -0700 (PDT)
Received: from google.com (143.11.148.146.bc.googleusercontent.com. [146.148.11.143])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b86f480sm2949634a12.13.2026.06.22.02.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 02:23:30 -0700 (PDT)
Date: Mon, 22 Jun 2026 09:23:26 +0000
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v7 5/7] KVM: arm64: Validate the offset to the mem access
 descriptor
Message-ID: <ajj_DkqiDwiF8imZ@google.com>
References: <20260617145130.3729015-1-sebastianene@google.com>
 <20260617145130.3729015-6-sebastianene@google.com>
 <ajQjOH9Cjk1UqdT-@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQjOH9Cjk1UqdT-@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,linaro.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.54:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.54:from];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2460843941
X-Spamd-Bar: --
Message-ID-Hash: KXXVT3DV7E7SSHQL7LMGQNZXKPSNC3VH
X-Message-ID-Hash: KXXVT3DV7E7SSHQL7LMGQNZXKPSNC3VH
X-MailFrom: sebastianene@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KXXVT3DV7E7SSHQL7LMGQNZXKPSNC3VH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

On Thu, Jun 18, 2026 at 05:56:24PM +0100, Vincent Donnefort wrote:
> On Wed, Jun 17, 2026 at 02:51:28PM +0000, Sebastian Ene wrote:
> > Prevent the pKVM hypervisor from making assumptions that the
> > endpoint memory access descriptor (EMAD) comes right after the
> > FF-A memory region header.
> > Prior to FF-A version 1.1 the header of the memory region
> > didn't contain an offset to the endpoint memory access descriptor.
> > The layout of a memory transaction looks like this from 1.1 onward:
> > Type | Field name | Offset
> > [ Header | ffa_mem_region  | 0
> >   EMAD 1 | ffa_mem_region_attributes) | ffa_mem_region.ep_mem_offset
> > ]
> > Verify that the offset to the first endpoint memory access descriptor
> > is within the mailbox buffer bounds.
> > 
> > Also, fix one hardcoded sizeof(struct ffa_mem_region_attributes) that
> > should be replaced ffa_emad_size_get() for compatibility with FFA v1.0.
> > 
> > Fixes: 42fb33dde42b ("KVM: arm64: Use FF-A 1.1 with pKVM")
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 29 +++++++++++++++++++++--------
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > index 2d211661952e..1a2abd0154c6 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -476,11 +476,14 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> >  	DECLARE_REG(u32, fraglen, ctxt, 2);
> >  	DECLARE_REG(u64, addr_mbz, ctxt, 3);
> >  	DECLARE_REG(u32, npages_mbz, ctxt, 4);
> > +	u32 offset, nr_ranges, checked_offset, em_mem_access_off;
> >  	struct ffa_mem_region_attributes *ep_mem_access;
> >  	struct ffa_composite_mem_region *reg;
> >  	struct ffa_mem_region *buf;
> > -	u32 offset, nr_ranges, checked_offset;
> >  	int ret = 0;
> > +	size_t mem_region_len = !FFA_MEM_REGION_HAS_EP_MEM_OFFSET(hyp_ffa_version) ?
> > +		offsetof(struct ffa_mem_region, ep_mem_offset) :
> > +		sizeof(struct ffa_mem_region);
> >  
> >  	if (addr_mbz || npages_mbz || fraglen > len ||
> >  	    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
> > @@ -488,8 +491,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> >  		goto out;
> >  	}
> >  
> > -	if (fraglen < sizeof(struct ffa_mem_region) +
> > -		      sizeof(struct ffa_mem_region_attributes)) {
> > +	if (fraglen < mem_region_len + ffa_emad_size_get(hyp_ffa_version)) {
> 
> Can't we replace mem_region_len with ffa_mem_desc_offset()? that pretty much
> looks like the same thing.
> 

We can't because `ffa_mem_desc_offset` dereferences struct
ffa_mem_region to extract ep_mem_offset as per the latest updates. 

> 
> >  		ret = FFA_RET_INVALID_PARAMETERS;
> >  		goto out;
> >  	}
> > @@ -508,8 +510,13 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> >  	buf = hyp_buffers.tx;
> >  	memcpy(buf, host_buffers.tx, fraglen);
> >  
> > -	ep_mem_access = (void *)buf +
> > -			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> > +	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> > +	if ((u64)em_mem_access_off + ffa_emad_size_get(hyp_ffa_version) > fraglen) {
> 
> This check looks like ffa_mem_desc_offset() with count to 1.
> 
>
> > +		ret = FFA_RET_INVALID_PARAMETERS;
> > +		goto out_unlock;
> > +	}
> > +
> > +	ep_mem_access = (void *)buf + em_mem_access_off;
> >  	offset = ep_mem_access->composite_off;
> >  	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
> >  		ret = FFA_RET_INVALID_PARAMETERS;
> > @@ -574,9 +581,9 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
> >  	DECLARE_REG(u32, handle_lo, ctxt, 1);
> >  	DECLARE_REG(u32, handle_hi, ctxt, 2);
> >  	DECLARE_REG(u32, flags, ctxt, 3);
> > +	u32 offset, len, fraglen, fragoff, em_mem_access_off;
> >  	struct ffa_mem_region_attributes *ep_mem_access;
> >  	struct ffa_composite_mem_region *reg;
> > -	u32 offset, len, fraglen, fragoff;
> >  	struct ffa_mem_region *buf;
> >  	int ret = 0;
> >  	u64 handle;
> > @@ -599,8 +606,14 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
> >  	len = res->a1;
> >  	fraglen = res->a2;
> >  
> > -	ep_mem_access = (void *)buf +
> > -			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> > +	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> > +	if ((u64)em_mem_access_off + ffa_emad_size_get(hyp_ffa_version) > fraglen) {
> 
> ditto. ffa_mem_desc_offset()
> 
> > +		ret = FFA_RET_INVALID_PARAMETERS;
> > +		ffa_rx_release(res);
> > +		goto out_unlock;
> > +	}
> > +
> > +	ep_mem_access = (void *)buf + em_mem_access_off;
> >  	offset = ep_mem_access->composite_off;
> >  	/*
> >  	 * We can trust the SPMD to get this right, but let's at least
> > -- 
> > 2.54.0.1136.gdb2ca164c4-goog
> > 

Thanks,
Sebastian
