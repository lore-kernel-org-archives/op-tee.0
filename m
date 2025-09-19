Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A566CAC5A5
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 05:22:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 840CD43069
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 05:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1758259336;
	bh=aGuXua3RqBqMbkEsqs3c662eE1wX94ZzkiZiXLaHhzQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=aKLgkc9MAaqvKjhEdXaYjz0o+RCc+c0Ug6UysjUlaYmiYhZL5Gy0hKjGYUYoWPngR
	 nCxpReDGyJcYR+H9DdL4FmU2v6ILWieJGhq8YBgy0cFH7lhv3MR8ljPWvN+80YB6ck
	 zrHCgo8ui0M9lLWTSTpxx2K6G2D0VgvuE6roUAqp3Jx+rcxm4crGjrX52E2BW3NoQz
	 wVCgG34aGryGpbzhw35JVnS0lZYqXyo4tesZ9JcboarFeaVZaq9CPKa83aFxskTKcV
	 96SXpR/wW8CEptmf2KDLZjMUPWJ/JXXAHE82Ng08j0s4gbJEMcJ31YVrW++Xng5L2d
	 bShni6MUQTb9Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CD3B543069
	for <op-tee@lists.trustedfirmware.org>; Fri, 19 Sep 2025 05:22:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=u6D6N0PI;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3900B418F4;
	Fri, 19 Sep 2025 05:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F53C4CEF0;
	Fri, 19 Sep 2025 05:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758259322;
	bh=aGuXua3RqBqMbkEsqs3c662eE1wX94ZzkiZiXLaHhzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6D6N0PIhaCCFjsH08OGh0t8fxy+kTrdSXnJl8UqJ7CpLcYuL31JMz4XScQcA6CAr
	 SbY0YldCPFdK/lYnBHZIs9qmyefWPS5xXYPQfngKZTub05Q3lKvvYqhCmBjAF8ljGe
	 H885r+ZhMNKuKmB+peHYhXHLDihH1clX6FUtIFIdlA4eTTrAouFQqu8Q/vFqhSFeIu
	 IFjCnDkQcdye/T+TYw+5DMC14mKwakTDbd9QmTdoEIceelk9px8/0/5uAkTL6JUerk
	 IPB+FzfbZTSeARLRMQZ8nS88CYIz3LffHT/EGT7Qj/bc8Dh5U5Q7qYl/WQfpaZwt4t
	 XOEynmnopKDVw==
Date: Fri, 19 Sep 2025 10:51:56 +0530
To: Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] tee: qcom: return -EFAULT instead of -EINVAL if
 copy_from_user() fails
Message-ID: <aMzodGIvL88HNi0d@sumit-X1>
References: <aMvV8WIKnqLN3w6R@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMvV8WIKnqLN3w6R@stanley.mountain>
X-Rspamd-Queue-Id: CD3B543069
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
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
Message-ID-Hash: NIZTZ6CHFY3E7WDGKTBUVXAJB66RODVG
X-Message-ID-Hash: NIZTZ6CHFY3E7WDGKTBUVXAJB66RODVG
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NIZTZ6CHFY3E7WDGKTBUVXAJB66RODVG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Sep 18, 2025 at 12:50:41PM +0300, Dan Carpenter wrote:
> If copy_from_user() fails, the correct error code is -EFAULT, not
> -EINVAL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/tee/qcomtee/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> index 783acc59cfa9..b6715ada7700 100644
> --- a/drivers/tee/qcomtee/core.c
> +++ b/drivers/tee/qcomtee/core.c
> @@ -424,7 +424,7 @@ static int qcomtee_prepare_msg(struct qcomtee_object_invoke_ctx *oic,
>  		if (!(u[i].flags & QCOMTEE_ARG_FLAGS_UADDR))
>  			memcpy(msgptr, u[i].b.addr, u[i].b.size);
>  		else if (copy_from_user(msgptr, u[i].b.uaddr, u[i].b.size))
> -			return -EINVAL;
> +			return -EFAULT;
>  
>  		offset += qcomtee_msg_offset_align(u[i].b.size);
>  		ib++;
> -- 
> 2.51.0
> 
