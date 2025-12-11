Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6C7D43346
	for <op-tee@archiver.kernel.org>; Thu, 11 Dec 2025 20:23:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2A123431DC
	for <op-tee@archiver.kernel.org>; Thu, 11 Dec 2025 20:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765484582;
	bh=VjnzkzrbjYp/xhO+I3YHw8NcxOdTLcWTJwkReW+wNyg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0wD26dHt/x/wIBblXdKvBQscydQkt4NPHCVjq1TECoHPuuobdtZFe+OQFucSET6os
	 Jpl7S8lfNhPGsFZMvBW3fvIocO4pAHGft4gNb9i0IoOnSQl4tqw1sNOQfSaXYqOWzA
	 /CSJnJ+lm2kresTul+iZQjxMV6YMAsvV7Wz7zFV7Gd8//1Rrs9LxJ+WKpmgMku7iI/
	 6voVX550fE3lr0BNdV+HPWUO3gmOIxmEiKHyFxY026cQ0O916h3HA3ZFKQkxfyFE+O
	 8XcRxSURwV/vPNplx+guWmywqgUiNphsv8SwIyTN+FzIGCzqF/Ckkyj+/9a03gl6To
	 q+IalCagKluKQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 332C941849
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Dec 2025 20:22:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Jxiem6bI;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E2E0560097;
	Thu, 11 Dec 2025 20:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A4AC4CEF7;
	Thu, 11 Dec 2025 20:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765484557;
	bh=67YAd1cWfgEDQnJk7N7ii4cbGijDnNqw6ET5G080vvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jxiem6bIZ1ZQBKGzXaW9M6IAhnzJcK/902yg+eOQzGDa+IDgWbz1IM+fwFjoayABO
	 Cba4xXI7gEx2EzEY3gCdDzI3DI/daa5xa2gvjFFiOQveQoBbqeLZzpGZK9a5IwA8uW
	 FX3NphZEUV6+7hevO1+gJr4r5B9sGhZRQyG3kCEheECQwEHEIrTu3xHimErkF6OWYd
	 eo/kzgkoF9+PWphqF5nNuXWSli74gPLLGn32SmUSOcGNk/NYByIoRzPSXcIbe/oy+J
	 2AxUNuMOaIdRnKLamYbkW4+RyA5y9oYBZvQ0Nw5ei+/A5PEH7P6CeejSqqLZ1Ob69U
	 cJ/AgU4fRIBfw==
Date: Thu, 11 Dec 2025 22:22:33 +0200
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 17/17] tpm/tpm_ftpm_tee: Make use of tee bus methods
Message-ID: <aTsoCR2TpCk7QpU8@kernel.org>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <eaf8216e8a6c3dabce5a82be5765d67c66318791.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eaf8216e8a6c3dabce5a82be5765d67c66318791.1765472125.git.u.kleine-koenig@baylibre.com>
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[100.75.92.58:server fail,172.105.4.254:server fail];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmx.de,ziepe.ca,kernel.org,lists.trustedfirmware.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 332C941849
Message-ID-Hash: XKQCGFX54QCDAQZNZQCQ6KVKTAA4XVHL
X-Message-ID-Hash: XKQCGFX54QCDAQZNZQCQ6KVKTAA4XVHL
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XKQCGFX54QCDAQZNZQCQ6KVKTAA4XVHL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Thu, Dec 11, 2025 at 06:15:11PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_=
tee.c
> index e5fbc70b0eca..20294d1953a3 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -169,7 +169,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_da=
ta *ver, const void *data)
>   * Return:
>   *	On success, 0. On failure, -errno.
>   */
> -static int ftpm_tee_probe(struct device *dev)
> +static int ftpm_tee_probe_generic(struct device *dev)
>  {
>  	int rc;
>  	struct tpm_chip *chip;
> @@ -251,11 +251,18 @@ static int ftpm_tee_probe(struct device *dev)
>  	return rc;
>  }
> =20
> +static int ftpm_tee_probe(struct tee_client_device *tcdev)
> +{
> +	struct device *dev =3D &tcdev->dev;
> +
> +	return ftpm_tee_probe_generic(dev);
> +}
> +
>  static int ftpm_plat_tee_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> =20
> -	return ftpm_tee_probe(dev);
> +	return ftpm_tee_probe_generic(dev);
>  }
> =20
>  /**
> @@ -265,7 +272,7 @@ static int ftpm_plat_tee_probe(struct platform_device=
 *pdev)
>   * Return:
>   *	0 always.
>   */
> -static int ftpm_tee_remove(struct device *dev)
> +static void ftpm_tee_remove_generic(struct device *dev)
>  {
>  	struct ftpm_tee_private *pvt_data =3D dev_get_drvdata(dev);
> =20
> @@ -285,15 +292,20 @@ static int ftpm_tee_remove(struct device *dev)
>  	tee_client_close_context(pvt_data->ctx);
> =20
>  	/* memory allocated with devm_kzalloc() is freed automatically */
> +}
> =20
> -	return 0;
> +static void ftpm_tee_remove(struct tee_client_device *tcdev)
> +{
> +	struct device *dev =3D &tcdev->dev;
> +
> +	ftpm_tee_remove_generic(dev);
>  }
> =20
>  static void ftpm_plat_tee_remove(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> =20
> -	ftpm_tee_remove(dev);
> +	ftpm_tee_remove_generic(dev);
>  }
> =20
>  /**
> @@ -335,11 +347,11 @@ static const struct tee_client_device_id optee_ftpm=
_id_table[] =3D {
>  MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
> =20
>  static struct tee_client_driver ftpm_tee_driver =3D {
> +	.probe		=3D ftpm_tee_probe,
> +	.remove		=3D ftpm_tee_remove,
>  	.id_table	=3D optee_ftpm_id_table,
>  	.driver		=3D {
>  		.name		=3D "optee-ftpm",
> -		.probe		=3D ftpm_tee_probe,
> -		.remove		=3D ftpm_tee_remove,
>  	},
>  };
> =20
> --=20
> 2.47.3
>=20

And also for this:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
