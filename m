Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986A4C71136
	for <op-tee@archiver.kernel.org>; Tue, 17 Jun 2025 11:33:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D0F9046613
	for <op-tee@archiver.kernel.org>; Tue, 17 Jun 2025 11:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1750159994;
	bh=CRnbVtr0GLb3lzwVaUxRD662hwv3QeuvoQMwpeWJVEU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=clE11d9UVRa+yvTEZdGRD5gRNjodT0ZTry0Y76FjIvYWyHXI6aIRW0a4ru5p0Cniz
	 7lPNIXLAPwRglKvzbs1mrHQbYehdIXPx006/qno1MHYd9pIOqsw65drKS+Gf3F2R4n
	 8n68OqB0AGky9Ksa2OhfbnROcw3EC0Ig6S61Zbk1VjSxSMRDNfJnO8b2B9ER+IKrMK
	 rVpEgjqKpT5CHTgsL/lxrUrx1J8m5GkOGf8SqP+x7VfsZF+qaXUtghHPQAj4CWL70p
	 xOareoamBWU4nNGJrHdbBmwlJXZUkGlyThWm+uunqi+e01Gijtt3KgPUE71dYvX1Vq
	 VRGqkJJir/cxw==
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EC31042CCF
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Jun 2025 11:32:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kzkXwuL1;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7BAB25C61E5;
	Tue, 17 Jun 2025 11:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DEFC4CEE3;
	Tue, 17 Jun 2025 11:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750159969;
	bh=CRnbVtr0GLb3lzwVaUxRD662hwv3QeuvoQMwpeWJVEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzkXwuL1P9QjyVWGow80aEJoOUAhmHjnyJjnxodlDQK10dgSZTFCk9cUHzT6a+xEI
	 F4zaSAlMkQVtSgZKqGqp6f4J4dWVQNSt5+oYMNV5WUyzGJLNmq+QQdPlRnApG4baEb
	 8Wo7h32OsM5SlumGiOB5doGG0MqgC333Y5Qd7ykvbR5MfovNQx6HgAz+7FPo/Q+6Bv
	 Bj+9MsrH2tz0ybMehGhQeP799yQ/J7kKd85Y3srd4EitEdzbtRnSV8sKxLhWvEF1pk
	 J8QgypJY63uKLSp3o+pohBAWSC3hKHrBIKw1/EbVNQIDBQzCjZn/UVKoVdV40eJCZz
	 x9VcIgMi/7nng==
