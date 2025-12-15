Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62F5D5B873
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 22:48:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3390D4319E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 22:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765838922;
	bh=MFWlJ0CX9cNAQQkQqpO8VdvZn6LJjqBDu3gwC9BpBIE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Xr5gbhvFfNPBmNAR5sk7/SXvZYp+yiOX4qv6Tm2PktYIII1nHrS9PWGHoZ0kBWw9Y
	 uXU2hpJ8qSuZMZMc1mAf8Exv5w/1pHBEWLRTMIP9Mc4K2MoX5X87yV8iHwdcsEqjZj
	 tTJlA44Anh42l1iZPwNt1Vs7v4zNw2QhPz7soiSToh9ZpfnfJohuXVeID+BxfLD9Qt
	 qdllvqJXHvRHst1eg+4Rks1Y940NBUvQXg+XUfCBUixAIIU7iP7zLfuPfRLWL5D7Ij
	 JW4w9gDNdzQBNh/74fTS05JD8+3wW3JdEXqs60goYEj40Fxzs+EbdWhwYqZsf6316l
	 pSO2uCF/slDuQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 16D0F4319E
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 22:48:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mtjJv3Sb;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6086E40C4F;
	Mon, 15 Dec 2025 22:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B8EC4CEF5;
	Mon, 15 Dec 2025 22:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765838904;
	bh=gzI/8qh+r5aIKGfXOsjin56/O6OgyOXJRRtbBvPR/SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtjJv3SbNRWuU26ZrNudj4avpvMZXsHcSZ11zSfe9+nQCZkjsOkeJlX20wsy708zr
	 hKEeZG3zWtsoNfyOiNwP3MA5ocmqyjtDoXBSMpRix93jg1eHBBXUkazMQLTekszbff
	 U94MIz2MLpAoded/RyRCWR+k1YDKIMq1K+q8rQUgVf/k2CRl61asQnYKCyktOO2sJL
	 nhfRR2FWWyOxS6r/PeIvUXbM5bjyHtdm6SkGmojSgoFMihL76cH/UK0qh29RL+wzwr
	 nDFB0GC3Jy1xGH7Dxd5Gcbtz+GaFYA4zQ/7AQTSQNz7we6MkZLIbr2yDK5TzXyeWuo
	 tIgU6ZPE10qBg==
Date: Tue, 16 Dec 2025 00:48:20 +0200
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 16/17] tpm/tpm_ftpm_tee: Make use of tee specific
 driver registration
Message-ID: <aUCQNO1ovSifxO9F@kernel.org>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <5c8d6d420338d0d028f785680520d375e8a49673.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5c8d6d420338d0d028f785680520d375e8a49673.1765791463.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmx.de,ziepe.ca,kernel.org,vger.kernel.org,lists.trustedfirmware.org,oss.qualcomm.com];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 16D0F4319E
X-Spamd-Bar: -----
Message-ID-Hash: W3XJBCME4A5X35ACXKDJIRGQY4DSLLM5
X-Message-ID-Hash: W3XJBCME4A5X35ACXKDJIRGQY4DSLLM5
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Sumit Garg <sumit.garg@kernel.org>, linux-integrity@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/W3XJBCME4A5X35ACXKDJIRGQY4DSLLM5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Mon, Dec 15, 2025 at 03:16:46PM +0100, Uwe Kleine-K=F6nig wrote:
> tee_client_driver_register() is typed more strongly and cares about
> assigning the driver's bus. Similar for tee_client_driver_unregister().
>=20
> Make use of these functions.
>=20
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_=
tee.c
> index 4e63c30aeaf1..e5fbc70b0eca 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -338,7 +338,6 @@ static struct tee_client_driver ftpm_tee_driver =3D {
>  	.id_table	=3D optee_ftpm_id_table,
>  	.driver		=3D {
>  		.name		=3D "optee-ftpm",
> -		.bus		=3D &tee_bus_type,
>  		.probe		=3D ftpm_tee_probe,
>  		.remove		=3D ftpm_tee_remove,
>  	},
> @@ -352,7 +351,7 @@ static int __init ftpm_mod_init(void)
>  	if (rc)
>  		return rc;
> =20
> -	rc =3D driver_register(&ftpm_tee_driver.driver);
> +	rc =3D tee_client_driver_register(&ftpm_tee_driver);
>  	if (rc) {
>  		platform_driver_unregister(&ftpm_tee_plat_driver);
>  		return rc;
> @@ -364,7 +363,7 @@ static int __init ftpm_mod_init(void)
>  static void __exit ftpm_mod_exit(void)
>  {
>  	platform_driver_unregister(&ftpm_tee_plat_driver);
> -	driver_unregister(&ftpm_tee_driver.driver);
> +	tee_client_driver_unregister(&ftpm_tee_driver);
>  }
> =20
>  module_init(ftpm_mod_init);
> --=20
> 2.47.3
>=20

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
