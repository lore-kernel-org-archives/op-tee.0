Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6450D59D99
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:27:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1D68D4FE89
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765783631;
	bh=VeZXgzLxZZXPiVoVLG+o/MPolrlCq3Iwn+FFFP1i4bI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=PyXUvid3c+TkT+buVEtOZ+YGWfC68A/8F5FYpMfC0oSVh3LvAlml0PQwrYQr8AruP
	 jz4+E22pG3278gnEpkzDcLhz2uOKzD1djuWNGB+3b12TBcUbjzEhcQJ3B2hUN3GqnV
	 0cMFHmzUY+PJSgDbqzUbwgVumY5McGY0tHmAAoC5c+aQ+NBhqp1+CXc610uhBL5KC+
	 +dCQE7AqRK6Kq+pp/pV5/71LI3iGxx7/y2vSxtUEYthCqPP3FMxK8ojUumRdB40Q5B
	 Dio1ne3KFoE34bh4ttcnQQ9PpBUz8LD7gAYeXRg5ZSH05h+2L1ePWTyaOEQQVSMSrV
	 OPDt9Ab2gRjZQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BC1FC4320D
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:26:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TpF2IC4S;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 228734054C;
	Mon, 15 Dec 2025 07:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC89C4CEF5;
	Mon, 15 Dec 2025 07:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765783596;
	bh=adTi4XQQUTGymDm5WX6G+3RmsZRhvswJ8uqLtFBbcD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpF2IC4S4wICHQTWovp22HK6/b8SoyK20DBohUd6xMEG/R3ZZchat3YL7ibYptPHp
	 N/deQiqZLO3f6FuOqIPar8jUlKvFUkAewQLkm8Qx5Uu94CwMpMGmn563Dn73+NY3Pc
	 hHRRb+mYKKpjkRwNZ/S03NJqrrN6HTxT8suVM6dJ6gKW7UyLdns1D59c9z3bRitQSK
	 bbTTjkyh9Fbmqm9hjAgAmESVF/veiCU1lXRfC/x1DYlBDA44ti3+6+Q1e0qR53ap1A
	 fu5TXJDLmtTIAbvspZeS45gI+G6Sv/8FHtohcAArqeHdYBzrhk3KOdVOwxig8kLEFc
	 nC2K+64DZU3iQ==
Date: Mon, 15 Dec 2025 16:26:30 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 04/17] hwrng: optee - Make use of
 module_tee_client_driver()
Message-ID: <aT-4Ju_vgEf2JGC4@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <a2560b5a16c01dc1f63437ce0d60b3ee9c7cb3b8.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a2560b5a16c01dc1f63437ce0d60b3ee9c7cb3b8.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BC1FC4320D
X-Spamd-Bar: -----
Message-ID-Hash: TJJNHUO4ORMBGEHFSSK4DIFJ6325EF52
X-Message-ID-Hash: TJJNHUO4ORMBGEHFSSK4DIFJ6325EF52
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TJJNHUO4ORMBGEHFSSK4DIFJ6325EF52/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

nit for subject: s/hwrng: optee -/hwrng: optee:/

On Thu, Dec 11, 2025 at 06:14:58PM +0100, Uwe Kleine-K=F6nig wrote:
> Reduce boilerplate by using the newly introduced module_tee_client_driver=
().
> That takes care of assigning the driver's bus, so the explicit assigning
> in this driver can be dropped.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/hw_random/optee-rng.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/=
optee-rng.c
> index 96b5d546d136..6ee748c0cf57 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -281,24 +281,12 @@ static struct tee_client_driver optee_rng_driver =
=3D {
>  	.id_table	=3D optee_rng_id_table,
>  	.driver		=3D {
>  		.name		=3D DRIVER_NAME,
> -		.bus		=3D &tee_bus_type,
>  		.probe		=3D optee_rng_probe,
>  		.remove		=3D optee_rng_remove,
>  	},
>  };
> =20
> -static int __init optee_rng_mod_init(void)
> -{
> -	return driver_register(&optee_rng_driver.driver);
> -}
> -
> -static void __exit optee_rng_mod_exit(void)
> -{
> -	driver_unregister(&optee_rng_driver.driver);
> -}
> -
> -module_init(optee_rng_mod_init);
> -module_exit(optee_rng_mod_exit);
> +module_tee_client_driver(optee_rng_driver);
> =20
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Sumit Garg <sumit.garg@linaro.org>");
> --=20
> 2.47.3
>=20
>=20
