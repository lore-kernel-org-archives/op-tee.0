Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45C560A6F74
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=1GZ/ZjcJ;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G50XDvpD
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 101B2454FC
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794395323;
	bh=SDcWifd/Zu9wcRKP52uQVdiLNucbPw1/niYb9JsOkp0=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=1GZ/ZjcJKqx7HcVuxICuBHpJf95zZrdd3AGJ1vd4/ozazvo9cL9UfMcyhAuptP0Lo
	 47maKb/KBU+oup3O5nVTG/W1xSIwWWprJOeZLE9rjfEVlYrbohzy5MhsaLiZZHr+qZ
	 u/k//hHiRRJ4/eoCpY/jSbcFVOb4MjYcwZ5K8+LBGt6mMfbvFbuWzoi64fD5RK67kX
	 OfOVJmcECAhZS5Zmk1oLhmvsDy4VOuPsX4S/JEGqD2lCLivqqqbPfJLqTcFZNkoT6X
	 kr62sjiveAzbC+otFwbqJVJfpPwu2/PEpZFL/SEAiBFma7IO7ScKX2CJ0+fysxxvTg
	 bheAai8LPcYjg==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AA76745045
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 11:08:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G50XDvpD;
	dkim-atps=neutral
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4b64722b5e6so34393925e9.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 03:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395302; x=1795000102; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbCldHU5Mwk7c5H3z6Uc6u4VrcQ6WVCcsNry6NcYtQ0=;
        b=G50XDvpDV7rQQ2m6qbxbZBbbfwiOxbDuzGzfNc1FVEFgW94m2zowtcCT2watLGHbkS
         8CBnHCPPPJyFjD2mq64FzSZdpK8DxKeHErHcBg4sXuR8Jl56c3s/eLms2SG+Ss2vIaw0
         QBGzmtDWqgdCQdlRIiraQYmIPmwiTMKZnkeEGZz9klN8uBixxtJyCuAwVxDzND+FB0uf
         L6ML3pWUraGv92IbmIrJmSzvd0et3aGW6wwRAbLTv/wbIXSzugsGEi2S+vmasKILHDB9
         ngWYPXkJWOR86CQsRHq3QMoAkfDRnKQG6YQOe8EjtGvo2nUqyJt2v8AEezd0/spymbuN
         oFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395302; x=1795000102;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IbCldHU5Mwk7c5H3z6Uc6u4VrcQ6WVCcsNry6NcYtQ0=;
        b=ojCleU0OjTh/MvxoRhVUjA09r7Dxzhiko/5JWtGrasQzAeVKDmyFV834P9nCb8mKq1
         TYVAkLvwvUwCiHjO1VPJc3LwsvqcBLSxiiHH955Li5vPJq0LGbm4Q+SmmGMjQn8ItV6v
         UYLB/n4mQFsUnurbemXVWjs20IygJBZafVRvjBAMbPawrnVAhnwZAe4FL4viFRQpjHSH
         J5H4JLY9j0M65/az9NIBpboV190F/gzzBHFfKlk22aWSyzmfTBbToIonSgY10aDwArZC
         kXPlKEJlhm7Jxhmy28LMZsh2beA/dxdiOoUGJTHV9GHtPGzUVLc/a2YQasmmlyMZ546g
         9AXg==
X-Forwarded-Encrypted: i=1; AL+hErGKzzsgMKV55OB4PO8h4Uls7/eu7N9SOxrb1wfzGuKFTxP9A/y/bDhvBat6+/hJBETvO6hRXLw=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/IVa8jfzI8dnGzXRxDYx6jsjGoFC0lA0ViGQUBVbdYgN1VFxo3
	BprEMsETa1Ol1LNsv6Mmq75lVS6mcujdnYSfo4OZ6e/IT/f+rYfnzbnQ+eCrumz8LyqdKQV6zLX
	hLuZB9I15oYWoBFqRgvDB4g==
