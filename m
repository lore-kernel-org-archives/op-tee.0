Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55262CAC592
	for <op-tee@archiver.kernel.org>; Mon, 22 Sep 2025 04:11:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7E046431BC
	for <op-tee@archiver.kernel.org>; Mon, 22 Sep 2025 04:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1758514291;
	bh=qLe5+D3p/KCHuEXmJDeqOmQHa8PWtS/4MQOlxPYDX7E=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Ef1YcTnRy5wtZiSUrsGUmNmliXtoirWxLaSU4MsZ01wiCFsk6nkkKEXOFHK1FE5wL
	 eY397doMrSt6+IIMfY8HZrwfUVJzPCn5IGz+IBpE3OaqglgjrAazi+WLWqRQeb9bt2
	 VcWO/qvx+o6diHscIV1n574svIbA27UQfdabGS1CsvemzOKgJTGIXK/cZrcF6hyQuZ
	 DTc0eifQ6yZQy6ce3C7uYdzOVjRJ8/B9DPoaXCiH6oCx1FCtVeTQco67yBCoV3Q8FB
	 GRbB7VSaZVS/SkLy9vMmStShoakP+0gvi2WZINOdVO53bLcznx1NPVDke1f2Jx07F6
	 OHMZkHOA/XW9Q==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3903B40B1E
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Sep 2025 04:11:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LA1B5JnG;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 703C8601DC;
	Mon, 22 Sep 2025 04:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EED2C4CEF5;
	Mon, 22 Sep 2025 04:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758514276;
	bh=qLe5+D3p/KCHuEXmJDeqOmQHa8PWtS/4MQOlxPYDX7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LA1B5JnGwrN9VzNVeM/dbIS00PgdcxFS4733F2v2T9YlH3M5yujhhvRNDpVcR4vtz
	 yKbWstSh5+BAbFl2n4jD2hTE8bmJaYVdU7LRWUOnrgfFEmaIpsE1e6RI4gfTjGaEsc
	 85VFdX7B2MIYH4SYEs0Ivqwo+TO7+n+dR3Vl5kHTlMLcTGnaJ2EbbWAj5rw2NLFKpu
	 6r9EQIChNAGv1G7HYfGXHB53zhT6apKxF1sdDqWm0sWwBTQ3uqGB2up4ntxnaBcWDi
	 kA2g7nHKA4D5oBZSNt1ROCBEnJc5QVbhuoT5Xre+fv8cuA34uaqpAS6L1SwCv3vMae
	 WT9ve0Qz92AYg==
Date: Mon, 22 Sep 2025 09:41:10 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH] tee: fix register_shm_helper()
Message-ID: <aNDMXvTriEiSLwPb@sumit-X1>
References: <20250919124217.2934718-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919124217.2934718-1-jens.wiklander@linaro.org>
X-Rspamd-Queue-Id: 3903B40B1E
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.trustedfirmware.org,linaro.org,gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: RKOXGCJALUUY3E53OSYZVIHCWPZVEQE4
X-Message-ID-Hash: RKOXGCJALUUY3E53OSYZVIHCWPZVEQE4
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Jerome Forissier <jerome.forissier@linaro.org>, stable@vger.kernel.org, Masami Ichikawa <masami256@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RKOXGCJALUUY3E53OSYZVIHCWPZVEQE4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Fri, Sep 19, 2025 at 02:40:16PM +0200, Jens Wiklander wrote:
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
> Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_shm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..6ed7d030f4ed 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -316,7 +316,16 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>  
>  	len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
>  				     &off);
> -	if (unlikely(len <= 0)) {
> +	if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
> +		if (len > 0) {
> +			/*
> +			 * If we only got a few pages, update to release
> +			 * the correct amount below.
> +			 */
> +			shm->num_pages = len / PAGE_SIZE;
> +			ret = ERR_PTR(-ENOMEM);
> +			goto err_put_shm_pages;
> +		}
>  		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>  		goto err_free_shm_pages;
>  	}

Rather than operating directly on "len" without checking for error code
first doesn't seems appropriate to me. How about following diff instead?

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..cb52bc51943e 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -319,6 +319,14 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
        if (unlikely(len <= 0)) {
                ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
                goto err_free_shm_pages;
+       } else if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
+               /*
+                * If we only got a few pages, update to release the correct
+                * amount below.
+                */
+               shm->num_pages = len / PAGE_SIZE;
+               ret = ERR_PTR(-ENOMEM);
+               goto err_put_shm_pages;
        }
 
        /*

-Sumit

> -- 
> 2.43.0
> 
