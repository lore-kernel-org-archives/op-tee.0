Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B66C87FD2
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 10:44:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B2D0B4FC11
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1754909049;
	bh=RL02yIA3ZBoae2LqkUhd8Ztvv3r4XMzdn9pwoj0qZ8c=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ieOws56HmJcyA6KWCtjqkPmr3otFZsz5bIK/V1P5XV1V4TiA1pZdZtberpMT1FUMW
	 iXjNJggukrkTW1U+GfKpZC55oFiJ5hXAnI5hs2aXv6oZsdsCmetQ8YeiBmDp/UweTr
	 z4B10pCS2zkOOQB0t30V0P2N5Cjn0RkcsA3lvvyybhi5uVOI2HDWOvb37fo3OmCsXe
	 +EVHraUNzrrjq8sR3YgBs1ViskPVvSzhczpB6GuI59IVmVhwFaL1SNytWf+vsaRGlz
	 oxUzdhnpLyRbSkoV0xHJAbstXR7QupMf+ujCG7L0RmnpznvYtAzCSIYAmleM4/TFgN
	 i/CYJ+CeqNxDg==
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 14A653F379
	for <op-tee@lists.trustedfirmware.org>; Mon, 11 Aug 2025 10:43:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H8lbw34h;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 751195C61F5;
	Mon, 11 Aug 2025 10:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D44C4CEF6;
	Mon, 11 Aug 2025 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754909033;
	bh=RL02yIA3ZBoae2LqkUhd8Ztvv3r4XMzdn9pwoj0qZ8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8lbw34hdkpGir/mUnbPkKHrU47JWl62cqXWh2jqVyHsra+vo0oXX5WrJqN66IMFC
	 ZF+HmNeQGndj0vZwhvCKoiOnuoawfzCRol9RiUpROuEq7Wmc1iAVAKAZPGT7P6ztCU
	 uMvylJIN6fvceujXrkp2RnFuIsuofaRCQDDuG+hanVsSPVwmMZYzbMHxvkQRqyLJ/Y
	 WW17OWQA43I8ZOOdXGwLfbKXVCFXGHYnsPm3LwK+qIss/C0oPe0JTH4+OsnlJ/BWFj
	 jkjTdeCvdSU0kK6nMxLr3/Tv6o7iXJ5Oj83iPkGlqHalu0E56QHxpqMmAtjn29oXC6
	 WpoV4fDor+yAg==
Date: Mon, 11 Aug 2025 16:13:47 +0530
To: Sungbae Yoo <sungbaey@nvidia.com>
Subject: Re: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Message-ID: <aJnJY5hV-Pul8QzN@sumit-X1>
References: <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
 <aJmChHa_BxNO74cB@sumit-X1>
 <SJ2PR12MB8689AE34D74E657EFC3055F7B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR12MB8689AE34D74E657EFC3055F7B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
X-Rspamd-Queue-Id: 14A653F379
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	RCVD_IN_DNSWL_HI(-0.50)[139.178.84.217:from];
	R_SPF_ALLOW(-0.20)[+ip4:139.178.84.217];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15830, ipnet:139.178.80.0/21, country:NL];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: BVUNFFB4JYPSWVO5R5QTEZXV3XRVY422
X-Message-ID-Hash: BVUNFFB4JYPSWVO5R5QTEZXV3XRVY422
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BVUNFFB4JYPSWVO5R5QTEZXV3XRVY422/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, Aug 11, 2025 at 10:00:17AM +0000, Sungbae Yoo wrote:
> Fixes optee_ffa_api_is_compatbile() to optee_ffa_api_is_compatible()
> because compatbile is a typo of compatible.
> 
> Fixes: 4615e5a34b95 ("optee: add FF-A support")
> 

This blank line should be dropped.

> Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>
> 

With that fixed, feel free to apply:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index f9ef7d94cebd..a963eed70c1d 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -657,7 +657,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
>   * with a matching configuration.
>   */
> 
> -static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
> +static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
>                     const struct ffa_ops *ops)
>  {
>     const struct ffa_msg_ops *msg_ops = ops->msg_ops;
> @@ -908,7 +908,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>     ffa_ops = ffa_dev->ops;
>     notif_ops = ffa_ops->notifier_ops;
> 
> -   if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> +   if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
>         return -EINVAL;
> 
>     if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> --
> 2.34.1
