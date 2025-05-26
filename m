Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76A4C54FB3
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 07:33:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 109CC43123
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 07:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1748244834;
	bh=n06pjiR3hX6mJ2V6ci9WvZueX0ybWrSTpdyrRyQUxww=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FVmEkwyCpmmsfnR9265rzDaa7a+cPnfP6zDRnQ333Av3MF7bMYL4kYG0rRaSmvENV
	 Rp66zRTP227KpAWArAe+FBS9nZSdMck2Fg03KepnxOyybx7W41kV914D5rsZkjw6hK
	 0xdU5VCVb/U05wwuiRMtrHT5MH3EcYaRbKlp8B9DNGz3lJFMt5QHD4mQgVAg3Z7phO
	 AlyvK25siA9Lzqux888F/0b7k20lkwpUFUg9AUFe78/Z9yQJ3UG7cziZC4kAsHX/Ft
	 hSOG7b0LCW6nd5OvJtYFDv95K65fvVJA9AahZTKc+gdTIs9VWMv3lzjUW2ZMsCoWud
	 ho/g8gl415zTg==
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ABF8E43070
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 07:33:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tlH4K3Nl;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 36FCFA4E03C;
	Mon, 26 May 2025 07:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532ADC4CEE7;
	Mon, 26 May 2025 07:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748244815;
	bh=n06pjiR3hX6mJ2V6ci9WvZueX0ybWrSTpdyrRyQUxww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlH4K3NlopK8NwFlAUzj3LDpVkIdJAYwYJ2MYUMGCqcetxLG7vnPmXJYBZWWyR51U
	 j08tn++djKFXkX+3JQlQXy4tC5mtIX5OBiBeapxjNNajb3Gu6gfItSiOmZx4TPc1VH
	 HDvZWb+lr8YvcXPJbFeCbeldXJUysGZN1dwpNxnpMuDqANvh1tPN6AptLgYEY2tjcg
	 19yOKh4mk6DgmFxXBW82XrZ/YEbHTCPAeKK81H9Wccz7gphhe+tMfYXTaZUym9CjFq
	 HIfXhWz3NgQj7Nwb/2LoODSYMcmO7n1KqE85/+JsVs7xJOEOjxkK0f6Yi8B2EIDAAl
	 1swcErzoeYZLQ==
