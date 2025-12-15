Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7483D59D99
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:55:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 374974FF25
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765785358;
	bh=tWXYSgMDhruZ7nVnbqBYxZNKy9SBrFNt8fI/oORN0qg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JtbglR9g5bKpxyyDbgR6Kr0zK5aPG9PUuqrZMe+jspTIzDYFkOiPqJAq1JLBCzJm+
	 Lc5Ba0Q4GPNeSZSUS5LeukaFsLCb95lU9R+A07DHcjdYq4HIz9ZoArggGPMQs0uR9G
	 wleB3cvvCM3riN5CkWBC7CGLEhJpm4l8UvsYGRt2epUlV/MZFOnyXrrt/z/wcycdM7
	 170eGvJik+N/BMK6h/d26b2B8mIYcTRkw3TGXYQUaDGxdrQo2gN/6f3SvaVxVJQRR6
	 V7ai7PCeAfpjKxE3+PHYAwlQq2TSDS0CBZIvnGysj4eH5E0HcxqiCUmFyfJEUtvf+n
	 MUP/JXfsoNlcA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9CA824FF1F
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:55:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nqsTVgQ8;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5574360129;
	Mon, 15 Dec 2025 07:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC736C4CEF5;
	Mon, 15 Dec 2025 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765785326;
	bh=2qJr895ogd7LPk/YsFAb/JfvV6B7y4KUOhDxybT1U8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqsTVgQ85nB3TC8WJu8my6yqsPEwgqdKMCHvbMV9Kk9vZi/KtU34Vp9mDYZkIkGvS
	 Rdv6SZ2PGO5hUg31hQqFiZC/huPk/HA0qATQzmYkwMQtpaYjN+4T9amD49GWE5OTJu
	 TXoehSJh6ITWFZt9u5OxLmWBwMA/F0j6FVpaB8S2Y49wXHS9cMi5fPtyXLwr3GxNGb
	 OGV2YoE22969pwGcn4fcSsxyzrpMTOFqil6WPhBRXBDoPKCsD/eGYt2vQg+B7xmiwv
	 3jKkeDKGQB2NhEQIhKXRSDf+rtgAke3aFRxjbovJXfcxMrj+70Iq8wHl5KE7H9xNQx
	 0S+Zv6QQWugIw==
Date: Mon, 15 Dec 2025 16:55:19 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 08/17] efi: stmm: Make use of
 module_tee_client_driver()
Message-ID: <aT--5-bIY8S2PiZa@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <0896270bc530d1e3b7fbcf5f7e168172dcc05d1e.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0896270bc530d1e3b7fbcf5f7e168172dcc05d1e.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,gmail.com,foss.st.com,oss.qualcomm.com,siemens.com,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9CA824FF1F
X-Spamd-Bar: ---
Message-ID-Hash: TKYMCSZ7QKCVGIBWVHD4VMW5T3YF6J6M
X-Message-ID-Hash: TKYMCSZ7QKCVGIBWVHD4VMW5T3YF6J6M
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, op-tee@lists.trustedfirmware.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TKYMCSZ7QKCVGIBWVHD4VMW5T3YF6J6M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:02PM +0100, Uwe Kleine-K=F6nig wrote:
> Reduce boilerplate by using the newly introduced module_tee_client_driver=
().
> That takes care of assigning the driver's bus, so the explicit assigning
> in this driver can be dropped.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/=
efi/stmm/tee_stmm_efi.c
> index 65c0fe1ba275..5903811858b6 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -584,24 +584,12 @@ static struct tee_client_driver tee_stmm_efi_driver=
 =3D {
>  	.id_table	=3D tee_stmm_efi_id_table,
>  	.driver		=3D {
>  		.name		=3D "tee-stmm-efi",
> -		.bus		=3D &tee_bus_type,
>  		.probe		=3D tee_stmm_efi_probe,
>  		.remove		=3D tee_stmm_efi_remove,
>  	},
>  };
> =20
> -static int __init tee_stmm_efi_mod_init(void)
> -{
> -	return driver_register(&tee_stmm_efi_driver.driver);
> -}
> -
> -static void __exit tee_stmm_efi_mod_exit(void)
> -{
> -	driver_unregister(&tee_stmm_efi_driver.driver);
> -}
> -
> -module_init(tee_stmm_efi_mod_init);
> -module_exit(tee_stmm_efi_mod_exit);
> +module_tee_client_driver(tee_stmm_efi_driver);
> =20
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> --=20
> 2.47.3
>=20
>=20
