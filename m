Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600DECD98ED
	for <op-tee@archiver.kernel.org>; Thu, 18 Jun 2026 17:09:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 83CC244A3A
	for <op-tee@archiver.kernel.org>; Thu, 18 Jun 2026 17:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781802565;
	bh=/mCzhgbQYuE891O0eWLlpWbYinEKlouXuNO+3ntuMGQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XN87iLlVOVbgOT4A9cd91Oaq3FniiKizN5q1+MJv9t6syi3aWrtyNC+8jZ/pAlD7h
	 IEQopqOR88N5Icyu6HvxeSydSgMNxzztwU6IbxHiTZumZd13HGZMCJV38D8kJyTgSH
	 HYSjs/IojM2wvHNDLhGDqNeTeDIqocHnbpBytp+rpN1j6Ow0Qa9N7yZxPFoJH69eaa
	 017jF7/KDtcM+jezFQyPaBGiKap9HSTF1zOIbYQe4RI/DCdXf/sO8zSRFNQtIwPefX
	 9lzkgHVGs6iNVbCzxXpzpdwroS8tw97fQs7Gwja2y8Sp0tlL47MBfgWKxqCz2U1Yas
	 TKAo0RAZZKu2Q==
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 44B2D43941
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Jun 2026 17:09:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=R0cuz7sW;
	dkim-atps=neutral
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so17844015e9.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 18 Jun 2026 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781802558; x=1782407358; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QdkuOGLUlQ7bxWy9OnUbmcuGQ3e2VCJK+CUYR+keUTk=;
        b=R0cuz7sWCKjpCQZqRzIdUrbtD2NzJzjtcJfy++BYQ6BMy2E3UNAeVcP1ubY6m7GNwK
         e5ONJ8MlC8+kuH6SSZ1bifWm6invJBQ7OmKzIdY2awL82J+yvVahvpiQeyrskAt41m0v
         53sRnlT4txsW72xmFBwNkBCmapBhdbJy+rpAEX+X9NY+pQrSpPAJ+uUySDBEglu0kw+F
         gZA6npBJ/7U8L/Mh+Sd6KWsh9YZY+CGmFWiIQeEqvSqnHeR73ijSMvdayYR73GuE+2c5
         j8mUwIWYdYEziDHA4q8lkfz6HWC8wvcrPe79bpLJLYqhTf/MG/TTtPTWK3GDS2MWZ4ax
         ekww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781802558; x=1782407358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdkuOGLUlQ7bxWy9OnUbmcuGQ3e2VCJK+CUYR+keUTk=;
        b=hY1opLqiPO6slEKonsUQoItW7JOv05TtMHVv97rESsjRJhSCGCVGKeCifAxR/dhRdZ
         AtRyA71N0DlvAeotcuu8RYRFE9sx7mc1ZZXTvzJVaGAb8zYivDK+F5y31zTkgNnSsfn6
         5NoqTHVGtGdcjM2mPFPgdeKU7/u5Q9m2jyJt34+rcxOk8ZFz+YECnut6dtuf6oqICQt8
         BoHT75LLgq7kLn5jZLjeeYpOKpGGD4+z8+Eb79o3/8A7EdcZNgX7kowkYEcbNhajeZWy
         nP8l/Ct+t9e1Bra/ILCMGV/hSC+8fkYu3BbObCbmTPIEiFtceJ+wWnl4sgNAJmO5ik6Z
         OCZA==
X-Forwarded-Encrypted: i=1; AFNElJ8P8+VHHdZLglXuwAjEf5lQ/FYaIZ20Bd7VAp6w8iDx+lJppYgeRbFjOSyLJCcRT1/tLYANMt4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx0ZzQPnXfl9F0zLl9GNihesYUICJKNPxOcUVwMjZgbJ7XmqENL
	w8B9MpkQWKwvsi41qZgaL1NWWoECGS5dUrO2QBAbvCRh2TLlosO+2/dQnQVjwbPlVw==
