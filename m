Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEEAC982E1
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:04:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 04A9E44F26
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789988641;
	bh=crSJB8mHimPQYUC2eGv0NrncV7UaIOvRQXYK9SxofUo=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jwsfcQQ0iDgeZ6fsX7HleZrR1ujxbCD1WDYrjayPO2tw4i+wCOp9iTK45yd8FXeR4
	 FPq7QDYGO+bxrNVmJubC67mPHBp0KYv/NE2gii2L3qWFJJJwsQfIFhQbJk0YRFbHz7
	 P0iAU3cCnMEIpud+4vpVFURGrtXjVhouGPz1uDNKiTD5AjpuBlPH9I/87nhrnThRSK
	 Wr6PBILF9I5QB8sS0TE+0nOUbvau4hWDU8twhPXf33FyN7d9RRT2POQ6eicheFYtdi
	 dyiC+JFECGGcpUS4M/W78jslACJEAX6BedXgXlHzD02n88XW8PotOptCJU04sv9+F4
	 MhX0SRGnXRiAw==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AA6EA45418
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 11:01:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OsI6b2ki;
	dkim-atps=neutral
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e73659ac5so41375905e9.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789988463; x=1790593263; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cvjbTKhoGU/dDzLNariOWDtPZWx05brpq3W1pqMLn2I=;
        b=OsI6b2kiqj0EsSNxAstlB2C9tsDxNAsDt9jd4UqnVoLlPyu2mnuo6vxcry00s5clQV
         k+u8JaD+eBimckeNKJFJwq6T+5BRfS6Dqi3Tg6T4COjexPC0jC6HTxye9ShXZ1F3GpYz
         i/bE7AOtMTcphNwCrmvjfOrOg+5vAeMBkiVpiZ4x+nTr4QPmMnOL4fbOKgxaa4tdahct
         1xeStcMzG5kuIaCcFu8YN7fJOu3o1bAsR+QzhdhmHTMhfNwkFy8fKHjeXUfyJTUzRcFk
         QDJYDgD89D6+Uu6GpBgPnsh3V7mH9eipbyyA3sya5PMoeYyrZ+IpkC58MJeOEqeCXwaz
         rYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988463; x=1790593263;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cvjbTKhoGU/dDzLNariOWDtPZWx05brpq3W1pqMLn2I=;
        b=iBrBOkyMwjogolfvXQMmI5aSw2ZdypoZkohFsL5diosUbM8kqH3Wpz/HjMuqCpIXg6
         updLk4/dPwVCISntipdPFl15EvyEAa3OMgem4/Sjdsjmw05ciGp3Et3GKp47TabEz/xs
         sOejOGfguUNyZpVXl0ydL8I8HD/yknqlC2yacZdmTH7gsPVtjv8WS7eGKB8Pv+294qWw
         aRoNWoWvqEcq05S3b+v4NUcvBXP+uRu4bXhQE46M9Hf/uNAFETyXOd7p0dc7lp8LKHZ8
         BOGDEOX3rhiRvQ+xLcKnzhEDBeQgS8MqowoICNUA3vkvTEQCicR0vI5IVzxZJI9HhTBe
         HCpg==
X-Forwarded-Encrypted: i=1; AKwUvBym3pIbYR6O3SQjzjcrInFj9/WDZc4oa1uYCEHMgx7Hamc675DQ7s2H/VlVs+meqO3U1Fb6LqI=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++m49tddEWnGjEHMBfmJopihUtFn7yGhN1z4emtMDmTZtmrw3g/2
	tIooF2OTscVXQjhn9wx4KoI8giTpYaru+bhxYHXJWIfCc+xseMUoWEvVZ1JQFFEFUdY1if6vBiy
	4ULTVm3YlRzj1B5qkLp5HZA==
X-Received: from wmix8-n2.prod.google.com ([2002:a05:600c:e548:20b0:49d:2730:73de])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d25:b0:49f:d753:3de9 with SMTP id 5b1f17b1804b1-49fd7533df5mr5289235e9.33.1789988463507;
 Mon, 21 Sep 2026 04:01:03 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:00:48 +0100
In-Reply-To: <20260921110050.3977591-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260921110050.3977591-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921110050.3977591-7-vdonnefort@google.com>
Subject: [PATCH v2 6/8] optee: Add support for arm,ffa-lend-pool
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org,
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3bw6xagokbqwhpazzqradfsaasxq.oayab-fqqxuefe.fdgefqprudyimdq.ads@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.70:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3bw6xagokbqwhpazzqradfsaasxq.oayab-fqqxuefe.fdgefqprudyimdq.ads@flex--vdonnefort.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.70:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AA6EA45418
X-Spamd-Bar: --
Message-ID-Hash: DE6FC5N5NTJYWI5QIHXT3S7XJWBGU5DJ
X-Message-ID-Hash: DE6FC5N5NTJYWI5QIHXT3S7XJWBGU5DJ
X-MailFrom: 3bw6xagoKBqwhPaZZQRadfSaaSXQ.OaYab-fQQXUefe.fdgefQPRUdYiMdQ.adS@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DE6FC5N5NTJYWI5QIHXT3S7XJWBGU5DJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

Hook OP-TEE dynamically allocated protected memory pools to the
"arm,ffa-lend-pool" driver. While the SMC transport platform device
resolves the pool through its DT "memory-region" property, the FF-A
transport lacks a device tree node and binds via ffa_lend_pool_attach().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 drivers/tee/optee/Makefile        |  1 +
 drivers/tee/optee/core.c          |  6 +++
 drivers/tee/optee/ffa_abi.c       | 13 +++++-
 drivers/tee/optee/ffa_lend_pool.c | 72 +++++++++++++++++++++++++++++++
 drivers/tee/optee/optee_private.h |  4 ++
 drivers/tee/optee/protmem.c       | 20 +++++----
 drivers/tee/optee/smc_abi.c       | 21 ++++++---
 7 files changed, 121 insertions(+), 16 deletions(-)
 create mode 100644 drivers/tee/optee/ffa_lend_pool.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index ad7049c1c107..4986d863b9f7 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -9,6 +9,7 @@ optee-objs += supp.o
 optee-objs += device.o
 optee-objs += smc_abi.o
 optee-objs += ffa_abi.o
+optee-objs += ffa_lend_pool.o
 
 # for tracing framework to find optee_trace.h
 CFLAGS_smc_abi.o := -I$(src)
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a52c1f498b99..39f315cea830 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -201,6 +201,12 @@ void optee_remove_common(struct optee *optee)
 	/* Unregister OP-TEE specific client devices on TEE bus */
 	optee_unregister_devices();
 
+	/*
+	 * Must follow optee_unregister_devices(). Clients require the lend pool
+	 * linkage to successfully free their memory.
+	 */
+	optee_lend_pool_unregister(optee);
+
 	optee_notif_uninit(optee);
 	optee_shm_arg_cache_uninit(optee);
 	teedev_close_context(optee->ctx);
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 633715b98625..e979dbc9a547 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -1042,13 +1042,21 @@ static int optee_ffa_protmem_pool_init(struct optee *optee, u32 sec_caps)
 	int rc = 0;
 
 	if (sec_caps & OPTEE_FFA_SEC_CAP_PROTMEM) {
+		rc = optee_lend_pool_register(optee);
+		if (rc)
+			return rc;
+
 		pool = optee_protmem_alloc_dyn_pool(optee, id);
-		if (IS_ERR(pool))
+		if (IS_ERR(pool)) {
+			optee_lend_pool_unregister(optee);
 			return PTR_ERR(pool);
+		}
 
 		rc = tee_device_register_dma_heap(optee->teedev, id, pool);
-		if (rc)
+		if (rc) {
+			optee_lend_pool_unregister(optee);
 			pool->ops->destroy_pool(pool);
+		}
 	}
 
 	return rc;
