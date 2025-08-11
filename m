Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CF1C87FDA
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 05:41:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6AC234FC98
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 05:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1754890903;
	bh=AGpSbbO9BlUDuEdBA3XSdDky7H21WLK9dwd7KKSaKY4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qsHcVRge1LFiDfnTwej28xRlVVdpekscjTSPUSwBqFmy7iGUpoVw3Gni1ioPh51WM
	 LmNzBzYAajs1xKRep1rWzHBXEvE0sk7VkHtmMwE+rIeS01NglGbeD2cKw9lKhJ3KSs
	 KeD7cOFy+8E2OW8dyhpql6uQzvIfleLc8CcJAx2NHRhn8ZJl9gkNK635U7oY7ObuDB
	 UVcHq3ZZ2I3yx71JTxQEioyIjR1gDvVx1pnu+kbnnVR0cUuTfRtRueV7S/LReN2hMA
	 8hf6kDNE0zHyWlPmDS1hoIkEISdG9QyeowMu+5yCzhobJRI/ZkTq8GKmWHKm2XVXfY
	 8Fa/lMlmBgbRQ==
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 188DA3F08F
	for <op-tee@lists.trustedfirmware.org>; Mon, 11 Aug 2025 05:41:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D5J16kuK;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8524CA56917;
	Mon, 11 Aug 2025 05:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C79C4CEED;
	Mon, 11 Aug 2025 05:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754890889;
	bh=AGpSbbO9BlUDuEdBA3XSdDky7H21WLK9dwd7KKSaKY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5J16kuKWp5ArZw48/USMiJJy1fDJMzKNmM625koO4HBZoXxYOw4B+YjgAl4G0Ctw
	 rmzjyXzeBDqOcnaRJZu5ssFTeygBd3DaSvntTI0nT6iiHU+ac3qlZjR8yKxxa5lDrP
	 odKGUC9XNhaaDqpuPE7/yTw4WpuVfWDsDNSTISMtE9HL4tjmlpU5OcR9rAbXvyvCXZ
	 Xh17VPBqUwxcy4xSuhVX2LxfMTSlv8gGXbm8Fd20zXsM1cMFVEP0HA1I4u3HL8JoYW
	 biJMEiyrfilhYzVfi7gDonBPbG/mSj6XyLwe+G0jdYsBQHHcHOELNTuUgLTJ0IRQ4i
	 jGDwDTwamGbHA==
Date: Mon, 11 Aug 2025 11:11:24 +0530
To: Sungbae Yoo <sungbaey@nvidia.com>
Subject: Re: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Message-ID: <aJmChHa_BxNO74cB@sumit-X1>
References: <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
X-Rspamd-Queue-Id: 188DA3F08F
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:147.75.193.91];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15830, ipnet:147.75.193.0/24, country:NL];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[147.75.193.91:from];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: IA52GFN6JWKAEE2JTWWFAGEI4S25XEH6
X-Message-ID-Hash: IA52GFN6JWKAEE2JTWWFAGEI4S25XEH6
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IA52GFN6JWKAEE2JTWWFAGEI4S25XEH6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Aug 06, 2025 at 12:47:35PM +0000, Sungbae Yoo wrote:

Add some commit description.

> Fix: commit 4615e5a34b95 ("optee: add FF-A support")

Correct fixes tag, should be instead:

Fixes: 4615e5a34b95 ("optee: add FF-A support")

-Sumit

> Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>
> 
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
>                                         const struct ffa_ops *ops)
>  {
>         const struct ffa_msg_ops *msg_ops = ops->msg_ops;
> @@ -908,7 +908,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         ffa_ops = ffa_dev->ops;
>         notif_ops = ffa_ops->notifier_ops;
> 
> -       if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> +       if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
>                 return -EINVAL;
> 
>         if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> --
> 2.34.1
