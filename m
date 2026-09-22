Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48A1C982F1
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 05:57:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 20E9944F26
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 05:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790056647;
	bh=oA4X8bg4D69EtOBe5V6cBG+ESypw2o0LdcbV1QdnU98=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=KBGIA6+C/Xg4UDIuZN7Saf3+8nN42+bU9g/QYjre3jG7heRZAsSs+V9CfHetxTzWv
	 4AT2ceuP7G9DFMSjXHFFinx+FNHar5mJi0kizK58sVFRY/jGyx4ocDMM3n8IMAFBuH
	 LgXvElxj67jGaUFiWZx6JIUWIQfXB9xpt7GA9N4Pd2IlIGaeNz7ckhmIVDeYpQtOMh
	 slHyaktXp7fB7TSVIIZhdIC9i9zMRzFoArx/JSGWjMAaPy36cYmUe+wbiR4/TFvRaN
	 LE75uX0mIEcDXyvgwaqbxxSE55q9p4hUSC9PkSQHGJJqQ6NgiVvI8+AAFu6rqdl57n
	 MIhow08MGxd9A==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D2D3544F26
	for <op-tee@lists.trustedfirmware.org>; Tue, 22 Sep 2026 05:57:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+bx1QbA;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C91E42B14;
	Tue, 22 Sep 2026 05:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4481F000FF;
	Tue, 22 Sep 2026 05:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790056639;
	bh=+ObChoFplMy58dVx0xmB9riQUjVBXhcLJqj+sig+tvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H+bx1QbAFtCK5w8M9OLBwMjmshn4FWUiM1fycWLxf1SkhL43AQrFieZcHFmE4hLD7
	 L01DQCz8u9gjWUXZHVl4yoTr35oGoeOxVRwlyyli2yh3joHBvr2bDgrG/P1Gwxnjp4
	 YU5rWSRq0+ZliYAOl716wxH5pV6K88X22O+wziPNMz4YOCA8PmNkr0y9cqXTH/afTF
	 AIjOAQGxDNSj9LhUrUQ5dXXTcJ8U7cxZSUMA6EiztqiDPY8n/S5MrMvWllIw47pb4u
	 4RNeLomvR5MwdcZRd1Jc4Vnx4G5VblBp8nrsrn18gr1MR6hcFNL7oCIQU6mxN8Owij
	 LRVYFNUFrY6tQ==
Date: Tue, 22 Sep 2026 11:27:10 +0530
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <arIYtjmSKCs14SqO@sumit-xelite>
Mail-Followup-To: Vincent Donnefort <vdonnefort@google.com>,
	catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org,
	jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com,
	ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org,
	danielmentz@google.com, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, op-tee@lists.trustedfirmware.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260921110050.3977591-1-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260921110050.3977591-1-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received,172.234.252.31:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D2D3544F26
X-Spamd-Bar: --------
Message-ID-Hash: 3Q7BY7AW25ZAVMJ4TO27Y47VUMDJ4RFS
X-Message-ID-Hash: 3Q7BY7AW25ZAVMJ4TO27Y47VUMDJ4RFS
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3Q7BY7AW25ZAVMJ4TO27Y47VUMDJ4RFS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

Hi Vincent,

On Mon, 21 Sep 2026 at 12:00:42 +0100, Vincent Donnefort wrote:
>This series is a follow-up to the discussion that has started here [1].
>
>When memory is lent to the Secure world via FF-A, CPU speculative
>accesses from NS to the lent pages can still occur as long as it retains
>a cacheable mapping to it.
>
>Ideally, lent memory would be "no-map" but that would mean giving up
>MiBs of useful memory, so let's try to do better with the help of a CMA
>pool.
>
>On arm64, modifying the direct map at runtime is generally restricted
>because the linear map defaults to block mapping and splitting blocks at
>runtime may trigger fatal page fault, unless the CPU implements BBML3
>or the entire direct map was mapped at page granularity from boot.
>Forcing last-level mappings system-wide incurs a severe penalty we want
>to avoid. Instead, this series introduces targeted last-level mappings
>for designated memory regions, along with the "arm,ffa-lend-pool" CMA
>driver to manage unmapping and remapping on lend/reclaim transitions:
>
>1. memblock:
>   - Introduce MEMBLOCK_PTEMAP to force PTE mappings only for a specific region.
>
>2. set_memory infrastructure:
>   - Introduce can_set_direct_map_range() to check if a specific address
>     range is mapped with last-level entries and can be modified safely.
>   - Introduce __set_direct_map_*() variants that bypass redundant checks
>     when the caller has already validated the range.
>
>3. "arm,ffa-lend-pool" driver
>   - Introduce the "arm,ffa-lend-pool" CMA reserved-memory driver, which
>     unmaps pages prior to lending (ffa_prepare_lend()) and restores them
>     when reclaimed (ffa_lend_reclaimed()).
>
>4. Optee support
>   - Hook OP-TEE dynamic protected memory pools to "arm,ffa-lend-pool" for
>     both SMC (via DT memory-region phandle) and FF-A (via
>     ffa_lend_pool_attach()) transports.


Thanks for your proposal in trying to solve this hard problem of
unmapping pages from kernel linear map. I remember discussing this
problem last year at LPC too.

Have you had a chance to look at a more generic MM proposal around this
issue here [1]?

One of the major concern for me with your proposal is tying the
protected memory allocation to fixed sized platform specific pool size
based on DT. Then the cost of granular mappings/unmapping if the
platforms choose to enlarge these pools.

As you maybe aware one of the major use-cases here for protected DMAbufs
is the secure media pipeline use-case which is memory intensive
workload. IMO, the solution proposed at [1] seems to address it although
people have flagged rough edges there but should be addressable.

