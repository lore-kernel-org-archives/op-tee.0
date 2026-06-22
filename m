Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D393CDB46F
	for <op-tee@archiver.kernel.org>; Mon, 22 Jun 2026 11:22:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BE4C544EDF
	for <op-tee@archiver.kernel.org>; Mon, 22 Jun 2026 11:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782127363;
	bh=70B5mhzskHceq9SpN0r29f++IYglrvBZ5GQWolH6+k0=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=pXqG7PwJgBasYsJX6XQPU0ebavI/FAXLVird+kN/L+nQ8MJHWFfiR3cg1HfHNBqqb
	 yhuGmWbklt30r4Qh2mG1DuZWvh7+VyNjQ2Luh0Ma1D2kmlLn0vrciAcuqTBb9JxymY
	 9RkYZcnIlrE0PuTbItRcVr2TGRyVGEKO4cetQlc2pKLMVukbgf6oFw506pCt6GMA8d
	 OaZfkZ1lQY7R+A71KVU+xc1cySmDsEQqTzxMrqOvfuFVXWUoDVdlL5wnRQnE/pcVud
	 kVTjFWU1eI3IRFkxo1adBiGC1fSXFb4dzH5tWIvTuCXvTy3btdgYAdHnAeUT6NBWzi
	 wxxozUPsK/uCg==
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1A77C44E9E
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 11:22:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PgnBSA0V;
	dkim-atps=neutral
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49245a7a018so87825e9.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Jun 2026 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782127356; x=1782732156; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1yY6fW7A2By32TyWMvRTUIRlB5g4qNh9tuneOqU99E=;
        b=PgnBSA0VvBE0qtHYGo5GSa8yV+6f/1FZAbw9Y9Pc+4kAyDSpfX3ieu0N1UvqGDjUt3
         El8YvC4T+2kT1aL1RzhVcxeOPD0paoDN5fXSru7UoYcmALsWWHz3UTtqs8W2SXMl7WuZ
         RzFYrTIz0/pD46QF+A8QrhOkgTDSUrmsfFIUG84/60G2KmFd62q0JsWc5B778D2rNnW3
         KtZVd5hmih1WbgPtpbMqk7CH7XxTATI13dfYFK4mvLqZB/5r3hhALYSQ2W8YZqkx7jSv
         1IM80xceROW22gpjuxCpTMzu+pL16fDGQCQURBGbYQU77Rxc9zxBMHvvYFRw6BA1UXF+
         NbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782127356; x=1782732156;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1yY6fW7A2By32TyWMvRTUIRlB5g4qNh9tuneOqU99E=;
        b=pnPGatydmXfHmki0A06d/7lcusuGEjAvZDrkGS+CsvfUEdyK3t1CNPhNQWIqoKJ26A
         PnDPQeZJpxxgws9jfCNvoXmKSm57mZXkq1GD9OzhcXFNC1TX4dYrylYfxuCzwumNaGDc
         mZv0bbdmBIzV7YvEh7vMdG0Gt/8TEekJGMGCE5yfgkejX3wpTmtTE7w+Su+BnTXTcI0n
         wnG/skbDqY4f9JoqgeZzbIDj/UrmBc17cYVo8n0VdZk6DDdHoIZfy16ygDcDmISDTtti
         qzzaWv8VNVgymYqkYuoYBD/VTT8nEG3/V7zUJdSbh/gF7uOI8xYo5KngC8x/mzEsmSxY
         mjZg==
X-Forwarded-Encrypted: i=1; AFNElJ8jm5H3v5wb65t1MeXoHeL3zZlffoXYcTQASNDVf5YFQnDL7SwCly9uIVWDFQ1khQJf25P1zT4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxGugePLnHdu4ezfe4PF8O6SAYNKkdtdB79x6osBqBi+oBYC6Gg
	lP8UrYLN2LbuNSRJDX89aYWYn0wiNQ/ugwBHzG7dUj8rnWIwkRht8WAp+t05O/rScg==
