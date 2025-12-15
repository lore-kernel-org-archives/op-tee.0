Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2876D5B874
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 22:53:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 287EF4FEDD
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 22:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765839239;
	bh=ZQ7RbUVNzWIV7Mi7IMdQ4PYDGDneu7EWwwPpmoVnHHY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tZ1Q9UWwxOuuqjGam4fQ2OvT6n+bJ7jQAB4+9wtUIwcySvPWeQna3c0nJm9gJuaiI
	 n7jXy2ybcVxwlDPUR2fpll0F8ATmIcbLQ6Lsxv3DCggEtZY+to1QEJU94GsX0m4zYX
	 kj4sYazrlt81zxiTzSKX6XdyMP3W59HYti61CaVskWcfXYDqGBlahl9IxRDe9uDX7V
	 kzJt1DM2pzMGl1wpN3NkTVEspClWwZxkIvEsM/QA6Fpy7FsRDXsYZEpFz1HLOhsiFY
	 uO+bbYTbjvxqUDZQ7wgydMOd7/TkIuPsOUcZYmjN8Tc+MpI+rr1xUF4BAFgBve89uG
	 cx+ANIoy1a43w==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6E72443227
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 22:53:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qB3niWaC;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B854043960;
	Mon, 15 Dec 2025 22:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1247FC4CEF5;
	Mon, 15 Dec 2025 22:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765839212;
	bh=B1h7/1DmR44SJyNfk6xG+ATAskZvle6ewB/MpObH3BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qB3niWaC7Ien1/Y0GfZr61WTp6exsLmJF1/UrG6af14N+OjXWdpLP25l6BBzgOpIT
	 djGIMMSCvyjaj2nkF6J7MLkehpBA8LomYDaUGRD87j+Rc+aPu32pWdImvEY6q2c4hm
	 B/HXj8wCviR1HgEUIjtrSEHAH5y7Lm8HMKQON9PMCGDR6Rt/qEwnEgp6OZ9a8i8tzp
	 lhYvuiXeuM0MGO0jBvp/i5sWbpRJ/jaxjN3/5OSqe/khUQIsDIqMCJz6P9aMGgo8Jj
	 C6dBFPhvo1On1oqjbnsJw7HzWqjBWiobjJb5eihikAkk5KBINZyQ5va6R5CKVc3Xwm
	 kzEX8x1ZhYwfA==
Date: Tue, 16 Dec 2025 00:53:28 +0200
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 17/17] tpm/tpm_ftpm_tee: Make use of tee bus methods
Message-ID: <aUCRaIL9DFSZcA7O@kernel.org>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <7bb98eeb8a478ca69344499f2e58016bbf787313.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7bb98eeb8a478ca69344499f2e58016bbf787313.1765791463.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmx.de,ziepe.ca,kernel.org,vger.kernel.org,lists.trustedfirmware.org,oss.qualcomm.com];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6E72443227
X-Spamd-Bar: ------
Message-ID-Hash: UID5AQWBLJ3VZOFE6NBIMGCDKDSPHO7T
X-Message-ID-Hash: UID5AQWBLJ3VZOFE6NBIMGCDKDSPHO7T
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Sumit Garg <sumit.garg@kernel.org>, linux-integrity@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UID5AQWBLJ3VZOFE6NBIMGCDKDSPHO7T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Mon, Dec 15, 2025 at 03:16:47PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.

nit: "TEE subsystem has implemented callbacks for probe() and remove()".

Or this what I presume has happened: someone has implemented new
callbacks to subsystem (vs randomly appearing from the divine
skies).

> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>=20
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
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

BR, Jarkko
