Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85ADEC71136
	for <op-tee@archiver.kernel.org>; Tue, 17 Jun 2025 10:34:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C8D0746463
	for <op-tee@archiver.kernel.org>; Tue, 17 Jun 2025 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1750156453;
	bh=GibPsIlevxOfBKYBxrjjiAzIV3pxJcH/cpEFN0tFDJw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rZUsCxjdhf3spD23RpphDx4wGU+Ztbu3bBFRU89v2xS4PrcIpxg1/Yvw3iYMGPpFJ
	 yHhYCtov3ypqXg9VZoD/gEcWv/j+GFLDdzhXO+OmDr5gT7mvleg6y0+UGPswJ01ZYC
	 jxo39BHrOLKDGK/VDv/e8oQvQ9bmdge0+IgaOAQ1EOk9b23wDrclMtTV/CBT4E8dqP
	 P07xhhYBGJUZuV2orsY6cULQneVLQAGmUg7xMKVFBriOglL3bM+1agVPBgEz0H3B8L
	 csURptdkYIorpDyDKXbuOkOT7Ga09g5S7UGnqPTe1wcz8mZ3nfW1TB6XyHCS51VwFg
	 ZICTg/O8If2Vg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8F54141BC8
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Jun 2025 10:33:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eVZDOWhS;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D6E50629F8;
	Tue, 17 Jun 2025 10:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B448EC4CEED;
	Tue, 17 Jun 2025 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750156430;
	bh=GibPsIlevxOfBKYBxrjjiAzIV3pxJcH/cpEFN0tFDJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVZDOWhSrzsOO+Q6iLrPDPzXqzUKdvp6D+1evTRfwD9bG9b9hfLa3qXtKO2OnlqNW
	 rrUfXlPuzqCxeP71ZfC73NjxK/IvTqa4aLQACNktsIYsu9soE+WvQlXlQwloynuY0v
	 pmt5FfeD9+pKmbC2SCEswA5yf0QI3SeXBnDhCDdyMeKP8bHHmtjvMktBL2VGI0Xbmc
	 GVTddYEeY9NI9LuW27LxxdLZRiiJnTwpN9Tkiw7kSqERHEACHzDzytOb8AqeoPScmV
	 wruoFg7o3n7HkFu0FfPGjmrfmaKmLEYpENG9j+VgYrD6dn98JeH/3IM2zvb7jD8/oj
	 RuTnSS9EQUNBw==
