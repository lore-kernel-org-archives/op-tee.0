Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9177DD41D74
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:29:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E7A294FE9E
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765783776;
	bh=zq4pwGMBbOlRIR6ZIKVtKayG9LD4iP9Pm3xeLI/rIqE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=y90iKVcAgw5Bhgk3lfjhQ+u7CXplONqpn+GYocNSDIYY4XU/kw243c3RbaREtY+VZ
	 y8ARrfQUMijPrg0sSwuqHu0Lzc9HPs3qU84wcxXQ79wO2fwbxr2+ISr/RnRQwAyds+
	 90YLmJOe04Vj3uZ27qcuq2gXFEClCgwDu+kuEPySH3HllpN6XHoIcvEnAHZaaSwjCh
	 5tMugyNEzuQHB793yzxUC/naqXV+gqH2b8JcDVvO7jUrW+tt1nRB9GfoCGnNmFgI2M
	 FZV37phP74sIUlkgEtWbk45AP29jNstF9+/604aHT/qWdb/3ADi7SEu4NFcs+iHFpg
	 ibrmr4i698Uqg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B9A5341BA6
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:29:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I2b9RvOQ;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F3CB160127;
	Mon, 15 Dec 2025 07:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E58C4CEF5;
	Mon, 15 Dec 2025 07:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765783743;
	bh=+acBqxMrq6CWcFTVPTL0XBwbI38gJhfbp6LXCHPsn/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2b9RvOQZmqZdZdFSgFyEDnssGAjMKvA5qvUCp1UeLcw10rWuoCWZcM4Oi22MOwxG
	 5W3ZZ+1SGOf1UB8cBkjLuGQ/rBoUfo+bGtaZ90PRNX9QO/yUHuIg1DpDX/6jvkV5t2
	 6MF7NAc2ctPeMvPVgNT3NoKHFJ+mBVGMLUfM44+p0aZQw0JgzNN5LXGhjdV4PRDS30
	 ZsEDU3HsRRAf62mLNsljHfit4lQiaffrm1MsjkT1aE1WlWjhtLIAxS6OKCPnSE7CIB
	 tXJIJ06nyUT0dw6pDfFfcBmEZT3P1IHfNcCK8RMA1pq2hAoy30I5IQqm6XOeYez8k/
	 vMtsH6nknJCMg==
Date: Mon, 15 Dec 2025 16:28:58 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 06/17] rtc: optee: Migrate to use tee specific driver
 registration function
Message-ID: <aT-4usVp-PhNNw7T@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <a586934215a4971f9920398655cb85fd29d91c9f.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a586934215a4971f9920398655cb85fd29d91c9f.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
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
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B9A5341BA6
X-Spamd-Bar: ---
Message-ID-Hash: C5MNSGGIZCPXFKM3LQ2KALQXMTKN57CO
X-Message-ID-Hash: C5MNSGGIZCPXFKM3LQ2KALQXMTKN57CO
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, op-tee@lists.trustedfirmware.org, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/C5MNSGGIZCPXFKM3LQ2KALQXMTKN57CO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:00PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee subsystem recently got a set of dedicated functions to register
> (and unregister) a tee driver. Make use of them. These care for setting t=
he
> driver's bus (so the explicit assignment can be dropped) and the driver
> owner (which is an improvement this driver benefits from).
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/rtc/rtc-optee.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

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