Date: Mon, 26 May 2025 13:03:11 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v9 7/9] optee: support protected memory allocation
Message-ID: <aDQZN-frPnr1_N5I@sumit-X1>
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-8-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520152436.474778-8-jens.wiklander@linaro.org>
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.70 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	RCVD_IN_DNSWL_MED(-0.20)[147.75.193.91:from];
	R_SPF_ALLOW(-0.20)[+ip4:147.75.193.91];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	ASN(0.00)[asn:54825, ipnet:147.75.192.0/21, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: ABF8E43070
Message-ID-Hash: QH6SCQBPEIHDMBYENV2JHHYAZZ3OC3F3
X-Message-ID-Hash: QH6SCQBPEIHDMBYENV2JHHYAZZ3OC3F3
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QH6SCQBPEIHDMBYENV2JHHYAZZ3OC3F3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, May 20, 2025 at 05:16:50PM +0200, Jens Wiklander wrote:
> Add support in the OP-TEE backend driver for protected memory
> allocation. The support is limited to only the SMC ABI and for secure
> video buffers.
> 
> OP-TEE is probed for the range of protected physical memory and a
> memory pool allocator is initialized if OP-TEE have support for such
> memory.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c          | 10 +++++++
>  drivers/tee/optee/optee_private.h |  2 ++
>  drivers/tee/optee/smc_abi.c       | 45 +++++++++++++++++++++++++++++--
>  3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index c75fddc83576..4b14a7ac56f9 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -56,6 +56,15 @@ int optee_rpmb_intf_rdev(struct notifier_block *intf, unsigned long action,
>  	return 0;
>  }
>  
> +int optee_set_dma_mask(struct optee *optee, u_int pa_width)
> +{
> +	u64 mask = DMA_BIT_MASK(min(64, pa_width));
> +
> +	optee->teedev->dev.dma_mask = &optee->teedev->dev.coherent_dma_mask;
> +
> +	return dma_set_mask_and_coherent(&optee->teedev->dev, mask);
> +}
> +
>  static void optee_bus_scan(struct work_struct *work)
>  {
>  	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> @@ -181,6 +190,7 @@ void optee_remove_common(struct optee *optee)
>  	tee_device_unregister(optee->supp_teedev);
>  	tee_device_unregister(optee->teedev);
>  
> +	tee_device_unregister_all_dma_heaps(optee->teedev);
>  	tee_shm_pool_free(optee->pool);
>  	optee_supp_uninit(&optee->supp);
>  	mutex_destroy(&optee->call_queue.mutex);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index dc0f355ef72a..5e3c34802121 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -272,6 +272,8 @@ struct optee_call_ctx {
>  
>  extern struct blocking_notifier_head optee_rpmb_intf_added;
>  
> +int optee_set_dma_mask(struct optee *optee, u_int pa_width);
> +
>  int optee_notif_init(struct optee *optee, u_int max_key);
>  void optee_notif_uninit(struct optee *optee);
>  int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index f0c3ac1103bb..f3cae8243785 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1584,6 +1584,42 @@ static inline int optee_load_fw(struct platform_device *pdev,
>  }
>  #endif
>  
> +static int optee_protmem_pool_init(struct optee *optee)
> +{
> +	enum tee_dma_heap_id heap_id = TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
> +	struct tee_protmem_pool *pool;
> +	int rc;
> +
> +	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM) {
> +		union {
> +			struct arm_smccc_res smccc;
> +			struct optee_smc_get_protmem_config_result result;
> +		} res;
> +
> +		optee->smc.invoke_fn(OPTEE_SMC_GET_PROTMEM_CONFIG, 0, 0, 0, 0,
> +				     0, 0, 0, &res.smccc);
> +		if (res.result.status != OPTEE_SMC_RETURN_OK) {
> +			pr_err("Secure Data Path service not available\n");
> +			return 0;
> +		}
> +		rc = optee_set_dma_mask(optee, res.result.pa_width);
> +		if (!rc)
> +			pool = tee_protmem_static_pool_alloc(res.result.start,
> +							     res.result.size);
> +		if (IS_ERR(pool))
> +			return PTR_ERR(pool);
> +
> +		rc = tee_device_register_dma_heap(optee->teedev, heap_id, pool);
> +		if (rc)
> +			goto err;
> +	}
> +
> +	return 0;
> +err:
> +	pool->ops->destroy_pool(pool);
> +	return rc;
> +}
> +
>  static int optee_probe(struct platform_device *pdev)
>  {
>  	optee_invoke_fn *invoke_fn;
> @@ -1679,7 +1715,7 @@ static int optee_probe(struct platform_device *pdev)
>  	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
>  	if (!optee) {
>  		rc = -ENOMEM;
> -		goto err_free_pool;
> +		goto err_free_shm_pool;
>  	}
>  
>  	optee->ops = &optee_ops;
> @@ -1752,6 +1788,10 @@ static int optee_probe(struct platform_device *pdev)
>  		pr_info("Asynchronous notifications enabled\n");
>  	}
>  
> +	rc = optee_protmem_pool_init(optee);

Here we should do a Kconfig check for CONFIG_DMABUF_HEAPS so that we
don't proceed any further with initialization.

Rest looks good to me.

-Sumit

> +	if (rc)
> +		goto err_notif_uninit;
> +
>  	/*
>  	 * Ensure that there are no pre-existing shm objects before enabling
>  	 * the shm cache so that there's no chance of receiving an invalid
> @@ -1787,6 +1827,7 @@ static int optee_probe(struct platform_device *pdev)
>  		optee_disable_shm_cache(optee);
>  	optee_smc_notif_uninit_irq(optee);
>  	optee_unregister_devices();
> +	tee_device_unregister_all_dma_heaps(optee->teedev);
>  err_notif_uninit:
>  	optee_notif_uninit(optee);
>  err_close_ctx:
> @@ -1803,7 +1844,7 @@ static int optee_probe(struct platform_device *pdev)
>  	tee_device_unregister(optee->teedev);
>  err_free_optee:
>  	kfree(optee);
> -err_free_pool:
> +err_free_shm_pool:
>  	tee_shm_pool_free(pool);
>  	if (memremaped_shm)
>  		memunmap(memremaped_shm);
> -- 
> 2.43.0
> 
