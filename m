Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91439606A320
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ELmzxNyE
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E1EE245526
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 07:39:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ELmzxNyE;
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 12DAE43264
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 23:42:41 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b4e04eda5aso14282827b3.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 15:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795045360; x=1795650160; darn=lists.trustedfirmware.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5gmN6H+RSfew5cKRkkzfR78AcJ/HC4QuJ1A3RJGQZBo=;
        b=ELmzxNyEt/Bt7HzzUqOoMMorugeNej+jKkgYfWk3gmNkdCHfN8ATJB2tBAN4TUp9rL
         cxuwTO3l+vTe2RU2xSTn32K9aa2wyZvPBV8zkSIRl65cgwFWstTYkpDY2uR5M9dv061f
         1FkwQf6eSrIgr8JAZB5ATp7Xp7lKVe+PwFIv73Q6uFal5FGRGC1TubxP0VNCEgCn7B1K
         OAXBna3NRfiqUJyfi40nSd2TT48k55qW1GK/A29s7xytRiumfcPMYM+flDKnwEGNkdS+
         CEa+dxCTLY7BucuWi9cw86Sc+LUwk5FQFWNhQ5hYZwQ9Ldikcy6tkLAPqwg+myXo7ffs
         knJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795045360; x=1795650160;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5gmN6H+RSfew5cKRkkzfR78AcJ/HC4QuJ1A3RJGQZBo=;
        b=byDH2gWKr8g8w8TQFQSuczGRi0iy6D4vcV02PJusvVTB0zhTuLXZgdZK+d6yoKq3UH
         8pX6Ewt172cUWqQ70QYLU3gzogC0ktHSF4Jq2QMZsIfQh08aTEbeqxS3mNI/ilmjtu/I
         1NEOuRHbumyleSpCpz8gU+M1nHxvQzCrjcPcMvYg73jTIN8R1Pz1FxHmvglpDN7bW+Ao
         V/AAgqngv29uhy24hrur1GBWKoDUdaS9Kdm7fxq8OpWzx8R5G+ICHbqQgIR88BMy9wu8
         at8g5bnN8qNRqipCi0SBPBT8YC7G5EIuXaDFtmbVCf6kQiJkScDXqQPKYZACTaYKNlLO
         qzYw==
X-Forwarded-Encrypted: i=1; AL+hErF+srUasH9uOh7EGyyymE0iutlbikNWux0WVix7VMQqYkcxx4ynSj0yWqkA77zCXFbcfTTp5+c=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9AUItiKxlOz0HSQAWQKVNyNh+kkjyi7OkYsfzmmwyhh8muV4b9
	eLyfRM3qzGJ9yxUmueNmirIVyuNpztcH764HHkVrrqhnm3ER5Lj372AL
X-Gm-Gg: AZFdTZcPoXuAhIxnJQybQnIJ4mzlAzZBk3M0nDYwtxJkFMEwOZfsGAr3uo5//T0xEME
	WRQpbeFKMbgE0Zi3kdFC0nJUAhpkKy5S/vekiTkI2hBDFXe0rbC9J3gBVGy38p9dOI/n8gW6EnN
	8yml24TTvQIhWFy/pvIJNXYiA4QfNUBMh4sbvSKKqdFSjFEfwyesFR0MYjQOg6sK0wGQ2Q9F6ym
	8rljgYogM9wo+68JuwBjZ2PrYJS7goMpq+6YpmGQxgzdZfSnZQmi15SAsEGRTLKjhPzLiber9PR
	mSNqWAVlMYkuWkmmoP0q4YvQYB817d1qHgnSmB9J4ZunBZiYU1z7ARy5mR5V6UmG3TO64mzZJtU
	WVUe8Si5vMcKT8rOhP8srjAzhbH6GR8pqUO20FEkMipf97ONw2ERylFwd7KE1jpUUzZfLahED7V
	gxfKHycnnqO/WcDFOE6yfr8nPqf6pR9OqZtD/iHjiy216wN3qA8dVzTmRf7Ne/kAMxMk2wSGny6
	6/r2sEgmii7JPSRebifro924iaH1hnl8jYxhDJBghQMEJbcRRfl2XML4+xSTAcmCDTmNh8SUJjd
	98rDQsRcMT5fqXyAStnnDz3nfgMky8rFJg==
X-Received: by 2002:a05:690c:306:b0:8b0:e479:6872 with SMTP id 00721157ae682-8b4fed09583mr22589027b3.17.1795045360439;
        Wed, 18 Nov 2026 15:42:40 -0800 (PST)
