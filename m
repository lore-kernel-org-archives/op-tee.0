Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B97CD98CE
	for <op-tee@archiver.kernel.org>; Fri, 12 Jun 2026 14:22:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 34CEF43809
	for <op-tee@archiver.kernel.org>; Fri, 12 Jun 2026 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781274158;
	bh=zHwPddHtZ+nAl0/u5z9/ESyAgx0+d2S2sHjzyMdqxQY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gB92lXHmGuPnUmToeSgs6NBi9OSccKPTSIaP37BQl2OUx0Dbl2WNqWojtXobI8hCa
	 /ZD5FBZgt1t6tPoAAEadCzJRn4bPhmXf0OwoIgwnxX1dfl6Q8PHEluDRmpollIB+sl
	 XUPezEr7iHcJaMRzblr2JqzwCCtCsNfqBugudAUhs9934WZ6Qi+E9akJDvvUpR6yaD
	 Y863jnChVbaNrmT5PdYkqCeeUuAvVlKrBUIutldLvTlTOQ7wKIs8/B2aj1FNKPC005
	 NP+NPZwohYbbBvr+HWBJzJxrHvU0dXaeb4FxkEQ+WcqBC/ePlCk/u+wbS6/pu7TEv9
	 LSHk8nTlddlxg==
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EE17543809
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Jun 2026 14:22:31 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OD1LagHj;
	dkim-atps=neutral
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490bd64ca95so70645e9.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Jun 2026 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781274151; x=1781878951; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0u5FTqBTXNLLGdidnrnWIaCMVX09cl5M57gIDTlUfs=;
        b=OD1LagHjvt29KRbT6wPJfIiKXpVBUdeYmrOVKrlPbMaSyEd8yT6QgzL2MpaLLLQkzZ
         WSZ8DSlnjcyF+0kAjApyxhvUDVImyDvlQ3zlRTFAtb3ORKFlpVrvjc97mMomGjk40bBu
         DItwhlxGHApGRIbo5hNOvF97uLjT5Koxu8JgapAtZOP3SC6nXdtQDxPplcdgSH/xIoYV
         Ba1GvOkBfmlQi9ear8JcjgAHwxB0svtOEagGAv6PdnYWasqT9BHCrtki+863XZoXR+bv
         YMdCTlXRLnpeouUSbf7aQR7x0k/FjEGaHNn7YSnVarBzKisXeiRir0Zf0AUEwgQn6quA
         lvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274151; x=1781878951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0u5FTqBTXNLLGdidnrnWIaCMVX09cl5M57gIDTlUfs=;
        b=ssp636C5IaNiz45+jSiZ7Y/Rj/2QLpQItrIdjEw+7YPWXqSOOhVRy1tJRiXr8X60OT
         wZyYth7P57mbDiw7zpNxh0ayb8wSkoeFmVIhUE2CjVlMt5VtAVQXODQEDMlf15qAgoAu
         IUZDtBO6j0+tyyV23fOdC2mhc2Heh54m9a/UwLQ5VM+Q4h/IAqoVsX/4JoSeTm41cGqH
         hfI/p8yvaHpHYO7MLrcBe06O2KYleQAWz1R5lEVoX404hlqc9K9c/+TQLiP2a1qExWUP
         LmHi6dZ2huxoEH8DIb8DF9/S0qk/QMPnEdyGXR+xIKHqV9Y+v/T6epFabtLApbAlUIDd
         SuAQ==
X-Gm-Message-State: AOJu0YwDMDkQFPd6Vf+Y3CSBv1Jtg+/7GD9b9VynLsHHMp+I8+z91pyK
	hFTWOa38WDrxidMPu3AD477CJ5krFfyi+IRxPm6dWqoH2PDckrD0Quf3TVvLrOOVeQ==
X-Gm-Gg: Acq92OEX0DILd11eJ3bzPpmSYImuN4yNOIScvYtVo3YVOmzVutL6Ex6GtTcje3EJjq5
	FMGWBRMVE/xG3gn4cxbXBfIoKDasZnChYcxwhwEO1O4F1doO+uZLbkZLIxfeLzrfO/b6qBo1ASj
	/SV+NgAtRSp0KTzON6gsj0BRCNSmSTUBWMFaBt9O/0e0313MqItMy/+W5m37RAyQrzGy+MZBSXT
	fSTj9PI6ILzN+e8XTCuJdZPzWIbn7ktav1WdxHDgoWsQpS2CsXasGlQV957z0BIuOIry82aFwc4
	fqihg4EMv/pOo1GmSJEk1nzf4H2jvkL9MoxzNjsRILROqoQfGDshAi6DTLcL26ybg+zQAV+jHq8
	9ZbKbuu3ckNJsSfgvEu+WxMelDBz42AsvxK+7BjHj5DP8oZ46paSsR97qHRxVMd8zzNcOweXC2x
	aDVbpPlR0e1O+a54LDvCkYxwOkKrtv+eGYhj3z3LY4z6by2YQEuqLaFY5Q9oVBMbzNzv0FEw==
X-Received: by 2002:a05:600c:6b62:b0:485:1a54:9407 with SMTP id 5b1f17b1804b1-490ea5204ffmr1201925e9.0.1781274150414;
        Fri, 12 Jun 2026 07:22:30 -0700 (PDT)
Received: from google.com (143.11.148.146.bc.googleusercontent.com. [146.148.11.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7db9c6sm71157125e9.8.2026.06.12.07.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:22:29 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:22:25 +0000
To: Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 4/6] KVM: arm64: Fix bounds checking in
 do_ffa_mem_reclaim()
Message-ID: <aiwWIRS-l-SS-wcK@google.com>
References: <20260527150236.1978655-1-smostafa@google.com>
 <20260527150236.1978655-5-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527150236.1978655-5-smostafa@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.48:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.48:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EE17543809
X-Spamd-Bar: ---
Message-ID-Hash: B2AFSU27HWDGE7G766Y3U4ZNOC7V3CBQ
X-Message-ID-Hash: B2AFSU27HWDGE7G766Y3U4ZNOC7V3CBQ
X-MailFrom: sebastianene@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, vdonnefort@google.com, sudeep.holla@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B2AFSU27HWDGE7G766Y3U4ZNOC7V3CBQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

On Wed, May 27, 2026 at 03:02:34PM +0000, Mostafa Saleh wrote:
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
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 1af722771178..b6cf9ad82e12 100644
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
> @@ -641,6 +641,11 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
>  		goto out_unlock;
>  
>  	reg = (void *)buf + offset;
> +	if (offset + CONSTITUENTS_OFFSET(reg->addr_range_cnt) > len) {
> +		ret = FFA_RET_ABORTED;
> +		goto out_unlock;
> +	}
> +

I wonder if we should do this check first and then mem_reclaim, the rational being that if the check fails
the page will be lost forever.

```
	reg = (void *)buf + offset;                                                                                                                                                                            
	if (offset + CONSTITUENTS_OFFSET(reg->addr_range_cnt) > len) {                                                                                                                                         
		ret = FFA_RET_ABORTED;                                                                                                                                                                         
		goto out_unlock;                                                                                                                                                                               
	}

	ffa_mem_reclaim(res, handle_lo, handle_hi, flags);                                                                                                                                                    
	if (res->a0 != FFA_SUCCESS)                                                                                                                                                                           
		goto out_unlock; 
```                                                                                                                                                                                                      

>  	/* If the SPMD was happy, then we should be too. */
>  	WARN_ON(ffa_host_unshare_ranges(reg->constituents,
>  					reg->addr_range_cnt));
> -- 
> 2.54.0.746.g67dd491aae-goog
>

Sebastian 
