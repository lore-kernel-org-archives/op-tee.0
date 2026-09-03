Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4426DC624DA
	for <op-tee@archiver.kernel.org>; Thu,  3 Sep 2026 10:10:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 69975452C7
	for <op-tee@archiver.kernel.org>; Thu,  3 Sep 2026 10:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788430248;
	bh=9ctY17ROWC1UecrpN6Iri7rIFXCRd3ly8uwOYRSqsgs=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=X7YeuDJupWPKtDlJFdL3vuDrel081V4Y07OVXtLiU1BGqH62IfWUbm6Q39zDiUmyp
	 9S3cd20EFOFPIrRwNwY+zCZ76kY2h2tkhXEcDpMIhbGHxUDwhA2P04PkwhYzZHCzUh
	 TcxW/WlRjeFkeZewSq2WJPjTU/1qff5/MZOtHH1p8K037FK03SUOXugCGvhnU3ITCH
	 Ut9cyU+7FemIeA/cEeQDDVOfpYjfRm8TMWdTbsEaH4LSldPNiHfAYzeuN9p4luRSs3
	 KUDy8D9pBmgzLWH7/F8SdcocQtAu1yG/wvE/uSCrr+lNOuLzU8FDvPN6uCnaR/m25t
	 eBuJJHWwwSyBA==
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D97024493F
	for <op-tee@lists.trustedfirmware.org>; Thu,  3 Sep 2026 10:10:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DuAYU+lF;
	dkim-atps=neutral
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso21880455e9.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 03 Sep 2026 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788430241; x=1789035041; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v+pGX1kR1YWXhGrmpKIk1Ega27SLYogpSDSn/oUaopE=;
        b=DuAYU+lFhEuA7dBPHzObGikWykcAx+7AF6ch9fgOoa/rRrlisBbZugEZJE/d1KMTdt
         mx9bNBNvISvnfbwcyN4IlC6ZJncOZIM3HHSeDq7lwf4TM268rGzZFHDNBuOzxwn4rCaa
         kXoP0V6hz48hAUv13cdp1oxWIAd+2FzOe8LbzkPMbM4kSfGYeHtg82lLTHejpxR4yWEW
         3cSDpayiYYhzVBdQ/bi70ePsbLE9QmPVQF8CFkIy+xTEW1Umjx1pAQ9oXngI//I848Rv
         1/jXSp8Mv+1PzxbvmH4fVpX4YH2D707SYkyf9kihngsvWpNVAnpwPTT9DooYwB/VIM9p
         MatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430241; x=1789035041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+pGX1kR1YWXhGrmpKIk1Ega27SLYogpSDSn/oUaopE=;
        b=HapmN7xdliaaJVhCPiKjK+Eb5iOSiUGe4+cSvcDMC88Zy5O1fVVSc4L/M4BikQ40jo
         ZU2Z+firO9DRD37V8ZL9wbIZUX9TPE30Ro0py+r0J9wPGetwoXb5eTdlYuvdiv2QZSMc
         a1oSWO3oEIdaZ7Zeh9L5ZprTaGdGy32d3Dab6hIocYPX0PfrN0xXcS19s6cBa6gwBhgO
         DVnb9lRnyhH7MX2f36z+Tsb7VnI5PKlUNWvYKc93Oo7JbcIHDTdu2HuuxNAMabEo5ag3
         khd2+of5CmkLsDIrTNnJoMwcgNxL3EIN0G8dYitSjcdiKTlaJKEmY8OU5e5P0ypvM3/W
         MD0g==
X-Forwarded-Encrypted: i=1; AKwUvBwdVDJfNJfeXTsPAgPBGW2HtdRSvuNeJ1tVj1sxSug4JOd7vMQAlUJMRaA/+yFR5sA+tzbR8qw=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++k1mXaXcGOAR6/3vPJmxGozBi+AI7jdZvGA5qUIFYNzDIbYIg56
	yJNwfmppA8Rne2WxqZNy/vDFjfaAFo8plLxwVbElssMKU/ae51gcH7Mr8M5sZDfoWw==
