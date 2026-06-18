Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AACCD98ED
	for <op-tee@archiver.kernel.org>; Thu, 18 Jun 2026 16:19:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C2E5644F4B
	for <op-tee@archiver.kernel.org>; Thu, 18 Jun 2026 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781799572;
	bh=uzmUSZKJNxpvsYM+nwXF0RdLyej6el26bxG8gdr9KNc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XmpRkf5oZzLLIYYOOFrXLGWRVT1Rxp5XnpSg+Ug1Yr9OiSZhgGvYWJXV7cL90l4jR
	 bodIBN+kXivR6bSHmN7/hDM17N8gOVknesmeeiZoxrUuM6gfhVcIAQRPO/NNv2FiP5
	 oWxx/R4KymsMGDfMU5nrc4PEplcWNJkFqaGFPoC9ZWVZND1sAIUHuD9hElaXl0DOP6
	 5RUvwt/xJ/2Ufn3MIm9+IyLumx+Pv5ZDrf6wgvO3dZtrOpBWWAn7aWTbyuZohGWTHU
	 Ih1AtM4HTZKHBu7AYat6UznM/Umjsvsgh8x+JOb8bXYVUMN8/3PremPlPEvdaSqmh3
	 wkRq/ecawiWYA==
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0E86B43865
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Jun 2026 16:19:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HRrgLVdx;
	dkim-atps=neutral
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4645995069bso574717f8f.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 18 Jun 2026 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781799566; x=1782404366; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MNzaKBiFWGgNDTUfrZ2uI/mAEuS8g827vmh39Qo+Zo=;
        b=HRrgLVdxgKAkgPPVS3hecW5OtkxqkMl422Btvk48gVcccJX/BL+uBquWMq63Fa2ODT
         vEVuy4DhYxwGVAfkJcDPxk22w+725uzvzWBaz6zaa1RiDipI2Bgrsig8fdTrh9+x1tlD
         Xf+xoWfE2EfxaOr7chUCSC4yb6NDF6LD5Xnkg1eGUilaHfQgBS4e+kEvQDHMudAEQH0Y
         oZdPINqnjWUQLsL64SY1d5M373ILF+efs3t3eNRdkl3xyotmTw7X3zAAIrJsPkdubu+E
         Et7CGh/knYOxKMjwCeGJolxTFVmEbg9xLqB2Qnl7pzP9uv/MuNctOsKhmJseq7abigJz
         Ti/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781799566; x=1782404366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MNzaKBiFWGgNDTUfrZ2uI/mAEuS8g827vmh39Qo+Zo=;
        b=ACQrRQCEMXb9D0DYfenTmJYyiLcAeVg0TILHI+ST5WeGgsIi06OnHwauNplMY4gj0f
         dvLTQGM7ddeT/pCPplBUarRO8tENijLaVvq8/BBCQAp2OBmimPGBwcMmKKREwo9GECRX
         Eb0lldvkqXuR4u4rVVmFqrRN3WlIiXW7deR0TTKfOKSNTo7cP2bNiasA6Kk7feT0cZ2N
         VqgOigOic1vMVhuW3pLEmlL8GbSKLxNaXO2qWNht8AgOXleOVlq8i7Ecgp5N5hxT/wNS
         qxqoTmYzNN9G+hJQjfapD6kkkyeHOGv0AXO8Kq70/YN/sfniI4GdKoUhC7kE+g6Qj/Je
         77uQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aAan0cLsKFhfzlJlImAKZkO0x0cB/qOxvMMplFanMQ3X2MYJtFLznzgrIR8Mhrto7mUcroOQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzGw1ZP4GHabNIau/IW32SkhQz/iHDDQoK/2h9hIkGg37Lc0UBT
	3clq4GEYcWkW7TL2PPWMAtvLoQ/9kTM9CEqEBQoWIka29OE5jGRAMtMsKTbMDqFTjg==
