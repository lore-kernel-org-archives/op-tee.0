Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF7BCD98F2
	for <op-tee@archiver.kernel.org>; Thu, 18 Jun 2026 16:56:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 735AC44DEB
	for <op-tee@archiver.kernel.org>; Thu, 18 Jun 2026 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781801797;
	bh=UpeUIUHNDvq4wZict7iVU/9egJyKDT4wEJN5nl33azY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AEL2Iq31vUbdCI6+9Mggfaf3sAKxNK2DG1FPvGUAWf7f4uDq+U1u7R9qkJ2lCz+Kw
	 wf5LisBfQ6dJJS0al3H63MAjwcE/hKESG47+f5Cflgs6nVjofc5VHaJiIINMy1UqMS
	 +rvYFXztDcQfiq7SI9EK2d2PdaEtmuJNnsPkKUXruGYRLEFPOlXbWYKfxNqX4S0Bwo
	 hB4qgUEnq1Nve3nfSBhEMmpkPWJ7ua0AwTmOGFW1ufAzZg/G9/WOB3C089tf6rKIni
	 sFlSgaVdBPTeBIfKpjiSVgGyoQYdV2RRupzNsMOKN7O6kcsl5sxg1ZHTQ7seDM6Fr+
	 phKp1ziSJ0e5Q==
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 72B5F43A68
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Jun 2026 16:56:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GVPq45oq;
	dkim-atps=neutral
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso9079545e9.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 18 Jun 2026 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781801789; x=1782406589; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYHUL+Y9sDYt/84sbmqrw+bMmVqlzQNkmZJ6A0M/j4w=;
        b=GVPq45oq5OT6jpUYevE0sb7W1dk5RZjFU9lPkfXAvAEt4kbx00e1ReH8NG47jxFkiV
         N2n4Bnqrvr97aMeJpfhleMI3h12k6Nu2SaPDu6rcDxqPTx9cTY9aIVOPJulUXDjt3MiC
         RKeJP0II9a3Z0DxQIjoaKN8BT11Py3gc10Poy9ClHJJSqnT+Kkse5+I00WU8W1Ti1i5J
         icQgyXrWtlzW6uO4dm4ZGrdRKr7a8wz3oy71ylkYOc6ivyFdPi982Z/v5GrpYSQ9ljKy
         FZGbxhGNdTw5Esq6tb1vUYEZLgi1kVF2YLNhwFAHkMTSrBWWXGsVIuuq8q9R08bWqCcN
         dkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781801789; x=1782406589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYHUL+Y9sDYt/84sbmqrw+bMmVqlzQNkmZJ6A0M/j4w=;
        b=rWiDTv4FaKuhLVYzGcHJtnhYVnDXyZoUnwYK7DbD9wFVYO9p1Z04ftJrl72k9sjLsp
         lbRTGafU3pI6h9pZxiGDcONpBFfRhmmlMQJ0R1V5gVd1J6xbZ+4GeZBcPndw7GOJ9jGY
         G0hHjOAxf0XezFCYmb3NbBAqVTZ1DGEA8IOX64G4yn770Z3/eV8wDydLM8Vx8o6gR5zW
         2OtEzso/Yz1eknLNtPxR2z9eVHTXRGK0dJSXNlEFUUUbA/LvYy1Df9b8RJjWfWaqFPmK
         GgthTbNK+1OnOlpWDF6zlQlO6VMnI+jFzlEHAp33uwOHPYpntv5nky2PelPGg7L0Q/5L
         Ycnw==
X-Forwarded-Encrypted: i=1; AFNElJ9Pk+0NsQdyqHtDJWBmk0qdoFBXyHtD6ZE1GL3kHIRywMyjhd9ICm0txr+5ECxLrJX6tTEQAL0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxHxSZGNZi0Vsq4lE+M0CQPKa33bgaFIiiCF0NVGDA6qXg+8nn+
	Xhww2C+hm7czQDgSq5cbi0sVhv+Yk6BNsc+uiyvwtS49L9cVSyNlMaYKuJnW71phpA==
X-Gm-Gg: AfdE7clARhY+ADLSMaLS20Sm+lhn055gBFa4hDO30SPtGZwMdDzpq9TupIrEaf8Okwf
	AR/blZ5Z52hWKhGWsqjOLyeUdhDnoikK2umMtSwqtYItPR5FsPyxcIOHuRI3yPkBm0aIPskpsT/
	HFzt3Z8n3eTHnwhaeWmT+Gzlbkp149Myg/6xcQFpJ9X39uafnGp3dmMBNRmGIlBGWpRtmgSEpsF
	d2mApXnBaAcnJZLJklegTsJUKyXNbqRBrlz/rPPEEpKxNDHLqYIaf1iwJeJ54lnR8z8IpUudRUe
	3HR4b45Aw2FKjdKQQSVLuvfXMrNAzk6YbFXrJVK+Sz13mdMoyNwjFiqlnVpkdTZbcQo8hmGZI/k
	BhYURxyzjRaMumTJqHfpvUM8jJ/zEg+Qa5hk3P6lZhGK5hk75jL7Go4JlFFS+rU1HkFaDrH9C6r
	0414qEmXY1J29ygXhRXgKYfApOhqipmWO8/pJT5kssOf1zX0E8mdobdBmI
