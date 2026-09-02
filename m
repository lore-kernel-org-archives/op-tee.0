Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF18AC624D6
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 13:27:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E5C4C43ECB
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788355661;
	bh=46EGZ5pqfojB4SEknL4ghE/O+NrgMIaCGgz/FeaouIc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2QOxsYwiFEprAWr0UZf04XxSP4d1TSIiPB+sEY0QGMjyCLOydeuvlH+Mfc3+d5cd0
	 oyyiro8oh4/xLe9MkItG7ANUI7tA0JszLCErMrkCdF0x9ebWdGj2jCLTdoLpLyvvuM
	 j1zXTFR0UT4Vr1UDI6KFYT4UYl1NAbcwwQWNjjkpoGOwN696N8p59UHe75z+55oWE6
	 Gny5H2+uSslMvXnzFSz0cmJwhyXqpBc4lc62c4+XeY4pgG4nuVnap6hBFNrUVAS0HR
	 IosU3I7tvSNZapUA5HHVxegX2cFLhQmzwD/zbYuKW6FHUq+eHJl5lWcsAkIDHsv2KS
	 SyTrmtEQFmuTA==
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A8A4D43ECB
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 13:27:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CyWjE3dn;
	dkim-atps=neutral
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c255c58156bso169822966b.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788355653; x=1788960453; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zt5M13bJdXW7K7qyVlwwml2r+oge4XhKrpcO5BXQh9I=;
        b=CyWjE3dnfyxXfGdvUPeJCAVQm2gOP9Qop64+H/PIWtg0QcKfp8+GQJObIjAls0XfAp
         GIOLZKEDOwgxiIE544oCEhRkJ3HF+IGzpATrjo7xfAeDzNs32HfE2p87rQIi5xM+tM9d
         WMHaJs730mlLEM5nmvt62q0ZdeQxVJpyn62GSlbB4kLUjDCTvzbSOO9M213cu9fvOu5R
         zEqiIZvsgZGOdJdVodg8BjlMRjwa+rLvrlhsy4ZLW3muSi6cxJe0AXYzDEXvqSOfhKJD
         n0vRn3rXeCkJgHt/y587DfbfYVIgt46MVi90b4oT2iteydpcMS4neIhjCynIaBa0Fenk
         X1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788355653; x=1788960453;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zt5M13bJdXW7K7qyVlwwml2r+oge4XhKrpcO5BXQh9I=;
        b=TTLYYcuBGGR575VC1c6U6erGudu+Exs6+azh9RqzKcRCdqnEXTg8evow489SmLLwe4
         sWGU2ZULc91+yuUlI7rRYHSI1XnNnEAAvdf294Qh0jsA1WrEfLVKIo5rnXgLViTaq7mO
         2jJiWlPO8lvA74BW9Qebg+1UB9gxM6gI1TuuaAtvzCAKuME4W8KF6kPbqTrVzUZyYCQ2
         MuqrIhvLb8JOtIm8Lcq0BENERBj8IBnfXSgnb1d5oXZaCvzE3Z1X3XJ0Ea4Qsi+OT1WM
         b+XkDwChD2vJGs0UrIA4yTdsgEd696yi1jKoJJbQw5tWaNZfp/eoqhoBdNwS4wcdip0F
         SfVA==
X-Forwarded-Encrypted: i=1; AKwUvBwC2cB+aFztrIfF+/0jyzDg38nnup11616gjqIchdk1/VhAP8R5/IJDNbZ4tfNmj2SlLmlGUog=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mEB2EiTnR3WiKweZI0t/c4aXJGstVVpd843bwoeiP3YeDPNaTz
	m20lYwT14E9cxaqbJki94PTk5eVyyl4Vxgj+jPSN25TMKS84R/X4Rbpn6NhwMnmruw==
