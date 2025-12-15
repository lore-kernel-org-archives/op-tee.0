Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C159D59D99
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:23:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CF38E4FE8C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765783427;
	bh=w9nZsuc+S/PzgppUs7YeKIPwWL4YpSho8mIEzfcXsVM=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XbeWl1QmSyTmuIqib5Do63mj/bg3WFFrE/NeezhPJTAEL8+rI7yQltyhDWrehyQtO
	 4pEdQCU7GVPovWatsgQZ9Oeu2A1rIOoto7x2kYDfjVWsDyXlwMiNOIt5FOulS1Bien
	 m9bwqM/x0615ZNGeuT/e8fm6KBGIRqX55aj0u5gET7DfGaGw8tU2CIo/YsuzANKUE2
	 VLB/oFp4wcHgiNhFsDxFxkpaUfOMrhZ1fRCFQoyOkgCKcpRhL7qstd+R20BXdOfh+Y
	 7gUREHzvxB9j11wUXJek64rRcqpDYBmF1gKdT40/pQdyTZARZTKABGiijtMIPLf6Gi
	 asHh6zlM86SZw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 704D14320D
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:23:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g9KVs2QE;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D3AE660127;
	Mon, 15 Dec 2025 07:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB834C4CEF5;
	Mon, 15 Dec 2025 07:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765783393;
	bh=Ndkdct+kc4a23U8HI5m2DXW0sRa3QtnMfg6MmJAUS6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9KVs2QEb9v9WsbvT6G6SiGNvw4t/6sgDycujOQd7ep5MrVJ8hfFmxniNpz3j2oQq
	 01aLmq87PypZAmIjsv6tGyAr3FYxGLHkBIWS2poLeEbSPPdlocFrJ1NrvtY5GxefGZ
	 EHGOR2vF3DqPkXJ0yOYumtMClLl4EgRAax7hVqO8fcLoUad1V5QSl9W9zqgEPjZqcc
	 x58h3rsI5z8Du8U62GftItu5YKzGkPH5oazPBnenMVtmsex5CsekX+QU7dr/k0rZIk
	 NKINJTOx0MvJXFY0Z1jmZJpsoV9X2vx4oH0bR1I5XOgLvv+sysQohkQojzmCm1jVT7
	 T7Z7arg+CN+ew==
Date: Mon, 15 Dec 2025 16:23:08 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 02/17] tee: Add probe, remove and shutdown bus
 callbacks to tee_client_driver
