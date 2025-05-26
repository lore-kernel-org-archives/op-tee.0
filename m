Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00168C54FB3
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 07:23:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3AE0543125
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 07:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1748244197;
	bh=kQ4k7Xphh54QIxwt6vGLShRpXDSSLCxTPN7vVeaFxCY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=LGvYQkc5dpUo1wGPSPNbnzOF8np2YbUA/C7poxgaFcYXJxDyTFcL91GrmioZ1O0a/
	 p5UU1faEeWcL8efp6ypUejg5dtaFcPB3pACSRYlpgku0Mgn0nuSNxZ4Dki1PnFsSm6
	 OkNmgiT+aiuu2rbJyQ7PlHn4832LZ2hek+ZTZZMqWbdveMil+mNhvN8JNg5o61chbv
	 M0QTGKsWC45zvENEKARvDp0mHLnVugd6F6OGi1lKjWnAuGhcjqXdApi7LAhzqJ22m5
	 HosnNnHH+ispKN61atIij21c3j/eTCUE77Nfu+5CC6GUVgmibGiaGn36bJWHDCyFUz
	 HBTqCJuKUZpDw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0497D43070
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 07:22:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F91OMDK0;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2606861120;
	Mon, 26 May 2025 07:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AB2C4CEE7;
	Mon, 26 May 2025 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748244177;
	bh=kQ4k7Xphh54QIxwt6vGLShRpXDSSLCxTPN7vVeaFxCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F91OMDK0O7gcmEkQdrzt+uf0tyyU4HiriJmD9GpcHrKJn/LBWuyEb5ZEiLnzhj/C+
	 HjKPEXah8xYaU7LdJdZGRc/0B34awR6Ys0ms9HsBhesD6c+O4tNhdI2bVBfWIsw2ve
	 04Ld4ebrsSMAEK6y3stNWnsKgiyw9r7T2RFhW35tCtH/UI7T76lmh45L+D+t7ClP5R
	 OQdsiyQBiVm5XYV9OUFlppofAeY7Z0sjfytGvqPhNw8zNOIxRHl2BVaoB1xTksmkNT
	 uXQPy8s6Dw9Ybb5FAYXr7SYBlWEyzgg4RhfAFbQcLHLF892hiKVpcjnVijA3AqReCQ
	 l5/Pag91EsJoQ==
Date: Mon, 26 May 2025 12:52:31 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v9 6/9] tee: add tee_shm_alloc_dma_mem()
Message-ID: <aDQWt5Ck1Bo01Z_4@sumit-X1>
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-7-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520152436.474778-7-jens.wiklander@linaro.org>
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0497D43070
Message-ID-Hash: 6NNTBAK2Y7FJN2BGHBHNGWOREHQJFUXT
X-Message-ID-Hash: 6NNTBAK2Y7FJN2BGHBHNGWOREHQJFUXT
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6NNTBAK2Y7FJN2BGHBHNGWOREHQJFUXT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, May 20, 2025 at 05:16:49PM +0200, Jens Wiklander wrote:
> Add tee_shm_alloc_dma_mem() to allocate DMA memory. The memory is
> represented by a tee_shm object using the new flag TEE_SHM_DMA_MEM to
> identify it as DMA memory. The allocated memory will later be lent to
> the TEE to be used as protected memory.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_shm.c    | 74 ++++++++++++++++++++++++++++++++++++++--
>  include/linux/tee_core.h |  5 +++
>  2 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index e1ed52ee0a16..92a6a35e1a1e 100644
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
> @@ -49,7 +56,14 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
>  	struct tee_shm *parent_shm = NULL;
>  	void *p = shm;
>  
> -	if (shm->flags & TEE_SHM_DMA_BUF) {
> +	if (shm->flags & TEE_SHM_DMA_MEM) {
> +		struct tee_shm_dma_mem *dma_mem;
> +
> +		dma_mem = container_of(shm, struct tee_shm_dma_mem, shm);
> +		p = dma_mem;
> +		dma_free_pages(&teedev->dev, shm->size, dma_mem->page,
> +			       dma_mem->dma_addr, DMA_BIDIRECTIONAL);

Although the kernel bot already found a randconfig issue, it looks like
we need to add Kconfig dependencies like HAS_DMA, DMA_CMA etc.

Also, I was thinking if we should rather add a new TEE subsystem
specific Kconfig option like: TEE_DMABUF_HEAPS which can then be used to
select whatever dependency is needed as well as act as a gating Kconfig
for relevant features.

-Sumit

> +	} else if (shm->flags & TEE_SHM_DMA_BUF) {
>  		struct tee_shm_dmabuf_ref *ref;
>  
>  		ref = container_of(shm, struct tee_shm_dmabuf_ref, shm);
> @@ -306,6 +320,62 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>  
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
> +
>  int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
>  			     int (*shm_register)(struct tee_context *ctx,
>  						 struct tee_shm *shm,
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index 02c07f661349..925690e1020b 100644
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
