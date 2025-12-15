Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70CAD5B16E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 13:19:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 380C74FE9B
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765804785;
	bh=kWTln1gviCbN4kT5uOJ3jmSosw+WhT2Bj58ZmDNjBWE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jEAemKi3SC20JVZ38F48y6hWPmbXOpoRbmnRwmq8nApIKD1OPlYKmrR97rgvSfZmE
	 byYiHeLR8o36usLg9jskyIrr3SmTlIpqnlzn7+0jQBmCAwen6UApr0zjFoTx/aIOfZ
	 c9nplfG42f69j4oqy61h89oAefjgGJW4v1H8Cf9JUpJ58kflh8rz9o58rmYEBlzgTy
	 oNwuGOPMd4nrGa/621+v9Gfo5hjT5eXLJ5Aj4Gv3tMbLgWS2fJLxFa90OaMP7MjYf8
	 G6cgwF1CImBMUIQRI75w3NknZGQguADivoKTfu6RQ9X9BGisJ1K/gaNjdqLGzvy93L
	 8xyuQ+KwDUNeQ==
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ED04F41B91
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 10:42:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xa269C9h;
	dkim-atps=neutral
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4489A4E41C09
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 10:42:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17A1260664;
	Mon, 15 Dec 2025 10:42:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE8AC11941C71;
	Mon, 15 Dec 2025 11:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765795356; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iVnSkXLIZ8OVjARBRtMXQL8etwNmPUgJcIoKsh2mIdw=;
	b=xa269C9hVnH88eHieZoaBncQLiLIsHmpXh8lNZGAWaMCKo3d6WtI+lMAIWqAgkRvs/4pJJ
	mx8RF3W6E46GDmXNVR3HiTRqwVmoLbTf/gL5bt/i1EmOjB5CCiIknleHKQJtXhNjyKn6VC
	htWItCbHPH2qz8pvDFPcsQ0rSfymu0XM4FSxPsa6s8tBdFhIcjsfuEfrJ9q9czDdVou0Jz
	lAqkoUudQLi9asZS8ghQIV/ssBunwT6YYzy7VOnknR7Wr4IxazaMYhgLNJslTQXc9pv1jY
	p1XzY139FKo11KD70eeVctZDPj1I1pYE49caUqL4rQ5pbyPTXhUo2YmNXKIN/w==
Date: Mon, 15 Dec 2025 11:42:35 +0100
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 07/17] rtc: optee: Make use of tee bus methods
Message-ID: <20251215104235c0010f89@mail.local>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <a9c8da1b7b2832044129ec9e2616c40e0023ad57.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a9c8da1b7b2832044129ec9e2616c40e0023ad57.1765472125.git.u.kleine-koenig@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:185.246.85.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:21409, ipnet:185.246.84.0/22, country:FR];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[185.246.85.4:from];
	DKIM_TRACE(0.00)[bootlin.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: ED04F41B91
X-Spamd-Bar: ----
X-MailFrom: alexandre.belloni@bootlin.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: IFZSN55JGHZZOUKK747IVXDFKKM7IPME
X-Message-ID-Hash: IFZSN55JGHZZOUKK747IVXDFKKM7IPME
X-Mailman-Approved-At: Mon, 15 Dec 2025 13:18:49 +0000
CC: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IFZSN55JGHZZOUKK747IVXDFKKM7IPME/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Alexandre Belloni via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Alexandre Belloni <alexandre.belloni@bootlin.com>

On 11/12/2025 18:15:01+0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove. Make use of
> these. This fixes a runtime warning about the driver needing to be
> converted to the bus methods.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/rtc/rtc-optee.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-optee.c b/drivers/rtc/rtc-optee.c
> index f924a729ead0..eefde789d194 100644
> --- a/drivers/rtc/rtc-optee.c
> +++ b/drivers/rtc/rtc-optee.c
> @@ -547,9 +547,9 @@ static int optee_ctx_match(struct tee_ioctl_version_d=
ata *ver, const void *data)
>  		return 0;
>  }
> =20
> -static int optee_rtc_probe(struct device *dev)
> +static int optee_rtc_probe(struct tee_client_device *rtc_device)
>  {
> -	struct tee_client_device *rtc_device =3D to_tee_client_device(dev);
> +	struct device *dev =3D &rtc_device->dev;
>  	struct tee_ioctl_open_session_arg sess2_arg =3D {0};
>  	struct tee_ioctl_open_session_arg sess_arg =3D {0};
>  	struct optee_rtc *priv;
> @@ -682,8 +682,9 @@ static int optee_rtc_probe(struct device *dev)
>  	return err;
>  }
> =20
> -static int optee_rtc_remove(struct device *dev)
> +static void optee_rtc_remove(struct tee_client_device *rtc_device)
>  {
> +	struct device *dev =3D &rtc_device->dev;
>  	struct optee_rtc *priv =3D dev_get_drvdata(dev);
> =20
>  	if (priv->features & TA_RTC_FEATURE_ALARM) {
> @@ -696,8 +697,6 @@ static int optee_rtc_remove(struct device *dev)
>  	tee_shm_free(priv->shm);
>  	tee_client_close_session(priv->ctx, priv->session_id);
>  	tee_client_close_context(priv->ctx);
> -
> -	return 0;
>  }
> =20
>  static int optee_rtc_suspend(struct device *dev)
> @@ -724,10 +723,10 @@ MODULE_DEVICE_TABLE(tee, optee_rtc_id_table);
> =20
>  static struct tee_client_driver optee_rtc_driver =3D {
>  	.id_table	=3D optee_rtc_id_table,
> +	.probe		=3D optee_rtc_probe,
> +	.remove		=3D optee_rtc_remove,
>  	.driver		=3D {
>  		.name		=3D "optee_rtc",
> -		.probe		=3D optee_rtc_probe,
> -		.remove		=3D optee_rtc_remove,
>  		.pm		=3D pm_sleep_ptr(&optee_rtc_pm_ops),
>  	},
>  };
> --=20
> 2.47.3
>=20

--=20
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
