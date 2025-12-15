Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78C3D5B86F
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 11DB14FE9B
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765836281;
	bh=qO4oz8p3JIt3/Y/ERP26+SMlJT7RcIU4AK2eFXSmXiQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mIzQ+6+r4cc7vGWeJm12Z444lKBbcYNhh7lknbfqKnmxQb6JGnhwVeHSMjiAp5clz
	 sguL+N/PUECUzDNI+9fihT1lJT0JnWFlY2Cgi0ixtLcvRynAOoH2rpdn3aWinDT7gJ
	 w50dtLfu/9KiivOLDc/ibHP1a4O61+5IAhTp0pNx3IUxdpr7G5Kg6R5j1UmEELHM5k
	 iT9RKgExtXEfHsR8DP99DtymxGzrZFVe03jweo1U77tdBOX2FlymMheZ6zQ15jaohg
	 G1/6re0sjgxeKgH41poPUPMALTOcn/tV5o4Wgwi4B5r4PrMeQj622/8BNWVx6k+pUU
	 QnHlLJRFRcijg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 79A2E4FE12
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 22:04:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SUKm5xfU;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DEB3460053;
	Mon, 15 Dec 2025 22:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAC0C4CEF5;
	Mon, 15 Dec 2025 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765836262;
	bh=vGjzAFwNR6AwMM6AHlInRy9NxfEhAAxRUMwgbnwUrRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUKm5xfUsV5V4rQCL33sfiBzcllYGtrINx8fdzN1II6y8s9L8bFrS/WjreGUe2mF3
	 LTRi7dAJIUKT4ezPv2jS8o4tQDUG0Dnk/8ObVQnvpo6dy3kLKpyn+DrYuPyHa3tbXO
	 0zkUeWtgS0WQH8a4oFMLXnff6NTWFbcaI+9Bely9b/wYt+ANdxw+y11zrakHvYrs9M
	 fTJQb2OHTokhmcpxPMagNeHIEBIzuZ++htRPAIpnFObryhskdWwadJExa02VBVM0L/
	 beaDosIYe76m6M4vdTs8wxC4bSLA+ZVEv4LMM8VoRb3AdlhWbXMg2jJLnOUdS6mJ4P
	 addsMDYiks5Fg==
Date: Tue, 16 Dec 2025 00:04:18 +0200
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 15/17] KEYS: trusted: Make use of tee bus methods
Message-ID: <aUCF4hW5xkvpv9lt@kernel.org>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <ad8aaa343c1e8523659259290f63aea8be906977.1765791463.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ad8aaa343c1e8523659259290f63aea8be906977.1765791463.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 79A2E4FE12
X-Spamd-Bar: ----
Message-ID-Hash: XH73OQDOLONIY4QR2G7Y3LOQI7CZ63WE
X-Message-ID-Hash: XH73OQDOLONIY4QR2G7Y3LOQI7CZ63WE
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XH73OQDOLONIY4QR2G7Y3LOQI7CZ63WE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Mon, Dec 15, 2025 at 03:16:45PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>=20
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
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

I'm sorry but cannot help saying but these not being in reverse tree
order hurts my eyes ;-)

I.e., I'd personally move declaration of sess_arg right after rng_device
despite being additional change to the scope of the patch.

That said, Sumit has the ultimate veto right here, and this not any kind
of fault in this patch so I will obviously ack the patch;

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


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

BR, Jarkko
