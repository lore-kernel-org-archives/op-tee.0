Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8E2C79F9E
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:50:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 80D37451A9
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788774625;
	bh=jcSHuYkkSx/TOO3ELmd5fYDSVWMlRxHO2m5zczAIUrk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=EPKq3tDeakRmtZkVAz+QrbYi8oIMVpGUs4me0n977CdTRpK3GTfKY5UXoKqJ4mQ2K
	 fOHAQympdYRa7aJaF9VbjvY2VAE1haQv0QpwGupCfKhfodn4W3JWLCidmSDAvLZc7T
	 dSuTf1bZHKgxEfCCXnqCjMFgkENM0wfdhemubEChvszvwm3xPswklbNeqxe9OcpRyK
	 t+E1t4cqWdS5/EWtv/UF1kSM4LAWKd0eR4JwlZlU/XVF5H4JQyrjeQQh/qukKwSUMU
	 cqiQpukDClzv7oHk1QaDis94fm+/j111yX/amM8brmXQG8lrtYnxwKulvMdzs+C+PN
	 NcKE1Nwupcn5g==
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AB91A44462
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Sep 2026 09:50:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BHTlHd72;
	dkim-atps=neutral
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48584dc164fso3170695f8f.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788774616; x=1789379416; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vkgu8toociZzIJhvAE7ca3qg7cytH4ujCtgPL1CR/5A=;
        b=BHTlHd72krNp5L/7os0vwqmT3ED6JlTjRrBvpk3w1feQV3LW+Jv8I4ZykKErzTwtHU
         V6Ui9xlLM3Q/1+oMISJR/AW07U2VWcqF4Fbvl7g3qT9nvVawE+A0i8eqL9wqoYcbykyJ
         tIaQ6Bj4te0xmZo0Ztl5MuMQBw98lqHvKpqwnPdB8SQ18DSecOjtvvjeUzzHYDpJ8pJq
         xGvwavNZgAW1kjD+hmdSnMPlbY+jRDy7oGLztxGdMkztVwJI6oc1YW13zzpk3risHYl1
         b3zXEkZ+Sw4I8WWfYZL6pR2M5t3MX6FIJYefKoT/aCS1e4R4zOxpUb/b8WW8AGwupGq7
         u5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774616; x=1789379416;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vkgu8toociZzIJhvAE7ca3qg7cytH4ujCtgPL1CR/5A=;
        b=mjLBSLqklWnKoi8j9cJyYdpsh/UPnWRodHNBO0AP5yNlGIpsXktZblQd289pDLWST0
         jQrGP0O2sGi5GHQzIzdaSlYwRKTIJQZxRF4QNJI4zQa+OovPPNymvdiZKMYZ5+eo6SF5
         CU/EmIu2wf5NjyacrFAE9DVoeVWY+p5pWSFxYlBGDMIuzYqYUTOe2wUUuNgQb5/uNud/
         D2+LeVQtbDCAA0K0J6kVAGWzGezFFh/g+bmQ3XQtpcmVRsntvpcZhalzBSuUgKLBRm5u
         93jjPDCZ/35rPzDifV1tnNhhL81WOA/KnbmQuKkENvJ6jVVK+G3rYoX2x0QphqDQXFt6
         sHNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwT0liRxJifrCJVwXmgZWoaCaef5wPZ8TPKGI04RCnqVu+k8PnPW9CqjN6MeaY+jNGagQukRXM=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++n/VqOqvvfOoq9/j9YBaEzCAmHFUlui76HS24/RoXOS6r8qXMF2
	fdTpI46n5GPohaW4U1wFERMqbdVspIlRPUFz3AYTLTVHDltpU4qEkrQGj8RKuOOQ8Q==
X-Gm-Gg: AYBFou0PijtMZmTLmSEVUfoS6+RRptPkgqZX2Ye4ZUMiWVNGBPQQqyW9Sbn9CWkIw1H
	53nmqpg0pK5bi2aDjU8oDchMb6rPdmQg8F6jJD4HXqEwgAH3FFYGP/vtmU+AOT7cB8jkWrWIi2v
	Xqq94M8W9aM07LmoWpIXnUR89UJcaaeWDwLn7lw6RkB9/01Sj/i0hJdGNdx4Z5/BeadshXwy9Fi
	Xpy2lnpx+XbXBRDKxvW6U4f5UYgdNLHHMbTtkZKXtNmTun/Vr+VGujITaruB7XNMM+CpHHeUW8U
	ppIUXvzcCIsrbAW3jtmIpnPOdrhE8LCjhZ5bPjhNnHiZ2QiY0KpEAaInNB3DcOUAd3vQ+2PwiQu
	D/3uHhjbdVFMNTENtaP9NpViEkOg0SR4SpO1MA58OtA5LQ6k0ukdljG4/IjhoYA6url7a23HUvT
	LNfVwg9E/0mb9b08BU0AHfI53nu0Pbo5AUfg7wX3gBhTuiRe+bg7Jh7nTUq6Dd7LLcUCNhNK8DP
	ViKywomx84mLL653NsoYLN2JOW4/pKx
X-Received: by 2002:adf:e18d:0:b0:485:8a46:7060 with SMTP id ffacd0b85a97d-4858a46720amr19581670f8f.50.1788774615795;
        Mon, 07 Sep 2026 02:50:15 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm27142034f8f.4.2026.09.07.02.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:50:15 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:50:12 +0100
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v9 01/10] memblock: Introduce MEMBLOCK_LLMAP
Message-ID: <ap6I1FN_2ylRzFXH@google.com>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-2-vdonnefort@google.com>
 <ap2_926WXr7uAYVX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap2_926WXr7uAYVX@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.48:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.48:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[104.155.91.135:received];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AB91A44462