X-Gm-Gg: AYBFou21wCMF6M9ypOC08bl4wt1FnW+gpM8UZYJF3XoWlsTv7gEflEVUnpTXJeJ+N1d
	q78EnI+/ddo5pnlWqTf6m0xSNWe1Xmfj1HEI29LvEaFJGgLJONToB1VrWTNJDOTCpfsj6bIBfEy
	VDnleVXxoBo0mMDUmy8oeJydcoc6+cX6n/UOHb80mtGqKih6lfC5pPsAF/6abi0SEcXfj4yTBKc
	fVNfM24RIGX69Z+Pvb+bqWcT5qpQHoy0FUMoQB8teJEn0ll5DqcVb69BG4R+G7IjNFbXqTVEuMB
	4zwKXbuvXLcjrmRShuSxH+DjD8VeUNHd6RMAiZiWToRcekdSnmpmMvb2ygv112QEuYfcAW5dxLc
	nneuaiUvjCtL8NYIo5JeIBI7fGl0ZToRit1xsNvXJK9u5MIQVuzLaZtzleCSwBV0vziNlDCLkZC
	LGF3Yp2u/wAYpmwqDEjlg/SkpEx/T9S+UNssovRQwu8i5YxgbxJK7N0wA+JkeNHcuP2/8jXnSvN
	MS+pFTE2iBbz6AxMDXeuHXerCC+cS6bllEXqBiRSuT5ng==
X-Received: by 2002:a05:600c:1906:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-49ce57e7a9dmr190171115e9.4.1788430240105;
        Thu, 03 Sep 2026 03:10:40 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf2531232sm33980375e9.7.2026.09.03.03.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:10:39 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:10:36 +0100
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 09/10] firmware: arm_ffa: Introduce ffa-lend-pool
Message-ID: <aplHnDS2e-Cd5yPC@google.com>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-10-vdonnefort@google.com>
 <20260902173826.GC1440252-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902173826.GC1440252-robh@kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.54:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.54:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D97024493F
X-Spamd-Bar: ---
Message-ID-Hash: AGD5GGADAJIXBV75OVJM7IATKAUGKTOJ
X-Message-ID-Hash: AGD5GGADAJIXBV75OVJM7IATKAUGKTOJ
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AGD5GGADAJIXBV75OVJM7IATKAUGKTOJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Wed, Sep 02, 2026 at 12:38:26PM -0500, Rob Herring wrote:
> On Wed, Sep 02, 2026 at 11:47:11AM +0100, Vincent Donnefort wrote:
> > When memory is lent to the Secure world via FF-A, fatal CPU speculative
> > reads from Non-Secure can still occur as long as it retains a cacheable
> > mapping to that memory. Introduce the "arm,ffa-lend-pool"
> > reserved-memory CMA driver to unmap pages before lending
> > (ffa_prepare_lend()) and restore them upon reclaim
> > (ffa_lend_reclaimed()). Devices bind to the pool via the "memory-region"
> > DT property or via ffa_lend_pool_attach().
> > 
> >   reserved-memory {
> >       #address-cells = <0x2>;
> >       #size-cells = <0x2>;
> >       ranges;
> > 
> >       ffa_lend: ffa-lend-pool {
> >           compatible = "arm,ffa-lend-pool";
> 
> Needs a binding schema...

Ack

> 
> >           reusable;
> >           ll-map;
> >           size = <0x0 0x4000000>;
> >       };
> >   };
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> [...]
> 
> > +static int __init ffa_lend_pool_setup(unsigned long node, struct reserved_mem *rmem)
> > +{
> > +	struct cma *cma;
> > +	int ret;
> > +
> > +	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
> > +	    of_get_flat_dt_prop(node, "no-map", NULL)) {
> > +		pr_err("FF-A lend pool: node must be 'reusable' and not 'no-map'\n");
> > +		return -EINVAL;
> 
> Your schema should enforce/check this.
> 
> [...]
> 
> > +static const struct reserved_mem_ops ffa_lend_pool_ops = {
> > +	.node_init	= ffa_lend_pool_setup,
> > +	.device_init	= ffa_lend_pool_device_init,
> > +	.device_release = ffa_lend_pool_device_release,
> > +};
> > +RESERVEDMEM_OF_DECLARE(ffa_lend_pool, "arm,ffa-lend-pool", &ffa_lend_pool_ops);
> 
> Do you need this early? If not, you can create a platform driver for 
> "arm,ffa-lend-pool". ramoops is implemented that way for example.
> 
> Rob

Only memblock_mark_llmap() must be called very early.

The rest just need to be in place before the TEE driver probed. So a platform
driver should work.

Thanks!

-- 
Vincent
