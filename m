Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824CBD59D99
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:56:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CB3404FF25
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765785396;
	bh=nP4QsbHhT9sosSDMZ1m504dA69co9Zj6v6z11MSSugI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=UUZp/Bx7zN2wTyIkiz0bK/Pa0QbMWJDvvuJBQyF0l54R9KpfXmgcHajSLGUVW9Z+P
	 lrT6w3bdqJ2gdKJMmvb37IFYePbVvLyvTlxr6gZO0tJi/CAwZw2gIRvkE7EFlbPUir
	 mOyAaVoBC8nO343ERjUnYA4XUvXac2yEMOiEMKb7kNBtH+JXmJbmpyx1TUBdLK0Lvs
	 2PF0U20T4eNs85SSd5iHmmFuSMkpCOusH+xdgLV40R1yodPag2bIQn6828B9skOpdE
	 emGgYAOpWRRv9zFYdZOLSob1fBcInEK7LyI4TG2+9fUro4KRpDNx+iFjKOpovPPbCC
	 kvd+HUsLYKWqA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DBD164FF49
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:56:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=deQNvTra;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3EE2A4165B;
	Mon, 15 Dec 2025 07:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F90C4CEF5;
	Mon, 15 Dec 2025 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765785365;
	bh=MlLssv01cYup7HpjM3F8nb2QRsjJ2hpns8lGvv96LxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=deQNvTratwzTgo1nYpirqW+raG211ew5e5OBLf6eOcDnhuHXPD80+udhz+WDYVaD3
	 uPznMJOefvjSB0YpIX+U8ByiU0aTknd/jqseZKkoy5F9ZGRSR7tkGy+y6ykzzT8FL5
	 Y4mxOuEDOvg3ynqQGStVdFuzjvpCqNoWba/+xKiVE95RKHeBLlyRb3rHQwBjo5AZE9
	 Hu73u4pMijggb8SRcIj2w963f5s6bs1PoPnE7c3IH/AeWyTj6b/anVxbt/NS5xX/7V
	 iMM/XK0ynNtSqkNQoN+JRyUCgOv2LvzBGKeJ3otrWuy2CAjgb17cgQpWXcytkZKIRa
	 k00BOxcaaco7g==
Date: Mon, 15 Dec 2025 16:55:57 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 09/17] efi: stmm: Make use of tee bus methods
Message-ID: <aT-_DbMYPN0p2CrK@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <9e3d9ab0f7987f313237b51911865f0cccae8eb5.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9e3d9ab0f7987f313237b51911865f0cccae8eb5.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: DBD164FF49
X-Spamd-Bar: ----
Message-ID-Hash: J26CTHDB3FCQBLYYL43NQPZNNQM3IJRZ
X-Message-ID-Hash: J26CTHDB3FCQBLYYL43NQPZNNQM3IJRZ
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, op-tee@lists.trustedfirmware.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/J26CTHDB3FCQBLYYL43NQPZNNQM3IJRZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:03PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/=
efi/stmm/tee_stmm_efi.c
> index 5903811858b6..7b04dd649629 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -520,8 +520,9 @@ static void tee_stmm_restore_efivars_generic_ops(void)
>  	efivars_generic_ops_register();
>  }
> =20
> -static int tee_stmm_efi_probe(struct device *dev)
> +static int tee_stmm_efi_probe(struct tee_client_device *tee_dev)
>  {
> +	struct device *dev =3D &tee_dev->dev;
>  	struct tee_ioctl_open_session_arg sess_arg;
>  	efi_status_t ret;
>  	int rc;
> @@ -571,21 +572,19 @@ static int tee_stmm_efi_probe(struct device *dev)
>  	return 0;
>  }
> =20
> -static int tee_stmm_efi_remove(struct device *dev)
> +static void tee_stmm_efi_remove(struct tee_client_device *dev)
>  {
>  	tee_stmm_restore_efivars_generic_ops();
> -
> -	return 0;
>  }
> =20
>  MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
> =20
>  static struct tee_client_driver tee_stmm_efi_driver =3D {
>  	.id_table	=3D tee_stmm_efi_id_table,
> +	.probe		=3D tee_stmm_efi_probe,
> +	.remove		=3D tee_stmm_efi_remove,
>  	.driver		=3D {
>  		.name		=3D "tee-stmm-efi",
> -		.probe		=3D tee_stmm_efi_probe,
> -		.remove		=3D tee_stmm_efi_remove,
>  	},
>  };
> =20
> --=20
> 2.47.3
>=20
>=20