@@ -1172,6 +1180,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 err_unregister_devices:
 	optee_unregister_devices();
+	optee_lend_pool_unregister(optee);
 	if (optee->ffa.bottom_half_value != U32_MAX)
 		notif_ops->notify_relinquish(ffa_dev,
 					     optee->ffa.bottom_half_value);
diff --git a/drivers/tee/optee/ffa_lend_pool.c b/drivers/tee/optee/ffa_lend_pool.c
new file mode 100644
index 000000000000..b865c37efd5a
--- /dev/null
+++ b/drivers/tee/optee/ffa_lend_pool.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support for the arm,ffa-lend-pool, unmaps lent memory from the host stage-1
+ * to mitigate for CPU speculative read of Secure memory
+ *
+ * Copyright (C) 2026 Google LLC.
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <linux/arm_ffa.h>
+#include <linux/errno.h>
+#include <linux/of_reserved_mem.h>
+
+#include "optee_private.h"
+
+static struct device_node *optee_dev_node(struct optee *optee)
+{
+	return dev_of_node(optee->teedev->dev.parent);
+}
+
+static struct device *optee_device(struct optee *optee)
+{
+	return &optee->teedev->dev;
+}
+
+static int optee_lend_pool_err(int err)
+{
+	/*
+	 * Registration of the arm,ffa-lend-pool reserved-memory is optional as
+	 * another (although less performant) stage-2 mitigation might be in
+	 * place.
+	 */
+	if (err == -ENODEV)
+		return 0;
+
+	return err;
+}
+
+int optee_lend_pool_register(struct optee *optee)
+{
+	struct device_node *np = optee_dev_node(optee);
+	struct device *dev = optee_device(optee);
+	int ret;
+
+	if (np)
+		ret = of_reserved_mem_device_init_by_idx(dev, np, 0);
+	else
+		ret = ffa_lend_pool_attach(dev);
+
+	return optee_lend_pool_err(ret);
+}
+
+void optee_lend_pool_unregister(struct optee *optee)
+{
+	struct device_node *np = optee_dev_node(optee);
+	struct device *dev = optee_device(optee);
+
+	if (np)
+		of_reserved_mem_device_release(dev);
+	else
+		ffa_lend_pool_detach(dev);
+}
+
+int optee_lend_pool_prepare(struct optee *optee, struct page *page, u64 nr_pages)
+{
+	return optee_lend_pool_err(ffa_prepare_lend(optee_device(optee), page, nr_pages));
+}
+
+void optee_lend_pool_reclaimed(struct optee *optee, struct page *page, u64 nr_pages)
+{
+	ffa_lend_reclaimed(optee_device(optee), page, nr_pages);
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index aefe1e6f5689..f26723e81573 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -325,6 +325,10 @@ void optee_supp_uninit(struct optee_supp *supp);
 void optee_supp_release(struct optee_supp *supp);
 struct tee_protmem_pool *optee_protmem_alloc_dyn_pool(struct optee *optee,
 						      enum tee_dma_heap_id id);
+int optee_lend_pool_register(struct optee *optee);
+void optee_lend_pool_unregister(struct optee *optee);
+int optee_lend_pool_prepare(struct optee *optee, struct page *page, u64 nr_pages);
+void optee_lend_pool_reclaimed(struct optee *optee, struct page *page, u64 nr_pages);
 
 int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		    struct tee_param *param);
diff --git a/drivers/tee/optee/protmem.c b/drivers/tee/optee/protmem.c
index be3abf6e8aa6..b8ee372d20c0 100644
--- a/drivers/tee/optee/protmem.c
+++ b/drivers/tee/optee/protmem.c
@@ -42,19 +42,16 @@ static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
 		goto err_null_protmem;
 	}
 