Received: from [10.138.10.6] ([149.102.242.31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fdf1d0desm25041597b3.1.2026.11.18.15.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 15:42:39 -0800 (PST)
Message-ID: <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
Date: Wed, 18 Nov 2026 18:42:15 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
To: Rodolfo Giometti <giometti@enneenne.com>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 keyrings@vger.kernel.org
References: <20261118140421.584086-1-giometti@enneenne.com>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20261118140421.584086-1-giometti@enneenne.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jzPPC6cqPSJxGVQJoosVKqnL"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.09 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	SIGNED_PGP(-2.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20260707];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.180:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.180:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 12DAE43264
X-Spamd-Bar: ------
X-MailFrom: demiobenour@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 5K5OEHPAQSV7EQDA7JFQZDG43DZOKKTH
X-Message-ID-Hash: 5K5OEHPAQSV7EQDA7JFQZDG43DZOKKTH
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:39:02 +0000
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Richard Weinberger <richard@nod.at>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5K5OEHPAQSV7EQDA7JFQZDG43DZOKKTH/>
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
--------------jzPPC6cqPSJxGVQJoosVKqnL
Content-Type: multipart/mixed; boundary="------------TfokhGkQ0eBXMCucH70BiVLN";
 protected-headers="v1"; hp="clear"
Message-ID: <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
Date: Wed, 18 Nov 2026 18:42:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
To: Rodolfo Giometti <giometti@enneenne.com>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 keyrings@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
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
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20261118140421.584086-1-giometti@enneenne.com>

--------------TfokhGkQ0eBXMCucH70BiVLN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/18/26 9:04 AM, Rodolfo Giometti wrote:
> This RFC proposes a key type, "keycrypt", whose material user space can=

> use for symmetric operations but never read: AES-256-CBC, HMAC-SHA256
> and an authenticated AES-256-GCM stream, through a file descriptor that=

> KEYCTL_CRYPT_OPEN returns for one key and one operation.

I haven't looked at the API, but from a cryptographic perspective,
this encourages very poor practices.  AES-GCM even allows userspace
to extract the secret authentication key.

AES-256-CBC isn't a suitable mode on its own, unless it's combined
with a MAC in encrypt-then-MAC.  Even then, it has a 2^64 birthday
bound, so it should only be used 2^48 times with a single key unless
the key is ephemeral.

AES-GCM is not a suitable algorithm either.  If you allow encrypting
with a key loaded from persistent storage, there is no way for the API
to ensure it is only used with a unique nonce.  Nonce reuse leaks the
authentication key and allows forgeries.  Using random nonces isn't
good enough either: NIST only allows 2^32 encryptions in this case,
and the API can't enforce that limit.

For long-term keys, all of the following are much safer choices.
They have 192-bit nonces, which means that one can generate them
at random for each encryption without any problems.

- XAES-256-GCM
- XChaCha20-Poly1305
- AEGIS-256

AES-GCM-SIV is also okay, provided that you are fine with occasionally
leaking if two plaintexts are equal.  This happens whenever there is
a nonce collision, so with probability 2^-32 after 2^32 encryptions.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------TfokhGkQ0eBXMCucH70BiVLN--

--------------jzPPC6cqPSJxGVQJoosVKqnL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmr+N+MACgkQszaHOrMp
8lNdbA/+LXcNkxhaSmkBIlfaAw6S95byA9OavCx3gDwybKkdpBRsqEMuUDmi6Krv
sUsDLaeMdH3ar/BHBgzdRhYzWSYylQxAXK5kyk9Dl+eyd7ytersCCZOWNqQEXZm8
J2LKr4uL8732Pdf9nju8nULZYGbZMMOruowXjBaVMXexkB1+6mlo5Nlg2GWQi+tq
Hq9ZznN68KGW4g+4Tf1yUAVTrCV1il7GWH5B2NmiYoE+X7gXBAm/SN6AZFOBdC8R
9RqyWBD49MqMMo2bJUtpO4GYBp5Nq/mj51QZMQft/SuzJIukGVOgBZjs4tYc6Rzw
aYoqSJs44bHE4zdSItWMBMDMrFE4QwSZT9B79wJDYMc1XYC8GTEcV+A63nqID8Pm
cGeJ75QYBrQPSOGE8Y6JeniPKwFOHc+ZapobcMEZIo/e84/XsTLt3/WLlm92W+AK
b1B+kFVPbKu7aAp59KPE/6woXt1nWraeSJ2yT6kJv7nVlDTgmVjROCYIWx1z7Zxb
w3CLI05Dru/vR3Kfrb1qIwcExSnqHikSICBFrlCtcJ2QIXAe7q97XMUOtrG/r/tV
PhAcmfxf24npXFn3RhkkaT+XxqY891rJUHLUDfu1p8Rs8+QA+wf9ti+I/Ow0zC1c
TQibXKQlhu/Pb1CwVlGfg5OG29hOQEplCyaVjnQK5oPaw9O5NEs=
=AtsF
-----END PGP SIGNATURE-----

--------------jzPPC6cqPSJxGVQJoosVKqnL--
