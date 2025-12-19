Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBE6D711CA
	for <op-tee@archiver.kernel.org>; Fri, 19 Dec 2025 06:23:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DBD3241BC4
	for <op-tee@archiver.kernel.org>; Fri, 19 Dec 2025 06:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1766125394;
	bh=L2pRfdOgJJHdGRk1MDGl+rNfo4Uxf7p5j+b2niMF3ek=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=kzsmUua7sI6NpwvO32qImSxU2HUwvqAbddXREt8N1COEy9CgF9xXujgagFZDP7u91
	 nwnPbPmStjs1sbMTma0CVret1ytJXwZOOrJYHObjBnQWkLSVtlYFbO7TYbuzfhk9bK
	 ACeApMpWpDaqRpL0DjFkxmHzjK0cFvEVhsLRNAT8CUlZB+eta0NryATNaQtyO8BcpO
	 I/2AG9YqSsYokydGH4XY2Hn1RBdgupf5+ZBOIQQ08dMgSi8pEXJGSLjNjWaG0wGR/w
	 J4Mgcu/hIsVN2gMn38nI3k8kueJQK2WAne8jWG5F0CzffRItZtXqR25WwDi3hqDhTK
	 4V94EPTmfhPjQ==
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D1B344FF65
	for <op-tee@lists.trustedfirmware.org>; Fri, 19 Dec 2025 06:22:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=SR9XdtD8;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=0r6gG8SlXmvlIIsbOSguFzX/oc68mghidC1DJol2F74=;
	b=SR9XdtD8nT+RbMNH3/p/tZnARnJpWpWCJ5aqkzRtNzdKellAyUkeAy8qDTLVkvz6YM0wgIMtmGC
	lZ97SG1GL/cbhwqqujYH5LOmM+zTb7Gqpb5WM/hZJ27ykI640XLkeaG0Pd7SQXjiYXySruIw8/4MF
	1HthJ3VQL4TMVratXD1V4Z9eIrDiEkHdYRx8OEJ3gC1ly0OkEsvfsx/vVljVtb8xn2UohuglDQVsV
	KpRnQdCa46jQebLi+zNcrv4FCTdjV8BqAeYUrjLMmjhvPvbn9yPnsoHth7Waioflpqs7PU/eoJ3X3
	5eYdw0IN8/WoPMmOjI7EB/lKLBGTlTQciPNw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vWTsd-00BEE6-03;
	Fri, 19 Dec 2025 14:22:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Dec 2025 14:22:23 +0800
Date: Fri, 19 Dec 2025 14:22:23 +0800
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 05/17] hwrng: optee - Make use of tee bus methods
Message-ID: <aUTvHwzw5-1vE6sv@gondor.apana.org.au>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <170dceec036ffe468a1f9f26fa08ac9e157ada29.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <170dceec036ffe468a1f9f26fa08ac9e157ada29.1765791463.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.97 / 15.00];
	BAYES_HAM(-2.97)[99.86%];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+a:abb.hmeau.com:c];
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
X-Rspamd-Queue-Id: D1B344FF65
X-Spamd-Bar: ---
Message-ID-Hash: Z33MBD7YVVBHDYKKFPLWJEH2ZSJ4GEUC
X-Message-ID-Hash: Z33MBD7YVVBHDYKKFPLWJEH2ZSJ4GEUC
X-MailFrom: herbert@gondor.apana.org.au
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>, op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Z33MBD7YVVBHDYKKFPLWJEH2ZSJ4GEUC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Herbert Xu via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Herbert Xu <herbert@gondor.apana.org.au>

On Mon, Dec 15, 2025 at 03:16:35PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>=20
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/hw_random/optee-rng.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
