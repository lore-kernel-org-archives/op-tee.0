Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CFDC5AD49
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 08:14:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D06014311F
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1748247254;
	bh=1FEQ33EDgRQThqrYNVwsS/ECQVP2rLowPOJ80r0AksE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=o5jMbei+4BSrx8aC36JKbFrfucPryDLG2XWNGukTe2QPKXTREfEoDt9Jx7TOZsUkz
	 94LBZIWPNX3aOgXUnQWXvTgWMy4AW0O5VtyBtP5/4s1tVELVMDsc8BpwSt0kDqh85y
	 0bUBDATRe3HhEMaEhArAj7FZLUyLHGdP0OYluRg/lO+Gi8fTvxhLgS42D0sS15aSbv
	 ZUTPPGpZnjpBPUO5gSz8KoJ0Nlsx2T+sj57spXTjIw9NsOYsAaekUT6V3h9+WaYjnv
	 AX95shqQyUsXWX2juFf1ExgE082ym5cNJbBpjDks1JhGOOI4ro41P/SZyTtt629HyH
	 +QpFTvd0FrtgQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8854442F36
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 08:13:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=agdSSmCb;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 177986112E;
	Mon, 26 May 2025 08:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A82C4CEEF;
	Mon, 26 May 2025 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748247235;
	bh=1FEQ33EDgRQThqrYNVwsS/ECQVP2rLowPOJ80r0AksE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agdSSmCbJrmUXnITkYok9W4XfBvVB3JWo5GH7/dUZ9OT3dikuYr7e8Jk3qFWtEget
	 w/e3Tg4Xa5FJo2ZWKv/DtFisTjezwtQ0tRlsVDf1IIUcRak8q9MzXq45Ch8UfkYClb
	 ka3PsgQmgIVO6YONcdIrFSl+IAerxjmNQjGUlEEzZ9SttcolFiC0lmQsjnsiLwGX4j
	 HN51afGR8nZvZ8JZC19m42t//vGUbVlaavR7ykLnO5rN7/iAXZy2QnloB7CyOb0pKU
	 6AB9wlpNLcpMmiY+RTCrrkyePD1fe3IeqNWdRyIeT6vXVuRups6lO42EbG7qLy2kaw
	 NrXyQoUuDiD5g==
Date: Mon, 26 May 2025 13:43:41 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v9 9/9] optee: smc abi: dynamic protected memory
 allocation
