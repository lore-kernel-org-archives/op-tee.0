Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0079BD41D74
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:30:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 494CC4FE89
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765783854;
	bh=pZPBs6dvUxDNsIOzgkuFCEHNzwuvMN3TWKJNGZX5UIE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tUDYaWaMuU1sgPkK4NICZr8npGoUta0//Ex1cierL7gJ0pkOhoBCF7arbu04Cy5x6
	 MGZQalCNjMw/El0K91ACSD0oc423y2o08ztQfKAR4BUgd0BqY+lrulhRhU8fsrZM2q
	 J9UXQQ7OmNCbhRKq/b02vecKoJ/nI2YPSNJXoDXmYetcVcHnH2WJy4JKEJ0X/EXgCu
	 bgv4wXegyjAzeKllR6cARbmIiNV8Q2PG8ArCg9UnOb6MA8OR8RJDIHIRVM1aT5PLKl
	 p6Pu2bEDsCXaBfsNpySstT6LN7uwRYJH4pgadvlfyY8muT5a8w/Ab3Vg4hN1zDouGE
	 H99su1u3wizHg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B01484FE89
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:30:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E7c7rQKC;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 06A164400C;
	Mon, 15 Dec 2025 07:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5071BC19422;
	Mon, 15 Dec 2025 07:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765783821;
	bh=pXIJDfb/CsLXA8wtAEz4FUjy0cEBwnmQr7yMw4TD76s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7c7rQKCKBFkzxqMgC9va5F3dOj8PJgLiLriaPipnDZCbfaHrCrsT4Ks8F6S21dlA
	 4VlUZLWb9b2r+p3TLEapqCMi67CIrBwY6GBfHJxQH/wZNP13RPb3yPmymc6Dy+OHpr
	 s/RZHSQUhjBuUq8F1YWiPTKi1OaLxYBiJsO2PjP1laTwW6IciTE5unlq6UX5MEDEZN
	 V9gGoMn3kNiiZGZKWSz2S6YvIVyQbxfIetu3R5A7KOm7GJFBkzVyb/ynXWw5GLBcPC
	 G/GTE//kBQwV5Pb1Xs1sAgz73siwmUg5M4EK4qRNxiqNpTiKR594bdouYghtVnAlB6
	 eRcMjktyVx4IQ==
Date: Mon, 15 Dec 2025 16:30:16 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 07/17] rtc: optee: Make use of tee bus methods
Message-ID: <aT-5CCZBzZdn937E@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <a9c8da1b7b2832044129ec9e2616c40e0023ad57.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a9c8da1b7b2832044129ec9e2616c40e0023ad57.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from,100.75.92.58:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B01484FE89
X-Spamd-Bar: ---
Message-ID-Hash: NYGB7UAAX2XCR2KHQ6DKXGGVJBIX7K4H
X-Message-ID-Hash: NYGB7UAAX2XCR2KHQ6DKXGGVJBIX7K4H
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, op-tee@lists.trustedfirmware.org, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NYGB7UAAX2XCR2KHQ6DKXGGVJBIX7K4H/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:01PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove. Make use of
> these. This fixes a runtime warning about the driver needing to be
> converted to the bus methods.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/rtc/rtc-optee.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

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
