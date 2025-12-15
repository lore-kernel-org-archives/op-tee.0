Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BD0D5B16C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:38:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 873034FEDD
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765784334;
	bh=UNkdE9v+VPEu3Ht6ngqAW55bRSYjmEwZyurj7w5Sq6o=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=VfOVfwHrEwRwGArmTY1gWOW+jaCdyvV9BVixSy61rhq0RRPACcdufjVe43uvySbii
	 dqVXIdzlxmSRFYP15ekwnZJ9FFLLaZMagqJqw5uH0rkjykVd6q61ItCNt5tWsXBTjG
	 bNaIoiDCDsMs9qtp1ntj6OULoH8tAZwmqLDIEIC2AQ8vfHYG1NwjRHaQJu4Pwb2WSo
	 mxu5LDWmaU3z2lBDP4SIysSsBx2OlINDGzkm+T6Hz9s0tsxz0JsakwLu2T4P0COaWy
	 MiSR9edDTZ7D+e2pF9DlAjFXWZOxV5NaP0VprrwElZtmpBiKmAxhzUkLc4p5iADzUi
	 bixDNfeY+GdMw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 976C64FEDC
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:38:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K/Nz8fNF;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 15D2560129;
	Mon, 15 Dec 2025 07:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E417FC4CEF5;
	Mon, 15 Dec 2025 07:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765784301;
	bh=U3cC7k6Isie63Z6FqsnXxtE9EV4pc6zGst140+xRdL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/Nz8fNFmrBJ01MnfF60HKhK2CtEYyA5zr2dg1xtfZcjLUqHdKlu/NwdTE7x2Y7+H
	 vc0J15aFZS8dRbATt2vKNwg/m4DDDPJdBzqVfPRyrb8n9yybsScx1jDn8MowHO0tF5
	 G4DQn4BK8SuxuDAgUdL1IvTdj19rTTHc9WXsF36L703N7Vp6LIYm2kR7+NKMulTtUl
	 NHrep+wTJrHdZSQ9khs5KyZoZUrHrYv/qqJneBkvTyNLUATRokQZ0NTlO0irMrD+yW
	 9sRecq2SOtd8FS7m6j5byB4u5Upc8JQyL8o5ft5umBYjgqc9/ZZ8thzeDNfcn+BWk1
	 ZDrnO/uIZXg5g==
Date: Mon, 15 Dec 2025 16:38:16 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 16/17] tpm/tpm_ftpm_tee: Make use of tee specific
 driver registration
Message-ID: <aT-66JZEVUmCUBc1@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <812e5c580599b27d4f752ba8cfc35ad5371ab545.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <812e5c580599b27d4f752ba8cfc35ad5371ab545.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.105.4.254:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmx.de,kernel.org,ziepe.ca,lists.trustedfirmware.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 976C64FEDC
X-Spamd-Bar: -----
Message-ID-Hash: I6HZFJDT47LLCEYIL6JAWR5JX24DIIQ3
X-Message-ID-Hash: I6HZFJDT47LLCEYIL6JAWR5JX24DIIQ3
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I6HZFJDT47LLCEYIL6JAWR5JX24DIIQ3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:10PM +0100, Uwe Kleine-K=F6nig wrote:
> tee_client_driver_register() is typed more strongly and cares about
> assigning the driver's bus. Similar for tee_client_driver_unregister().
>=20
> Make use of these functions.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

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
>=20
