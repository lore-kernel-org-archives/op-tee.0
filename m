Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7A2C624D0
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:55:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C2D9C44F37
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788346550;
	bh=IR5a7dw8niUl1D2oqM5QJBMPZf1MLc6PkEbzReKAZA0=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=z4VqHCdDdEdRMV4ihr+DxXsqZ5krdyje3YV9HgfcClm5xNUc3nhtFn+xmAx90iQxi
	 dbFu+fMz2YbMBiG/XaM4fEe5Z7ZYhAfVvbgb+DjH2SMxTlqp/nbM94J454wRdpi11l
	 1B83i9TiF9gTxDHhnHYPnXX98AInj5O6yaA+3ZvT2z8VNR/VL7JfkEU92kWceoUXMz
	 bR77s+sW7lYTg9e+waLBUu09posN0nIBI6/f0NLKACqQf0ZCij6ybIPn8UDdBacvm8
	 8oR4exTd7mZLjXqOkhw6n+SgWsRm06rB/zEMzp9uLdSGxLPUP9avNHmK/X5SibJnIP
	 8LRsnJgd4VEcA==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 055B1453C8
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 10:51:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KjGlpF8m;
	dkim-atps=neutral
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so8375255e9.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788346279; x=1788951079; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w1wC9u3twhPNjqquLWPyT5Y0R6x/ILvd7DMTdNgZ19s=;
        b=KjGlpF8mz4XWTl+8XOkqiB9VnN6xrpCW5trK8wGZqLHTWraYXNl/YH+gnQDy67OB0E
         JibXQOgDRZKblYWQNL/N8UM9Y0IBDgBNf7JudoOUV+Y2OiJ7FGpBjs++HMMcoM94ZMr7
         5YIQV+II5h8bRm1eEkX8D9dse/+DI0AggNULCeyvfmwgKOHToy0xHSCApnGjdFUTs720
         ZKEVBxw4N+He7E9jBNrLDc7Vz6u2+sjFEj7GY/HgO14UWzkGKLGtI9pfyR988K/lSQJu
         FFyLQHEOQ4de4v2FZOiB/CbUwDguYC6TbNjiLVv0BDCyDiUSGe1HGLEzomQns+rHC3f+
         68Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346279; x=1788951079;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1wC9u3twhPNjqquLWPyT5Y0R6x/ILvd7DMTdNgZ19s=;
        b=VdDGwIXrzKZWidSNt3ngyYImVB8h2F8Q/d5qdUDjhs+Wbw1zHLwwro/f1qRwzHzRy5
         jAnLiGS/yPlmknLRNwBhtTPU3sLrtw9z6MlDzSmqtO4+C5YPIVVlhzybYlR/gFmjTPBt
         JmitITl/7vdDAh0BRNn28CYcA9go+Dj6jiTrYmW34laPyUjoPALVj0AJfGOoleXJmuzs
         ++FYwhuxLVrAxdAa+0x8Nas9Qt/D1VdRO1v6WtGHvtLOhhWEC74UX0J63E+J2CjXwtxr
         9awFWMuc41/82/opnmFwYrrznDpimy4sjkvq3SLQDfw92lyrs3kcZGs5eVdlvYweDaw4
         UQuA==
X-Forwarded-Encrypted: i=1; AHgh+RrhsC3XzCJZ3WicVed1FkmfHs0gG2ZZwsMwcVdLCiJRArubO8Gvna6NpUbeAgnq5xN7JOkNPnI=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mX6NX6wMjmUH8rratB4+IcV31Zk9qYDYDUeF6a2fdn0R/DFJwY
	6+ZuY3Nmx1YFmAc1f4U5s30MSbx6+3J3+U6dMFtBKOP+zi8f+08KvL0lVk7PihbCe3onWHqbLKV
	jgSPKc4sg+tum+nZAtBDKTQ==
X-Received: from wmqy14.prod.google.com ([2002:a05:600c:364e:b0:49c:ca29:c0ed])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5653:b0:49c:eb17:cf3b with SMTP id 5b1f17b1804b1-49ceb17cff4mr15337645e9.8.1788346278647;
 Wed, 02 Sep 2026 03:51:18 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:12 +0100
In-Reply-To: <20260902104712.2399797-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260902104712.2399797-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902104712.2399797-11-vdonnefort@google.com>
Subject: [PATCH v9 10/10] optee: Add support for arm,ffa-lend-pool
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3pv-xagokbmeucnmmdenqsfnnfkd.bnlno-sddkhrsr.sqtrsdcehqlv9qd.nqf@flex--vdonnefort.bounces.google.com];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.71:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3pv-xagokbmeucnmmdenqsfnnfkd.bnlno-sddkhrsr.sqtrsdcehqlv9qd.nqf@flex--vdonnefort.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.71:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 055B1453C8
X-Spamd-Bar: --
Message-ID-Hash: 4T45OTGI3KSN7SHAMOJCIB62QRWJUOHH
X-Message-ID-Hash: 4T45OTGI3KSN7SHAMOJCIB62QRWJUOHH
X-MailFrom: 3pv-XagoKBmEUCNMMDENQSFNNFKD.BNLNO-SDDKHRSR.SQTRSDCEHQLV9QD.NQF@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4T45OTGI3KSN7SHAMOJCIB62QRWJUOHH/>
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

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 633715b98625..4d6555171918 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -979,6 +979,7 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
 
 	mutex_destroy(&optee->ffa.mutex);
 	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
