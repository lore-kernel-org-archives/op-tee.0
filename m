Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A00CCFA1A
	for <op-tee@archiver.kernel.org>; Wed, 12 Nov 2025 07:54:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1FAC450011
	for <op-tee@archiver.kernel.org>; Wed, 12 Nov 2025 07:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1762934045;
	bh=oM0JeTTvUpqVY6SFAd/6+llHZkwzaZXqX1EM0V5i61Y=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OhcNTW0PxHfR3mJROxYlWyMH9zWK2fnrkGzunt0PgUsIfsyhilDccHe795O69SndM
	 UpywMAlCANUbGv/5EOW/OXL7KvYXDWuQkEm0z/1oVNLtufJzE5z2hPUiSpAsVKqHlh
	 c9SwAP93hpBOXqiZXdehLyA5/JiuEkn7spJfKbAOeo+mmyjHqKU1lUJugtLV0fQ5rd
	 xS8ddjpEBu/mJUE4FCw8Ts1ILBuuRRrlGRJo7IeDtxKrMB45DAHcL8ROiVAMeLAkRj
	 nBZ7lQ834YLd3tWDtS9dBItmXb30H+jWvrHcDLfynAYlJZAAGZ13Gn19mv9x8Ucapr
	 aFEf7/NOWjz7Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 96F9342F4B
	for <op-tee@lists.trustedfirmware.org>; Wed, 12 Nov 2025 07:53:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=T3ykk909;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E962C433DF;
	Wed, 12 Nov 2025 07:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782AAC116B1;
	Wed, 12 Nov 2025 07:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762934034;
	bh=oM0JeTTvUpqVY6SFAd/6+llHZkwzaZXqX1EM0V5i61Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3ykk909Mysh4N3z7D4b74Fiwo+i66kLpa9Gk4MJJucZiiQkGiXAJRDpm7RLQ+y7C
	 fEFbSS2BraQBbZ5W6nDY39FUCwggLwC6BRIDAfc3xjfcv0fGSaFJyVjaQBnoVbRGXj
	 FUaZ477gWDuFG1718n7/8Rn/llcYG63i2wUsPUYjemlGyMEKzAsnPiZR1mSuWRb1UY
	 FmoSvY90sZx7oI2NUQ8XMdcOUEVZ4Q/9k8ih7gUEGALZnz3SBv3xvKyNpaDWmY5ZAi
	 BYxhxFoP4upCxDa9SGBtTBXf1ohrbtICLSoO1tlVtD5oA7E+ILp4c2LwuECe7zaRti
	 DmrVflMm/08Rw==
Date: Wed, 12 Nov 2025 13:23:49 +0530
To: Ally Heev <allyheev@gmail.com>
Subject: Re: [PATCH v3] tee: qcomtee: fix uninitialized pointers with free
 attribute
Message-ID: <aRQ9DQ1Ncf4Iep4o@sumit-X1>
References: <20251111-aheev-uninitialized-free-attr-tee-v3-1-57905b913359@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-aheev-uninitialized-free-attr-tee-v3-1-57905b913359@gmail.com>
X-Spamd-Bar: -----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 96F9342F4B
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
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: WVW52MMR7URATWJEGYQNQSILJTURXOBW
X-Message-ID-Hash: WVW52MMR7URATWJEGYQNQSILJTURXOBW
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WVW52MMR7URATWJEGYQNQSILJTURXOBW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Nov 11, 2025 at 01:26:42PM +0530, Ally Heev wrote:
> Uninitialized pointers with `__free` attribute can cause undefined
> behavior as the memory assigned randomly to the pointer is freed
> automatically when the pointer goes out of scope.
> 
> qcomtee doesn't have any bugs related to this as of now, but
> it is better to initialize and assign pointers with `__free`
> attribute in one statement to ensure proper scope-based cleanup
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
> Changes in v3:
> - fixed commit message and description
> - Link to v2: https://lore.kernel.org/r/20251110-aheev-uninitialized-free-attr-tee-v2-1-023ffba9ea0f@gmail.com
> 
> Changes in v2:
> - initializing variables to NULL at the declaration
> - Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com
> ---
>  drivers/tee/qcomtee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

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
> ---
> base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
> 
> Best regards,
> -- 
> Ally Heev <allyheev@gmail.com>
> 
