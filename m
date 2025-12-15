Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE47D41D74
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:41:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C8E84FF2A
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765784468;
	bh=1/SqOxkZ8K9YmUxbPPdqIFLzzTEK5ivBtHoYe/c4+18=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=E1vZ8q4hheJx2lUVw6yV4CyJ3/G75dhl+d6NBuOM0aDzjRhSS5+32u8nN/80uS5VF
	 lp0HHA5BNkJiY33mUGqMHyEvD6iELbp2+sfu53K7WYEcMLFpyT9VfzfYOn/sy2Uzll
	 aT7VhiUXb2Aa8qncc9X0uhXkrL0GrJkJZnQyA+J+KpSf3OD91/OcTO9K2m2XFVK9TS
	 tpMUWBBSuh5tsBBYvPli9ng0v6nSTZZcCoQ09paFPNqbNfJVvWREU6irPCZCeaJ0Lk
	 NTbq9qoJb5I+N0ie1r9vI0JXrIv9T18T4eZLzV6mnXKBjbMAwy6nynCh2QYcMb92rH
	 xTWNhGyMMc0UQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E2AE74FEDD
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:40:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KbQJdW5K;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 43554404FE;
	Mon, 15 Dec 2025 07:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6244CC4CEF5;
	Mon, 15 Dec 2025 07:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765784434;
	bh=23XSYhvjr3uNqy8bGtatdctDcA1JC+DCg4ttOh6KX6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KbQJdW5KQM0yuDAy5L4hXjKuPPk151eQCzYeanPy+BTz/yOyrW37oRmXQkDg3B6Bc
	 KIxV88wvKtfT5mqL9vW9W8Fis57M5v7C2+9h6bp3mZ6odAhnDHv3LB6PjhLHb43gAN
	 V19XnmidUZlv1uPy/sAoi06/M4estFM4jWhICPuhTaBhF0vpQtaQ6J2rck1JczS8fN
	 ErreS/ePJUlGXgPp1v4Fpt0Jnez9xz5oW6n4WBJXt9Fs7BC1boHe2CH0VJAXxTYEFo
	 Mt/QntlVhk67AeYHn3G+6CpR5zgO2RXrGb3Qc7U/EsUrYhzvVP6iL8f8J/8gEGXYTc
	 C5xwiJyC8uueg==
Date: Mon, 15 Dec 2025 16:40:28 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 17/17] tpm/tpm_ftpm_tee: Make use of tee bus methods
Message-ID: <aT-7bIq-CAg53Tf6@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <eaf8216e8a6c3dabce5a82be5765d67c66318791.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eaf8216e8a6c3dabce5a82be5765d67c66318791.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_CC(0.00)[linaro.org,gmx.de,kernel.org,ziepe.ca,lists.trustedfirmware.org,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from,100.75.92.58:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E2AE74FEDD
X-Spamd-Bar: -----
Message-ID-Hash: QOH5FE33J4AIY2EZGAP75IHY22GUX6YK
X-Message-ID-Hash: QOH5FE33J4AIY2EZGAP75IHY22GUX6YK
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QOH5FE33J4AIY2EZGAP75IHY22GUX6YK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:11PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

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
>=20
