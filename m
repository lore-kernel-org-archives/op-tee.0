Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BACD59D99
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:37:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 057824FEE3
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765784247;
	bh=RhPEh+Z6TqhRBapUBK4SmmDU1NEAAQMBW5ldo7oAHDM=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=plrl1RVv/1zAEfjcrDrsmBZft/GYrLJygJb6MRZ72VVl6ONOgT0Wt3cywoWsfq9B3
	 uvEXF7DCHlPEKBYuUgFlJ8BKw5iXmcNFRGpeu8r3em8v6PVAQeh6+rd6/50LDF1ywC
	 FAivbHxeekMYJ/QPD/CldYQoAEYvKBbFh2DYGPPs3cVIlS5H/EuwtoOBqCTGdS6vxY
	 bMTMnSu9HwqHh3lFHVa1PCj1+IiG40q8py0hiHQbgRufqu3GdePQMXyI3U4KhSzFYn
	 mP/v/f9STXvC92eCeylO6AKdyotAa3JUfn9Mjd+g4nO7Mz4FbLAZcl4fQEl3BBx6do
	 wLKtpeJNS99OA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C78B64FECE
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:36:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TKoIYD90;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 33C4F43EBE;
	Mon, 15 Dec 2025 07:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9B0C4CEF5;
	Mon, 15 Dec 2025 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765784167;
	bh=SNNUq7KU8x7V29ijpjlfv//eZVaSmLl/pwwin6AI2Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKoIYD90uMhvL1iKT6lsyEsfKo1ciIMwa87/Kxr9OUecFwxG7gh9QHOVQiGdWmvRb
	 VVD/JYfzHq1k7pZ5iDCgzZ+WMxUXYRlXqhsAOSxlOL547VDldypSJD3eBJLxbHVS0V
	 /I8FhmP8jqpM+6rX2VTe/DG33t8qA/CqMHoNkAZL7c+n/uMpWVlioZ9gLGyZqm5g/5
	 E8ob/bFFCirmOEx3fE2APOW59zAZ91UxMtUNQ6QK7ACtrlys8omR6RxIxeH/pjsCFa
	 uYNDcVAe7zMj0LxOCU0CZ5Sj29V6Tbuv/gokKX1TY/76V0XxYKHS8fJaqw8a+3ehr1
	 AX9q/Af5TPLVg==
Date: Mon, 15 Dec 2025 16:36:00 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 14/17] KEYS: trusted: Migrate to use tee specific
 driver registration function
Message-ID: <aT-6YJJRaLq5BcvQ@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <0b3ce259fa26e59ef24a91ca070e2b08feeede82.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0b3ce259fa26e59ef24a91ca070e2b08feeede82.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C78B64FECE
X-Spamd-Bar: ---
Message-ID-Hash: YM2YPFRKFEHZWSIQET4BSM5L77MG7GEA
X-Message-ID-Hash: YM2YPFRKFEHZWSIQET4BSM5L77MG7GEA
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YM2YPFRKFEHZWSIQET4BSM5L77MG7GEA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:08PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee subsystem recently got a set of dedicated functions to register
> (and unregister) a tee driver. Make use of them. These care for setting t=
he
> driver's bus (so the explicit assignment can be dropped) and the driver
> owner (which is an improvement this driver benefits from).
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

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
