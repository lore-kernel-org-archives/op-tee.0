Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA77C43602
	for <op-tee@archiver.kernel.org>; Fri,  3 Jul 2026 10:35:21 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 93C6944DE8
	for <op-tee@archiver.kernel.org>; Fri,  3 Jul 2026 10:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783074920;
	bh=Vzefwy+FmvZ4/SyohLy5EyBfQ7O9LgW5bNYkr6/E3d4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=RcC8y7oL+ZcMoYceHkPF0WjKmAg60CDmhjIYbm7bWrQt2Jrfn/W0l4wQ3qcZrEpQE
	 HvpfUzQg3qUqWvOpkH1KOSYdgT6u2EyjM/pdl48FSPXt/2obSi9U2oP9uxm0R7Xw91
	 LBfjl7a1wCyppdwe4d1wufn0WOZQnNSrdjhspI6jbzlUjVuaXFss4BRXGazuZlFQdM
	 X87KFGcdUQGBlkCqUblHBnxH0tAeor4p2ZEq63cvUJkRcZ9xhUatKVmKqP02wSBFRx
	 m5HNfk7uxNWNrjF7EKMDy6yUk9y8wVSbD3RumP0ioQM23jvJzXSkxjPiyd1DChZmMo
	 UMj7xJ0f+w9Rw==
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 30DC344A19
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Jul 2026 10:35:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=E4DmRbxu;
	dkim-atps=neutral
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4759b4f0897so211595f8f.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 03 Jul 2026 03:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783074913; x=1783679713; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wp+fsHhsX4lAKb58gXPJ8tba1DU/IH/qxP9n8Ckh7NI=;
        b=E4DmRbxu17CWQ/XPmCEAsYkh/XY4JAxcDmpVEKMyvzi+R74Pr5Yz6gFCYVjCH7LIFy
         bXt+VLOW1y4dbBpRxe330tckMaTtLNVpV0BoH2gpqg0w8VR7+DygvmW/RqxoGeAU8CCN
         BRdLxwMruHNWOgGVWBzd7CNkI9SGKn4rcPdETU3z3atw1iiGbBJvbygoRxy7JKz5jI+p
         Dr6+gR8ixQ3rgFjFMCnO7I1J3jr9d/lZ1TfRmAdaG7nicBbylEXre+mu7Iu1d0EegtC+
         sBrOw7Tq+1lF8+MbE9Hpt2E1OLVD0LGXJ1oCiwSK1hNAPO7BODK6kCHecrAlDz+2E9N9
         LG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783074913; x=1783679713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wp+fsHhsX4lAKb58gXPJ8tba1DU/IH/qxP9n8Ckh7NI=;
        b=KKp+YXkBXEgcS/Vetj9Gjmec1xaEFccRvzMBBFd0NKVf4ZVcP/LPR5iDYT0a/pWipu
         DzWk4bnkGNdv/639PfXzWOVy/rwFHsurCV2G7ODuIQNy/ClZMZ4sw/HipHE21c4nQolT
         F6E7h5WhosecrNJYyxhPrLREAvfsV7yXV0/zWF1duMajQqDZkSYmxx5ySzYIHDnrMM67
         kui6CinDm/JUkbEzjJbLGjZx+/LsrWwBH+d9UkSu33tbwyLslNDgXE74CVZfZ4tO99WN
         10MbJy4ztVSZ6gQSffwM4A861RaTuPjdNUbWbSXjE9egqiRwZmkjhQZyVnzLLRTrWqpl
         8eKw==
X-Forwarded-Encrypted: i=1; AHgh+RrXg/p4u4jq/W/LiACgGyvq/ztLuqFx70UT4ygUkPRke48x5P8kR7JufzW3CpbbEw34cndlGTo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywio/YUHFEHGr2xUWJlEOSrE508Hr2xggsZV6GSXbAOTbnxEIB2
	YOMIHcFlbYQyDyYPjRP9ll1zw/JTapuIVnY5ORD1DN7DgyN+IbQiIu79jfydFso1RA==
