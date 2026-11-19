Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A721606A32A
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=iMCz4c4v
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 83BF845B7E
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 08:35:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=iMCz4c4v;
	dkim-atps=neutral
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7DD624440B
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 18:33:25 +0000 (UTC)
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id U6wix2IW175O9U6wix0Oma; Thu, 19 Nov 2026 19:33:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1795113203; bh=2t8AtcRowxFNGYE8HteZpHIn9jAWUm8DVCWA8vMMYBE=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=iMCz4c4vXgNfjaVsNwvBuMF7tZY4Yy54lPGmuAGKY6P71MLCV/srwMTceBQ/GAt34
	 IwJr1uqnf/dmNjlMZQB9cLgUTxbIw6iVRuT9buaKQVDbz3kaNVFEIoEpXvAkCgmyEI
	 PSFVCiHj3v8SvBzh912x32zMoFnRUAiLuKuPzH9wjTX7qSHSKg+cusdAEfdyhakn6U
	 MDZ+sXbJbEnEXvAx8A/4DselQVxkwI8uuu0bk6VUSPoq8UUhqONY29s9ATTEIL13dy
	 Cw/3hrysPCKNiLyF9KsJstL/jDdfxcyJ3j39BP5mlGiBGtXHINn2jlUD38UGg+FRMw
	 xxp9/W63RlIFw==
Message-ID: <4ad95ed5-26b6-4871-bcb6-cfebfe73917a@enneenne.com>
Date: Thu, 19 Nov 2026 19:33:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] KEYS: keycrypt: keys that user space can use but
 never read
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <650f89ef-9745-4f75-b254-80fa5ac4773d@gmail.com>
 <av5EyVHnNzT27dyK@kernel.org> <av8In0Xyd5iI9N7K@kernel.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <av8In0Xyd5iI9N7K@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDXtWOlFTYpyTg35cFi8NKxn6M8tXvqRpaK6Te9d9LP538qpRWPqyhYCRUO7FN90zeUALjH4Pv0kc5qTXvx9JqFIICyIFmy8AMREg/ZL7rPvrVR8BOUd
 cLloYWy2etZ8Iz2Dj35VuyDIDq5OJcXlqCU0GxFuELT2Ll0+SMmq0xT0b1NQ/mGJ1DRr6EgGHmwb1jcrz7jDiFyXggFkpjEOVUfCxm33Z+AP0WZg8zgrFJ0n
 ffHu26kwKFVQdawAYFWmaAXnHN1p0WPTc2eQub+iUcKYdh/LB+1TMtCynW4g+PFuL/Ox/uZYSQ3twHUYmoc0NljKoPOQdr9z82B634PV+Tl5rFaczqEJswvL
 RMT75ziH1aZFGiT3YGWODPXE3kKUfWeYw2ky9PgD86fbcUKc9YG7O6O4C555MM8R18YgP7zwMiMpC0MPLWUV4TYOFHuGzRI3nAMUWf2OAvcXsYsO9EJVC1dZ
 /CJBXkFCk64KKzxL3y8DwpvUb58jZOH5wiXqHdVhVBx7moWR2O7fcnAGvb0ROFigOOWFyNifYgQAUKvRx0Gjo0aKANKYhIDOo9FoNc3nTrLMB+wllSvU908i
 ZvkuwtX35joO+/L82trX60+HcodZHev58cbR0wIdppW64faoXjrD2ty6e3+iNo1wzj4r1WV6hSakPGcj+ITxJAyi+jIfJwOIVZnMMjwKHWWd276ZqiyPHgzR
 tHcGBXPnD0+Y4FdwbDCkcDNcPihbMtNcarY0ckxuc2T0QuwtA6V5JI+qd+13NzNwBNaSBd9q0vR4Houfn0O1tVDSLHjYJhYnCW1hfd8zibQ4R4JUQeDCsiso
 hDRhfUPbEdA73rTyHioYeBE2HST4BYaYzwzPHgFSowkALmKiOo3P6Y+sT2OdjUa1mi5YmmKKNIRc5pqRvd/Poq1X6e5PtLi+bMEeLu/tD0VuL3zYOGxE+sHW
 BTqxG0WyQtxpY++s7NY1cpcH0qqhtrXP08lJaeDotFcKwlEQgSTkroRSzbXG9NMpu/BmvKQiIhI/dqa4MxRp7JEEFN/QNVR7WEj2UU0vqJswExy2aYWzzdw+
 FkBYKTSapeFo97Im9jOUDeTGL1gcFhA/aHSIiD07c4PP/74NLMye+4RTaOnZlsrMaXjbB2/jn6s9k9AKtJfRSJPMFnBj3YyvI3YYi+xduehbptXY4hxkqo3D
 c5x2hRhHNjhs0zg+GpmJGknXwvGaK4l4a6zTOKWmfv7xMtgIZ/Vn9d4GsOJdkemp7e3WX6RGITrcgwSghHENodqP2MvCkuvhyBHE4/kY7pUMNCMYz3xNrYgX
 6PdBjdKe
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.78 / 15.00];
	BAYES_HAM(-2.98)[99.91%];
	DMARC_POLICY_ALLOW(-0.50)[enneenne.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:62.149.156.0/24];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	ONCE_RECEIVED(0.20)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:31034, ipnet:62.149.128.0/19, country:IT];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[62.149.156.176:from];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gondor.apana.org.au,davemloft.net,kernel.org,lists.trustedfirmware.org,nxp.com,pengutronix.de,nod.at,arndb.de,paul-moore.com,namei.org,hallyn.com,lwn.net,linuxfoundation.org,infradead.org,lists.infradead.org,lists.ozlabs.org,gmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[62.149.156.176:from];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[aruba.it:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[aruba.it:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7DD624440B
X-Spamd-Bar: ---
X-MailFrom: giometti@enneenne.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: N2KUVK5JMNAHHBR2SR7W7TUNTLCZTMTN
X-Message-ID-Hash: N2KUVK5JMNAHHBR2SR7W7TUNTLCZTMTN
X-Mailman-Approved-At: Fri, 20 Nov 2026 08:35:26 +0000
CC: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Richard Weinberger <richard@nod.at>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-d
 ev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Demi Marie Obenour <demiobenour@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/N2KUVK5JMNAHHBR2SR7W7TUNTLCZTMTN/>
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

On 19/11/2026 15:33, Jarkko Sakkinen wrote:

[snip]

> And yeah, we don't have projected problems. I.e. "no users" is always
> NAK. You have to step on the nail at first.

A customer of mine stepped on it. Their product, on i.MX6, encrypts its
rootfs with dm-crypt and a CAAM black key, never in clear. Its backups,
though, are encrypted in user space with a key kept as a CAAM blob; to
use it, the blob is opened and the key handed to user space in clear.

The next generation is on i.MX93, and the customer now wants the
backups and other encrypted archives protected like the rootfs: the key
must never be in clear outside a secure world. The i.MX93 has no CAAM.
OP-TEE can hold the key, but every way the mainline keyring offers to
use it (a trusted key, through dm-crypt or AF_ALG) unseals its bytes
into kernel memory, and AF_ALG no longer reaches hardware drivers.
keycrypt's OP-TEE backend does not unseal it: a key it generates leaves
the TA only sealed.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming
