Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1D8EA3F00
	for <op-tee@archiver.kernel.org>; Tue, 10 Feb 2026 05:22:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D59744328A
	for <op-tee@archiver.kernel.org>; Tue, 10 Feb 2026 05:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1770700951;
	bh=glo5WwPN7zuxUs13l+Gkpb+FSft51JklOnxQCxcPTAA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uVBk9OVckwDX1Xbr/rcJsgHvZW/pdpSV3mi5Zx4m83yZNUWhQRNzsgzE1D1Wo7+QL
	 Rgm6WkmJ3QiwuDfEWEFlrYI5eve6PXMYfviLmZvGABjIjisNsoJy+StkKxU1F6r/Pz
	 wAQNyqBjzzJ2jP4Wkc+RAubeexrjCqnVWBym3/1qMyFANPzpMNPd7gXz+vlkMKvA2z
	 6p2pVvqHLRqi23Zei6PQ3iMIv+WyfbugD+QoN2sbhjLnyFonpkAd+e6UtzMPuC1g38
	 wa9PFyDRWHbN0ray3FkAmUhDhRhkUwdGJBYnU74XTs22SyGjNf87Yf/NEfgCS8fj2t
	 GbLFEPWyBF4tw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AA1A942D86
	for <op-tee@lists.trustedfirmware.org>; Tue, 10 Feb 2026 05:22:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OEdxU484;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 241FD6013C;
	Tue, 10 Feb 2026 05:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397D8C19421;
	Tue, 10 Feb 2026 05:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770700927;
	bh=glo5WwPN7zuxUs13l+Gkpb+FSft51JklOnxQCxcPTAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEdxU484MqZsTrEdVZpGu/8ENWII1kfqKlYUu2ZpvWjh0ENVIod2TylMPL/lXF/HT
	 p9f00xw7EsJYEzngZEiS9V3uGgQMtx4Sh9w1HTfP1hgUn2jOti75rKQrX56MNsWc13
	 QvmQ6XLFN0L7UQACvaJWNnnRTff7C2wj4/KD9W7Mt9ikfERrd3DLDtEbvDF6LTODAx
	 GhtDWnt7D0+XLWRu8IK8mhdwxY25VM63RAc9UjDi9YJzR1PzAAlnvnNXUq6JaoifUy
	 bah01WWs0jULbJUrtePZd4Nsd1i05OGKr1GYk7EHnBAM4XuTxCP6eezRPyijKugl9a
	 SP5K3pxToywoQ==
Date: Tue, 10 Feb 2026 10:52:00 +0530
To: rouven.czerwinski@linaro.org
Subject: Re: [PATCH 1/3] optee: simplify OP-TEE context match
Message-ID: <aYrAeEiqG7iwXm_w@sumit-xelite>
References: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
 <20260126-optee-simplify-context-match-v1-1-d4104e526cb6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-optee-simplify-context-match-v1-1-d4104e526cb6@linaro.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AA1A942D86
X-Spamd-Bar: ---
Message-ID-Hash: Z3NIRL5ZEBVRIRY4NOVJWJQMQZLC4BVL
X-Message-ID-Hash: Z3NIRL5ZEBVRIRY4NOVJWJQMQZLC4BVL
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Z3NIRL5ZEBVRIRY4NOVJWJQMQZLC4BVL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, Jan 26, 2026 at 11:11:24AM +0100, Rouven Czerwinski via B4 Relay wrote:
> From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> 
> Simplify the TEE implementor ID match by returning the boolean
> expression directly instead of going through an if/else.
> 
> Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> ---
>  drivers/tee/optee/device.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 950b4661d5df..4c85b04d6004 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -13,10 +13,7 @@
>  
>  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>  {
> -	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> -		return 1;
> -	else
> -		return 0;
> +	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
>  }
>  
>  static int get_devices(struct tee_context *ctx, u32 session,
> 
> -- 
> 2.52.0
> 
> 
> 
