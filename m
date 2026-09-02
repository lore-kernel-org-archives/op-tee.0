Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50407C624D0
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:51:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 67A46453C8
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788346278;
	bh=b8dYj5Mb3BDa4NaGc2pKKYPn/Bn+O6BIzVzZSjPQZ/s=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=aryxy4LGq9Do9QouKfa4P8K9JkbU2J3+nTKW/3Z/zYc3epihyZou6rG6VSYt7IZMC
	 rnO0l+ZxCvR//BFh+cOKeu39Lhihs3aVipe5ZcgziARs0yZNn7Zgcw6tjNS7p8hqT1
	 9GrkMCwuPRN9EaBF7Lb+gduWzFdMppdEuh19k47iatYyzADLvPnRUDifrg5FaIu0h3
	 +czwhZs/iplRGPMtkyTXNDIwElGyZQQu87ugvv7WtG8x1t+93Xz656F65Yk4P8mGz9
	 zI2/InRNdWXNxCQpLz0tni3bbE0M2ob3t5CaTQuQaD/xqEBDjCuB6qj/LxJuP/N4CH
	 XSXEfBwwxRlnw==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3669A43ECB
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 10:51:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FVItORck;
	dkim-atps=neutral
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so5814405e9.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 03:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788346267; x=1788951067; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fj637K00n75DiMuZkcJnY4d1CwmzO8C83BzSZ9fxg50=;
        b=FVItORck5YCY+fyZxN4JY0hwOxLTZJlO5MlOsZZyzMrhEVYLdklk7bN70rHgRre5G9
         MuoNFUdHOlxrmg8BAXNFF/SBXQ8CsQF6MLrwxEqR60afB3lK4wUd+k4gXUpmcQ6IuIpN
         u6SC9wdkVPuf35GDJjG9bnHG+QaY1QvSfAtsIuN2vLXy7ILuy8DlwRL3pNxheFIeFq74
         XTBIrAAyVeHuU4xYZOpyhBd0NgMe2zMULYZ22QdaakaLyy2n9Fv3T+eAUF8syqFR4yKA
         M5+TB8WlT5o6bXbjv/sXAm2oLlovPms0UpQJTL/lPvRfCsx/Y3qDaUE5x4RmD/p0PPqW
         dAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346267; x=1788951067;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fj637K00n75DiMuZkcJnY4d1CwmzO8C83BzSZ9fxg50=;
        b=CsROsnsERwBKY7EHfvcd5mtgG/OJ5CHs+f0ihtt9xo8nLbrkCViOs1jymooCdevfJz
         I0JnpALBhcQf3wrc+9N3Gp7gT1lQWcJyADCeM74+N3rUIyA87hopcW1FXC3rJPQ91q3X
         UAkgfcDPHzwbw2c/eTNnyDye5/fjqhsweLLpwGKFGLXJPPye6Ipd7c5eDBtlWcs7Sauh
         z9ZPEZAYIFZHeGqjuEBsZ8ucEw7aMLX9CxAuQJ9zbrQxn6h3vFqLQYpK/aiPAhDlP0iH
         SxER/mcUKQELbJhbdsKFACar54grojN7w8Tn6sNZd5Lszc5OonTouowtSF6d1Da58OZh
         yz6g==
X-Forwarded-Encrypted: i=1; AHgh+RrBILtzVnpOpWt/DDeFYqKN61fGS1PQg39/6NlFuSCDlGXIaA+8Fec6NgWuXCYBisl29/Hsf8E=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lA7OQEOLqUAtzqnrpT8a7cgwablSfOwL6tGfGn/PrqjLvbmM8a
	Rr8WDbgbRr8mLSBnuMAPipomDVRhgxRuuKN2oSdriTWhD5NvgmQj63Tq2MitRTI45T7bNp02bBA
	JbUEzA/MCH4hUv6KN/OD97g==
X-Received: from wmee9.prod.google.com ([2002:a05:600c:2189:b0:49c:e2b5:5573])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3587:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49ce583bc25mr63950535e9.16.1788346266751;
 Wed, 02 Sep 2026 03:51:06 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:02 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902104712.2399797-1-vdonnefort@google.com>
