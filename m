Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525BDCA1013
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 05:21:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8F844431C4
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 05:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1758259284;
	bh=T7nSh+shj7guGdolih7Yv5v9HrzkJVn157Nh6VJh8Yw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AZZ3fkNZORX52CK3aEa9FkW/rxeOD+GlMLak1uwHSCJwfT18llht2VpJlgToDnLdG
	 pMI594OfSQ7Rq6hEPEDtRc0OxYolgnwGRXbg7lAYpLYJwxOtBM0S39axRtqwXZdvdu
	 bzygOFd9MtqMC26IDVkzp4xcLoNekkRfITtcIGsQ3Fi8pT1WDQOFP8da+YBt2+wSOd
	 qbg9oOTHXv9slslvOsbIgoBXBrHvg1je4djxBaWDcEqliioMnxwf2fEcmXCclVOyJS
	 wvEkL44gRvBkMBDaV/7Pw9p9XztHKy8pKzYLJnFOX4SgVSGoFVBy2TnR3TBtosFFwx
	 IYWKRirJdCJ2Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8C2F740B16
	for <op-tee@lists.trustedfirmware.org>; Fri, 19 Sep 2025 05:21:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=igLixv5H;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B730840048;
	Fri, 19 Sep 2025 05:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AF0C4CEF0;
	Fri, 19 Sep 2025 05:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758259267;
	bh=T7nSh+shj7guGdolih7Yv5v9HrzkJVn157Nh6VJh8Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igLixv5H7kLt9hMkzcGGIBbYUNMAGH+D3As4VpYWKjN210BxqXmrQwIhbMp1zDOGv
	 UffJScAL3V9ytoeLEXRtG5MjVa19Vuda1M83ueSc7Poc3NvzwHizjEA44Kk607ADDy
	 HgVdqJRq9YMT3DN89JDb0NIObnGmPoLoenKeWynYhttdvG3mS81jD/iPFT6Y0WsxMG
	 wIFdaOu8HebttjbnqwrYOJ5PIJahua+jYd/VXGW6Dl7yoY/bX+xw+FKurtS+8F15CU
	 RQF3M1IadDYbHcz1YlBZlJ2ERV5pk2gesPbjF42k81/+bAeUqTzuTzPbN66/ElHiTb
	 ED4Un1P4J0stQ==
Date: Fri, 19 Sep 2025 10:51:01 +0530
To: Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
Message-ID: <aMzoPc67ws5NMpKS@sumit-X1>
References: <aMvV4kK386Sni10i@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMvV4kK386Sni10i@stanley.mountain>
X-Rspamd-Queue-Id: 8C2F740B16
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: SWZYDEWGP6VSZ3N4VQCD7674WZJISAAD
X-Message-ID-Hash: SWZYDEWGP6VSZ3N4VQCD7674WZJISAAD
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SWZYDEWGP6VSZ3N4VQCD7674WZJISAAD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Sep 18, 2025 at 12:50:26PM +0300, Dan Carpenter wrote:
> Re-order these checks to check if "i" is a valid array index before using
> it.  This prevents a potential off by one read access.
> 
> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/tee/qcomtee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index cc17a48d0ab7..ac134452cc9c 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
>  	}
>  
>  	/* Release any IO and OO objects not processed. */
> -	for (; u[i].type && i < num_params; i++) {
> +	for (; i < num_params && u[i].type; i++) {
>  		if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
>  		    u[i].type == QCOMTEE_ARG_TYPE_IO)
>  			qcomtee_object_put(u[i].o);
> -- 
> 2.51.0
> 
> 
