Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F9CD59D99
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:34:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 38EB94FEDB
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765784056;
	bh=gYEQk4NxhSPSuaP1X7FGuUVbEMXuyWMsOyF257Z7JjI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ZA55lvKp85uGXbeROWkFwAopR0mPDPs+6mXqqwi2TO9pu0/uIWZoinUq7OREWEfIz
	 5gRQuWtguTlT2rwYgLbUFiym+b2rK6IJR/bt8y3IDN5ldFkXWW7CO3iruARNatOXnx
	 f/gselEsFfMeaA02TPZdjvpqDmpCezd1CB+1rmkAmfrv7k1NQ3680XN+hnH0NMh9jb
	 zdqaiYGSrDZCKwzpD+QAu5E2qnnVWVTzXEr7w74DGTZsSrAF1EN/blGzJI0wJ7zH/4
	 Ltk95qAZhWZIJYVu28i/rk7PM+2K2xrWoi2t8H2RBOTEJX6/eC26WLrvzBm6G7OUcN
	 cC4VM6hXnXunA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8B2894FEDA
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:33:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dxSfLzdO;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D6BF9400E3;
	Mon, 15 Dec 2025 07:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C11C4CEF5;
	Mon, 15 Dec 2025 07:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765784023;
	bh=5820ngv824z9uIu9EV45nBDdVf0Jn6z4pOSe9nMQUgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxSfLzdOgHpYOIjRNV+fICOTTU2fO1BZMdnpYaK5H994otGjw1ARZSr5IJbXGUYQR
	 DZEI4PJp2L5sJ8RxOT2hc0W2CENFG6paMyA3/inlUwRMkYB+AWQp0n6ryuOJyMYkcQ
	 dUy+vEzD7/WJrbHKswIq2Zq18iIuWeV+v/agisbgggBDfDKZL1i5sdkCUXeGT8Z4nX
	 UNzgNxuqZc0aGn0p7343OZcxE/hso0D9N3kq5isU6C6YHvDTOTgWONqgc+M9TgZN4v
	 kcvUQSMnOgm1AipiVMVATsJ7wZ9ePdxkREc7MXVp+Vv42UFf8pT4nJ8sA1L6soETqP
	 c9QesQEL1OVyg==
Date: Mon, 15 Dec 2025 16:33:37 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 12/17] firmware: tee_bnxt: Make use of
 module_tee_client_driver()
Message-ID: <aT-50by9eHqHQIYH@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <5b520fd96f8b385acc280226f548913c9ee98011.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5b520fd96f8b385acc280226f548913c9ee98011.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,broadcom.com,gmail.com,lists.trustedfirmware.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 8B2894FEDA
X-Spamd-Bar: ---
Message-ID-Hash: UKQDOIHAQN6X6PSDXMZ7PMOA3MWWR2ZZ
X-Message-ID-Hash: UKQDOIHAQN6X6PSDXMZ7PMOA3MWWR2ZZ
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UKQDOIHAQN6X6PSDXMZ7PMOA3MWWR2ZZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:06PM +0100, Uwe Kleine-K=F6nig wrote:
> Reduce boilerplate by using the newly introduced module_tee_client_driver=
().
> That takes care of assigning the driver's bus, so the explicit assigning
> in this driver can be dropped.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/firmware/broadcom/tee_bnxt_fw.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/b=
roadcom/tee_bnxt_fw.c
> index 40e3183a3d11..fbdf1aa97c82 100644
> --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> @@ -261,25 +261,13 @@ static struct tee_client_driver tee_bnxt_fw_driver =
=3D {
>  	.id_table	=3D tee_bnxt_fw_id_table,
>  	.driver		=3D {
>  		.name		=3D KBUILD_MODNAME,
> -		.bus		=3D &tee_bus_type,
>  		.probe		=3D tee_bnxt_fw_probe,
>  		.remove		=3D tee_bnxt_fw_remove,
>  		.shutdown	=3D tee_bnxt_fw_shutdown,
>  	},
>  };
> =20
> -static int __init tee_bnxt_fw_mod_init(void)
> -{
> -	return driver_register(&tee_bnxt_fw_driver.driver);
> -}
> -
> -static void __exit tee_bnxt_fw_mod_exit(void)
> -{
> -	driver_unregister(&tee_bnxt_fw_driver.driver);
> -}
> -
> -module_init(tee_bnxt_fw_mod_init);
> -module_exit(tee_bnxt_fw_mod_exit);
> +module_tee_client_driver(tee_bnxt_fw_driver);
> =20
>  MODULE_AUTHOR("Vikas Gupta <vikas.gupta@broadcom.com>");
>  MODULE_DESCRIPTION("Broadcom bnxt firmware manager");
> --=20
> 2.47.3
>=20