Date: Tue, 17 Jun 2025 17:02:40 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v10 6/9] tee: add tee_shm_alloc_dma_mem()
Message-ID: <aFFSWDiVsxA1CbCX@sumit-X1>
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-7-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610131600.2972232-7-jens.wiklander@linaro.org>
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EC31042CCF
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:139.178.84.217];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:54825, ipnet:139.178.80.0/21, country:US];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[139.178.84.217:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[139.178.84.217:from,100.75.92.58:received];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: XYRMRV3FEIFMRHQ437R3EUBECQEWNZJV
X-Message-ID-Hash: XYRMRV3FEIFMRHQ437R3EUBECQEWNZJV
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XYRMRV3FEIFMRHQ437R3EUBECQEWNZJV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Jun 10, 2025 at 03:13:50PM +0200, Jens Wiklander wrote:
> Add tee_shm_alloc_dma_mem() to allocate DMA memory. The memory is
> represented by a tee_shm object using the new flag TEE_SHM_DMA_MEM to
> identify it as DMA memory. The allocated memory will later be lent to
> the TEE to be used as protected memory.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_shm.c    | 85 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/tee_core.h |  5 +++
>  2 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index e63095e84644..60b0f3932cee 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -5,6 +5,8 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/device.h>
>  #include <linux/dma-buf.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/highmem.h>
>  #include <linux/idr.h>
>  #include <linux/io.h>
>  #include <linux/mm.h>
> @@ -13,9 +15,14 @@
>  #include <linux/tee_core.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> -#include <linux/highmem.h>
>  #include "tee_private.h"
>  
> +struct tee_shm_dma_mem {
> +	struct tee_shm shm;
> +	dma_addr_t dma_addr;
> +	struct page *page;
> +};
> +
>  static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  {
>  	size_t n;
> @@ -48,7 +55,16 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
>  {
>  	void *p = shm;
>  
> -	if (shm->flags & TEE_SHM_DMA_BUF) {
> +	if (shm->flags & TEE_SHM_DMA_MEM) {
> +#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)

nit: this config check can be merged into the above if check.

> +		struct tee_shm_dma_mem *dma_mem;
> +
> +		dma_mem = container_of(shm, struct tee_shm_dma_mem, shm);
> +		p = dma_mem;
> +		dma_free_pages(&teedev->dev, shm->size, dma_mem->page,
> +			       dma_mem->dma_addr, DMA_BIDIRECTIONAL);
> +#endif
> +	} else if (shm->flags & TEE_SHM_DMA_BUF) {

Do we need a similar config check for this flag too?

With these addressed, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>  		struct tee_shm_dmabuf_ref *ref;
>  
>  		ref = container_of(shm, struct tee_shm_dmabuf_ref, shm);
> @@ -303,6 +319,71 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>  
> +#if IS_ENABLED(CONFIG_TEE_DMABUF_HEAPS)
> +/**
> + * tee_shm_alloc_dma_mem() - Allocate DMA memory as shared memory object
> + * @ctx:	Context that allocates the shared memory
> + * @page_count:	Number of pages
> + *
> + * The allocated memory is expected to be lent (made inaccessible to the
> + * kernel) to the TEE while it's used and returned (accessible to the
> + * kernel again) before it's freed.
> + *
> + * This function should normally only be used internally in the TEE
> + * drivers.
> + *
> + * @returns a pointer to 'struct tee_shm'
> + */
> +struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
> +				      size_t page_count)
> +{
> +	struct tee_device *teedev = ctx->teedev;
> +	struct tee_shm_dma_mem *dma_mem;
> +	dma_addr_t dma_addr;
> +	struct page *page;
> +
> +	if (!tee_device_get(teedev))
> +		return ERR_PTR(-EINVAL);
> +
> +	page = dma_alloc_pages(&teedev->dev, page_count * PAGE_SIZE,
> +			       &dma_addr, DMA_BIDIRECTIONAL, GFP_KERNEL);
> +	if (!page)
> +		goto err_put_teedev;
> +
> +	dma_mem = kzalloc(sizeof(*dma_mem), GFP_KERNEL);
> +	if (!dma_mem)
> +		goto err_free_pages;
> +
> +	refcount_set(&dma_mem->shm.refcount, 1);
> +	dma_mem->shm.ctx = ctx;
> +	dma_mem->shm.paddr = page_to_phys(page);
> +	dma_mem->dma_addr = dma_addr;
> +	dma_mem->page = page;
> +	dma_mem->shm.size = page_count * PAGE_SIZE;
> +	dma_mem->shm.flags = TEE_SHM_DMA_MEM;
> +
> +	teedev_ctx_get(ctx);
> +
> +	return &dma_mem->shm;
> +
> +err_free_pages:
> +	dma_free_pages(&teedev->dev, page_count * PAGE_SIZE, page, dma_addr,
> +		       DMA_BIDIRECTIONAL);
> +err_put_teedev:
> +	tee_device_put(teedev);
> +
> +	return ERR_PTR(-ENOMEM);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_alloc_dma_mem);
> +#else
> +struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
> +				      size_t page_count)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_alloc_dma_mem);
> +#endif
> +
>  int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
>  			     int (*shm_register)(struct tee_context *ctx,
>  						 struct tee_shm *shm,
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index f17710196c4c..e46a53e753af 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -29,6 +29,8 @@
>  #define TEE_SHM_POOL		BIT(2)  /* Memory allocated from pool */
>  #define TEE_SHM_PRIV		BIT(3)  /* Memory private to TEE driver */
>  #define TEE_SHM_DMA_BUF		BIT(4)	/* Memory with dma-buf handle */
> +#define TEE_SHM_DMA_MEM		BIT(5)	/* Memory allocated with */
> +					/* dma_alloc_pages() */
>  
>  #define TEE_DEVICE_FLAG_REGISTERED	0x1
>  #define TEE_MAX_DEV_NAME_LEN		32
> @@ -310,6 +312,9 @@ void *tee_get_drvdata(struct tee_device *teedev);
>   */
>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
>  
> +struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
> +				      size_t page_count);
> +
>  int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
>  			     int (*shm_register)(struct tee_context *ctx,
>  						 struct tee_shm *shm,
> -- 
> 2.43.0
> 