X-Gm-Gg: AfdE7cntQZ6zBfBaPNG5bHUwY2kXAQ1Yga9IOyNMzDN9k3cz29+AsdVQtn7amSulcPy
	59z7PitY6Ieq9PcJ9VF95btIYyhon/4rBbdsPWSMo0/xF4mgjOZHPZJ7LEYnDM/pORTUhTGp77H
	MCIqMq16FkKEWhp46BtAlZGNGtGCNjR1omMTu4XQd43PoCMWMqzENNA/bLIKoQcxodrS0/1qC18
	yYXKi4QQYL/trPVvN/V88FOBHgtNYpeK1FDSs5kAzBY3ajz53nTQDhJHzXuUD+MNMmkLWv/NmfZ
	/0Y6JrGwt+ynnfo/IZGhVL+xyGUgpZP12ak1J3BE5P7PhkXP5FynHfDNZd9GowGijSPvR3e432g
	Fp5DjXIMdBLxMS/6HNYNZ79u8OzKygm3YH57XBoED3IdRa94XjmQSmr4U7VQ0gr9onY4tzVXt1a
	Yo55ThjVb0rsRDKLWoBxk3sxpjZYNG9wXi7+V6bjIJpImepFEX/2IYs+Fd70PcdDsZVpyD0g==
X-Received: by 2002:a05:600c:2254:b0:48a:5618:b4d4 with SMTP id 5b1f17b1804b1-49241527581mr2615965e9.1.1782127355433;
        Mon, 22 Jun 2026 04:22:35 -0700 (PDT)
Received: from google.com (143.11.148.146.bc.googleusercontent.com. [146.148.11.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c579dfsm25252029f8f.31.2026.06.22.04.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 04:22:34 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:22:31 +0000
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v7 5/7] KVM: arm64: Validate the offset to the mem access
 descriptor
Message-ID: <ajka9wZXKlYWlYDA@google.com>
References: <20260617145130.3729015-1-sebastianene@google.com>
 <20260617145130.3729015-6-sebastianene@google.com>
 <ajQjOH9Cjk1UqdT-@google.com>
 <ajj_DkqiDwiF8imZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajj_DkqiDwiF8imZ@google.com>
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
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.52:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.52:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1A77C44E9E
X-Spamd-Bar: --
Message-ID-Hash: UOFKHZLFOEU5JVR53TDDNACXND5BVXC4
X-Message-ID-Hash: UOFKHZLFOEU5JVR53TDDNACXND5BVXC4
X-MailFrom: sebastianene@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UOFKHZLFOEU5JVR53TDDNACXND5BVXC4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

On Mon, Jun 22, 2026 at 09:23:26AM +0000, Sebastian Ene wrote:
> On Thu, Jun 18, 2026 at 05:56:24PM +0100, Vincent Donnefort wrote:
> > On Wed, Jun 17, 2026 at 02:51:28PM +0000, Sebastian Ene wrote:
> > > Prevent the pKVM hypervisor from making assumptions that the
> > > endpoint memory access descriptor (EMAD) comes right after the
> > > FF-A memory region header.
> > > Prior to FF-A version 1.1 the header of the memory region
> > > didn't contain an offset to the endpoint memory access descriptor.
> > > The layout of a memory transaction looks like this from 1.1 onward:
> > > Type | Field name | Offset
> > > [ Header | ffa_mem_region  | 0
> > >   EMAD 1 | ffa_mem_region_attributes) | ffa_mem_region.ep_mem_offset
> > > ]
> > > Verify that the offset to the first endpoint memory access descriptor
> > > is within the mailbox buffer bounds.
> > > 
> > > Also, fix one hardcoded sizeof(struct ffa_mem_region_attributes) that
> > > should be replaced ffa_emad_size_get() for compatibility with FFA v1.0.
> > > 
> > > Fixes: 42fb33dde42b ("KVM: arm64: Use FF-A 1.1 with pKVM")
> > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  arch/arm64/kvm/hyp/nvhe/ffa.c | 29 +++++++++++++++++++++--------
> > >  1 file changed, 21 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > index 2d211661952e..1a2abd0154c6 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > @@ -476,11 +476,14 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> > >  	DECLARE_REG(u32, fraglen, ctxt, 2);
> > >  	DECLARE_REG(u64, addr_mbz, ctxt, 3);
> > >  	DECLARE_REG(u32, npages_mbz, ctxt, 4);
> > > +	u32 offset, nr_ranges, checked_offset, em_mem_access_off;
> > >  	struct ffa_mem_region_attributes *ep_mem_access;
> > >  	struct ffa_composite_mem_region *reg;
> > >  	struct ffa_mem_region *buf;
> > > -	u32 offset, nr_ranges, checked_offset;
> > >  	int ret = 0;
> > > +	size_t mem_region_len = !FFA_MEM_REGION_HAS_EP_MEM_OFFSET(hyp_ffa_version) ?
> > > +		offsetof(struct ffa_mem_region, ep_mem_offset) :
> > > +		sizeof(struct ffa_mem_region);


