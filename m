Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFCDC87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 06:05:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EAF5C4FCA0
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 06:05:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rg1mzkyG;
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3D66F4FCAC
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 06:03:56 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so7593896a12.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 12 Aug 2025 23:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755065035; x=1755669835; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HslIfr6UrxDAQ4eYDN73R0okgxEMwKel2ECtA9Ty7MM=;
        b=Rg1mzkyGqTt91LwTkFaBFJFLc7cjJoip0gey2wMFshHeCTrQ3JhSNK0r24W+s748QA
         hiBBJSyBDAoGc7a2zD9bXffxBmEaJZ7d0HjoY0zD3GtDjlCjgBqyEKWqGF82t8sSFTlW
         XF5KztPzpkcfAuGn/ZRp9kzhAKz7CBG06qK0Y72xeCpYnTnhlhXW8IWPEaFk9T2Y19oW
         /yj7Qzd82F2IPj9nlvjo2qeXTaZr2rRueZgZ1uUfO+S7ppKDHpydfixnngiAKfkR2qM2
         QXlbax72J2jK17TALwikuUT+HFg2kZG/H/g8oeAUOYXUF68n4U/wmdRnjEdmhkiOKzsq
         USaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755065035; x=1755669835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HslIfr6UrxDAQ4eYDN73R0okgxEMwKel2ECtA9Ty7MM=;
        b=NBcdqpxAHHnh6g3z/E+MU+xPVJ85pV8W76lpyA23eaX1IOhdyEYJuFJLqIlaTClFJ0
         jf8T5SSw5hMWsE/GF+0I/lNieSDBVYsMibwkbvsiIRMph20MMiFg3p3gJZIaLhFe90Fl
         +LyNZFB4dSV5TctlJBvBK8TAQz2ytEbhq/JKfg8duYHkDCRtySCEzy2dItslm0uloEV4
         +96p3cUHbv+r7QfYGVIWJDr3s3cywKVPICE4zZ1YyotZ/kZjJXvDRGfpYWRDbxvkqaFj
         61B0VyWkVC3q/i/BcQPOyM4GpmmUKDuiX0tqoav7G4+K4Zj3nzH0AWEXU76iQx36saGM
         P/oA==
X-Forwarded-Encrypted: i=1; AJvYcCVn+E/0THOPKoVsVvJ2Bhd2xEiXAF8DV/lwC318yacQZHoNAAK4hs2XZxV2sHVhuk/riQExuwo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwyO/Ywf22IGQnh5N8ZEJbPgF3y5jBVV/jURBzZAMeqalxCEYyy
	HnUkY5F5/e1a9YDArRA2dJHw/EUklo5AroF5yzJqSmgS05yALqr9y6WM6FFnUq3MgIyGlw==
X-Gm-Gg: ASbGncsWIAGVZe9URvma4LFbG7o6hVLpqVlx6awBk2KJwJao5agd5KE7sn4g3BHzu+V
	a1qBoc08JWAES0qZn6stHdktPxFDm5UqGCNZcKPGiMIZ8Km4ZpyoKyNqG1kjbYo7NP3mggyVPBR
	l0ADNRmmkAQB7GDoSfM1mYfDW6chiWxiHTGnxqGdtYKw1GJh0qQnGTQRRXgLbhgYiTiA+xNnWDF
	CRzcB7hyt2x9Yh+iiY8DnXfyvR0k+So9pvepPRTHUST0+4vH8OctRKPtUGu2DgIViGb6nyDcf5u
	Ov1QcfrEL1fmnCqOB9MKANQ2h9KG9P/FA8x4PlCeS5pHuTvB3MsfutxRpP8CeVx7YjbkR8zfx/5
	3X2Srk7g96cKAld+SU+UYYNVAK/MQtYef2mEUBZ4a7EfdsMIoqNYxOJ9shAq4NR/tsmP5UC6uKm
	s=
X-Google-Smtp-Source: AGHT+IGZzXrc8tpt9jiXTe6tz9b3sNrqW8znB+h7LlrCLWp5xzmgjzmjXdupn1kUgAZTDMXmyZ/QpQ==
X-Received: by 2002:a05:6402:44c9:b0:618:273b:4f51 with SMTP id 4fb4d7f45d1cf-6186bfd5757mr1049458a12.23.1755065035056;
        Tue, 12 Aug 2025 23:03:55 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm21498679a12.25.2025.08.12.23.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:03:54 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v11 3/9] tee: implement protected DMA-heap
Date: Wed, 13 Aug 2025 08:02:52 +0200
Message-ID: <20250813060339.2977604-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813060339.2977604-1-jens.wiklander@linaro.org>
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3D66F4FCAC
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.41:from];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.41:from];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: TT7TG6LIPA34TI3DCXGEYVJH7L5HLL3H
X-Message-ID-Hash: TT7TG6LIPA34TI3DCXGEYVJH7L5HLL3H
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TT7TG6LIPA34TI3DCXGEYVJH7L5HLL3H/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Implement DMA heap for protected DMA-buf allocation in the TEE
subsystem.

Protected memory refers to memory buffers behind a hardware enforced
firewall. It is not accessible to the kernel during normal circumstances
but rather only accessible to certain hardware IPs or CPUs executing in
higher or differently privileged mode than the kernel itself. This
interface allows to allocate and manage such protected memory buffers
via interaction with a TEE implementation.

The protected memory is allocated for a specific use-case, like Secure
Video Playback, Trusted UI, or Secure Video Recording where certain
hardware devices can access the memory.

The DMA-heaps are enabled explicitly by the TEE backend driver. The TEE
backend drivers needs to implement protected memory pool to manage the
protected memory.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/tee/Kconfig       |   5 +
 drivers/tee/Makefile      |   1 +
 drivers/tee/tee_core.c    |   2 +
 drivers/tee/tee_heap.c    | 500 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/tee_private.h |   6 +
 include/linux/tee_core.h  |  53 ++++
 6 files changed, 567 insertions(+)
 create mode 100644 drivers/tee/tee_heap.c

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 61b507c18780..90600607a9d8 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -13,6 +13,11 @@ menuconfig TEE
 
 if TEE
 
+config TEE_DMABUF_HEAPS
+	bool
+	depends on HAS_DMA && DMABUF_HEAPS
+	default y
+
 source "drivers/tee/optee/Kconfig"
 source "drivers/tee/amdtee/Kconfig"
 source "drivers/tee/tstee/Kconfig"
diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
index 5488cba30bd2..949a6a79fb06 100644
--- a/drivers/tee/Makefile
+++ b/drivers/tee/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEE) += tee.o
 tee-objs += tee_core.o
+tee-objs += tee_heap.o
 tee-objs += tee_shm.o
 tee-objs += tee_shm_pool.o
 obj-$(CONFIG_OPTEE) += optee/
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index acc7998758ad..52f5806ed314 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1064,6 +1064,8 @@ void tee_device_unregister(struct tee_device *teedev)
 	if (!teedev)
 		return;
 
+	tee_device_put_all_dma_heaps(teedev);
+
 	if (teedev->flags & TEE_DEVICE_FLAG_REGISTERED)
 		cdev_device_del(&teedev->cdev, &teedev->dev);
 
