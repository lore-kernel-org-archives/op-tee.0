Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889AFCA0EE0
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 06:07:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D5CFD4FCDA
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 06:07:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sN4fA89i;
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6199D4310C
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 06:04:02 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af939afe5efso723858466b.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 12 Aug 2025 23:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755065041; x=1755669841; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Twd7GfdaaubIhr0igmVjXFbwxXSCknyV61sXbYgmYh4=;
        b=sN4fA89iB4WvWK3txUrAFn/TfAepRN+W+WdUZh9+W0o5xjnMyfM2/9mcIW3Qb56B3w
         uhlRwrHaQJ4w29d/fL6GLvr2jM3uVX/Sk0jIdaQuSBbSWAZmfAynCqHyA3BADofpq46Z
         6UYWjuYTYqZIc5kcBQxqzShqQcdNoSVGZ0f1TA6UGfBpNu8xwloGne7CZXuAsPE4miue
         KLiQNC/AN96vpMGGMVZQCgp5IO+d28iAjuCXT8ey7qXgJZIj+rMRIVeamacozTxcQdVu
         xaF1Fc2Ty9zITLeUAXIbMOqKOT4+DktuRpKZ8hbrR7TjGBVXQfNMTIVIQyUNEosT+Jh1
         9uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755065041; x=1755669841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Twd7GfdaaubIhr0igmVjXFbwxXSCknyV61sXbYgmYh4=;
        b=LOpS4vfbW0VeCoQq6HBu642a/m7FliIiFvoohqPbl3CqXDyAPpKs3bCVGNKXvij0de
         16f5VM+tJzFyVA0+9Xqq6RW2EcmKams0E3eMQtxYUDwOr/hITzj1+tvctpmpcdT6g8av
         6BygVWadidmdL9MGxIwI9MP9LN27zgucSfKxdcdR6494fzRBcCpBCyRixFBcMMad0RmF
         gIqy3iKErzY5xJkFZ+M4AMNTSIpbiQfpS+CmdP+SVca54i765vH0ahu+sGXgIcenjmAN
         pcUmKAer9mmU/7FEKmFdw6Fv9CPAj5WtWh7PPmxyeo9QRUzTnDZDeqbewe0wpus0p8pN
         yVZg==
X-Forwarded-Encrypted: i=1; AJvYcCWScIQW7ZswiSifinBx2Br856wRxCnxKl0PdEh08cxVCLq0fTaODDNUiFeg4XQBLZgLPmZ90zs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx51xUeqtlvraiHgnoXwXcDJOpn10i92OqlE9hq8R1Suf1hsUxV
	ugd1S6dSfh9n1hSus7syAoWtE+R8FlLiSj/LE3nQVD4WDBgJL8sLdXZ9toInLVTEiKKmxA==
X-Gm-Gg: ASbGncurdHgIQqKabQbpXCbSEqOcNglr+3gOo3zIlGdT6CNK9LRbCot+cnHARYd9z9W
	+6cORpqiAnb4Q4IZjuzKxxFmdc0qxG9jZ03N2a86C6+xQFsoEaGC+Gmuo9mp4+H4fgwXxDT0JhE
	AHfn1w2S01ZC+ZR23k/tLmdGoxHm+b6tYj21R+B+yo/4KOIbqqDMXOls67TyOGlxCqaxlJHSlUk
	qX5cBh9uFUPRdEt2ifGTeYmE7kOKRjaCjQS+ax0ByOl7zKI1Yu5MD91xONAWpRnfO42/AEGsL1z
	5Uq65CWt2TU4gKIq7FutqEyRvx1H781bwe0iK1LZZ11rrPVKCQvOgIBopGVxtKQOOWBse2Xh5c7
	soKIhhYbSvEfVZeVgwQewseY9Dla3/b6UtATol7dGmO5yOIBUmVQyFKukpWwFrMjy6qAs34bKN1
	g=
X-Google-Smtp-Source: AGHT+IEgbRmeLzHygurQ8GrbNyHN6Kt0VXzSY9aLiaH8bdOGe6I40zVx+CJbKLm6X6f5LwY4hBf41g==
X-Received: by 2002:a17:907:9629:b0:ae3:c6a3:f855 with SMTP id a640c23a62f3a-afca4dff310mr182406266b.31.1755065041198;
        Tue, 12 Aug 2025 23:04:01 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm21498679a12.25.2025.08.12.23.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:04:00 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v11 6/9] tee: add tee_shm_alloc_dma_mem()