While talking with Vincent about this change, we agreed that it would be
easier to introduce a helper that will get the size of the struct
ffa_mem_region which is different based on the ff-a version.

This would hopefully increase the readability of this. The description
of the struct ffa_mem_region can be found in (Table 5.19: Lend, donate or
share memory transaction descriptor) from DEN0077A.

I will spin a new version to address this and collect the review tags.

> > >  
> > >  	if (addr_mbz || npages_mbz || fraglen > len ||
> > >  	    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
> > > @@ -488,8 +491,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> > >  		goto out;
> > >  	}
> > >  
> > > -	if (fraglen < sizeof(struct ffa_mem_region) +
> > > -		      sizeof(struct ffa_mem_region_attributes)) {
> > > +	if (fraglen < mem_region_len + ffa_emad_size_get(hyp_ffa_version)) {
> > 
> > Can't we replace mem_region_len with ffa_mem_desc_offset()? that pretty much
> > looks like the same thing.
> > 
> 
> We can't because `ffa_mem_desc_offset` dereferences struct
> ffa_mem_region to extract ep_mem_offset as per the latest updates. 
> 
> > 
> > >  		ret = FFA_RET_INVALID_PARAMETERS;
> > >  		goto out;
> > >  	}
> > > @@ -508,8 +510,13 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> > >  	buf = hyp_buffers.tx;
> > >  	memcpy(buf, host_buffers.tx, fraglen);
> > >  
> > > -	ep_mem_access = (void *)buf +
> > > -			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> > > +	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> > > +	if ((u64)em_mem_access_off + ffa_emad_size_get(hyp_ffa_version) > fraglen) {
> > 
> > This check looks like ffa_mem_desc_offset() with count to 1.
> > 
> >
> > > +		ret = FFA_RET_INVALID_PARAMETERS;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	ep_mem_access = (void *)buf + em_mem_access_off;
> > >  	offset = ep_mem_access->composite_off;
> > >  	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
> > >  		ret = FFA_RET_INVALID_PARAMETERS;
> > > @@ -574,9 +581,9 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
> > >  	DECLARE_REG(u32, handle_lo, ctxt, 1);
> > >  	DECLARE_REG(u32, handle_hi, ctxt, 2);
> > >  	DECLARE_REG(u32, flags, ctxt, 3);
> > > +	u32 offset, len, fraglen, fragoff, em_mem_access_off;
> > >  	struct ffa_mem_region_attributes *ep_mem_access;
> > >  	struct ffa_composite_mem_region *reg;
> > > -	u32 offset, len, fraglen, fragoff;
> > >  	struct ffa_mem_region *buf;
> > >  	int ret = 0;
> > >  	u64 handle;
> > > @@ -599,8 +606,14 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
> > >  	len = res->a1;
> > >  	fraglen = res->a2;
> > >  
> > > -	ep_mem_access = (void *)buf +
> > > -			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> > > +	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> > > +	if ((u64)em_mem_access_off + ffa_emad_size_get(hyp_ffa_version) > fraglen) {
> > 
> > ditto. ffa_mem_desc_offset()
> > 
> > > +		ret = FFA_RET_INVALID_PARAMETERS;
> > > +		ffa_rx_release(res);
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	ep_mem_access = (void *)buf + em_mem_access_off;
> > >  	offset = ep_mem_access->composite_off;
> > >  	/*
> > >  	 * We can trust the SPMD to get this right, but let's at least
> > > -- 
> > > 2.54.0.1136.gdb2ca164c4-goog
> > > 
> 
> Thanks,
> Sebastian