Can you try a port of [1] for arm64 since the author did all the work
with x86 as reference?

[1] https://lore.kernel.org/all/20260726-page_alloc-unmapped-v3-0-6f5729aa9832@google.com/

-Sumit

>
>Testing:
>========
>
>Tested with QEMU v8 using OP-TEE OS (built with CFG_CORE_DYN_PROTMEM=y)
>under both SMC and FF-A transports [2]
>
>static void dump_direct_map(const char *label)
>{
>	printf("\n=== %s ===\n", label);
>	fflush(stdout);
>	system("sed -n '/Linear Mapping start/,/Linear Mapping end/p' /sys/kernel/debug/kernel_page_tables");
>	fflush(stdout);
>}
>
>int main(int argc, char *argv[])
>{
>	int heap_fd;
>	int dmabuf_fd;
>	struct dma_heap_allocation_data data = { 0 };
>	size_t size = 1024 * 1024; /* 1MB */
>
>	if (argc > 1)
>		size = strtoul(argv[1], NULL, 0);
>
>	dump_direct_map("BEFORE ALLOCATION");
>
>	heap_fd = open("/dev/dma_heap/protected,secure-video", O_RDWR);
>	if (heap_fd < 0) {
>		perror("open /dev/dma_heap/protected,secure-video");
>		return 1;
>	}
>
>	printf("\nOpened /dev/dma_heap/protected,secure-video\n");
>	printf("Allocating %zu bytes of protected memory via DMA heap...\n", size);
>
>	data.len = size;
>	data.fd_flags = O_RDWR | O_CLOEXEC;
>	if (ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &data) < 0) {
>		perror("ioctl DMA_HEAP_IOCTL_ALLOC");
>		close(heap_fd);
>		return 1;
>	}
>
>	dmabuf_fd = data.fd;
>	printf("Successfully allocated %zu bytes! dmabuf_fd = %d\n", size, dmabuf_fd);
>
>	dump_direct_map("DURING LEND (EXPECT HOLE IN DIRECT MAP)");
>
>	printf("\nReleasing dmabuf_fd...\n");
>	close(dmabuf_fd);
>	close(heap_fd);
>
>	dump_direct_map("AFTER RECLAIM (RESTORED DIRECT MAP)");
>
>	return 0;
>}
>
>[1] https://lore.kernel.org/all/20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com/
>[2] https://optee.readthedocs.io/en/latest/building/gits/build.html#qemu-v8
>
>Changelog:
>
>v2:
>  - Rename MEMBLOCK_LLMAP to MEMBLOCK_PTEMAP (Mike)
>  - Warn on conflicting MEMBLOCK_NOMAP and MEMBLOCK_PTEMAP flags (Mike)
>  - Drop DT "ll-map" property and mark MEMBLOCK_PTEMAP from ffa_lend_pool_setup() (Rob, Thierry)
>  - Drop "reusable" and "no-map" property checks from ffa_lend_pool_setup() (Rob)
>  - dt-bindings: Document arm,ffa-lend-pool (Rob)
>  - Rework the Optee support with a separate ffa_lend_pool.c file.
>  - use walk_kernel_page_table_range_lockless() for
>    can_set_direct_map_range() to fix folded page table (Sashiko)
>  - Add missing TLB flush in ffa_prepare_lend()
>  - Disable hibernation
>  - Rebase on linux-next (next-20260918) to use the new set_direct_map*() ranges (Mike)
>
>v1 (https://lore.kernel.org/all/20260902104712.2399797-1-vdonnefort@google.com/)
>
>Vincent Donnefort (8):
>  memblock: Introduce MEMBLOCK_PTEMAP
>  arm64: Introduce can_set_direct_map_range()
>  arm64: Introduce __set_direct_map*()
>  arm64: Add support for MEMBLOCK_PTEMAP
>  firmware: arm_ffa: Introduce ffa-lend-pool
>  optee: Add support for arm,ffa-lend-pool
>  dt-bindings: reserved-memory: Add Arm FF-A lend pool
>  dt-bindings: firmware: optee: Add memory-region property
>
> .../arm/firmware/linaro,optee-tz.yaml         |   5 +
> .../reserved-memory/arm,ffa-lend-pool.yaml    |  55 ++++
> arch/arm64/include/asm/set_memory.h           |   7 +
> arch/arm64/mm/mmu.c                           |  23 +-
> arch/arm64/mm/pageattr.c                      |  72 ++++-
> drivers/firmware/arm_ffa/Kconfig              |   5 +
> drivers/firmware/arm_ffa/Makefile             |   1 +
> drivers/firmware/arm_ffa/lend_pool.c          | 261 ++++++++++++++++++
> drivers/tee/optee/Makefile                    |   1 +
> drivers/tee/optee/core.c                      |   6 +
> drivers/tee/optee/ffa_abi.c                   |  13 +-
> drivers/tee/optee/ffa_lend_pool.c             |  72 +++++
> drivers/tee/optee/optee_private.h             |   4 +
> drivers/tee/optee/protmem.c                   |  20 +-
> drivers/tee/optee/smc_abi.c                   |  21 +-
> include/linux/arm_ffa.h                       |  23 ++
> include/linux/memblock.h                      |  18 ++
> mm/memblock.c                                 |  30 ++
> 18 files changed, 608 insertions(+), 29 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/reserved-memory/arm,ffa-lend-pool.yaml
> create mode 100644 drivers/firmware/arm_ffa/lend_pool.c
> create mode 100644 drivers/tee/optee/ffa_lend_pool.c
>
>
>base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
>-- 
>2.55.0.1082.g2b9226bbc0-goog
>
