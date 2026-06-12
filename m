Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E22CD98CF
	for <op-tee@archiver.kernel.org>; Fri, 12 Jun 2026 16:08:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C0FB644DFA
	for <op-tee@archiver.kernel.org>; Fri, 12 Jun 2026 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781280488;
	bh=+Vco8Dmdfgiaph1JQEXf8hi7Xz17MRwEMZYFFDnZWUA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=WRtXbxRbynMQGrIo1VxBvxSO/33RbrwZA/X864UGQvldCZNgcC5wmwD/v+g1Wv0Su
	 oBPf1jCfGOo0hLzk8VfiH0/pdyLe7zQj6mssGKm9MCz5XZmNAg16Zfs2qOBc9CF+WJ
	 z+rlwwYULktENxyVnFwC8uwF+A55VHBriBqwfFbSymSqOz4Y9yb8Iyla7b659KnmbQ
	 HhdW7uHTH9ioLs1By/I/On+hBVhNvoh1x8frKMWzCTyG9/ChGKtIrWPebm3nXGRKJD
	 PqDo3TU1ViAjCpkeZJBDXLbnFAvH4Gp813dCzguiJ7r7Jg/hRGMF7kQRELxC7oo8ur
	 599u6O6pZ8/lQ==
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 88BFD43716
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Jun 2026 16:08:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZXob4nTu;
	dkim-atps=neutral
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490bb5ad3bdso71275e9.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Jun 2026 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781280481; x=1781885281; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLOF6fP/rRJNscoDrzMxzXOITjjOmIqhXSUh0KfqXwE=;
        b=ZXob4nTuN00VRwWunySBf/d9MXsC+kslTdhIAZlhCejazwL8s78V8Ews3HdEcCOL/c
         GFP3CekYWCEzi5Eyi81qnc0eKS+fNMGUvRZ0lW/g0P3QjGzWQ5YiVDl3zkXpZBnH9G5E
         z+K2dkQb6MMuJowXVp18DZfJHMZHlFYGSNEnlZSf1GH8N+fUSBaniWziLsMFNjFPfuMl
         sPjsJGHtp2JjhOKbSwpwEdE1eOOTl3Rc7NnNx3N1RoB6v0INuqoBggHSpT/GbpIjqJ33
         3HPK//veoCCoZz5PpIq2tgjMFEHU06qEiuMJSKK9YAOiipF15C1PjVJlN5GKeXKAQ+t/
         1a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781280481; x=1781885281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLOF6fP/rRJNscoDrzMxzXOITjjOmIqhXSUh0KfqXwE=;
        b=ehgsGA2f+kejcAzo48+dnqoBDwnV+2eUKEWuPjCzShrqr8QZo9Qz5TqzevIJfVN2Sh
         YUoW86aPHDfdLSJx5fN4ngtlrBmV5OOjM3tnk2YU88PuK7I4Iyjrc7XxdyRGpH/XxDRX
         SW+qiN7UTbIuhcjHKLjyUleL85oojyLKcTqiq1nWnlw1nhKFsyd691xB99IkO+Mw8qSF
         MYZrHb1SAA27A4dxxw1cF85JubjOtsJX2JXkhcRJgfG4UAhs5NRq3XX7Su2adBb9VWTY
         fcG5v/z/+RQa14VMmapdbzxQn48P4+7G3rteb5YUbYi/doYN78O/3l2CLNFCkotZPswM
         g1Pg==
X-Gm-Message-State: AOJu0Yy9W8BCgy/fZZylAHij1NhQSliDN+dDR3kV3agJAe/wu4oS49Ud
	w5p0bDEZLZnzZgYeA3CYcLGw6yrZ66d8noIyGDL3dMrfzo4memjZhqRww51Ce6ueVQ==
