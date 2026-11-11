Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE0606A327
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=ZsbUV6Eg;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EO7VhK34
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 79032454C7
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 11:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794395550;
	bh=EB+KMeTaRov+guErLB/65xFwcIKBCVwbiI17pyJRBEo=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ZsbUV6EgEOe/4PafoAB+5q8Qj2TnsuWIJsCsfOSI9fCeaFPp9whrHMAjZBdxl9dNO
	 Z0z5GSeH320eVW94T+sgiDYShcO8PUXhk8bHKrvM7WMzxph9/CWS6kGz7U0AfdH/Tb
	 oqboICwKrnpBWbU2EK8gDvuqxXuytNXgCfYQtGJKiugo5ZzNj8yAvXw/SfXZp3vb9t
	 /qWXIa+Tziw6RvdT80x5vjxCTr9bgBfOxKfOFM5rqXFOlpVZeVAMs4+1vq+7JCvfNs
	 98Cp68rYD3x8+m7NzcqxiVeYsTNcJ5jypSlfjLNoO3iMO5exs1tDleB0yLD1kjTxmT
	 QFh7h0ZT/tzjA==
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C9608454F6
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 11:08:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EO7VhK34;
	dkim-atps=neutral
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4902ce85f72so2397978f8f.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395321; x=1795000121; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1XlqkjYgUHqMtiyvO2/LqlbV238Aov7kyKv1cwFa5P4=;
        b=EO7VhK34v4vIjTSAaAjIkFt71yhhpqHJdVIVdQbRLEQp72oaxbJ3ZTAxaFgSJmCfYM
         SwcGfWp0vRN/FcOJPCiYbU85iEnnpeeyPM8HKXAsFQhowp0gupkXsg4Sgy5FOy8awV4o
         qaa8G12Ppd49iEVysJTVwgi5QYnfO17BbGdnH2yJt1fn9Tr06pkR1QB06WtmRrkBrcKm
         A8A5mKNzrM7TiTXxuxfDWIk58rtpVyVOukrUdRNIeSdXBS6PIJAOwHueq0r4OvvkDXEh
         MF4UJXO3GtN+blFtpBIEtH2tvYghY+4CvNODQ31K3z4lRHw+RhLd4xCjIqbHn0ea9lPT
         GILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395321; x=1795000121;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XlqkjYgUHqMtiyvO2/LqlbV238Aov7kyKv1cwFa5P4=;
        b=aiOJeDMGJsaKwXsfcpLMom95rbP587spx/59jJV2cPTOEApR8R6ioNVAsX/FALQDLB
         DWmwx3X9+2I9YMLELAocG/2TxSh5tbgkLcXnixLmL1QW4curu7KsPKpmVFXfshWftCxN
         jMD5ZG67z0JieigoLOz6deRAlWvKW7UQX2qF2khjGeGrUs6VutbNxKHnOuSQKLKlIcwr
         dSaVOAq+5QUpeLWrOsG5mB0oiWPqrgla+6SKNnBpMLnQa4p5zrHmMOuiWNTrdsaWcXxI
         vsMiRnczMuaQR899aGtbxJbJLB3q1C+gm6KxQLDG10Zd/1x3+SyXDBZmIJLJL+pA1TS9
         LlqQ==
X-Forwarded-Encrypted: i=1; AL+hErH4jaeHtW8x8BLG8R+Vu/4+LBzoOeJqTDFcf7GBxe28oacknLWG/1o6zpiaa9XyYus40lDSI7s=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+qFMVufp1x0mxWuzd1bK2eeT2WBdJj5HuuO7fQp8mIBt/N36ZV
	jJhX6ibJvKZQeTlJUGcbT+T5qvieyEMYu0C+Ei0Jtcn+lny/xs5IKUDVYcchZEIUMteNC5NpV8f
	Xg/Sdz5J9x/XLModijA4Q5w==
