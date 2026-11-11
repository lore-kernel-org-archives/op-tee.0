Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CF606A882
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=XfqWAkgk;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FhVSX05I
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F03D5454FF
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794395464;
	bh=FhoUySTa/xE42MaJs91lsEFXMxxFrF3eY81LqgCSXaU=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XfqWAkgk7NNQqelYal4PN418g3rgiULung6CF9m8EZG2o9vTUEKpoddTd+BciiIdC
	 eGKQ5f8koKqMDZhF2UyDE8+QPma696JA9gj+FPFbgyYDBDpDNsM0N0O099HEP60MV4
	 /tj7JJN2Iz5PTpphUabfU+gV9Rj9I+LGE5bNKHCjK1zMGw3Q1dy80lgcSSvPqwhi0O
	 uS8C7xOM1HbeG2SMjR4Jj7mY4P508G0hwghUOhZvKch1S33+mnebfIDrmbjq2quNi6
	 nTquYaQE5ejeT/1mWd3xP+3wOKBwPR5mAi7dKyeaxbKjgTF/jH9y2zOjlJdVsYQ0fl
	 j1WVcqaUD8AGg==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 79E7345507
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 11:08:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FhVSX05I;
	dkim-atps=neutral
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a359c7f47bso26034535e9.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 03:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395308; x=1795000108; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fepHfB0plBo6LzhKi5imbPgE2fv/KA+5u7RqYYS0Pqg=;
        b=FhVSX05Iz4wLFwdBZ/JQ6qW+Tnxc1/9sfQR2PorYt1j/RIQuwY5gDS0ReU6aROPRI/
         KBe6sS8zXHx5o2GZqdTHcL1MdMMslLnA4pLNxvzhKilkghuF/2aUweLVdvVLrd6E29tD
         zXLxkUhCROzvN0WZubIhhAmN1IdpPkitdU7CRTCB6fdk+G9L4u+84Ru314QcXJ7OyAd8
         LbGFVQmgRd4kDMbUvYuYwv7gKxqDRd8rLrXSwrBy0isO8yhy+MpOeERqj+AIGu5jWOmE
         tF4lRQZZmhdYlZjfMYzuimWdzDBKB5d45BqUxjyveHwdH9nLjcHhOzY7jEefIL27T5ms
         sEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395308; x=1795000108;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fepHfB0plBo6LzhKi5imbPgE2fv/KA+5u7RqYYS0Pqg=;
        b=sAs2vRtb2Yoq5gPeHdc33l2cpFz2qEecYF6KFVf9W7lt6lGsPCQSoPlkE6BTD2hm3J
         QtBP11Kumixxb27EBbgD0P2CthpGWbKy1+HdiEJ/liaVc2gGpLuSUaXNroLketZkscTb
         ti5ocjG3x+GKFKdSsN9h9kfx6z3/QELjxfHBdGS/XLMx1xbUVyqxeA2vYNQAlyGWjTao
         Ms0qM6FnR4HEPxxcxheZoK3REOKOm8uGdArYUFOAvn/J+XIGoZEVAevLpRGdpFqu0PJM
         tVQ3/T8jE7bzvoHrLsb6WL+SPnD4XGsOB8i8v1uxU7xNd/rJ5kyDGi3hjGFOzNVwNs08
         TiaA==
X-Forwarded-Encrypted: i=1; AL+hErEBIuR5Ei97F3gSW3T4eWF9aq9O9sOTTp0JhxrcpAheJ2ss8x4nNs8di4Nw0yLQzD6cq/AEp4o=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+gTE3xT98xBtioizjg8VKk6mda9yINycoIdaknVOv0Wl0ntzFt
	er9kyYhHj+PWq7R+shFFJg4Vpr5jhBFCtBA6lfkZCXE1NnwCJyB1b+u4fk/MEl//FrHHW8OJFcA
	tSoUxM4sNvKxN5PQbqvra+Q==
X-Received: from wrtw18.prod.google.com ([2002:a5d:6092:0:b0:496:45d:6be1])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c167:b0:4a1:a6e0:4ce4 with SMTP id 5b1f17b1804b1-4ba093acf6dmr33023215e9.33.1794395307950;
 Wed, 11 Nov 2026 03:08:27 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:35 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-6-vdonnefort@google.com>
