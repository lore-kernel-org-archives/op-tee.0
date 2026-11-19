Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41939606A33A
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=PCSX754u;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkO9ZyBD
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A0B6D4553D
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795098792;
	bh=1sX2bVXVnl6WFgWIejYTd8iFIBqD/o8g20BGJlOIx/4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=PCSX754ufDCdF0aEP+DK940knvRijFiEjZpO0EFEvFfYlpvXiy7lgK2zOfkfIC8rz
	 IBdEXVN/uyRxRjz+DtV46zt2542jEk24/446eoPvICPHaCMpYsmajTnak/uoEt0ngU
	 QxG5WJKXRoWZrdyPxUtL+z4siKVTUPRHOaYcDwRLQMBnqdSWkKfizy2Nnp8as0dINf
	 53yBBfh2XVSxAvbGWQhn4SaEvF39A8tdVCmNMq7n1naiEgFh+rPLMapCrDLlyeA1kO
	 RE8eIqLkJv2q/qIjxTFdBGgyOLv83G/y+Gyvl766vTAN4tBJZ5d+QMUPmgFkgVjrBS
	 iNaOmnpjd/qXA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id A88D244ED4
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 14:33:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkO9ZyBD;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 0AF3260A6D;
	Thu, 19 Nov 2026 14:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3738E1F000CA;
	Thu, 19 Nov 2026 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795098786;
	bh=lv3NYu11pHprgRUUKX5nzbXJ9PYh0wkr94sy1z7rgm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DkO9ZyBD2TgaZMRcs8EgWiOCyNyqCS5GVpH0PIaxsiAxioBTNKOP1wNtv66D5cYUo
	 SVbW8UDU1ecj5E3RCQAhHUNANk3OefmNfhyVcaUvR0Gz4clykNB0Ug9GoG1Ptr8ZuJ
	 ONnfC20iTyqzzJ2bUJn6Pg6qw6zmZqZ3ZatVKnDFWAqwRPzMWGYReKxU4oRi50tS1Q
	 1qTF54aQpt4AAtXTH2qm2wUUGVJhq8ji6yCXpiUz4OvXBnHZfzrVs9GnUElmUD670e
	 vrz7s2wx6vlq7TxR3Li0W0SBs0mp7rRKPrBjNuC5IHgS3SdNuJjawMEJSGy/3xT0BT
	 6PR8vQwsFHWZw==
Date: Thu, 19 Nov 2026 16:33:03 +0200
To: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
Message-ID: <av8In0Xyd5iI9N7K@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av5EyVHnNzT27dyK@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.19 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.99)[99.95%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[enneenne.com,redhat.com,vger.kernel.org,gondor.apana.org.au,davemloft.net,kernel.org,lists.trustedfirmware.org,nxp.com,pengutronix.de,nod.at,arndb.de,paul-moore.com,namei.org,hallyn.com,lwn.net,linuxfoundation.org,infradead.org,lists.infradead.org,lists.ozlabs.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A88D244ED4
X-Spamd-Bar: -------
Message-ID-Hash: WH6KCDTZY2XUSYGBAIMMUBCYRUYITGVS
X-Message-ID-Hash: WH6KCDTZY2XUSYGBAIMMUBCYRUYITGVS
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Rodolfo Giometti <giometti@enneenne.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Richard Weinberger <richard@nod.at>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, linux-
 arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Demi Marie Obenour <demiobenour@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WH6KCDTZY2XUSYGBAIMMUBCYRUYITGVS/>
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

On Thu, Nov 19, 2026 at 02:37:33AM +0200, Jarkko Sakkinen wrote:
> The exitential problem here is that KEYCTL_CRYPT_OPEN creates a circular
> relationship between the keyrings API and a specific key type.
> 
> At hardware level I did not see any support for TPM, which narrows down
> the potential user base.
> 
> The remaining potential user base is further reduced by those that use
> trusted keys; leaving out those who need to solve the assumed problem
> that only this patch set can presumebly sort out.
> 
> And we don't really know at this point that cut. This is pretty much
> the break down of what is wrong here.
> 
> If there is/was a problem to sort out, it should be so constrained that
> it should be as quick to describe as stepping over a nail really.
> 
> These are the main topics what I would focus on.

I'm not disregarding that there might be something; and neither
disregarding e.g., the use of Claude. Throwing a dice can apply as well
human made code as for me code is just code. Perhaps using Claude,
people just tend to have just a itchier trigger finger :-)

The place where *in my personal opinion*  anyone who uses agents would
be better to do manual work is the commit message. It enforces to use
cognitive abilities even more so than writing code, if you with
absolutely no self-deception, read it all through and write with your
own words what the heck it does.

Usually when hitting the wall doing that leads into better code
because of the healthy reality check. I'm not a medical doctor but
I believe at least that thinking more stuff like this is also great
for long-term health and cognitive abilities.

AI is for mental health as a car is for physical health; for better or
worse.

Code quality is also over-rated although best effort should be done
but that's all. If you get it, then it is done. It's harder than it
sounds without self-deception part.

And yeah, we don't have projected problems. I.e. "no users" is always
NAK. You have to step on the nail at first.

Just need to clear my thoughts on overall the topic :-) This is I guess
where I stand now. Hope you find these helpful.

Br, Jarkko
