Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DE8D41D74
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:33:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E74BF4FED2
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765784015;
	bh=Be8R1Y/VWsWIMoilDVP4sqm+hnev9rISY0MRGNCHDq8=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eJaAWfFrEq7q+jnu50DeFj8m28e5UYoCYLntCb51bTiYfU1CK9JyccIfTFeE/HU86
	 lcVDeEE9nkHbxoLfRjF6mxr3qS7O8CSdkQnCfFj1n/b7RM1QnfjU25xp/9+Si9Z7wH
	 ajxpQb94TqKJAqxUjArbmpeRUfklHyvkuZXuXtoJqkRk1qBIwlWa+qPPSuWAtoDmgC
	 DdjI4uqkz29kGoyBNrXxv0+gTQG0HUcJYXeE9AISCok9xl4XokJrXKF/jAVEcuBf1r
	 lV1Dha4gagfWialRj7PZoYg9R5SqQ6KfJByVTWtv/CVEXSElvrezga+sFNtaQMaxNO
	 JMc2ObvyIFQvA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C54494FE89
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:33:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W8Z3NaTa;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 27B0D60127;
	Mon, 15 Dec 2025 07:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C51C4CEF5;
	Mon, 15 Dec 2025 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765783981;
	bh=BA6xeU5bsb5CEAuSg7p2q3xijPwECww0M/yOXMPnGRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8Z3NaTaapjPXXOknD7a6ed7PNFUNruwaceXiDABCUWBOPYY86MVGVfghoXYhtEnK
	 nG6cX6w2tYV84SRnuAr/kVxjqZfh4GuLXDkQs+VUSRJ1/yFY5T6gqhLUrz9mkiIpD2
	 5paRRwHe6Gc/9bkWhd70Aldnu+830DoJzm+KY9CLMrod+26ypQmfMeF1gipronNxbg
	 EkP1UNDJgzrWdhSaK5nfa00j1oe13U1i//iKiQrVjjF615EpcIzoaHeveeQ5Yxom47
	 i34Jb1nQ2WE/8MlzUScV5WkkYVKzU5in6og5SUieZSvy1dOTADm5Cp25S+B16yMkIF
	 A4oE0uIJQzEQQ==
Date: Mon, 15 Dec 2025 16:32:55 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 11/17] firmware: arm_scmi: Make use of tee bus methods
Message-ID: <aT-5p7FTvNU8jcLU@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <46dae3cada663b3a5ae1989881d9e74ef40acce5.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <46dae3cada663b3a5ae1989881d9e74ef40acce5.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,wanadoo.fr,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C54494FE89
X-Spamd-Bar: ---
Message-ID-Hash: YIJF6AFCWRQDUP4SOYPSONV42R4APW4V
X-Message-ID-Hash: YIJF6AFCWRQDUP4SOYPSONV42R4APW4V
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sudeep Holla <sudeep.holla@arm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Cristian Marussi <cristian.marussi@arm.com>, op-tee@lists.trustedfirmware.org, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YIJF6AFCWRQDUP4SOYPSONV42R4APW4V/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:05PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods. Note that the return value of .remove=
()
> was already ignored before, so there is no problem introduced by dropping
> the error returns.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/firmware/arm_scmi/transports/optee.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/firmware/arm_scmi/transports/optee.c b/drivers/firmw=
are/arm_scmi/transports/optee.c
> index 8fdb80d3fabd..07ae18d5279d 100644
> --- a/drivers/firmware/arm_scmi/transports/optee.c
> +++ b/drivers/firmware/arm_scmi/transports/optee.c
> @@ -529,8 +529,9 @@ static const struct of_device_id scmi_of_match[] =3D {
>  DEFINE_SCMI_TRANSPORT_DRIVER(scmi_optee, scmi_optee_driver, scmi_optee_d=
esc,
>  			     scmi_of_match, core);
> =20
> -static int scmi_optee_service_probe(struct device *dev)
> +static int scmi_optee_service_probe(struct tee_client_device *scmi_pta)
>  {
> +	struct device *dev =3D &scmi_pta->dev;
>  	struct scmi_optee_agent *agent;
>  	struct tee_context *tee_ctx;
>  	int ret;
> @@ -578,24 +579,22 @@ static int scmi_optee_service_probe(struct device *=
dev)
>  	return ret;
>  }
> =20
> -static int scmi_optee_service_remove(struct device *dev)
> +static void scmi_optee_service_remove(struct tee_client_device *scmi_pta)
>  {
>  	struct scmi_optee_agent *agent =3D scmi_optee_private;
> =20
>  	if (!scmi_optee_private)
> -		return -EINVAL;
> +		return;
> =20
>  	platform_driver_unregister(&scmi_optee_driver);
> =20
>  	if (!list_empty(&scmi_optee_private->channel_list))
> -		return -EBUSY;
> +		return;
> =20
>  	/* Ensure cleared reference is visible before resources are released */
>  	smp_store_mb(scmi_optee_private, NULL);
> =20
>  	tee_client_close_context(agent->tee_ctx);
> -
> -	return 0;
>  }
> =20
>  static const struct tee_client_device_id scmi_optee_service_id[] =3D {
> @@ -609,11 +608,11 @@ static const struct tee_client_device_id scmi_optee=
_service_id[] =3D {
>  MODULE_DEVICE_TABLE(tee, scmi_optee_service_id);
> =20
>  static struct tee_client_driver scmi_optee_service_driver =3D {
> -	.id_table	=3D scmi_optee_service_id,
> -	.driver		=3D {
> +	.probe =3D scmi_optee_service_probe,
> +	.remove =3D scmi_optee_service_remove,
> +	.id_table =3D scmi_optee_service_id,
> +	.driver =3D {
>  		.name =3D "scmi-optee",
> -		.probe =3D scmi_optee_service_probe,
> -		.remove =3D scmi_optee_service_remove,
>  	},
>  };
> =20
> --=20
> 2.47.3
>=20
>=20