diff --git a/drivers/tee/tee_heap.c b/drivers/tee/tee_heap.c
new file mode 100644
index 000000000000..d8d7735cdffb
--- /dev/null
+++ b/drivers/tee/tee_heap.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Linaro Limited
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+#include <linux/genalloc.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/tee_core.h>
+#include <linux/xarray.h>
+
+#include "tee_private.h"
+
+struct tee_dma_heap {
+	struct dma_heap *heap;
+	enum tee_dma_heap_id id;
+	struct kref kref;
+	struct tee_protmem_pool *pool;
+	struct tee_device *teedev;
+	bool shutting_down;
+	/* Protects pool, teedev, and shutting_down above */
+	struct mutex mu;
+};
+
+struct tee_heap_buffer {
+	struct tee_dma_heap *heap;
+	size_t size;
+	size_t offs;
+	struct sg_table table;
+};
+
+struct tee_heap_attachment {
+	struct sg_table table;
+	struct device *dev;
+};
+
+struct tee_protmem_static_pool {
+	struct tee_protmem_pool pool;
+	struct gen_pool *gen_pool;
+	phys_addr_t pa_base;
+};
+
+#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
+static DEFINE_XARRAY_ALLOC(tee_dma_heap);
+
+static void tee_heap_release(struct kref *kref)
+{
+	struct tee_dma_heap *h = container_of(kref, struct tee_dma_heap, kref);
+
+	h->pool->ops->destroy_pool(h->pool);
+	tee_device_put(h->teedev);
+	h->pool = NULL;
+	h->teedev = NULL;
+}
+
+static void put_tee_heap(struct tee_dma_heap *h)
+{
+	kref_put(&h->kref, tee_heap_release);
+}
+
+static void get_tee_heap(struct tee_dma_heap *h)
+{
+	kref_get(&h->kref);
+}
+
+static int copy_sg_table(struct sg_table *dst, struct sg_table *src)
+{
+	struct scatterlist *dst_sg;
+	struct scatterlist *src_sg;
+	int ret;
+	int i;
+
+	ret = sg_alloc_table(dst, src->orig_nents, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	dst_sg = dst->sgl;
+	for_each_sgtable_sg(src, src_sg, i) {
+		sg_set_page(dst_sg, sg_page(src_sg), src_sg->length,
+			    src_sg->offset);
+		dst_sg = sg_next(dst_sg);
+	}
+
+	return 0;
+}
+
+static int tee_heap_attach(struct dma_buf *dmabuf,
+			   struct dma_buf_attachment *attachment)
+{
+	struct tee_heap_buffer *buf = dmabuf->priv;
+	struct tee_heap_attachment *a;
+	int ret;
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	ret = copy_sg_table(&a->table, &buf->table);
+	if (ret) {
+		kfree(a);
+		return ret;
+	}
+
+	a->dev = attachment->dev;
+	attachment->priv = a;
+
+	return 0;
+}
+
+static void tee_heap_detach(struct dma_buf *dmabuf,
+			    struct dma_buf_attachment *attachment)
+{
+	struct tee_heap_attachment *a = attachment->priv;
+
+	sg_free_table(&a->table);
+	kfree(a);
+}
+
+static struct sg_table *
+tee_heap_map_dma_buf(struct dma_buf_attachment *attachment,
+		     enum dma_data_direction direction)
+{
+	struct tee_heap_attachment *a = attachment->priv;
+	int ret;
+
+	ret = dma_map_sgtable(attachment->dev, &a->table, direction,
+			      DMA_ATTR_SKIP_CPU_SYNC);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &a->table;
+}
+
+static void tee_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				   struct sg_table *table,
+				   enum dma_data_direction direction)
+{
+	struct tee_heap_attachment *a = attachment->priv;
+
+	WARN_ON(&a->table != table);
+
+	dma_unmap_sgtable(attachment->dev, table, direction,
+			  DMA_ATTR_SKIP_CPU_SYNC);
+}
+
+static void tee_heap_buf_free(struct dma_buf *dmabuf)
+{
+	struct tee_heap_buffer *buf = dmabuf->priv;
+
+	buf->heap->pool->ops->free(buf->heap->pool, &buf->table);
+	mutex_lock(&buf->heap->mu);
+	put_tee_heap(buf->heap);
+	mutex_unlock(&buf->heap->mu);
+	kfree(buf);
+}
+
+static const struct dma_buf_ops tee_heap_buf_ops = {
+	.attach = tee_heap_attach,
+	.detach = tee_heap_detach,
+	.map_dma_buf = tee_heap_map_dma_buf,
+	.unmap_dma_buf = tee_heap_unmap_dma_buf,
+	.release = tee_heap_buf_free,
+};
+
+static struct dma_buf *tee_dma_heap_alloc(struct dma_heap *heap,
+					  unsigned long len, u32 fd_flags,
+					  u64 heap_flags)
+{
+	struct tee_dma_heap *h = dma_heap_get_drvdata(heap);
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct tee_device *teedev = NULL;
+	struct tee_heap_buffer *buf;
+	struct tee_protmem_pool *pool;
+	struct dma_buf *dmabuf;
+	int rc;
+
+	mutex_lock(&h->mu);
+	if (h->teedev) {
+		teedev = h->teedev;
+		pool = h->pool;
+		get_tee_heap(h);
+	}
+	mutex_unlock(&h->mu);
+
+	if (!teedev)
+		return ERR_PTR(-EINVAL);
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf) {
+		dmabuf = ERR_PTR(-ENOMEM);
+		goto err;
+	}
+	buf->size = len;
+	buf->heap = h;
+
+	rc = pool->ops->alloc(pool, &buf->table, len, &buf->offs);
+	if (rc) {
+		dmabuf = ERR_PTR(rc);
+		goto err_kfree;
+	}
+
+	exp_info.ops = &tee_heap_buf_ops;
+	exp_info.size = len;
+	exp_info.priv = buf;
+	exp_info.flags = fd_flags;
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf))
+		goto err_protmem_free;
+
+	return dmabuf;
+
+err_protmem_free:
+	pool->ops->free(pool, &buf->table);
+err_kfree:
+	kfree(buf);
+err:
+	mutex_lock(&h->mu);
+	put_tee_heap(h);
+	mutex_unlock(&h->mu);
+	return dmabuf;
+}
+
+static const struct dma_heap_ops tee_dma_heap_ops = {
+	.allocate = tee_dma_heap_alloc,
+};
+
+static const char *heap_id_2_name(enum tee_dma_heap_id id)
+{
+	switch (id) {
+	case TEE_DMA_HEAP_SECURE_VIDEO_PLAY:
+		return "protected,secure-video";
+	case TEE_DMA_HEAP_TRUSTED_UI:
+		return "protected,trusted-ui";
+	case TEE_DMA_HEAP_SECURE_VIDEO_RECORD:
+		return "protected,secure-video-record";
+	default:
+		return NULL;
+	}
+}
+
+static int alloc_dma_heap(struct tee_device *teedev, enum tee_dma_heap_id id,
+			  struct tee_protmem_pool *pool)
+{
+	struct dma_heap_export_info exp_info = {
+		.ops = &tee_dma_heap_ops,
+		.name = heap_id_2_name(id),
+	};
+	struct tee_dma_heap *h;
+	int rc;
+
+	if (!exp_info.name)
+		return -EINVAL;
+
+	if (xa_reserve(&tee_dma_heap, id, GFP_KERNEL)) {
+		if (!xa_load(&tee_dma_heap, id))
+			return -EEXIST;
+		return -ENOMEM;
+	}
+
+	h = kzalloc(sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+	h->id = id;
+	kref_init(&h->kref);
+	h->teedev = teedev;
+	h->pool = pool;
+	mutex_init(&h->mu);
+
+	exp_info.priv = h;
+	h->heap = dma_heap_add(&exp_info);
+	if (IS_ERR(h->heap)) {
+		rc = PTR_ERR(h->heap);
+		kfree(h);
+
+		return rc;
+	}
+
+	/* "can't fail" due to the call to xa_reserve() above */
+	return WARN_ON(xa_is_err(xa_store(&tee_dma_heap, id, h, GFP_KERNEL)));
+}
+
+int tee_device_register_dma_heap(struct tee_device *teedev,
+				 enum tee_dma_heap_id id,
+				 struct tee_protmem_pool *pool)
+{
+	struct tee_dma_heap *h;
+	int rc;
+
+	if (!tee_device_get(teedev))
+		return -EINVAL;
+
+	h = xa_load(&tee_dma_heap, id);
+	if (h) {
+		mutex_lock(&h->mu);
+		if (h->teedev) {
+			rc = -EBUSY;
+		} else {
+			kref_init(&h->kref);
+			h->shutting_down = false;
+			h->teedev = teedev;
+			h->pool = pool;
+			rc = 0;
+		}
+		mutex_unlock(&h->mu);
+	} else {
+		rc = alloc_dma_heap(teedev, id, pool);
+	}
+
+	if (rc) {
+		tee_device_put(teedev);
+		dev_err(&teedev->dev, "can't register DMA heap id %d (%s)\n",
+			id, heap_id_2_name(id));
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tee_device_register_dma_heap);
+
+void tee_device_put_all_dma_heaps(struct tee_device *teedev)
+{
+	struct tee_dma_heap *h;
+	u_long i;
+
+	xa_for_each(&tee_dma_heap, i, h) {
+		if (h) {
+			mutex_lock(&h->mu);
+			if (h->teedev == teedev && !h->shutting_down) {
+				h->shutting_down = true;
+				put_tee_heap(h);
+			}
+			mutex_unlock(&h->mu);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(tee_device_put_all_dma_heaps);
+
+int tee_heap_update_from_dma_buf(struct tee_device *teedev,
+				 struct dma_buf *dmabuf, size_t *offset,
+				 struct tee_shm *shm,
+				 struct tee_shm **parent_shm)
+{
+	struct tee_heap_buffer *buf;
+	int rc;
+
+	/* The DMA-buf must be from our heap */
+	if (dmabuf->ops != &tee_heap_buf_ops)
+		return -EINVAL;
+
+	buf = dmabuf->priv;
+	/* The buffer must be from the same teedev */
+	if (buf->heap->teedev != teedev)
+		return -EINVAL;
+
+	shm->size = buf->size;
+
+	rc = buf->heap->pool->ops->update_shm(buf->heap->pool, &buf->table,
+					      buf->offs, shm, parent_shm);
+	if (!rc && *parent_shm)
+		*offset = buf->offs;
+
+	return rc;
+}
+#else
+int tee_device_register_dma_heap(struct tee_device *teedev __always_unused,
+				 enum tee_dma_heap_id id __always_unused,
+				 struct tee_protmem_pool *pool __always_unused)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(tee_device_register_dma_heap);
+
+void
+tee_device_put_all_dma_heaps(struct tee_device *teedev __always_unused)
+{
+}
+EXPORT_SYMBOL_GPL(tee_device_put_all_dma_heaps);
+
+int tee_heap_update_from_dma_buf(struct tee_device *teedev __always_unused,
+				 struct dma_buf *dmabuf __always_unused,
+				 size_t *offset __always_unused,
+				 struct tee_shm *shm __always_unused,
+				 struct tee_shm **parent_shm __always_unused)
+{
+	return -EINVAL;
+}
+#endif
+
+static struct tee_protmem_static_pool *
+to_protmem_static_pool(struct tee_protmem_pool *pool)
+{
+	return container_of(pool, struct tee_protmem_static_pool, pool);
+}
+
+static int protmem_pool_op_static_alloc(struct tee_protmem_pool *pool,
+					struct sg_table *sgt, size_t size,
+					size_t *offs)
+{
+	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
+	phys_addr_t pa;
+	int ret;
+
+	pa = gen_pool_alloc(stp->gen_pool, size);
+	if (!pa)
+		return -ENOMEM;
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (ret) {
+		gen_pool_free(stp->gen_pool, pa, size);
+		return ret;
+	}
+
+	sg_set_page(sgt->sgl, phys_to_page(pa), size, 0);
+	*offs = pa - stp->pa_base;
+
+	return 0;
+}
+
+static void protmem_pool_op_static_free(struct tee_protmem_pool *pool,
+					struct sg_table *sgt)
+{
+	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sgtable_sg(sgt, sg, i)
+		gen_pool_free(stp->gen_pool, sg_phys(sg), sg->length);
+	sg_free_table(sgt);
+}
+
+static int protmem_pool_op_static_update_shm(struct tee_protmem_pool *pool,
+					     struct sg_table *sgt, size_t offs,
+					     struct tee_shm *shm,
+					     struct tee_shm **parent_shm)
+{
+	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
+
+	shm->paddr = stp->pa_base + offs;
+	*parent_shm = NULL;
+
+	return 0;
+}
+
+static void protmem_pool_op_static_destroy_pool(struct tee_protmem_pool *pool)
+{
+	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
+
+	gen_pool_destroy(stp->gen_pool);
+	kfree(stp);
+}
+
+static struct tee_protmem_pool_ops protmem_pool_ops_static = {
+	.alloc = protmem_pool_op_static_alloc,
+	.free = protmem_pool_op_static_free,
+	.update_shm = protmem_pool_op_static_update_shm,
+	.destroy_pool = protmem_pool_op_static_destroy_pool,
+};
+
+struct tee_protmem_pool *tee_protmem_static_pool_alloc(phys_addr_t paddr,
+						       size_t size)
+{
+	const size_t page_mask = PAGE_SIZE - 1;
+	struct tee_protmem_static_pool *stp;
+	int rc;
+
+	/* Check it's page aligned */
+	if ((paddr | size) & page_mask)
+		return ERR_PTR(-EINVAL);
+
+	if (!pfn_valid(PHYS_PFN(paddr)))
+		return ERR_PTR(-EINVAL);
+
+	stp = kzalloc(sizeof(*stp), GFP_KERNEL);
+	if (!stp)
+		return ERR_PTR(-ENOMEM);
+
+	stp->gen_pool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!stp->gen_pool) {
+		rc = -ENOMEM;
+		goto err_free;
+	}
+
+	rc = gen_pool_add(stp->gen_pool, paddr, size, -1);
+	if (rc)
+		goto err_free_pool;
+
+	stp->pool.ops = &protmem_pool_ops_static;
+	stp->pa_base = paddr;
+	return &stp->pool;
+
+err_free_pool:
+	gen_pool_destroy(stp->gen_pool);
+err_free:
+	kfree(stp);
+
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_GPL(tee_protmem_static_pool_alloc);
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 9bc50605227c..6c6ff5d5eed2 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -8,6 +8,7 @@
 #include <linux/cdev.h>
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/dma-buf.h>
 #include <linux/kref.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
@@ -24,4 +25,9 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
 struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
 					  unsigned long addr, size_t length);
 
+int tee_heap_update_from_dma_buf(struct tee_device *teedev,
+				 struct dma_buf *dmabuf, size_t *offset,
+				 struct tee_shm *shm,
+				 struct tee_shm **parent_shm);
+
 #endif /*TEE_PRIVATE_H*/
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index a38494d6b5f4..28b65010b9ed 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -8,9 +8,11 @@
 
 #include <linux/cdev.h>
 #include <linux/device.h>
+#include <linux/dma-buf.h>
 #include <linux/idr.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/scatterlist.h>
 #include <linux/tee.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
@@ -30,6 +32,12 @@
 #define TEE_DEVICE_FLAG_REGISTERED	0x1
 #define TEE_MAX_DEV_NAME_LEN		32
 
+enum tee_dma_heap_id {
+	TEE_DMA_HEAP_SECURE_VIDEO_PLAY = 1,
+	TEE_DMA_HEAP_TRUSTED_UI,
+	TEE_DMA_HEAP_SECURE_VIDEO_RECORD,
+};
+
 /**
  * struct tee_device - TEE Device representation
  * @name:	name of device
@@ -116,6 +124,36 @@ struct tee_desc {
 	u32 flags;
 };
 
+/**
+ * struct tee_protmem_pool - protected memory pool
+ * @ops:		operations
+ *
+ * This is an abstract interface where this struct is expected to be
+ * embedded in another struct specific to the implementation.
+ */
+struct tee_protmem_pool {
+	const struct tee_protmem_pool_ops *ops;
+};
+
+/**
+ * struct tee_protmem_pool_ops - protected memory pool operations
+ * @alloc:		called when allocating protected memory
+ * @free:		called when freeing protected memory
+ * @update_shm:		called when registering a dma-buf to update the @shm
+ *			with physical address of the buffer or to return the
+ *			@parent_shm of the memory pool
+ * @destroy_pool:	called when destroying the pool
+ */
+struct tee_protmem_pool_ops {
+	int (*alloc)(struct tee_protmem_pool *pool, struct sg_table *sgt,
+		     size_t size, size_t *offs);
+	void (*free)(struct tee_protmem_pool *pool, struct sg_table *sgt);
+	int (*update_shm)(struct tee_protmem_pool *pool, struct sg_table *sgt,
+			  size_t offs, struct tee_shm *shm,
+			  struct tee_shm **parent_shm);
+	void (*destroy_pool)(struct tee_protmem_pool *pool);
+};
+
 /**
  * tee_device_alloc() - Allocate a new struct tee_device instance
  * @teedesc:	Descriptor for this driver
@@ -154,6 +192,11 @@ int tee_device_register(struct tee_device *teedev);
  */
 void tee_device_unregister(struct tee_device *teedev);
 
+int tee_device_register_dma_heap(struct tee_device *teedev,
+				 enum tee_dma_heap_id id,
+				 struct tee_protmem_pool *pool);
+void tee_device_put_all_dma_heaps(struct tee_device *teedev);
+
 /**
  * tee_device_set_dev_groups() - Set device attribute groups
  * @teedev:	Device to register
@@ -229,6 +272,16 @@ static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
 	pool->ops->destroy_pool(pool);
 }
 
+/**
+ * tee_protmem_static_pool_alloc() - Create a protected memory manager
+ * @paddr:	Physical address of start of pool
+ * @size:	Size in bytes of the pool
+ *
+ * @returns pointer to a 'struct tee_protmem_pool' or an ERR_PTR on failure.
+ */
+struct tee_protmem_pool *tee_protmem_static_pool_alloc(phys_addr_t paddr,
+						       size_t size);
+
 /**
  * tee_get_drvdata() - Return driver_data pointer
  * @returns the driver_data pointer supplied to tee_register().
-- 
2.43.0

