Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA52CA0EDC
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 06:13:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4F7CD4FC79
	for <op-tee@archiver.kernel.org>; Thu, 14 Aug 2025 06:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755151997;
	bh=DAGhSWQHXEHySMtrjXTOpoAjZ6wAwaqNMvo6ON2OJxA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=t/wfDtbTCDJza2NaB9oLpsC9VQDaVT9UyzApTUS+PbVj+2j/uYZd6pKKaDHTobkuG
	 N7FoW1VsSFNdlSzMMs/MBdydzJWW6PvAfsomDysqoI4bT4K52rAvJ79bBwj0pqhAG8
	 gfCZhMLXbF8wHhhd6vMr4MTLN8bLP/eXwGCpj3rrgReYvKHZ2Bn/SdAuGPzyPKmzjI
	 /a6jwuHjoMlQpgxrSUoxVgub2qg8F2C+F3fxQ229CorNZtxL40vLM7j8H+PgYfM1QE
	 8qJNc13pTkPkMw7Xvp0tvYsvmSFbsYlBrbQOlp7YXnfyZX/Eo2xKoEqiyEyPuioGfb
	 d+Xf+1ukhMINA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 05A6A42E12
	for <op-tee@lists.trustedfirmware.org>; Thu, 14 Aug 2025 06:13:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h3lHu3ai;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3EB61601DD;
	Thu, 14 Aug 2025 06:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4E7C4CEEF;
	Thu, 14 Aug 2025 06:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755151983;
	bh=DAGhSWQHXEHySMtrjXTOpoAjZ6wAwaqNMvo6ON2OJxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3lHu3aiobL0T0fk/o90/lR7crHSA/3wZHAC0YA3sLLGB4v52FV10x7lKyMsDM1sY
	 ReumTALeQkloTBu3I6tsjCabMWXzXx/TTYModh1h68VLWmUJuROoRfdM+XEQ9P+RzV
	 UB8/LkiK08WUB14CsUUycZrb4Cr17AsakkaM3DGiPsQ42MVJSWy0IDk3LMydTjy9mb
	 PsaDi8/RZptKDGWlrS1g3RQ4ZVHxtMj4ArPk5ZiGP8sf0UT4YOqTsb2xG9bcldG//j
	 1znx2Lggvw/UgNIQt2PoA9yjcHRwJrbTFO3+tCdsojX5ToVSmZWRUvumraX1h9VpFO
	 mkR2nWKX7robQ==
Date: Thu, 14 Aug 2025 11:42:50 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v11 2/9] dma-buf: dma-heap: export declared functions
Message-ID: <aJ1-YpgvGt4_6CFU@sumit-X1>
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
 <20250813060339.2977604-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813060339.2977604-3-jens.wiklander@linaro.org>
X-Rspamd-Queue-Id: 05A6A42E12
X-Spamd-Bar: --
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,collabora.com,arm.com,google.com,qti.qualcomm.com,ffwll.ch,fooishbar.org,linaro.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: LNM5L2HSBLTUXH2DMCJUQTHXXP2BLS7K
X-Message-ID-Hash: LNM5L2HSBLTUXH2DMCJUQTHXXP2BLS7K
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LNM5L2HSBLTUXH2DMCJUQTHXXP2BLS7K/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Aug 13, 2025 at 08:02:51AM +0200, Jens Wiklander wrote:
> Export the dma-buf heap functions to allow them to be used by the OP-TEE
> driver. The OP-TEE driver wants to register and manage specific secure
> DMA heaps with it.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/dma-buf/dma-heap.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Can we get an ack from DMAbuf maintainers here? With that we should be
able to queue this patch-set for linux-next targetting the 6.18 merge
window.

-Sumit

> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 3cbe87d4a464..cdddf0e24dce 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -202,6 +202,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
>  {
>  	return heap->priv;
>  }
> +EXPORT_SYMBOL(dma_heap_get_drvdata);
>  
>  /**
>   * dma_heap_get_name - get heap name
> @@ -214,6 +215,7 @@ const char *dma_heap_get_name(struct dma_heap *heap)
>  {
>  	return heap->name;
>  }
> +EXPORT_SYMBOL(dma_heap_get_name);
>  
>  /**
>   * dma_heap_add - adds a heap to dmabuf heaps
> @@ -303,6 +305,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>  	kfree(heap);
>  	return err_ret;
>  }
> +EXPORT_SYMBOL(dma_heap_add);
>  
>  static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
>  {
> -- 
> 2.43.0
> 
