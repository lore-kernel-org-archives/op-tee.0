Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46901CD4F5E
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 10:30:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 736E2444FC
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779359416;
	bh=NmD9mUNzX/y6DlpDoXIS6qMuNwv/jfPgZo+xoA3y7wo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=kxqamZ8jB3ez/ZE9b1NRrv8O9XZDWQzeOFYKD21wXCOAmyzLBTlIZTyWLRQByWiZZ
	 btulNU/msr3UEUQXsWmv5+yv8BKa9q+2LLu2m7B8BcyP1b0/+WZKrBvLjfy9Q/pXNV
	 VZdO1FVKioWAhT9I3oHVGYMFVQBbyC8mCJZCOBq37d+iGlezD/mKcUdW/aLhT0uHCp
	 v3olSt8t79RcyBiS0WIUClNGMrPR94RcJlIe7q1sk/K232+HBAwLHMdtghijovgXdg
	 2ZU2I8F7BZdLDCV/w9OBeAKXkNCVrQqs+Ef/VZTj35BCIWXI3EvhtweTbmJeSQ9shg
	 CTfxbSypJ7eaQ==
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 81465443C3
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 10:30:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PKkT8qtV;
	dkim-atps=neutral
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so4675e9.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779359408; x=1779964208; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOcR2ywmAIsHfMOA6/DbnreILk4QaSYQyzKUA6hoOMk=;
        b=PKkT8qtVWIhyimH2bUMDkfpJye4ucShxMD6Gi6RYfLo3HtwGmtqPCUbizR5cgkWGe2
         98RHZVZtnrVvcZKC9exE5uhGYiyuQmIBEBo5/AWOjeSxCOgxG1YUueNWcdHfAWXdAZmg
         QlhV12jGmLiGQEKecsC8+ZRw40kwJ7hFiH+XrcveoY1Uxz432kviqeZnt2Lki5kZrk/8
         SivcPDchxqbp9QusBRUla/9PfmfkksOF6co9sOoH+ASNpRyt92DOJFjZEd+/kQUbnDIP
         GLt3HrK7DSKs9jzh3P3HrUV4+7Rxobv5b/ByJtd2EXhjMc79SZfWbt1aFoAd93NOt2NN
         2KzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779359408; x=1779964208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOcR2ywmAIsHfMOA6/DbnreILk4QaSYQyzKUA6hoOMk=;
        b=lAhntp3mz77ufWezbiUIcU6tF/vlQz6IWKnMO1QhbB0KzZWIwCd8Y+lWrzJNAVZyDi
         skqz2XhkoifNm5woDysDJm9UEGRDwIfbJxRHl4vcUJo6Rh7TekuR6DOa3Kz/Tpd2CTmI
         NI8E3FjmDvt/dDtdKrHwHLIHwuxX6aSm0A6dYhhJxYiOq8KrTnaH4FAViHSYKx044oe9
         W66+W6wwIZpPc+Abbu4+tY+wdqrQr/Hz1zLHYrtzzG9LVk1Nz24FmGaSrpU1Z1v/390w
         Re4iBCDEgwby0CBrskxFAky2RT5wA2SQS6kC2Om4kyfx/n+jvjnkDceTs6UCsFF3amgv
         KQAw==
X-Gm-Message-State: AOJu0Ywkkk3LK2qIZ4ekdRh7rvSVvjBI5FLCGd6Hm/keoqp1R4C52xDG
	F1DcFG7gUZw/xBcKx/xdORHyWRd5HfOtevnXrGTONXWtVMVDJZ+s/PBtBaQoyh95sg==
X-Gm-Gg: Acq92OFYgIkJdwA2UsOVDJ3cW7dFaOoSh9sLxIS26K2qXDJZ/52B2sgUiwpiZBkFwkO
	sqQrMkKzfSxVrNknP8zZstpbZbj+sLh40UgM4pYdH1loxqtcEOjby584rVoyczTa3EzDTbGEF7R
	lbFcu9mEcZHWUke7RPqvel06vfQ5ltT3neRsIasRrziqXDGWr5mkW2lbVfiRF/OQiIoFM5GSTot
	WfHxTAiiGvxDfKwv76HUu65/h2ZV6AZc/aV5NfIUCalMT5j0S6ryKAYsjvKrJ6gTXp0b33N7nFn
	RYiyDhgRliPmM9QV4Eqheg/XBAbl2n9grp9UDXiAuetkMtUkm1SnxoNggf2LDMz3/Kf5rE3vU/o
	8WUJkLhxs0lObpq9I4tNFPlviZ1JDhtd40Y4L6qRXTGX0YfGar2PknyhRLaQJjcL/mreeyMO3yW
	diP+KoUgYe3pQ2zMXRkzHGsPztsGiHjxqLdOgD7eVYrF22S7pKXhzzR7b5VwpfF+GCFYNjVLdxb
	gI=
X-Received: by 2002:a05:600c:1551:b0:489:1f6a:4ac0 with SMTP id 5b1f17b1804b1-49035c64bccmr990775e9.0.1779359407929;
        Thu, 21 May 2026 03:30:07 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7cf23bsm1764718f8f.5.2026.05.21.03.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:30:07 -0700 (PDT)
Date: Thu, 21 May 2026 10:30:03 +0000
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 4/5] KVM: arm64: Fix bounds checking in
 do_ffa_mem_reclaim()
Message-ID: <ag7eq3bfBOxfaZ59@google.com>
References: <20260520204948.2440882-1-smostafa@google.com>
 <20260520204948.2440882-5-smostafa@google.com>
 <86ldddw4ht.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ldddw4ht.wl-maz@kernel.org>
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.52:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.52:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 81465443C3
X-Spamd-Bar: ---
Message-ID-Hash: ARY4KVDS752OX5EI5L26LPBXK26CEU7I
X-Message-ID-Hash: ARY4KVDS752OX5EI5L26LPBXK26CEU7I
X-MailFrom: smostafa@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ARY4KVDS752OX5EI5L26LPBXK26CEU7I/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

Hi Marc,

On Thu, May 21, 2026 at 09:28:46AM +0100, Marc Zyngier wrote:
> On Wed, 20 May 2026 21:49:47 +0100,
> Mostafa Saleh <smostafa@google.com> wrote:
> > 
> > Sashiko (locally) reports out of bound write possiblity if SPMD
> > returns an invalid data.
> > 
> > While SPMD is considered trusted, pKVM does some basic checks,
> > for offset to be less than or equal len.
> > 
> > However, that is incorrect as even if the offset is smaller than
> > len pKVM can still access out of bound memory in the next
> > ffa_host_unshare_ranges().
> > 
> > Split this check into 2:
> > 1- Check that the fixed portion of the descriptor fits.
> > 2- After getting reg, check the variable array size addr_range_cnt
> >    fits.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > index 1af722771178..e6aa2bfa63b1 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -607,7 +607,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
> >  	 * check that we end up with something that doesn't look _completely_
> >  	 * bogus.
> >  	 */
> > -	if (WARN_ON(offset > len ||
> > +	if (WARN_ON(offset + CONSTITUENTS_OFFSET(0) > len ||
> >  		    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE)) {
> 
> Do you really want to keep this a WARN_ON(), given that this results
> in a panic in most pKVM configurations?

Which kind of configuration will that check fail on?
Does that mean at the moment pKVM does out-of-bound access for
the header?

Thanks,
Mostafa

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
