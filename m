Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B26C9EC77
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 11:26:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 064074327D
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1768217193;
	bh=8VF91cn6n+Hdw0u+8yUozg+3jgNGOkOZI/CN7HHlD9c=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=aHeqKUXb6ZuXgjc+i2sY9cDfY6xXe07PolRWpAh0qreJ376rsIetN/8CyF0mr8xWD
	 N8ipvgYUFQllWIeJc2F2eOiQzACRr1op3TdVSprBOPEwKbO0KlfLUGIjP9WsJ3wEnl
	 h6FUzg+LpKoXiXNRoZx69V3yOvBk5m73igmWcWRAp/hN5tr5Z3PWgdTtDLtgRKKciJ
	 Y2gu4q5S+3XhiJ41LZ5PzNZIc8DaMeefuxLUu4tPjXAf9aa2HaAHD+RrCexslH5rLP
	 3SW0EIdEeRCSG6fbTr9tnNLwIWBz8lqkU1lElXcT56W+TTeHtZgJN63U7Meoh88r7b
	 P9mJLMIUASfBw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CB0F243275
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 11:26:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VJhb1NNq;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 58ADE6001D;
	Mon, 12 Jan 2026 11:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A343C16AAE;
	Mon, 12 Jan 2026 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768217175;
	bh=8VF91cn6n+Hdw0u+8yUozg+3jgNGOkOZI/CN7HHlD9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJhb1NNqkMBjxDwhoqrSnqvpl6qCkOEWLlTqQd6yPzQjxDlv3jquNHTY2Z6TJ3g1e
	 TFKeL36ssN92pqywC/2aXh40DW/TVoiRJR/Ixu3qushWalgbehyyT1J+YTTo/veeEY
	 tDyDiSXPTAvGT+4jxY0LVE0sroRq2EdnzBp91vhMl9g6yXHX8AJKwGMKw0gCgZOTqD
	 ZujtXi2Yb9tERaYYY0z5ZZt0LUmWUfMF02f6uzGNjv8fLDiQ7XgNtonfeQBn6jJjDG
	 DdtotWEFcuvc3z1eF/rvmn9ZfZL988/UdIeM3r1CK0LzhqPtWxBjU6fIC6kCuqNCwE
	 F9QOn3hySUPjg==
Date: Mon, 12 Jan 2026 16:56:10 +0530
To: Colin Ian King <coking@nvidia.com>
Subject: Re: [PATCH][next] optee: make read-only array attr static const
Message-ID: <aWTaUvGu9dlvnJO9@sumit-xelite>
References: <20260109154442.421248-1-coking@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109154442.421248-1-coking@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CB0F243275
X-Spamd-Bar: ---
Message-ID-Hash: HSQRK7Z47MBYZSVJ6WLPRIWVVXVS2NY5
X-Message-ID-Hash: HSQRK7Z47MBYZSVJ6WLPRIWVVXVS2NY5
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HSQRK7Z47MBYZSVJ6WLPRIWVVXVS2NY5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Fri, Jan 09, 2026 at 03:44:42PM +0000, Colin Ian King wrote:
> Don't populate the read-only array attr on the stack at run
> time, instead make it static const.

Is there any value add to do this? AFAIK, the static local variables
aren't preffered.

-Sumit

> 
> Signed-off-by: Colin Ian King <coking@nvidia.com>
> ---
>  drivers/tee/optee/rpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index 97fc5b14db0c..1758eb7e6e8b 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -43,7 +43,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  	struct i2c_msg msg = { };
>  	size_t i;
>  	int ret = -EOPNOTSUPP;
> -	u8 attr[] = {
> +	static const u8 attr[] = {
>  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>  		TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> -- 
> 2.51.0
> 
