Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56323606A32C
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=v1XHUkjw;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik0wB+4P
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A95E945523
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795014476;
	bh=7Puxe22RqnE0w2T2L8dnLekQPzMSu8xVNdyOfGWZZ74=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=v1XHUkjwsAX9g9rV2pX0DCzIhlEYDATEyutl7HuXUfIsmU/OqBSHqOwYqk3+Q4eAl
	 v4RWUxC1LAOIj97yQ0y7OMOpTeh+KgFfTsjwpf+oQ9sAUbu3rns+SRSnT5n1AK0zQ7
	 PeRRDr+EOL94oiLefdoP+uFiffeRua5591TdXbj5WcCNdgWURGriJIbBaM8Adcxk5x
	 Aa5EgDevb5/hjw7JgOSldTmtaLVSN/fufPu6Z0QVS0jmBaaufx1juGWcbmF/dX3Bdy
	 hjEHJLsJlD2jTg5H1VoQc+/V4Nokn/ZXxPe/MOIrPDDmxQwjlIJJQvwyW/FjMQXqXN
	 nU50nfL98J5Mw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id 53A2343AD0
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 15:07:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik0wB+4P;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 8E70743DC3;
	Wed, 18 Nov 2026 15:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C01C41F000C4;
	Wed, 18 Nov 2026 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795014471;
	bh=WpNvKlvQgWs4nlBDzrAzqY0K1wpz+T9bN3CMOunjYys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ik0wB+4PWOYL2hmQiNwFTeBBvupZ2nUcJiZ54iyfaa2tU77mnLlpFifyj8n1RAoxc
	 JiFr1whbKGn9jctVHgQHsWlXlRxqGaOAejYgryvppYJ1hYUJPmJajsbl1RZNJZ2urH
	 fAR3taWBeKxDwuMnnlsPRwbWW5GR06M9hA5dv1M1pEA51yEPNLWXKWfBsoGOA85JWU
	 RdSwiNfRnISgDS/zRQ8IFyTjSctGJRDAEhTnp4ENDN8HwGtDmIypnNR9Lro8os8drC
	 gH5m26+2mcTSgygYysYIO2BPjm0gAz6kctoO3OxBWgeB2Wg89nS8C+lhRUQ+5galCW
	 RrUE6ZrvqIprA==
Date: Wed, 18 Nov 2026 17:07:46 +0200
To: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
Message-ID: <av2_QoJHp1gMTFMp@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <mvyqqjhvfka3kkumztixzozrthutkq6mfakkonxqbpm5gvzb62@eitzzleeyioe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvyqqjhvfka3kkumztixzozrthutkq6mfakkonxqbpm5gvzb62@eitzzleeyioe>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.78 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.68)[98.58%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[172.234.252.31:from];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[34];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[enneenne.com,redhat.com,vger.kernel.org,gondor.apana.org.au,davemloft.net,kernel.org,lists.trustedfirmware.org,nxp.com,pengutronix.de,nod.at,gmail.com,arndb.de,paul-moore.com,namei.org,hallyn.com,lwn.net,linuxfoundation.org,infradead.org,lists.infradead.org,lists.ozlabs.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 53A2343AD0
X-Spamd-Bar: -------
Message-ID-Hash: NXCWKSWXECC3J7XDV4TT774ARD5BBJBH
X-Message-ID-Hash: NXCWKSWXECC3J7XDV4TT774ARD5BBJBH
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Rodolfo Giometti <giometti@enneenne.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Richard Weinberger <richard@nod.at>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Demi Marie Obenour <demiobenour@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.k
 ernel.org, linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NXCWKSWXECC3J7XDV4TT774ARD5BBJBH/>
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

On Wed, Nov 18, 2026 at 03:57:27PM +0100, Marco Felsch wrote:
> These are basically the trusted-key purpose.

This is it.

If I was adding something like this, I would at least:

1. Discuss the solution that would extend trusted keys to the level
   that makes it crystal clear that this is won't work out too
   well.
2. Then show how the new thing addresses all of this.

If there is any gist this should not require whole a lot of text
dump.

AI assistance should not be really even mentioned the cover letters in
my opinion. It's equal to text editor; or smoke signals. It does not
level down anything i.e., I'm equally dissatified however this was
produced :-) 

Br, Jarkko
