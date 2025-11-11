Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401FACCF9E3
	for <op-tee@archiver.kernel.org>; Tue, 11 Nov 2025 06:46:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5540A5004E
	for <op-tee@archiver.kernel.org>; Tue, 11 Nov 2025 06:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1762843610;
	bh=S8NL42wQ9BP/YnBr2kNkscTRPs3arYtcaxRYzrae+28=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=t1HrTy15AbDF9rStrQM5DMc9t4SY4t/FSi+7ekb2rRyp54e57kRPUhwxGHzAwubVT
	 X37i+y7WW0vB4tUdMmwvp68UKyx9nD3sIy6U7fBLRcw/yww2nBYeFAVp9GGXs7K6hc
	 ALP9Jd5XDJqPyiwz5XypRQp3/XS8ezkwTD6LAG831X3NJpXdLWfSQYxj3CMIqdjXwW
	 PRw6ztU3YuSov+JnXcdFMshIpjdtxTZBAJWYUlMbJkuKTQnnZY1dmjZQMBrONm5nvI
	 uVT1D0SOuGwZTfkSjw4Lx8LhAptwi+R1xrL3Gk0TlXhl9aMShuSW2ZRvjytNk8N8zN
	 EYSsuUf/k7zLQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 30D6E4FFA7
	for <op-tee@lists.trustedfirmware.org>; Tue, 11 Nov 2025 06:46:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VHj0fVFM;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A380419CF;
	Tue, 11 Nov 2025 06:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB37C116D0;
	Tue, 11 Nov 2025 06:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762843599;
	bh=S8NL42wQ9BP/YnBr2kNkscTRPs3arYtcaxRYzrae+28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHj0fVFM0JMpXzeg92ClDm8ztAFvZ3XoCd4IeyozoD6bTmKO9945kho/d3oD86VDv
	 eLrywXMONm7KBHc1m8qFz4xJrpjUq+89IH1y4kAZdQgPzZ++hDr8mF8H2FGb3NsCbz
	 ZsGXYaVmOdFSnkZaHrnV00bvzcqRViYAZcgJ091QsN31DglGf40IgRM9Zwrv+z72pp
	 O7W7qIyCgaz4XCB0Pez0MwNiw46t4ZfE+CsCkKmSp4xqtjGxUcmTSxRc0kY8zjGPMc
	 pNTQFFgJHLJzrCMdw5B8kZMlKQ1Q4j1ISqYdw2KNDe9V8Pv4h+cTrHMaDxcENCNnWU
	 /BIbWO6QStHMw==
Date: Tue, 11 Nov 2025 12:16:34 +0530
To: Ally Heev <allyheev@gmail.com>
Subject: Re: [PATCH v2] tee: fix uninitialized pointers with free attribute
Message-ID: <aRLbymGzR-dTAjco@sumit-X1>
References: <20251110-aheev-uninitialized-free-attr-tee-v2-1-023ffba9ea0f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-aheev-uninitialized-free-attr-tee-v2-1-023ffba9ea0f@gmail.com>
X-Spamd-Bar: -----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 30D6E4FFA7
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: GUBDEG3PXZWX75UESIP2NCYZOLYJSK47
X-Message-ID-Hash: GUBDEG3PXZWX75UESIP2NCYZOLYJSK47
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GUBDEG3PXZWX75UESIP2NCYZOLYJSK47/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, Nov 10, 2025 at 08:47:30PM +0530, Ally Heev wrote:

For the subject, try to follow the convention:

tee: qcomtee: fix ...

> Uninitialized pointers with `__free` attribute can cause undefined
> behavior as the memory assigned randomly to the pointer is freed
> automatically when the pointer goes out of scope.
> 
> tee doesn't have any bugs related to this as of now, but

s/tee/qcomtee/

> it is better to initialize and assign pointers with `__free`
> attribute in one statement to ensure proper scope-based cleanup
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
> Changes in v2:
> - initializing variables to NULL at the declaration
> - Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com
> ---
>  drivers/tee/qcomtee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index ac134452cc9cfd384c28d41547545f2c5748d86c..65f9140d4e1f8909d072004fd24730543e320d74 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -645,7 +645,7 @@ static void qcomtee_get_version(struct tee_device *teedev,
>  static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>  					  u32 *version)
>  {
> -	struct qcomtee_object_invoke_ctx *oic __free(kfree);
> +	struct qcomtee_object_invoke_ctx *oic __free(kfree) = NULL;
>  	struct qcomtee_object *client_env, *service;
>  	struct qcomtee_arg u[3] = { 0 };
>  	int result;
> 

The change itself looks fine to me.

-Sumit

> ---
> base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
> 
> Best regards,
> -- 
> Ally Heev <allyheev@gmail.com>
> 
