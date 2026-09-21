Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACBDC982EE
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:03:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 972914537F
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789988612;
	bh=TPX36FUUUvbKFKPQ58T2rMiYjcSbT6IYNeh8EC+IoXs=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=syFHLi8PD68OlZdZPzpQZp3zrLp251dHjsMagOGY5ZCljsD83M5Kw3upWyHV6Fja0
	 V2FS46s7eB3aOQYvNDoV2tcbCVXQ5vBYQloBcUFHR5wtY+fGScJ1mEgK1fBTdGsppj
	 YPOF9PXACvTobvTAeni81eTp2Qb7Zm0xa84ltloiXW0imhZF6gUPhU6sISQdAwUrRn
	 BVWSNS/FvhpYNPqmqvm6bR1mgp74bni57+CLH+TkSrYz3oHylJcyaEx6al8jE6HaTa
	 9MHmeRRssFoDGVbnIiU3vLFWSWSzkzNPY74oGK6heB8jfH5uR2IIEMp7L3FEKLROpc
	 Lhbp8joKcOpZg==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E158A4541D
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 11:01:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p3uJszuP;
	dkim-atps=neutral
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29452ecadeso327898066b.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789988463; x=1790593263; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mS8QTe3O0YSNViqoUNLsYRtEn1B1+bnqRzNqyeLclGU=;
        b=p3uJszuPBblu2kgOvcNqKcyJjrfrWAAppxqJPu+8OrlxXws4dMUYe7+brgAIDX1L6w
         lxyjWOVIdqpMCsAWd+iHWzklKPJaEGY4KkKo6Q2YW5XZ0/sR++UcnFgfGdNe5IZtDzPZ
         fAV0sC+mSZXuC0PnoccL8x/SMo2+aVZOCfvzje78E9ylyN54f6VvwhGkYELsrr9kfhUW
         BVmFVNQHjvmYSvjngDe/dTjA//XvT+VeujKAViFttaArq6s4PH3pjq6vviMo7pSrloNW
         wmGU6ERU2ncwEbaIvx9ATd8yMddSLPJNsvPUcEyTjsdoNjSBXbcP24bRzOXe/bcfQ2uT
         jeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988463; x=1790593263;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mS8QTe3O0YSNViqoUNLsYRtEn1B1+bnqRzNqyeLclGU=;
        b=i2LvCSXqv9J//HfecdJXXoXD3V/xohje+Owt2MrWBAEZ10ul+vkmSXQxqYvhuaXvCF
         mYCS2I1BPeo3BxEyrARUeeMPa5C/mWHIck+BttlUE3cn1gil4qqUY1tu1vgrCFcdLH4X
         4M5aAudsFBn0NLJcxyjSGkaRNAhEsqzt5o0G82K/xOMb6C76XsmIKA1pl54nU4053QqP
         T50FUrwH76I8Ls3uI6+wn0HZMKmv+7tgvkPKdTovzT9ZO1XjLRry+wJcTy1q/b9gwquw
         lL6aungyuAfdYAqXJdZott1C4+6uA4aSBS8NXqZYqcRAxvLdmI859YwAwAaVxsHVfOpH
         azbA==
X-Forwarded-Encrypted: i=1; AKwUvBziWVop55OccS99o5fFMb84AIEGOzr88Rb83tYDk5djqJh6JhCewkjiz/EWNlKesbhwILrtvMA=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mN29OjpJ9qDV2jhNNaZaX/E+yt1Ca5IuRSXETmD1Pr9kedyRiA
	6mwSlxYuaQOkl7tb97DNk1/ZEqTidu1Z8vbhco73xCdoiyBkkDLDMZjE39/vOrBhK7+cBKnT6/9
	iDNZLfqSj9xlFCF+r0cDrWw==
X-Received: from ejbmb16.prod.google.com ([2002:a17:906:eb10:b0:c25:46b8:4594])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:94cd:b0:c29:3ea4:a219 with SMTP id a640c23a62f3a-c2a15eb3513mr916572766b.44.1789988462315;
 Mon, 21 Sep 2026 04:01:02 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:00:47 +0100
