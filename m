Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCB606A325
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=rj2JSK1x;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKsKwoar
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1951445521
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795012396;
	bh=LDae4vLnFMmqtddrZ03YbDCknSAq0KDjq5i+PySQBUQ=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rj2JSK1xgJtWOONct8xE6KxJxi2NOUPUZ2yuIFwnpacxdNlrAQhAVWI5Zmy9m5UVb
	 LkdaM2ZRgLPwg2aUkK5x18ch8LvEIuzZ90/tpEanJkBDzmFr1O7IV/5u6cEyOmQggq
	 cwio3DnKL++CR/Yy9sJ5TPVF8zg7GY7OclwVrrUob94Mmlm5YtFSZFmvtZyl4J0KMp
	 4ZueqqTf9YdQ4Z+qwve3J0NHp5dNjFXX38EPs4jKtmDtHtK3t21Mtcs3h6hlq+JXDk
	 DGezOQDrmvSWOfh01sTPIe5JTz1QzBDcIbXBMQgR5Mj53VBgP3YXkuOXU91QKmUhpt
	 CdW+3QhwGxmcA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F193845416
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 14:33:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKsKwoar;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3ABFC44F4F;
	Wed, 18 Nov 2026 14:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00781F000C6;
	Wed, 18 Nov 2026 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012390;
	bh=UbKKKwuSqmqLTt5+7BE++XpAc29t2C2cKUALxdXI6xc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKsKwoar7e0Ra6XiwKT/7z8u6kEiledf3bbg3prwX+2CfHTPA8N88AVHSkgadsRZk
	 hEoeym3oodfOUSlx1z5W75iZ+EGi+35iK5jA7UzVK6CsT7ZsSnduqmqvCPCSgPqAG3
	 41e6gDciB8zkAAkIM2YaJ+Ym/f6udYcdpYnS940I3GWzK4uuYa+PpPa3y/k59gNkKf
	 4TLJhzKow5l/8qYR3UU+hplToQZNGAOns5IjU0MCnXO82m5hQm6TTy26FEqmAH8MOV
	 1dbRNOsI7HLzIeVKpr82dKHZqJ8h3RT2AoPq7CKk5Gpmm63ubnxGacXHAN0nMuIoOy
	 toD0PUObwlYVQ==
Message-ID: <sashiko-outbox-221217@kernel.org>
Subject: Re: [RFC PATCH 3/9] KEYS: keycrypt: Add the OP-TEE backend
To: "Rodolfo Giometti" <giometti@enneenne.com>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, keyrings@vger.kernel.org
In-Reply-To: <20261118140421.584086-4-giometti@enneenne.com>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118140421.584086-4-giometti@enneenne.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:33:08 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	MISSING_MIME_VERSION(2.00)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,lists.trustedfirmware.org,nxp.com,pengutronix.de,nod.at,gmail.com,arndb.de,paul-moore.com,namei.org,hallyn.com,lwn.net,linuxfoundation.org,infradead.org,vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from,100.103.45.18:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F193845416
X-Spamd-Bar: -----
Message-ID-Hash: BOXVWMAAEJFGVFCMYX757A37QYXCWLDJ
X-Message-ID-Hash: BOXVWMAAEJFGVFCMYX757A37QYXCWLDJ
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, =?utf-8?b?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Richard Weinberger <richard@nod.at>, =?utf-8?b?Q2hyaXN0b3BoZSBMZXJveSAoQ1MgR1JP?= =?utf-8?b?VVAp?= <chleroy@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Demi Marie Obenour <demiobenour@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BOXVWMAAEJFGVFCMYX757A37QYXCWLDJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: sashiko-bot--- via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] keys: keycrypt: NULL dereference in kc_optee_remove() after
  shutdown
--

commit 8da0e0d8cf01260109b52bb935a051203beb3758
Author: Rodolfo Giometti <giometti@enneenne.com>

KEYS: keycrypt: Add the OP-TEE backend

This commit adds the "optee" keycrypt backend driver for the tee tier,
using sessions to the keycrypt OP-TEE Trusted Application to seal, load,
and run operations on keys.

> diff --git a/security/keys/keycrypt/optee.c b/security/keys/keycrypt/opte=
e.c
> new file mode 100644
> index 0000000000000..5a3ab6f825f17
> --- /dev/null
> +++ b/security/keys/keycrypt/optee.c

[ ... ]

> +static void kc_optee_remove(struct tee_client_device *tdev)
> +{
> +	keycrypt_unregister_backend(&keycrypt_optee);
> +	tee_client_close_session(kc_optee.tee, kc_optee.ctl);
> +	tee_shm_free(kc_optee.ctl_shm);
> +	tee_client_close_context(kc_optee.tee);
> +	kc_optee.tee =3D NULL;
> +}
> +
> +static const struct tee_client_device_id kc_optee_id_table[] =3D {
> +	{ UUID_INIT(0x65a0d9f0, 0xf057, 0x414c,
> +		    0x9d, 0x5a, 0x9a, 0xac, 0x7c, 0x8b, 0xa4, 0x61) },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, kc_optee_id_table);
> +
> +static struct tee_client_driver kc_optee_driver =3D {
> +	.probe		=3D kc_optee_probe,
> +	.remove		=3D kc_optee_remove,
> +	/* Sessions left open would outlive a kexec in the secure world */
> +	.shutdown	=3D kc_optee_remove,

[Severity: High]
Can kc_optee_remove() run a second time when .remove is called after
.shutdown?

device_shutdown() invokes .shutdown without unbinding the driver.  On
Arm FF-A OP-TEE platforms, device_shutdown() first calls
tee_client_device_shutdown() -> kc_optee_remove() on the TA child device,
setting kc_optee.tee to NULL, and then reaches the parent FF-A device
whose .shutdown callback (ffa_remove() -> ... ->
optee_unregister_devices()) unregisters the TA device and calls
tee_client_device_remove() -> kc_optee_remove() again.

The second call hits WARN_ON_ONCE(!h) in keycrypt_unregister_backend(),
dereferences NULL kc_optee.tee in tee_client_close_session() and
tee_client_close_context(), and double frees kc_optee.ctl_shm.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118140421.5840=
86-1-giometti@enneenne.com?part=3D3
