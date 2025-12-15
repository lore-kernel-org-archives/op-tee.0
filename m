Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409E6D59D99
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:31:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8E31B4FE96
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765783894;
	bh=EeBFa9LxKotgGrdPqcbWVmlCxtFsMb4MgjjACwb02d0=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ec1rRIGNO/i5Cxrf6NOijkuj+7QWYkVn91nOZFUJo5nU+HEd5KTdz9o1KP6Sdtm9F
	 10Xt0tQgMsDoBG7RnsBpilSA8tORDz1iXsOVjfEFIGv50cy0HjsxUGy7tNaAi6olzO
	 odEgUTRXfzdGDvVxSiQso26jFTgvNWtksybYNU+uvSU6y3/c3xo3HoUW4H6KqfZsAR
	 +HfrBBHqt6zC6F23IMATQxCIcpwxV35Nnc4lxKgha3JXMx2s3Xaixwq7AdYofqTr0K
	 hYGWed09Kmyf2q/LbzgoPDyEMU5nepM7znZZ3g3FC6blx9ARr4Fb75DZ3xks3RZ+Ko
	 99i7BmsnErnDA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E58F74FECA
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:31:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZrA4UstO;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5EEAE60140;
	Mon, 15 Dec 2025 07:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B64C4CEF5;
	Mon, 15 Dec 2025 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765783860;
	bh=cqq1WygF8ip5+I3ALGpTWCHJxLIkscoD9iWmQBjY6nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrA4UstOic+82ZQ4QSHC9C0T1gI6cYX954HpmrwHKcD0bjXFaQ07vWKYx87oWaieZ
	 RygMFS8ccA2HDovmZSHXRxNsXf3CVsgXBaJdf/nbljauPpORCr9teJSXj9d78KMwC9
	 hX3hnGk0a5hQFzURbc0FWdxluJ8GOYjBK0IigLzJgOV5TwSAOoUGce12h/lCjpdwzF
	 kYBAM8040hIzCpZdlZVgmAFhqNVQRd8b3xeIvCX3deUBhU2YEmM9looCLG+qKm8X85
	 ywxgFZsHpxfQrXL9Z2W6T255EE10AptzXxi5eZWqgkfLMG9flkuypf0fpbjCh/wS8d
	 wCBwm21PClo1w==
Date: Mon, 15 Dec 2025 16:30:54 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 10/17] firmware: arm_scmi: optee: Make use of
 module_tee_client_driver()
Message-ID: <aT-5LtYnLSF_MwW4@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <537c48e3db243b5c68c3192179a948efb3a180c7.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <537c48e3db243b5c68c3192179a948efb3a180c7.1765472125.git.u.kleine-koenig@baylibre.com>
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
X-Rspamd-Queue-Id: E58F74FECA
X-Spamd-Bar: ---
Message-ID-Hash: LJWD4AOGKPPRU4BXZHUXKENFBXQOIHU2
X-Message-ID-Hash: LJWD4AOGKPPRU4BXZHUXKENFBXQOIHU2
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sudeep Holla <sudeep.holla@arm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Cristian Marussi <cristian.marussi@arm.com>, op-tee@lists.trustedfirmware.org, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LJWD4AOGKPPRU4BXZHUXKENFBXQOIHU2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:04PM +0100, Uwe Kleine-K=F6nig wrote:
> Reduce boilerplate by using the newly introduced module_tee_client_driver=
().
> That takes care of assigning the driver's bus, so the explicit assigning
> in this driver can be dropped.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/firmware/arm_scmi/transports/optee.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/drivers/firmware/arm_scmi/transports/optee.c b/drivers/firmw=
are/arm_scmi/transports/optee.c
> index dc0f46340153..8fdb80d3fabd 100644
> --- a/drivers/firmware/arm_scmi/transports/optee.c
> +++ b/drivers/firmware/arm_scmi/transports/optee.c
> @@ -612,23 +612,12 @@ static struct tee_client_driver scmi_optee_service_=
driver =3D {
>  	.id_table	=3D scmi_optee_service_id,
>  	.driver		=3D {
>  		.name =3D "scmi-optee",
> -		.bus =3D &tee_bus_type,
>  		.probe =3D scmi_optee_service_probe,
>  		.remove =3D scmi_optee_service_remove,
>  	},
>  };
> =20
> -static int __init scmi_transport_optee_init(void)
> -{
> -	return driver_register(&scmi_optee_service_driver.driver);
> -}
> -module_init(scmi_transport_optee_init);
> -
> -static void __exit scmi_transport_optee_exit(void)
> -{
> -	driver_unregister(&scmi_optee_service_driver.driver);
> -}
> -module_exit(scmi_transport_optee_exit);
> +module_tee_client_driver(scmi_optee_service_driver);
> =20
>  MODULE_AUTHOR("Etienne Carriere <etienne.carriere@foss.st.com>");
>  MODULE_DESCRIPTION("SCMI OPTEE Transport driver");
> --=20
> 2.47.3
>=20