X-Gm-Gg: AfdE7cmaZcwwMbFaRg+tQpmNLQBwFUazUa/7GRRLe23/A1gKn/DiCwo+ftlKpmCgcB/
	NIJ5HDe18iOzNxw3JLC59u9Nco5kYL02TJPsFfw7udE9ICwclU2MvGDK1j/1fC38JLcjKPgj0Br
	uoy/y7wYpN8y8TEOVACqJyAomFPAk7q6UqNkdPcSa/Cwc/aGsjjHnQCYPhqur3A7TvDrWSjNgAJ
	O/SJyVHUmmFJrKQgi6no++hV2dJRueZxSny4J+5/xfJspYlMTLelUd2Q5AsyoLrd0Kdm9iEk3UG
	VXiLpYlewgqWyGlfpq+sVglE8TfFboNLejtnn8GWDrHNkAgOyqUqH1Ciq8mMxdRPIA+RBtSO/pN
	ihNHZxiAhUofWkRK40UZHiVdomx4RE7iv7bm0dtNk7TUUeoB4Eq/6FCtJYSEWKS1mfLw4u++sgq
	LFWHaVl02vJaHx4qW7aniF0HW1/yMcaenmI4MQQ9D6+TvPo1PfsxFd+rEX
X-Received: by 2002:a05:6000:2384:b0:464:1462:2286 with SMTP id ffacd0b85a97d-4650052fe2amr287936f8f.16.1781799565346;
        Thu, 18 Jun 2026 09:19:25 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46289c3b3a3sm16235705f8f.30.2026.06.18.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 09:19:24 -0700 (PDT)
Date: Thu, 18 Jun 2026 17:19:20 +0100
To: Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v7 4/7] KVM: arm64: Fix bounds checking in
 do_ffa_mem_reclaim()
Message-ID: <ajQaiM7pIXzzl_vA@google.com>
References: <20260617145130.3729015-1-sebastianene@google.com>
 <20260617145130.3729015-5-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617145130.3729015-5-sebastianene@google.com>
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
	ARC_NA(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[104.155.91.135:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.44:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.44:from];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0E86B43865
X-Spamd-Bar: --
Message-ID-Hash: GUHBAW552SUBOLZLBAMEAZSFTIXYVBT4
X-Message-ID-Hash: GUHBAW552SUBOLZLBAMEAZSFTIXYVBT4
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GUHBAW552SUBOLZLBAMEAZSFTIXYVBT4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Wed, Jun 17, 2026 at 02:51:27PM +0000, Sebastian Ene wrote:
> From: Mostafa Saleh <smostafa@google.com>
> 
> Sashiko (locally) reports out of bound write possiblity if SPMD
> returns an invalid data.
> 
> While SPMD is considered trusted, pKVM does some basic checks,
> for offset to be less than or equal len.
> 
> However, that is incorrect as even if the offset is smaller than
> len pKVM can still access out of bound memory in the next
> ffa_host_unshare_ranges().
> 
> Split this check into 2:
> 1- Check that the fixed portion of the descriptor fits.
> 2- After getting reg, check the variable array size addr_range_cnt
>    fits.
> 
> Also, drop the WARN_ONs as that will panic the kernel and in the
> next checks there are no WARNs, so that makes it consistent.
> 
> Fixes: 0a9f15fd5674 ("KVM: arm64: pkvm: Add support for fragmented FF-A descriptors")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Sebastian Ene <sebastianene@google.com>

FTR, I believe the comment about composite_off in include/linux/arm_ffa.h is
incorrect. It is an offset to a ffa_composite_mem_region (not a
ffa_mem_region_addr_range)

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 1af722771178..2d211661952e 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -607,8 +607,8 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
>  	 * check that we end up with something that doesn't look _completely_
>  	 * bogus.
>  	 */
> -	if (WARN_ON(offset > len ||
> -		    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE)) {
> +	if (offset + CONSTITUENTS_OFFSET(0) > len ||
> +	    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
>  		ret = FFA_RET_ABORTED;
>  		ffa_rx_release(res);
>  		goto out_unlock;
> @@ -636,11 +636,17 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
>  		ffa_rx_release(res);
>  	}
>  
> +	reg = (void *)buf + offset;
> +	if (offset + CONSTITUENTS_OFFSET(reg->addr_range_cnt) > len) {
> +		ret = FFA_RET_ABORTED;
> +		ffa_rx_release(res);
> +		goto out_unlock;
> +	}
> +
>  	ffa_mem_reclaim(res, handle_lo, handle_hi, flags);
>  	if (res->a0 != FFA_SUCCESS)
>  		goto out_unlock;
>  
> -	reg = (void *)buf + offset;
>  	/* If the SPMD was happy, then we should be too. */
>  	WARN_ON(ffa_host_unshare_ranges(reg->constituents,
>  					reg->addr_range_cnt));
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
> 
