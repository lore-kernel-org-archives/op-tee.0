Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FE1CD98CF
	for <op-tee@archiver.kernel.org>; Fri, 12 Jun 2026 15:20:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 69E0B444F8
	for <op-tee@archiver.kernel.org>; Fri, 12 Jun 2026 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781277642;
	bh=y4gUR7PK7kB9TGfGnWD6YdieymSk4ciySNgT4AjfdVk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gr/GY+Qhh3fDswRCjs34+icfI2BJ3fikS6zpk5/iEVy7ZUI7UNuujQNaGEsw5oEA0
	 mJc1Dcf5kSxEFbNhy620yjXrDSAxSyOSjCTNUJf723H4XDbiUM/5lf3/p7TCJUCQwM
	 CBJLc7gBGiklbA8QGL/leHNdvxua74juXy4ZPffgQkBalGfjH5cYJaz+uyoQ6Q2vCJ
	 K8cW26JcZS7+dwtpaoKWpgE9qinyAvNY6PQMNiXAJLpmk4HwNPVpx31HfaCvCgHMHY
	 BS8qL/7YqkwTbJzb/v8CxjbeymCYnUedzDmA559q49zM0Cay4SQ6vXmgXHvxbYwLXq
	 UrTbqyD0Oewyw==
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 50B5F43941
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Jun 2026 15:20:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BeTXGqco;
	dkim-atps=neutral
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso76995e9.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Jun 2026 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781277635; x=1781882435; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M73/czaUWyBGnw72mY49ubaGrHPAbyEOgxiU49yDTv4=;
        b=BeTXGqcoU7uVt9LpcDKBgc5MUbCvtDY/41QMvxZsPatde03FfXbR+e32V0+SrRttbc
         RSp2JpHLmFgbeqilZPwoKffXkKJ2YxO+p/sxd0/2BTU20QQUT8SKop8196Ou9BrC4xWQ
         x3R+W0fmM5tz7SALda1EB6raEilWrHh10gc1JpvVTJmNub5iZODKpAtXAyA3IhZ+xb8/
         GqT05YyohlKpcs3H+1A0xBzOUZCiTQPxGRTg90bybiMjIuZ666oD3d+40ggx7RjT5GKG
         tSklBTJJLjWJSKh9HdpwzYvJIFiOD76W/L3bTZ+lV2fAee9lsW/+f7J88vvwfOsWN8Fa
         82Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781277635; x=1781882435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M73/czaUWyBGnw72mY49ubaGrHPAbyEOgxiU49yDTv4=;
        b=BcT8ZaMQQZLBV9V+K3rEG5bd4daMt0W6x8XT8B7dAVrWBGjBzKT8YX69jYEC2H9xAb
         6us1WrWHNb8Q/GKLBBlgRnk1ZB85Xis0xSsN8Iu0twjEse/kXJ8MVWrN8mn5xRKrgz6Q
         hXk6yDnewDPBK0f2W0FqxlcqolL1s4CrbdtA0h0S0tfaCWkX+S40PMvuxJ1c5lsnu6id
         BtG0QtaiWC9XV8KVyF5CB58vtaxqtvfotJiEZG75Lqoi3sjtYVIVn8NkfXHzYtoEB2r8
         JfzogCWklIlzjeiMTfVuf4KtoVUziyuDXMRjd5D8g/Sqjo2edWcSYBOeYSPs0/lXYz5J
         kNzQ==
X-Gm-Message-State: AOJu0YxxlfGvbWxKDDTVf8g/G+NSAq9lKvjyY57N4D73DrKTAY+qIfzf
	x2RTQVBlbPGoQsed6odj6ZnlvXVJALtapVU+kb+rrBnRrOr3R+KwQ7PHvgtZvn/kLg==
X-Gm-Gg: Acq92OF6eHw0Q3wsJU+stYYC31jA/TTXK2PLwcgfqmGbRf4YmL/RXu+Iy2aoafqaQqC
	9o7HdySTV1Zcjn+9Q83YUKAYaxCmpenNn0I7XBE4AsP//XB7YSvcTzsfuvW4QWKKgL7u6ZBD0r0
	6LNlZHCIDqhVXirl9hvubPh1iPgfXo6e5rvMlcrax+iHjlb9pf0sw/+vrVdZWyIxGyPAPkOFU2M
	W9pnriH2L4IyMa8T/E4whuUYhvoT8uCZzBtJumNPnOPVYegZcarVFnaIqdQaNJTNVgdUZmCxu+m
	Y+Q/iVCfz2U6AbGsKzM17UQE0rUB0uCGnKX0WjjYypmPNxmrPEKvrSzFFcOeSsKvGLOYLMNGDga
	zr5/GeGTMSUEKfcoDBn4sI2nH36KEtQklz27A3ah9i3o2bkt8JG0HmT067rh2iUdA3aqsGgnM7p
	46qd42ZjcaTKcJFB0D/h8Rua2ON13/TDrgZ6vRYU0xCDuAYPsaT1TFw/FP6tzaOb09+uRTMA==
X-Received: by 2002:a05:600c:2309:b0:489:1f6a:4ac0 with SMTP id 5b1f17b1804b1-490ea51dfb4mr951915e9.0.1781277634812;
        Fri, 12 Jun 2026 08:20:34 -0700 (PDT)