X-Gm-Gg: AYBFou34TXj5OFcgt9j6MWnHBZuONlvn8iAF04YQOPA3P7GWMdNcwldf1rVYeDYZ3dH
	+eTu3ux98k/CC/TPTl+Y0QsEULSctEyZekq1tqYAKqKyagOuOwG6ThDSqHbGpTlg7NFtJYTeWa/
	pEKOvRH24rgf+YRt+BWmNQnFkIS4LvABrTHLm7+mfxPA5IYDAzsd9F0sFh+ILyyKPtOUcXWPndJ
	Sw0+qM7io1DWbjraj1uU7+GRYEJLxWXMmnhBh1RoQ7SUuKvhvyob+KJmXxQ22KHiFgMqktfKPRB
	SGKtwyMiU7fXBLDXqlYtYNBndDt78teEAEXwC2JQWdCYrdXU7Ho0bWkEqvCdRF+0ixUSEdyOhls
	p7FyUP1FinfZSryc2PyWbsmZnjnuGEo7115Os3SU9ag9jR16GvnAFtZdTuMO8nKPaNUsRszNexe
	7gZATCpKcKEwaLtP7DOj/dK6DdE3ULuH3c3vu5iSZH68JndNO8id8SSipMMC8rK1fiVVi7PtVI1
	yXCkWkpfLgqib2Ugq5z/cwqPJHAzp1B
X-Received: by 2002:a17:906:f58e:b0:c25:c954:faf2 with SMTP id a640c23a62f3a-c25d563a41cmr291059666b.21.1788355652676;
        Wed, 02 Sep 2026 06:27:32 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d039d796sm138037066b.40.2026.09.02.06.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:27:32 -0700 (PDT)
Date: Wed, 2 Sep 2026 14:27:28 +0100
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org,
	jenswi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v9 00/10] arm64: Unmap FF-A lent memory from direct map
Message-ID: <apgkQJai-2pjI75-@google.com>
References: <20260902104712.2399797-1-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902104712.2399797-1-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.41:from];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.41:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A8A4D43ECB
X-Spamd-Bar: ----
Message-ID-Hash: 4DRYXDTL3JVVKKCJ2QSAQVSOX2EBVTI3
X-Message-ID-Hash: 4DRYXDTL3JVVKKCJ2QSAQVSOX2EBVTI3
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4DRYXDTL3JVVKKCJ2QSAQVSOX2EBVTI3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

This is of course v1, not v9...