X-Received: by 2002:a05:600c:8217:b0:492:3d05:5639 with SMTP id 5b1f17b1804b1-4923f6a949dmr6700535e9.36.1781801788773;
        Thu, 18 Jun 2026 09:56:28 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650b67a33csm153604f8f.17.2026.06.18.09.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 09:56:28 -0700 (PDT)
Date: Thu, 18 Jun 2026 17:56:24 +0100
To: Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v7 5/7] KVM: arm64: Validate the offset to the mem access
 descriptor
Message-ID: <ajQjOH9Cjk1UqdT-@google.com>
References: <20260617145130.3729015-1-sebastianene@google.com>
 <20260617145130.3729015-6-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617145130.3729015-6-sebastianene@google.com>
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.42:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.42:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 72B5F43A68
X-Spamd-Bar: --
Message-ID-Hash: YUGL6Y7F3OH4CJLJDF5E3C44ZQV4Y2I4
X-Message-ID-Hash: YUGL6Y7F3OH4CJLJDF5E3C44ZQV4Y2I4
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YUGL6Y7F3OH4CJLJDF5E3C44ZQV4Y2I4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Wed, Jun 17, 2026 at 02:51:28PM +0000, Sebastian Ene wrote:
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
> Fixes: 42fb33dde42b ("KVM: arm64: Use FF-A 1.1 with pKVM")
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 2d211661952e..1a2abd0154c6 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -476,11 +476,14 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>  	DECLARE_REG(u32, fraglen, ctxt, 2);
>  	DECLARE_REG(u64, addr_mbz, ctxt, 3);
>  	DECLARE_REG(u32, npages_mbz, ctxt, 4);
> +	u32 offset, nr_ranges, checked_offset, em_mem_access_off;
>  	struct ffa_mem_region_attributes *ep_mem_access;
>  	struct ffa_composite_mem_region *reg;
>  	struct ffa_mem_region *buf;
> -	u32 offset, nr_ranges, checked_offset;
>  	int ret = 0;
> +	size_t mem_region_len = !FFA_MEM_REGION_HAS_EP_MEM_OFFSET(hyp_ffa_version) ?
> +		offsetof(struct ffa_mem_region, ep_mem_offset) :
> +		sizeof(struct ffa_mem_region);
>  
>  	if (addr_mbz || npages_mbz || fraglen > len ||
>  	    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
> @@ -488,8 +491,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>  		goto out;
>  	}
>  
> -	if (fraglen < sizeof(struct ffa_mem_region) +
> -		      sizeof(struct ffa_mem_region_attributes)) {
> +	if (fraglen < mem_region_len + ffa_emad_size_get(hyp_ffa_version)) {

Can't we replace mem_region_len with ffa_mem_desc_offset()? that pretty much
looks like the same thing.


>  		ret = FFA_RET_INVALID_PARAMETERS;
>  		goto out;
>  	}
> @@ -508,8 +510,13 @@ static void __do_ffa_mem_xfer(const u64 func_id,
>  	buf = hyp_buffers.tx;
>  	memcpy(buf, host_buffers.tx, fraglen);
>  
> -	ep_mem_access = (void *)buf +
> -			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> +	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> +	if ((u64)em_mem_access_off + ffa_emad_size_get(hyp_ffa_version) > fraglen) {

This check looks like ffa_mem_desc_offset() with count to 1.


> +		ret = FFA_RET_INVALID_PARAMETERS;
> +		goto out_unlock;
> +	}
> +
> +	ep_mem_access = (void *)buf + em_mem_access_off;
>  	offset = ep_mem_access->composite_off;
>  	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
>  		ret = FFA_RET_INVALID_PARAMETERS;
> @@ -574,9 +581,9 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
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
> @@ -599,8 +606,14 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
>  	len = res->a1;
>  	fraglen = res->a2;
>  
> -	ep_mem_access = (void *)buf +
> -			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> +	em_mem_access_off = ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
> +	if ((u64)em_mem_access_off + ffa_emad_size_get(hyp_ffa_version) > fraglen) {

ditto. ffa_mem_desc_offset()

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
> 2.54.0.1136.gdb2ca164c4-goog
> 
