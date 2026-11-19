Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED571606A320
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fi5v7G0o
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4E91950353
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 07:40:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fi5v7G0o;
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 08A2643A65
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 00:43:47 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67db0791748so1936906d50.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 16:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049026; x=1795653826; darn=lists.trustedfirmware.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fgA8o0FbMXPNXu1ndyU//XOwV/J+NqWrJ7q89CkWjTg=;
        b=Fi5v7G0ogt58c8biNMAhFPHsJdwIz1MsQic7HQlRfWq1eguXhEnkkr8G/sjt/z/kxN
         I15ZdER+V0NOC+Un1JNHfZe1LlvJr0LKzXtLU7A12tYtwQOx/3q7kKhfNie5GldD6jZX
         bo8HllhGXF8pEhRRn2w32SEmyI5idFpOZfJyD+zannqmqFpzwMEG+DSiKJKr84T9u6P/
         rpJZ8s/cXhiLR/jdM2o2pxpyiHt8TEd1YHKDvEcqhXNCwr+wB0K187LrVunX/9rK5zOR
         ZbNXg7pPaRjnPktlXVUrY2JAbzpRRMLfJK3R4Xgfz5TMuuQLbZkJGNDeUs6eNlLOhxoG
         JnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049026; x=1795653826;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgA8o0FbMXPNXu1ndyU//XOwV/J+NqWrJ7q89CkWjTg=;
        b=fvKA3gi7mNV+FYPm2C661iJ3IkpGCWwt1JeXpO6thwW7vfusBzEKUb89uV9BT59+tv
         3qh34oDaLa8A4rXLbkSBWQMw+itlZEYWK5CVZENSi2siCgt20fbccmb2uKWXKvcyvvcH
         be9n8LmI1+7DynLECI/wZnoB4SO+oLEiOOAzUs2nGdV9QzvrMxe++E/ZbyDc3xRGVvy6
         EJEpJIMqC0/B7t+/CCSai4y8RmbyVKNutz7WkwPqFoE5hj7HV4xahYZCQEfYQY+UeiNX
         JYn1+Gv3PjYIIs4JNAT5ZqmeaqnbOVo300XKEh6rdyP7ItighnxO5f2gokRVEoegNT3W
         zsWQ==
X-Forwarded-Encrypted: i=1; AL+hErHDSJ9oGMZFHiRgOxVQZgwfFVM9B3IEoNRSa1TSYK5HxdrcD3wwSGvwClX+MGTNucnDfalr7zM=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+000Wuq88KpimydFn1L3Zl2jzN7ucZVbIHNZCHlWfhwAAJP/bc
	rfqTopk2UhfC+PtpmPlx7MOoEuHcylaLS2wJXHhbpfQeDdC9LlpTttQy
X-Gm-Gg: AZFdTZeF4b9H+ur5/krhbpspwgzITCri2KYb/AOtu+parAEFgdZ41Or8XrG7xjr1rPM
	PW5+DKdfsyMFg7MrIHjyRyy2UZyEnVCrLd33hwfuCUqC9Km6F3fJxnTyqBdAjom7NLFHuQTqwlo
	UNwpxrq99VsiiHQyWIe2AJqOfc9qeE+RDef+BwIwmGVdF+WyTMEaLS94ySsH13VuPgaATixWL9N
	nf7mXgteHRaiRGvJM1ePd0Mxn4cZeU8Zns54D5MQiQlWUlN03PVg0/SfY3ikO8kPAp1nWBgDMJ1
	Gews/ANR6ApgXz+QCJo1wPbjQ/IAs3Ojf+UxO9/1lbwMqcswQT2LdcUDg61Q/AdhR6/hT9bdVcF
	jUUDqePnqOn+8rksfB0XwdOZYEgkxqEI14NOU+VNYrOUFWu7cOcjdT/EHNIOhj+bi3nBM2laslq
	DK4fL7sOgHdne2ZZnGS9YIdgi4tBQj1U+x8By9M6c0rdU2RKBZId/BQu17GN+7qAyAJWGAxBwDh
	RTOCLn8PVZ4x4qHze7i1hcdmihcq55pouRcEEztY8TAYpB47reLatL7qksCp3jkZJc3e5ad3QBz
	XhLKlNJfXpvTAg2B8jnWKTniHC3YYStRngs=
X-Received: by 2002:a53:d018:0:b0:67d:affd:e015 with SMTP id 956f58d0204a3-67dd3f19e9dmr1827544d50.37.1795049026165;
        Wed, 18 Nov 2026 16:43:46 -0800 (PST)
Received: from [10.138.10.6] ([149.102.242.31])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd58a1478sm2511941d50.14.2026.11.18.16.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 16:43:45 -0800 (PST)
Message-ID: <61ca7c37-7b42-48a3-be2e-95deb4d999a2@gmail.com>
Date: Wed, 18 Nov 2026 19:43:37 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
To: Jarkko Sakkinen <jarkko@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <av5EyVHnNzT27dyK@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0bx6vSKCAV0Mo03JVw607zhR"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:74.125.0.0/16];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20260707];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.224.48:from];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.224.48:from];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 08A2643A65
X-Spamd-Bar: ------
X-MailFrom: demiobenour@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: KSY4ATCLYW27FXJL6WDQJFSPHIE5YV5V
X-Message-ID-Hash: KSY4ATCLYW27FXJL6WDQJFSPHIE5YV5V
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:39:02 +0000
CC: Rodolfo Giometti <giometti@enneenne.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Richard Weinberger <richard@nod.at>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, linux-
 arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KSY4ATCLYW27FXJL6WDQJFSPHIE5YV5V/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0bx6vSKCAV0Mo03JVw607zhR
