Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A507D5B86F
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 22:01:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 94E524FECE
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 22:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765836099;
	bh=Uc4Pnn7OtWKuDM2lPQPCG1Bkwlyx9QkXQeoDZ0FbaOk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Bj8wKPovTrNudM1jEXC4K9y3S0CcJIdanEeuoK1BMIsl8x5fpNT3p9J7q6zyKL5nM
	 4sVGVM4Qx9X5oQfIGNPzbY9/NLAnYBjg+pGMFrlOpkA35QccqPt0HVsfPBFZcuOlpu
	 7y8/X7aRudAQ1ne3ZhmRiIY3ZpeVFV/DEa4jEDPxb1xD7D7acK+3IA3uGLqJIQ4mj4
	 J6V6zyj2ELPZnGzedAJTWIaXIOeL3y5kpu/VpPCMqj9sUmbpkbAtXDNVM+ZMl3BHxB
	 SeNhy66y7r7LZOHRM+iVZ4yX3HtAz6HgCnlKfGqi8ewlzRpzdBftDF5asxidJ6ZsbO
	 ayWDzfmGEdaPw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E55424FE93
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 22:01:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aS6VJZ5P;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 56DC64242C;
	Mon, 15 Dec 2025 22:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9FDC4CEF5;
	Mon, 15 Dec 2025 22:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765836080;
	bh=gAyZ9dbbvlTKeak8iAsSIImqvtdOTUL/71rbHjPUa6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aS6VJZ5PrfH/K6eL/rM/XNgxf76zYlRkVZQd21pGJfpgcpISpHFc76y9WEtTG6Yz4
	 rhgdG2PlMcP34UrS2bzOvWgD4WdO+10Qfe3OfE+PK+Cd3HNhMRFgoRh0clQDABIutw
	 ezJ9Hh3uamekOqwkJxRkKDZ/LKs+lEIi7zXa2nUVApEAg/+I4ewmr2pmM7aujDleue
	 rtgQKrwRbGNIksnX/3Df7ENeqEOo9fZe26g7abk2jhccIXu22QklpLceiwd8Et6y7t
	 2QagNvb7KjegK+/x5rate6fHLWZjPa7edrhDbDSd4WapO6rgVvKuzc4Itt+ZX8HDX2
	 dkI9XdLKCfF0Q==
Date: Tue, 16 Dec 2025 00:01:16 +0200
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 14/17] KEYS: trusted: Migrate to use tee specific
 driver registration function
Message-ID: <aUCFLJe6k_5UAmM0@kernel.org>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <687c004c32718ba7044ffa9165f33842267a745d.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <687c004c32718ba7044ffa9165f33842267a745d.1765791463.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E55424FE93
X-Spamd-Bar: ----
Message-ID-Hash: XRMSUYGKQVA3GQD4IV4KXPTWA6JPC2CQ
X-Message-ID-Hash: XRMSUYGKQVA3GQD4IV4KXPTWA6JPC2CQ
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XRMSUYGKQVA3GQD4IV4KXPTWA6JPC2CQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Mon, Dec 15, 2025 at 03:16:44PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee subsystem recently got a set of dedicated functions to register
> (and unregister) a tee driver. Make use of them. These care for setting t=
he
> driver's bus (so the explicit assignment can be dropped) and the driver
> owner (which is an improvement this driver benefits from).
>=20
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/tru=
sted-keys/trusted_tee.c
> index aa3d477de6db..3cea9a377955 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -264,7 +264,6 @@ static struct tee_client_driver trusted_key_driver =
=3D {
>  	.id_table	=3D trusted_key_id_table,
>  	.driver		=3D {
>  		.name		=3D DRIVER_NAME,
> -		.bus		=3D &tee_bus_type,
>  		.probe		=3D trusted_key_probe,
>  		.remove		=3D trusted_key_remove,
>  	},
> @@ -272,12 +271,12 @@ static struct tee_client_driver trusted_key_driver =
=3D {
> =20
>  static int trusted_tee_init(void)
>  {
> -	return driver_register(&trusted_key_driver.driver);
> +	return tee_client_driver_register(&trusted_key_driver);
>  }
> =20
>  static void trusted_tee_exit(void)
>  {
> -	driver_unregister(&trusted_key_driver.driver);
> +	tee_client_driver_unregister(&trusted_key_driver);
>  }
> =20
>  struct trusted_key_ops trusted_key_tee_ops =3D {
> --=20
> 2.47.3
>=20

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
