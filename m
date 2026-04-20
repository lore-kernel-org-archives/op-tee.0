Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A6CF588C2
	for <op-tee@archiver.kernel.org>; Mon, 20 Apr 2026 12:29:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E76E844A1F
	for <op-tee@archiver.kernel.org>; Mon, 20 Apr 2026 12:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1776688174;
	bh=TjpqsBK8zzamLpyz9+s5hoi4/jVAJ12AOShG0716e1g=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xPHm77Xu690Z87GQjD34N0GMsL8L0kJecnrMasYtQeNJdl9W6QP5+2OXs0K6zrR/Y
	 TvyXC1SLUGmXh64UAdvFWws998TI43YZY89Qbf92tjqKJHtfdFWzdT4ZUWuVrEQxG4
	 SRRK0iAXuuIeIjXLjEowiNaApXaBXzWZemTPQ+zwPZEWgvpAD6s4rJRwqWKKNWz2UU
	 u/qCll1d8BLmRXrrE0VZ9iTEEZlB4kSKSRpID9qWBZ3TMzCN7/4a5ZQR6mMQ65EWpm
	 usOmCPbW6m0ybqYjyq8ozWlBWy74Ms3UHm59KZjq5toFzw6zto1xnVFP2W/QUgM94U
	 IZI2M8oecB7Lg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C18054326A
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Apr 2026 12:29:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qlT38oVO;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3729143989;
	Mon, 20 Apr 2026 12:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC3C2BCB6;
	Mon, 20 Apr 2026 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776688167;
	bh=TjpqsBK8zzamLpyz9+s5hoi4/jVAJ12AOShG0716e1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlT38oVOJS+7xYmfCVi+X6ww7o2PPLQmsfevNenmh75zbkuf5WSWN93F/4scfDyfW
	 As+XSzGGLYNhsjISB1Feqj0/9Rhz40KwIEiMWV3LZGG2BMj7wpMlCmsq9Uc4eSNhyP
	 +UtWK4RvvEB+9DXvhWe3UEEgnaQPCeBoaoutg5CFA85bAVvMqF6kv0Ycp/vZ3f+50Z
	 dYBhdXyMZM/lRlf5zr3EUZwyN13tBaLz1NsEQxCM/cm2x7MzzrCabaF/2K187kAQ3w
	 vhjcznDiAD24LqqDMVVTSd6eiLah1113OS4vwMgtYrnYaMOu11XMDj8T25XHGRLVsE
	 MCC05ubE58zHg==
Date: Mon, 20 Apr 2026 17:59:22 +0530
To: Hirokazu Honda <hiroh@chromium.org>
Subject: Re: [PATCH] tee: optee: Allow MT_NORMAL_TAGGED shared memory
Message-ID: <aeYcIpw6lyUnmIsN@sumit-xelite>
References: <20260416221819.3600289-1-hiroh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416221819.3600289-1-hiroh@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C18054326A
X-Spamd-Bar: ----
Message-ID-Hash: GJS2FORHA23JRZAUE4PUKLNQJ5JJEQRI
X-Message-ID-Hash: GJS2FORHA23JRZAUE4PUKLNQJ5JJEQRI
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GJS2FORHA23JRZAUE4PUKLNQJ5JJEQRI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Apr 16, 2026 at 03:18:19PM -0700, Hirokazu Honda wrote:
> From: Hirokazu Honda <hiroh@chromium.org>
> 
> On ARM64, shared memory can have MT_NORMAL_TAGGED attribute when using
> the Memory Tagging Extension (MTE). The OP-TEE driver needs to
> recognize this as normal memory to allow sharing such buffers with the
> Secure World.
> 
> Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
> ---
>  drivers/tee/optee/call.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 9effe88049e9..e046aff61828 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -602,7 +602,8 @@ static bool is_normal_memory(pgprot_t p)
>  	return (((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC) ||
>  		((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEBACK));
>  #elif defined(CONFIG_ARM64)
> -	return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
> +	return ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL)) ||
> +	       ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED));
>  #else
>  #error "Unsupported architecture"
>  #endif
> -- 
> 2.54.0.rc1.513.gad8abe7a5a-goog
> 
