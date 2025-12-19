Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF4FD711CA
	for <op-tee@archiver.kernel.org>; Fri, 19 Dec 2025 06:22:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4BD7D4FF35
	for <op-tee@archiver.kernel.org>; Fri, 19 Dec 2025 06:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1766125363;
	bh=yZ/6hwCvZ+4Y5LN+1NOChr4/0weL6+8iM4M+PibD4AQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=1AeeQ8TomlSbATYAMRQP01X8CD2pf5eX9iPELzZk3XOOX9gCX2jCLp/Iv3N4zsdNw
	 7OGG61GBglf60xf6u/A7zjr3u692dc/mpf8sjTkGvPqNPGP6ZgmWWM5vIjiAz5UHs0
	 3mkGG2ZImUPAXsG9P5uzDm/r9kb2Sgo+I/fCMuQgHDuEW1K+dO+ZktaTHLMmN9Jz3l
	 T7oc6Yx/v271lAbAL0/hmvSv3h8NdDj9TjGZzZzsMb+se4JOGVx3gllv62bAnHI3sE
	 OjOx0nEtmHBgCwtJnyylsLF78qLqRufoK/41NpzKRAPc6Rb8jRFUa9I3RdXthXiR3o
	 xVsFumCwI08bg==
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1C03A41BC4
	for <op-tee@lists.trustedfirmware.org>; Fri, 19 Dec 2025 06:22:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=ENnGgPvQ;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=W0MN6pUFNVtsOI+Zv3JYyUrXeCxmmFLgM9vFQUhlADw=;
	b=ENnGgPvQ6zoEsTz+ORcYvVV/fbBV5FLiqhmPNMgE2V0f/D4u2DOBkWlKFmhfd8K2uapISLk09NL
	HaRfGs5tR5BcSlZQ+0iJFsOT9vcSxjGzv/6FeX/kNo/dWfuuKXQ4OseBb473WCX4mAW8Ba3vY6cdX
	4L3oX01y4AZB2XZWNNadrnWPY2nofZS4HeAyY0Pv+ItiKgoLIY+WADjVrW7L65yCh9pgq+fKmIbL3
	s8IIqEjU6MM2LV58t7lL4Xl9CpmTsm4gGKnJdv2S8Lbt/mcTD3fAtCe8BFdGj2wn2BQXRySzgHKrT
	jriX6jztWYmMGBFKr4FVu2nOXFswnRYiAtaw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vWTsO-00BEDw-0W;
	Fri, 19 Dec 2025 14:22:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Dec 2025 14:22:08 +0800
Date: Fri, 19 Dec 2025 14:22:08 +0800
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 04/17] hwrng: optee - Make use of
 module_tee_client_driver()
Message-ID: <aUTvENaCfiURNyFg@gondor.apana.org.au>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <d0074b2e05cfb78ce5e95c875731e784bef52411.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d0074b2e05cfb78ce5e95c875731e784bef52411.1765791463.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.82 / 15.00];
	BAYES_HAM(-2.82)[99.20%];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+a:abb.hmeau.com];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:4764, ipnet:180.181.228.0/22, country:AU];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1C03A41BC4
X-Spamd-Bar: ---
Message-ID-Hash: Z4VEH6LB5YZW74J5DOGAHQIHILVOREVD
X-Message-ID-Hash: Z4VEH6LB5YZW74J5DOGAHQIHILVOREVD
X-MailFrom: herbert@gondor.apana.org.au
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>, op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Z4VEH6LB5YZW74J5DOGAHQIHILVOREVD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Herbert Xu via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Herbert Xu <herbert@gondor.apana.org.au>

On Mon, Dec 15, 2025 at 03:16:34PM +0100, Uwe Kleine-K=F6nig wrote:
> Reduce boilerplate by using the newly introduced module_tee_client_driver=
().
> That takes care of assigning the driver's bus, so the explicit assigning
> in this driver can be dropped.
>=20
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/hw_random/optee-rng.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