X-Gm-Gg: Acq92OFBOAl4n3KVxFzZQNg9ZX8L1dzfw3zC+k/zlOTC8hLK7r3hj4PvgUm6/4TyHtT
	uSJanoAZXTTPqJKNesWxGmQ6Zv/1FvHzXrHWdH15y7smGjSJpcPcqxxWlNPQT4t6kwg/YaMb+fb
	7Y7c4ezNmRrl6YNTh8+/5sgqBCOu8d9Ir2dQp66p+es7ocg14D4U+Q52xJuIspNK3oFltJ+5rBm
	b9nHyXUmDN+dz6YiI2MMy8x/XOX81VLWOq1o9TTE2Day2ywlvdpbfmpUT2RyvEuuuHwVf6IjafE
	AKOHDab9DVTVK9g/b7b/j0eNii6OLjWis1IQ0YwItltqJMhb5Q90TYedNiQ9XqoepyCspPbyRZM
	n+q3O27N14vwyHIlnjYZKBoo2r18oVRxKW81ZqZ8HI9FAHCJCERopuOrs2jLBQMWV+QcKNRE+r4
	0ygGe8dWClBIINQkBVi+ezRAVL8xAqj9LKsZdCXFPfJxaoCgZsrv5Cy40YQzN+2A/QTQbpAg==
X-Received: by 2002:a05:600d:6445:20b0:490:c2b6:de6b with SMTP id 5b1f17b1804b1-490ea5da36fmr1068545e9.12.1781280481013;
        Fri, 12 Jun 2026 09:08:01 -0700 (PDT)
Received: from google.com (143.11.148.146.bc.googleusercontent.com. [146.148.11.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7389953f8f.11.2026.06.12.09.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:08:00 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:07:56 +0000
To: Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 6/6] KVM: arm64: Ensure FFA ranges are page aligned
Message-ID: <aiwu3EqWdviH5Rmo@google.com>
References: <20260527150236.1978655-1-smostafa@google.com>
 <20260527150236.1978655-7-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527150236.1978655-7-smostafa@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.44:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.44:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 88BFD43716
X-Spamd-Bar: ---
Message-ID-Hash: UBDEDCEJHPYXYMIC5ZDXHGSW42EMPOEH
X-Message-ID-Hash: UBDEDCEJHPYXYMIC5ZDXHGSW42EMPOEH
X-MailFrom: sebastianene@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, vdonnefort@google.com, sudeep.holla@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UBDEDCEJHPYXYMIC5ZDXHGSW42EMPOEH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

On Wed, May 27, 2026 at 03:02:36PM +0000, Mostafa Saleh wrote:

Hi Mostafa,

> At the moment we only check that the size of the range is page
> aligned, and truncate the address to the page boundary.
> This make an assumption that TZ will do the same.
> 
> However, it might decide to use the extra offset of the neighbour
> page at the end, which is valid under FFA if NS is using larger
> page size.
> 
> Harden this check by also checking that the base address is aligned
> and reject it otherwise.
> 
> Fixes: 436090001776 ("KVM: arm64: Handle FFA_MEM_SHARE calls from the host")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index a12e01883314..daf0e328c847 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -352,7 +352,7 @@ static u32 __ffa_host_share_ranges(struct ffa_mem_region_addr_range *ranges,
>  		u64 sz = (u64)range->pg_cnt * FFA_PAGE_SIZE;
>  		u64 pfn = hyp_phys_to_pfn(range->address);
>  
> -		if (!PAGE_ALIGNED(sz))
> +		if (!PAGE_ALIGNED(sz | range->address))
>  			break;
>  

Should we do the pfn assignment after the check ?

>  		if (__pkvm_host_share_ffa(pfn, sz / PAGE_SIZE))
> @@ -372,7 +372,7 @@ static u32 __ffa_host_unshare_ranges(struct ffa_mem_region_addr_range *ranges,
>  		u64 sz = (u64)range->pg_cnt * FFA_PAGE_SIZE;
>  		u64 pfn = hyp_phys_to_pfn(range->address);
>  
> -		if (!PAGE_ALIGNED(sz))
> +		if (!PAGE_ALIGNED(sz | range->address))
>  			break;
>  

The same here

>  		if (__pkvm_host_unshare_ffa(pfn, sz / PAGE_SIZE))
> -- 
> 2.54.0.746.g67dd491aae-goog
> 

Thanks,
Sebastian
