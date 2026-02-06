Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE01EE2084
	for <op-tee@archiver.kernel.org>; Fri,  6 Feb 2026 10:58:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 70DDF43711
	for <op-tee@archiver.kernel.org>; Fri,  6 Feb 2026 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1770375511;
	bh=kenUozXkKSW+3e10XK9cQ/jFaolbja/kHF4Q+OUfPMo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=TNTceY7S3Afc77ofacZrTVRHh705VB45yqe77h2yfA99QHM8NXKoqhnuhrRqfGfHR
	 NqIOxTnkBDEo71w6YOM4FwuGzlUfR27nqoigdzO6rmpV2jf235/QTFBK7i49JpBksS
	 pizhbU0Fq/i0W4v5sOZPq0c6mdxsFbksRco9984y8V5Jtnla/eJlM8Hf2wCkmNLi9b
	 ZS1Aw0N6koIz3wNuPMGeG0IovCT3WoeUBM8YaPfkmvIXjOSCz/mxVw+pHViVS/CIk/
	 mQ+tbMdM+Gccp/7b9MXz9IvzDBEDTi++d4JsjIQHJzfaMMitz4NBIXWB+jCSgwQong
	 JDuPALakVQKdw==
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A022B436D1
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Feb 2026 10:58:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=IXuE0Z8T;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=8ANb9onDdaVcYdsoufhva+0OyHpF8IK2xM3N3X0tI84=;
	b=IXuE0Z8T7Cz4E0mzWjVZzxGK3GXk80Yrk3p4iuNnf/c1OEEcBfK+fRNOY4oTWUsuJyzcuuKtxtZ
	bZTWLHe+fErkQMKhlhTKSoXPH7O02A9vd63oBrri9iVVleY4+DVGPMqmaV6IjhzFUDVZM+bLfxpTO
	1/6hYosKjn7jAV5gocOxcZXP9TsnQpYj1apFF0QK2O7Q3e8B+1sNFNmNhx2K9t6J9iFT6whMQeD+y
	i4Su+UIC+gdOyjvZHIQ2hUxi9MjaE9wTdfW4rhSxb/TISYoi/gPyZ4hgXs9zDxD8ECeo1Y77aMdXs
	jk+zTFg/QJq+tOKC/OFXRDbHBJULu3brTplg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1voJX6-004zTg-2N;
	Fri, 06 Feb 2026 18:57:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Feb 2026 18:57:52 +0800
Date: Fri, 6 Feb 2026 18:57:52 +0800
To: rouven.czerwinski@linaro.org
Subject: Re: [PATCH 2/3] hwrng: optee - simplify OP-TEE context match
Message-ID: <aYXJMKtRIcbGxJ3x@gondor.apana.org.au>
References: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
 <20260126-optee-simplify-context-match-v1-2-d4104e526cb6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-optee-simplify-context-match-v1-2-d4104e526cb6@linaro.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.41 / 15.00];
	BAYES_HAM(-2.41)[97.30%];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+a:abb.hmeau.com];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:4764, ipnet:180.181.228.0/22, country:AU];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[apana.org.au:dkim];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[180.181.231.80:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A022B436D1
X-Spamd-Bar: ---
Message-ID-Hash: 2O6QNTZMAUH35RXH2LTXHP3L66S6Q623
X-Message-ID-Hash: 2O6QNTZMAUH35RXH2LTXHP3L66S6Q623
X-MailFrom: herbert@gondor.apana.org.au
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2O6QNTZMAUH35RXH2LTXHP3L66S6Q623/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Herbert Xu via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Herbert Xu <herbert@gondor.apana.org.au>

On Mon, Jan 26, 2026 at 11:11:25AM +0100, Rouven Czerwinski via B4 Relay wrote:
> From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> 
> Simplify the TEE implementor ID match by returning the boolean
> expression directly instead of going through an if/else.
> 
> Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> ---
>  drivers/char/hw_random/optee-rng.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
