Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EFBEBFD1E
	for <op-tee@archiver.kernel.org>; Mon, 13 Apr 2026 09:03:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C00743291
	for <op-tee@archiver.kernel.org>; Mon, 13 Apr 2026 09:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1776071015;
	bh=0sOX8GKgRbRUwdzVDoXTccQF5IzCxIxM+r1xkMMHTZA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zrhlwL4mR8TrWCo6oR+XG3Fj9GAXOBM+2idaoVekldYqkRfDAWzxcTz8obqFh6dpe
	 p67GXtzN3CrIBGQnRZLgDro7C846e5whyDgGp7OOmlX6J613j6WlcoOQeolFZAdWb5
	 ZJrYicBePILCj2+NIyqFzPa2E8ctekSSVaHToNQ1mnVnT/PPmBBBaXxz6K2mJAjtLr
	 aFHyJY30jF2e7TXtOG2zxXv1uoqCU05uOkILrWdqO++bOadMpu28L1fohl/oXLpvXX
	 GQqmdQMAwFoVq97Rpr+85hZSzZsCYJDGr3vZ0+rFIqyicRgR/+1/1Jf8gPxd25IDPn
	 tBNitrEdLsRmw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B220143291
	for <op-tee@lists.trustedfirmware.org>; Mon, 13 Apr 2026 09:03:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PsH8TLK/;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C4F160180;
	Mon, 13 Apr 2026 09:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97609C116C6;
	Mon, 13 Apr 2026 09:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776071007;
	bh=0sOX8GKgRbRUwdzVDoXTccQF5IzCxIxM+r1xkMMHTZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsH8TLK/CS0f6wGP6Rzc0K7rbFX2d2dJbKZyEHh+Y9ytqG3NGUpPaSxDYNQ46Tp7N
	 vJTiet+KUIGUc+ojY4Qymk8YZ9R41HSBuYE8o1t5mEPOHHF98zKYQ6XlO/toMuQPDQ
	 SefRMoXaTxaO75NhY501/mew2QimrQy1qSd5uCFqY36aXPsH4NpUo6RmmtBtHf+847
	 c9Ec8N1FO+eACjVSfjuWPcTknt/t7C6a+fxOTjNYSJTVl3kuQzWL0sk551Q50bdmzo
	 E9KjQG9yg2ykd+/WwarONjc/lcx5UlbXfVUh+vCk6o962EMyKWPjhU6fW/YLQLGoH3
	 vyFXWVGAzOWCA==
Date: Mon, 13 Apr 2026 14:33:21 +0530
To: Georgiy Osokin <g.osokin@auroraos.dev>
Subject: Re: [PATCH] tee: shm: fix shm leak in register_shm_helper()
Message-ID: <adyxWXpcxJ3f0w6G@sumit-xelite>
References: <20260408155203.817744-1-g.osokin@auroraos.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408155203.817744-1-g.osokin@auroraos.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B220143291
X-Spamd-Bar: ---
Message-ID-Hash: HYR4SNNOH4MAGV2MCN4JKTUZEG7RURX6
X-Message-ID-Hash: HYR4SNNOH4MAGV2MCN4JKTUZEG7RURX6
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, s.shtylyov@auroraos.dev, stable@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HYR4SNNOH4MAGV2MCN4JKTUZEG7RURX6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Apr 08, 2026 at 06:52:03PM +0300, Georgiy Osokin wrote:
> register_shm_helper() allocates shm before calling
> iov_iter_npages(). If iov_iter_npages() returns 0, the function
> jumps to err_ctx_put and leaks shm.
> 
> This can be triggered by TEE_IOC_SHM_REGISTER with
> struct tee_ioctl_shm_register_data where length is 0.
> 
> Jump to err_free_shm instead.
> 
> Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
> Cc: stable@vger.kernel.org
> Cc: lvc-project@linuxtesting.org
> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> ---
>  drivers/tee/tee_shm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the fix, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index e9ea9f80cfd9..6742b3579c86 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -435,7 +435,7 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>  	num_pages = iov_iter_npages(iter, INT_MAX);
>  	if (!num_pages) {
>  		ret = ERR_PTR(-ENOMEM);
> -		goto err_ctx_put;
> +		goto err_free_shm;
>  	}
>  
>  	shm->pages = kzalloc_objs(*shm->pages, num_pages);
> -- 
> 2.50.1
> 
