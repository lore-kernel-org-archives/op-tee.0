Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59E606A33D
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=wl87mW+u;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSxT9huh
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EF9254553D
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795049724;
	bh=0ZCA5bijEA3H3+ucMKVL9QMFueOHMZURjFphKbbU1MI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=wl87mW+uduL8DHhJbA207RM61PKWz6l9xUd2N9HqEbpRz01uFjsW5Ht5vokcpdXMS
	 RKge2bARc0jLeh2m3zZffCc90PvjJjkqFO3d7BY5JuB5Wb7dz3p+VLKxkHmS4b6wCG
	 Tz4GjoFdX8aekhLhiEuiKaM8+XwskMAez78i33sM8adrePYx37TalAUv9eve+Hs/nZ
	 /cVkQ4kQWi3SymkNaKtdPUb9iU/4Dqw0V9ohioPD+o0qXy+lVegZepqkiI39EEIy4J
	 vq7oeRa51R2Hu95chZdsDyvjIkWTMln2X3CzI/0CljE1cghb89HSE8GYuOhEFT41//
	 q7bSppMtDIasg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id DCA8543A65
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 00:55:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSxT9huh;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 48042642B3;
	Thu, 19 Nov 2026 00:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6BD871F000C6;
	Thu, 19 Nov 2026 00:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795049718;
	bh=25HxFNVSbdwyEfeQT/v/hb2lKg9U17dcPsjF33ZXCwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VSxT9huhMwIVOvdxA1oFUsA4Z3PU2/6QKN1JtOI9ZSJErZpgzNWfQOcPlKak7TIE4
	 tm+0xSyBkBRfpn8XMWTzqp6KgUlDMmSl0HEHE90q5hwkySZIy9ns74+aW5YDlu9QwV
	 vwcxJUfaAxhlXZj0yYWSuZ8ZbfS2AK6rkE6AUIW0ogLTDSl9WRU2XQN9k6nL4Fy8mv
	 C4L9LtEdTSU97TB4VEGpS/gI+hAGPUHp3DtgSFei2y7DITtIFMXh2ymqvxfleCFenG
	 HZgKoVAwIiKWIq+u3tkkkmJxz6F1QUKEAxNhZ+GdXSpvRLONSfa7LYlJ4B0KvBgLyc
	 SaJhYffuT9SzQ==
Date: Thu, 19 Nov 2026 02:55:14 +0200
To: Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [RFC PATCH 9/9] KEYS: keycrypt: Add the aes256-gcm-stream
 algorithm
Message-ID: <av5I8lhExyKvf9w_@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118141257.627441-1-giometti@enneenne.com>
 <75946579-8335-4491-86da-fcda25ae9fd8@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75946579-8335-4491-86da-fcda25ae9fd8@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.43 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.73)[98.82%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DCA8543A65
X-Spamd-Bar: --------
Message-ID-Hash: HE3ILD7RBGPIBJFUZDW577INH64RA2RE
X-Message-ID-Hash: HE3ILD7RBGPIBJFUZDW577INH64RA2RE
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Rodolfo Giometti <giometti@enneenne.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Richard Weinberger <richard@nod.at>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, linux-
 arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HE3ILD7RBGPIBJFUZDW577INH64RA2RE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 07:25:09PM -0500, Demi Marie Obenour wrote:
> On 11/18/26 9:12 AM, Rodolfo Giometti wrote:
> > This patch is a proposal on its own: nothing before it needs it, so it
> > can be discussed, or left out, apart from the rest.

If there is no one who needs this, this is literally throwing a dice
with Claude.

> > 
> > aes256-cbc does not authenticate what it decrypts, and a file or a
> > transfer longer than one call cannot be sealed with a single AES-GCM
> > invocation without buffering all of it, nor decrypted without
> > releasing plaintext before its tag is checked.
> > 
> > Add aes256-gcm-stream: the STREAM construction (Hoang, Reyhanitabar,
> > Rogaway, Vizar) over AES-256-GCM. A message is split into segments
> > of up to 64 KiB, each sealed with its own tag under a subkey derived
> > with HKDF-SHA256 from the key and a 16-byte salt drawn at
> > KEYCTL_CRYPT_OPEN; the nonce carries the segment's position and a
> > last-segment flag, and the counter lives in the kernel, so segments
> > can be neither reordered nor dropped from the end unnoticed. The
> > segments go through a new ioctl, KEYCRYPT_IOC_SEGMENT, and
> > KEYCRYPT_IOC_FINAL reports a stream whose last segment never came.
> > A tee or hsm backend draws the salt and keeps the counter in its
> > secure side; the sw and optee backends implement it.
> 
> Please use Cobblestone-128 or Cobblestone-256 instead.
> https://c2sp.org/chunked-encryption has the spec, and you can check
> against the implementation in pyca/cryptography or (for Cobblestone-128)
> the Go package filippo.io/cobblestone.  This assumes your CPU has AES
> and GCM instructions; if not, you should see about using one that does
> or work with a cryptographer to standardize an alternative that doesn't
> need them.
> 
> Nonstandard constructions like this one are to be avoided.

The wider problem in crypto without a use case there is nothing
to protect.

> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)


Br, Jarkko