X-Spamd-Bar: ---
Message-ID-Hash: AMWSGIMNGOGRMRIKXPIARHCFOA7JWLA7
X-Message-ID-Hash: AMWSGIMNGOGRMRIKXPIARHCFOA7JWLA7
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AMWSGIMNGOGRMRIKXPIARHCFOA7JWLA7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Sun, Sep 06, 2026 at 10:33:11PM +0300, Mike Rapoport wrote:
> On Wed, Sep 02, 2026 at 11:47:03AM +0100, Vincent Donnefort wrote:
> > Keeping last-level mappings is interesting on some architectures as it
> > allows mapping/unmapping pages from the kernel direct map without the
> > risk of splitting blocks which, under the break-before-make rule, may
> > trigger page-faults the kernel can't handle.
> > 
> > However, mapping the entire direct map at PTE-level is costly. So
> > instead, create a new memblock flag MEMBLOCK_LLMAP to enable the system
> 
> I believe MEMBLOCK_PTE_MAP sounds more descriptive.

The idea was to have something close from NOMAP, to emphasis it is one or the
other. But PTE_MAP sounds good too.

> 
> > to decide which region must be covered by mappings up to the last-level.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index d62db9e776cf..d40a5ded188d 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -52,6 +52,7 @@ extern unsigned long long max_possible_pfn;
> >   * kernel that we know is good to use. It is the only memory that
> >   * allocations may happen from in this phase.
> >   * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
> > + * @MEMBLOCK_LLMAP: memory region to be mapped using last-level mapping
> >   */
> >  enum memblock_flags {
> >  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> > @@ -63,6 +64,7 @@ enum memblock_flags {
> >  	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
> >  	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
> >  	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
> > +	MEMBLOCK_LLMAP		= 0x100,/* last-level mapping */
> >  };
> >  
> >  /**
> > @@ -160,6 +162,8 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
> >  int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
> >  int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
> >  int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
> > +int memblock_mark_llmap(phys_addr_t base, phys_addr_t size);
> > +int memblock_clear_llmap(phys_addr_t base, phys_addr_t size);
> >  
> >  void memblock_free(void *ptr, size_t size);
> >  void reset_all_zones_managed_pages(void);
> > @@ -306,6 +310,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
> >  	return m->flags & MEMBLOCK_KHO_SCRATCH;
> >  }
> >  
> > +static inline bool memblock_is_llmap(struct memblock_region *m)
> > +{
> > +	return m->flags & MEMBLOCK_LLMAP;
> > +}
> > +
> >  int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
> >  			    unsigned long  *end_pfn);
> >  void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 9ce86349a29f..1591b50503ed 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1119,6 +1119,16 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
> >   */
> >  int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
> >  {
> > +	struct memblock_region *r;
> > +
> > +	memblock_cap_size(base, &size);
> > +
> > +	for_each_mem_region(r) {
> > +		if (memblock_is_llmap(r) &&
> > +		    memblock_addrs_overlap(base, size, r->base, r->size))
> > +			return -EINVAL;
> > +	}
> 
> I'm not very fond of implicit skips here. memblock has no idea what's the
> caller intention, maybe it actually wants to change the memory from nomap
> to pte-mapped.
> 
> I'd rather warn in memblock_is_nomap() and memblock_is_llmap() if they both
> are set and let the caller deal with making sure they are not.

ack.

> 
> > +
> >  	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_NOMAP);
> >  }
> >  
> > @@ -1204,6 +1214,45 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
> >  				    MEMBLOCK_KHO_SCRATCH);
> >  }
> >  
> > +/**
> > + * memblock_mark_llmap - Mark a memory region with flag MEMBLOCK_LLMAP.
> > + * @base: the base phys addr of the region
> > + * @size: the size of the region
> > + *
> > + * If supported by the architecture, such region is mapped at the last-level in
> > + * the kernel direct map.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +int __init_memblock memblock_mark_llmap(phys_addr_t base, phys_addr_t size)
> > +{
> > +	struct memblock_region *r;
> > +
> > +	memblock_cap_size(base, &size);
> > +
> > +	for_each_mem_region(r) {
> > +		if (memblock_is_nomap(r) &&
> > +		    memblock_addrs_overlap(base, size, r->base, r->size))
> > +			return -EINVAL;
> > +	}
> 
> same here

ack

> 
> > +
> > +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
> > +				    MEMBLOCK_LLMAP);
> > +}
> > +
> > +/**
> > + * memblock_clear_llmap - Clear flag MEMBLOCK_LLMAP for a specified region.
> > + * @base: the base phys addr of the region
> > + * @size: the size of the region
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +int __init_memblock memblock_clear_llmap(phys_addr_t base, phys_addr_t size)
> > +{
> > +	return memblock_setclr_flag(&memblock.memory, base, size, 0,
> > +				    MEMBLOCK_LLMAP);
> > +}
> > +
> >  static bool should_skip_region(struct memblock_type *type,
> >  			       struct memblock_region *m,
> >  			       int nid, int flags)
> > @@ -2886,6 +2935,7 @@ static const char * const flagname[] = {
> >  	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
> >  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
> >  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
> > +	[ilog2(MEMBLOCK_LLMAP)] = "LLMAP",
> >  };
> >  
> >  static int memblock_debug_show(struct seq_file *m, void *private)
> > -- 
> > 2.55.0.970.g62bdec98f9-goog
> > 
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Vincent