Date: Tue, 17 Jun 2025 16:03:40 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v10 3/9] tee: implement protected DMA-heap
Message-ID: <aFFEhOe_pvZ5P2cL@sumit-X1>
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610131600.2972232-4-jens.wiklander@linaro.org>
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8F54141BC8
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[172.105.4.254:from];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: SB4EUGTUMB6BCJJRAFTS33DPYD3LYKD3
X-Message-ID-Hash: SB4EUGTUMB6BCJJRAFTS33DPYD3LYKD3
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SB4EUGTUMB6BCJJRAFTS33DPYD3LYKD3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Jun 10, 2025 at 03:13:47PM +0200, Jens Wiklander wrote:
> Implement DMA heap for protected DMA-buf allocation in the TEE
> subsystem.
> 
> Protected memory refers to memory buffers behind a hardware enforced
> firewall. It is not accessible to the kernel during normal circumstances
> but rather only accessible to certain hardware IPs or CPUs executing in
> higher or differently privileged mode than the kernel itself. This
> interface allows to allocate and manage such protected memory buffers
> via interaction with a TEE implementation.
> 
> The protected memory is allocated for a specific use-case, like Secure
> Video Playback, Trusted UI, or Secure Video Recording where certain
> hardware devices can access the memory.
> 
> The DMA-heaps are enabled explicitly by the TEE backend driver. The TEE
> backend drivers needs to implement protected memory pool to manage the
> protected memory.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/Kconfig       |   5 +
>  drivers/tee/Makefile      |   1 +
>  drivers/tee/tee_heap.c    | 472 ++++++++++++++++++++++++++++++++++++++
>  drivers/tee/tee_private.h |   6 +
>  include/linux/tee_core.h  |  65 ++++++
>  5 files changed, 549 insertions(+)
>  create mode 100644 drivers/tee/tee_heap.c
> 
> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> index 61b507c18780..90600607a9d8 100644
> --- a/drivers/tee/Kconfig
> +++ b/drivers/tee/Kconfig
> @@ -13,6 +13,11 @@ menuconfig TEE
>  
>  if TEE
>  
> +config TEE_DMABUF_HEAPS
> +	bool
> +	depends on HAS_DMA && DMABUF_HEAPS
> +	default y
> +
>  source "drivers/tee/optee/Kconfig"
>  source "drivers/tee/amdtee/Kconfig"
>  source "drivers/tee/tstee/Kconfig"
> diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
> index 5488cba30bd2..949a6a79fb06 100644
> --- a/drivers/tee/Makefile
> +++ b/drivers/tee/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TEE) += tee.o
>  tee-objs += tee_core.o
> +tee-objs += tee_heap.o
>  tee-objs += tee_shm.o
>  tee-objs += tee_shm_pool.o
>  obj-$(CONFIG_OPTEE) += optee/
> diff --git a/drivers/tee/tee_heap.c b/drivers/tee/tee_heap.c
> new file mode 100644
> index 000000000000..7788381a76cb
> --- /dev/null
> +++ b/drivers/tee/tee_heap.c
> @@ -0,0 +1,472 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025, Linaro Limited
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +#include <linux/genalloc.h>
> +#include <linux/module.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/tee_core.h>
> +#include <linux/xarray.h>
> +
> +#include "tee_private.h"
> +
> +struct tee_dma_heap {
> +	struct dma_heap *heap;
> +	enum tee_dma_heap_id id;
> +	struct tee_protmem_pool *pool;
> +	struct tee_device *teedev;
> +	/* Protects pool and teedev above */
> +	struct mutex mu;
> +};
> +
> +struct tee_heap_buffer {
> +	struct tee_protmem_pool *pool;
> +	struct tee_device *teedev;
> +	size_t size;
> +	size_t offs;
> +	struct sg_table table;
> +};
> +
> +struct tee_heap_attachment {
> +	struct sg_table table;
> +	struct device *dev;
> +};
> +
> +struct tee_protmem_static_pool {
> +	struct tee_protmem_pool pool;
> +	struct gen_pool *gen_pool;
> +	phys_addr_t pa_base;
> +};
> +
> +#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
> +static DEFINE_XARRAY_ALLOC(tee_dma_heap);
> +
> +static int copy_sg_table(struct sg_table *dst, struct sg_table *src)
> +{
> +	struct scatterlist *dst_sg;
> +	struct scatterlist *src_sg;
> +	int ret;
> +	int i;
> +
> +	ret = sg_alloc_table(dst, src->orig_nents, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	dst_sg = dst->sgl;
> +	for_each_sgtable_sg(src, src_sg, i) {
> +		sg_set_page(dst_sg, sg_page(src_sg), src_sg->length,
> +			    src_sg->offset);
> +		dst_sg = sg_next(dst_sg);
> +	}
> +
> +	return 0;
> +}
> +
> +static int tee_heap_attach(struct dma_buf *dmabuf,
> +			   struct dma_buf_attachment *attachment)
> +{
> +	struct tee_heap_buffer *buf = dmabuf->priv;
> +	struct tee_heap_attachment *a;
> +	int ret;
> +
> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	ret = copy_sg_table(&a->table, &buf->table);
> +	if (ret) {
> +		kfree(a);
> +		return ret;
> +	}
> +
> +	a->dev = attachment->dev;
> +	attachment->priv = a;
> +
> +	return 0;
> +}
> +
> +static void tee_heap_detach(struct dma_buf *dmabuf,
> +			    struct dma_buf_attachment *attachment)
> +{
> +	struct tee_heap_attachment *a = attachment->priv;
> +
> +	sg_free_table(&a->table);
> +	kfree(a);
> +}
> +
> +static struct sg_table *
> +tee_heap_map_dma_buf(struct dma_buf_attachment *attachment,
> +		     enum dma_data_direction direction)
> +{
> +	struct tee_heap_attachment *a = attachment->priv;
> +	int ret;
> +
> +	ret = dma_map_sgtable(attachment->dev, &a->table, direction,
> +			      DMA_ATTR_SKIP_CPU_SYNC);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return &a->table;
> +}
> +
> +static void tee_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
> +				   struct sg_table *table,
> +				   enum dma_data_direction direction)
> +{
> +	struct tee_heap_attachment *a = attachment->priv;
> +
> +	WARN_ON(&a->table != table);
> +
> +	dma_unmap_sgtable(attachment->dev, table, direction,
> +			  DMA_ATTR_SKIP_CPU_SYNC);
> +}
> +
> +static void tee_heap_buf_free(struct dma_buf *dmabuf)
> +{
> +	struct tee_heap_buffer *buf = dmabuf->priv;
> +	struct tee_device *teedev = buf->teedev;
> +
> +	buf->pool->ops->free(buf->pool, &buf->table);
> +	tee_device_put(teedev);
> +}
> +
> +static const struct dma_buf_ops tee_heap_buf_ops = {
> +	.attach = tee_heap_attach,
> +	.detach = tee_heap_detach,
> +	.map_dma_buf = tee_heap_map_dma_buf,
> +	.unmap_dma_buf = tee_heap_unmap_dma_buf,
> +	.release = tee_heap_buf_free,
> +};
> +
> +static struct dma_buf *tee_dma_heap_alloc(struct dma_heap *heap,
> +					  unsigned long len, u32 fd_flags,
> +					  u64 heap_flags)
> +{
> +	struct tee_dma_heap *h = dma_heap_get_drvdata(heap);
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct tee_device *teedev = NULL;
> +	struct tee_heap_buffer *buf;
> +	struct tee_protmem_pool *pool;
> +	struct dma_buf *dmabuf;
> +	int rc;
> +
> +	mutex_lock(&h->mu);
> +	if (tee_device_get(h->teedev)) {
> +		teedev = h->teedev;
> +		pool = h->pool;
> +	}
> +	mutex_unlock(&h->mu);
> +
> +	if (!teedev)
> +		return ERR_PTR(-EINVAL);
> +
> +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> +	if (!buf) {
> +		dmabuf = ERR_PTR(-ENOMEM);
> +		goto err;
> +	}
> +	buf->size = len;
> +	buf->pool = pool;
> +	buf->teedev = teedev;
> +
> +	rc = pool->ops->alloc(pool, &buf->table, len, &buf->offs);
> +	if (rc) {
> +		dmabuf = ERR_PTR(rc);
> +		goto err_kfree;
> +	}
> +
> +	exp_info.ops = &tee_heap_buf_ops;
> +	exp_info.size = len;
> +	exp_info.priv = buf;
> +	exp_info.flags = fd_flags;
> +	dmabuf = dma_buf_export(&exp_info);
> +	if (IS_ERR(dmabuf))
> +		goto err_protmem_free;
> +
> +	return dmabuf;
> +
> +err_protmem_free:
> +	pool->ops->free(pool, &buf->table);
> +err_kfree:
> +	kfree(buf);
> +err:
> +	tee_device_put(h->teedev);
> +	return dmabuf;
> +}
> +
> +static const struct dma_heap_ops tee_dma_heap_ops = {
> +	.allocate = tee_dma_heap_alloc,
> +};
> +
> +static const char *heap_id_2_name(enum tee_dma_heap_id id)
> +{
> +	switch (id) {
> +	case TEE_DMA_HEAP_SECURE_VIDEO_PLAY:
> +		return "protected,secure-video";
> +	case TEE_DMA_HEAP_TRUSTED_UI:
> +		return "protected,trusted-ui";
> +	case TEE_DMA_HEAP_SECURE_VIDEO_RECORD:
> +		return "protected,secure-video-record";
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static int alloc_dma_heap(struct tee_device *teedev, enum tee_dma_heap_id id,
> +			  struct tee_protmem_pool *pool)
> +{
> +	struct dma_heap_export_info exp_info = {
> +		.ops = &tee_dma_heap_ops,
> +		.name = heap_id_2_name(id),
> +	};
> +	struct tee_dma_heap *h;
> +	int rc;
> +
> +	if (!exp_info.name)
> +		return -EINVAL;
> +
> +	if (xa_reserve(&tee_dma_heap, id, GFP_KERNEL)) {
> +		if (!xa_load(&tee_dma_heap, id))
> +			return -EEXIST;
> +		return -ENOMEM;
> +	}
> +
> +	h = kzalloc(sizeof(*h), GFP_KERNEL);
> +	if (!h)
> +		return -ENOMEM;
> +	h->id = id;
> +	h->teedev = teedev;
> +	h->pool = pool;
> +	mutex_init(&h->mu);
> +
> +	exp_info.priv = h;
> +	h->heap = dma_heap_add(&exp_info);
> +	if (IS_ERR(h->heap)) {
> +		rc = PTR_ERR(h->heap);
> +		kfree(h);
> +
> +		return rc;
> +	}
> +
> +	/* "can't fail" due to the call to xa_reserve() above */
> +	return WARN_ON(xa_is_err(xa_store(&tee_dma_heap, id, h, GFP_KERNEL)));
> +}
> +
> +int tee_device_register_dma_heap(struct tee_device *teedev,
> +				 enum tee_dma_heap_id id,
> +				 struct tee_protmem_pool *pool)
> +{
> +	struct tee_dma_heap *h;
> +	int rc;
> +
> +	h = xa_load(&tee_dma_heap, id);
> +	if (h) {
> +		mutex_lock(&h->mu);
> +		if (h->teedev) {
> +			rc = -EBUSY;
> +		} else {
> +			h->teedev = teedev;
> +			h->pool = pool;
> +			rc = 0;
> +		}
> +		mutex_unlock(&h->mu);
> +	} else {
> +		rc = alloc_dma_heap(teedev, id, pool);
> +	}
> +
> +	if (rc)
> +		dev_err(&teedev->dev, "can't register DMA heap id %d (%s)\n",
> +			id, heap_id_2_name(id));
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tee_device_register_dma_heap);
> +
> +void tee_device_unregister_all_dma_heaps(struct tee_device *teedev)
> +{
> +	struct tee_protmem_pool *pool;
> +	struct tee_dma_heap *h;
> +	u_long i;
> +
> +	xa_for_each(&tee_dma_heap, i, h) {
> +		if (h) {
> +			pool = NULL;
> +			mutex_lock(&h->mu);
> +			if (h->teedev == teedev) {
> +				pool = h->pool;
> +				h->teedev = NULL;
> +				h->pool = NULL;
> +			}
> +			mutex_unlock(&h->mu);
> +			if (pool)
> +				pool->ops->destroy_pool(pool);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
> +
> +int tee_heap_update_from_dma_buf(struct tee_device *teedev,
> +				 struct dma_buf *dmabuf, size_t *offset,
> +				 struct tee_shm *shm,
> +				 struct tee_shm **parent_shm)
> +{
> +	struct tee_heap_buffer *buf;
> +	int rc;
> +
> +	/* The DMA-buf must be from our heap */
> +	if (dmabuf->ops != &tee_heap_buf_ops)
> +		return -EINVAL;
> +
> +	buf = dmabuf->priv;
> +	/* The buffer must be from the same teedev */
> +	if (buf->teedev != teedev)
> +		return -EINVAL;
> +
> +	shm->size = buf->size;
> +
> +	rc = buf->pool->ops->update_shm(buf->pool, &buf->table, buf->offs, shm,
> +					parent_shm);
> +	if (!rc && *parent_shm)
> +		*offset = buf->offs;
> +
> +	return rc;
> +}
> +#else
> +int tee_device_register_dma_heap(struct tee_device *teedev __always_unused,
> +				 enum tee_dma_heap_id id __always_unused,
> +				 struct tee_protmem_pool *pool __always_unused)
> +{
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(tee_device_register_dma_heap);
> +
> +void
> +tee_device_unregister_all_dma_heaps(struct tee_device *teedev __always_unused)
> +{
> +}
> +EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
> +
> +int tee_heap_update_from_dma_buf(struct tee_device *teedev __always_unused,
> +				 struct dma_buf *dmabuf __always_unused,
> +				 size_t *offset __always_unused,
> +				 struct tee_shm *shm __always_unused,
> +				 struct tee_shm **parent_shm __always_unused)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +static struct tee_protmem_static_pool *
> +to_protmem_static_pool(struct tee_protmem_pool *pool)
> +{
> +	return container_of(pool, struct tee_protmem_static_pool, pool);
> +}
> +
> +static int protmem_pool_op_static_alloc(struct tee_protmem_pool *pool,
> +					struct sg_table *sgt, size_t size,
> +					size_t *offs)
> +{
> +	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
> +	phys_addr_t pa;
> +	int ret;
> +
> +	pa = gen_pool_alloc(stp->gen_pool, size);
> +	if (!pa)
> +		return -ENOMEM;
> +
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	if (ret) {
> +		gen_pool_free(stp->gen_pool, pa, size);
> +		return ret;
> +	}
> +
> +	sg_set_page(sgt->sgl, phys_to_page(pa), size, 0);
> +	*offs = pa - stp->pa_base;
> +
> +	return 0;
> +}
> +
> +static void protmem_pool_op_static_free(struct tee_protmem_pool *pool,
> +					struct sg_table *sgt)
> +{
> +	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sgtable_sg(sgt, sg, i)
> +		gen_pool_free(stp->gen_pool, sg_phys(sg), sg->length);
> +	sg_free_table(sgt);
> +}
> +
> +static int protmem_pool_op_static_update_shm(struct tee_protmem_pool *pool,
> +					     struct sg_table *sgt, size_t offs,
> +					     struct tee_shm *shm,
> +					     struct tee_shm **parent_shm)
> +{
> +	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
> +
> +	shm->paddr = stp->pa_base + offs;
> +	*parent_shm = NULL;
> +
> +	return 0;
> +}
> +
> +static void protmem_pool_op_static_destroy_pool(struct tee_protmem_pool *pool)
> +{
> +	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
> +
> +	gen_pool_destroy(stp->gen_pool);
> +	kfree(stp);
> +}
> +
> +static struct tee_protmem_pool_ops protmem_pool_ops_static = {
> +	.alloc = protmem_pool_op_static_alloc,
> +	.free = protmem_pool_op_static_free,
> +	.update_shm = protmem_pool_op_static_update_shm,
> +	.destroy_pool = protmem_pool_op_static_destroy_pool,
> +};
> +
> +struct tee_protmem_pool *tee_protmem_static_pool_alloc(phys_addr_t paddr,
> +						       size_t size)
> +{
> +	const size_t page_mask = PAGE_SIZE - 1;
> +	struct tee_protmem_static_pool *stp;
> +	int rc;
> +
> +	/* Check it's page aligned */
> +	if ((paddr | size) & page_mask)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!pfn_valid(PHYS_PFN(paddr)))
> +		return ERR_PTR(-EINVAL);
> +
> +	stp = kzalloc(sizeof(*stp), GFP_KERNEL);
> +	if (!stp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	stp->gen_pool = gen_pool_create(PAGE_SHIFT, -1);
> +	if (!stp->gen_pool) {
> +		rc = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	rc = gen_pool_add(stp->gen_pool, paddr, size, -1);
> +	if (rc)
> +		goto err_free_pool;
> +
> +	stp->pool.ops = &protmem_pool_ops_static;
> +	stp->pa_base = paddr;
> +	return &stp->pool;
> +
> +err_free_pool:
> +	gen_pool_destroy(stp->gen_pool);
> +err_free:
> +	kfree(stp);
> +
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_GPL(tee_protmem_static_pool_alloc);
> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> index 9bc50605227c..6c6ff5d5eed2 100644
> --- a/drivers/tee/tee_private.h
> +++ b/drivers/tee/tee_private.h
> @@ -8,6 +8,7 @@
>  #include <linux/cdev.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
> +#include <linux/dma-buf.h>
>  #include <linux/kref.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
> @@ -24,4 +25,9 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>  					  unsigned long addr, size_t length);
>  
> +int tee_heap_update_from_dma_buf(struct tee_device *teedev,
> +				 struct dma_buf *dmabuf, size_t *offset,
> +				 struct tee_shm *shm,
> +				 struct tee_shm **parent_shm);
> +
>  #endif /*TEE_PRIVATE_H*/
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index a38494d6b5f4..22e03d897dc3 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -8,9 +8,11 @@
>  
>  #include <linux/cdev.h>
>  #include <linux/device.h>
> +#include <linux/dma-buf.h>
>  #include <linux/idr.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
> +#include <linux/scatterlist.h>
>  #include <linux/tee.h>
>  #include <linux/tee_drv.h>
>  #include <linux/types.h>
> @@ -30,6 +32,12 @@
>  #define TEE_DEVICE_FLAG_REGISTERED	0x1
>  #define TEE_MAX_DEV_NAME_LEN		32
>  
> +enum tee_dma_heap_id {
> +	TEE_DMA_HEAP_SECURE_VIDEO_PLAY = 1,
> +	TEE_DMA_HEAP_TRUSTED_UI,
> +	TEE_DMA_HEAP_SECURE_VIDEO_RECORD,
> +};
> +
>  /**
>   * struct tee_device - TEE Device representation
>   * @name:	name of device
> @@ -116,6 +124,36 @@ struct tee_desc {
>  	u32 flags;
>  };
>  
> +/**
> + * struct tee_protmem_pool - protected memory pool
> + * @ops:		operations
> + *
> + * This is an abstract interface where this struct is expected to be
> + * embedded in another struct specific to the implementation.
> + */
> +struct tee_protmem_pool {
> +	const struct tee_protmem_pool_ops *ops;
> +};
> +
> +/**
> + * struct tee_protmem_pool_ops - protected memory pool operations
> + * @alloc:		called when allocating protected memory
> + * @free:		called when freeing protected memory
> + * @update_shm:		called when registering a dma-buf to update the @shm
> + *			with physical address of the buffer or to return the
> + *			@parent_shm of the memory pool
> + * @destroy_pool:	called when destroying the pool
> + */
> +struct tee_protmem_pool_ops {
> +	int (*alloc)(struct tee_protmem_pool *pool, struct sg_table *sgt,
> +		     size_t size, size_t *offs);
> +	void (*free)(struct tee_protmem_pool *pool, struct sg_table *sgt);
> +	int (*update_shm)(struct tee_protmem_pool *pool, struct sg_table *sgt,
> +			  size_t offs, struct tee_shm *shm,
> +			  struct tee_shm **parent_shm);
> +	void (*destroy_pool)(struct tee_protmem_pool *pool);
> +};
> +
>  /**
>   * tee_device_alloc() - Allocate a new struct tee_device instance
>   * @teedesc:	Descriptor for this driver
> @@ -154,6 +192,11 @@ int tee_device_register(struct tee_device *teedev);
>   */
>  void tee_device_unregister(struct tee_device *teedev);
>  
> +int tee_device_register_dma_heap(struct tee_device *teedev,
> +				 enum tee_dma_heap_id id,
> +				 struct tee_protmem_pool *pool);
> +void tee_device_unregister_all_dma_heaps(struct tee_device *teedev);
> +
>  /**
>   * tee_device_set_dev_groups() - Set device attribute groups
>   * @teedev:	Device to register
> @@ -229,6 +272,28 @@ static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
>  	pool->ops->destroy_pool(pool);
>  }
>  
> +/**
> + * tee_protmem_static_pool_alloc() - Create a protected memory manager
> + * @paddr:	Physical address of start of pool
> + * @size:	Size in bytes of the pool
> + *
> + * @returns pointer to a 'struct tee_protmem_pool' or an ERR_PTR on failure.
> + */
> +struct tee_protmem_pool *tee_protmem_static_pool_alloc(phys_addr_t paddr,
> +						       size_t size);
> +
> +/**
> + * tee_protmem_pool_free() - Free a protected memory pool
> + * @pool:	The protected memory pool to free
> + *
> + * There must be no remaining protected memory allocated from this pool
> + * when this function is called.
> + */
> +static inline void tee_protmem_pool_free(struct tee_protmem_pool *pool)
> +{
> +	pool->ops->destroy_pool(pool);
> +}

I don't see this API being used anywhere, with this dropped feel free to
add:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> +
>  /**
>   * tee_get_drvdata() - Return driver_data pointer
>   * @returns the driver_data pointer supplied to tee_register().
> -- 
> 2.43.0
> 