X-Received: from wrqn16.prod.google.com ([2002:a5d:4210:0:b0:48e:3826:ef3f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:481d:b0:493:803e:800f with SMTP id ffacd0b85a97d-499c6e96f58mr3024659f8f.29.1794395320547;
 Wed, 11 Nov 2026 03:08:40 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:38 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-9-vdonnefort@google.com>
Subject: [PATCH v3 8/8] optee: Add support for lendable-dma-pool
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
	FORGED_SENDER(0.30)[vdonnefort@google.com,3uez0agokboe0itssjktwylttlqj.htrtu-yjjqnxyx.ywzxyjiknwr1fwj.twl@flex--vdonnefort.bounces.google.com];
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
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3uez0agokboe0itssjktwylttlqj.htrtu-yjjqnxyx.ywzxyjiknwr1fwj.twl@flex--vdonnefort.bounces.google.com];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.71:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.71:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C9608454F6
X-Spamd-Bar: /
Message-ID-Hash: RJ4TVDAZB4MJNLS7QHAZD2U3SYQONJMK
X-Message-ID-Hash: RJ4TVDAZB4MJNLS7QHAZD2U3SYQONJMK
X-MailFrom: 3uEz0agoKBoE0itssjktwylttlqj.htrtu-yjjqnxyx.ywzxyjiknwr1fwj.twl@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RJ4TVDAZB4MJNLS7QHAZD2U3SYQONJMK/>
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

When memory is lent to secure world, fatal CPU speculative reads can
still occur while it retains a cacheable mapping. Use the
lendable-dma-pool API to unmap pages before lending and restore them
upon reclaim.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 drivers/tee/optee/protmem.c | 48 ++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/tee/optee/protmem.c b/drivers/tee/optee/protmem.c
index be3abf6e8aa6..10e8f1540e5e 100644
--- a/drivers/tee/optee/protmem.c
+++ b/drivers/tee/optee/protmem.c
@@ -4,6 +4,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/genalloc.h>
 #include <linux/slab.h>
@@ -21,6 +22,7 @@ struct optee_protmem_dyn_pool {
 	u_int mem_attr_count;
 	refcount_t refcount;
 	u32 use_case;
+	bool unmapped;
 	struct tee_shm *protmem;
 	/* Protects when initializing and tearing down this struct */
 	struct mutex mutex;
@@ -32,6 +34,35 @@ to_protmem_dyn_pool(struct tee_protmem_pool *pool)
 	return container_of(pool, struct optee_protmem_dyn_pool, pool);
 }
 
+static int zap_direct_map_dyn_protmem(struct optee_protmem_dyn_pool *rp)
+{
+	int ret;
+
+	ret = dma_zap_direct_map(&rp->optee->teedev->dev,
+				 phys_to_page(rp->protmem->paddr),
+				 rp->protmem->size);
+	if (ret && ret != -ENODEV)
+		return ret;
+
+	rp->unmapped = !ret;
+
+	return 0;
+}
+
+static void restore_direct_map_dyn_protmem(struct optee_protmem_dyn_pool *rp)
+{
+	if (WARN_ON(!rp->protmem))
+		return;
+
+	if (!rp->unmapped)
+		return;
+
+	dma_restore_direct_map(&rp->optee->teedev->dev,
+			       phys_to_page(rp->protmem->paddr),
+			       rp->protmem->size);
+	rp->unmapped = false;
+}
+
 static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
 {
 	int rc;
@@ -42,19 +73,15 @@ static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
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
+	rc = zap_direct_map_dyn_protmem(rp);
+	if (rc)
+		goto err_put_shm;
+
 	rc = rp->optee->ops->lend_protmem(rp->optee, rp->protmem,
 					  rp->mem_attrs,
 					  rp->mem_attr_count, rp->use_case);
 	if (rc)
-		goto err_put_shm;
+		goto err_restore_direct_map;
 	rp->protmem->flags |= TEE_SHM_DYNAMIC;
 
 	rp->gen_pool = gen_pool_create(PAGE_SHIFT, -1);
@@ -76,6 +103,8 @@ static int init_dyn_protmem(struct optee_protmem_dyn_pool *rp)
 	rp->gen_pool = NULL;
 err_reclaim:
 	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
+err_restore_direct_map:
+	restore_direct_map_dyn_protmem(rp);
 err_put_shm:
 	tee_shm_put(rp->protmem);
 err_null_protmem:
@@ -112,6 +141,7 @@ static void release_dyn_protmem(struct optee_protmem_dyn_pool *rp)
 	rp->gen_pool = NULL;
 
 	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
+	restore_direct_map_dyn_protmem(rp);
 	rp->protmem->flags &= ~TEE_SHM_DYNAMIC;
 
 	WARN(refcount_read(&rp->protmem->refcount) != 1, "Unexpected refcount");
-- 
2.56.0.542.g3ef89b7020-goog