Message-ID: <aT-3XEEpOIAl5R_Q@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <7f73b2ee784c0b78fa3bfee3aaa3b95f47041178.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7f73b2ee784c0b78fa3bfee3aaa3b95f47041178.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[172.105.4.254:server fail,100.75.92.58:server fail];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 704D14320D
X-Spamd-Bar: -----
Message-ID-Hash: 7BXY2DBBYSNARJABJAQOGBLTQ4ZYFMM2
X-Message-ID-Hash: 7BXY2DBBYSNARJABJAQOGBLTQ4ZYFMM2
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7BXY2DBBYSNARJABJAQOGBLTQ4ZYFMM2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:14:56PM +0100, Uwe Kleine-K=F6nig wrote:
> Introduce a bus specific probe, remove and shutdown function. For now
> this only allows to get rid of a cast of the generic device to a
> tee_client device in the drivers and changes the remove prototype to
> return void---a non-zero return value is ignored anyhow.
>=20
> The objective is to get rid of users of struct device_driver callbacks
> .probe(), .remove() and .shutdown() to eventually remove these. Until
> all tee_client drivers are converted this results in a runtime warning
> about the drivers needing an update because there is a bus probe
> function and a driver probe function.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/tee/tee_core.c  | 68 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/tee_drv.h |  3 ++
>  2 files changed, 71 insertions(+)
>=20
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 51379f7fc5d5..89164d35fc5c 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1398,19 +1398,87 @@ static int tee_client_device_uevent(const struct =
device *dev,
>  	return add_uevent_var(env, "MODALIAS=3Dtee:%pUb", dev_id);
>  }
> =20
> +static int tee_client_device_probe(struct device *dev)
> +{
> +	struct tee_client_device *tcdev=3D to_tee_client_device(dev);

missing space: s/tcdev=3D/tcdev =3D/

> +	struct tee_client_driver *drv =3D to_tee_client_driver(dev->driver);
> +
> +	if (drv->probe)
> +		return drv->probe(tcdev);
> +	else
> +		return 0;
> +}
> +
> +static void tee_client_device_remove(struct device *dev)
> +{
> +	struct tee_client_device *tcdev=3D to_tee_client_device(dev);

ditto.

> +	struct tee_client_driver *drv =3D to_tee_client_driver(dev->driver);
> +
> +	if (drv->remove)
> +		drv->remove(tcdev);
> +}
> +
> +static void tee_client_device_shutdown(struct device *dev)
> +{
> +	struct tee_client_device *tcdev=3D to_tee_client_device(dev);

ditto.

> +	struct tee_client_driver *drv =3D to_tee_client_driver(dev->driver);
> +
> +	if (dev->driver && drv->remove)
> +		drv->remove(tcdev);

don't we need to check and invoke drv->shutdown here?

> +}
> +
>  const struct bus_type tee_bus_type =3D {
>  	.name		=3D "tee",
>  	.match		=3D tee_client_device_match,
>  	.uevent		=3D tee_client_device_uevent,
> +	.probe		=3D tee_client_device_probe,
> +	.remove		=3D tee_client_device_remove,
> +	.shutdown	=3D tee_client_device_shutdown,
>  };
>  EXPORT_SYMBOL_GPL(tee_bus_type);
> =20
> +static int tee_client_device_probe_legacy(struct tee_client_device *tcde=
v)
> +{
> +	struct device *dev =3D &tcdev->dev;
> +	struct device_driver *driver =3D dev->driver;
> +
> +	return driver->probe(dev);
> +}
> +
> +static void tee_client_device_remove_legacy(struct tee_client_device *tc=
dev)
> +{
> +	struct device *dev =3D &tcdev->dev;
> +	struct device_driver *driver =3D dev->driver;
> +
> +	driver->remove(dev);
> +}
> +
> +static void tee_client_device_shutdown_legacy(struct tee_client_device *=
tcdev)
> +{
> +	struct device *dev =3D &tcdev->dev;
> +	struct device_driver *driver =3D dev->driver;
> +
> +	driver->shutdown(dev);
> +}
> +
>  int __tee_client_driver_register(struct tee_client_driver *tee_driver,
>  				 struct module *owner)
>  {
>  	tee_driver->driver.owner =3D owner;
>  	tee_driver->driver.bus =3D &tee_bus_type;
> =20
> +	/*
> +	 * Drivers that have callbacks set for tee_driver->driver need updating
> +	 * to use the callbacks in tee_driver instead. driver_register() warns
> +	 * about that, so no need to warn here, too.
> +	 */
> +	if (!tee_driver->probe && tee_driver->driver.probe)
> +		tee_driver->probe =3D tee_client_device_probe_legacy;
> +	if (!tee_driver->remove && tee_driver->driver.remove)
> +		tee_driver->remove=3D tee_client_device_remove_legacy;

missing space: s/tee_driver->remove=3D/tee_driver->remove =3D/

> +	if (!tee_driver->shutdown && tee_driver->driver.probe)

you should rather check here for tee_driver->driver.shutdown?

-Sumit

> +		tee_driver->shutdown =3D tee_client_device_shutdown_legacy;
> +
>  	return driver_register(&tee_driver->driver);
>  }
>  EXPORT_SYMBOL_GPL(__tee_client_driver_register);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 850c03b2cdea..e561a26f537a 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -315,6 +315,9 @@ struct tee_client_device {
>   * @driver:		driver structure
>   */
>  struct tee_client_driver {
> +	int (*probe)(struct tee_client_device *);
> +	void (*remove)(struct tee_client_device *);
> +	void (*shutdown)(struct tee_client_device *);
>  	const struct tee_client_device_id *id_table;
>  	struct device_driver driver;
>  };
> --=20
> 2.47.3
>=20
