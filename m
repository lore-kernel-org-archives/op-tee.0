Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308F3D5B16F
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 13:19:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 76A634FE89
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765804748;
	bh=9VKSl3JQmCYqHn3+PxjxpSTxPd+ZgGFgcdZcd6rvj6M=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FMu5ZuM6aeYjYekbw1DabHZeOJGG14GyyI6hFzZZaSD+bpeGR6+4cm8FlWmINW/xb
	 RvSaok2XvnFZyHYOVQ7JowQW7G5Rnyb6lAxyCM+77V8eTfxbGhQ0rh7OPUEt//hJ8z
	 9p8k3c14qUp5wdOWlUHMAOl4NdP05zvIfONy5/7C09BY1RzLa3kiluaCKqUR4LjjtM
	 txRPAFBYJp3bVKKgmRxk3gcED92AYpUFx1RpN+kUc846V+6/HrfMAUX+wdyblve8Fz
	 xhXui0IKbpm3yXL+aKYVLwCtf2H6F6stXVINW2G9M/hdUr3QPNoUKrqtSKGnl7pVU/
	 oKJ9yH1zb5ocw==
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 359C941B91
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 10:41:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=b/iVlkhq;
	dkim-atps=neutral
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0D6384E41C09
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 10:41:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D764D60664;
	Mon, 15 Dec 2025 10:41:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8998511941C6F;
	Mon, 15 Dec 2025 11:41:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765795309; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EUBV6XSQpX1AofrFO8TKRN3vjQObFhvyS/Q6s52icVw=;
	b=b/iVlkhqa6DufO+mHtMb971AG3039Ptu5Xc+nyaBEScChO/NPquLSNONryRngqJFD2WZP0
	pzqy8pVV4dw+POe66rZLCpPUkbLXxiwZ3aXecRDodt9h5XDTY1yzV0LE2w4goZCd8fAHiY
	8zVmEoAU7ZanSrQDDNj0hu6s6Hddz6cIDJtK+Afjpil5MMq+j29h10fALy4J5TSF04qEXM
	n8TfM0rtozRTCoWSTtQoBcf3z8J5ng6zdEmBuLI2eMyYmnLG4ARMNSEaorIQE/3ywIiUVe
	XnLAizzyVvVkmc8T+0UQoBdqYRXsGzWGPPhStjrLK3samR6QXkFuzjjn5HbMlQ==
Date: Mon, 15 Dec 2025 11:41:47 +0100
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 06/17] rtc: optee: Migrate to use tee specific driver
 registration function
Message-ID: <202512151041471a0eabfc@mail.local>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <a586934215a4971f9920398655cb85fd29d91c9f.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a586934215a4971f9920398655cb85fd29d91c9f.1765472125.git.u.kleine-koenig@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:185.246.85.4];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:21409, ipnet:185.246.84.0/22, country:FR];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[185.246.85.4:from];
	DKIM_TRACE(0.00)[bootlin.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 359C941B91
X-Spamd-Bar: ---
X-MailFrom: alexandre.belloni@bootlin.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: JQY33U6OFWLHKGHB5DIEF3WPE6TE65J5
X-Message-ID-Hash: JQY33U6OFWLHKGHB5DIEF3WPE6TE65J5
X-Mailman-Approved-At: Mon, 15 Dec 2025 13:18:49 +0000
CC: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JQY33U6OFWLHKGHB5DIEF3WPE6TE65J5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Alexandre Belloni via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Alexandre Belloni <alexandre.belloni@bootlin.com>

On 11/12/2025 18:15:00+0100, Uwe Kleine-K=F6nig wrote:
> The tee subsystem recently got a set of dedicated functions to register
> (and unregister) a tee driver. Make use of them. These care for setting t=
he
> driver's bus (so the explicit assignment can be dropped) and the driver
> owner (which is an improvement this driver benefits from).
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/rtc/rtc-optee.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-optee.c b/drivers/rtc/rtc-optee.c
> index 184c6d142801..f924a729ead0 100644
> --- a/drivers/rtc/rtc-optee.c
> +++ b/drivers/rtc/rtc-optee.c
> @@ -726,25 +726,13 @@ static struct tee_client_driver optee_rtc_driver =
=3D {
>  	.id_table	=3D optee_rtc_id_table,
>  	.driver		=3D {
>  		.name		=3D "optee_rtc",
> -		.bus		=3D &tee_bus_type,
>  		.probe		=3D optee_rtc_probe,
>  		.remove		=3D optee_rtc_remove,
>  		.pm		=3D pm_sleep_ptr(&optee_rtc_pm_ops),
>  	},
>  };
> =20
> -static int __init optee_rtc_mod_init(void)
> -{
> -	return driver_register(&optee_rtc_driver.driver);
> -}
> -
> -static void __exit optee_rtc_mod_exit(void)
> -{
> -	driver_unregister(&optee_rtc_driver.driver);
> -}
> -
> -module_init(optee_rtc_mod_init);
> -module_exit(optee_rtc_mod_exit);
> +module_tee_client_driver(optee_rtc_driver);
> =20
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Cl=E9ment L=E9ger <clement.leger@bootlin.com>");
> --=20
> 2.47.3
>=20

--=20
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