X-Received: from wmba9.prod.google.com ([2002:a05:600c:6dc9:b0:4a1:b748:caa2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b78:b0:4a6:4d6b:a840 with SMTP id 5b1f17b1804b1-4ba0938fdf4mr37001375e9.31.1794395302318;
 Wed, 11 Nov 2026 03:08:22 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:30 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-1-vdonnefort@google.com>
Subject: [PATCH v3 0/8] arm64: Unmap FF-A lent memory from direct map
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3pkz0agokbm8iqbaarsbegtbbtyr.pbzbc-grryvfgf.gehfgrqsvezjner.bet@flex--vdonnefort.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20260707];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3pkz0agokbm8iqbaarsbegtbbtyr.pbzbc-grryvfgf.gehfgrqsvezjner.bet@flex--vdonnefort.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.71:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.71:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AA76745045
X-Spamd-Bar: /
Message-ID-Hash: FZQTR6QTRGJO6P2VTHMDSOLSD2SQISFM
X-Message-ID-Hash: FZQTR6QTRGJO6P2VTHMDSOLSD2SQISFM
X-MailFrom: 3pkz0agoKBm8iQbaaRSbegTbbTYR.PbZbc-gRRYVfgf.gehfgRQSVeZjNeR.beT@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FZQTR6QTRGJO6P2VTHMDSOLSD2SQISFM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series is a follow-up to the discussion that has started here [1].

When memory is lent to the Secure world via FF-A, CPU speculative
accesses from NS to the lent pages can still occur as long as it retains
a cacheable mapping to it.

Ideally, lent memory would be "no-map" but that would mean giving up
MiBs of useful memory, so let's try to do better with the help of a CMA
pool.

On arm64, modifying the direct map at runtime is generally restricted
because the linear map defaults to block mapping and splitting blocks at
runtime may trigger fatal page fault, unless the CPU implements BBML3
or the entire direct map was mapped at page granularity from boot.
Forcing last-level mappings system-wide incurs a severe penalty we want
to avoid. Instead, this series introduces targeted last-level mappings
for designated memory regions, along with a generic "lendable-dma-pool"
CMA driver to manage unmapping and remapping on lend/reclaim transitions:

1. memblock:
   - Introduce MEMBLOCK_PTEMAP to force PTE mappings only for a specific region.

2. dma-mapping:
   - Introduce the "lendable-dma-pool" CMA reserved-memory driver, along with
     generic dma_zap_direct_map() and dma_restore_direct_map() APIs to unmap
     pages from the direct map and restore them.

3. arm64 direct map support:
   - Implement the "lendable-dma-pool" hooks.

4. OP-TEE support:
   - Hook OP-TEE dynamic protected memory allocation (tee_shm_alloc_dma_mem()) to
     dma_zap_direct_map() and dma_restore_direct_map().

Testing:
========

Tested with QEMU v8 using OP-TEE OS (built with CFG_CORE_DYN_PROTMEM=y)
under both SMC and FF-A transports [2]

static void dump_direct_map(const char *label)
{
	printf("\n=== %s ===\n", label);
	fflush(stdout);
	system("sed -n '/Linear Mapping start/,/Linear Mapping end/p' /sys/kernel/debug/kernel_page_tables");
	fflush(stdout);
}

int main(int argc, char *argv[])
{
	int heap_fd;
	int dmabuf_fd;
	struct dma_heap_allocation_data data = { 0 };
	size_t size = 1024 * 1024; /* 1MB */

	if (argc > 1)
		size = strtoul(argv[1], NULL, 0);

	dump_direct_map("BEFORE ALLOCATION");

	heap_fd = open("/dev/dma_heap/protected,secure-video", O_RDWR);
	if (heap_fd < 0) {
		perror("open /dev/dma_heap/protected,secure-video");
		return 1;
	}

	printf("\nOpened /dev/dma_heap/protected,secure-video\n");
	printf("Allocating %zu bytes of protected memory via DMA heap...\n", size);

	data.len = size;
	data.fd_flags = O_RDWR | O_CLOEXEC;
	if (ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &data) < 0) {
		perror("ioctl DMA_HEAP_IOCTL_ALLOC");
		close(heap_fd);
		return 1;
	}

	dmabuf_fd = data.fd;
	printf("Successfully allocated %zu bytes! dmabuf_fd = %d\n", size, dmabuf_fd);

	dump_direct_map("DURING LEND (EXPECT HOLE IN DIRECT MAP)");

	printf("\nReleasing dmabuf_fd...\n");
	close(dmabuf_fd);
	close(heap_fd);

	dump_direct_map("AFTER RECLAIM (RESTORED DIRECT MAP)");

	return 0;
}

