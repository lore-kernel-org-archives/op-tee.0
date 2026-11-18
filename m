Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353F606A31C
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=WxeeU/Gy
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 942B6503B3
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 14:43:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.a=rsa-sha256 header.s=a1 header.b=WxeeU/Gy;
	dkim-atps=neutral
Received: from smtpcmd11117.aruba.it (smtpcmd11117.aruba.it [62.149.156.117])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 17CC5434BB
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 14:08:43 +0000 (UTC)
Received: from polimar.tail4f75e6.ts.net ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id TgL3x51SR6VShTgL3xMvuh; Wed, 18 Nov 2026 15:08:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1795010922; bh=bQFBSzdwaul4KRf67gSRWGbR6PYoKg8o6esTEGD0jNs=;
	h=From:To:Subject:Date:MIME-Version;
	b=WxeeU/GyZZVGWKDWlav8NoEyVBhSiMpftt1sFyS7lgDkfZSf5ifjjw0YqP9kRK+6y
	 gTywOI89xxLSFQqQLdMLZ5cqFUc4foUfziVVYQRMp8dbitFGiI6FEfkygAHC2aByxv
	 XmjyDvWNxhZlHVVBpKN0XInRHNMvsFwcw0+6cX3am0X8dKjEaPsDYHGPvnTnoNgnOq
	 gaB30NXCODTiYQaZvBcWf5h/d3wBg2DgCcTuja93TWUw8rhN8sjQsCnFa4fK47HFvv
	 +fEZ6YWNW4oZXl1HHnC1EThzIW9P9QVSBnswY9meNS9+Oay5oj/jWSjySZa/Yn7Fa/
	 ICqksqW0C4KOQ==
