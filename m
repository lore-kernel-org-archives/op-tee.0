Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB99D41D74
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:24:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 40FB74FE8C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765783493;
	bh=9szjL1u7GS1XgSF/nNAMKd7NOQjGbsueSlM0t6xUnL8=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2j052u399Kg5JlBlRp3RrooGkNlqdiW/wMkfMh5cDA48c3Pbzfgnk2zSB+JTKbxoQ
	 3BxRQfnA7RDM/+me0qIW+BRn5CVULOuy5+GEZVcahkGbX97WTRQw5x6YlvJX1MIfJZ
	 Nt3ZvivdFP2kUiLh2UiQd+QCbOuWNtvPMJR5mjTP8lYv5+PJBRHyR9Cz8nrYiAdDjU
	 JcxmgsHYF8WU4YdyPkQfLIRU0tkXOXmuQHFUsa+TRnjkCYyxonzQ4ZjlPCUcbzxUBW
	 IPILDixY3nEm2xu7mhJRw/UKEGEW01leFLl9mcZ+SDnoFJUJ6CgO2o4Bv+CZ0WtbG7
	 DhUb+uI/mvu+g==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 26CD44320D
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:24:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bye+8z1e;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 76B5A40B54;
	Mon, 15 Dec 2025 07:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B96C4CEF5;
	Mon, 15 Dec 2025 07:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765783459;
	bh=IohxA+HbB0DZaupV93o9uo3GzrNHJa4aB8aDCmZCDOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bye+8z1eHTkzYZQU6jFjQ8eDkgIoA3cvOX8lxLUOzrPc6Wqx0xUSs2sIdKyx7vjhZ
	 pUeG+BTsREnAEaknjYineD3QdsuMKWJ4aEu/5L1ccOUomgovcPZH6p9k+EEs4QaJaj
	 K0fI2+FI09vVGiU8ml9JcuS3+743iAte/bt7XKO8MTZ/lAt6/uKrgY0CfTFjbQdUDE
	 qo5AldCdmczWweRvyR2PYGYSWKbd5G83yklh9wvGkdHlw8O0BAY9PO+XYZz+Y52TfW
	 iUM1wzG8jGI1rMIwIo0IBlt8iE58GeCRWoqZ9JW9hog2UuOebGyIoqjbKknQQuqpqA
	 EQy7FHwfCbncg==
Date: Mon, 15 Dec 2025 16:24:14 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 03/17] tee: Adapt documentation to cover recent
 additions
Message-ID: <aT-3ngz0md7wOJhC@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <cce3ff1b96641295a669fe9805a7435c7ae0b89f.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cce3ff1b96641295a669fe9805a7435c7ae0b89f.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 26CD44320D
X-Spamd-Bar: -----
Message-ID-Hash: BGO6KI4N4ZCLZNNSMQR2ZTE2OYPT52BR
X-Message-ID-Hash: BGO6KI4N4ZCLZNNSMQR2ZTE2OYPT52BR
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BGO6KI4N4ZCLZNNSMQR2ZTE2OYPT52BR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:14:57PM +0100, Uwe Kleine-K=F6nig wrote:
> The previous commits introduced some helpers to reduce boilerplate
> and bus specific callbacks for probe and remove.
>=20
> Adapt the reference example to make use of these.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  Documentation/driver-api/tee.rst | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/Documentation/driver-api/tee.rst b/Documentation/driver-api/=
tee.rst
> index 5eaeb8103988..4d58ac0712c1 100644
> --- a/Documentation/driver-api/tee.rst
> +++ b/Documentation/driver-api/tee.rst
> @@ -43,24 +43,12 @@ snippet would look like::
>  	MODULE_DEVICE_TABLE(tee, client_id_table);
> =20
>  	static struct tee_client_driver client_driver =3D {
> +		.probe		=3D client_probe,
> +		.remove		=3D client_remove,
>  		.id_table	=3D client_id_table,
>  		.driver		=3D {
>  			.name		=3D DRIVER_NAME,
> -			.bus		=3D &tee_bus_type,
> -			.probe		=3D client_probe,
> -			.remove		=3D client_remove,
>  		},
>  	};
> =20
> -	static int __init client_init(void)
> -	{
> -		return driver_register(&client_driver.driver);
> -	}
> -
> -	static void __exit client_exit(void)
> -	{
> -		driver_unregister(&client_driver.driver);
> -	}
> -
> -	module_init(client_init);
> -	module_exit(client_exit);
> +	module_tee_client_driver(client_driver);
> --=20
> 2.47.3
>=20
