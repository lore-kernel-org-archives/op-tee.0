Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674C9C79F8C
	for <op-tee@archiver.kernel.org>; Sun,  6 Sep 2026 19:33:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7C910452A1
	for <op-tee@archiver.kernel.org>; Sun,  6 Sep 2026 19:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788723208;
	bh=Do2CEdD6a5aUwLTxegZNZ7rZH9H8xfi1JGY3Uv4qcvI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Qcnjr2llbqSI7KY0LJLRW2ilf1F7MzvRLPNNqJuxGXoxKWKvlo37UFQao2c4su+l/
	 I5b8sDf/ZaTMMU1i9UpRQ+IgGdqrSXIoeZhwrTDC4prIdp+2dscyEpJXgw1v365Old
	 fEfCCXinrSBRA2Awu0VU6DBSY+33AS8ak7aw5giOZImhv8eL9ctFtKkzXPcCWvEcpF
	 W+HZ49oG19vZM5b6FYQVd8E+YC2DDmwP3+NMIlwIr9jATfvvHETQWsi5Jjtdo/Ll6Y
	 qn8uJSGRplJYadk2zoZSFJc5zWSfXhpewUSZ4SeQmoSZ8KhGw3tKqhgJhkm7QObO9s
	 71LJ1+OoKYtZQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9A30F42CFE
	for <op-tee@lists.trustedfirmware.org>; Sun,  6 Sep 2026 19:33:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOQ+l3C3;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 24BB3601F9;
	Sun,  6 Sep 2026 19:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2B71F00A3A;
	Sun,  6 Sep 2026 19:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723200;
	bh=0kNqOTPkZp3J7RemsYmMnYNi7t0didLL0edZoqZbuyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UOQ+l3C3lLujBRXFNmIZbndVsdbScZNJL6O1tqSdqMjmQrjL6ZYziJuWgml1fG0Sf
	 YZjhOpebC9esQLeWBd/jXa9dy1aBOGM9VUfFMdkM1pq8Z2PBJM6ySVz5xzTC6IWHcr
	 hUPG4TiNf0iGjXu2vtdIdxNSmSj85hQyuGO+G/8KJIYORUlSuKuQuG/X9RChqR/x9Y
	 DsHFniEg6Ij/QnQKTcdYooZxqdcI9V1/aRc3LxVfuVuJOyhGvQIWOkfgrAxuFPAZe2
	 vs5e1PdKfZ70Pm/jfgXnCkSDYJMr9D6/FyFbnT3DbR7iuUbU7GjmYCz5kkL2F0VMoz
	 puMLclabJJmcQ==
Date: Sun, 6 Sep 2026 22:33:11 +0300
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v9 01/10] memblock: Introduce MEMBLOCK_LLMAP
Message-ID: <ap2_926WXr7uAYVX@kernel.org>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-2-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902104712.2399797-2-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9A30F42CFE
X-Spamd-Bar: ---------
Message-ID-Hash: TIPRFTDQKL5PCA3FCFUFT224RBLJKVCA
X-Message-ID-Hash: TIPRFTDQKL5PCA3FCFUFT224RBLJKVCA
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TIPRFTDQKL5PCA3FCFUFT224RBLJKVCA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mike Rapoport via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mike Rapoport <rppt@kernel.org>

On Wed, Sep 02, 2026 at 11:47:03AM +0100, Vincent Donnefort wrote:
> Keeping last-level mappings is interesting on some architectures as it
> allows mapping/unmapping pages from the kernel direct map without the
> risk of splitting blocks which, under the break-before-make rule, may
> trigger page-faults the kernel can't handle.
> 
> However, mapping the entire direct map at PTE-level is costly. So
> instead, create a new memblock flag MEMBLOCK_LLMAP to enable the system

I believe MEMBLOCK_PTE_MAP sounds more descriptive.

> to decide which region must be covered by mappings up to the last-level.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index d62db9e776cf..d40a5ded188d 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -52,6 +52,7 @@ extern unsigned long long max_possible_pfn;
>   * kernel that we know is good to use. It is the only memory that
>   * allocations may happen from in this phase.
>   * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
> + * @MEMBLOCK_LLMAP: memory region to be mapped using last-level mapping
>   */
>  enum memblock_flags {
>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
> @@ -63,6 +64,7 @@ enum memblock_flags {
>  	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>  	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
>  	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
> +	MEMBLOCK_LLMAP		= 0x100,/* last-level mapping */
>  };
>  
>  /**
> @@ -160,6 +162,8 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
>  int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
> +int memblock_mark_llmap(phys_addr_t base, phys_addr_t size);
> +int memblock_clear_llmap(phys_addr_t base, phys_addr_t size);
>  
>  void memblock_free(void *ptr, size_t size);
>  void reset_all_zones_managed_pages(void);
> @@ -306,6 +310,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
>  	return m->flags & MEMBLOCK_KHO_SCRATCH;
>  }
>  
> +static inline bool memblock_is_llmap(struct memblock_region *m)
> +{
> +	return m->flags & MEMBLOCK_LLMAP;
> +}
> +
>  int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
>  			    unsigned long  *end_pfn);
>  void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 9ce86349a29f..1591b50503ed 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1119,6 +1119,16 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>   */
>  int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
>  {
> +	struct memblock_region *r;
> +
> +	memblock_cap_size(base, &size);
> +
> +	for_each_mem_region(r) {
> +		if (memblock_is_llmap(r) &&
> +		    memblock_addrs_overlap(base, size, r->base, r->size))
> +			return -EINVAL;
> +	}

I'm not very fond of implicit skips here. memblock has no idea what's the
caller intention, maybe it actually wants to change the memory from nomap
to pte-mapped.

I'd rather warn in memblock_is_nomap() and memblock_is_llmap() if they both
are set and let the caller deal with making sure they are not.

> +
>  	return memblock_setclr_flag(&memblock.memory, base, size, 1, MEMBLOCK_NOMAP);
>  }
>  
> @@ -1204,6 +1214,45 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
>  				    MEMBLOCK_KHO_SCRATCH);
>  }
>  
> +/**
> + * memblock_mark_llmap - Mark a memory region with flag MEMBLOCK_LLMAP.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * If supported by the architecture, such region is mapped at the last-level in
> + * the kernel direct map.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_mark_llmap(phys_addr_t base, phys_addr_t size)
> +{
> +	struct memblock_region *r;
> +
> +	memblock_cap_size(base, &size);
> +
> +	for_each_mem_region(r) {
> +		if (memblock_is_nomap(r) &&
> +		    memblock_addrs_overlap(base, size, r->base, r->size))
> +			return -EINVAL;
> +	}

same here

> +
> +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
> +				    MEMBLOCK_LLMAP);
> +}
> +
> +/**
> + * memblock_clear_llmap - Clear flag MEMBLOCK_LLMAP for a specified region.
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int __init_memblock memblock_clear_llmap(phys_addr_t base, phys_addr_t size)
> +{
> +	return memblock_setclr_flag(&memblock.memory, base, size, 0,
> +				    MEMBLOCK_LLMAP);
> +}
> +
>  static bool should_skip_region(struct memblock_type *type,
>  			       struct memblock_region *m,
>  			       int nid, int flags)
> @@ -2886,6 +2935,7 @@ static const char * const flagname[] = {
>  	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
>  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
>  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
> +	[ilog2(MEMBLOCK_LLMAP)] = "LLMAP",
>  };
>  
>  static int memblock_debug_show(struct seq_file *m, void *private)
> -- 
> 2.55.0.970.g62bdec98f9-goog
> 

-- 
Sincerely yours,
Mike.