Subject: [PATCH v9 00/10] arm64: Unmap FF-A lent memory from direct map
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org,
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3mv-xagokblui0baa12beg3bb381.zb9bc-g1185fgf.gehfg1025e9jxe1.be3@flex--vdonnefort.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.71:from];
	ARC_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3mv-xagokblui0baa12beg3bb381.zb9bc-g1185fgf.gehfg1025e9jxe1.be3@flex--vdonnefort.bounces.google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.71:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3669A43ECB
X-Spamd-Bar: --
Message-ID-Hash: ODYST2VWM26J4QRADD5SUTYOADYRP6BW
X-Message-ID-Hash: ODYST2VWM26J4QRADD5SUTYOADYRP6BW
X-MailFrom: 3mv-XagoKBlUI0BAA12BEG3BB381.zB9BC-G1185FGF.GEHFG1025E9JxE1.BE3@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ODYST2VWM26J4QRADD5SUTYOADYRP6BW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

This series is a follow-up to the discussion that has started here [1].
While standalone, it also provides primitives reusable for the VPR DMA
heap.

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
for designated memory regions, along with the "arm,ffa-lend-pool" CMA
driver to manage unmapping and remapping on lend/reclaim transitions:

1. memblock & OF reserved memory ("ll-map"):
   - Introduce MEMBLOCK_LLMAP and the DT "ll-map" property for reserved-memory
     nodes to force last-level (PTE) mappings only for a specific region.

2. set_memory infrastructure:
   - Introduce can_set_direct_map_range() to check if a specific address
     range is mapped with last-level entries and can be modified safely.
   - Introduce __set_direct_map_*() variants that bypass redundant checks
     when the caller has already validated the range.

3. "arm,ffa-lend-pool" driver
   - Introduce the "arm,ffa-lend-pool" CMA reserved-memory driver, which
     unmaps pages prior to lending (ffa_prepare_lend()) and restores them
     when reclaimed (ffa_lend_reclaimed()).

4. Optee support
   - Hook OP-TEE dynamic protected memory pools to "arm,ffa-lend-pool" for
     both SMC (via DT memory-region phandle) and FF-A (via
     ffa_lend_pool_attach()) transports.

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

Vincent Donnefort (10):
  memblock: Introduce MEMBLOCK_LLMAP
  of: reserved_mem: Introduce "ll-map" property
  set_memory.h: Introduce can_set_direct_map_range()
  set_memory.h: Introduce __set_direct_map*()
  arm64: can_set_direct_map() if BBML3
  arm64: Implement can_set_direct_map_range()
  arm64: Implement __set_direct_map*()
  arm64: Add support for MEMBLOCK_LLMAP
  firmware: arm_ffa: Introduce ffa-lend-pool
  optee: Add support for arm,ffa-lend-pool

 arch/arm64/include/asm/set_memory.h  |   7 +
 arch/arm64/mm/mmu.c                  |  23 ++-
 arch/arm64/mm/pageattr.c             |  67 +++++++-
 drivers/firmware/arm_ffa/Kconfig     |   5 +
 drivers/firmware/arm_ffa/Makefile    |   1 +
 drivers/firmware/arm_ffa/lend_pool.c | 223 +++++++++++++++++++++++++++
 drivers/of/of_reserved_mem.c         | 104 ++++++++++---
 drivers/tee/optee/ffa_abi.c          |  13 +-
 drivers/tee/optee/protmem.c          |   8 -
 drivers/tee/optee/smc_abi.c          |  17 +-
 drivers/tee/tee_shm.c                |  11 +-
 include/linux/arm_ffa.h              |  21 +++
 include/linux/memblock.h             |   9 ++
 include/linux/set_memory.h           |  39 +++++
 mm/memblock.c                        |  50 ++++++
 15 files changed, 545 insertions(+), 53 deletions(-)
 create mode 100644 drivers/firmware/arm_ffa/lend_pool.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0.970.g62bdec98f9-goog