From: Rodolfo Giometti <giometti@enneenne.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org
Subject: [RFC PATCH 5/9] MAINTAINERS: add KEYS-KEYCRYPT
Date: Wed, 18 Nov 2026 15:08:38 +0100
Message-ID: <20261118140838.606692-1-giometti@enneenne.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118140421.584086-1-giometti@enneenne.com>
References: <20261118140421.584086-1-giometti@enneenne.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKiEjT0uFTsYQNdRuokOTdmnkW3pULIFQvB3gvUGOb2nW6mxdjD+mMF9m5Re0nilbpCTtnbk8020gjP3W7f9zOh0nkfAeaXYYe3YEJxQiu6w1Obo1Ug2
 P9jbfhopFkA9HutyhsZaXJJKLRyx2boRdom2oOXmG9Au1qLbd4NVPVMIP+P37Mb5GP3mOcgKzg4HOg+ynv22TBQl8n1fs+wHCmV1I8znSOEoV/wkAdYPldWP
 82YijmBgZb2WjCvpwvA7n2a4KQhpD8JQNZMMntiwVfFdnckFS561VPndNgMCAbvgB1RawKGId065rbUAQ6CYN/8PDn+SIhWsv9nTL9gqDDcpjxxe/ZwHG4/u
 jPItmbgrxbA9jYbl1TsRPHrJW51lZJ+vgpYF7wemISH+J+Go3Ys5GcZ5PNj7I3aLwP9a5ajzKsUoNds/K+GqSYbd0sOx+RqsqD6lC69XHrGdQt0c+dJk/LqD
 O7AQAUIx8gjWFVPiZ+Vuq99BORNo/6JvqaXSreAIryZCm2Dk8lCtRnHAm7iJBOQTk9wQRkTag0xNkqBB2yOAYs4peIDHlzYicyUTtc3AmeNHm1Trc11tw1Jn
 42EeGjPQpc1HmteaLWvHe+L8aTr8b4w70p2+0aCVwko+flPJ/bFcJGsAVBSnQLzpbUZ3XCdhGPVPqGH4lOliQwRlrqn27Gj7ZRlrlbUdmbas5jRXiO1Mey/P
 J+qNj7JsVSmTEM54w7cwZTtT5C1JqEWsi7wBtAJLdcAAdYLwpxofHEbmCWFpY3vszYHU7MUkvuGXbAtp9YPDlDPJbFbCZqC5TU8PhY4JMJHdCgAM6bLt1HlB
 cWiJ5G634M0t3Epd0mvyznAUk+GAHQnZXAHTTUMa8o7qjzh2BplNHtzf5ddmSO6bIV9eoaNVbE37bQApYKq5rmCkQzffmUXXnSywmC76aRqYk3TZuCtW9rLf
 pcMfcjtps/7YSHZAK8rs8frBRrKvyaaC4APqkUMD4AencSJmafcAfQKkuJ6foxc9ZtAJd244MaeESe6dJdUN3i+W8uSGKExI3wRipOvW7Y485gAOr5ohkPHL
 qKYFc7Kipw67yGIrs85Ku/s66zKUUgIJ02NQZYXdqy0qi7tCIM/bdTYPW9EN+MpdwMulW/R6k50lbClv7Qs2qiMzckD3NH2CLcTs5R0+7OBGzS3waKS3rWS6
 zcs0GlKjLdQebbI3T7gulx7ubm0k45EvJKMM3f4JOodd9BwK2PTfO+1QJzogwF/l8yxiOSvD5yC7D8kMWlU14FtPUt41pNHPohz4qg1Lj3Qe958US/qjUHhb
 73Zzk0ssdMrlnK9Yjf3jLb+PM9sNE5DdCZlk6K52B9VwAPSwiSI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enneenne.com,none];
	ONCE_RECEIVED(0.20)[];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip4:62.149.156.0/24:c];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:31034, ipnet:62.149.128.0/19, country:IT];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[62.149.156.117:from];
	DNSWL_BLOCKED(0.00)[62.149.156.117:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_NONE(0.00)[aruba.it:dkim];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,lists.trustedfirmware.org,nxp.com,pengutronix.de,nod.at,gmail.com,arndb.de,paul-moore.com,namei.org,hallyn.com,lwn.net,linuxfoundation.org,infradead.org,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,enneenne.com];
	DKIM_TRACE(0.00)[aruba.it:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 17CC5434BB
X-Spamd-Bar: --
X-MailFrom: giometti@enneenne.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: DT5OB26GG4IMWLZLMWFHA5FXCLLOTSQX
X-Message-ID-Hash: DT5OB26GG4IMWLZLMWFHA5FXCLLOTSQX
X-Mailman-Approved-At: Wed, 18 Nov 2026 14:40:35 +0000
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Richard Weinberger <richard@nod.at>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Demi Marie Obenour <demiobenour@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.o
 rg, linux-kernel@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DT5OB26GG4IMWLZLMWFHA5FXCLLOTSQX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an entry for the keycrypt key type, its sw backend and its
documentation, and one for its OP-TEE backend, so that changes to the
backend also reach the OP-TEE list.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 MAINTAINERS | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..41dc8fe1fb36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14813,6 +14813,24 @@ F:	Documentation/security/keys/trusted-encrypted.rst
 F:	include/keys/encrypted-type.h
 F:	security/keys/encrypted-keys/
 
+KEYS-KEYCRYPT
+M:	Rodolfo Giometti <giometti@enneenne.com>
+L:	keyrings@vger.kernel.org
+L:	linux-crypto@vger.kernel.org
+L:	linux-integrity@vger.kernel.org
+S:	Maintained
+F:	Documentation/security/keys/keycrypt.rst
+F:	include/keys/keycrypt.h
+F:	include/uapi/linux/keycrypt.h
+F:	security/keys/keycrypt/
+
+KEYS-KEYCRYPT OP-TEE BACKEND
+M:	Rodolfo Giometti <giometti@enneenne.com>
+L:	keyrings@vger.kernel.org
+L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
+S:	Maintained
+F:	security/keys/keycrypt/optee*
+
 KEYS-TRUSTED
 M:	James Bottomley <James.Bottomley@HansenPartnership.com>
 M:	Jarkko Sakkinen <jarkko@kernel.org>
-- 
2.43.0