X-Gm-Gg: AfdE7cnFxxMflZIRA4dB5Lj358VAuLFldc+oRo0BWA+jxaTCsog3qGnp3LUDtPDZ1DP
	z7ucCBDi33C31sqhwTKb3Q547QyuB3WK7k9iG0Xo8kbwijkoQLEVngFduhY6MBZrMagQCamp6/5
	+tyWyVqCOTHhMeFCm9FNZUVWkmSp2sG5BLioUhTVi4b4sKrhRHmIGg99tkfW0jjpbipq7XQfIUA
	Y2AoJwtxrwmSMzGXXl9uyT2iCUX+a8lJmS/HbBIniFvkEE1eGJwTx4aj0PZpTXMZjquGkPG3lmy
	ERHJsW5DY0FKM126s5MCL2BSkO/wEHVPqEGPOjFDFeAGISXIWSeK3uODFAh3l3y/ZVwy/pFogrt
	0Rk4Y7mWaieNmRFv/D5EgHGHwlSL490wZJ3pMF00d/EGx5EAKvRjjvFYMofVmuX+mvSTxbwpnDQ
	iL7i7lPkxZpWkI20AiukmVlqLSe5uIPn8scCPkTtZXDXTuMMtXccuQurLH7JsF3Q==
X-Received: by 2002:adf:e106:0:b0:46d:d693:88cc with SMTP id ffacd0b85a97d-477b5489f5cmr8754455f8f.47.1783074912560;
        Fri, 03 Jul 2026 03:35:12 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dd46asm18021822f8f.36.2026.07.03.03.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:35:11 -0700 (PDT)
Date: Fri, 3 Jul 2026 11:35:08 +0100
To: Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v9 4/6] KVM: arm64: Validate the offset to the mem access
 descriptor
Message-ID: <akeQXIY_7Z0v9ouR@google.com>
References: <20260702103848.1647249-1-sebastianene@google.com>
 <20260702103848.1647249-5-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702103848.1647249-5-sebastianene@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DNSWL_BLOCKED(0.00)[209.85.221.54:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.54:from];
	MID_RHS_MATCH_FROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 30DC344A19
X-Spamd-Bar: --
Message-ID-Hash: QHATVMGUNS5PLSGVFELQBMR24ACU6WM4
X-Message-ID-Hash: QHATVMGUNS5PLSGVFELQBMR24ACU6WM4
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, oupton@kernel.org, sudeep.holla@kernel.org, will@kernel.org, joey.gouly@arm.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, maz@kernel.org, mrigendra.chaubey@gmail.com, op-tee@lists.trustedfirmware.org, perlarsen@google.com, seiden@linux.ibm.com, smostafa@google.com, sumit.garg@kernel.org, suzuki.poulose@arm.com, yuzenghui@huawei.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QHATVMGUNS5PLSGVFELQBMR24ACU6WM4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Thu, Jul 02, 2026 at 10:38:41AM +0000, Sebastian Ene wrote:
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
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Sebastian Ene <sebastianene@google.com>

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 27 +++++++++++++++++++--------
>  include/linux/arm_ffa.h       |  7 +++++++
>  2 files changed, 26 insertions(+), 8 deletions(-)
> 
[...]

> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 033c630b271b..e71d83ee0aef 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -421,6 +421,13 @@ struct ffa_mem_region {
>  #define FFA_EMAD_HAS_IMPDEF_FIELD(version)	((version) >= FFA_VERSION_1_2)
>  #define FFA_MEM_REGION_HAS_EP_MEM_OFFSET(version) ((version) > FFA_VERSION_1_0)
>  
> +/* The layout changed from FFA_VERSION_1_0 and the region includes an
> + * ep_mem_offset.
> + */

nit: Coding-style.

> +#define FFA_MEM_REGION_SZ(version)		(!FFA_MEM_REGION_HAS_EP_MEM_OFFSET((version)) ?\
> +						 offsetof(struct ffa_mem_region, ep_mem_offset) :\
> +						 sizeof(struct ffa_mem_region))

nit: Could avoid the ! by just swapping the two expressions.

> +
>  static inline u32 ffa_emad_size_get(u32 ffa_version)
>  {
>  	u32 sz;
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
