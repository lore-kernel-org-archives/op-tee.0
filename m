Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D66FC982EE
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:01:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2B6BE454BB
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789988465;
	bh=eN7iTn1wD0hv6E0Nm6zoniYYsyYKikUiM6fMfXhhLZk=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=B0x+sOZWX14ahRmXGPCKWE0LPVnZXrHWRFDZWF9ZtEg7szcjl2Ec1+IiftA5dwHyj
	 ziN6KbduKZS49rN8/GCSLlA0ndj3qjY07bjoJwuwNIpPtMTEYI1ar64CtnIIRqr5a6
	 1bjyoXSlI+08PcrAL8vTCK2UJTwMHnnEVMBOqWM5JhwG9lqTgOSbUEHtn/DG2XUItF
	 pauZzPdiKp/I7SgZ6/3aBAkuD1UYmSdN0byEm4P2Y5ifGcFtTxZtmW+mdZwLWb8woN
	 3HS3jPKcwj7eLf+Zg7qJc/aTNdZfq5Uc0GA/dy47lOYm98Tvfzi2OZH9lgBW/0ykOU
	 u/cxsB36JR97A==
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C00904449D
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 11:00:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=m+94KYFw;
	dkim-atps=neutral
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48589603501so1372009f8f.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 04:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789988456; x=1790593256; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tq21iXQPKKynEPw3Uhq/hZUwml7pvAbpZ0OeTPKe4Go=;
        b=m+94KYFwrgHL5f3clu+fJPFF8gMA/t3IqxtDpFWNb0aHr4eHaNYa6D5plO6CWeb0uv
         illzAtD/kqWYhjPQIZuoCpj4S/7sk/kiz9VpmdLrGxIsgn+RHpaqfaz3WkhamQNAQCGB
         HGFPuGxiKyPj55Vl3j1eCH2MBL68g8mNs8Mu9tZtx/k5ps8EGnnKczDpkso+qOG5eOxB
         s8cQDEM9il7m/31t9TITLHNMPX1mgvKbHYv5sd6db/hOh85HyIQOm2z7YxZ3+6eEJNa/
         FiU9d+K8u8mOmDDxPwRnwIUaf/qtCAUN0Gj4o2G+BAGNnIOX4psA/WRASQdPadUVA2yB
         pTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988456; x=1790593256;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tq21iXQPKKynEPw3Uhq/hZUwml7pvAbpZ0OeTPKe4Go=;
        b=iTqRSnJb6HdSRPaCBuT+MgqPnGEZF2yUi7Li8/Ybr8NIjnrNAbklcIo7bbJuPLZRmO
         nvXbK1+iJwrRj5bRqao2jGlNSusotwDKINrM2sebISsnBRQTj73nkftJa6vMC5PqmkvV
         hm+4FgtuviM4sakgpqf/eP1I9+oKE7PAgQREeu8vmrCgQFuUnQSVoC+CgxNk7NoEgCsk
         f8MsCZF9lRVEnlB5OXbGoo/+r298HEz8PWi7HrCtSvNnUutQ2xZjxzj52dW/s0hMKxPu
         C/LIO3nCS9Cam4utZKw9FOHftfTlI3lgfyjNWWeo3DDwYEhckBwgUZJHtt5V9aGgO2bX
         +TMg==
X-Forwarded-Encrypted: i=1; AKwUvBxKi3gjw7HV0Q3dyGZABW5YnzKmXkY0phTNG/s5N+9kPEOeOMM93rj9AB749X+Yjd3YfeHyJ6o=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kDrfS56AY9vAHo+9i09oIolEOWez8BITpyEy7/3u8UhQVC+qj3
	prExdfrDci1gAqDXGYT/m4TaIqM2oXPux2wQDzcirH4xQ5aWAu/YIlv4mwAn3nJZXLcU0aAKylp
	bK/4YALimXvELlJ7IJjMHDA==
X-Received: from wrbep8.prod.google.com ([2002:a05:6000:42c8:b0:488:5ffc:4b74])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6f05:0:b0:487:10b6:1ce2 with SMTP id ffacd0b85a97d-4871e2158d7mr13645670f8f.1.1789988455971;
 Mon, 21 Sep 2026 04:00:55 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:00:42 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921110050.3977591-1-vdonnefort@google.com>
Subject: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3zw6xagokbqqzhsrrijsvxksskpi.gsqst-xiipmwxw.xvywxihjmvqaevi.svk@flex--vdonnefort.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.70:from];
	ARC_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3zw6xagokbqqzhsrrijsvxksskpi.gsqst-xiipmwxw.xvywxihjmvqaevi.svk@flex--vdonnefort.bounces.google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.70:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C00904449D
X-Spamd-Bar: --
Message-ID-Hash: GLNSGRZPWUBQ6YQJ452FZ7GIBU6HP2PN
X-Message-ID-Hash: GLNSGRZPWUBQ6YQJ452FZ7GIBU6HP2PN
X-MailFrom: 3Zw6xagoKBqQZHSRRIJSVXKSSKPI.GSQST-XIIPMWXW.XVYWXIHJMVQaEVI.SVK@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GLNSGRZPWUBQ6YQJ452FZ7GIBU6HP2PN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

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
for designated memory regions, along with the "arm,ffa-lend-pool" CMA
driver to manage unmapping and remapping on lend/reclaim transitions:

1. memblock:
   - Introduce MEMBLOCK_PTEMAP to force PTE mappings only for a specific region.

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

Changelog:

v2:
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
  arm64: Introduce can_set_direct_map_range()
  arm64: Introduce __set_direct_map*()
  arm64: Add support for MEMBLOCK_PTEMAP
  firmware: arm_ffa: Introduce ffa-lend-pool
  optee: Add support for arm,ffa-lend-pool
  dt-bindings: reserved-memory: Add Arm FF-A lend pool
  dt-bindings: firmware: optee: Add memory-region property

 .../arm/firmware/linaro,optee-tz.yaml         |   5 +
 .../reserved-memory/arm,ffa-lend-pool.yaml    |  55 ++++
 arch/arm64/include/asm/set_memory.h           |   7 +
 arch/arm64/mm/mmu.c                           |  23 +-
 arch/arm64/mm/pageattr.c                      |  72 ++++-
 drivers/firmware/arm_ffa/Kconfig              |   5 +
 drivers/firmware/arm_ffa/Makefile             |   1 +
 drivers/firmware/arm_ffa/lend_pool.c          | 261 ++++++++++++++++++
 drivers/tee/optee/Makefile                    |   1 +
 drivers/tee/optee/core.c                      |   6 +
 drivers/tee/optee/ffa_abi.c                   |  13 +-
 drivers/tee/optee/ffa_lend_pool.c             |  72 +++++
 drivers/tee/optee/optee_private.h             |   4 +
 drivers/tee/optee/protmem.c                   |  20 +-
 drivers/tee/optee/smc_abi.c                   |  21 +-
 include/linux/arm_ffa.h                       |  23 ++
 include/linux/memblock.h                      |  18 ++
 mm/memblock.c                                 |  30 ++
 18 files changed, 608 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/arm,ffa-lend-pool.yaml
 create mode 100644 drivers/firmware/arm_ffa/lend_pool.c
 create mode 100644 drivers/tee/optee/ffa_lend_pool.c


base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
-- 
2.55.0.1082.g2b9226bbc0-goog

