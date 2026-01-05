Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C94FC2A072
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 05:26:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 44E0842FF1
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 05:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767590815;
	bh=zvvg8AmQdAqvlZU/5MgPfJwyH0EOaUGnUf/oADXTllA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=n9WQdR84oU/BH0jlZLp3szmqmha1NSr4D+prFMKBM3yWGRpicYvJVzalxhC1KuZqz
	 W3Vw5YDZpSFY9/r7BdeHsDRFvtIuF5i/Ixx76IoVjGyK2wkMrSfSmCNbqkFT5VACHL
	 He5496bLpyahrdBFInx+vgt2djqcyGdxHjJv+BwLsCLtfmJOnYEd3Ul4MQg1FY65k6
	 ca7wAQmZ+jKmut+sqJZ3V66Qr1T5wUiydcBNY+0Vxd70HV96GlZkUCPK5PG2j491PD
	 XdsRmJjzs8Ibpcs/a5fOJRIIRA5h9cU/L41DND6DUqjhfCMuQFO7/LiGCaGWkhRBjm
	 4EfeKYPKckGxA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3BE6241B30
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 05:26:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q+5Eni3G;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8CB6B437C5;
	Mon,  5 Jan 2026 05:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73407C116D0;
	Mon,  5 Jan 2026 05:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767590798;
	bh=zvvg8AmQdAqvlZU/5MgPfJwyH0EOaUGnUf/oADXTllA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+5Eni3G7wsP6sTikeT5kPwuORBaNZxI/5UyIMuPf8ioJIfM4G1+wo9ty6lSZs/tZ
	 ETrAwWl8q+eysTRIPTdpxbq+tgyX2NigTWsWNdWn1lAXWk18bCCibx5jpBy1tPlbaD
	 3mtltKdSwCgbKSnyFJH4BAymGYNOVIxHDGIcarPnzIjEvv93fhRgVfnvZ7I4AslDGK
	 bUMH/cNletrZUvx1QjMtVMpguR+y887dgkWzJsfH9YKTVK5MLndK7CaaSOT7uLOQl1
	 8uxXMvs/7hPrzMCBjw5o8P+s6LDLfhWrc5HSk3arQO/kTGTHdjCB4zKBquzhs0EznW
	 bMQtJcBu0uXCw==
Date: Mon, 5 Jan 2026 10:56:32 +0530
To: Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH] optee: update outdated comment
Message-ID: <aVtLiJBGovTFhjcc@sumit-xelite>
References: <20260104170119.291968-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104170119.291968-1-Julia.Lawall@inria.fr>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3BE6241B30
X-Spamd-Bar: -
Message-ID-Hash: H2JG2DMKMXQBZM7HHFHGMAAMQBMF7DEL
X-Message-ID-Hash: H2JG2DMKMXQBZM7HHFHGMAAMQBMF7DEL
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: kernel-janitors@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/H2JG2DMKMXQBZM7HHFHGMAAMQBMF7DEL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Sun, Jan 04, 2026 at 06:01:19PM +0100, Julia Lawall wrote:
> The function cmd_alloc_suppl() was renamed as
> optee_rpc_cmd_alloc_suppl() in commit c51a564a5b48
> ("optee: isolate smc abi").  Update the comment
> accordingly.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/tee/optee/rpc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index ebbbd42b0e3e..97fc5b14db0c 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -247,8 +247,8 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
>  	param.u.value.c = 0;
>  
>  	/*
> -	 * Match the tee_shm_get_from_id() in cmd_alloc_suppl() as secure
> -	 * world has released its reference.
> +	 * Match the tee_shm_get_from_id() in optee_rpc_cmd_alloc_suppl()
> +	 * as secure world has released its reference.
>  	 *
>  	 * It's better to do this before sending the request to supplicant
>  	 * as we'd like to let the process doing the initial allocation to
> 