+	ffa_lend_pool_detach(&optee->teedev->dev);
 
 	kfree(optee);
 }
@@ -1042,13 +1043,21 @@ static int optee_ffa_protmem_pool_init(struct optee *optee, u32 sec_caps)
 	int rc = 0;
 
 	if (sec_caps & OPTEE_FFA_SEC_CAP_PROTMEM) {
+		rc = ffa_lend_pool_attach(&optee->teedev->dev);
+		if (rc && rc != -ENODEV)
+			return rc;
+
 		pool = optee_protmem_alloc_dyn_pool(optee, id);
-		if (IS_ERR(pool))
+		if (IS_ERR(pool)) {
+			ffa_lend_pool_detach(&optee->teedev->dev);
 			return PTR_ERR(pool);
+		}
 
 		rc = tee_device_register_dma_heap(optee->teedev, id, pool);
-		if (rc)
+		if (rc) {
 			pool->ops->destroy_pool(pool);
+			ffa_lend_pool_detach(&optee->teedev->dev);
+		}
 	}
 
 	return rc;
diff --git a/drivers/tee/optee/protmem.c b/drivers/tee/optee/protmem.c
index be3abf6e8aa6..9b64db9b4e64 100644
--- a/drivers/tee/optee/protmem.c
+++ b/drivers/tee/optee/protmem.c
@@ -42,14 +42,6 @@ static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
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
 	rc = rp->optee->ops->lend_protmem(rp->optee, rp->protmem,
 					  rp->mem_attrs,
 					  rp->mem_attr_count, rp->use_case);
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index b8a2bdac3208..5949aa717cad 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/rpmb.h>
 #include <linux/sched.h>
@@ -1528,6 +1529,8 @@ static void optee_smc_remove(struct platform_device *pdev)
 	if (optee->smc.memremaped_shm)
 		memunmap(optee->smc.memremaped_shm);
 
+	of_reserved_mem_device_release(&optee->teedev->dev);
+
 	kfree(optee);
 }
 
@@ -1712,16 +1715,22 @@ static int optee_protmem_pool_init(struct optee *optee)
 	if (!protm && !dyn_protm)
 		return 0;
 
+	of_reserved_mem_device_init_by_idx(&optee->teedev->dev,
+					   dev_of_node(optee->teedev->dev.parent), 0);
 	if (protm)
 		pool = static_protmem_pool_init(optee);
 	if (dyn_protm && IS_ERR(pool))
 		pool = optee_protmem_alloc_dyn_pool(optee, heap_id);
-	if (IS_ERR(pool))
+	if (IS_ERR(pool)) {
+		of_reserved_mem_device_release(&optee->teedev->dev);
 		return PTR_ERR(pool);
+	}
 
 	rc = tee_device_register_dma_heap(optee->teedev, heap_id, pool);
-	if (rc)
+	if (rc) {
 		pool->ops->destroy_pool(pool);
+		of_reserved_mem_device_release(&optee->teedev->dev);
+	}
 
 	return rc;
 }
@@ -1833,14 +1842,14 @@ static int optee_probe(struct platform_device *pdev)
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
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 6742b3579c86..49a9b2993c83 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015-2017, 2019-2021 Linaro Limited
  */
 #include <linux/anon_inodes.h>
+#include <linux/arm_ffa.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-mapping.h>
@@ -43,6 +44,7 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
 
 		dma_mem = container_of(shm, struct tee_shm_dma_mem, shm);
 		p = dma_mem;
+		ffa_lend_reclaimed(&teedev->dev, shm->paddr, shm->size);
 		dma_free_pages(&teedev->dev, shm->size, dma_mem->page,
 			       dma_mem->dma_addr, DMA_BIDIRECTIONAL);
 #endif
@@ -288,6 +290,7 @@ struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
 	struct tee_shm_dma_mem *dma_mem;
 	dma_addr_t dma_addr;
 	struct page *page;
+	int ret;
 
 	if (!tee_device_get(teedev))
 		return ERR_PTR(-EINVAL);
@@ -297,9 +300,13 @@ struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
 	if (!page)
 		goto err_put_teedev;
 
+	ret = ffa_prepare_lend(&teedev->dev, page_to_phys(page), page_count * PAGE_SIZE);
+	if (ret && ret != -ENODEV)
+		goto err_free_pages;
+
 	dma_mem = kzalloc_obj(*dma_mem);
 	if (!dma_mem)
-		goto err_free_pages;
+		goto err_map_pages;
 
 	refcount_set(&dma_mem->shm.refcount, 1);
 	dma_mem->shm.ctx = ctx;
@@ -313,6 +320,8 @@ struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
 
 	return &dma_mem->shm;
 
+err_map_pages:
+	ffa_lend_reclaimed(&teedev->dev, page_to_phys(page), page_count * PAGE_SIZE);
 err_free_pages:
 	dma_free_pages(&teedev->dev, page_count * PAGE_SIZE, page, dma_addr,
 		       DMA_BIDIRECTIONAL);
-- 
2.55.0.970.g62bdec98f9-goog