[1] https://lore.kernel.org/all/20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com/
[2] https://optee.readthedocs.io/en/latest/building/gits/build.html#qemu-v8

Changelog:

v3:
  - Replace "arm,ffa-lend-pool" and OP-TEE "memory-region" DT binding with generic
    "lendable-dma-pool" compatible with "linux,cma-default" (Sumit).
  - move conflict check to flag-setting time in memblock_setclr_flag()
    (Mike)
  - Rebase onto v7.4-rc1.

v2 (https://lore.kernel.org/all/20260921110050.3977591-1-vdonnefort@google.com/):
  - Rename MEMBLOCK_LLMAP to MEMBLOCK_PTEMAP (Mike)
  - Warn on conflicting MEMBLOCK_NOMAP and MEMBLOCK_PTEMAP flags (Mike)
  - Drop DT "ll-map" property and mark MEMBLOCK_PTEMAP from ffa_lend_pool_setup() (Rob, Thierry)
  - Drop "reusable" and "no-map" property checks from ffa_lend_pool_setup() (Rob)
  - dt-bindings: Document arm,ffa-lend-pool (Rob)
  - Rework the Optee support with a separate ffa_lend_pool.c file.
  - use walk_kernel_page_table_range_lockless() for
    can_set_direct_map_range() to fix folded page table (Sashiko)
  - Add missing TLB flush in ffa_prepare_lend()
  - Disable hibernation
  - Rebase on linux-next (next-20260918) to use the new set_direct_map*() ranges (Mike)

v1 (https://lore.kernel.org/all/20260902104712.2399797-1-vdonnefort@google.com/)

Vincent Donnefort (8):
  memblock: Introduce MEMBLOCK_PTEMAP
  arm64: Add support for MEMBLOCK_PTEMAP
  dma-contiguous: Expose rmem_cma_ops
  dt-bindings: reserved-memory: Add lendable-dma-pool
  dma-mapping: Introduce lendable-dma-pool
  arm64: Introduce direct_map_is_ptemap()
  arm64: Add support for lendable-dma-pool
  optee: Add support for lendable-dma-pool

 .../reserved-memory/lendable-dma-pool.yaml    |  58 +++++
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/set_memory.h           |   6 +
 arch/arm64/mm/dma-mapping.c                   |  71 +++++
 arch/arm64/mm/mmu.c                           |  22 +-
 arch/arm64/mm/pageattr.c                      | 121 ++++++++-
 drivers/tee/optee/protmem.c                   |  48 +++-
 include/linux/dma-map-ops.h                   |   9 +
 include/linux/dma-mapping.h                   |  16 ++
 include/linux/memblock.h                      |   9 +
 kernel/dma/Kconfig                            |   3 +
 kernel/dma/Makefile                           |   1 +
 kernel/dma/contiguous.c                       |   4 +-
 kernel/dma/contiguous.h                       |  10 +
 kernel/dma/lendable.c                         | 243 ++++++++++++++++++
 mm/memblock.c                                 |  39 ++-
 16 files changed, 630 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml
 create mode 100644 kernel/dma/contiguous.h
 create mode 100644 kernel/dma/lendable.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.542.g3ef89b7020-goog