-	/*
-	 * TODO unmap the memory range since the physical memory will
-	 * become inaccesible after the lend_protmem() call.
-	 *
-	 * If the platform supports a hypervisor at EL2, it will unmap the
-	 * intermediate physical memory for us and stop cache pre-fetch of
-	 * the memory.
-	 */
+	rc = optee_lend_pool_prepare(rp->optee, phys_to_page(rp->protmem->paddr),
+				     rp->page_count);
+	if (rc)
+		goto err_put_shm;
+
 	rc = rp->optee->ops->lend_protmem(rp->optee, rp->protmem,
 					  rp->mem_attrs,
 					  rp->mem_attr_count, rp->use_case);
 	if (rc)
-		goto err_put_shm;
+		goto err_lend_pool_reclaimed;
 	rp->protmem->flags |= TEE_SHM_DYNAMIC;
 
 	rp->gen_pool = gen_pool_create(PAGE_SHIFT, -1);
@@ -76,6 +73,9 @@ static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
 	rp->gen_pool = NULL;
 err_reclaim:
 	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
+err_lend_pool_reclaimed:
+	optee_lend_pool_reclaimed(rp->optee, phys_to_page(rp->protmem->paddr),
+				  rp->page_count);
 err_put_shm:
 	tee_shm_put(rp->protmem);
 err_null_protmem:
@@ -112,6 +112,8 @@ static void release_dyn_protmem(struct optee_protmem_dyn_pool *rp)
 	rp->gen_pool = NULL;
 
 	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
+	optee_lend_pool_reclaimed(rp->optee, phys_to_page(rp->protmem->paddr),
+				  rp->page_count);
 	rp->protmem->flags &= ~TEE_SHM_DYNAMIC;
 
 	WARN(refcount_read(&rp->protmem->refcount) != 1, "Unexpected refcount");
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index b8a2bdac3208..e46eb881cf90 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1522,7 +1522,6 @@ static void optee_smc_remove(struct platform_device *pdev)
 		optee_disable_shm_cache(optee);
 
 	optee_smc_notif_uninit_irq(optee);
-
 	optee_remove_common(optee);
 
 	if (optee->smc.memremaped_shm)
@@ -1714,14 +1713,25 @@ static int optee_protmem_pool_init(struct optee *optee)
 
 	if (protm)
 		pool = static_protmem_pool_init(optee);
-	if (dyn_protm && IS_ERR(pool))
+	if (dyn_protm && IS_ERR(pool)) {
+		rc = optee_lend_pool_register(optee);
+		if (rc)
+			return rc;
+
 		pool = optee_protmem_alloc_dyn_pool(optee, heap_id);
+		if (IS_ERR(pool)) {
+			optee_lend_pool_unregister(optee);
+			return PTR_ERR(pool);
+		}
+	}
 	if (IS_ERR(pool))
 		return PTR_ERR(pool);
 
 	rc = tee_device_register_dma_heap(optee->teedev, heap_id, pool);
-	if (rc)
+	if (rc) {
+		optee_lend_pool_unregister(optee);
 		pool->ops->destroy_pool(pool);
+	}
 
 	return rc;
 }
@@ -1833,14 +1843,14 @@ static int optee_probe(struct platform_device *pdev)
 	    (sec_caps & OPTEE_SMC_SEC_CAP_RPMB_PROBE))
 		optee->in_kernel_rpmb_routing = true;
 
-	teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
+	teedev = tee_device_alloc(&optee_clnt_desc, &pdev->dev, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
 		goto err_free_optee;
 	}
 	optee->teedev = teedev;
 
-	teedev = tee_device_alloc(&optee_supp_desc, NULL, pool, optee);
+	teedev = tee_device_alloc(&optee_supp_desc, &pdev->dev, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
 		goto err_unreg_teedev;
@@ -1932,6 +1942,7 @@ static int optee_probe(struct platform_device *pdev)
 		optee_disable_shm_cache(optee);
 	optee_smc_notif_uninit_irq(optee);
 	optee_unregister_devices();
+	optee_lend_pool_unregister(optee);
 err_notif_uninit:
 	optee_notif_uninit(optee);
 err_close_ctx:
-- 
2.55.0.1082.g2b9226bbc0-goog