Content-Type: multipart/mixed; boundary="------------B160UtrZAU3kNrK8qGCCzylk";
 protected-headers="v1"; hp="clear"
Message-ID: <61ca7c37-7b42-48a3-be2e-95deb4d999a2@gmail.com>
Date: Wed, 18 Nov 2026 19:43:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
 David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Sahil Malhotra
 <sahil.malhotra@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Richard Weinberger <richard@nod.at>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-crypto@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261118140421.584086-1-giometti@enneenne.com>
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <av5EyVHnNzT27dyK@kernel.org>

--------------B160UtrZAU3kNrK8qGCCzylk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/18/26 7:37 PM, Jarkko Sakkinen wrote:
> On Wed, Nov 18, 2026 at 06:42:15PM -0500, Demi Marie Obenour wrote:
>> On 11/18/26 9:04 AM, Rodolfo Giometti wrote:
>>> This RFC proposes a key type, "keycrypt", whose material user space c=
an
>>> use for symmetric operations but never read: AES-256-CBC, HMAC-SHA256=

>>> and an authenticated AES-256-GCM stream, through a file descriptor th=
at
>>> KEYCTL_CRYPT_OPEN returns for one key and one operation.
>>
>> I haven't looked at the API, but from a cryptographic perspective,
>> this encourages very poor practices.  AES-GCM even allows userspace
>> to extract the secret authentication key.
>>
>> AES-256-CBC isn't a suitable mode on its own, unless it's combined
>> with a MAC in encrypt-then-MAC.  Even then, it has a 2^64 birthday
>> bound, so it should only be used 2^48 times with a single key unless
>> the key is ephemeral.
>>
>> AES-GCM is not a suitable algorithm either.  If you allow encrypting
>> with a key loaded from persistent storage, there is no way for the API=

>> to ensure it is only used with a unique nonce.  Nonce reuse leaks the
>> authentication key and allows forgeries.  Using random nonces isn't
>> good enough either: NIST only allows 2^32 encryptions in this case,
>> and the API can't enforce that limit.
>>
>> For long-term keys, all of the following are much safer choices.
>> They have 192-bit nonces, which means that one can generate them
>> at random for each encryption without any problems.
>>
>> - XAES-256-GCM
>> - XChaCha20-Poly1305
>> - AEGIS-256
>>
>> AES-GCM-SIV is also okay, provided that you are fine with occasionally=

>> leaking if two plaintexts are equal.  This happens whenever there is
>> a nonce collision, so with probability 2^-32 after 2^32 encryptions.
>=20
> The exitential problem here is that KEYCTL_CRYPT_OPEN creates a circula=
r
> relationship between the keyrings API and a specific key type.
>=20
> At hardware level I did not see any support for TPM, which narrows down=

> the potential user base.
>=20
> The remaining potential user base is further reduced by those that use
> trusted keys; leaving out those who need to solve the assumed problem
> that only this patch set can presumebly sort out.
>=20
> And we don't really know at this point that cut. This is pretty much
> the break down of what is wrong here.
>=20
> If there is/was a problem to sort out, it should be so constrained that=

> it should be as quick to describe as stepping over a nail really.
>=20
> These are the main topics what I would focus on.

This whole patchset looks like a solution looking for a problem.

The usual solution to something like this is a userspace service
like ssh-agent.  Then you can do whatever key management you want.
That doesn't protect against root, but if someone can get root you
have bigger problems.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------B160UtrZAU3kNrK8qGCCzylk--

--------------0bx6vSKCAV0Mo03JVw607zhR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmr+RjoACgkQszaHOrMp
8lO5Iw/9HOFK9h3BHZwDlgyA+MXIYfSw1WE0cw6OUocFfslcMGtaJ8QUnc8FK7ej
JwNHAFrOQiY0Om8URIO+73PT7KKU3jUc0xHs4ZEbrZ+pUdwOaPSu8AIhc7QHrAbw
sqPqYIKJsbaoiuFGaZWZA/rBxBofCyx1kPZfLBVTtk6UochaiB5wNg7uPZsET7o+
qmrujw2kIGRuMREUtnBM2784dfVECk6kT4ukrFfKu6CYD+fANTEaVGFfasiOATFv
th2IpXIn9teh3KnD7bESgkgmKNo/3Ve0ltsrCnWa2JrwSrvacDjqtxIGQGZqAIe/
Ydt2QmrbrYfpOzACofLLmC3hEs3KL2fEFpfC2CfSYdABc71dYQZf4YsVtVXYwvVD
h6+AOlMBdAuD7HGnjyYRoLz+0ootP0+XmSYadYQbMBJX+T+6+Yc4Dk8fOMV5fp1o
GmaCI2gz3kd46+jOE7+NNUDb180/eth0DZo9A0/q1sbe6rLe5/mIWXdZ42tvvEzy
uysEfhp/DLGc1rkHiGTZeOEv5O74eGRqfK2ZpkRIXOitHt0k9W5xAIe4Wy1tsTfV
S1BrrJD+YEAZJP/3cRbbZvb3bV10NujrW1gJVMoP+vQt/AncJ1IIgkmL/WzK6tUo
QWTfj6w6ZSnX1UjV4yv0Svpyjy0CM53r4p/gZZow8N+5a4I/k3g=
=kuCZ
-----END PGP SIGNATURE-----

--------------0bx6vSKCAV0Mo03JVw607zhR--