Message-ID: <aDQitSd27Z4qC0xT@sumit-X1>
References: <20250520152436.474778-1-jens.wiklander@linaro.org>
 <20250520152436.474778-10-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520152436.474778-10-jens.wiklander@linaro.org>
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
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
X-Rspamd-Queue-Id: 8854442F36
Message-ID-Hash: B26E3FFGH7D5M73MIBKZFLGMNFPF2KTY
X-Message-ID-Hash: B26E3FFGH7D5M73MIBKZFLGMNFPF2KTY
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B26E3FFGH7D5M73MIBKZFLGMNFPF2KTY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, May 20, 2025 at 05:16:52PM +0200, Jens Wiklander wrote:
> Add support in the OP-TEE backend driver for dynamic protected memory
> allocation using the SMC ABI.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/smc_abi.c | 102 ++++++++++++++++++++++++++++++------
>  1 file changed, 85 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index f3cae8243785..6b3fbe7f0909 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -965,6 +965,70 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
>  	return rc;
>  }
>  
> +static int optee_smc_lend_protmem(struct optee *optee, struct tee_shm *protmem,
> +				  u16 *end_points, unsigned int ep_count,
> +				  u32 use_case)
> +{
> +	struct optee_shm_arg_entry *entry;
> +	struct optee_msg_arg *msg_arg;
> +	struct tee_shm *shm;
> +	u_int offs;
> +	int rc;
> +
> +	msg_arg = optee_get_msg_arg(optee->ctx, 2, &entry, &shm, &offs);
> +	if (IS_ERR(msg_arg))
> +		return PTR_ERR(msg_arg);
> +
> +	msg_arg->cmd = OPTEE_MSG_CMD_LEND_PROTMEM;
> +	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
> +	msg_arg->params[0].u.value.a = use_case;
> +	msg_arg->params[1].attr = OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
> +	msg_arg->params[1].u.tmem.buf_ptr = protmem->paddr;
> +	msg_arg->params[1].u.tmem.size = protmem->size;
> +	msg_arg->params[1].u.tmem.shm_ref = (u_long)protmem;
> +
> +	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
> +	if (rc)
> +		goto out;
> +	if (msg_arg->ret != TEEC_SUCCESS) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	protmem->sec_world_id = (u_long)protmem;
> +
> +out:
> +	optee_free_msg_arg(optee->ctx, entry, offs);
> +	return rc;
> +}
> +
> +static int optee_smc_reclaim_protmem(struct optee *optee,
> +				     struct tee_shm *protmem)
> +{
> +	struct optee_shm_arg_entry *entry;
> +	struct optee_msg_arg *msg_arg;
> +	struct tee_shm *shm;
> +	u_int offs;
> +	int rc;
> +
> +	msg_arg = optee_get_msg_arg(optee->ctx, 1, &entry, &shm, &offs);
> +	if (IS_ERR(msg_arg))
> +		return PTR_ERR(msg_arg);
> +
> +	msg_arg->cmd = OPTEE_MSG_CMD_RECLAIM_PROTMEM;
> +	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> +	msg_arg->params[0].u.rmem.shm_ref = (u_long)protmem;
> +
> +	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
> +	if (rc)
> +		goto out;
> +	if (msg_arg->ret != TEEC_SUCCESS)
> +		rc = -EINVAL;
> +
> +out:
> +	optee_free_msg_arg(optee->ctx, entry, offs);
> +	return rc;
> +}
> +
>  /*
>   * 5. Asynchronous notification
>   */
> @@ -1216,6 +1280,8 @@ static const struct optee_ops optee_ops = {
>  	.do_call_with_arg = optee_smc_do_call_with_arg,
>  	.to_msg_param = optee_to_msg_param,
>  	.from_msg_param = optee_from_msg_param,
> +	.lend_protmem = optee_smc_lend_protmem,
> +	.reclaim_protmem = optee_smc_reclaim_protmem,
>  };
>  
>  static int enable_async_notif(optee_invoke_fn *invoke_fn)
> @@ -1586,11 +1652,14 @@ static inline int optee_load_fw(struct platform_device *pdev,
>  
>  static int optee_protmem_pool_init(struct optee *optee)
>  {
> +	bool protm = optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM;
> +	bool dyn_protm = optee->smc.sec_caps &
> +			 OPTEE_SMC_SEC_CAP_DYNAMIC_PROTMEM;
>  	enum tee_dma_heap_id heap_id = TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
> -	struct tee_protmem_pool *pool;
> -	int rc;
> +	struct tee_protmem_pool *pool = ERR_PTR(-EINVAL);
> +	int rc = -EINVAL;
>  
> -	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM) {
> +	if (protm) {
>  		union {
>  			struct arm_smccc_res smccc;
>  			struct optee_smc_get_protmem_config_result result;
> @@ -1598,26 +1667,26 @@ static int optee_protmem_pool_init(struct optee *optee)
>  
>  		optee->smc.invoke_fn(OPTEE_SMC_GET_PROTMEM_CONFIG, 0, 0, 0, 0,
>  				     0, 0, 0, &res.smccc);
> -		if (res.result.status != OPTEE_SMC_RETURN_OK) {
> -			pr_err("Secure Data Path service not available\n");
> -			return 0;
> -		}
> -		rc = optee_set_dma_mask(optee, res.result.pa_width);
> +		if (res.result.status == OPTEE_SMC_RETURN_OK)
> +			rc = optee_set_dma_mask(optee, res.result.pa_width);

This change should be folded in patch 7/9.

>  		if (!rc)
>  			pool = tee_protmem_static_pool_alloc(res.result.start,
>  							     res.result.size);
> -		if (IS_ERR(pool))
> -			return PTR_ERR(pool);
> +	}
>  
> +	if (dyn_protm && IS_ERR(pool))
> +		pool = optee_protmem_alloc_dyn_pool(optee, heap_id);
> +
> +	if (!IS_ERR(pool)) {
>  		rc = tee_device_register_dma_heap(optee->teedev, heap_id, pool);
>  		if (rc)
> -			goto err;
> +			pool->ops->destroy_pool(pool);
>  	}
>  
> +	if (protm || dyn_protm)
> +		return rc;
> +
>  	return 0;
> -err:
> -	pool->ops->destroy_pool(pool);
> -	return rc;
>  }
>  
>  static int optee_probe(struct platform_device *pdev)
> @@ -1788,9 +1857,8 @@ static int optee_probe(struct platform_device *pdev)
>  		pr_info("Asynchronous notifications enabled\n");
>  	}
>  
> -	rc = optee_protmem_pool_init(optee);
> -	if (rc)
> -		goto err_notif_uninit;
> +	if (optee_protmem_pool_init(optee))
> +		pr_info("Protected memory service not available\n");

This change can be folded in patch 7/9.

Rest looks good to me.

-Sumit

>  
>  	/*
>  	 * Ensure that there are no pre-existing shm objects before enabling
> -- 
> 2.43.0
> 