Received: from google.com (143.11.148.146.bc.googleusercontent.com. [146.148.11.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c4240sm6626262f8f.27.2026.06.12.08.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 08:20:34 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:20:30 +0000
To: Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 5/6] KVM: arm64: Validate the offset to the mem access
 descriptor
Message-ID: <aiwjvihrwbInBqGn@google.com>
References: <20260527150236.1978655-1-smostafa@google.com>
 <20260527150236.1978655-6-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527150236.1978655-6-smostafa@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.49:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.49:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 50B5F43941
X-Spamd-Bar: ----
Message-ID-Hash: UPEE6L3WJHOB7HBDDLNNEXREI7E3REFT
X-Message-ID-Hash: UPEE6L3WJHOB7HBDDLNNEXREI7E3REFT
X-MailFrom: sebastianene@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, vdonnefort@google.com, sudeep.holla@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UPEE6L3WJHOB7HBDDLNNEXREI7E3REFT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

On Wed, May 27, 2026 at 03:02:35PM +0000, Mostafa Saleh wrote:
> From: Sebastian Ene <sebastianene@google.com>
> 
> Prevent the pKVM hypervisor from making assumptions that the
> endpoint memory access descriptor (EMAD) comes right after the
> FF-A memory region header.
> Prior to FF-A version 1.1 the header of the memory region
> didn't contain an offset to the endpoint memory access descriptor.
> The layout of a memory transaction looks like this from 1.1 onward:
> Type | Field name | Offset
> [ Header | ffa_mem_region  | 0
>   EMAD 1 | ffa_mem_region_attributes) | ffa_mem_region.ep_mem_offset
> ]
> Verify that the offset to the first endpoint memory access descriptor
> is within the mailbox buffer bounds.
> 
> Also, fix one hardcoded sizeof(struct ffa_mem_region_attributes) that
> should be replaced ffa_emad_size_get() for compatibility with FFA v1.0.
> 
> [@Mostafa, Add missing call to ffa_rx_release() and use fraglen
>  as the max buffer size as it is the only intialised part]
> 
> Fixes: 42fb33dde42b ("KVM: arm64: Use FF-A 1.1 with pKVM")
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index b6cf9ad82e12..a12e01883314 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -476,10 +476,10 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>  	DECLARE_REG(u32, fraglen, ctxt, 2);
>  	DECLARE_REG(u64, addr_mbz, ctxt, 3);
>  	DECLARE_REG(u32, npages_mbz, ctxt, 4);
> +	u32 offset, nr_ranges, checked_offset, em_mem_access_off;
>  	struct ffa_mem_region_attributes *ep_mem_access;
>  	struct ffa_composite_mem_region *reg;
>  	struct ffa_mem_region *buf;
> -	u32 offset, nr_ranges, checked_offset;
>  	int ret = 0;
>  
>  	if (addr_mbz || npages_mbz || fraglen > len ||
> @@ -489,7 +489,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>  	}
>  

Hi Mostafa,

>  	if (fraglen < sizeof(struct ffa_mem_region) +
> -		      sizeof(struct ffa_mem_region_attributes)) {
> +		      ffa_emad_size_get(hyp_ffa_version)) {
>  		ret = FFA_RET_INVALID_PARAMETERS;
>  		goto out;
>  	}

Here sashiko complains about a compatibility break with v1.0 even though
it is not from this change. This is because the size of sizeof(struct
ffa_mem_region) was 36 bytes in v1.0 and now it is 48.

This check can cause "perfectly valid v1.0 memory transfers to be rejected"
(from sashiko).

Other than that this looks good. I will spin a new version of this
series.

> @@ -508,8 +508,13 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>  	buf = hyp_buffers.tx;
>  	memcpy(buf, host_buffers.tx, fraglen);
>  
> -	ep_mem_access = (void *)buf +
> -			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> +	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> +	if ((u64)em_mem_access_off + ffa_emad_size_get(hyp_ffa_version) > fraglen) {
> +		ret = FFA_RET_INVALID_PARAMETERS;
> +		goto out_unlock;
> +	}
> +
> +	ep_mem_access = (void *)buf + em_mem_access_off;
>  	offset = ep_mem_access->composite_off;
>  	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
>  		ret = FFA_RET_INVALID_PARAMETERS;
> @@ -574,9 +579,9 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
>  	DECLARE_REG(u32, handle_lo, ctxt, 1);
>  	DECLARE_REG(u32, handle_hi, ctxt, 2);
>  	DECLARE_REG(u32, flags, ctxt, 3);
> +	u32 offset, len, fraglen, fragoff, em_mem_access_off;
>  	struct ffa_mem_region_attributes *ep_mem_access;
>  	struct ffa_composite_mem_region *reg;
> -	u32 offset, len, fraglen, fragoff;
>  	struct ffa_mem_region *buf;
>  	int ret = 0;
>  	u64 handle;
> @@ -599,8 +604,14 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
>  	len = res->a1;
>  	fraglen = res->a2;
>  
> -	ep_mem_access = (void *)buf +
> -			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> +	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> +	if ((u64)em_mem_access_off + ffa_emad_size_get(hyp_ffa_version) > fraglen) {
> +		ret = FFA_RET_INVALID_PARAMETERS;
> +		ffa_rx_release(res);
> +		goto out_unlock;
> +	}
> +
> +	ep_mem_access = (void *)buf + em_mem_access_off;
>  	offset = ep_mem_access->composite_off;
>  	/*
>  	 * We can trust the SPMD to get this right, but let's at least
> -- 
> 2.54.0.746.g67dd491aae-goog
>

Thanks,
Sebastian