X-Gm-Gg: AfdE7clXLHdq/1RBcPQWE0tmq/AQ4p007D3TX4o0KdFW8aTKjvxMcrh06bIcB2oAP4Z
	Jh9BRygR98Tv6JMf7Hpdf+S9GcZGSSWb2MIawY619fGL/TSidrNhTkNKc1V9QRTDOKb3+UjHttu
	euCnKR4GfmanTjNvK+xkdy7DBCvKVuOcTMxhipnWkFGPAJAJZHXdB1Ts9ZTmOdk57eQDdaY7G7e
	roPF89U3sZYICbBp/OGugg+ym+t5B9LfGDrm7PB0Fs5EGMpGQ7cX8uOTk1Vn8mTMXIAD569p3K7
	A10NNwNo6DgNhAJ1oPy3EzCaQ4K+GMeC6X+9h4Piueyu8sn/KwncFIF8Q9b1+TUlmA96Jn6Ju65
	dJJOD9sY4T6a/7BPAyPcgDDZ9mF+HSlex0d/+pzbB6NpgDGbFDRto2GzVWuDKWIkXkClIhd/It6
	BBDQD1IuzG0lFxu/LasI6RCej31mz1pcDrEkQsUab6LwTjoEBXc4ovbKSl
X-Received: by 2002:a05:600c:4ec6:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-492381864b5mr67892175e9.13.1781802557213;
        Thu, 18 Jun 2026 10:09:17 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a712sm1949215e9.13.2026.06.18.10.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 10:09:15 -0700 (PDT)
Date: Thu, 18 Jun 2026 18:09:11 +0100
To: Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v7 6/7] KVM: arm64: Ensure FFA ranges are page aligned
Message-ID: <ajQmN-UQD3uJJddJ@google.com>
References: <20260617145130.3729015-1-sebastianene@google.com>
 <20260617145130.3729015-7-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617145130.3729015-7-sebastianene@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.41:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.41:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 44B2D43941
X-Spamd-Bar: --
Message-ID-Hash: 3DKVKAZ53V4H5LVHGJJEPIRIJHXXSZM7
X-Message-ID-Hash: 3DKVKAZ53V4H5LVHGJJEPIRIJHXXSZM7
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3DKVKAZ53V4H5LVHGJJEPIRIJHXXSZM7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Wed, Jun 17, 2026 at 02:51:29PM +0000, Sebastian Ene wrote:
> From: Mostafa Saleh <smostafa@google.com>
> 
> At the moment we only check that the size of the range is page
> aligned, and truncate the address to the page boundary.
> This make an assumption that TZ will do the same.
> 
> However, it might decide to use the extra offset of the neighbour
> page at the end, which is valid under FFA if NS is using larger
> page size.

I failed to parse this 

But I see 

/* The base IPA of the constituent memory region, aligned to 4 kiB */ 

So it sounds fair to prevent oversharing when PAGE_SIZE > 4KiB

> 
> Harden this check by also checking that the base address is aligned
> and reject it otherwise.
> 
> Fixes: 436090001776 ("KVM: arm64: Handle FFA_MEM_SHARE calls from the host")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Sebastian Ene <sebastianene@google.com>

Perhaps the commit description needs some improvement.

The rest looks good.

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 1a2abd0154c6..d7c5701d0584 100644
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
>  		if (__pkvm_host_share_ffa(pfn, sz / PAGE_SIZE))
> @@ -372,7 +372,7 @@ static u32 __ffa_host_unshare_ranges(struct ffa_mem_region_addr_range *ranges,
>  		u64 sz = (u64)range->pg_cnt * FFA_PAGE_SIZE;
>  		u64 pfn = hyp_phys_to_pfn(range->address);
>  
> -		if (!PAGE_ALIGNED(sz))
> +		if (!PAGE_ALIGNED(sz | range->address))
>  			break;
>  
>  		if (__pkvm_host_unshare_ffa(pfn, sz / PAGE_SIZE))
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
> 