Date: Wed, 13 Aug 2025 08:02:55 +0200
Message-ID: <20250813060339.2977604-7-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813060339.2977604-1-jens.wiklander@linaro.org>
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6199D4310C
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.49:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.49:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: WUUIBUZA62K4GSDMXDG4H74OL5BO7Q7O
X-Message-ID-Hash: WUUIBUZA62K4GSDMXDG4H74OL5BO7Q7O
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WUUIBUZA62K4GSDMXDG4H74OL5BO7Q7O/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add tee_shm_alloc_dma_mem() to allocate DMA memory. The memory is
represented by a tee_shm object using the new flag TEE_SHM_DMA_MEM to
identify it as DMA memory. The allocated memory will later be lent to
the TEE to be used as protected memory.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c    | 85 +++++++++++++++++++++++++++++++++++++++-
 include/linux/tee_core.h |  5 +++
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 76195a398c89..e195c892431d 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -5,6 +5,8 @@
 #include <linux/anon_inodes.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/highmem.h>
 #include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -13,9 +15,14 @@
 #include <linux/tee_core.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
-#include <linux/highmem.h>
 #include "tee_private.h"
 
+struct tee_shm_dma_mem {
+	struct tee_shm shm;
+	dma_addr_t dma_addr;
+	struct page *page;
+};
+
 static void shm_put_kernel_pages(struct page **pages, size_t page_count)
 {
 	size_t n;
@@ -48,7 +55,16 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
 {
 	void *p = shm;
 
-	if (shm->flags & TEE_SHM_DMA_BUF) {
+	if (shm->flags & TEE_SHM_DMA_MEM) {
+#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
+		struct tee_shm_dma_mem *dma_mem;
+
+		dma_mem = container_of(shm, struct tee_shm_dma_mem, shm);
+		p = dma_mem;
+		dma_free_pages(&teedev->dev, shm->size, dma_mem->page,
+			       dma_mem->dma_addr, DMA_BIDIRECTIONAL);
+#endif
+	} else if (shm->flags & TEE_SHM_DMA_BUF) {
 		struct tee_shm_dmabuf_ref *ref;
 
 		ref = container_of(shm, struct tee_shm_dmabuf_ref, shm);
@@ -268,6 +284,71 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
 
+#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
+/**
+ * tee_shm_alloc_dma_mem() - Allocate DMA memory as shared memory object
+ * @ctx:	Context that allocates the shared memory
+ * @page_count:	Number of pages
+ *
+ * The allocated memory is expected to be lent (made inaccessible to the
+ * kernel) to the TEE while it's used and returned (accessible to the
+ * kernel again) before it's freed.
+ *
+ * This function should normally only be used internally in the TEE
+ * drivers.
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
+				      size_t page_count)
+{
+	struct tee_device *teedev = ctx->teedev;
+	struct tee_shm_dma_mem *dma_mem;
+	dma_addr_t dma_addr;
+	struct page *page;
+
+	if (!tee_device_get(teedev))
+		return ERR_PTR(-EINVAL);
+
+	page = dma_alloc_pages(&teedev->dev, page_count * PAGE_SIZE,
+			       &dma_addr, DMA_BIDIRECTIONAL, GFP_KERNEL);
+	if (!page)
+		goto err_put_teedev;
+
+	dma_mem = kzalloc(sizeof(*dma_mem), GFP_KERNEL);
+	if (!dma_mem)
+		goto err_free_pages;
+
+	refcount_set(&dma_mem->shm.refcount, 1);
+	dma_mem->shm.ctx = ctx;
+	dma_mem->shm.paddr = page_to_phys(page);
+	dma_mem->dma_addr = dma_addr;
+	dma_mem->page = page;
+	dma_mem->shm.size = page_count * PAGE_SIZE;
+	dma_mem->shm.flags = TEE_SHM_DMA_MEM;
+
+	teedev_ctx_get(ctx);
+
+	return &dma_mem->shm;
+
+err_free_pages:
+	dma_free_pages(&teedev->dev, page_count * PAGE_SIZE, page, dma_addr,
+		       DMA_BIDIRECTIONAL);
+err_put_teedev:
+	tee_device_put(teedev);
+
+	return ERR_PTR(-ENOMEM);
+}
+EXPORT_SYMBOL_GPL(tee_shm_alloc_dma_mem);
+#else
+struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
+				      size_t page_count)
+{
+	return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL_GPL(tee_shm_alloc_dma_mem);
+#endif
+
 int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 			     int (*shm_register)(struct tee_context *ctx,
 						 struct tee_shm *shm,
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index b6c54b34a8b5..7b0c1da2ca6c 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -29,6 +29,8 @@
 #define TEE_SHM_POOL		BIT(2)  /* Memory allocated from pool */
 #define TEE_SHM_PRIV		BIT(3)  /* Memory private to TEE driver */
 #define TEE_SHM_DMA_BUF		BIT(4)	/* Memory with dma-buf handle */
+#define TEE_SHM_DMA_MEM		BIT(5)	/* Memory allocated with */
+					/* dma_alloc_pages() */
 
 #define TEE_DEVICE_FLAG_REGISTERED	0x1
 #define TEE_MAX_DEV_NAME_LEN		32
@@ -298,6 +300,9 @@ void *tee_get_drvdata(struct tee_device *teedev);
  */
 struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
 
+struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
+				      size_t page_count);
+
 int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
 			     int (*shm_register)(struct tee_context *ctx,
 						 struct tee_shm *shm,
-- 
2.43.0