Subject: [PATCH v3 5/8] dma-mapping: Introduce lendable-dma-pool
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3q0z0agokbnqnvgffwxgjlyggydw.ugegh-lwwdaklk.ljmklwvxajeosjw.gjy@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20260707];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3q0z0agokbnqnvgffwxgjlyggydw.ugegh-lwwdaklk.ljmklwvxajeosjw.gjy@flex--vdonnefort.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.70:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.70:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 79E7345507
X-Spamd-Bar: /
Message-ID-Hash: 3KZGLK7F3CVY2LTMDKURW5AOV2LK3NYL
X-Message-ID-Hash: 3KZGLK7F3CVY2LTMDKURW5AOV2LK3NYL
X-MailFrom: 3q0z0agoKBnQnVgffWXgjlYggYdW.Ugegh-lWWdaklk.ljmklWVXajeoSjW.gjY@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3KZGLK7F3CVY2LTMDKURW5AOV2LK3NYL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On arm64, when memory is lent to secure world (e.g. via Arm FF-A), fatal
CPU speculative reads can still occur while it retains a cacheable
direct mapping. Introduce the "lendable-dma-pool" reserved-memory CMA
driver with dma_zap_direct_map() and dma_restore_direct_map() to unmap
pages before lending and restore them upon reclaim. Devices use the pool
via "memory-region" or "linux,cma-default":

  reserved-memory {
      #address-cells = <0x2>;
      #size-cells = <0x2>;
      ranges;

      linux,cma {
          compatible = "lendable-dma-pool";
          reusable;
          linux,cma-default;
          size = <0x0 0x4000000>;
      };
  };

If no lendable-dma-pool node is provided, the API falls back to
can_set_direct_map().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 include/linux/dma-map-ops.h |   9 ++
 include/linux/dma-mapping.h |  16 +++
 kernel/dma/Kconfig          |   3 +
 kernel/dma/Makefile         |   1 +
 kernel/dma/lendable.c       | 243 ++++++++++++++++++++++++++++++++++++
 5 files changed, 272 insertions(+)
 create mode 100644 kernel/dma/lendable.c

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index afaf2c12189b..e1d1e8d70855 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -379,6 +379,15 @@ static inline void arch_dma_prep_coherent(struct page *page, size_t size)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
 
+#ifdef CONFIG_DMA_LENDABLE
+int __init arch_dma_mark_lendable(phys_addr_t base, phys_addr_t size);
+bool __init arch_dma_is_lendable(struct page *page, unsigned int nr_pages);
+int arch_dma_zap_direct_map(struct page *page, unsigned int nr_pages,
+			    bool from_lendable);
+int arch_dma_restore_direct_map(struct page *page, unsigned int nr_pages,
+				bool from_lendable);
+#endif /* CONFIG_DMA_LENDABLE */
+
 void *arch_dma_set_uncached(void *addr, size_t size);
 void arch_dma_clear_uncached(void *addr, size_t size);
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index efde0e5a58dc..24239599505d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -511,6 +511,22 @@ void dma_free_pages(struct device *dev, size_t size, struct page *page,
 int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct page *page);
 
+#ifdef CONFIG_DMA_LENDABLE
+int dma_zap_direct_map(struct device *dev, struct page *page, size_t size);
+void dma_restore_direct_map(struct device *dev, struct page *page, size_t size);
+#else
+static inline int dma_zap_direct_map(struct device *dev, struct page *page,
+				     size_t size)
+{
+	return -ENODEV;
+}
+
+static inline void dma_restore_direct_map(struct device *dev, struct page *page,
+					  size_t size)
+{
+}
+#endif /* CONFIG_DMA_LENDABLE */
+
 static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 3830a63ae032..8d65e2daa7d2 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -192,6 +192,9 @@ config DMA_CMA
 
 if  DMA_CMA
 
+config DMA_LENDABLE
+	bool
+
 config DMA_NUMA_CMA
 	bool "Enable separate DMA Contiguous Memory Area for NUMA Node"
 	depends on NUMA
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 6977033444a3..6b257d82bd9b 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_HAS_DMA)			+= mapping.o direct.o
 obj-$(CONFIG_DMA_OPS_HELPERS)		+= ops_helpers.o
 obj-$(CONFIG_ARCH_HAS_DMA_OPS)		+= dummy.o
 obj-$(CONFIG_DMA_CMA)			+= contiguous.o
+obj-$(CONFIG_DMA_LENDABLE)		+= lendable.o
 obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
