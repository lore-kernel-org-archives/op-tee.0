Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2076CCAC5AC
	for <op-tee@archiver.kernel.org>; Mon, 22 Sep 2025 08:50:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 622A443181
	for <op-tee@archiver.kernel.org>; Mon, 22 Sep 2025 08:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1758531037;
	bh=3LiBLlWVvFCy5klUJ+cPajsUi3HC6fr8Tl8FH/qHaac=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=fGBcLYqtzrl05felshBJwAg/jhjZ02aUERE0Ojx0v2EKwFQTZ+xXr/DylWkOqP8YX
	 mVNs4sF1H2MkP6OQm/pLEtn2bXYHzmrlv+BeBnn6HfRHDRUaeSBMXuq98qfqSi9xkv
	 55oWAVUqjXR2gaE6VW01qaekiDbQatcw8ucNxpt/zQZ/b5LweUC0XWG3m1R99TcOgR
	 ela5wmX2OV6BbeG7wdmADEnQ6QJSyPGaBENw1XRvr/SbLVzPHV0HtXwioW+3CigXvb
	 VbC1hT4YGilfjMNRO+FarxKr27k1YBsKE19R6qUb4ojHY3DPk2iNrNXXIIdyQ6DhgJ
	 inNujRXPhpf+Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9656F41B5F
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Sep 2025 08:50:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AU/P3ygy;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D2DB340511;
	Mon, 22 Sep 2025 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60413C4CEF0;
	Mon, 22 Sep 2025 08:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758531021;
	bh=3LiBLlWVvFCy5klUJ+cPajsUi3HC6fr8Tl8FH/qHaac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AU/P3ygynrdzgQwEX0PEavE51C9fuBWO2Z2T34OfzDhViNrVpPkVKiJCcFrsmoZb6
	 WKe+JcFsQmuTBB2sipJv74gQx1OqwjkdAPYMAzG3+YAH9hkxYu8wDzWkqc88Xgxnag
	 TVE8lRIwlu1OGdCS94LRtWC8B8aJconfMJIzGxnS+DO8S5PV9BEzlBbmsc0jsHcPcc
	 rNoPyS4BRUMZvkQp6LeUDncUpxbqtnSK53uI/86l9Hw4TMmlajXndgU1SDYhnk5HKH
	 Sl46Ms4slzsouDHcjFTioWHFiyp43wUka3CO0IlGRMTtMtbdOrEgUrxJ16Z1QWYf/M
	 5Q9xLtlBObZeA==
Date: Mon, 22 Sep 2025 14:20:14 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v2] tee: fix register_shm_helper()
Message-ID: <aNENxpvdpW7ItjgT@sumit-X1>
References: <20250922083211.3341508-2-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922083211.3341508-2-jens.wiklander@linaro.org>
X-Rspamd-Queue-Id: 9656F41B5F
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.trustedfirmware.org,linaro.org,gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: KFJABTNTBVOS7VDLSFDEX4GFCNCPWW5K
X-Message-ID-Hash: KFJABTNTBVOS7VDLSFDEX4GFCNCPWW5K
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Jerome Forissier <jerome.forissier@linaro.org>, stable@vger.kernel.org, Masami Ichikawa <masami256@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KFJABTNTBVOS7VDLSFDEX4GFCNCPWW5K/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, Sep 22, 2025 at 10:31:58AM +0200, Jens Wiklander wrote:
> In register_shm_helper(), fix incorrect error handling for a call to
> iov_iter_extract_pages(). A case is missing for when
> iov_iter_extract_pages() only got some pages and return a number larger
> than 0, but not the requested amount.
> 
> This fixes a possible NULL pointer dereference following a bad input from
> ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Masami Ichikawa <masami256@gmail.com>
> Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com/
> Tested-by: Masami Ichikawa <masami256@gmail.com>
> Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
> Changes from v1
> - Refactor the if statement as requested by Sumit
> - Adding Tested-by: Masami Ichikawa <masami256@gmail.com
> - Link to v1:
>   https://lore.kernel.org/op-tee/20250919124217.2934718-1-jens.wiklander@linaro.org/
> ---
>  drivers/tee/tee_shm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..76c54e1dc98c 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -319,6 +319,14 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>  	if (unlikely(len <= 0)) {
>  		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>  		goto err_free_shm_pages;
> +	} else if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
> +		/*
> +		 * If we only got a few pages, update to release the
> +		 * correct amount below.
> +		 */
> +		shm->num_pages = len / PAGE_SIZE;
> +		ret = ERR_PTR(-ENOMEM);
> +		goto err_put_shm_pages;
>  	}
>  
>  	/*
> -- 
> 2.43.0
> 