On Wed, Sep 02, 2026 at 11:47:02AM +0100, Vincent Donnefort wrote:
> This series is a follow-up to the discussion that has started here [1].
> While standalone, it also provides primitives reusable for the VPR DMA
> heap.
> 
> When memory is lent to the Secure world via FF-A, CPU speculative
> accesses from NS to the lent pages can still occur as long as it retains
> a cacheable mapping to it.
> 
> Ideally, lent memory would be "no-map" but that would mean giving up
> MiBs of useful memory, so let's try to do better with the help of a CMA
> pool.
> 
> On arm64, modifying the direct map at runtime is generally restricted
> because the linear map defaults to block mapping and splitting blocks at
> runtime may trigger fatal page fault, unless the CPU implements BBML3
> or the entire direct map was mapped at page granularity from boot.
> Forcing last-level mappings system-wide incurs a severe penalty we want
> to avoid. Instead, this series introduces targeted last-level mappings
> for designated memory regions, along with the "arm,ffa-lend-pool" CMA
> driver to manage unmapping and remapping on lend/reclaim transitions:
> 
> 1. memblock & OF reserved memory ("ll-map"):
>    - Introduce MEMBLOCK_LLMAP and the DT "ll-map" property for reserved-memory
>      nodes to force last-level (PTE) mappings only for a specific region.
> 
> 2. set_memory infrastructure:
>    - Introduce can_set_direct_map_range() to check if a specific address
>      range is mapped with last-level entries and can be modified safely.
>    - Introduce __set_direct_map_*() variants that bypass redundant checks
>      when the caller has already validated the range.
> 
> 3. "arm,ffa-lend-pool" driver
>    - Introduce the "arm,ffa-lend-pool" CMA reserved-memory driver, which
>      unmaps pages prior to lending (ffa_prepare_lend()) and restores them
>      when reclaimed (ffa_lend_reclaimed()).
> 
> 4. Optee support
>    - Hook OP-TEE dynamic protected memory pools to "arm,ffa-lend-pool" for
>      both SMC (via DT memory-region phandle) and FF-A (via
>      ffa_lend_pool_attach()) transports.
> 
> Testing:
> ========
> 
> Tested with QEMU v8 using OP-TEE OS (built with CFG_CORE_DYN_PROTMEM=y)
> under both SMC and FF-A transports [2]
> 
> static void dump_direct_map(const char *label)
> {
> 	printf("\n=== %s ===\n", label);
> 	fflush(stdout);
> 	system("sed -n '/Linear Mapping start/,/Linear Mapping end/p' /sys/kernel/debug/kernel_page_tables");
> 	fflush(stdout);
> }
> 
> int main(int argc, char *argv[])
> {
> 	int heap_fd;
> 	int dmabuf_fd;
> 	struct dma_heap_allocation_data data = { 0 };
> 	size_t size = 1024 * 1024; /* 1MB */
> 
> 	if (argc > 1)
> 		size = strtoul(argv[1], NULL, 0);
> 
> 	dump_direct_map("BEFORE ALLOCATION");
> 
> 	heap_fd = open("/dev/dma_heap/protected,secure-video", O_RDWR);
> 	if (heap_fd < 0) {
> 		perror("open /dev/dma_heap/protected,secure-video");
> 		return 1;
> 	}
> 
> 	printf("\nOpened /dev/dma_heap/protected,secure-video\n");
> 	printf("Allocating %zu bytes of protected memory via DMA heap...\n", size);
> 
> 	data.len = size;
> 	data.fd_flags = O_RDWR | O_CLOEXEC;
> 	if (ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &data) < 0) {
> 		perror("ioctl DMA_HEAP_IOCTL_ALLOC");
> 		close(heap_fd);
> 		return 1;
> 	}
> 
> 	dmabuf_fd = data.fd;
> 	printf("Successfully allocated %zu bytes! dmabuf_fd = %d\n", size, dmabuf_fd);
> 
> 	dump_direct_map("DURING LEND (EXPECT HOLE IN DIRECT MAP)");
> 
> 	printf("\nReleasing dmabuf_fd...\n");
> 	close(dmabuf_fd);
> 	close(heap_fd);
> 
> 	dump_direct_map("AFTER RECLAIM (RESTORED DIRECT MAP)");
> 
> 	return 0;
> }
> 
> [1] https://lore.kernel.org/all/20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com/
> [2] https://optee.readthedocs.io/en/latest/building/gits/build.html#qemu-v8
> 
> Vincent Donnefort (10):
>   memblock: Introduce MEMBLOCK_LLMAP
>   of: reserved_mem: Introduce "ll-map" property
>   set_memory.h: Introduce can_set_direct_map_range()
>   set_memory.h: Introduce __set_direct_map*()
>   arm64: can_set_direct_map() if BBML3
>   arm64: Implement can_set_direct_map_range()
>   arm64: Implement __set_direct_map*()
>   arm64: Add support for MEMBLOCK_LLMAP
>   firmware: arm_ffa: Introduce ffa-lend-pool
>   optee: Add support for arm,ffa-lend-pool
> 
>  arch/arm64/include/asm/set_memory.h  |   7 +
>  arch/arm64/mm/mmu.c                  |  23 ++-
>  arch/arm64/mm/pageattr.c             |  67 +++++++-
>  drivers/firmware/arm_ffa/Kconfig     |   5 +
>  drivers/firmware/arm_ffa/Makefile    |   1 +
>  drivers/firmware/arm_ffa/lend_pool.c | 223 +++++++++++++++++++++++++++
>  drivers/of/of_reserved_mem.c         | 104 ++++++++++---
>  drivers/tee/optee/ffa_abi.c          |  13 +-
>  drivers/tee/optee/protmem.c          |   8 -
>  drivers/tee/optee/smc_abi.c          |  17 +-
>  drivers/tee/tee_shm.c                |  11 +-
>  include/linux/arm_ffa.h              |  21 +++
>  include/linux/memblock.h             |   9 ++
>  include/linux/set_memory.h           |  39 +++++
>  mm/memblock.c                        |  50 ++++++
>  15 files changed, 545 insertions(+), 53 deletions(-)
>  create mode 100644 drivers/firmware/arm_ffa/lend_pool.c
> 
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> -- 
> 2.55.0.970.g62bdec98f9-goog
> 

-- 
Vincent
