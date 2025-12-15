Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D409FD41D74
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:38:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 32DB64FF2A
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 07:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765784287;
	bh=URdC5ZDeyxpsIUac82AzsdW0oRji/0Vjiq8nRpYqLzk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tlwZQG4Hci2FCOo2JtrGKlWTO/Um3dE1QbJPGCxWSxAt4tgQiOSKa+xVdr0yM8K5F
	 D0eXSgJShEmfb2qfDwctF4rHGGU+mez8gIFE0ZhOWaOzOVnL6PcCM6bidy2osgzMop
	 xHvrunbmfcxh1b38gmeEJTRr5MCq3kCP/lX7F+zx15IKQKPHlGdgshDR9SiDwWIipd
	 LQ7nAp4sYAa6RzUbJBotjBkCyL7S1WGTGXBiMrvXnQJup6bug0vhqnhuRVPpixC45E
	 5irsjpczhdPKXkffLekWA6VeSJHfCOEbvr8rRhlM63PYc8PzeP13PlKUSopzmBSA2z
	 P6rB09Vm+GRKg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A3F374FECD
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 07:36:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WgHD24/X;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4346460127;
	Mon, 15 Dec 2025 07:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857EBC4CEF5;
	Mon, 15 Dec 2025 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765784214;
	bh=2OORDja30gMmDgyUzWDMnzZHy7weS+LKrcxmBaHXsyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgHD24/X7wV/312UORX7oPByYndRHEuIcpls3eBGVVuiAKyuZWDBzXNzHyULu2Uqs
	 UJnvdrDkliHw1yJiyUEtsufuGp8afT1ayToFgM1So+/ihBws8tgadsKcRgVXsX5EAR
	 Xrx2037bgdCEmkOGeiv7uqe7VVfUzU3oqbSaVLKMF8hdv3tFxkv4HI/geTeeGOG63X
	 giudcdejoZ1sNxi6PeOggbNSHRsmrQ+zWdGMMpGQNJrSgl5CdWz3dmFW8KQo7BLAdX
	 mnuyplfoCOOi4nO0IEyHPamRjTZqUeP2KQhzCTq2AEok96vLhvHFn7G27+Dm8bgA78
	 OmUZl3pnRLa/A==
Date: Mon, 15 Dec 2025 16:36:46 +0900
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 15/17] KEYS: trusted: Make use of tee bus methods
Message-ID: <aT-6jibmsCK6BPhP@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <aab4c00b7e89abce7bcd8241c47f3398fb7227f8.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aab4c00b7e89abce7bcd8241c47f3398fb7227f8.1765472125.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.105.4.254:from];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A3F374FECD
X-Spamd-Bar: ---
Message-ID-Hash: WKF3H43SM3OIFZ6RWHWNSD7CMCNNOBKD
X-Message-ID-Hash: WKF3H43SM3OIFZ6RWHWNSD7CMCNNOBKD
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WKF3H43SM3OIFZ6RWHWNSD7CMCNNOBKD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Dec 11, 2025 at 06:15:09PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>=20
> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/tru=
sted-keys/trusted_tee.c
> index 3cea9a377955..6e465c8bef5e 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -202,9 +202,9 @@ static int optee_ctx_match(struct tee_ioctl_version_d=
ata *ver, const void *data)
>  		return 0;
>  }
> =20
> -static int trusted_key_probe(struct device *dev)
> +static int trusted_key_probe(struct tee_client_device *rng_device)
>  {
> -	struct tee_client_device *rng_device =3D to_tee_client_device(dev);
> +	struct device *dev =3D &rng_device->dev;
>  	int ret;
>  	struct tee_ioctl_open_session_arg sess_arg;
> =20
> @@ -244,13 +244,11 @@ static int trusted_key_probe(struct device *dev)
>  	return ret;
>  }
> =20
> -static int trusted_key_remove(struct device *dev)
> +static void trusted_key_remove(struct tee_client_device *dev)
>  {
>  	unregister_key_type(&key_type_trusted);
>  	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
>  	tee_client_close_context(pvt_data.ctx);
> -
> -	return 0;
>  }
> =20
>  static const struct tee_client_device_id trusted_key_id_table[] =3D {
> @@ -261,11 +259,11 @@ static const struct tee_client_device_id trusted_ke=
y_id_table[] =3D {
>  MODULE_DEVICE_TABLE(tee, trusted_key_id_table);
> =20
>  static struct tee_client_driver trusted_key_driver =3D {
> +	.probe		=3D trusted_key_probe,
> +	.remove		=3D trusted_key_remove,
>  	.id_table	=3D trusted_key_id_table,
>  	.driver		=3D {
>  		.name		=3D DRIVER_NAME,
> -		.probe		=3D trusted_key_probe,
> -		.remove		=3D trusted_key_remove,
>  	},
>  };
> =20
> --=20
> 2.47.3
>=20
