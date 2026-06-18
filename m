Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27152CD98ED
	for <op-tee@archiver.kernel.org>; Thu, 18 Jun 2026 17:14:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4DE8C44B11
	for <op-tee@archiver.kernel.org>; Thu, 18 Jun 2026 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781802885;
	bh=aLRhpNncKn9DUj8bxhQ/4BAqsypCWpBBw8Z5q0jDYdc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=cFtSzPpZeWz8YBvOvoehX09hocHODgZYkDdfqNSrJqA+a8B+j5u8xP01eUWnSBs6d
	 1qG4zpJSjc3QJPK5kMSWXhvLFMWLOf1sanzgPlsuB4ZEj4/8mSviAhXLpDvZ5ooij5
	 t/XVvaGEweWLuN+nK3YgeujgJaanQZvwyWIr96IkLK3HEksVYy0LvA+c5X7IOrW9Mx
	 Ae80JSrf8WzE0/KlB4zgxjOgeUGratpOSy84MLhk+xV5qAQrmVE1ptomM+9CM7hW3B
	 cp7FyRzjH3K7dfTUkdhg3CI5b2I4t0jIqoq5G17PF8m31FXgLsszl8w/jaZgF8bHvQ
	 876hBabYlk/RA==
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D071743A68
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Jun 2026 17:14:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mUzWwvsh;
	dkim-atps=neutral
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-460166910e6so806796f8f.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 18 Jun 2026 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781802877; x=1782407677; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q37gll9uXRgmI+EFMA1NhDtwvLbIk280Pp5eRyLMrZs=;
        b=mUzWwvsh0DFHYQXrqlxX3tGa6QNf6Q5RP+sc5e+3SLQUueZLKwWe98aQQdJbMJf6jJ
         8raKbfSG5C641YXbarbdcMJyDDdDzJa+xWvtBMH95FVWTmQKfwpQjt/ZJTHBc04gpoc+
         0n4p1egEaI+Wr+yb9f2MnyhAIXAWeiFlfbnLrjvR6gP7d+/56oFgd67AyhsujoICK4et
         XpI/E2ignuEVMePFkLGysWsuj3htCFp38VtTMIu7L6MaqSxHOCgy95hDUnPZp+oqGZWL
         ADo7r9qvyC5Oo0iSGgzVF+sERQXH1QdZ2rX5Wrm4ULX5THNxnDPJNXjoC9B7V3CgUhqy
         cAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781802877; x=1782407677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q37gll9uXRgmI+EFMA1NhDtwvLbIk280Pp5eRyLMrZs=;
        b=A324hOl9RQBav0r1ISCusPrMwFJINMDb3GI0Cu8/ttFAI44gAsiLq2UCL2BCG50ycm
         qo5B2msyxO5CTomIayaEOuF0Tsl0Tpn5tOf98iAO7/g6dMyY3vqdw6P9icP1cw1U+ENW
         O+KSlA+GgCW9d+dfLqN+GJwqODsEtvCbrSOgxk7ubUFH1z3PBRPswpIw3HjwLcvZnE0z
         GB5CGde951PC5pBGPndDH6e9kFVFzxI/D4Q+ag6zCZ3oH7aMhrf9JocqAvE9xNsP2rcv
         pOgsjDPUxXMrdFPbnL7zVlhHLFX4E9t947Sg9KJTNjrZVR/PB4BmtktvEY9g16RK9MkV
         cw6Q==
X-Forwarded-Encrypted: i=1; AFNElJ84zP1h86mtDZ0W8yFd5SwuDLIgq4hZQUAlBOeivxUcPWB7OFIfV4ThIuwUOeLJV0SwK7rp/xI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz6Tp/uQxRpgeylWoEv0rvIQOWuSKtFP0Ji5QX1Z45k1TOZSt7+
	trcYyoVIvisCLYoCEtcfiNsjijkhGplZztbBQ4Na1ObVvshSozy6NHefMyjMlK4WDA==
X-Gm-Gg: AfdE7ck+rO7DZDULlKSKIDLywuxdZDUsaN2ePnKC2nrLzK4r0dGXjjUTc4Gw6WuTRHt
	/lB13iJoYxie50vEzBd+kTC56pxNEjIojMUJ5dJ31Bs78Bvaj020pCSL86gVhgWa3u/dIrwGYHI
	e+uxOW2pbOVaM8yXbRs2iCWOGC1kF4mpV4FlcctHSzb0ZLGpfxU6b/ic29049X4nY6ipTH4PiWX
	w9RytYg6ihbgFt0mq2eH+0O+T8spRaxml0FoflkNsrHDhZM/pqsVkarJqqajIuoEv6wo9PBR/M4
	QgKLwIqK9cFfz6ISmL3Hy6eURcYN+BnLVJxX9Vqvi26Udr1dV0aM2ucgF2jNpIs1JVS98fn8XuF
	xHISTQaA5Ad+ZGz3zuna+ZWLkvwcgP9exTrtAv6VGXsShCWbfqmYr+bY8bMpbtcjHdkJf+7wLHx
	NOjgnqyoQAYoPIE6n3oX9fLvpgpJMKa1AY9OuEVcL3fgLMkCcGFKRZLAOH
X-Received: by 2002:a05:6000:184b:b0:45e:fa38:c899 with SMTP id ffacd0b85a97d-46500a02b15mr590072f8f.4.1781802875940;
        Thu, 18 Jun 2026 10:14:35 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a0546fsm418554f8f.2.2026.06.18.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 10:14:35 -0700 (PDT)
Date: Thu, 18 Jun 2026 18:14:32 +0100
To: Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v7 7/7] KVM: arm64: Zero out the stack initialized data
 in the FFA handler
Message-ID: <ajQneFTingGFdPSb@google.com>
References: <20260617145130.3729015-1-sebastianene@google.com>
 <20260617145130.3729015-8-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617145130.3729015-8-sebastianene@google.com>
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
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.221.45:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.45:from];
	MID_RHS_MATCH_FROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D071743A68
X-Spamd-Bar: --
Message-ID-Hash: 6KIEB2XWYYEBNNP7DTUXY25Q7QEI6GQV
X-Message-ID-Hash: 6KIEB2XWYYEBNNP7DTUXY25Q7QEI6GQV
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com, Sashiko AI <sashiko-bot@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6KIEB2XWYYEBNNP7DTUXY25Q7QEI6GQV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Wed, Jun 17, 2026 at 02:51:30PM +0000, Sebastian Ene wrote:
> Don't leak hypervisor stack data when using the FFA_VERSION call.
> When the compiler doesn't support -ftrivial-auto-var-init=zero option

Even when it does, I believe this is an optional kernel option.

> we need to zero out the stack initialized variable before returning data
> to the host caller.
> 
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>

It seems most people are using "Reported-by: Sashiko <sashiko-bot@kernel.org>"

> Closes:
> https://lore.kernel.org/all/20260616160016.C62C81F000E9@smtp.kernel.org/
> Fixes: c9c012625e12 ("KVM: arm64: Trap FFA_VERSION host call in pKVM")
> Signed-off-by: Sebastian Ene <sebastianene@google.com>

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index d7c5701d0584..b321682ead04 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -883,7 +883,7 @@ static void do_ffa_part_get(struct arm_smccc_1_2_regs *res,
>  
>  bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
>  {
> -	struct arm_smccc_1_2_regs res;
> +	struct arm_smccc_1_2_regs res = {0};
>  
>  	/*
>  	 * There's no way we can tell what a non-standard SMC call might
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
> 
