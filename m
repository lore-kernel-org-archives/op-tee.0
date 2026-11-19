Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335BB606A334
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=j3EplCKo;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQv06nro
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 874064551F
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 01:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795050074;
	bh=mjG1lmnCS4E7pNYjr99kQxRDtikm4GdrXg8ajC/hHfM=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=j3EplCKodGa6wwIUP2zKAhbvrX9EyQbUlbYs9e/rQZ1rgRlwPbe4R5W+Pw481Oa2Z
	 4bue2wihwUr5ytNK8pDzh31UCdx82iLpCMvpBzqTB6xNL753m5SGiPPmcNSk20ocBU
	 +YFNowyxn4Gbl2h4+UgwKRbPBSDhY7qY9ONvaM295rf+kLOG2h2AX4M9Y3fbnkr/zj
	 dUUltpzlH3Y1PIdr6BrmFeKmw7eYwH2IEjJtgRxXH5tMJPkZamANERtmO1lY1NZ2P/
	 3LCekG9aycDN/Uk1vujEKOlHINvFiQozFNiXwxcKoRI2XkkX27zEHY+anX+6OnR1o3
	 xkDMwJ4NMs5KQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id A4A2244F1D
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 01:01:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQv06nro;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id E578843726;
	Thu, 19 Nov 2026 01:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3E62E1F000C4;
	Thu, 19 Nov 2026 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795050068;
	bh=49NXjUTbzL4+xbJpcXKoJd4omTTJA3SheYrgPCgGq84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IQv06nrofbIqNARVVWh9JrAgHaEyRWKOud9QvOcchO4KY4ScIzXSqs80rNJ/ht3b1
	 Tsu7VMYrIh/2Fi+hRTl7qSSsKz4S7jM8ebpPVfo17lwtEFZMdAvwfZsxatV/ZsWAUp
	 PJgwsXqU+KqK3LvIcvOGucx9P9jANzCFHIamLnf4sC5rVp+bvnrP0sCUChwGa++Hwx
	 a7awEoAOqry4Xom2vSVycaB2NRS9vG06yCTtwmMYjMTvqtDoBc6hHSkU5Dk5pOb1Ih
	 GIaqltmVlM6m491tKp84gsZmgrtTNr8xvyupIzrYmeeJ//m5Bn5hJKwuAsDqwP+LxE
	 +hNKrozwFIXmA==
Date: Thu, 19 Nov 2026 03:01:05 +0200
To: Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
Message-ID: <av5KUakRYdiaondn@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org>
 <61ca7c37-7b42-48a3-be2e-95deb4d999a2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ca7c37-7b42-48a3-be2e-95deb4d999a2@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[172.234.252.31:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_TO(0.00)[gmail.com];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A4A2244F1D
X-Spamd-Bar: -------
Message-ID-Hash: IPQDCHOUZ4UP2Z23QUOWASNFIFROFGIX
X-Message-ID-Hash: IPQDCHOUZ4UP2Z23QUOWASNFIFROFGIX
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Rodolfo Giometti <giometti@enneenne.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Richard Weinberger <richard@nod.at>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, linux-
 arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IPQDCHOUZ4UP2Z23QUOWASNFIFROFGIX/>
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

On Wed, Nov 18, 2026 at 07:43:37PM -0500, Demi Marie Obenour wrote:
> On 11/18/26 7:37 PM, Jarkko Sakkinen wrote:
> > On Wed, Nov 18, 2026 at 06:42:15PM -0500, Demi Marie Obenour wrote:
> >> On 11/18/26 9:04 AM, Rodolfo Giometti wrote:
> >>> This RFC proposes a key type, "keycrypt", whose material user space can
> >>> use for symmetric operations but never read: AES-256-CBC, HMAC-SHA256
> >>> and an authenticated AES-256-GCM stream, through a file descriptor that
> >>> KEYCTL_CRYPT_OPEN returns for one key and one operation.
> >>
> >> I haven't looked at the API, but from a cryptographic perspective,
> >> this encourages very poor practices.  AES-GCM even allows userspace
> >> to extract the secret authentication key.
> >>
> >> AES-256-CBC isn't a suitable mode on its own, unless it's combined
> >> with a MAC in encrypt-then-MAC.  Even then, it has a 2^64 birthday
> >> bound, so it should only be used 2^48 times with a single key unless
> >> the key is ephemeral.
> >>
> >> AES-GCM is not a suitable algorithm either.  If you allow encrypting
> >> with a key loaded from persistent storage, there is no way for the API
> >> to ensure it is only used with a unique nonce.  Nonce reuse leaks the
> >> authentication key and allows forgeries.  Using random nonces isn't
> >> good enough either: NIST only allows 2^32 encryptions in this case,
> >> and the API can't enforce that limit.
> >>
> >> For long-term keys, all of the following are much safer choices.
> >> They have 192-bit nonces, which means that one can generate them
> >> at random for each encryption without any problems.
> >>
> >> - XAES-256-GCM
> >> - XChaCha20-Poly1305
> >> - AEGIS-256
> >>
> >> AES-GCM-SIV is also okay, provided that you are fine with occasionally
> >> leaking if two plaintexts are equal.  This happens whenever there is
> >> a nonce collision, so with probability 2^-32 after 2^32 encryptions.
> > 
> > The exitential problem here is that KEYCTL_CRYPT_OPEN creates a circular
> > relationship between the keyrings API and a specific key type.
> > 
> > At hardware level I did not see any support for TPM, which narrows down
> > the potential user base.
> > 
> > The remaining potential user base is further reduced by those that use
> > trusted keys; leaving out those who need to solve the assumed problem
> > that only this patch set can presumebly sort out.
> > 
> > And we don't really know at this point that cut. This is pretty much
> > the break down of what is wrong here.
> > 
> > If there is/was a problem to sort out, it should be so constrained that
> > it should be as quick to describe as stepping over a nail really.
> > 
> > These are the main topics what I would focus on.
> 
> This whole patchset looks like a solution looking for a problem.
> 
> The usual solution to something like this is a userspace service
> like ssh-agent.  Then you can do whatever key management you want.
> That doesn't protect against root, but if someone can get root you
> have bigger problems.

This is true. Even if the code was like it is BUT it had a clear
motivation, I would likely suggest to the author how to resolve the
problem more properly.

I.e. bar is not too high in initial code quality but it is steep
from the get go in the "utility value".

> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)


Br, Jarkko
