Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0F606A325
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=CycFhd9A
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9F9A65032C
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 14:19:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=CycFhd9A;
	dkim-atps=neutral
Received: from smtpcmd11116.aruba.it (smtpcmd11116.aruba.it [62.149.156.116])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EB2CA4529F
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 12:17:32 +0000 (UTC)
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id U14zxDwan6VShU14zxRiua; Thu, 19 Nov 2026 13:17:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1795090651; bh=V3OZh4icVrzbMI2k6cXTPEjlLw6DW6zRycuz+4CAfec=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=CycFhd9A1catDJK8mSVVnIjyH5ROQd1v+wC5+drY99wllUzOcvv0JnbleYae1QyWl
	 BfXvel5+GlGK/smjYdZVOsE8ifTJ+aNn92e3/PHwymqXJ9vopCmtPNtiJdDDxgFhXQ
	 gH0O5LL0GqGBMM5zzAqHd0YcDoUE/TebWvQKcOdv9bAt/QbHhwHYpgUqx3x1h4Ldgp
	 75NfGZPT+sNKTTrA02giDUkiO0gk016/Jf4H4Ha37Gpw+3d0e3MxEHOw+7cjazCAy7
	 12PcNhVzIViATgQFKluA/RK3kpXudgDDYCPNifgplaPxzA8PVajw1Iru4DOG02ulfO
	 Vnl/JByjL9DVw==