diff --git a/kernel/dma/lendable.c b/kernel/dma/lendable.c
new file mode 100644
index 000000000000..85ac3ad10df0
--- /dev/null
+++ b/kernel/dma/lendable.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Lendable DMA Contiguous Memory Pool
+ *
+ * Prevents CPU speculative reads to DMA memory (e.g. when lent to a secure
+ * world) by unmapping it from the kernel direct map. This works if the
+ * architecture allows modifying the direct map globally (can_set_direct_map())
+ * or if the memory belongs to a reserved-memory CMA pool compatible with
+ * "lendable-dma-pool".
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#define pr_fmt(fmt) "dma-lendable: " fmt
+
+#include <linux/atomic.h>
+#include <linux/bsearch.h>
+#include <linux/cma.h>
+#include <linux/dma-map-ops.h>
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/set_memory.h>
+#include <linux/sort.h>
+#include <linux/suspend.h>
+
+#include "contiguous.h"
+
+#define DMA_LENDABLE_DISABLED	-1
+
+static struct cma *lendable_areas[MAX_CMA_AREAS] __ro_after_init;
+static unsigned int nr_lendable_areas __ro_after_init;
+static atomic_t dma_lendable_active;
+
+static int __lendable_cmp(const void *a, const void *b)
+{
+	const struct cma *cma_a = *(struct cma * const *)a;
+	const struct cma *cma_b = *(struct cma * const *)b;
+
+	return cmp_int(cma_get_base(cma_a), cma_get_base(cma_b));
+}
+
+static bool cma_is_lendable(struct cma *cma)
+{
+	return cma && bsearch(&cma, lendable_areas, nr_lendable_areas,
+			      sizeof(lendable_areas[0]), __lendable_cmp);
+}
+
+static bool cma_has_range(struct cma *cma, struct page *page, unsigned int nr_pages)
+{
+	phys_addr_t start = page_to_phys(page);
+	phys_addr_t end = start + ((phys_addr_t)nr_pages << PAGE_SHIFT);
+	phys_addr_t base = cma_get_base(cma);
+
+	return start >= base && end <= base + cma_get_size(cma);
+}
+
+/**
+ * dma_zap_direct_map() - Remove a DMA page range from the kernel direct map
+ * @dev:	Device that allocated the pages (or NULL for default CMA pool)
+ * @page:	First page of the memory region
+ * @size:	Page-aligned size of the memory region in bytes
+ *
+ * Cleans and invalidates caches and removes the memory range from the kernel
+ * direct map to prevent speculative CPU accesses. Must be paired with
+ * dma_restore_direct_map().
+ *
+ * Context: Any context if allocated from a lendable pool; process context
+ *          (may sleep) otherwise.
+ * Return:
+ * * 0		- Success.
+ * * -EINVAL	- @size is 0 or not page-aligned.
+ * * -ENODEV	- Direct map cannot be modified and @dev has no lendable pool.
+ * * -EFAULT	- @dev has a lendable pool, but [@page, @page + @size) is
+ *		  outside that pool.
+ * * -EBUSY	- Direct map zapping is temporarily disabled (hibernation).
+ */
+int dma_zap_direct_map(struct device *dev, struct page *page, size_t size)
+{
+	unsigned int nr_pages = size >> PAGE_SHIFT;
+	bool from_lendable, has_lendable;
+	struct cma *cma;
+	int ret;
+
+	if (!size || !PAGE_ALIGNED(size))
+		return -EINVAL;
+
+	cma = dev_get_cma_area(dev);
+	has_lendable = cma_is_lendable(cma);
+	from_lendable = has_lendable && cma_has_range(cma, page, nr_pages);
+
+	if (!from_lendable && !can_set_direct_map())
+		return has_lendable ? -EFAULT : -ENODEV;
+
+	/* Provides full ordering */
+	if (!atomic_add_unless(&dma_lendable_active, 1, DMA_LENDABLE_DISABLED))
+		return -EBUSY;
+
+	ret = arch_dma_zap_direct_map(page, nr_pages, from_lendable);
+	if (ret)
+		atomic_dec(&dma_lendable_active);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dma_zap_direct_map);
+
+/**
+ * dma_restore_direct_map() - Restore a zapped DMA page range in the direct map
+ * @dev:	Device that allocated the pages (or NULL for default CMA pool)
+ * @page:	First page of the memory region
+ * @size:	Page-aligned size of the memory region in bytes
+ *
+ * Restores the default kernel direct mapping and invalidates caches for a range
+ * previously zapped with dma_zap_direct_map().
+ *
+ * Context: Any context if allocated from a lendable pool; process context
+ *          (may sleep) otherwise.
+ */
+void dma_restore_direct_map(struct device *dev, struct page *page, size_t size)
+{
+	unsigned int nr_pages = size >> PAGE_SHIFT;
+	bool from_lendable;
+	struct cma *cma;
+
+	if (WARN_ON_ONCE(!size || !PAGE_ALIGNED(size)))
+		return;
+
+	cma = dev_get_cma_area(dev);
+	from_lendable = cma_is_lendable(cma) && cma_has_range(cma, page, nr_pages);
+
+	if (WARN_ON_ONCE(!from_lendable && !can_set_direct_map()))
+		return;
+
+	if (WARN_ON_ONCE(arch_dma_restore_direct_map(page, nr_pages, from_lendable)))
+		return;
+
+	WARN_ON_ONCE(atomic_dec_return_release(&dma_lendable_active) < 0);
+}
+EXPORT_SYMBOL_GPL(dma_restore_direct_map);
+
+static int dma_lendable_pm_notify(struct notifier_block *nb,
+				  unsigned long mode, void *data)
+{
+	/* Prevent hibernation while unmapped pages may be inaccessible */
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		if (atomic_cmpxchg_acquire(&dma_lendable_active, 0, DMA_LENDABLE_DISABLED))
+			return notifier_from_errno(-EBUSY);
+		break;
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		atomic_cmpxchg(&dma_lendable_active, DMA_LENDABLE_DISABLED, 0);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block dma_lendable_pm_nb = {
+	.notifier_call	= dma_lendable_pm_notify,
+};
+
+static int __init dma_lendable_init(void)
+{
+	unsigned int i, nr = 0;
+
+	for (i = 0; i < nr_lendable_areas; i++) {
+		struct cma *cma = lendable_areas[i];
+
+		if (!arch_dma_is_lendable(phys_to_page(cma_get_base(cma)),
+					  cma_get_size(cma) >> PAGE_SHIFT)) {
+			pr_warn("Ignoring %s: not lendable\n", cma_get_name(cma));
+			continue;
+		}
+
+		lendable_areas[nr++] = cma;
+	}
+	nr_lendable_areas = nr;
+
+	sort(lendable_areas, nr_lendable_areas, sizeof(lendable_areas[0]), __lendable_cmp, NULL);
+
+	register_pm_notifier(&dma_lendable_pm_nb);
+
+	return 0;
+}
+core_initcall(dma_lendable_init);
+
+#ifdef CONFIG_OF_RESERVED_MEM
+static int __init rmem_lendable_validate(unsigned long node,
+					 phys_addr_t *align)
+{
+	return rmem_cma_ops.node_validate(node, align);
+}
+
+static int __init rmem_lendable_fixup(unsigned long node, phys_addr_t base,
+				      phys_addr_t size)
+{
+	int ret = rmem_cma_ops.node_fixup(node, base, size);
+
+	if (ret)
+		return ret;
+
+	return arch_dma_mark_lendable(base, size);
+}
+
+static int __init rmem_lendable_setup(unsigned long node,
+				      struct reserved_mem *rmem)
+{
+	int ret = rmem_cma_ops.node_init(node, rmem);
+
+	if (ret)
+		return ret;
+
+	lendable_areas[nr_lendable_areas++] = rmem->priv;
+
+	return 0;
+}
+
+static int rmem_lendable_device_init(struct reserved_mem *rmem,
+				     struct device *dev)
+{
+	return rmem_cma_ops.device_init(rmem, dev);
+}
+
+static void rmem_lendable_device_release(struct reserved_mem *rmem,
+					 struct device *dev)
+{
+	rmem_cma_ops.device_release(rmem, dev);
+}
+
+static const struct reserved_mem_ops rmem_lendable_ops = {
+	.node_validate	= rmem_lendable_validate,
+	.node_fixup	= rmem_lendable_fixup,
+	.node_init	= rmem_lendable_setup,
+	.device_init	= rmem_lendable_device_init,
+	.device_release	= rmem_lendable_device_release,
+};
+
+RESERVEDMEM_OF_DECLARE(cma_lendable, "lendable-dma-pool", &rmem_lendable_ops);
+#endif /* CONFIG_OF_RESERVED_MEM */
-- 
2.56.0.542.g3ef89b7020-goog