In-Reply-To: <20260921110050.3977591-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260921110050.3977591-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921110050.3977591-6-vdonnefort@google.com>
Subject: [PATCH v2 5/8] firmware: arm_ffa: Introduce ffa-lend-pool
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org,
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3bg6xagokbqsgozyypqzcerzzrwp.nzxza-eppwtded.ecfdepoqtcxhlcp.zcr@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.72:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3bg6xagokbqsgozyypqzcerzzrwp.nzxza-eppwtded.ecfdepoqtcxhlcp.zcr@flex--vdonnefort.bounces.google.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.218.72:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E158A4541D
X-Spamd-Bar: --
Message-ID-Hash: TQ4G7ZCQWVKITIRF2J4EM6VO5MZVAX2U
X-Message-ID-Hash: TQ4G7ZCQWVKITIRF2J4EM6VO5MZVAX2U
X-MailFrom: 3bg6xagoKBqsgOZYYPQZceRZZRWP.NZXZa-ePPWTded.ecfdePOQTcXhLcP.ZcR@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TQ4G7ZCQWVKITIRF2J4EM6VO5MZVAX2U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

When memory is lent to the Secure world via FF-A, fatal CPU speculative
reads from Non-Secure can still occur as long as it retains a cacheable
mapping to that memory. Introduce the "arm,ffa-lend-pool"
reserved-memory CMA driver to unmap pages before lending
(ffa_prepare_lend()) and restore them upon reclaim
(ffa_lend_reclaimed()). Devices bind to the pool via the "memory-region"
DT property or via ffa_lend_pool_attach().

  reserved-memory {
      #address-cells = <0x2>;
      #size-cells = <0x2>;
      ranges;

      ffa_lend: ffa-lend-pool {
          compatible = "arm,ffa-lend-pool";
          reusable;
          size = <0x0 0x4000000>;
      };
  };

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 drivers/firmware/arm_ffa/Kconfig     |   5 +
 drivers/firmware/arm_ffa/Makefile    |   1 +
 drivers/firmware/arm_ffa/lend_pool.c | 261 +++++++++++++++++++++++++++
 include/linux/arm_ffa.h              |  23 +++
 4 files changed, 290 insertions(+)
 create mode 100644 drivers/firmware/arm_ffa/lend_pool.c

diff --git a/drivers/firmware/arm_ffa/Kconfig b/drivers/firmware/arm_ffa/Kconfig
index 5e3ae5cf82e8..66dbf74c37c3 100644
--- a/drivers/firmware/arm_ffa/Kconfig
+++ b/drivers/firmware/arm_ffa/Kconfig
@@ -19,3 +19,8 @@ config ARM_FFA_SMCCC
 	bool
 	default ARM_FFA_TRANSPORT
 	depends on ARM64 && HAVE_ARM_SMCCC_DISCOVERY