Message-ID: <10d27c34-72d7-4380-abc9-6f8eddc6c08c@enneenne.com>
Date: Thu, 19 Nov 2026 13:17:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
Content-Language: en-US
To: Demi Marie Obenour <demiobenour@gmail.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org>
 <61ca7c37-7b42-48a3-be2e-95deb4d999a2@gmail.com>
 <01692969-8e92-4a08-bde9-aad86674504f@gmail.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <01692969-8e92-4a08-bde9-aad86674504f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKBPrYJ2CDN4f71Kap/ixDsQG8LCW21ix5G/r+qduPuGoKFzPku3ui/3D6NrDy/I4fLjS/AZ5x4bSLPCyVIF0to5TjSclhUTdSU4uon2/XK98GioKEpu
 t0DAXGgZowfR8EBdb4xlQI1aOmtiyouqFm6ozJqENawyIYsyVwWUPVtIrxKIMh6tgg2DcE0bNvKSfTxI4E/KX6og6HQ36T9SsUF5L6ywvP0CPLLtoj3XfOJK
 KK6OL4sQiUzIGXyKYC/g5t6eDL7TGBKZYqtynb/EnlVDCDMoH+BMpug/FQzubq89PMXLKw1FzF7r79429pnKXBHAlDBdAGSZfIFNS5uHsw8Ky4Ryb//LMK9V
 xLfwyhC5KBHWow0xsn0MR7mF6xbrK8rHOP6EY/6N+7N/mkYzZW0dxG31VP79/qgd0FE+u/f6bwMdsGglkPiv7Y+X/kQhNQovCMTLqK/xd4/A1//iDD4ibkuq
 1/kQFk3iW8okXGDrlVnZ6UkHWDYJU0H4V33JM+dA1KrG1s5yxelszfrfDGYXDXRvM9MRXG2C0JJFVnXDW1DBfX7oruz0XIMBt6ZuUqYpwYoCJYgDT8/Y94gB
 RtndS527vikEPvkczW3D2qQoIsrt4+TG4WSJC3lfoPhIyloLUzoc3clohznlcZ5d41rbBCRbfQ1vSp4l+bVmTsLWseSQTZKxyCBx5FWky+xTaEm69CxDc2nW
 HxMYdlYxr4DwnIfL+x2fqCJ5RbC7gBciMQd6ihsH1iadIXHfBcS4KhXDviVzexL7jL7TLPHnlpjTAhT/rODrCAAiT5G8Le0zqKlXI3LhP81Ke0+765dQ0e9y
 vgu5MhNb82zl8mX48OJ9rhfGTJKQP6C/S1uHuzQOV8VuqFJx7jL006rc7ZGJIcc4/bSi4OzRvFhFOgNVnMJP+jAWIUvBJtJS4o9aDPfIoaC0wUPeec7ltUUx
 3YAptj8Js+/LJy8wIk8KSIHNu1+DIrXnbtSxZ48rdWX3ylBXpUU2OdzVbAPjylucDm+hVHDEnZGmwM4stN3z19Ce9cCXkLIDcyAWyz9J1zqQ0O2bu0XmE7hv
 9+HAxJgOrvm6fyiIZnDN/P7bOyh6SKydeOvoEul+E155hehVkqO41wFNa7awsiPXufzyRwo7sKbPtMCbyJ4P/mnlwQSbOC29VJQeoCboPfyks3hw+p1gJkwG
 UStDxD9YrJOkVXUS048vbJ5rbuI5vxFjkO5bxo7Dsgk2WyJjnWav55v2ahPGzLX0t+XZEaY1n4iDLxnooNN/H35sYauqbDVs3RMMPG938OJL4wUKNVf/6fDh
 Y3+0UYag
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[enneenne.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:62.149.156.0/24];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	ONCE_RECEIVED(0.20)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	ASN(0.00)[asn:31034, ipnet:62.149.128.0/19, country:IT];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_IN_DNSWL_NONE(0.00)[62.149.156.116:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[62.149.156.116:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_NONE(0.00)[aruba.it:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[aruba.it:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EB2CA4529F
X-Spamd-Bar: ---
X-MailFrom: giometti@enneenne.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: WRPJA2HXWKLK22LGEGWOPVXY3ID7LINL
X-Message-ID-Hash: WRPJA2HXWKLK22LGEGWOPVXY3ID7LINL
X-Mailman-Approved-At: Thu, 19 Nov 2026 14:18:35 +0000
CC: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Richard Weinberger <richard@nod.at>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-d
 ev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WRPJA2HXWKLK22LGEGWOPVXY3ID7LINL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/11/2026 05:35, Demi Marie Obenour wrote:
> On 11/18/26 7:43 PM, Demi Marie Obenour wrote:
>> On 11/18/26 7:37 PM, Jarkko Sakkinen wrote:
>>> On Wed, Nov 18, 2026 at 06:42:15PM -0500, Demi Marie Obenour wrote:
>>>> AES-256-CBC isn't a suitable mode on its own, unless it's combined
>>>> with a MAC in encrypt-then-MAC.  Even then, it has a 2^64 birthday
>>>> bound, so it should only be used 2^48 times with a single key unless
>>>> the key is ephemeral.

CBC is there for existing formats (craf writes files that openssl enc
can read) and because the CAAM path is CBC only. I take your points
on it.

>>>> AES-GCM is not a suitable algorithm either.  If you allow encrypting
>>>> with a key loaded from persistent storage, there is no way for the API
>>>> to ensure it is only used with a unique nonce.  Nonce reuse leaks the
>>>> authentication key and allows forgeries.  Using random nonces isn't
>>>> good enough either: NIST only allows 2^32 encryptions in this case,
>>>> and the API can't enforce that limit.

You are right that a construction of our own is the wrong choice:
patch 9, the only GCM in the series, has no user yet and can go.

[snip]

>> The usual solution to something like this is a userspace service
>> like ssh-agent.  Then you can do whatever key management you want.
>> That doesn't protect against root, but if someone can get root you
>> have bigger problems.

The threat here is root, on devices where root eventually falls: a
key root can copy decrypts that device's data offline and forever. A
service that holds the key in its memory gives that away. keycrypt
with the OP-TEE backend does not: the TA keeps the key and checks the
purpose sealed with it at every use, so even a compromised kernel can
only use it on that device, and only for that purpose.

> Also, if you need keys stored in hardware for some reason (compliance,
> time-limited exfiltration), you can use a userspace library or
> daemon that abstracts over whatever the hardware-specific API is.

Yes, that is the case I mean, and a daemon over a TEE would not give
the key away either. What it costs here is, for OP-TEE's PKCS#11 TA,
secure storage before the root filesystem exists; for the CAAM, the
only user-space path is AF_ALG cbc(paes), the one off-CPU exception
left in an interface the kernel documents as deprecated, privileged by
default, with a key format per driver and no purpose.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming
