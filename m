Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA33C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 09:51:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D1F4844973
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 09:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782813106;
	bh=yb90SNjFBocihj8fiYGJqdyII0fOUVjjiJzpoUx4P1E=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=CJF29fO2iNTneTs0c/GZ/7DGQvpz++qeStz6WFmcGp70GAl6oneQy88a9JQ7i70HY
	 nZ+uKiYMTtAIdQyrURNoUt7Znwf0X89rvWYqQpUxVERImrawJBvc2cZlmCe4uDT4wc
	 3WKyHdH6XnJ5EIHA6rskjdg3X1P7l8rDbAa2vh9aUIYyEBYZ9fmNw+0yhrA+iI5l36
	 szqnszb7fHKPROlc2bVKchdjijj+2Djq07STERA18k3xJomY96ow755vZ8dGQo9ZrG
	 9V730wohEz7WF1KBaJVBb0mgYhL72KlxXzTVn1QtaVhoaMkFtn3W+FtdTDF8Ir3t2u
	 YiLKYYaXuWS1Q==
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A5B8F44973
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 09:51:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=U/iONQ+N;
	dkim-atps=neutral
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b8d99342so30205e9.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782813098; x=1783417898; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RtSqH+WqtZAB5cklSCb440iNsoDcg75bAXjvEoBq+ok=;
        b=U/iONQ+NTkhkk2GY9n9stekryHBtJQFCTw1Ny+qhQa1XU03FGF+aS/IK2BLYXik13Q
         zIvqcjpk4uNCN/kkKegOMnpefnuAMwiEStA1/QL4zsEHfoj5N77LH5bB1EegZqRiOUZB
         yjI9R9pT5QoH9IOTrbj/n3p9r49dZ2LM7wTFp3LD5ZEP8Q+3DrHV6aaYR5xs27b12Icd
         20xlsbSGuORT4W2d8UqM4TLWxqhfwKhq8shEIc7BoRZt57RwN5m5TfX8IXwJAYnYXtsS
         Qsq1G0OZ70lHE4nX0HuiU35jyRBSakAEAqZCRUrySGk8jnpPoyXn4OXXvPjexhicDlY3
         2Frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813098; x=1783417898;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RtSqH+WqtZAB5cklSCb440iNsoDcg75bAXjvEoBq+ok=;
        b=k7eAI12nQLoHns7I/woiH2fAJTHF7WXS8eg3XuYovrsO++ziGgGolImlpQH9BxY1V/
         jhkjt/MamYDkeKfclLdi/94GqlFTuL0TI41uOmjmZeT2z9//VEs9lJj7V9jBilxAx+AO
         2ARshAbgC8k0LpDTHK6zeL3Ey++Y0s/qeThOIIG2I3IwlmIffLhcZQ1q193UiP9orMKj
         XNe/Dpixqag2T8NqjJxEv2WqnpG5fx4y2e1H8p4KhbH0diZWLEbUMMqFWB8MX9Y6VW59
         ykm2QjYaLd8IyGw4EBc8mCfC2p4uKMKu1UARRZcfhVbBEEq6EoP50pb9gfEUEoZdDCKC
         dQgA==
X-Forwarded-Encrypted: i=1; AFNElJ9wm2t3PEz0zD++jz8UYaOTIq56Bxuf/rg5MGX5tR1QMy9wqbjkwUOCM8vkRv0Br+dPLIAObPc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxSbikmAmhR0aN6inUXsnvEMVd1L1EZevT9ut/jbFyCCX8XnDoh
	guC3W15OUWKxcoW6KzC4t9oAi2TOv/dFK7KnaLKjnx3szuEdWQ27E5fLodNIWjkcnA==
X-Gm-Gg: AfdE7cmdjUiYKDVFl1PlhzoJNeVzgTUZ5NKDCo3Mbk8+4olWDrEL5Ee7H2qgEbkuVn9
	sIGPY9uum+D47BlJWAYC0rQWU7U3EykbTjwJ8ccBaOdfYJ6auWeB+eLY6bzPvq2zNnCIhXO7uOu
	A4UvcXafWOhfNLGgvSma3BJ0eeUIO93S/D9c+sggCGBLpuO924dDhJI592E+5MGwnXCctNLOoD3
	mn7+QG5EE6cSpa0k+RoGoQ82xuMTVd2QAo5ChEvWm32a4J9Ph5AWWmZk26GdkVrxkYRWx6YfK5M
	T8A2McOlY1D6DhLVb5pNnEhrStNw/d6YYUXwJVLmhfX4HYR8gESAvNDy0pxV0xS0DlCqSfzjEhs
	nmizmEXbyEtEN2tb5aabwvIjDxvImGvd05Bp57+7R9KenaP540grh4sJpD3qdpWr4deSX+AktMx
	+fciY/1Gs9JcIZt4DhZHh9+BEmPmA24DgAzkUn/r5HMT+v2aNki33GZXrE6VM=
X-Received: by 2002:a05:600c:58d0:b0:493:adf3:d892 with SMTP id 5b1f17b1804b1-493bd76f95emr1505e9.3.1782813096603;
        Tue, 30 Jun 2026 02:51:36 -0700 (PDT)
Received: from google.com (143.11.148.146.bc.googleusercontent.com. [146.148.11.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bb4f174esm22907135e9.2.2026.06.30.02.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:51:36 -0700 (PDT)
Date: Tue, 30 Jun 2026 09:51:30 +0000
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v7 6/7] KVM: arm64: Ensure FFA ranges are page aligned
Message-ID: <akORop8Z9Levu9Sr@google.com>
References: <20260617145130.3729015-1-sebastianene@google.com>
 <20260617145130.3729015-7-sebastianene@google.com>
 <ajQmN-UQD3uJJddJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQmN-UQD3uJJddJ@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,linaro.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,google.com,gmail.com,lists.trustedfirmware.org,linux.ibm.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.128.42:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.42:from];
	MID_RHS_MATCH_FROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A5B8F44973
X-Spamd-Bar: --
Message-ID-Hash: HOHZSKVJUWXIXK4LU3CTRNU32WUHCWF5
X-Message-ID-Hash: HOHZSKVJUWXIXK4LU3CTRNU32WUHCWF5
X-MailFrom: sebastianene@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HOHZSKVJUWXIXK4LU3CTRNU32WUHCWF5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

On Thu, Jun 18, 2026 at 06:09:11PM +0100, Vincent Donnefort wrote:
> On Wed, Jun 17, 2026 at 02:51:29PM +0000, Sebastian Ene wrote:
> > From: Mostafa Saleh <smostafa@google.com>
> > 
> > At the moment we only check that the size of the range is page
> > aligned, and truncate the address to the page boundary.
> > This make an assumption that TZ will do the same.
> > 
> > However, it might decide to use the extra offset of the neighbour
> > page at the end, which is valid under FFA if NS is using larger
> > page size.
> 

Hey Vincent,

> I failed to parse this 
> 
> But I see 
> 
> /* The base IPA of the constituent memory region, aligned to 4 kiB */ 
> 
> So it sounds fair to prevent oversharing when PAGE_SIZE > 4KiB
> 

I think the problem is when you have a mismatch between FFA_PAGE_SIZE
and the system PAGE_SIZE. We expect a fixed FFA_PAGE_SIZE of 4kb and
this is enforced by :
https://elixir.bootlin.com/linux/v7.1.2/source/arch/arm64/kvm/hyp/nvhe/ffa.c#L761

if FFA_PAGE_SIZE = 4kb and PAGE_SIZE = 16kb you can end up annotating more pages with FF-A then
needed when the range->address is unaligned.

It took me a while to understand this so I guess it is better to rephrase the commit msg.

> > 
> > Harden this check by also checking that the base address is aligned
> > and reject it otherwise.
> > 
> > Fixes: 436090001776 ("KVM: arm64: Handle FFA_MEM_SHARE calls from the host")
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> 
> Perhaps the commit description needs some improvement.
> 
> The rest looks good.
> 
> Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
> 
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > index 1a2abd0154c6..d7c5701d0584 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -352,7 +352,7 @@ static u32 __ffa_host_share_ranges(struct ffa_mem_region_addr_range *ranges,
> >  		u64 sz = (u64)range->pg_cnt * FFA_PAGE_SIZE;
> >  		u64 pfn = hyp_phys_to_pfn(range->address);
> >  
> > -		if (!PAGE_ALIGNED(sz))
> > +		if (!PAGE_ALIGNED(sz | range->address))
> >  			break;
> >  
> >  		if (__pkvm_host_share_ffa(pfn, sz / PAGE_SIZE))
> > @@ -372,7 +372,7 @@ static u32 __ffa_host_unshare_ranges(struct ffa_mem_region_addr_range *ranges,
> >  		u64 sz = (u64)range->pg_cnt * FFA_PAGE_SIZE;
> >  		u64 pfn = hyp_phys_to_pfn(range->address);
> >  
> > -		if (!PAGE_ALIGNED(sz))
> > +		if (!PAGE_ALIGNED(sz | range->address))
> >  			break;
> >  
> >  		if (__pkvm_host_unshare_ffa(pfn, sz / PAGE_SIZE))
> > -- 
> > 2.54.0.1136.gdb2ca164c4-goog
> > 

Thanks,
Sebastian
