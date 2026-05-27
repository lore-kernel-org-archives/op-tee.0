Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B57CD4F54
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 18:56:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BD1E944AFA
	for <op-tee@archiver.kernel.org>; Wed, 27 May 2026 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779908169;
	bh=P2+6W9UmUo/Zi9QFAGg+h1wefmR0kkt/vhLPG3MBoOo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=kBeWRczxBAfKiFukbkmFzEBaD8E6MIMjQwwquj2DcdtDL5r6cbQmFNWkbrcI/xA8j
	 dUiZzV7L4cUZLmCuzkpkQ8m1DuOrHLvPBcrkwT+H4KB5HitRCufxac3MDfByPQHR6C
	 fjeBe50/OoTItYpi7GSfop7Kq7WuMUKvdUtkqPJk0+g5y3VjDO8kVcr33TNBLyLLLv
	 PGh/Nw17pU4yG7Q0h6f9VyxFTF7yCfCHst+KfJ6RkzEnDkAxSQm8YNhGfFm8XV9PvA
	 uDODvinFjVSSWvobrimCDAHibsRVRdHqffkxttK9/PlHioENc3pF/zQ0lokwZoEZFD
	 IsL02ytX+aTqw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5D7AB443DC
	for <op-tee@lists.trustedfirmware.org>; Wed, 27 May 2026 18:56:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dP6ly0G9;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D950F6057B;
	Wed, 27 May 2026 18:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C151A1F000E9;
	Wed, 27 May 2026 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779908161;
	bh=liULdT5hPG3Hs3MVsuBYqbmNhVl/Zh1MhxhFa73l698=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dP6ly0G9qXtPakMjOJ5zrOUCUfpqM9+qBvvNugELgTNwDZhk9vDhIXM3lkgvo64H1
	 vPO5lINGavUCUdfxIqR2GD7X5PvkjsCV/EyeHVCW6mTXOmkyNZe9ln9cQRWx5Bqzhl
	 J5hopodkj4fUjifJUtiLdkceAghSStOLmdZVl0/jmdsaUXJ6MV+uLg92bzmN8+XVQT
	 dSj4f6Nw/y+FjXQJ7ir+dcMde2lKGmROBUf81E0X5hCDj9lxZvy8OCv65o2XmNcsCq
	 aS7KRB4rNvFcISCxQAyzpWi0j6jwYlh+N3UvYf2Sq6K7+ZVHLHPtmY3NK9XEtXAk1P
	 En+j8KLCuIelg==
Date: Thu, 28 May 2026 00:25:56 +0530
To: Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 1/6] optee: ffa: Add NULL check in
 optee_ffa_lend_protmem
Message-ID: <ahc-PMwAbFfo-4Q8@sumit-xelite>
References: <20260527150236.1978655-1-smostafa@google.com>
 <20260527150236.1978655-2-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527150236.1978655-2-smostafa@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5D7AB443DC
X-Spamd-Bar: ----
Message-ID-Hash: J4IBMBYBIQ5O454JV5ECNOA3EOBEQXGX
X-Message-ID-Hash: J4IBMBYBIQ5O454JV5ECNOA3EOBEQXGX
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/J4IBMBYBIQ5O454JV5ECNOA3EOBEQXGX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, May 27, 2026 at 03:02:31PM +0000, Mostafa Saleh wrote:
> Sashiko (locally) reports a possible null dereference under memory
> pressure due to the lack of validation of the allocated pointer.
> 
> Fix that by adding the missing check.
> 
> Fixes: 2b78d79cdf96 ("optee: FF-A: dynamic protected memory allocation")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index b4372fa268d0..633715b98625 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -698,6 +698,9 @@ static int optee_ffa_lend_protmem(struct optee *optee, struct tee_shm *protmem,
>  	int rc;
>  
>  	mem_attr = kzalloc_objs(*mem_attr, ma_count);
> +	if (!mem_attr)
> +		return -ENOMEM;
> +
>  	for (n = 0; n < ma_count; n++) {
>  		mem_attr[n].receiver = mem_attrs[n] & U16_MAX;
>  		mem_attr[n].attrs = mem_attrs[n] >> 16;
> -- 
> 2.54.0.746.g67dd491aae-goog
> 
