Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9FCD59D99
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:06:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D1DFE4FE8C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765782374;
	bh=cnoYVyWFnqoabzCVnr2BdHeHjYbJGus4X4BYXML+gdE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=IifFq/63GP0JxQgifo8p3Hh4NXMQBO5Uxnkc0/LM+WEgHlJg+SNGILtpKGcdt54gK
	 AGN8LwhlFVc+HbdoLo9TmZ8nJCPp/1Thj3VqHKjgb4B88NXdZVGfzJleOjNLKVX4i5
	 yxmeOn1dluvXnZ3p5xsCcfwO+vtYpiaiuT8kADV9m70BoBhG9uDzp4vXU7RgTh/+h+
	 BiUhFClFmxVBhjlPdUPhyKXQoSoSdXzdlPXdMY5GQJULPIMU2PavFpvXmr/2gBEGLm
	 AZfXstOjh2tBtbFU71VOQesuXFMxO4Z6K7wT4V63mLD6GazSxL6fS/TTguPDO2aMC3
	 Hfp1weLAoBcEA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9535C41BA6
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:05:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IriLj8Qv;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DC2E840039;
	Mon, 15 Dec 2025 07:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DD8C4CEF5;
	Mon, 15 Dec 2025 07:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765782334;
	bh=YImZtGlAy2v8SvxjAMcdkjfHXe7+vZ+vbYUbhWK+gwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IriLj8Qv4vx4NWruPMyR+3bD/hBMJXGtaJXOSELZGAEpQ6RcWyegshl7DUy7waJX/
	 KipzTiO596srtOFFARwiWcUOPq4peNO3nSC1lr48l/1vyT3/0VPu2vZysnhCGwXxal
	 Ki5e055wVqFF/8oBUiFFo0A+vZVXN/D+XubWMHAGa9upVjBGh2M/ECs9yhRj/oNNwh
	 FFvMnP6PUSurP6GsxUbqRdPYBoKA3EKvI3IqG+MtdDkya1Sk4V5Pzor18YeSCXQB16
	 HTLHsDIXRQpad3GN3ATOHvSsuzrC0Kv6H/owEllbL2UtmtIzjTDiu/tCD4D5I9gPLO
	 UEledGbIEvx9Q==
Date: Mon, 15 Dec 2025 16:05:30 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 01/17] tee: Add some helpers to reduce boilerplate for
 tee client drivers
Message-ID: <aT-zOu7dUtIPAjbJ@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <899e887aa68206155f2fc56ad768cbcf40012fb6.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <899e887aa68206155f2fc56ad768cbcf40012fb6.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[100.75.92.58:server fail];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9535C41BA6
X-Spamd-Bar: -----
Message-ID-Hash: SHVPZRU36KDER4HEVNL4GKSKB3JSZ7GN
X-Message-ID-Hash: SHVPZRU36KDER4HEVNL4GKSKB3JSZ7GN
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SHVPZRU36KDER4HEVNL4GKSKB3JSZ7GN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:14:55PM +0100, Uwe Kleine-K=F6nig wrote:
> Similar to platform drivers (and others) create dedicated register and
> unregister functions and a macro to simplify modules that only need to
> handle driver registration in their init and exit handlers.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/tee/tee_core.c  | 16 ++++++++++++++++
>  include/linux/tee_drv.h |  9 +++++++++
>  2 files changed, 25 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index d65d47cc154e..51379f7fc5d5 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1405,6 +1405,22 @@ const struct bus_type tee_bus_type =3D {
>  };
>  EXPORT_SYMBOL_GPL(tee_bus_type);
> =20
> +int __tee_client_driver_register(struct tee_client_driver *tee_driver,
> +				 struct module *owner)
> +{
> +	tee_driver->driver.owner =3D owner;
> +	tee_driver->driver.bus =3D &tee_bus_type;
> +
> +	return driver_register(&tee_driver->driver);
> +}
> +EXPORT_SYMBOL_GPL(__tee_client_driver_register);
> +
> +void tee_client_driver_unregister(struct tee_client_driver *tee_driver)
> +{
> +	driver_unregister(&tee_driver->driver);
> +}
> +EXPORT_SYMBOL_GPL(tee_client_driver_unregister);
> +
>  static int __init tee_init(void)
>  {
>  	int rc;
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 88a6f9697c89..850c03b2cdea 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -322,4 +322,13 @@ struct tee_client_driver {
>  #define to_tee_client_driver(d) \
>  		container_of_const(d, struct tee_client_driver, driver)
> =20
> +#define tee_client_driver_register(drv) \
> +        __tee_client_driver_register(drv, THIS_MODULE)
> +int __tee_client_driver_register(struct tee_client_driver *, struct modu=
le *);
> +void tee_client_driver_unregister(struct tee_client_driver *);
> +
> +#define module_tee_client_driver(__tee_client_driver) \
> +	module_driver(__tee_client_driver, tee_client_driver_register, \
> +		      tee_client_driver_unregister)
> +
>  #endif /*__TEE_DRV_H*/
> --=20
> 2.47.3
>=20
