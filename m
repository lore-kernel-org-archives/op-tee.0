Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE910D41D74
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 00:55:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E179F45B27
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 00:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765500943;
	bh=ImNiUJg9EtXcUshmWqXKE8CX1Seb/doZFlOMj0aesag=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3cjThy/M5Sj3Nyv3UCwx3elMluakGiwQi79vQsKdrV0YDVf99FbM920m5nmqnObab
	 AZ7xfpUNrsTXiqGCvfmn4/GBvdQ8tWzD2fVSXfruyX8qbOxwyMWjc87wsxq3lS+hWA
	 T+pH9Wz1DqoV60UbYvJlR8w8SpETd/AaX/tqLOBVqEfXlEAlifhJw+yKoxD+1Ov4hu
	 jeJzWMKqPIh53n0Vg7ymdAjE34k3FwyKu/d6EikCZieE4EcWkZealTIpzgirRMwQn7
	 GEnaKL2frzRWRpZVtYowDK10yafNFBAAKJtRfiidPpl/I+lTliJzFCG+mmtWRt07NW
	 cz3Ffhb9YXjlQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BC16742E6B
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Dec 2025 00:55:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RjzBSwah;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E93D60121;
	Fri, 12 Dec 2025 00:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26265C4CEF7;
	Fri, 12 Dec 2025 00:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765500929;
	bh=ImNiUJg9EtXcUshmWqXKE8CX1Seb/doZFlOMj0aesag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjzBSwahr1WYnQkSMxhNcq3KXkm9k4+BcQKk4iKKm75+eBjmj0hNJ7X510XvwFMIH
	 zv8iqY33hJyGA8kELK6fIjy9sQwnELpxZvw7Geq8W913rCk8PTqYOHKICuc4MQWfy7
	 mXYkDujbs66Ld/fZTGurUaqTb6g5peENujt5OG+vKN+fBndoRwIBjR5dlGAP309R3j
	 OXM1fxGHWjN28Ce2MV3snluLG9PBAHCxcmCI02X3xqfNKgNv45ydg/j7hW2orHzURR
	 lop8Sr644vAEN8ySbD89aZmAzyUOJ1vGI6mS/0Opz04/I8DMjlJkJ4SfAQ3D4Sump8
	 wfD5V1cc7J9vg==
Date: Fri, 12 Dec 2025 09:55:23 +0900
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] tee: qcomtee: call: Fix confusing cleanup.h syntax
Message-ID: <aTtn-x0hh18V7n7J@sumit-X1>
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[100.75.92.58:server fail];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from,100.75.92.58:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BC16742E6B
Message-ID-Hash: YJGCSLFXQKQE2S4ZGTLGGYTVD5243SC4
X-Message-ID-Hash: YJGCSLFXQKQE2S4ZGTLGGYTVD5243SC4
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YJGCSLFXQKQE2S4ZGTLGGYTVD5243SC4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, Dec 08, 2025 at 03:08:45AM +0100, Krzysztof Kozlowski wrote:
> Initializing automatic __free variables to NULL without need (e.g.
> branches with different allocations), followed by actual allocation is
> in contrary to explicit coding rules guiding cleanup.h:
> 
> "Given that the "__free(...) = NULL" pattern for variables defined at
> the top of the function poses this potential interdependency problem the
> recommendation is to always define and assign variables in one statement
> and not group variable definitions at the top of the function when
> __free() is used."
> 
> Code does not have a bug, but is less readable and uses discouraged
> coding practice, so fix that by moving declaration to the place of
> assignment.

Okay I see but..

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/call.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index 65f9140d4e1f..8f8830f0df26 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -395,9 +395,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  				 struct tee_ioctl_object_invoke_arg *arg,
>  				 struct tee_param *params)
>  {
> -	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
>  	struct qcomtee_context_data *ctxdata = ctx->data;
> -	struct qcomtee_arg *u __free(kfree) = NULL;
>  	struct qcomtee_object *object;
>  	int i, ret, result;
>  
> @@ -412,12 +410,14 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  	}
>  
>  	/* Otherwise, invoke a QTEE object: */
> -	oic = qcomtee_object_invoke_ctx_alloc(ctx);
> +	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
> +		qcomtee_object_invoke_ctx_alloc(ctx);
>  	if (!oic)
>  		return -ENOMEM;
>  
>  	/* +1 for ending QCOMTEE_ARG_TYPE_INV. */
> -	u = kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
> +	struct qcomtee_arg *u __free(kfree) = kcalloc(arg->num_params + 1, sizeof(*u),
> +						      GFP_KERNEL);

..this makes the code less readable with variable declarations floating
within the function. I would rather favor to not use the cleanup.h construct
but use explicit kfree() invocations instead like it's done in all other
allocations in the TEE subsystem.

-Sumit

>  	if (!u)
>  		return -ENOMEM;
>  
> @@ -562,9 +562,8 @@ static int qcomtee_supp_send(struct tee_context *ctx, u32 errno, u32 num_params,
>  
>  static int qcomtee_open(struct tee_context *ctx)
>  {
> -	struct qcomtee_context_data *ctxdata __free(kfree) = NULL;
> -
> -	ctxdata = kzalloc(sizeof(*ctxdata), GFP_KERNEL);
> +	struct qcomtee_context_data *ctxdata __free(kfree) = kzalloc(sizeof(*ctxdata),
> +								     GFP_KERNEL);
>  	if (!ctxdata)
>  		return -ENOMEM;
>  
> @@ -645,12 +644,12 @@ static void qcomtee_get_version(struct tee_device *teedev,
>  static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>  					  u32 *version)
>  {
> -	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
>  	struct qcomtee_object *client_env, *service;
>  	struct qcomtee_arg u[3] = { 0 };
>  	int result;
>  
> -	oic = qcomtee_object_invoke_ctx_alloc(ctx);
> +	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
> +		qcomtee_object_invoke_ctx_alloc(ctx);
>  	if (!oic)
>  		return;
>  
> -- 
> 2.51.0
> 
