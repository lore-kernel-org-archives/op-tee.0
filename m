Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE56D41D74
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:28:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2D30A4FECA
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765783688;
	bh=5jtidzlx8+FKVk7oOD1Uck8HdLWlqU6c9jLerEaB0I4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=YF4Z2UJd/sgqKzjxralf3ttoVTBGigh7ajTWgUNnboZE9C7bho2mIYsIvlh/o+kpM
	 QL9yjY1Jo7JhQj0CYOQE27S/Oucpbol5jmJdZg1X+TXO3KnBdUSTViWRHK1jzHsrTY
	 Xq0eUdtYkheP01SawTayI9DNApbzg7MZiZ0ogvOy3uk68D5U+6APLahZAtTgPLjVsa
	 J+Y3CvR0S/+DSxTnd1I/cLYsDnI+R12RVE6Boh27GdcY9zPo2V5GP5FM8M5QwbCKQ4
	 sA07T98o7FBEkp+VGrrJpwYsC+Me1/guURh02xWFbp1hOpPCZITKLfKs9lM7lt4P71
	 PrdRoGIuQpngA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B2EEE41BA6
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:27:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fhwv5XeK;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1E6FB60127;
	Mon, 15 Dec 2025 07:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A48AC4CEF5;
	Mon, 15 Dec 2025 07:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765783653;
	bh=pn4RUOECBeVYRLP+Yv3nGf565EQFyqgDPcA79qQqQkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhwv5XeK3kHHrv6jleo/yJ23crb4Tyk3vjjiXde3HvfewyM/FyZEdRzQxsHFvKCIH
	 +g/5Tnr+AaNYeRxsrj/XLiSv9pGs72kbsGl5OsHYzUG2npx21/IWuHvXriaY1DnmUW
	 199NqQP80GYzlT4j5q5Gqxl84f8t/PwcS7JcXfJjuimIUA865J+a/u6n+Q/YWBl6+T
	 jGCTU4oy9+9iZcqTQS/TpE0U2reQ6TK3qEEwcsJcBMc4YjNVecpwGXiF+GUDaVptVg
	 +e9QRmUQ/+yq2Ag7wW0RzkUCDXZNxgjvw+wKe0AOSz38QiBCShZg+23MA9N3Fv4cgO
	 XHDbaeVzo7n8w==
Date: Mon, 15 Dec 2025 16:27:28 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 05/17] hwrng: optee - Make use of tee bus methods
Message-ID: <aT-4YLINRTXamLfI@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <83301effbb923117122f5f076edbfdad1f947386.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <83301effbb923117122f5f076edbfdad1f947386.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.105.4.254:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B2EEE41BA6
X-Spamd-Bar: -----
Message-ID-Hash: RQ4JIQOLQ4X7JIZVFEDDUA3XJD5MCO4G
X-Message-ID-Hash: RQ4JIQOLQ4X7JIZVFEDDUA3XJD5MCO4G
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RQ4JIQOLQ4X7JIZVFEDDUA3XJD5MCO4G/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

nit for subject: s/hwrng: optee -/hwrng: optee:/

On Thu, Dec 11, 2025 at 06:14:59PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/hw_random/optee-rng.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/=
optee-rng.c
> index 6ee748c0cf57..5a3fa0b38497 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -211,9 +211,9 @@ static int optee_ctx_match(struct tee_ioctl_version_d=
ata *ver, const void *data)
>  		return 0;
>  }
> =20
> -static int optee_rng_probe(struct device *dev)
> +static int optee_rng_probe(struct tee_client_device *rng_device)
>  {
> -	struct tee_client_device *rng_device =3D to_tee_client_device(dev);
> +	struct device *dev =3D &rng_device->dev;
>  	int ret =3D 0, err =3D -ENODEV;
>  	struct tee_ioctl_open_session_arg sess_arg;
> =20
> @@ -261,12 +261,10 @@ static int optee_rng_probe(struct device *dev)
>  	return err;
>  }
> =20
> -static int optee_rng_remove(struct device *dev)
> +static void optee_rng_remove(struct tee_client_device *tee_dev)
>  {
>  	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
>  	tee_client_close_context(pvt_data.ctx);
> -
> -	return 0;
>  }
> =20
>  static const struct tee_client_device_id optee_rng_id_table[] =3D {
> @@ -278,11 +276,11 @@ static const struct tee_client_device_id optee_rng_=
id_table[] =3D {
>  MODULE_DEVICE_TABLE(tee, optee_rng_id_table);
> =20
>  static struct tee_client_driver optee_rng_driver =3D {
> +	.probe		=3D optee_rng_probe,
> +	.remove		=3D optee_rng_remove,
>  	.id_table	=3D optee_rng_id_table,
>  	.driver		=3D {
>  		.name		=3D DRIVER_NAME,
> -		.probe		=3D optee_rng_probe,
> -		.remove		=3D optee_rng_remove,
>  	},
>  };
> =20
> --=20
> 2.47.3
>=20
