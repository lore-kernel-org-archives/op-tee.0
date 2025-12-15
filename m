Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9850CD59D99
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:35:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E55614FF1F
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765784118;
	bh=cYCiu0imrD2CvDK/A947Dr692tcTAwbCYTNODNkDCDQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=liWdfDrxvQM2OPPMVUw/lIxCHP7ePdmOVfuwsB15wP0h7fpAt0ysJdSK+L6Nw+WLB
	 BIu2m2mszk/j+1VA+XDErIqACkn+VuX2fuMMOditMpGBkI4STkxjxnN/nXgrXoExNS
	 VDXHuniL8h+p7MQS1gMx/87RNLPHPxS7a4yyzAsc+CcZVVkpD12QR1gBrr6BT9zdMB
	 BSUwi/pn6PrmEi+RVY7qxoWRnj7fOwtdqdV9H3GWwVG6mx5woSEiw18SruoQ/teABw
	 +Y2kPE90kP+L0B8qe3XpYyE0xUPI1at38lrVf31gR6O4bNUNk8382m2FQKw9jd96QB
	 fjCwdj14wQjNA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E23044FECE
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:34:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mWu4QSRe;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5D84D60127;
	Mon, 15 Dec 2025 07:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3B1C116B1;
	Mon, 15 Dec 2025 07:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765784083;
	bh=MiHBA0Fjs39oJZsLunvPoV7wu3p/ufM0CWOh6Ua3eNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWu4QSReA7/21kROu7snleZys0FL/fADcMJTYazobHY4EbQ2Qw2f6h+b755e4I0i7
	 bnRee12hv1iJUspSw+0J/nTby197CFFgzJpwUv4i261oSadu0Ih20pDD6pYrTD59Hf
	 ltw2if3QFcqm41srxhL+TuT/4R9/4XIH70Jm5p3WWJfIvVX1uKL09Rk51PCzy0xDHZ
	 MzRTnOqK/uadzI3T297337WKalt6eeYNgTnQHcU8whfTPIfC4ySnUTVvZ6AdsvhwT/
	 M4o4PnSAiuYE9QzaItYdQwev+FPUHgEO0uGxOseJDV5ZNgR5oJj8Vzasc5XIjFbY8Z
	 uJzbre/hCy/1A==
Date: Mon, 15 Dec 2025 16:34:37 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 13/17] firmware: tee_bnxt: Make use of tee bus methods
Message-ID: <aT-6DVAIS2sK6pxZ@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <f0b513d92355a53d30d8fdfcbbf7250457ec470e.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f0b513d92355a53d30d8fdfcbbf7250457ec470e.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,broadcom.com,gmail.com,lists.trustedfirmware.org,vger.kernel.org];
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
X-Rspamd-Queue-Id: E23044FECE
X-Spamd-Bar: ---
Message-ID-Hash: ZE5VALFVHUNHSMMWAOIJ5YNZIRF3NWVI
X-Message-ID-Hash: ZE5VALFVHUNHSMMWAOIJ5YNZIRF3NWVI
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZE5VALFVHUNHSMMWAOIJ5YNZIRF3NWVI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:07PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/firmware/broadcom/tee_bnxt_fw.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/b=
roadcom/tee_bnxt_fw.c
> index fbdf1aa97c82..a706c84eb2b6 100644
> --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> @@ -181,9 +181,9 @@ static int optee_ctx_match(struct tee_ioctl_version_d=
ata *ver, const void *data)
>  	return (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE);
>  }
> =20
> -static int tee_bnxt_fw_probe(struct device *dev)
> +static int tee_bnxt_fw_probe(struct tee_client_device *bnxt_device)
>  {
> -	struct tee_client_device *bnxt_device =3D to_tee_client_device(dev);
> +	struct device *dev =3D &bnxt_device->dev;
>  	int ret, err =3D -ENODEV;
>  	struct tee_ioctl_open_session_arg sess_arg;
>  	struct tee_shm *fw_shm_pool;
> @@ -231,17 +231,15 @@ static int tee_bnxt_fw_probe(struct device *dev)
>  	return err;
>  }
> =20
> -static int tee_bnxt_fw_remove(struct device *dev)
> +static void tee_bnxt_fw_remove(struct tee_client_device *bnxt_device)
>  {
>  	tee_shm_free(pvt_data.fw_shm_pool);
>  	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
>  	tee_client_close_context(pvt_data.ctx);
>  	pvt_data.ctx =3D NULL;
> -
> -	return 0;
>  }
> =20
> -static void tee_bnxt_fw_shutdown(struct device *dev)
> +static void tee_bnxt_fw_shutdown(struct tee_client_device *bnxt_device)
>  {
>  	tee_shm_free(pvt_data.fw_shm_pool);
>  	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
> @@ -258,12 +256,12 @@ static const struct tee_client_device_id tee_bnxt_f=
w_id_table[] =3D {
>  MODULE_DEVICE_TABLE(tee, tee_bnxt_fw_id_table);
> =20
>  static struct tee_client_driver tee_bnxt_fw_driver =3D {
> +	.probe		=3D tee_bnxt_fw_probe,
> +	.remove		=3D tee_bnxt_fw_remove,
> +	.shutdown	=3D tee_bnxt_fw_shutdown,
>  	.id_table	=3D tee_bnxt_fw_id_table,
>  	.driver		=3D {
>  		.name		=3D KBUILD_MODNAME,
> -		.probe		=3D tee_bnxt_fw_probe,
> -		.remove		=3D tee_bnxt_fw_remove,
> -		.shutdown	=3D tee_bnxt_fw_shutdown,
>  	},
>  };
> =20
> --=20
> 2.47.3
>=20
