Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14C606A329
	for <op-tee@archiver.kernel.org>; Sun, 15 Nov 2026 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=TB6gPiIH;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhLu85Ua
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 68C0E45489
	for <op-tee@archiver.kernel.org>; Sun, 15 Nov 2026 19:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794770433;
	bh=FC2/9Nf6Q5FCrclKcPkKz6VieKrc0IDWqIB0lRHHj1s=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=TB6gPiIHkBYKYR8J9jKAkRqtaWR3Ph7PEHVYvKxejY+GZCxAowzT+1I2rBUrBN+YV
	 xGkvnr5NK2xxqQsJKTX8kvnA2j5xH6t7NkVuD45hBFJA3YMeFLtEHCsN3rQOp0lXVw
	 1Y8CieSian9CX8SsH5TgkO1jmajJmneFgexyk7qHbqD2L+ceYginUAXazIgRsKFSdQ
	 1duyXuTRC/C8AtKcqQ/eBfJEBfmfHP4J7I3nzAAiTVp8CGK2UA6eNNLvGJcRrmz86b
	 XnksUAbODgjkoxIjZwUA5J2EqsgnBqWb+ymCLB/jKAcLRwzWuBtPA8iiOZB62wNDvX
	 vb9tuV3ajNKBQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4E3A14538D
	for <op-tee@lists.trustedfirmware.org>; Sun, 15 Nov 2026 19:20:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhLu85Ua;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AB737601CC;
	Sun, 15 Nov 2026 19:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC921F000C4;
	Sun, 15 Nov 2026 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794770427;
	bh=fLaQUPcYKxXkir2twg3fsW7g9Gg8lBOZ22Z32cylxH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XhLu85Ua2c6WZLlLlAlu41R/VyenJMuIzs9+HeEnHjow/dZUNr5fsUxv33MVe0xR9
	 NiqKgGZojOd6z653AmlAbwBWSNz0Y/J4dsO9oqMstKyh/UAzeOwqo1F24tatjYGczh
	 Q0qBu2kvlSa0F8oIVuhxCAoOMhwI/hK6jFz/WnzR0a+3Y8LmbXpxRwMM+kxXmZY1iq
	 25w3eguzUz3kcvSwQsQNl1CFRImzluQwZPqKEdduaE+/HXoeSbYwThL2YZMJLNU1I0
	 E3zvrbGwhP652mJ1OL7CToELmOQZpBOaxBkQTr+i8KiSeA8Qj626ksqR9/Ha+aLwjb
	 //TVlKyt3smmQ==
Date: Sun, 15 Nov 2026 21:20:16 +0200
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v3 2/8] arm64: Add support for MEMBLOCK_PTEMAP
Message-ID: <avoF8IbOxVJ9Uh8Y@kernel.org>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-3-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111110738.872947-3-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4E3A14538D
X-Spamd-Bar: --------
Message-ID-Hash: LCKI44DKHLQRGVRZIWPTCH7DZOHAZH3L
X-Message-ID-Hash: LCKI44DKHLQRGVRZIWPTCH7DZOHAZH3L
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LCKI44DKHLQRGVRZIWPTCH7DZOHAZH3L/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Mike Rapoport via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mike Rapoport <rppt@kernel.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 11:07:32AM +0000, Vincent Donnefort wrote:
> With the MEMBLOCK_PTEMAP flag, force a PTE-level mapping. This also

I'd expand this to "Force a PTE-level mapping for memblock regions with
MEMBLOCK_PTEMAP flag set".

> disables contiguous PTEs to make sure any page from the memblock can be

                                     and memblock region here ^

> safely unmapped from the linear map.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  arch/arm64/mm/mmu.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 140520b351e2..a4cafafa1d82 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1184,9 +1184,8 @@ static void __init map_mem(void)
>  	phys_addr_t init_begin = __pa_symbol(__init_begin);
>  	phys_addr_t init_end = __pa_symbol(__init_end);
>  	phys_addr_t kernel_end = __pa_symbol(__bss_stop);
> -	phys_addr_t start, end;
>  	int flags = NO_EXEC_MAPPINGS;
> -	u64 i;
> +	struct memblock_region *r;
>  
>  	/*
>  	 * Setting hierarchical PXNTable attributes on table entries covering
> @@ -1226,9 +1225,14 @@ static void __init map_mem(void)
>  		       flags);
>  
>  	/* map all the memory banks */
> -	for_each_mem_range(i, &start, &end) {
> +	for_each_mem_region(r) {
> +		phys_addr_t start, end;
> +		int rflags = flags;
> +
> +		if (memblock_is_nomap(r))
> +			continue;
>  		/*
> -		 * for_each_mem_range may return sub-page-aligned boundaries
> +		 * for_each_mem_region may return sub-page-aligned boundaries
>  		 * after memblock_mark_nomap() splits regions at byte precision.
>  		 * __create_pgd_mapping_locked aligns phys down to PAGE_MASK,
>  		 * which could accidentally map no-map memory on the boundary.
> @@ -1237,17 +1241,21 @@ static void __init map_mem(void)
>  		 * regions. The cost is at most one page of unmapped gap at
>  		 * each boundary.
>  		 */
> -		start = PAGE_ALIGN(start);
> -		end = end & PAGE_MASK;
> +		start = PAGE_ALIGN(r->base);
> +		end = (r->base + r->size) & PAGE_MASK;

Nit: as we anyway change the assignment to end, PAGE_ALIGN_DOWN() is
slightly more explicit.

>  		if (start >= end)
>  			continue;
> +
> +		if (memblock_is_ptemap(r))
> +			rflags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> +
>  		/*
>  		 * The linear map must allow allocation tags reading/writing
>  		 * if MTE is present. Otherwise, it has the same attributes as
>  		 * PAGE_KERNEL.
>  		 */
>  		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
> -			       flags);
> +			       rflags);
>  	}
>  }
>  
> -- 
> 2.56.0.542.g3ef89b7020-goog
> 

-- 
Sincerely yours,
Mike.