+
+config ARM_FFA_LEND_POOL
+	bool
+	default y
+	depends on ARM_FFA_TRANSPORT && CMA && OF_RESERVED_MEM
diff --git a/drivers/firmware/arm_ffa/Makefile b/drivers/firmware/arm_ffa/Makefile
index 168990a7e792..5ea3019c407b 100644
--- a/drivers/firmware/arm_ffa/Makefile
+++ b/drivers/firmware/arm_ffa/Makefile
@@ -6,3 +6,4 @@ ffa-core-objs := $(ffa-bus-y)
 ffa-module-objs := $(ffa-driver-y) $(ffa-transport-y)
 obj-$(CONFIG_ARM_FFA_TRANSPORT)  = ffa-core.o
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += ffa-module.o
+obj-$(CONFIG_ARM_FFA_LEND_POOL) += lend_pool.o
diff --git a/drivers/firmware/arm_ffa/lend_pool.c b/drivers/firmware/arm_ffa/lend_pool.c
new file mode 100644
index 000000000000..e4348f5c618b
--- /dev/null
+++ b/drivers/firmware/arm_ffa/lend_pool.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Arm FF-A Reserved Memory CMA driver for Memory Lending
+ *
+ * Prevents CPU speculative reads to secure memory by unmapping it from the
+ * kernel direct map. This works if rodata=full or if all CPUs in the system
+ * support BBML3 or if a reserved-memory is declared for this driver
+ * "arm,ffa_lend_pool".
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <linux/arm_ffa.h>
+#include <linux/cleanup.h>
+#include <linux/cma.h>
+#include <linux/dma-map-ops.h>
+#include <linux/init.h>
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/rcupdate.h>
+#include <linux/suspend.h>
+#include <linux/set_memory.h>
+#include <linux/xarray.h>
+
+#include <linux/cacheflush.h>
+#include <asm/tlbflush.h>
+
+static DEFINE_XARRAY(ffa_lend_pool_devices);
+static atomic_t ffa_lend_pool_active;
+
+#define FFA_LEND_POOL_DISABLED	-1
+
+static bool ffa_lend_pool_can_set_direct_map(struct device *dev, struct page *page, u64 nr_pages)
+{
+	phys_addr_t addr, base, end;
+	size_t size;
+
+	if (can_set_direct_map())
+		return true;
+
+	if (!dev)
+		return false;
+
+	guard(rcu)();
+
+	if (xa_load(&ffa_lend_pool_devices, (unsigned long)dev) != dev)
+		return false;
+
+	if (WARN_ON_ONCE(!dev->cma_area))
+		return false;
+
+	addr = page_to_phys(page);
+	size = nr_pages << PAGE_SHIFT;
+	base = cma_get_base(dev->cma_area);
+	end = base + cma_get_size(dev->cma_area);
+
+	return addr >= base && (addr + size) <= end;
+}
+
+/**
+ * ffa_prepare_lend() - Prepare a memory region to be lent in FF-A
+ * @dev:	Device attached to the lend pool
+ * @page:	First page of the memory region
+ * @nr_pages:	Number of pages
+ *
+ * When memory is lent via FF-A, TrustZone transitions it to the secure state.
+ * As long as Arm CPUs retain a valid mapping to that now-secure memory, they
+ * can speculatively read it, which is fatal on some systems.
+ *
+ * ffa_prepare_lend() prevents this by unmapping the memory range from the
+ * kernel's direct map.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int ffa_prepare_lend(struct device *dev, struct page *page, u64 nr_pages)
+{
+	struct page *p, *end;
+	unsigned long addr;
+	int ret;
+
+	if (!ffa_lend_pool_can_set_direct_map(dev, page, nr_pages))
+		return -ENODEV;
+
+	/* provides full ordering */
+	if (!atomic_add_unless(&ffa_lend_pool_active, 1, FFA_LEND_POOL_DISABLED))
+		return -EBUSY;
+
+	end = page + nr_pages;
+	for (p = page; p < end; p++)
+		flush_dcache_page(p);
+
+	ret = __set_direct_map_invalid_noflush(page, nr_pages);
+	if (ret) {
+		atomic_dec(&ffa_lend_pool_active);
+		return ret;
+	}
+
+	addr = (unsigned long)page_address(page);
+	flush_tlb_kernel_range(addr, addr + (nr_pages << PAGE_SHIFT));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ffa_prepare_lend);
+
+/**
+ * ffa_lend_reclaimed() - Restore a reclaimed FF-A memory region
+ * @dev:	Device attached to the lend pool
+ * @page:	First page of the memory region
+ * @nr_pages:	Number of pages
+ *
+ * Restores a memory range into the kernel's direct mapping. It must be called
+ * after a successful FF-A memory reclaim invocation.
+ */
+void ffa_lend_reclaimed(struct device *dev, struct page *page, u64 nr_pages)
+{
+	if (!ffa_lend_pool_can_set_direct_map(dev, page, nr_pages))
+		return;
+
+	__set_direct_map_default_noflush(page, nr_pages);
+
+	atomic_dec_return_release(&ffa_lend_pool_active);
+}
+EXPORT_SYMBOL_GPL(ffa_lend_reclaimed);
+
+static int ffa_lend_pool_pm_notify(struct notifier_block *nb, unsigned long mode, void *data)
+{
+	/* Prevent hibernation which would try to access lent memory */
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+		if (atomic_cmpxchg_acquire(&ffa_lend_pool_active, 0, FFA_LEND_POOL_DISABLED))
+			return notifier_from_errno(-EBUSY);
+		break;
+	case PM_POST_HIBERNATION:
+		atomic_set(&ffa_lend_pool_active, 0);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ffa_lend_pool_pm_nb = {
+	.notifier_call	= ffa_lend_pool_pm_notify,
+};
+
+static const struct reserved_mem_ops ffa_lend_pool_ops;
+
+static struct reserved_mem *ffa_lend_pool_get_rmem(void)
+{
+	struct reserved_mem *rmem;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,ffa-lend-pool");
+	if (!np)
+		return NULL;
+
+	rmem = of_reserved_mem_lookup(np);
+	of_node_put(np);
+
+	if (WARN_ON_ONCE(rmem && rmem->ops != &ffa_lend_pool_ops))
+		return NULL;
+
+	return rmem;
+}
+
+/**
+ * ffa_lend_pool_attach() - Attach a device to the FF-A lend pool
+ * @dev:	Device to attach
+ *
+ * FF-A devices are dynamically discovered and might not have an associated
+ * device tree node with a "memory-region" phandle. In that case, drivers must
+ * use this function to attach to the "arm,ffa-lend-pool" reserved memory
+ * region.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int ffa_lend_pool_attach(struct device *dev)
+{
+	struct reserved_mem *rmem = ffa_lend_pool_get_rmem();
+
+	return rmem ? rmem->ops->device_init(rmem, dev) : -ENODEV;
+}
+EXPORT_SYMBOL_GPL(ffa_lend_pool_attach);
+
+/**
+ * ffa_lend_pool_detach() - Detach a device from the FF-A lend pool
+ * @dev:	Device to detach
+ *
+ * Releases the device from the "arm,ffa-lend-pool" reserved memory region.
+ */
+void ffa_lend_pool_detach(struct device *dev)
+{
+	struct reserved_mem *rmem = ffa_lend_pool_get_rmem();
+
+	if (rmem)
+		rmem->ops->device_release(rmem, dev);
+}
+EXPORT_SYMBOL_GPL(ffa_lend_pool_detach);
+
+static int __init ffa_lend_pool_setup(unsigned long node, struct reserved_mem *rmem)
+{
+	struct cma *cma;
+	int ret;
+
+	/* Limited by ffa_lend_pool_active */
+	if (rmem->size / PAGE_SIZE > INT_MAX)
+		return -E2BIG;
+
+	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
+		pr_err("FF-A lend pool: incorrect alignment of CMA region\n");
+		return -EINVAL;
+	}
+
+	ret = memblock_mark_ptemap(rmem->base, rmem->size);
+	if (ret)
+		return ret;
+
+	ret = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
+	if (ret) {
+		pr_err("FF-A lend pool: unable to setup CMA region (%d)\n", ret);
+		memblock_clear_ptemap(rmem->base, rmem->size);
+		return ret;
+	}
+
+	register_pm_notifier(&ffa_lend_pool_pm_nb);
+	rmem->priv = cma;
+
+	return 0;
+}
+
+static int ffa_lend_pool_device_init(struct reserved_mem *rmem, struct device *dev)
+{
+	int ret;
+
+	if (!can_set_direct_map_range(pfn_to_page(PHYS_PFN(rmem->base)), rmem->size / PAGE_SIZE)) {
+		pr_err("FF-A lend pool: reserved memory cannot be unmapped in direct map\n");
+		return -EINVAL;
+	}
+
+	dev->cma_area = rmem->priv;
+
+	ret = xa_err(xa_store(&ffa_lend_pool_devices, (unsigned long)dev, dev, GFP_KERNEL));
+	if (ret)
+		dev->cma_area = NULL;
+
+	return ret;
+}
+
+static void ffa_lend_pool_device_release(struct reserved_mem *rmem, struct device *dev)
+{
+	xa_erase(&ffa_lend_pool_devices, (unsigned long)dev);
+	dev->cma_area = NULL;
+}
+
+static const struct reserved_mem_ops ffa_lend_pool_ops = {
+	.node_init	= ffa_lend_pool_setup,
+	.device_init	= ffa_lend_pool_device_init,
+	.device_release = ffa_lend_pool_device_release,
+};
+RESERVEDMEM_OF_DECLARE(ffa_lend_pool, "arm,ffa-lend-pool", &ffa_lend_pool_ops);
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index e71d83ee0aef..8608847931cc 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -519,4 +519,27 @@ struct ffa_ops {
 	const struct ffa_notifier_ops *notifier_ops;
 };
 
+struct page;
+
+#if IS_ENABLED(CONFIG_ARM_FFA_LEND_POOL)
+int ffa_lend_pool_attach(struct device *dev);
+void ffa_lend_pool_detach(struct device *dev);
+int ffa_prepare_lend(struct device *dev, struct page *page, u64 nr_pages);
+void ffa_lend_reclaimed(struct device *dev, struct page *page, u64 nr_pages);
+#else
+static inline int ffa_lend_pool_attach(struct device *dev)
+{
+	return -ENODEV;
+}
+static inline void ffa_lend_pool_detach(struct device *dev)
+{
+}
+static inline int ffa_prepare_lend(struct device *dev, struct page *page, u64 nr_pages)
+{
+	return -ENODEV;
+}
+static inline void ffa_lend_reclaimed(struct device *dev, struct page *page, u64 nr_pages)
+{
+}
+#endif
 #endif /* _LINUX_ARM_FFA_H */
-- 
2.55.0.1082.g2b9226bbc0-goog

